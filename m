Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54A95EECDB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 06:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiI2E4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 00:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiI2E4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 00:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA879A6A5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 21:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664427361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5EIyNaGDWgowp2h1SvHqhXjov1ATgPOoGzDZgZks0Q=;
        b=DO7V4vTtLrHZQ9NEjGi2Pa2cpulAYN8NmnWN8JmecxQvWYAEB+1cj0IATZys9YWC/mBrJ2
        WuSyDnfwDgs9wjWdMTVzUIoaozba/JLCGdtTp6674paz7kc2S6IqFnBsqwNlAFa7rlHCoq
        Sx2jW42XA+4X/5LAJVvzqBdfNqAPpaw=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-434-fXuJRdiUP7aKVunto9X1_A-1; Thu, 29 Sep 2022 00:56:00 -0400
X-MC-Unique: fXuJRdiUP7aKVunto9X1_A-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-12d265203aeso292016fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 21:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/5EIyNaGDWgowp2h1SvHqhXjov1ATgPOoGzDZgZks0Q=;
        b=vnQsUOuAelX6079OPDVsvFHJgK/umSqNLYZsuf05Ba4ecqi80/RrZUD+2sG7ToBld7
         hGkLHL0lhh8e4bEsuQK0SxuckAF6LakGxZVZWpQONBeBwVOxgAl0IYnEzrjNkwa165oL
         MoDl6n9jWNBEpvurpQiaT5hB/aD106aRgFseoP4J/Ce/kIdau3TAlfJOVfFMuFrIOYC4
         pMiNj8hvZ//FT5eu80duD7bzDLeC/HdGxJQrnoIi7T91/GYI2lA0M1FeG0jh/9/6YBM/
         rGKGdJ1aDy6B9BpYgD4KGhkM8s97pF27TSG4CZvDDifzmFFUXbgKMrABmcZz3d7n833V
         7QHA==
X-Gm-Message-State: ACrzQf0OO6xtwwSujo6ViHvJOBYuiQtd0QOZPfkmdl38cMTFw0jq8VFI
        IQSW16yJfkrBble1WC/jcBZB2Reb467JCfJuzt12wHeKSJA7XS1pKXOPS12QdVdAgLU5uSGBBex
        CB0mGULbuUgo5yWr3cb2Yc1vTEU1qvlKc7tT3TXyQ
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id y4-20020a056808130400b00350649bf8a1mr655139oiv.280.1664427358817;
        Wed, 28 Sep 2022 21:55:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Ja7AdvVhSiEfOQwC/DeJwKJHDAK0SrEqaMd2Y6StZD1kNSEPEKqTmB8AyOWDOs1Io1Ox3zg8f1KXpPi5r1zI=
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id
 y4-20020a056808130400b00350649bf8a1mr655118oiv.280.1664427358386; Wed, 28 Sep
 2022 21:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com> <20220922024305.1718-3-jasowang@redhat.com>
 <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com> <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
 <afe960d3-730a-b52c-e084-40bf080b27fa@oracle.com> <CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com>
 <c5a96de5-699a-8b5e-0e89-bfe1822e1105@oracle.com>
In-Reply-To: <c5a96de5-699a-8b5e-0e89-bfe1822e1105@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 29 Sep 2022 12:55:47 +0800
Message-ID: <CACGkMEsJZshW6cMiGPBu4LBSAQYr3ZhsD006v2ncCvNgXW6RJw@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Parav Pandit <parav@nvidia.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        eperezma <eperezma@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Gautam Dawar <gdawar@xilinx.com>, Cindy Lu <lulu@redhat.com>,
        Yongji Xie <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 5:41 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 9/26/2022 8:59 PM, Jason Wang wrote:
>
> On Tue, Sep 27, 2022 at 9:02 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
> On 9/26/2022 12:11 AM, Jason Wang wrote:
>
> On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
> On 9/21/2022 7:43 PM, Jason Wang wrote:
>
> This patch implements features provisioning for vdpa_sim_net.
>
> 1) validating the provisioned features to be a subset of the parent
>     features.
> 2) clearing the features that is not wanted by the userspace
>
> For example:
>
> # vdpa mgmtdev show
> vdpasim_net:
>    supported_classes net
>    max_supported_vqs 3
>    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS=
_PLATFORM
>
> Sighs, not to blame any one and it's perhaps too late, but this
> "dev_features" attr in "mgmtdev show" command output should have been
> called "supported_features" in the first place.
>
> Not sure I get this, but I guess this is the negotiated features actually=
.
>
> Actually no, that is why I said the name is a bit confusing and "supporte=
d_features" might sound better.
>
> You're right, it's an mgmtdev show actually.
>
> This attribute in the parent device (mgmtdev) denotes the real device cap=
ability for what virtio features can be supported by the parent device. Any=
 unprivileged user can check into this field to know parent device's capabi=
lity without having to create a child vDPA device at all. The features that=
 child vDPA device may support should be a subset of, or at most up to what=
 the parent device offers. For e.g. the vdpa device dev1 you created below =
can expose less or equal device_features bit than 0x308820028 (MTU MAC CTRL=
_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM), but shouldn't be n=
o more than what the parent device can actually support.
>
> Yes, I didn't see anything wrong with "dev_features",
>
> Yep, it didn't appear to me anything wrong either at first sight, then I =
gave my R-b on the series introduced this attribute. But it's not a perfect=
 name, either, on the other hand. Parav later pointed out that the correspo=
nding enum definition for this attribute should follow pre-existing naming =
convention that we should perhaps do s/VDPA_ATTR_DEV_SUPPORTED_FEATURES/VDP=
A_ATTR_MGMTDEV_SUPPORTED_FEATURES/ to get it renamed, as this is a mgmtdev =
level attribute, which I agree. Now that with the upcoming "device_features=
" attribute (vdpa dev level) from this series, it's subject to another conf=
usions between these two similar names, but actually would represent things=
 at different level. While all other attributes in "mgmtdev dev show" seem =
to be aligned with the "supported_" prefix, e.g. supported_classes, max_sup=
ported_vqs, from which I think the stance of device is already implied thro=
ugh "mgmtdev" in the command. For the perspective of clarify and easy disti=
nction, "supported_features" seems to be a better name than "dev_features".

See another reply, I think I get your point,

1) VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES (lingshan's series) and
VDPA_ATTR_VDPA_DEV_FEATURES should be equivalent and unified to a
single attribute.
2) A better name to "supported_features" should be fine, patches are welcom=
ed

>
>  it aligns to the
> virtio spec which means the features could be used to create a vdpa
> device. But if everyone agree on the renaming, I'm fine.
>
> Never mind, if it's late don't have to bother.
>
>
>
> I think Ling Shan is working on reporting both negotiated features
> with the device features.
>
> Does it imply this series is connected to another work in parallel? Is it=
 possible to add a reference in the cover letter?
>
> I'm not sure, I remember Ling Shan did some work to not block the
> config show in this commit:
>
> commit a34bed37fc9d3da319bb75dfbf02a7d3e95e12de
> Author: Zhu Lingshan <lingshan.zhu@intel.com>
> Date:   Fri Jul 22 19:53:07 2022 +0800
>
>     vDPA: !FEATURES_OK should not block querying device config space
>
> We need some changes in the vdpa tool to show device_features
> unconditionally in the "dev config show" command.
>
> That's true, I think I ever pointed it out to Lingshan before, that it's =
not needed to bother exposing those config space fields in "dev config show=
" output, if the only intent is for live migration of device features betwe=
en nodes. For vDPA live migration, what cares most is those configuration p=
arameters specified on vdpa creation, and userspace VMM (QEMU) is supposed =
to take care of saving and restoring live device states. I think it's easie=
r to extend "vdpa dev show" output to include device_features and other con=
fig params as well, rather than count on validity of various config space f=
ields.

Probably, but for the migration it's more about the ability of the
mgmtdev instead of the vDPA device itself I think.

>
> https://lore.kernel.org/virtualization/454bdf1b-daa1-aa67-2b8c-bc15351c18=
51@oracle.com/
>
> It's not just insufficient, but sometimes is incorrect to create vDPA dev=
ice using the config space fields.  For instance, MAC address in config spa=
ce can be changed temporarily (until device reset) via ctrl_vq VIRTIO_NET_C=
TRL_MAC_ADDR_SET command. It's incorrect to create vDPA using the MAC addre=
ss shown in the config space.

I think it's still a must for create the mac with the exact mac address:

1) VIRTIO_NET_F_CTRL_MAC is not a must
2) there's no way for us to know whether or not the mac has been changed
3) migration code can restore the mac during restore

So exactly the same mac address is still required. (This is the same
as we are doing for live migration on software virtio)

>  Another example, if the source vDPA device has MAC address table size li=
mit of 100, then in the destination we should pick parent device with size =
limit no smaller than that, and create vDPA on remote node matching the exa=
ct same size. There's nothing config space field can assist here.

Two ways:

1) mgmtdev should show the mac table size so mgmt layer can provision
the mac table size
2) If the mac table exceeds what is supported in the destination, it
needs to enable the all uni in this case.

>
> One example further, in the future, if we are going to introduce mandator=
y feature (for e.g. VERSION_1, RING_PACKED) that the device is unable to su=
pport the opposite case, the destination device should be created with equa=
lly same mandatory device features, which only vDPA creation parameters sho=
uld matter. While I can't think of a case that the mgmt software or live mi=
gration tool would have to count on config space fields only.

Yes, in this case we need to introduce new netlink attributes for both
getting mandatory features from the management device and provisioning
those manadating features.

>
>
>
>
> 1) provision vDPA device with all features that are supported by the
>     net simulator
>
> # vdpa dev add name dev1 mgmtdev vdpasim_net
> # vdpa dev config show
> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>    negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLA=
TFORM
>
> Maybe not in this patch, but for completeness for the whole series,
> could we also add device_features to the output?
>
> Lingshan, could you please share your thoughts or patch on this?
>
> Noted here the device_features argument specified during vdpa creation is=
 introduced by this series itself, it somehow slightly changed the original=
 semantics of what device_features used to be.
>
> I'm not sure I get this, we don't support device_features in the past
> and it is used to provision device features to the vDPA device which
> seems to be fine.
>
> Before this change, only look at the dev_features in "mgmtdev show" and r=
emember creation parameters is sufficient to get to all needed info for cre=
ating vDPA at destination.

Note that even with the same vendor, mgmtdev may support different features=
.

> After this change, dev_features in "mgmtdev show" becomes less relevant, =
as it would need to remember vdpa creation parameters plus the device_featu=
res attribute. While this series allows cross vendor live migration, it wou=
ld complicate the implementation of mgmt software, on the other hand.

To allow cross vendor live migration I couldn't find a better way.

>
>
>
> When simply look at the "vdpa dev config show" output, I cannot really
> tell the actual device_features that was used in vdpa creation. For e.g.
> there is a missing feature ANY_LAYOUT from negotiated_features compared
> with supported_features in mgmtdev, but the orchestration software
> couldn't tell if the vdpa device on destination host should be created
> with or without the ANY_LAYOUT feature.
>
> I think VERSION_1 implies ANY_LAYOUT.
>
> Right, ANY_LAYOUT is a bad example. A good example might be that, I knew =
the parent mgmtdev on migration source node supports CTRL_MAC_ADDR, but I d=
on't find it in negotiated_features.
>
> I think we should use the features that we got from "mgmtdev show"
> instead of "negotiated features".
>
> That was how it's supposed to work previously, but with this series, I th=
ink the newly introduced device_features will be needed instead of the one =
in "mgmtdev show".

Just to clarify, there won't be a device_features in mgmtdev show
since it is device specific, each individual device can have its own
device features which are subset of what is supported by the mgmtdev.

>
>
> On the migration destination node, the parent device does support all fea=
tures as the source offers, including CTRL_MAC_ADDR. What device features y=
ou would expect the mgmt software to create destination vdpa device with, i=
f not otherwise requiring mgmt software to remember all the arguments on de=
vice creation?

So the provisioning in the destination should use exactly the same
device_feautres as what the vdpa device has in the source. But before
this, management layer should guarantee to provision a vDPA device
whose device_features can be supported on the destination in order to
allow live migration.

>
> So in this example, we need use "dev_features" so we get exact the
> same features after and operation as either src or dst.
>
> If the device_features vDPA created with at the source doesn't include CT=
RL_MAC_ADDR even though parent supports it, then the vDPA to be created at =
the destination shouldn't come with CTRL_MAC_ADDR either, regardless of whe=
ther or not CTRL_MAC_ADDR is present in destination "mgmtdev show".
>
> However, if just taking look at negotiated_features, some mgmt software i=
mplementations which don't persist the creation parameters can't get the de=
vice features a certain vDPA device at the source node was created with.
>
>
> SOURCE# vdpa mgmtdev show
> vdpasim_net:
>    supported_classes net
>    max_supported_vqs 3
>    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS=
_PLATFORM
> SOURCE# vdpa dev config show
> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>    negotiated_features MTU MAC CTRL_VQ VERSION_1 ACCESS_PLATFORM
>
> DESTINATION# vdpa mgmtdev show
> vdpasim_net:
>    supported_classes net
>    max_supported_vqs 3
>    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS=
_PLATFORM
>
>  But it should be sufficient to
> use features_src & feature_dst in this case. Actually, it should work
> similar as to the cpu flags, the management software should introduce
> the concept of cluster which means the maximal set of common features
> is calculated and provisioned during device creation to allow
> migration among the nodes inside the cluster.
>
> Yes, this is one way mgmt software may implement, but I am not sure if it=
's the only way. For e.g. for cpu flags, mgmt software can infer the guest =
cpus features in use from all qemu command line arguments and host cpu feat=
ures/capability, which doesn't need to remember creation arguments and is e=
asy to recover from failure without having to make the VM config persistent=
 in data store. I thought it would be great if vdpa CLI design could offer =
the same.
>
> One minor difference is that we have cpu model abstraction, so we can
> have things like:
>
> ./qemu-system-x86_64 -cpu EPYC
>
> Which implies the cpu features/flags where vDPA doesn't have. But
> consider it's just a 64bit (or 128 in the future), it doesn't seems to
> be too complex for the management to know, we probably need to start
> from this and then we can try to introduce some generation/model after
> it is agreed on most of the vendors.
>
> What you refer to is the so-called named model for CPU flags. I think it'=
s a good addition to have some generation or named model defined for vDPA. =
But I don't get the point for how it relates to exposing the actual value o=
f device features? Are you saying in this case you'd rather expose the mode=
l name than the actual value of feature bits? Well, I think we can expose b=
oth in different fields when there's really such a need.

It's something like:

vdpa dev add name dev1 mgmtdev vdpasim_net device_features VDPA_NET_MODEL_1

and VDPA_NET_MODEL_1 implies some feature sets.

>
> BTW with regard to the cpu model in mgmt software implementation, the one=
 implemented in libvirt is a mixed "Host model" [1] with taking advantage o=
f QEMU named model and exposing additional individual CPU features that get=
s close to what host CPU offers.

So creating vDPA device without "device_features" is somehow the host
model, it will have all features that is supported by the parent.

> I think this implies that mgmt software should have to understand what th=
e model name really means in terms of individual CPU features, so having fe=
ature bit value exposed will just do more help if vDPA goes the same way.

Exactly.

Thanks

>
>
> Regards,
> -Siwei
>
> [1] https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html#two-w=
ays-to-configure-cpu-models-with-qemu-kvm
>
>
> Thanks
>
> Thanks,
> -Siwei
>
>
> Thanks
>
> Thanks,
> -Siwei
>
>
> 2) provision vDPA device with a subset of the features
>
> # vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
> # vdpa dev config show
> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>    negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>
> Reviewed-by: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index 886449e88502..a9ba02be378b 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev =
*mdev, const char *name,
>       dev_attr.work_fn =3D vdpasim_net_work;
>       dev_attr.buffer_size =3D PAGE_SIZE;
>
> +     if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> +             if (config->device_features &
> +                 ~dev_attr.supported_features)
> +                     return -EINVAL;
> +             dev_attr.supported_features &=3D
> +                      config->device_features;
> +     }
> +
>       simdev =3D vdpasim_create(&dev_attr);
>       if (IS_ERR(simdev))
>               return PTR_ERR(simdev);
> @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev =3D {
>       .id_table =3D id_table,
>       .ops =3D &vdpasim_net_mgmtdev_ops,
>       .config_attr_mask =3D (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> -                          1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> +                          1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> +                          1 << VDPA_ATTR_DEV_FEATURES),
>       .max_supported_vqs =3D VDPASIM_NET_VQ_NUM,
>       .supported_features =3D VDPASIM_NET_FEATURES,
>   };
>
>
>

