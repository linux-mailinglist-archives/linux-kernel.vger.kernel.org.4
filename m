Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373EE637267
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKXGfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiKXGf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:35:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9F99371E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669271672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XW4QocPZ/IX7iF7xzjKQbsxjhbLSPlgpn0gsT7pmGR8=;
        b=Y4Z2nr7nBfKoUi4MDzp+i+WNy4E1UU4WMqLhAag2Rov6yKpnHEuClJGb0WZyxgrLj2zJkQ
        G0AG5PX+XYyFGZ4mXcWHcJop1CE+i5IAnWmDz+OpvC8goic+5VcHox+YWt6MWmgAEZQk6l
        Q3dloE2KIeaQSqlMrqlUqcaItvXsLTw=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-GRuDyWLwPX-_rfe4B7Zysw-1; Thu, 24 Nov 2022 01:34:30 -0500
X-MC-Unique: GRuDyWLwPX-_rfe4B7Zysw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-14261bd9123so454812fac.21
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XW4QocPZ/IX7iF7xzjKQbsxjhbLSPlgpn0gsT7pmGR8=;
        b=A/bK/Y7uNw4ecdrrrhaxmNTnESykYaYLDYPU9/pAe/2+8thO5zjiTUi9VUDIjPGDyQ
         pxGgcTxiktbRGnN0L7q2X44RmCEqw2bbP5/8G/lGHOCVfJfR2/FDxV0uvRhPB+FW4SzQ
         6eqIFtotvweWXQqocI+CWRTr7aPPTngEA/Js4nussELcrECJplD5UFTEUFd5/HHYK8KJ
         xuPq6/iLgGbm/Jl8muZFGrX8vqxKP/aLgKvnkzEHKFqEfajp6Iqndp8538eETgwB8jyi
         camBeJt5vAuVf3SVvCelpeSGR4bO0c8CsnOy0GMw0+eK9XKfoqDxOhRBipay/Ol74kfg
         wOHQ==
X-Gm-Message-State: ANoB5pnlc3FqJCiTQUoP0veM80h4oq685WBUjhwlQ4yRTjOb5TdsVMQn
        2uySQafunHmDnRovI40GKH7oG775SmwDa/hoTNP1CwSKlZ4aMPk8VTG6gpqiZrEOal0sYbWKzjN
        ELZiLDZ7+JUmRVX/JNiMRIH/ywwZK5UIpjQHRdnoE
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id e5-20020a4ab145000000b0049f449a5f6cmr5553710ooo.93.1669271669790;
        Wed, 23 Nov 2022 22:34:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7IyosG5Zgp1L1z/dEd/7W1lJHYNVRxsPXQn0yG8lUKOd7B4LRcDGirgFhy/2cx3irMqDkKK2cq6cTryykNnxQ=
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id
 e5-20020a4ab145000000b0049f449a5f6cmr5553705ooo.93.1669271669534; Wed, 23 Nov
 2022 22:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20221124062309.2081720-1-lulu@redhat.com>
In-Reply-To: <20221124062309.2081720-1-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 24 Nov 2022 14:34:18 +0800
Message-ID: <CACGkMEupFLwNFvGkU_vgDmhzY9K=b0KFC4BkWGVfO3s+GEWaKQ@mail.gmail.com>
Subject: Re: [PATCH] vhost_vdpa: fix the crash in unmap a large memory
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
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

On Thu, Nov 24, 2022 at 2:23 PM Cindy Lu <lulu@redhat.com> wrote:
>
> While testing in vIOMMU, sometimes guest will unmap very large memory,
> which will cause the crash.

Would you mind to post the calltrace?

> To fix this,Move the iommu_unmap to
> vhost_vdpa_pa_unmap/vhost_vdpa_va_unmap and only unmap the memory
> that saved in iotlb.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Let's add a fixes tag which I believe should be the first commit that
introduces vhost-vDPA. And let's cc stable as well.

> ---
>  drivers/vhost/vdpa.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 166044642fd5..c392979702cf 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -692,6 +692,8 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v,
>         struct vhost_iotlb_map *map;
>         struct page *page;
>         unsigned long pfn, pinned;
> +       struct vdpa_device *vdpa = v->vdpa;
> +       const struct vdpa_config_ops *ops = vdpa->config;
>
>         while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
>                 pinned = PFN_DOWN(map->size);
> @@ -703,6 +705,8 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v,
>                         unpin_user_page(page);
>                 }
>                 atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
> +               if ((ops->dma_map == NULL) && (ops->set_map == NULL))
> +                       iommu_unmap(v->domain, map->start, map->size);
>                 vhost_iotlb_map_free(iotlb, map);
>         }
>  }
> @@ -713,11 +717,15 @@ static void vhost_vdpa_va_unmap(struct vhost_vdpa *v,
>  {
>         struct vhost_iotlb_map *map;
>         struct vdpa_map_file *map_file;
> +       struct vdpa_device *vdpa = v->vdpa;
> +       const struct vdpa_config_ops *ops = vdpa->config;
>
>         while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
>                 map_file = (struct vdpa_map_file *)map->opaque;
>                 fput(map_file->file);
>                 kfree(map_file);
> +               if ((ops->dma_map == NULL) && (ops->set_map == NULL))
> +                       iommu_unmap(v->domain, map->start, map->size);

I wonder if it's better to move at least dma_map() here.

Thanks

>                 vhost_iotlb_map_free(iotlb, map);
>         }
>  }
> @@ -805,8 +813,6 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
>         } else if (ops->set_map) {
>                 if (!v->in_batch)
>                         ops->set_map(vdpa, asid, iotlb);
> -       } else {
> -               iommu_unmap(v->domain, iova, size);
>         }
>
>         /* If we are in the middle of batch processing, delay the free
> --
> 2.34.3
>

