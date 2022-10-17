Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48306600F31
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJQM2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJQM2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADA83741A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666009696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQMwXXMu5AfJrYit7l7Uz854Empc5WnvrUYDBysO3UE=;
        b=gRBFBuPv07zUziQyyWpq15leOz6d6rzHlL259ux8cenKfDnDVzp2O+RFFolBTHAzDkcjGk
        n+HH8+KcfIJ02TMiMaCu22iNkHHQtBDAhof82HRBttkuK3MRhdROLRwU0thyaqo+pbWXAY
        QcbNdrKvXOwSCToLASIw6e5SH+ejJLw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-539-7eBgRI1iPRum9ctWB6NU-A-1; Mon, 17 Oct 2022 08:28:15 -0400
X-MC-Unique: 7eBgRI1iPRum9ctWB6NU-A-1
Received: by mail-wr1-f69.google.com with SMTP id j8-20020adfa548000000b0022e2bf8f48fso3664821wrb.23
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQMwXXMu5AfJrYit7l7Uz854Empc5WnvrUYDBysO3UE=;
        b=WgSKfa3+N99QCL20w/zp47WixBhD3PxxFruCHSLJdWMP9OdyCj9ijCWJJOSd2x7UCC
         oj/1Ptnp70kjxZOKWPAhMZ4b8/LPz4fOoNjBmAmklYMQyFhsseuGJGOf7NQIk6jA3HCK
         1wuNoubHQs/J1PqJkih3cNuoaQNWuXYwY5j0T6QcmNH/7FycxGGS6se+wGfO8kAV/CSs
         1ui7RjzCcnhIv8+AecKzVahkVGpGnBS68boEMvZ05xuMgzgvxD/Sbri99T56+3m+Kx9C
         GPRZ3zBM0MHDL/Dr/AlDCUz5B1yUnKwrzPVgX/KVa8UnGB8UY4zqJiuhCktLizIkUh1C
         QRHg==
X-Gm-Message-State: ACrzQf3E070+gubVczbtGnluMoNltB6UqYUMXQFnaRJ+wHHsUMfpfEm0
        xn8xX+CCjkkNz4LvjpemqqIIuyl4k5SqtBSg3DNbXdC3keAjb26JYn1+VDdIoTLr7qYbFK2myLn
        LT2T4kWQPQkgAzWbrgjb3oY+0
X-Received: by 2002:a05:6000:1a41:b0:22e:3667:d306 with SMTP id t1-20020a0560001a4100b0022e3667d306mr5968227wry.21.1666009693728;
        Mon, 17 Oct 2022 05:28:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4PEZRXXcB8bnWPh9qBBx1EMbrXeW4Fwp2bsqrlUhIt+Q/hWM5HoRY+fvRaDWQruKlCqEjhAA==
X-Received: by 2002:a05:6000:1a41:b0:22e:3667:d306 with SMTP id t1-20020a0560001a4100b0022e3667d306mr5968212wry.21.1666009693306;
        Mon, 17 Oct 2022 05:28:13 -0700 (PDT)
Received: from ?IPv6:2001:bb6:3900:0:b5e3:ac1d:2cfd:61b1? ([2001:bb6:3900:0:b5e3:ac1d:2cfd:61b1])
        by smtp.gmail.com with ESMTPSA id bv16-20020a0560001f1000b0022e6f0d0d7csm9912905wrb.18.2022.10.17.05.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:28:12 -0700 (PDT)
Message-ID: <08d98212a355fdce5820d57bd0ffaf3ca0968531.camel@redhat.com>
Subject: Re: [PATCH 0/4] vDPA: dev config export via "vdpa dev show" command
From:   Sean Mooney <smooney@redhat.com>
To:     Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Daniel Berrange <berrange@redhat.com>
Date:   Mon, 17 Oct 2022 13:28:09 +0100
In-Reply-To: <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com>
References: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
         <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-17 at 15:08 +0800, Jason Wang wrote:
> Adding Sean and Daniel for more thoughts.
> 
> On Sat, Oct 15, 2022 at 9:33 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> > 
> > Live migration of vdpa would typically require re-instate vdpa
> > device with an idential set of configs on the destination node,
> > same way as how source node created the device in the first place.
> > 
> > In order to allow live migration orchestration software to export the
> > initial set of vdpa attributes with which the device was created, it
> > will be useful if the vdpa tool can report the config on demand with
> > simple query.
> 
> For live migration, I think the management layer should have this
> knowledge and they can communicate directly without bothering the vdpa
> tool on the source. If I was not wrong this is the way libvirt is
> doing now.
At least form a openstack(nova) perspective we are not expecting to do any vdpa device configuration
at the openstack level. To use a vdpa device in openstack the oeprator when installing openstack
need to create a udev/systemd script to precreatre the vdpa devices.

nova will query libvirt for the list avaiable vdpa devices at start up and record them in our database.
when schudling we select a host that has a free vdpa device and on that host we generate a xml snipit
that refernce the vdpa device and proivde that to libvirt and it will in turn program the mac.

"""
<interface type="vdpa">
    <mac address="b5:bc:2e:e7:51:ee"/>
    <source dev="/dev/vhost-vdpa-3"/>
</interface>
"""

when live migrating the workflow is similar. we ask our schduler for a host that should have enough avaiable
resouces, then we make an rpc call "pre_live_migrate" which makes a number of assterions such as cpu compatiablity
but also computes cpu pinning and device passthough asignemnts. i.e. in pre_live_migate we select wich cpu cores, pcie
devices and in this case vdpa devices to use on the destination host and return that in our rpc result.

we then use that information to udpate the libvirt domain xml with the new host specific information and start
the migration at the libvirt level.

today in openstack we use a hack i came up with to workaroudn that fact that you cant migrate with sriov/pci passthough
devices to support live migration with vdpa. basically before we call libvirt to live migrate we hot unplug the vdpa nic
form the guest and add them back after the migration is complte. if you dont bound the vdpa nics wiht a transparently migratable
nic in the guest that obvioulsy result in a loss of network connectivity while the migration is happenign which is not ideal
so a normal virtio-net interface on ovs is what we recommend as the fallback interface for the bound.

obviouly when vdpa supprot transparent live migration we can just skip this workaround which woudl be a very nice ux improvement.
one of the sideeffct of the hack however is you can start with an intel nic and end up with a melonox nic becasue we dont need
to preserve the device capablies sicne we are hotplugging.

with vdpa we will at least have a virtaul virtio-net-pci frontend in qemu to provide some level of abstraction.
i guess the point you are raising is that for live migration we cant start with 4 queue paris and vq_size=256
and select a device with 2 queue pairs and vq_size of 512 and expect that to just work.

There are two ways to adress that. 1 we can start recording this infor in our db and schdule only ot hosts with the same
configuration values, or 2 we can record the capablities i.e. the max vaulues that are support by a devcice and schdule to a host
where its >= the current value and rely on libvirt to reconfigure the device.

libvirt required very little input today to consume a vdpa interface
https://libvirt.org/formatdomain.html#vdpa-devices
there are some generic virtio device optiosn we could set https://libvirt.org/formatdomain.html#virtio-related-options
and some generic options like the mtu that the interface element supportr

but the miniumal valide xml snipit is litrally just the source dev path.

<devices>
  <interface type='vdpa'>
    <source dev='/dev/vhost-vdpa-0'/>
  </interface>
</devices>

nova only add the mac address and MTU today although i have some untested code that will try to also set the vq size.
https://github.com/openstack/nova/blob/11cb31258fa5b429ea9881c92b2d745fd127cdaf/nova/virt/libvirt/designer.py#L154-L167

The basic supprot we have today assumes however that the vq_size is either the same on all host or it does not matter because we do
not support transparent live migration today so its ok for it to change form host to host.
in any case we do not track the vq_size or vq count today so we cant schdule based on it or comunicate it to libvirt via our
pre_live_migration rpc result. that means libvirt shoudl check if the dest device has the same cofnig or update it if posible
before starting the destination qemu instance and begining the migration.

> 
> > This will ease the orchestration software implementation
> > so that it doesn't have to keep track of vdpa config change, or have
> > to persist vdpa attributes across failure and recovery, in fear of
> > being killed due to accidental software error.
the vdpa device config is not somethign we do today so this woudl make our lives more complex depending on
what that info is. at least in the case of nova we do not use the vdpa cli at all, we use libvirt as an indirection layer.
so libvirt would need to support this interface, we would have to then add it to our db and modify our RPC interface
to then update the libvirt xml with addtional info we dont need today.
> > 
> > In this series, the initial device config for vdpa creation will be
> > exported via the "vdpa dev show" command.
> > This is unlike the "vdpa
> > dev config show" command that usually goes with the live value in
> > the device config space, which is not reliable subject to the dynamics
> > of feature negotiation and possible change in device config space.
> > 
> > Examples:
> > 
> > 1) Create vDPA by default without any config attribute
> > 
> > $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
> > $ vdpa dev show vdpa0
> > vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> > $ vdpa dev -jp show vdpa0
> > {
> >     "dev": {
> >         "vdpa0": {
> >             "type": "network",
> >             "mgmtdev": "pci/0000:41:04.2",
> >             "vendor_id": 5555,
> >             "max_vqs": 9,
> >             "max_vq_size": 256,
> >         }
> >     }
> > }
This is how openstack works today. this step is done statically at boot time typiccly via a udev script or systemd servic file.
the mac adress is udpate don the vdpa interface by libvirt when its asigined to the qemu process.
if we wanted to suport multi queue or vq size configuration it would also happen at that time not during device creation.
> > 
> > 2) Create vDPA with config attribute(s) specified
> > 
> > $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
> >     mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> > $ vdpa dev show
> > vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> >   mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> > $ vdpa dev -jp show
> > {
> >     "dev": {
> >         "vdpa0": {
> >             "type": "network",
> >             "mgmtdev": "pci/0000:41:04.2",
> 
> So "mgmtdev" looks not necessary for live migration.
> 
> Thanks
> 
> >             "vendor_id": 5555,
> >             "max_vqs": 9,
> >             "max_vq_size": 256,
> >             "mac": "e4:11:c6:d3:45:f0",
> >             "max_vq_pairs": 4
> >         }
> >     }
> > }
dynmaicaly creating vdpa device at runtime while possible is not an approch we are plannign to supprot.

currntly in nova we perefer to do allcoation of staticically provsioned resouces in nova.
for persitent memory, sriov/pci passthorgh, dedciated cpus, hugepages and vdpa devices we manage inventories
of resouce that the operator has configured on the platform. 

we have one excption to this static aproch which is semi dynmaic that is how we manage vifo mediated devices.
for reasons that are not important we currrnly track the partent devices that are capable of providing MDEVs
and we directlly write to /sys/... to create teh mdev instance  of a requested mdev on demand.

This has proven ot be quite problematic as we have encountered caching bugs due to the delay between device
creation and when the /sys interface expost the direcotry stucture for the mdev. This has lead ot libvirt and as a result
nova getting out of sync with the actual state of the host. There are also issue with host reboots.

while we do see the advantage of beign able to create vdpa interface on demad espicaly if we can do finer grained resouce
partioning by allcoating one mdev with 4 vqs adn another with 8 ectra, or experice with dynmic mdev management gives us
pause. we can and will fix our bugs with mdevs but we have found that most of our customers that use feature  like this
are telcos or other similar industries that typiclly have very static wrokloads. while there is  some interest in making
there clouds more dynmaic they typically file a host and run the same worklaod on that host form months to years at a
time and plan there hardware and acordingly so they are well seved by the static usecase "1) Create vDPA by default without any config attribute".

> > 
> > ---
> > 
> > Si-Wei Liu (4):
> >   vdpa: save vdpa_dev_set_config in struct vdpa_device
> >   vdpa: pass initial config to _vdpa_register_device()
> >   vdpa: show dev config as-is in "vdpa dev show" output
> >   vdpa: fix improper error message when adding vdpa dev
> > 
> >  drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
> >  drivers/vdpa/vdpa.c                  | 63 +++++++++++++++++++++++++++++++++---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
> >  drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
> >  drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 +-
> >  include/linux/vdpa.h                 | 26 ++++++++-------
> >  8 files changed, 80 insertions(+), 22 deletions(-)
> > 
> > --
> > 1.8.3.1
> > 
> 

