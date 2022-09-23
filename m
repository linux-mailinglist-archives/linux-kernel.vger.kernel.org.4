Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1B5E72CA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiIWEU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiIWEU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDD0C88AF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 21:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663906825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zEIeJ9KcUC7PEIn7+/HEyTDs3dhCwcqq5MBHBVNCbfg=;
        b=LcACmQYH/SwFP5MmsDUeO7jBowTlA2U0D+YYJXA9JFDYqf4UZjefNyPhPxvTweYS0hYIvN
        1uDIUvUHzbD4nfrohmO9T1ONWHXWnhPnSavL41lAWzsfGoSYG1449U3bIGV/lyOkco7MBa
        6Mw1x7tOtdDFAwHncjv0PD9ofoavO30=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-172-MbPDf6RUM_2he-1mKK2KQg-1; Fri, 23 Sep 2022 00:20:24 -0400
X-MC-Unique: MbPDf6RUM_2he-1mKK2KQg-1
Received: by mail-oi1-f198.google.com with SMTP id h133-20020aca3a8b000000b00350c126bf48so5504949oia.23
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 21:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zEIeJ9KcUC7PEIn7+/HEyTDs3dhCwcqq5MBHBVNCbfg=;
        b=NTX+D65IUumHiYbnoOFsqpX4H57xdNVRpW6SFbqrlxDLwRlG+UnPW/8XFL4zoMnqcj
         HUAN3K4EGkDFGfSr0qxVMX8NNQ4kQj/VshgxZU1JY4oLw2t44LysnBzbAWGBtB/eNQi2
         TE/+nz+3oCZbxboSYSBi+wmGD2NGMnkqkDAMwdDUT573X2Pl1koKWGwED3FtVMyD6pJH
         Q7Rc0PCoPYvt2KY8xQfTB2x5eAGoNd2ExV3BXcfR1hvLQlltgSMPxMXeWzOaHbeD1Lkn
         fj2v8H/mDISbxO4p7vP0B38TvihwDirFs5jKTgohYh9MzmIHGeMol3W61tEYHPe/5f9+
         NLyQ==
X-Gm-Message-State: ACrzQf16+CzJY739iKE0kYhpqUsF5qae31a3OBS9RlhRacLRASn40HPw
        3FCONdfMHm2p20c209GpSTD3v2xWcIo/gkFEj/VkE9CdPTLueyC6t0j1/kWa8TzzG6J1xauiazR
        sJbw3Bfsx84ZTpikVPIluf3L1/jEZpVKotd6nzWwT
X-Received: by 2002:a9d:7d04:0:b0:655:ad62:6dbe with SMTP id v4-20020a9d7d04000000b00655ad626dbemr3124987otn.201.1663906823531;
        Thu, 22 Sep 2022 21:20:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4sPLwXUi8ibB7BZqlkpwkitSjs4HLpoSlg485F4FQ5/fubdhcQ+EnMMPtKZctGyxWmESRtFxJlI8lt9D3B+kI=
X-Received: by 2002:a9d:7d04:0:b0:655:ad62:6dbe with SMTP id
 v4-20020a9d7d04000000b00655ad626dbemr3124973otn.201.1663906823313; Thu, 22
 Sep 2022 21:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com> <20220922024305.1718-3-jasowang@redhat.com>
 <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 23 Sep 2022 12:20:12 +0800
Message-ID: <CACGkMEvRL3iN8iAP_1dZXLfOhRKv4573DYK6=C9gwME-85=03Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
To:     Eli Cohen <elic@nvidia.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>,
        "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "gdawar@xilinx.com" <gdawar@xilinx.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 1:14 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, 22 September 2022 5:43
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > lulu@redhat.com; xieyongji@bytedance.com
> > Subject: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> >
> > This patch implements features provisioning for vdpa_sim_net.
> >
> > 1) validating the provisioned features to be a subset of the parent
> >    features.
> > 2) clearing the features that is not wanted by the userspace
> >
> > For example:
> >
> > # vdpa mgmtdev show
> > vdpasim_net:
> >   supported_classes net
> >   max_supported_vqs 3
> >   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
> > VERSION_1 ACCESS_PLATFORM
> >
> > 1) provision vDPA device with all features that are supported by the
> >    net simulator
> >
> > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >   negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1
> > ACCESS_PLATFORM
> >
> > 2) provision vDPA device with a subset of the features
> >
> > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features
> > 0x300020000
>
> How about "features_mask" instead of "device_features"? Could avoid confusion.

It's device_feautres not a mask (the kernel code is probably confusing
per Michael's comment), so I tend to tweak the kernel code and keep
the name.

Thanks

>
> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> >
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > index 886449e88502..a9ba02be378b 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > vdpa_mgmt_dev *mdev, const char *name,
> >       dev_attr.work_fn = vdpasim_net_work;
> >       dev_attr.buffer_size = PAGE_SIZE;
> >
> > +     if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > +             if (config->device_features &
> > +                 ~dev_attr.supported_features)
> > +                     return -EINVAL;
> > +             dev_attr.supported_features &=
> > +                      config->device_features;
> > +     }
> > +
> >       simdev = vdpasim_create(&dev_attr);
> >       if (IS_ERR(simdev))
> >               return PTR_ERR(simdev);
> > @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> >       .id_table = id_table,
> >       .ops = &vdpasim_net_mgmtdev_ops,
> >       .config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> > -                          1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> > +                          1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> > +                          1 << VDPA_ATTR_DEV_FEATURES),
> >       .max_supported_vqs = VDPASIM_NET_VQ_NUM,
> >       .supported_features = VDPASIM_NET_FEATURES,
> >  };
> > --
> > 2.25.1
>

