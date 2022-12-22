Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A49653D27
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiLVIuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiLVIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:49:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E9365DB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671698945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=24SjBaC5+R1bpPX2KbnsN80A77tDgarL7SjF1z9c+4g=;
        b=PWHG8huAoQxObSVz5YI6FP0FG08MkNxUP6iP1iLjmXJmtjNcrrVb9YdWAWvumXe+1lcTzn
        tmJrBe6Ts6UntayfBj3CwlDxdAPwRVTGd9hKLKuTiLq89GQj79Kge3wAY5Bx4WP4yuSjiK
        IdbrhJ6ulwWmKFwgJ92P8XAr1QvtzdY=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-jiOJ_zknPwSSReV0zQAMSg-1; Thu, 22 Dec 2022 03:49:04 -0500
X-MC-Unique: jiOJ_zknPwSSReV0zQAMSg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-14c958c18b5so763216fac.23
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24SjBaC5+R1bpPX2KbnsN80A77tDgarL7SjF1z9c+4g=;
        b=kWGWktiwHd+LyUKCFAel1JQ8NAQ6h3aWboDu6EnRcO7HWbhX4jN4EKmC+g5mDDTJTw
         MjVHZVjAhqUZH7ybkr7mOOIqhBFCRUVrJzFYWEyoq+XA7suMYkMaI1PxixGTTSwCl1wY
         218gMoHeo+Hx9OstLsQa7JBvTY3qFqp7CBl32FCdopsc4SrpARTs+MMCuW/pSy+B6ViY
         gw2FK9E9+WyanhjZ6pUOOq9KaU5Kw8hkKnMZnZ4OA4Z0tI/RevwUEDTvwnt/Ara5qcQ+
         kc/BXCAWJyAMpAscsWuju5RGgxPKP/b/13NOU7k8jineqNB/RlJR/tRWVb9wIbPZB+S7
         rEVw==
X-Gm-Message-State: AFqh2ko9kmMkdNDhznlhuAJ077LhFcskBLy/ZWa4hUsNep+7/7TN0HVW
        22iMKssfHhwwTFnVMTe9lvnuWcjW4KRFvjhgy+nrfjcqHMdU3NEUebsHj6ByGb3Z9fVMeqMj39v
        Q6d9pqqROTEiaUBvk6mfO8ptpcVJ9lCOHNYBVQ3z4
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id c3-20020a9d7843000000b006781eb43406mr304630otm.237.1671698943035;
        Thu, 22 Dec 2022 00:49:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt0H5B2HRjAEKwQUonOjILxfVzsdchrDFOD71wfmyaYt+sSyUF6J4vJ1zUzneqGhd1C8v/KJpc7Wod7GEWcGCI=
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id
 c3-20020a9d7843000000b006781eb43406mr304627otm.237.1671698942833; Thu, 22 Dec
 2022 00:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20221222050052.20785-1-jasowang@redhat.com> <20221222050052.20785-3-jasowang@redhat.com>
 <CAJaqyWemV8aC=MRsu_h-WuRw8bquMZnBPNGONaJ6Nz_sGNWxCg@mail.gmail.com>
In-Reply-To: <CAJaqyWemV8aC=MRsu_h-WuRw8bquMZnBPNGONaJ6Nz_sGNWxCg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 22 Dec 2022 16:48:51 +0800
Message-ID: <CACGkMEt-VHmKVkwH=KzFuzUsg0AkT_0zLPnTfMrmR2cu2qvrcw@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] vdpasim: customize allocation size
To:     Eugenio Perez Martin <eperezma@redhat.com>
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

On Thu, Dec 22, 2022 at 4:22 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Dec 22, 2022 at 6:01 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > Allow individual simulator to customize the allocation size.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 8 ++++++--
> >  drivers/vdpa/vdpa_sim/vdpa_sim.h     | 1 +
> >  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 1 +
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 1 +
> >  4 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > index 757afef86ba0..55aaa023a6e2 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -253,7 +253,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >         struct vdpa_device *vdpa;
> >         struct vdpasim *vdpasim;
> >         struct device *dev;
> > -       int i, ret = -ENOMEM;
> > +       int i, ret = -EINVAL;
> > +
> > +       if (!dev_attr->alloc_size)
> > +               goto err_alloc;
>
> It's weird that we need an error goto here and the next chunk of code
> may return ERR_PTR(-EINVAL) directly. It's better to return directly
> here in my opinion.

Right, let me fix it.

>
> >
> >         if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> >                 if (config->device_features &
> > @@ -268,9 +271,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >         else
> >                 ops = &vdpasim_config_ops;
> >
> > +       ret = -ENOMEM;
>
> Nitpicking again,
>
> To set ret = -ENOMEM here is weird to me, since the next failure on
> __vdpa_alloc_device will override it. I'd set it right before
> dma_set_mask_and_coherent, closer to its actual usage.

Yes.

>
> Actually, I'd propagate dma_set_mask_and_coherent error and set ret =
> -ENOMEM right before *alloc functions, but it wasn't done that way
> before this series, so not a reason to NAK to me.

Yes and I think this needs a separate fix.

Thanks

>
> Thanks!
>
> >         vdpa = __vdpa_alloc_device(NULL, ops,
> >                                    dev_attr->ngroups, dev_attr->nas,
> > -                                  sizeof(struct vdpasim),
> > +                                  dev_attr->alloc_size,
> >                                    dev_attr->name, false);
> >         if (IS_ERR(vdpa)) {
> >                 ret = PTR_ERR(vdpa);
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > index 0e78737dcc16..51c070a543f1 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > @@ -37,6 +37,7 @@ struct vdpasim_dev_attr {
> >         struct vdpa_mgmt_dev *mgmt_dev;
> >         const char *name;
> >         u64 supported_features;
> > +       size_t alloc_size;
> >         size_t config_size;
> >         size_t buffer_size;
> >         int nvqs;
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > index c6db1a1baf76..4f7c35f59aa5 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > @@ -378,6 +378,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> >         dev_attr.nvqs = VDPASIM_BLK_VQ_NUM;
> >         dev_attr.ngroups = VDPASIM_BLK_GROUP_NUM;
> >         dev_attr.nas = VDPASIM_BLK_AS_NUM;
> > +       dev_attr.alloc_size = sizeof(struct vdpasim);
> >         dev_attr.config_size = sizeof(struct virtio_blk_config);
> >         dev_attr.get_config = vdpasim_blk_get_config;
> >         dev_attr.work_fn = vdpasim_blk_work;
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > index c3cb225ea469..20cd5cdff919 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -249,6 +249,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> >         dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
> >         dev_attr.ngroups = VDPASIM_NET_GROUP_NUM;
> >         dev_attr.nas = VDPASIM_NET_AS_NUM;
> > +       dev_attr.alloc_size = sizeof(struct vdpasim);
> >         dev_attr.config_size = sizeof(struct virtio_net_config);
> >         dev_attr.get_config = vdpasim_net_get_config;
> >         dev_attr.work_fn = vdpasim_net_work;
> > --
> > 2.25.1
> >
>

