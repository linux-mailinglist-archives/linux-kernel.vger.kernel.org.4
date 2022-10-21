Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA676070BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJUHNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJUHNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77066156
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666336418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+K0YudeCXHfh0Ej/rQGh2RbrGNuVuwTcbXf3PjEZPc=;
        b=Ubvkeic4ihCc2OnC4qcYUa31H4SjUsyA8LIm2kQbZP2lS00uROZnyWEdCMq8EkrjjvgHIi
        DExCtPSAqv3J7fEOAyYwItV/DQG1bQvYuMl1bx0SY5EE8kP7DktaQziE2biXaY3xsa2ujQ
        FaAcaBlIdVV2SYqArLwQGNJy2DS8DpY=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-543-cOWqgraEOnSeFTlvBj8ZwA-1; Fri, 21 Oct 2022 03:13:36 -0400
X-MC-Unique: cOWqgraEOnSeFTlvBj8ZwA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-13b29b8eceaso814257fac.20
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+K0YudeCXHfh0Ej/rQGh2RbrGNuVuwTcbXf3PjEZPc=;
        b=QagmTxOKWttqHzvdD+5DdB6tl18UYI3S8Z4DkRtcB/Zs90ZK17TfQafwhmHyW1JkrY
         PeHXOZQoZcOWK2mcvaSKbQWunDzCqA0SS826qpd9CRX4mzxVcXstIyby8uMMU+kXcJtb
         cMA+OVJuG5MiDX1OSJ37b/nWFqv2CZ49OP0E8Bzp/oJ9r+P4C5114i03i/Cs0VuGi1YA
         0MnhIGiC+7ibsiF6vSHvPmUBQc1zo6ndbwv5XqE4D+JXQkMeHQG5PDG1RhtgQpluAkXu
         Q5AantIaGkCsX+btaATVlS7WEukHYoPkQhKZ/z/5IPL4B89uhTEzwHxkiiutU0two8++
         wQkA==
X-Gm-Message-State: ACrzQf3Wlv8TEF+uuP3l8Z+x7MGNlILPGn1SbdIHaa3sVeH2obfCwnYK
        2VrS0lDWU3ufuVMHMgMPAdvOzANFdp7xSLvpcHR/mn4dfYErlxZtzY4C+ePQXJiwOdo4QKC9pRO
        HVUB2Q3QUm80DL+MBpr9NapfcsHVxwaLFaXGyoMij
X-Received: by 2002:a9d:12a8:0:b0:661:a06f:33d7 with SMTP id g37-20020a9d12a8000000b00661a06f33d7mr9041523otg.237.1666336415521;
        Fri, 21 Oct 2022 00:13:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4PXHoJbgdA+C7cmFOGkx27RMqNCCb2+5mROMQWK5BZ1jCyM9VeWVQThmbbCjFy/PfHKkzo3Kopu6X6BLfsjvo=
X-Received: by 2002:a9d:12a8:0:b0:661:a06f:33d7 with SMTP id
 g37-20020a9d12a8000000b00661a06f33d7mr9041496otg.237.1666336414927; Fri, 21
 Oct 2022 00:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com>
 <08d98212a355fdce5820d57bd0ffaf3ca0968531.camel@redhat.com>
 <5887b71e-cef2-a7b9-133c-e4ba860bf24a@oracle.com> <CACGkMEvQhfenW9-StMwaJ887eatb_qtRYdDn=E12Wwkc6HU-sQ@mail.gmail.com>
 <1a81e33d7069875ecba0fd493b298b5d33718081.camel@redhat.com>
In-Reply-To: <1a81e33d7069875ecba0fd493b298b5d33718081.camel@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 21 Oct 2022 15:13:22 +0800
Message-ID: <CACGkMEtQ4xawaU6i=h5SSJApW-95PBfV2PaHgAhitt8Eiz_okw@mail.gmail.com>
Subject: Re: [PATCH 0/4] vDPA: dev config export via "vdpa dev show" command
To:     Sean Mooney <smooney@redhat.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Daniel Berrange <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:09 PM Sean Mooney <smooney@redhat.com> wrote:
>
> On Tue, 2022-10-18 at 15:59 +0800, Jason Wang wrote:
> > On Tue, Oct 18, 2022 at 7:35 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> > >
> > >
> > >
> > > On 10/17/2022 5:28 AM, Sean Mooney wrote:
> > > > On Mon, 2022-10-17 at 15:08 +0800, Jason Wang wrote:
> > > > > Adding Sean and Daniel for more thoughts.
> > > > >
> > > > > On Sat, Oct 15, 2022 at 9:33 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> > > > > > Live migration of vdpa would typically require re-instate vdpa
> > > > > > device with an idential set of configs on the destination node,
> > > > > > same way as how source node created the device in the first place.
> > > > > >
> > > > > > In order to allow live migration orchestration software to export the
> > > > > > initial set of vdpa attributes with which the device was created, it
> > > > > > will be useful if the vdpa tool can report the config on demand with
> > > > > > simple query.
> > > > > For live migration, I think the management layer should have this
> > > > > knowledge and they can communicate directly without bothering the vdpa
> > > > > tool on the source. If I was not wrong this is the way libvirt is
> > > > > doing now.
> > > > At least form a openstack(nova) perspective we are not expecting to do any vdpa device configuration
> > > > at the openstack level. To use a vdpa device in openstack the oeprator when installing openstack
> > > > need to create a udev/systemd script to precreatre the vdpa devices.
> > > This seems to correlate vdpa device creation with the static allocation
> > > of SR-IOV VF devices. Perhaps OpenStack doesn't have a plan to support
> > > dynamic vdpa creation, but conceptionally vdpa creation can be on demand
> > > for e.g. over Mellanox SubFunction or Intel Scalable IOV device.
> >
> > Yes, it's not specific to vDPA but something that openstack needs to consider.
>
> yes so before i joined redhat in 2018 i worked at intel and was trying to intergate there mdev based
> solution for a nic that got canceled due to the changes required to adtop vdpa and some other issues.
> that orgianal approch was goign to dynmaicaly create teh mdev. for vdpa we built the support on top of
> our pci manager so the current support directly requires the vdpa device's parent to be a vf.
>
> we did this for two reasons, first when i started working on this again in 2020 that was the only model that
> worked with any nic that were aviable and at the time mdevs were automaticaly created when you allcoated the
> vf sicne this predated teh newer model of using the vdpa cli to add devcies. secondly buliding on top of the
> sriov/pci passthough framework was less invasive. with openstack we currently have only tested our vdpa support
> with melonox connectx6-dx cards which at the time i added supprot only supported vdpa device creation on vfs
> not subfunctions.
>
> we are aware that vdpa devices can be created over a Mellanox SubFunction or Intel Scalable IOV device
> but we do not plan to support either in the near term. Im the primary person who has been workign on the openstack
> support for vdpa in openstack but i will be working on some other work for the next 6 months or so
> its unlikely we will look at extending nova vdpa cpablities until our upstream b cycle which start in march next year.

Ok, I see. But note that cx6-dx has been switched to use vdap tool so
the vDPA device is no longer automatically being created after VF is
probed.

Actually, there's a third choice, the openstack can still choose to
"statically" provision the vDPA instance during the boot by just
calling the vdpa tool to create the instances.

>
> conceptually speakign we have two concerns with the dynamic approch. nova for better or worse effectivly runs with
> full root access alhtough tha tis configend with selinux/apparmor policies and/or with contaienrs in most production
> installations.

I think the situation should be no different from the case of e.g
using an iproute2 to create/destroy/configure networking devices? E.g
we case we need to create a bond or configure bridge/ovs. Can we keep
using the way we've used for iproute2?

> even so we try to limit privaldged calls and in the past we did not want nova specirifcly
> to make privladged calls to reconfigure hardware.  we already have precident for breaking that in the form of our
> generic mdev support where we are pass a list of parent devices and the mdev type to create on that device and then
> dynimcily advertise pools of avaiable mdevs which we create dynamicly. The scecond conserne is we have seen caching issue
> with libvirt when device change dynmicaly as it does nto always process the udev events correctly. as such our experince
> tells us that we are less likely to have caching related bugs if we take a staic approch.

I guess it might be bugs which needs to be fixed in the kernel instead
of trying to have workaround in the userspace but anyhow, we can still
emulate the "static" provisioning via vdpa tool, it seems more
smoothly that a immediate switch to dynamic one and then we will have
the time to fix the dynamic things.

>
> Enableing dynamic vdpa createion would reqiure a large rewrite of how vdpa has been integrated in nova and neutron(openstack networking component).
> right now when you create a neutron port of type vdpa we internally convert that to a pci_request of type vdpa which
> or pci_manager matches to a db record for the precreated vdpa devices. we woudl likely need to have a new vdpa-dynmaic or similar
> port type that would correspond to the subfucniton/iov backed vdpa devices adn we would need to modle them differencly in our database.

Yes, so this needs to be consided with the mdev/SIOV/SF, they
basically have the same model more or less.

>
> for sr-iov vfs the consumable consumable and therfor schdulable resouce is the vf so we have pools of vf with some metadata ot map them to logical
> networks in the case of a nic.  for a subfunciton/iov backed device there are presumabel two logical consumable resouces. The number of hardware
> vq pairs, and presumably there is a fintes number of iov/subfunctions a PF can allcoate.

This reminds me that the current vDPA tool can not report the number
of available vDPA instances that could be created by a mgmtdev, this
needs to be fixed.

> im sure there are other qualatative aspect we would like
> to schdule on but those are the main consumables that will determin how many vdpa devices we can create when selecting a host.
>
> we/i intentionally put this out of scope fo the inital vdpa support as i had no way to test this back in 2020 partly because we have a policy
> of not support test only code path i.e. adding supprot for the vdpa_sim kernel module which was discussed adn rejected becasue it does not create
> pci vfs for the vdpa devices and would have prevent using the pci manager or at least require us to fake the pci adress info using a sentenial like
> all 0. if we did not need to supprot dynamic creation the usnign a cential pci adress would actully be a quick way to add iov/subfucniton support
> but it woudl still require the static creations and a slight tweak to how we disucover the vdpa devices from libvirt.

Right, but for now, we have plenty of devices, e.g we can create vDPA
on top of subfucntion (and vDPA seems to be the first of several
devices that could be created via SF).

>
> so to summerise supporting vdpa with iov/subfuctions as the backedn device would be a relitivly simple if they are precreated, we can
> fake the entry in the pci tacker in that case using a sentinal adress other tag in the db row to denote they are not vf backed.
> this woudl not require any change to neutron although we woudl likely need ot also modify os-vif to lookup the repesentor netdev which we
> attach to openvswitch to accoutn for the fact its an iov/subfunciton isntead of a vf parent.
> the dynmic approch
>
> >
> > >
> > > >
> > > > nova will query libvirt for the list avaiable vdpa devices at start up and record them in our database.
> > > > when schudling we select a host that has a free vdpa device and on that host we generate a xml snipit
> > > > that refernce the vdpa device and proivde that to libvirt and it will in turn program the mac.
> > > >
> > > > """
> > > > <interface type="vdpa">
> > > >      <mac address="b5:bc:2e:e7:51:ee"/>
> > > >      <source dev="/dev/vhost-vdpa-3"/>
> > > > </interface>
> > > > """
> > > >
> > > > when live migrating the workflow is similar. we ask our schduler for a host that should have enough avaiable
> > > > resouces, then we make an rpc call "pre_live_migrate" which makes a number of assterions such as cpu compatiablity
> >
> > A migration compatibility check for vDPA should be done as well here.
> yes it could be although at this point we have alredy complete schduling so if the check fails we will abort the migration.
> presumable libvirt will also check after we invoke the migraation too but the ideal case woudl be that we have enough
> info in our db to select a host we know will work rather then checkign after the fact.
> >
> > > > but also computes cpu pinning and device passthough asignemnts. i.e. in pre_live_migate we select wich cpu cores, pcie
> > > > devices and in this case vdpa devices to use on the destination host
> > > In the case of vdpa, does it (the pre_live_migrate rpc) now just selects
> > > the parent mgmtdev for creating vdpa in later phase, or it ends up with
> > > a vdpa device being created? Be noted by now there's only a few
> > > properties for vdpa creation e.g. mtu and mac, that it doesn't need
> > > special reservation of resources for creating a vdpa device. But that
> > > may well change in the future.
> > >
> > > > and return that in our rpc result.
> > > >
> > > > we then use that information to udpate the libvirt domain xml with the new host specific information and start
> > > > the migration at the libvirt level.
> > > >
> > > > today in openstack we use a hack i came up with to workaroudn that fact that you cant migrate with sriov/pci passthough
> > > > devices to support live migration with vdpa. basically before we call libvirt to live migrate we hot unplug the vdpa nic
> > > > form the guest and add them back after the migration is complte. if you dont bound the vdpa nics wiht a transparently migratable
> > > > nic in the guest that obvioulsy result in a loss of network connectivity while the migration is happenign which is not ideal
> > > > so a normal virtio-net interface on ovs is what we recommend as the fallback interface for the bound.
> > > Do you need to preserve the mac address when falling back to the normal
> > > virtio-net interface, and similarly any other network config/state?
> > > Basically vDPA doesn't support live migration for the moment.
> >
> > Basic shadow vq based live migration can work now. Eugenio is working
> > to make it fully ready in the near future.
> this missed our merge window for the Zed cycle which feature froze in september and was relased a week or two ago.

I see.

>
> >
> > > This
> > > doesn't like to be a technically correct solution for it to work.
> >
> > I agree.
> this is what is what we added for sriov VF direct pasthouhg
> all you need to do in the guest is use the linux kernel bond driver to create a bound between the vf and anoter live migratebale prot type.
> the basic test i did for this i added the mac of the VF  to the allowed adress pairs for the ovs port and used that as the mac of the vf.
> this is all out os scope of openstack to configure and manage. we are not useing the virtio fallback support that was added after we implemted this
> as we dont have a good way today to descibe the grouping of the primary and fallback internfce in neutron api.
>
> the details of waht we do are here https://specs.openstack.org/openstack/nova-specs/specs/stein/approved/libvirt-neutron-sriov-livemigration.html
>
> we only do automatic hotplug for nic and only if they are drectly attached, if they use a macvtap to attach the vf to the vm we do not remove them.
> our intent for vdpa was to also not remove them and rely on the native live migration supprot when we detct the source and destiantion host
> supprot that.

Yes, it should work for vDPA as well, but what we want to say is that
vDPA will support native live migration. And vDPA is more than just a
networking device. It might not be easy to find a similar technology
like bond/multipath in other type of devices.

>
> >
> > > >
> > > > obviouly when vdpa supprot transparent live migration we can just skip this workaround which woudl be a very nice ux improvement.
> > > > one of the sideeffct of the hack however is you can start with an intel nic and end up with a melonox nic becasue we dont need
> > > > to preserve the device capablies sicne we are hotplugging.
> > > Exactly. This is the issue.
> so today in an openstack cloud you ingeneral should not know the vendro fo the nic that si provdie as a normal user.
> for vdpa that is even more imporant as vdpa is ment to abstract that and provdie a standardised virtio interface to the guest.
> there are atributes of the virtio inteface that obviously need to match liek the vq_size but we shoudl be able to
> live migrate from a vdpa device created on a connext6-dx vf to one expsoed by an intel iov device without the guest knowing
> that we have changed teh backend.

Yes.

> > > >
> > > > with vdpa we will at least have a virtaul virtio-net-pci frontend in qemu to provide some level of abstraction.
> > > > i guess the point you are raising is that for live migration we cant start with 4 queue paris and vq_size=256
> > > > and select a device with 2 queue pairs and vq_size of 512 and expect that to just work.
> > > Not exactly, the vq_size comes from QEMU that has nothing to do with
> > > vDPA tool. And live migrating from 4 queue pairs to 2 queue pairs won't
> > > work for the guest driver. Change of queue pair numbers would need
> > > device reset which  won't happen transparently during live migration.
> > > Basically libvirt has to match the exact queue pair number and queue
> > > length on destination node.
> > >
> > > >
> > > > There are two ways to adress that. 1 we can start recording this infor in our db and schdule only ot hosts with the same
> > > > configuration values, or 2 we can record the capablities i.e. the max vaulues that are support by a devcice and schdule to a host
> > > > where its >= the current value and rely on libvirt to reconfigure the device.
> > > >
> > > > libvirt required very little input today to consume a vdpa interface
> > > > https://libvirt.org/formatdomain.html#vdpa-devices
> >
> > So a question here, if we need to create vDPA on demand (e.g with the
> > features and configs from the source) who will do the provision? Is it
> > libvirt?
> for mdevs we directly write to /sys we decied not to supprot mdevctl as it was not vendor neutal at the time or packaged in
> distros other then fedora. since then libvirt has added the ablity to create mdevs via its nodedev api.

Good to know that, then it looks like libvirt should be in charge of this.

> if that had existed
> at the time we probably would have used that instead. so if we were to support dynamic mdev createion we would have two options
>
> 1.) wrap calls to the vdpa cli into privaldged fucntions executed in our privaladge seperation deamon
> 2.) use a libvirt provided api likely an extention to the nodedev api like the mdev one.
>
> timing would be a factor but if libvirt supported the capablity when we started working on supprot i dont see why we woudl
> bypass it and do it ourselve. if libvirt did not want to supprot this we woudl fall back to option 1.
>
> as noted above the openstack team at redhat will not have capsity to consume this ongoing work in the kernel/libvit
> until q2 next year at the eairliest so we likely wont make any discision in this regard until then.

I see, then we can see if it would be interesting for other vendors to
implement.

Thanks

>
> >
> > Thanks
> >
> > > > there are some generic virtio device optiosn we could set https://libvirt.org/formatdomain.html#virtio-related-options
> > > > and some generic options like the mtu that the interface element supportr
> > > >
> > > > but the miniumal valide xml snipit is litrally just the source dev path.
> > > >
> > > > <devices>
> > > >    <interface type='vdpa'>
> > > >      <source dev='/dev/vhost-vdpa-0'/>
> > > >    </interface>
> > > > </devices>
> > > >
> > > > nova only add the mac address and MTU today although i have some untested code that will try to also set the vq size.
> > > > https://github.com/openstack/nova/blob/11cb31258fa5b429ea9881c92b2d745fd127cdaf/nova/virt/libvirt/designer.py#L154-L167
> > > >
> > > > The basic supprot we have today assumes however that the vq_size is either the same on all host or it does not matter because we do
> > > > not support transparent live migration today so its ok for it to change form host to host.
> > > > in any case we do not track the vq_size or vq count today so we cant schdule based on it or comunicate it to libvirt via our
> > > > pre_live_migration rpc result. that means libvirt shoudl check if the dest device has the same cofnig or update it if posible
> > > > before starting the destination qemu instance and begining the migration.
> > > >
> > > > > > This will ease the orchestration software implementation
> > > > > > so that it doesn't have to keep track of vdpa config change, or have
> > > > > > to persist vdpa attributes across failure and recovery, in fear of
> > > > > > being killed due to accidental software error.
> > > > the vdpa device config is not somethign we do today so this woudl make our lives more complex
> > > It's regarding use case whether to support or not. These configs well
> > > exist before my change.
> > >
> > > > depending on
> > > > what that info is. at least in the case of nova we do not use the vdpa cli at all, we use libvirt as an indirection layer.
> > > > so libvirt would need to support this interface, we would have to then add it to our db and modify our RPC interface
> > > > to then update the libvirt xml with addtional info we dont need today.
> > >
> > > Yes. You can follow libvirt when the corresponding support is done, but
> > > I think it's orthogonal with my changes. Basically my change won't
> > > affect libvirt's implementation at all.
> > >
> > > Thanks,
> > > -Siwei
> > >
> > >
> > > > > > In this series, the initial device config for vdpa creation will be
> > > > > > exported via the "vdpa dev show" command.
> > > > > > This is unlike the "vdpa
> > > > > > dev config show" command that usually goes with the live value in
> > > > > > the device config space, which is not reliable subject to the dynamics
> > > > > > of feature negotiation and possible change in device config space.
> > > > > >
> > > > > > Examples:
> > > > > >
> > > > > > 1) Create vDPA by default without any config attribute
> > > > > >
> > > > > > $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
> > > > > > $ vdpa dev show vdpa0
> > > > > > vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> > > > > > $ vdpa dev -jp show vdpa0
> > > > > > {
> > > > > >      "dev": {
> > > > > >          "vdpa0": {
> > > > > >              "type": "network",
> > > > > >              "mgmtdev": "pci/0000:41:04.2",
> > > > > >              "vendor_id": 5555,
> > > > > >              "max_vqs": 9,
> > > > > >              "max_vq_size": 256,
> > > > > >          }
> > > > > >      }
> > > > > > }
> > > > This is how openstack works today. this step is done statically at boot time typiccly via a udev script or systemd servic file.
> > > > the mac adress is udpate don the vdpa interface by libvirt when its asigined to the qemu process.
> > > > if we wanted to suport multi queue or vq size configuration it would also happen at that time not during device creation.
> > > > > > 2) Create vDPA with config attribute(s) specified
> > > > > >
> > > > > > $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
> > > > > >      mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> > > > > > $ vdpa dev show
> > > > > > vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> > > > > >    mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> > > > > > $ vdpa dev -jp show
> > > > > > {
> > > > > >      "dev": {
> > > > > >          "vdpa0": {
> > > > > >              "type": "network",
> > > > > >              "mgmtdev": "pci/0000:41:04.2",
> > > > > So "mgmtdev" looks not necessary for live migration.
> > > > >
> > > > > Thanks
> > > > >
> > > > > >              "vendor_id": 5555,
> > > > > >              "max_vqs": 9,
> > > > > >              "max_vq_size": 256,
> > > > > >              "mac": "e4:11:c6:d3:45:f0",
> > > > > >              "max_vq_pairs": 4
> > > > > >          }
> > > > > >      }
> > > > > > }
> > > > dynmaicaly creating vdpa device at runtime while possible is not an approch we are plannign to supprot.
> > > >
> > > > currntly in nova we perefer to do allcoation of staticically provsioned resouces in nova.
> > > > for persitent memory, sriov/pci passthorgh, dedciated cpus, hugepages and vdpa devices we manage inventories
> > > > of resouce that the operator has configured on the platform.
> > > >
> > > > we have one excption to this static aproch which is semi dynmaic that is how we manage vifo mediated devices.
> > > > for reasons that are not important we currrnly track the partent devices that are capable of providing MDEVs
> > > > and we directlly write to /sys/... to create teh mdev instance  of a requested mdev on demand.
> > > >
> > > > This has proven ot be quite problematic as we have encountered caching bugs due to the delay between device
> > > > creation and when the /sys interface expost the direcotry stucture for the mdev. This has lead ot libvirt and as a result
> > > > nova getting out of sync with the actual state of the host. There are also issue with host reboots.
> > > >
> > > > while we do see the advantage of beign able to create vdpa interface on demad espicaly if we can do finer grained resouce
> > > > partioning by allcoating one mdev with 4 vqs adn another with 8 ectra, or experice with dynmic mdev management gives us
> > > > pause. we can and will fix our bugs with mdevs but we have found that most of our customers that use feature  like this
> > > > are telcos or other similar industries that typiclly have very static wrokloads. while there is  some interest in making
> > > > there clouds more dynmaic they typically file a host and run the same worklaod on that host form months to years at a
> > > > time and plan there hardware and acordingly so they are well seved by the static usecase "1) Create vDPA by default without any config attribute".
> > > >
> > > > > > ---
> > > > > >
> > > > > > Si-Wei Liu (4):
> > > > > >    vdpa: save vdpa_dev_set_config in struct vdpa_device
> > > > > >    vdpa: pass initial config to _vdpa_register_device()
> > > > > >    vdpa: show dev config as-is in "vdpa dev show" output
> > > > > >    vdpa: fix improper error message when adding vdpa dev
> > > > > >
> > > > > >   drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
> > > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
> > > > > >   drivers/vdpa/vdpa.c                  | 63 +++++++++++++++++++++++++++++++++---
> > > > > >   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
> > > > > >   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
> > > > > >   drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
> > > > > >   drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 +-
> > > > > >   include/linux/vdpa.h                 | 26 ++++++++-------
> > > > > >   8 files changed, 80 insertions(+), 22 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 1.8.3.1
> > > > > >
> > >
> >
>

