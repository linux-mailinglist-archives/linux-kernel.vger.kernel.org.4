Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6857464E6EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 06:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiLPFbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 00:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPFbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 00:31:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBB736D60
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 21:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671168626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3+XU3NOi5/AH6byjyKh3uKPQGZdUxmKJMRxGY2jtMG4=;
        b=PsCw/RwCsCp7tYJDaVEUPEKE3+tejVgSyv6JvL7+UnVLtGrcDFGIoD+x3BAahZdAvlx6iA
        bWR6eLkJ+H8uCRmRPa2YybDA2MVr2iHXlLO9BFrbxnu1WKS0zPdwWYCOzI+aubmM5wL7Ns
        0zyBw39dix7Y33JZz0JOMX7ciJ0hTIg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-602-g01Npib2O96Lk7HC00BxuA-1; Fri, 16 Dec 2022 00:30:24 -0500
X-MC-Unique: g01Npib2O96Lk7HC00BxuA-1
Received: by mail-oi1-f197.google.com with SMTP id p133-20020acaf18b000000b0035b236c8554so400443oih.15
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 21:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+XU3NOi5/AH6byjyKh3uKPQGZdUxmKJMRxGY2jtMG4=;
        b=axb9WmXrw5VAg1qv2Y0BpCJjNGpULF43MdHuZqojxozNe2veNxUnMv4D13K0eQvAT1
         DtvWuGwbmgZEpLusQYbKBNv1243FxBaFjWfroMrg+Sblf2+2xlOBcf4m72Xj8U2X3MV3
         1zgTM1Ri5T7MsXkr+lqvbg+vT8mnSmBWk6oe0icf6VTpNln5ZmdJRSIxursgtCwc8tlY
         6p1mLQHmUqXE5zUL3VT7PlAeGvHoNpN7Ep+ZlBJothaqlhGP8/l3gYbqtqV0EGcpUMHm
         WMPCICwMSFZqn6zMN1XLZwXR3pGkB/S7m/KM/jBADC4dOq1AGqO6JSD8xvn6aJbCvBDj
         VJsw==
X-Gm-Message-State: ANoB5pkCyzgC+2Of3QvZQF3TEjFdzhNrTPjqvKn8HnsO6RXEjPUDSx8n
        yJUpEmv1Kjs8QNHh/bl7MM7qTYW1p50yZ4pb3Lg/gSGBTmiZ2jAD+duViWJVfJg9ayWSAJEjXuj
        o1LoryPuEZ//Z52hiIpt/sbg8WxxT5ingYqOb9qk3
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id cm5-20020a056830650500b0066cfb5b4904mr49184173otb.237.1671168624165;
        Thu, 15 Dec 2022 21:30:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6BrOptlv6D9XDmrSx9Gl/+QASruxbWSD27Gp2XJqBb4LkjXk5a8WbVpb7gaZS4dCUJ7gxwKJDDAhCpCBzolGs=
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr49184168otb.237.1671168623904; Thu, 15
 Dec 2022 21:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205085846.741-1-xieyongji@bytedance.com>
In-Reply-To: <20221205085846.741-1-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 16 Dec 2022 13:30:12 +0800
Message-ID: <CACGkMEuhYO3neFmxwiBp8C0QTaa+Mb13kken+RZ9QuruMct6tA@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] vduse: Support automatic irq callback affinity
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

On Mon, Dec 5, 2022 at 4:59 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This brings current interrupt affinity spreading mechanism
> to vduse device. We will make use of irq_create_affinity_masks()
> to create an irq callback affinity mask for each virtqueue of
> vduse device. Then we will choose the CPU which has the lowest
> number of interrupt allocated in the affinity mask to run the
> irq callback.

This seems a balance mechanism but it might not be the semantic of the
affinity or any reason we need to do this? I guess we should use at
least round-robin in this case.

>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 50 ++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index d126f3e32a20..90c2896039d9 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -23,6 +23,7 @@
>  #include <linux/nospec.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/mm.h>
> +#include <linux/interrupt.h>
>  #include <uapi/linux/vduse.h>
>  #include <uapi/linux/vdpa.h>
>  #include <uapi/linux/virtio_config.h>
> @@ -58,6 +59,8 @@ struct vduse_virtqueue {
>         struct work_struct inject;
>         struct work_struct kick;
>         int irq_effective_cpu;
> +       struct cpumask irq_affinity;
> +       spinlock_t irq_affinity_lock;

Ok, I'd suggest to squash this into patch 5 to make it more easier to
be reviewed.

>  };
>
>  struct vduse_dev;
> @@ -123,6 +126,7 @@ struct vduse_control {
>
>  static DEFINE_MUTEX(vduse_lock);
>  static DEFINE_IDR(vduse_idr);
> +static DEFINE_PER_CPU(unsigned long, vduse_allocated_irq);
>
>  static dev_t vduse_major;
>  static struct class *vduse_class;
> @@ -710,6 +714,49 @@ static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
>         return dev->generation;
>  }
>
> +static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> +{
> +       unsigned int cpu, best_cpu;
> +       unsigned long allocated, allocated_min = UINT_MAX;
> +
> +       spin_lock(&vq->irq_affinity_lock);
> +
> +       best_cpu = vq->irq_effective_cpu;
> +       if (best_cpu != -1)
> +               per_cpu(vduse_allocated_irq, best_cpu) -= 1;
> +
> +       for_each_cpu(cpu, &vq->irq_affinity) {
> +               allocated = per_cpu(vduse_allocated_irq, cpu);
> +               if (!cpu_online(cpu) || allocated >= allocated_min)
> +                       continue;
> +
> +               best_cpu = cpu;
> +               allocated_min = allocated;
> +       }
> +       vq->irq_effective_cpu = best_cpu;
> +       per_cpu(vduse_allocated_irq, best_cpu) += 1;
> +
> +       spin_unlock(&vq->irq_affinity_lock);
> +}
> +
> +static void vduse_vdpa_set_irq_affinity(struct vdpa_device *vdpa,
> +                                       struct irq_affinity *desc)
> +{
> +       struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +       struct irq_affinity_desc *affd = NULL;
> +       int i;
> +
> +       affd = irq_create_affinity_masks(dev->vq_num, desc);
> +       if (!affd)

Let's add a comment on the vdpa config ops to say set_irq_affinity()
is best effort.

Thanks

> +               return;
> +
> +       for (i = 0; i < dev->vq_num; i++) {
> +               cpumask_copy(&dev->vqs[i]->irq_affinity, &affd[i].mask);
> +               vduse_vq_update_effective_cpu(dev->vqs[i]);
> +       }
> +       kfree(affd);
> +}
> +
>  static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
>                                 unsigned int asid,
>                                 struct vhost_iotlb *iotlb)
> @@ -760,6 +807,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
>         .get_config             = vduse_vdpa_get_config,
>         .set_config             = vduse_vdpa_set_config,
>         .get_generation         = vduse_vdpa_get_generation,
> +       .set_irq_affinity       = vduse_vdpa_set_irq_affinity,
>         .reset                  = vduse_vdpa_reset,
>         .set_map                = vduse_vdpa_set_map,
>         .free                   = vduse_vdpa_free,
> @@ -1380,6 +1428,8 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>                 INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
>                 spin_lock_init(&dev->vqs[i]->kick_lock);
>                 spin_lock_init(&dev->vqs[i]->irq_lock);
> +               spin_lock_init(&dev->vqs[i]->irq_affinity_lock);
> +               cpumask_setall(&dev->vqs[i]->irq_affinity);
>         }
>
>         return 0;
> --
> 2.20.1
>

