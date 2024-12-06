git clone https://gitlab.com/nvidia/container-images/driver
cd driver
cp -r ubuntu22.04 ubuntu22.04-azure
cd ubuntu22.04-azure
cd drivers
wget "https://download.microsoft.com/download/7/e/c/7ec792c9-3654-4f78-b1a0-41a48e10ca6d/NVIDIA-Linux-x86_64-550.127.05-grid-azure.run"
mv NVIDIA-Linux-x86_64-550.127.05-grid-azure.run NVIDIA-Linux-x86_64-550.127.05.run
chmod +x NVIDIA-Linux-x86_64-550.127.05.run
cd ..
sed -i 's%/tmp/install.sh download_installer%echo "Skipping Driver Download"%g' Dockerfile
sed 's%sh NVIDIA-Linux-$DRIVER_ARCH-$DRIVER_VERSION.run -x%sh NVIDIA-Linux-$DRIVER_ARCH-$DRIVER_VERSION.run -x \&\& mv NVIDIA-Linux-$DRIVER_ARCH-$DRIVER_VERSION-grid-azure NVIDIA-Linux-$DRIVER_ARCH-$DRIVER_VERSION%g' nvidia-driver -i
docker build --build-arg DRIVER_VERSION=550.127.05 --build-arg DRIVER_BRANCH=550 --build-arg TARGETARCH=amd64 --build-arg GOLANG_VERSION=1.23.4 . -t grid-azure-driver:550.127.05-ubuntu22.04
docker push grid-azure-driver:550.127.05-ubuntu22.04