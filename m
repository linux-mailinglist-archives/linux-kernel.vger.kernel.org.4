Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FC25E72C4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiIWER1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiIWERY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FF9EBD61
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 21:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663906642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=92zMdR2dAGB3Is6NLBt9+wywGF1FY710JpEgke8Qr/Q=;
        b=WtF7nPfHZtvobotpoCHM3sCQI2fcHZAe7gPT8O43Z7Y5P+WKPsP+dOs4o1Sq7j1hXkfGr3
        BWF/ClzOaMsAJht3j/mj8uhB5GrJMQkjM6PGBnWOjtJek0L3goyb6ZDZ8rGFbDEHu+JT5d
        TnhKHc0a6Mmai66e3nOOrXch28K9x9g=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-DsVGI-QLMzSZDDKUsesHKQ-1; Fri, 23 Sep 2022 00:17:20 -0400
X-MC-Unique: DsVGI-QLMzSZDDKUsesHKQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-12dbfae38b0so1510847fac.16
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 21:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=92zMdR2dAGB3Is6NLBt9+wywGF1FY710JpEgke8Qr/Q=;
        b=NKxIyfu/OeKS+lCsNhInSXx/panRatHc5+fgxtpClJBfHyglAh6OvHUEH8S7gkck3Z
         KLQUTyi9mLfbz2CmsyK5KhWCQHVewHgWtUBz5GX2hOS/ENCg3noQLNgTwD+pMTanOUOd
         eGlXlFttln6xleYpvRza7/12ej/RGA0aa8dpYq2IqytEblJOccc3NswHwTypzc6nKoGY
         2hrOzsDSdLgwA+8n4mw60Yspx8tFK9WH5q29FUPByDiBPUAIDDaLBBjf2geupXRaa8zo
         1TcPa4KzxbGIRPRFE5DhA/h4h8fFl5770YBD9PPHFQV1Vsjvo6zB7QIqhC4cCqqHIoNw
         s81w==
X-Gm-Message-State: ACrzQf0qZ0MsP5bnj7d4IgsuvfnBzwwgZH8ODYyZWQiQRSsCLMsJuKSH
        U/lvbKksAF3dbdW20LONVIzOG0dj61wjFA21s+08XU3dK56VBWPhApBSJoy3wTLRkKWCPr3xoKg
        XVlaoxcNua4oiPe8Dp+oflwryqXSDAG5xbzMxL0bD
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id bx34-20020a0568081b2200b00350c0f670ffmr7847599oib.35.1663906639914;
        Thu, 22 Sep 2022 21:17:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6XholEdJ/1SqvGLYW89uFGiquRiCe67tSU4smswurScWGy3lq5RTP2Q8QWBr0p8a9Ed18p3x9lLYDzhSSfZHg=
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr7847585oib.35.1663906639727; Thu, 22
 Sep 2022 21:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com> <20220922024305.1718-3-jasowang@redhat.com>
 <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922032858-mutt-send-email-mst@kernel.org> <DM8PR12MB5400D6550D2253E9964260F8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922035028-mutt-send-email-mst@kernel.org> <DM8PR12MB5400EC129B7A2B0D86EE72F2AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922050639-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220922050639-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 23 Sep 2022 12:17:08 +0800
Message-ID: <CACGkMEvaP+Mev8rZbv9b_DR_brqFupBR85kPuvd2Y8k==srL0A@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>,
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

On Thu, Sep 22, 2022 at 5:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 22, 2022 at 08:01:23AM +0000, Eli Cohen wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, 22 September 2022 10:53
> > > To: Eli Cohen <elic@nvidia.com>
> > > Cc: Jason Wang <jasowang@redhat.com>; si-wei.liu@oracle.com; Parav
> > > Pandit <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > > lulu@redhat.com; xieyongji@bytedance.com
> > > Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > >
> > > On Thu, Sep 22, 2022 at 07:47:40AM +0000, Eli Cohen wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Thursday, 22 September 2022 10:30
> > > > > To: Eli Cohen <elic@nvidia.com>
> > > > > Cc: Jason Wang <jasowang@redhat.com>; si-wei.liu@oracle.com; Parav
> > > > > Pandit <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > > > > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > > > > lulu@redhat.com; xieyongji@bytedance.com
> > > > > Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > > > >
> > > > > On Thu, Sep 22, 2022 at 05:13:59AM +0000, Eli Cohen wrote:
> > > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > > Sent: Thursday, 22 September 2022 5:43
> > > > > > > To: mst@redhat.com; jasowang@redhat.com
> > > > > > > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > > > > > > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > > > > > > virtualization@lists.linux-foundation.org; linux-
> > > kernel@vger.kernel.org;
> > > > > > > eperezma@redhat.com; lingshan.zhu@intel.com;
> > > gdawar@xilinx.com;
> > > > > > > lulu@redhat.com; xieyongji@bytedance.com
> > > > > > > Subject: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > > > > > >
> > > > > > > This patch implements features provisioning for vdpa_sim_net.
> > > > > > >
> > > > > > > 1) validating the provisioned features to be a subset of the parent
> > > > > > >    features.
> > > > > > > 2) clearing the features that is not wanted by the userspace
> > > > > > >
> > > > > > > For example:
> > > > > > >
> > > > > > > # vdpa mgmtdev show
> > > > > > > vdpasim_net:
> > > > > > >   supported_classes net
> > > > > > >   max_supported_vqs 3
> > > > > > >   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
> > > > > > > VERSION_1 ACCESS_PLATFORM
> > > > > > >
> > > > > > > 1) provision vDPA device with all features that are supported by the
> > > > > > >    net simulator
> > > > > > >
> > > > > > > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > > > > > > # vdpa dev config show
> > > > > > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > > > > > >   negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR
> > > VERSION_1
> > > > > > > ACCESS_PLATFORM
> > > > > > >
> > > > > > > 2) provision vDPA device with a subset of the features
> > > > > > >
> > > > > > > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features
> > > > > > > 0x300020000
> > > > > >
> > > > > > How about "features_mask" instead of "device_features"? Could avoid
> > > > > confusion.
> > > > >
> > > > > Not sure I agree.
> > > > > features_mask to me would mean it is & with features. Not the case here.
> > > > >
> > > >
> > > >
> > > > See the code below
> > > >
> > > > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > > vdpa_mgmt_dev *mdev, const char *name,
> > > >   dev_attr.work_fn = vdpasim_net_work;
> > > >   dev_attr.buffer_size = PAGE_SIZE;
> > > >
> > > > + if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > > > +         if (config->device_features &
> > > > +             ~dev_attr.supported_features)
> > > > +                 return -EINVAL;
> > > > +         dev_attr.supported_features &=
> > > > +                  config->device_features;
> > > > + }
> > > > +
> > >
> > > Oh I didn't notice. It's unnecessary, isn't it?
> > > Can just equivalently be
> > >
> > >     dev_attr.supported_features = config->device_features;
> > >
> > > right?
> > >
> >
> > I don't think so. You want to mask the set of features that the device will offer but you cannot dictate it.
>
> Sure, but it's already a given because device_features is a subset of
> supported_features. Observe:
>
> After this line:
>
>          if (config->device_features &
>             ~dev_attr.supported_features)
>                 return -EINVAL;
>
> we know that config->device_features & ~dev_attr.supported_features
> is 0.
>
> Therefore logically
>
> config->device_features  ==
>     (config->device_features & ~dev_attr.supported_features) |
>     (config->device_features & dev_attr.supported_features);
>
> it follows that
>
> config->device_features  ==
>     0 |
>     (config->device_features & dev_attr.supported_features);
>
> and finally
>
> config->device_features  ==
>     (config->device_features & dev_attr.supported_features);
>
>
> now
>
>                 dev_attr.supported_features &=
>                          config->device_features;
>
> is equivalent to
>
>                 dev_attr.supported_features =
>     (config->device_features & dev_attr.supported_features);
>
> and therefore to
>
>                 dev_attr.supported_features = config->device_features;

Yes, let me do that in the next version.

Thanks

>
>
>
> > >
> > > > > > > # vdpa dev config show
> > > > > > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > > > > > >   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> > > > > > >
> > > > > > > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> > > > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > > b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > > index 886449e88502..a9ba02be378b 100644
> > > > > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > > > > > > vdpa_mgmt_dev *mdev, const char *name,
> > > > > > >     dev_attr.work_fn = vdpasim_net_work;
> > > > > > >     dev_attr.buffer_size = PAGE_SIZE;
> > > > > > >
> > > > > > > +   if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > > > > > > +           if (config->device_features &
> > > > > > > +               ~dev_attr.supported_features)
> > > > > > > +                   return -EINVAL;
> > > > > > > +           dev_attr.supported_features &=
> > > > > > > +                    config->device_features;
> > > > > > > +   }
> > > > > > > +
> > > > > > >     simdev = vdpasim_create(&dev_attr);
> > > > > > >     if (IS_ERR(simdev))
> > > > > > >             return PTR_ERR(simdev);
> > > > > > > @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> > > > > > >     .id_table = id_table,
> > > > > > >     .ops = &vdpasim_net_mgmtdev_ops,
> > > > > > >     .config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> > > > > > > -                        1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> > > > > > > +                        1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> > > > > > > +                        1 << VDPA_ATTR_DEV_FEATURES),
> > > > > > >     .max_supported_vqs = VDPASIM_NET_VQ_NUM,
> > > > > > >     .supported_features = VDPASIM_NET_FEATURES,
> > > > > > >  };
> > > > > > > --
> > > > > > > 2.25.1
> > > > > >
> > > >
> >
>

