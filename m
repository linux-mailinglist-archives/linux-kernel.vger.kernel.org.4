Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339A4653CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiLVIXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLVIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:23:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD210FF5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671697374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WftDM2ppb1Th2kSnxYZSwuQtzw9XbFi69TK/nOjnvPc=;
        b=KubpdDer5zR/s0XO+wQR6I4dyZq17I3A0J9vYc1rkV7LnFq4YWRycmAJUDHtUvyMmk/AIU
        h68HjwdSpbam5bAGLkymwd69qEeGGVq/w9J/0VSosl6RUNQs46v2QM96UEenb2YWfaYGJF
        L0HwFPqa39x5kv/a49DIrYof2Yh+u4o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-zP3hRxGcP2SH27LXEMPwLg-1; Thu, 22 Dec 2022 03:22:53 -0500
X-MC-Unique: zP3hRxGcP2SH27LXEMPwLg-1
Received: by mail-ed1-f70.google.com with SMTP id h18-20020a05640250d200b004758e655ebeso1019042edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WftDM2ppb1Th2kSnxYZSwuQtzw9XbFi69TK/nOjnvPc=;
        b=dNhm07J9ZcGMidtj691IgxPdRhN9ofln7CEpTFRxvXz47eHfhSiw0x2uJV9oWaDgJg
         JCeU1nVPuKpQFUVJrcZIFAxq+EtD/jiea8G9dCzVpmPDXyoXm6RcRsCM8RX+VUzleh8b
         FiiNwGexiPXXfwF2nitAXFzYUaimJ+a/teumG16p5hQ16+EsumQUyYsQ30x+JncHTC5A
         Y0UYQ8g5ZMu/7MyscQV9gHwbLmcY/wirumTsyBXPI8daUk3ZbSIeN3Pk5pQy01egXqTt
         xkliEl/QZKX1J9QmKCIgyXWdoDCqVhth7nyaLbtchJI2UEMkLFl09LdF8SiiPvPGHGjD
         RP4g==
X-Gm-Message-State: AFqh2ko9jwsynsdromhu1c6EvxASW846mndPdkAh66AVG+Rw0/AeeHx3
        QO1Mwl6EdSwCOXJPUmi7w2LZKIFakcAINGy81tzJnCUCnG84pxUl/Oe8DPMOiWuFVGAymgAG+tN
        7IuaR+v3I0I0CnakPEd6usLrxuOaW+A20uK6APMeD
X-Received: by 2002:a17:906:d7b8:b0:7c1:2ce5:4d59 with SMTP id pk24-20020a170906d7b800b007c12ce54d59mr337645ejb.248.1671697371605;
        Thu, 22 Dec 2022 00:22:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtaqksoDTQcISVwWbWI5Z2gXm2iMdsK1JKpK38V920z4BJGVlLSTmskX9fSYGb6Mb8UAV4VxbeWiI6xq49FCAg=
X-Received: by 2002:a17:906:d7b8:b0:7c1:2ce5:4d59 with SMTP id
 pk24-20020a170906d7b800b007c12ce54d59mr337641ejb.248.1671697371399; Thu, 22
 Dec 2022 00:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20221222050052.20785-1-jasowang@redhat.com> <20221222050052.20785-3-jasowang@redhat.com>
In-Reply-To: <20221222050052.20785-3-jasowang@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 22 Dec 2022 09:22:14 +0100
Message-ID: <CAJaqyWemV8aC=MRsu_h-WuRw8bquMZnBPNGONaJ6Nz_sGNWxCg@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] vdpasim: customize allocation size
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 6:01 AM Jason Wang <jasowang@redhat.com> wrote:
>
> Allow individual simulator to customize the allocation size.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 8 ++++++--
>  drivers/vdpa/vdpa_sim/vdpa_sim.h     | 1 +
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 1 +
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 1 +
>  4 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 757afef86ba0..55aaa023a6e2 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -253,7 +253,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>         struct vdpa_device *vdpa;
>         struct vdpasim *vdpasim;
>         struct device *dev;
> -       int i, ret = -ENOMEM;
> +       int i, ret = -EINVAL;
> +
> +       if (!dev_attr->alloc_size)
> +               goto err_alloc;

It's weird that we need an error goto here and the next chunk of code
may return ERR_PTR(-EINVAL) directly. It's better to return directly
here in my opinion.

>
>         if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>                 if (config->device_features &
> @@ -268,9 +271,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>         else
>                 ops = &vdpasim_config_ops;
>
> +       ret = -ENOMEM;

Nitpicking again,

To set ret = -ENOMEM here is weird to me, since the next failure on
__vdpa_alloc_device will override it. I'd set it right before
dma_set_mask_and_coherent, closer to its actual usage.

Actually, I'd propagate dma_set_mask_and_coherent error and set ret =
-ENOMEM right before *alloc functions, but it wasn't done that way
before this series, so not a reason to NAK to me.

Thanks!

>         vdpa = __vdpa_alloc_device(NULL, ops,
>                                    dev_attr->ngroups, dev_attr->nas,
> -                                  sizeof(struct vdpasim),
> +                                  dev_attr->alloc_size,
>                                    dev_attr->name, false);
>         if (IS_ERR(vdpa)) {
>                 ret = PTR_ERR(vdpa);
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index 0e78737dcc16..51c070a543f1 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -37,6 +37,7 @@ struct vdpasim_dev_attr {
>         struct vdpa_mgmt_dev *mgmt_dev;
>         const char *name;
>         u64 supported_features;
> +       size_t alloc_size;
>         size_t config_size;
>         size_t buffer_size;
>         int nvqs;
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index c6db1a1baf76..4f7c35f59aa5 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -378,6 +378,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>         dev_attr.nvqs = VDPASIM_BLK_VQ_NUM;
>         dev_attr.ngroups = VDPASIM_BLK_GROUP_NUM;
>         dev_attr.nas = VDPASIM_BLK_AS_NUM;
> +       dev_attr.alloc_size = sizeof(struct vdpasim);
>         dev_attr.config_size = sizeof(struct virtio_blk_config);
>         dev_attr.get_config = vdpasim_blk_get_config;
>         dev_attr.work_fn = vdpasim_blk_work;
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index c3cb225ea469..20cd5cdff919 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -249,6 +249,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>         dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
>         dev_attr.ngroups = VDPASIM_NET_GROUP_NUM;
>         dev_attr.nas = VDPASIM_NET_AS_NUM;
> +       dev_attr.alloc_size = sizeof(struct vdpasim);
>         dev_attr.config_size = sizeof(struct virtio_net_config);
>         dev_attr.get_config = vdpasim_net_get_config;
>         dev_attr.work_fn = vdpasim_net_work;
> --
> 2.25.1
>

