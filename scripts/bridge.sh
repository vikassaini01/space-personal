#!/bin/bash

# Setup bridge on CentOS
if [ "$OS" == "centos" ]
  then
    # Create virbr0 file
touch /etc/sysconfig/network-scripts/ifcfg-virbr0
# Config virbr0

if [ -f "/etc/sysconfig/network-scripts/ifcfg-eth0" ]
then
ip=$(grep IPADDR= /etc/sysconfig/network-scripts/ifcfg-eth0)
netmask=$(grep NETMASK= /etc/sysconfig/network-scripts/ifcfg-eth0)
gw=$(grep GATEWAY= /etc/sysconfig/network-scripts/ifcfg-eth0)
echo "DEVICE=virbr0" > /etc/sysconfig/network-scripts/ifcfg-virbr0
echo "TYPE=Bridge" >> /etc/sysconfig/network-scripts/ifcfg-virbr0
echo "BOOTPROTO=static" >> /etc/sysconfig/network-scripts/ifcfg-virbr0
echo "$ip" >> /etc/sysconfig/network-scripts/ifcfg-virbr0
echo "$netmask" >> /etc/sysconfig/network-scripts/ifcfg-virbr0
echo "$gw" >> /etc/sysconfig/network-scripts/ifcfg-virbr0
echo "DNS1=8.8.8.8" >> /etc/sysconfig/network-scripts/ifcfg-virbr0
echo "DNS2=208.67.222.222" >> /etc/sysconfig/network-scripts/ifcfg-virbr0
echo "ONBOOT=yes" >> /etc/sysconfig/network-scripts/ifcfg-virbr0
echo "$ip added to virbr0 interface"
else
echo "file /etc/sysconfig/network-scripts/ifcfg-eth0 does not exist. "
fi

if [ -f "/etc/sysconfig/network-scripts/ifcfg-virbr0" ]
then
echo "DEVICE=eth0" > /etc/sysconfig/network-scripts/ifcfg-eth0
echo "IPV6INIT=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo "IPV6_AUTOCONF=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo "ONBOOT=yes" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo "BRIDGE=virbr0" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo "eth0 interface for bridge virbr0 added."
else
echo "bridge file /etc/sysconfig/network-scripts/ifcfg-virbr0 does not exist. "
fi

# Restart Network
service network restart
fi
