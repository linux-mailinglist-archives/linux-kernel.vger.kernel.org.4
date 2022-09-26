Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5629E5E9A42
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiIZHMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiIZHLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E111A3B7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664176283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rTr3KkpBeIzK/w5kOAdUeb2F4VLX4yhqW2U+MYMdpt4=;
        b=Tw8j6/eV+yXYxswkL161DP0WrB5McIt5dLoFn1hWZGf6ppfUyq5KdPligG2ee1nGYE7ttW
        RC6pjPd9w0Nypo9SFXp3fWbVpNVlE7ceAOsknukrDBKRbwoNtcv3cRd4kkCFF3KQ+2kntM
        dJTds2l+wx0xrFVwtCUKFsgIcJRiu+8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-qcXAULqKP6-PHcuWqjHJjw-1; Mon, 26 Sep 2022 03:11:22 -0400
X-MC-Unique: qcXAULqKP6-PHcuWqjHJjw-1
Received: by mail-oo1-f69.google.com with SMTP id w5-20020a4a3545000000b00475e491ac1eso2860556oog.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rTr3KkpBeIzK/w5kOAdUeb2F4VLX4yhqW2U+MYMdpt4=;
        b=xUAT7bFsyluSMFkr33JvXTxlyrZoIOU2EL+vGYsZQm0NleVtrMWIQVG+buw24T6tQ3
         hqXXPiu3zwoKkVw5gvyBxbofLeUX6lKtCaJsQZRygT48zfCdHiFFC+r8oUDkR/c5382V
         0d7Wwg6HvJ52esxVKnJyk2Aeba0HdTI/INrt3jS13ze+W0Ukclienb4KC3RjGuErtLLK
         XEJIh4JwbbFlVavOZGw36aIW79NSVwszb+ADpZ0jvplKX9a7pNqqBCVsGpIZuTH1KNN4
         E3UMe20Y+KnlDVKP8PznF0xtG8k4cIaB6CAhSj0idkd5TS01lCgn0KOrk+jb3u5Dve8V
         kgDg==
X-Gm-Message-State: ACrzQf0GX6Q8xJGFsWH0B3H/PsW5aadEv9kcviwrz8lqsBPGeBTdQHfG
        pLHeeJsQpCQBTfJ8JJpdBA+sSQhCSeiMDg2WFllr3LKR3r+xUzw9ftvahjPUXNAeIUxsYWAvlJO
        Wa0ibsw1zRR79vZYCOP2AgTtYAtFU096XZwUbT0E7
X-Received: by 2002:a05:6870:73cd:b0:12a:dff3:790a with SMTP id a13-20020a05687073cd00b0012adff3790amr17513964oan.35.1664176281414;
        Mon, 26 Sep 2022 00:11:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5cXS0akHljLMtgLGlvMqCBnKBPggdqK08akVV2C/fGuT5nl8vPIE4yZfA7Palpv36i9OMpJwxmvYF2lGND4EU=
X-Received: by 2002:a05:6870:73cd:b0:12a:dff3:790a with SMTP id
 a13-20020a05687073cd00b0012adff3790amr17513957oan.35.1664176281200; Mon, 26
 Sep 2022 00:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com> <20220922024305.1718-3-jasowang@redhat.com>
 <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com>
In-Reply-To: <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 26 Sep 2022 15:11:10 +0800
Message-ID: <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 9/21/2022 7:43 PM, Jason Wang wrote:
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
> >    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
> Sighs, not to blame any one and it's perhaps too late, but this
> "dev_features" attr in "mgmtdev show" command output should have been
> called "supported_features" in the first place.

Not sure I get this, but I guess this is the negotiated features actually.

I think Ling Shan is working on reporting both negotiated features
with the device features.

>
> >
> > 1) provision vDPA device with all features that are supported by the
> >     net simulator
> >
> > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >    negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
> Maybe not in this patch, but for completeness for the whole series,
> could we also add device_features to the output?

Lingshan, could you please share your thoughts or patch on this?

>
> When simply look at the "vdpa dev config show" output, I cannot really
> tell the actual device_features that was used in vdpa creation. For e.g.
> there is a missing feature ANY_LAYOUT from negotiated_features compared
> with supported_features in mgmtdev, but the orchestration software
> couldn't tell if the vdpa device on destination host should be created
> with or without the ANY_LAYOUT feature.

I think VERSION_1 implies ANY_LAYOUT. But it should be sufficient to
use features_src & feature_dst in this case. Actually, it should work
similar as to the cpu flags, the management software should introduce
the concept of cluster which means the maximal set of common features
is calculated and provisioned during device creation to allow
migration among the nodes inside the cluster.

Thanks

>
> Thanks,
> -Siwei
>
>
> >
> > 2) provision vDPA device with a subset of the features
> >
> > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
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
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > index 886449e88502..a9ba02be378b 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
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
> >   };
>

