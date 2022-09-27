Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3895EB91F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 06:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiI0EHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 00:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiI0EH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 00:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B480CA2207
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664251644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qcLBCLM+PH8ycKWx1k07/7s89oEdWy95TuEbp0KpqhA=;
        b=JYk9Yd9d6/AEj2GbBqlGE5GFHuPWBrVJJYmaT8bzc5gYXCCfioDxbNvmhAxQIsHZ7RiJ2T
        Yj+Atgtxn8T6vHpwQu0zbvNodm0yVh6qLuHFMPpTlAwpFjdHMHA3nQ3q3NFx08z85Z+wtW
        zN59671Xh4HNAnDBfBt1pHayplO3Ip8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-461-y5AWby3sM-u8neNpqTN8fQ-1; Tue, 27 Sep 2022 00:07:18 -0400
X-MC-Unique: y5AWby3sM-u8neNpqTN8fQ-1
Received: by mail-oi1-f200.google.com with SMTP id a26-20020aca1a1a000000b0034fdf34de68so2787880oia.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qcLBCLM+PH8ycKWx1k07/7s89oEdWy95TuEbp0KpqhA=;
        b=xTLVl7S7kzjYrgkHyZZypihWC8M9HG9QZkrAz4gu/gT0p68VTJ3xxTn3fU/sffH9G0
         XAsvHwj5mnzjGVaLhPqdgHEdU8Fbp2MvwJ6dqgi68siMtIDD4//8B29+bQKWmPXM6KBh
         yP3pDUgyMXlgs0EE5YdJzH97rTJ0+GSNsXkBDY5SMut+21yN1xeD2IvU9kJ/ssMoynib
         K5NXy1h5HaoSza+43BWDbCeNiG7YBwp12PjR5xUQQNK0sC9v+yj03CKCZbFcGIlY9weR
         phrz8n+XprsCeA8sC/Yx7VIxO/26yp/PGGPxYtuTp6d0xE3ZMxCFq+rsJ5YZilA+NxNs
         +GHw==
X-Gm-Message-State: ACrzQf1j7+Mv39tNy9zy2ygMKkxTJ+uhywLZB9EtXQ++5Em+veonYfIC
        xxCIjT++Bb1zdbsPgHzHs9RaKceF5WU3tbgKeFZ7PD2CnYKZ42dYTuvspNBYgNvcWRAePxUFnmM
        TipTGuxx8qS6j1b5EHPGBO0yfgEdex1Pe2vj2kUC1
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id y4-20020a056808130400b00350649bf8a1mr895310oiv.280.1664251637623;
        Mon, 26 Sep 2022 21:07:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4QxXyHj924wjaBEB7J29sMV1LhennrHiDY3BAsK2SHC05C6DnICL3Vj/1TwCJGn69NBgD2UzusGqwUyLj6jxw=
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id
 y4-20020a056808130400b00350649bf8a1mr895301oiv.280.1664251637343; Mon, 26 Sep
 2022 21:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com> <20220922024305.1718-3-jasowang@redhat.com>
 <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com> <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
 <afe960d3-730a-b52c-e084-40bf080b27fa@oracle.com> <CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com>
In-Reply-To: <CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 27 Sep 2022 12:07:06 +0800
Message-ID: <CACGkMEuQHV-pECAPy3EozDE20Gdeh6QjaBvu6u0djeL3PZT2NA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 11:59 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Sep 27, 2022 at 9:02 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >
> >
> >
> > On 9/26/2022 12:11 AM, Jason Wang wrote:
> >
> > On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu <si-wei.liu@oracle.com> wrot=
e:
> >
> >
> > On 9/21/2022 7:43 PM, Jason Wang wrote:
> >
> > This patch implements features provisioning for vdpa_sim_net.
> >
> > 1) validating the provisioned features to be a subset of the parent
> >     features.
> > 2) clearing the features that is not wanted by the userspace
> >
> > For example:
> >
> > # vdpa mgmtdev show
> > vdpasim_net:
> >    supported_classes net
> >    max_supported_vqs 3
> >    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCE=
SS_PLATFORM
> >
> > Sighs, not to blame any one and it's perhaps too late, but this
> > "dev_features" attr in "mgmtdev show" command output should have been
> > called "supported_features" in the first place.
> >
> > Not sure I get this, but I guess this is the negotiated features actual=
ly.
> >
> > Actually no, that is why I said the name is a bit confusing and "suppor=
ted_features" might sound better.
>
> You're right, it's an mgmtdev show actually.
>
> >This attribute in the parent device (mgmtdev) denotes the real device ca=
pability for what virtio features can be supported by the parent device. An=
y unprivileged user can check into this field to know parent device's capab=
ility without having to create a child vDPA device at all. The features tha=
t child vDPA device may support should be a subset of, or at most up to wha=
t the parent device offers. For e.g. the vdpa device dev1 you created below=
 can expose less or equal device_features bit than 0x308820028 (MTU MAC CTR=
L_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM), but shouldn't be =
no more than what the parent device can actually support.
>
> Yes, I didn't see anything wrong with "dev_features", it aligns to the
> virtio spec which means the features could be used to create a vdpa
> device. But if everyone agree on the renaming, I'm fine.
>
> >
> >
> > I think Ling Shan is working on reporting both negotiated features
> > with the device features.
> >
> > Does it imply this series is connected to another work in parallel? Is =
it possible to add a reference in the cover letter?
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

Ok, Lingshan post an example here:

https://lore.kernel.org/netdev/20220927025035.4972-2-lingshan.zhu@intel.com=
/T/#u

Thanks

>
> >
> >
> > 1) provision vDPA device with all features that are supported by the
> >     net simulator
> >
> > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >    negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_P=
LATFORM
> >
> > Maybe not in this patch, but for completeness for the whole series,
> > could we also add device_features to the output?
> >
> > Lingshan, could you please share your thoughts or patch on this?
> >
> > Noted here the device_features argument specified during vdpa creation =
is introduced by this series itself, it somehow slightly changed the origin=
al semantics of what device_features used to be.
>
> I'm not sure I get this, we don't support device_features in the past
> and it is used to provision device features to the vDPA device which
> seems to be fine.
>
> >
> >
> > When simply look at the "vdpa dev config show" output, I cannot really
> > tell the actual device_features that was used in vdpa creation. For e.g=
.
> > there is a missing feature ANY_LAYOUT from negotiated_features compared
> > with supported_features in mgmtdev, but the orchestration software
> > couldn't tell if the vdpa device on destination host should be created
> > with or without the ANY_LAYOUT feature.
> >
> > I think VERSION_1 implies ANY_LAYOUT.
> >
> > Right, ANY_LAYOUT is a bad example. A good example might be that, I kne=
w the parent mgmtdev on migration source node supports CTRL_MAC_ADDR, but I=
 don't find it in negotiated_features.
>
> I think we should use the features that we got from "mgmtdev show"
> instead of "negotiated features".
>
> >On the migration destination node, the parent device does support all fe=
atures as the source offers, including CTRL_MAC_ADDR. What device features =
you would expect the mgmt software to create destination vdpa device with, =
if not otherwise requiring mgmt software to remember all the arguments on d=
evice creation?
>
> So in this example, we need use "dev_features" so we get exact the
> same features after and operation as either src or dst.
>
> >
> > SOURCE# vdpa mgmtdev show
> > vdpasim_net:
> >    supported_classes net
> >    max_supported_vqs 3
> >    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCE=
SS_PLATFORM
> > SOURCE# vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >    negotiated_features MTU MAC CTRL_VQ VERSION_1 ACCESS_PLATFORM
> >
> > DESTINATION# vdpa mgmtdev show
> > vdpasim_net:
> >    supported_classes net
> >    max_supported_vqs 3
> >    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCE=
SS_PLATFORM
> >
> >  But it should be sufficient to
> > use features_src & feature_dst in this case. Actually, it should work
> > similar as to the cpu flags, the management software should introduce
> > the concept of cluster which means the maximal set of common features
> > is calculated and provisioned during device creation to allow
> > migration among the nodes inside the cluster.
> >
> > Yes, this is one way mgmt software may implement, but I am not sure if =
it's the only way. For e.g. for cpu flags, mgmt software can infer the gues=
t cpus features in use from all qemu command line arguments and host cpu fe=
atures/capability, which doesn't need to remember creation arguments and is=
 easy to recover from failure without having to make the VM config persiste=
nt in data store. I thought it would be great if vdpa CLI design could offe=
r the same.
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
> Thanks
>
> >
> > Thanks,
> > -Siwei
> >
> >
> > Thanks
> >
> > Thanks,
> > -Siwei
> >
> >
> > 2) provision vDPA device with a subset of the features
> >
> > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x30002000=
0
> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >    negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> >
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >   drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_s=
im/vdpa_sim_net.c
> > index 886449e88502..a9ba02be378b 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_de=
v *mdev, const char *name,
> >       dev_attr.work_fn =3D vdpasim_net_work;
> >       dev_attr.buffer_size =3D PAGE_SIZE;
> >
> > +     if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > +             if (config->device_features &
> > +                 ~dev_attr.supported_features)
> > +                     return -EINVAL;
> > +             dev_attr.supported_features &=3D
> > +                      config->device_features;
> > +     }
> > +
> >       simdev =3D vdpasim_create(&dev_attr);
> >       if (IS_ERR(simdev))
> >               return PTR_ERR(simdev);
> > @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev =3D {
> >       .id_table =3D id_table,
> >       .ops =3D &vdpasim_net_mgmtdev_ops,
> >       .config_attr_mask =3D (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> > -                          1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> > +                          1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> > +                          1 << VDPA_ATTR_DEV_FEATURES),
> >       .max_supported_vqs =3D VDPASIM_NET_VQ_NUM,
> >       .supported_features =3D VDPASIM_NET_FEATURES,
> >   };
> >
> >

