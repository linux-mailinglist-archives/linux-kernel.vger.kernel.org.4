Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4934B64E67F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 04:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiLPDxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 22:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiLPDxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 22:53:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0328BFE2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671162774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/mkgsybv+YQLr4xgOo2Mo6CQB2C40n1fNpguX/a6f0=;
        b=KWGoTvgMLD4S5QxtrWMRgpERujE9BftPsp+4fAqefH3iyei2Rj739yiDZz+lo/uFqslakz
        DBx6PNYnQK13A3XGLPPZ2QjAXpRcjEW29AOVkQ97lZMeRGkhnqH3wj5Jk11chvMroigAD+
        JJyPknqB6dzWsvNPRFKqizAKUu0IMDg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-422-KrrFLRcHO5Gb8pUXYpNkJw-1; Thu, 15 Dec 2022 22:52:52 -0500
X-MC-Unique: KrrFLRcHO5Gb8pUXYpNkJw-1
Received: by mail-oi1-f197.google.com with SMTP id y1-20020a056808130100b00359cb5ea927so360386oiv.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/mkgsybv+YQLr4xgOo2Mo6CQB2C40n1fNpguX/a6f0=;
        b=4OSlfRof3DpPl8aiBNnl7RwjD5beMffcnwxtWNBDsvWRCvEkMtI19Z4mDkDBd/YrJg
         aBJzBUK1ITbchMOhGjPBD8hoLra7OL17wpJ8sgGpeeUyr8Eag7dsd7jcDf5rt06pzWiT
         W6hz2Fp4yvy9pUW4V5J5b/rPCg9IFC2I71O2+YimM2l8LvSy9uhLAPBZm6XmJCLf/SFc
         wG9XDfipoTEs3IR3ZVT7PnyYbyhHaxxoLWb0sGlQ+F4iLwo7Lp/j69avMAFOpM/L3qVN
         iLn37XerkcD7hkIy6KPDy8GDYRsg/IAO1ljsSJTjYkuQS8oyGMtzDns5hLwFEIOQvPlB
         GJcA==
X-Gm-Message-State: ANoB5pk0bEWvW62Pl7QPOwswOPvJgZaOh4ukx0BJeADa9iPontYqm9TD
        AhQ9CCxnDaFTBR+b+qgh/826U6EPs7Pi54h7cFirYCAnPusYY8tkeLZi38b0Rz0ZUo8+NOkbVli
        3T7q62I7/MdukokOm8P0siHhQtXWU9ExndHeWxunh
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id cm5-20020a056830650500b0066cfb5b4904mr49171568otb.237.1671162772178;
        Thu, 15 Dec 2022 19:52:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7LLJFF2vwjKag+M02bzigSi3YJhDrHkH5IBNXsH5IdjpWSKWW5SLTf7TcNnRRFz54+6GmXg7+X2M1gXN7LlEI=
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr49171566otb.237.1671162771969; Thu, 15
 Dec 2022 19:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-3-xieyongji@bytedance.com>
In-Reply-To: <20221205084127.535-3-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 16 Dec 2022 11:52:40 +0800
Message-ID: <CACGkMEvJM4g5EAZiuS_-=uAOZ=LZN=KjNtFmVPXdv=arSVyLXg@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] vdpa: Add set/get_vq_affinity callbacks in vdpa_config_ops
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, tglx@linutronix.de, hch@lst.de,
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

On Mon, Dec 5, 2022 at 4:43 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This introduces set/get_vq_affinity callbacks in
> vdpa_config_ops to support interrupt affinity
> management for vdpa device drivers.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/virtio/virtio_vdpa.c | 28 ++++++++++++++++++++++++++++
>  include/linux/vdpa.h         | 13 +++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 9670cc79371d..08084b49e5a1 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -330,6 +330,32 @@ static const char *virtio_vdpa_bus_name(struct virtio_device *vdev)
>         return dev_name(&vdpa->dev);
>  }
>
> +static int virtio_vdpa_set_vq_affinity(struct virtqueue *vq,
> +                                      const struct cpumask *cpu_mask)
> +{
> +       struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vq->vdev);
> +       struct vdpa_device *vdpa = vd_dev->vdpa;
> +       const struct vdpa_config_ops *ops = vdpa->config;
> +       unsigned int index = vq->index;
> +
> +       if (ops->set_vq_affinity)
> +               return ops->set_vq_affinity(vdpa, index, cpu_mask);
> +
> +       return 0;
> +}
> +
> +static const struct cpumask *
> +virtio_vdpa_get_vq_affinity(struct virtio_device *vdev, int index)
> +{
> +       struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> +       const struct vdpa_config_ops *ops = vdpa->config;
> +
> +       if (ops->get_vq_affinity)
> +               return ops->get_vq_affinity(vdpa, index);
> +
> +       return NULL;
> +}
> +
>  static const struct virtio_config_ops virtio_vdpa_config_ops = {
>         .get            = virtio_vdpa_get,
>         .set            = virtio_vdpa_set,
> @@ -342,6 +368,8 @@ static const struct virtio_config_ops virtio_vdpa_config_ops = {
>         .get_features   = virtio_vdpa_get_features,
>         .finalize_features = virtio_vdpa_finalize_features,
>         .bus_name       = virtio_vdpa_bus_name,
> +       .set_vq_affinity = virtio_vdpa_set_vq_affinity,
> +       .get_vq_affinity = virtio_vdpa_get_vq_affinity,
>  };
>
>  static void virtio_vdpa_release_dev(struct device *_d)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d0f5e4e82c2..0ff6c9363356 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -247,6 +247,15 @@ struct vdpa_map_file {
>   *                             @vdev: vdpa device
>   *                             Returns the iova range supported by
>   *                             the device.
> + * @set_vq_affinity:           Set the irq affinity of virtqueue (optional)
> + *                             @vdev: vdpa device
> + *                             @idx: virtqueue index
> + *                             @cpu_mask: irq affinity mask
> + *                             Returns integer: success (0) or error (< 0)
> + * @get_vq_affinity:           Get the irq affinity of virtqueue (optional)
> + *                             @vdev: vdpa device
> + *                             @idx: virtqueue index
> + *                             Returns the irq affinity mask
>   * @set_group_asid:            Set address space identifier for a
>   *                             virtqueue group (optional)
>   *                             @vdev: vdpa device
> @@ -331,6 +340,10 @@ struct vdpa_config_ops {
>                            const void *buf, unsigned int len);
>         u32 (*get_generation)(struct vdpa_device *vdev);
>         struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> +       int (*set_vq_affinity)(struct vdpa_device *vdev, u16 idx,
> +                              const struct cpumask *cpu_mask);
> +       const struct cpumask *(*get_vq_affinity)(struct vdpa_device *vdev,
> +                                                u16 idx);
>
>         /* DMA ops */
>         int (*set_map)(struct vdpa_device *vdev, unsigned int asid,
> --
> 2.20.1
>

