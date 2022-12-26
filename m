Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0427655FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 05:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiLZENq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 23:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLZENo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 23:13:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9411B113C
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 20:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672027975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1xbwdMuKGP8PlsQI1dD5J5S50UOs/R2WOB6z3bdkzG4=;
        b=ZAeMYMvEmDeeszwQtW7r0DxEadhykAWvVwp++HobVXO/ATHVlwuEb8ZoysqE1br02SfCQs
        C7YcQ86h9G4PAiivR4sdPknGOd8660iGR8tHUzHOX+m7SfIrWjYZHmWnpSIqiKAFIrAWBw
        H8Q6G4dIpBnbTLlH0z00c8blGfu7ax8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-160-PWu28cnbNjqBquy9W5oQ4Q-1; Sun, 25 Dec 2022 23:12:54 -0500
X-MC-Unique: PWu28cnbNjqBquy9W5oQ4Q-1
Received: by mail-oo1-f71.google.com with SMTP id l22-20020a4a8556000000b004ad9f50165fso4640752ooh.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 20:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xbwdMuKGP8PlsQI1dD5J5S50UOs/R2WOB6z3bdkzG4=;
        b=z8CUR4jt4C9akIjo6I9rfu1357Zt+fb4xb0ijD2q2Es6T2ZauT46R31V1YNboEiyiy
         VT216yxZCzRvi3khy6/zx16fdeVSItkTP9GmvgI18Z4IGiVSLF8tlZEThOZHtyAw6gMr
         ah5XiE6sjV+HXJLYGygY086zP7Mczvmha3k3eam3m9wAPaevWQWKqsuTQ78n722UAPqO
         JR4gDJjwbLrzIfVawlvop2uXdpgtljPZemlwLfZ8OqxaRdUC/MjZpQrdxjLfO7kd1Z6O
         OTUza8Ezt0NJoeZx0AXEGSYHUT+KAHkQ3PpkLiBfVfJcItHUDEoObyew/sF3QJg8UyRp
         j5Xg==
X-Gm-Message-State: AFqh2kpfJQu3fd0YBPlfQeTaotfTqyj7Nnk8w2F76IRdwen7JfgSmrN2
        /zr9f0BDGXV5IdYQ5O44lDgNpZb+JM8prUBH4Pqq/V08+gK5e4FnbtZ5dK/dZ4zaNQkNyYN+aPR
        Ttwu2T3phrmMWxOkp2Aru0P2PsFk7FIsKz1es2gl9
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id lm23-20020a0568703d9700b00144b22a38d3mr1116696oab.280.1672027973444;
        Sun, 25 Dec 2022 20:12:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvOxYIKKPtEjS2uXMNjFn0C3JnkB7XGH2lpKLEHI+PC2if2hYhErIcKXJkXHdrzMYh4r2bqreHjb4eTaSLQ6Ro=
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id
 lm23-20020a0568703d9700b00144b22a38d3mr1116690oab.280.1672027973219; Sun, 25
 Dec 2022 20:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20221223060021.28011-1-jasowang@redhat.com> <20221223092656.ccs2fwwysu2gqzjo@sgarzare-redhat>
In-Reply-To: <20221223092656.ccs2fwwysu2gqzjo@sgarzare-redhat>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 26 Dec 2022 12:12:42 +0800
Message-ID: <CACGkMEsjEJyrZvKus8rWNw4zgi-8FeWGBU+LYm6p41K7-j5gpQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: get rid of DMA ops
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com, hch@lst.de
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

On Fri, Dec 23, 2022 at 5:27 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Dec 23, 2022 at 02:00:21PM +0800, Jason Wang wrote:
> >We used to (ab)use the DMA ops for setting up identical mappings in
> >the IOTLB. This patch tries to get rid of the those unnecessary DMA
> >ops by maintaining a simple identical/passthrough mappings by
> >default. When bound to virtio_vdpa driver, DMA API will simply use PA
> >as the IOVA and we will be all fine. When the vDPA bus tries to setup
> >customized mapping (e.g when bound to vhost-vDPA), the
> >identical/passthrough mapping will be removed.
> >
> >Signed-off-by: Jason Wang <jasowang@redhat.com>
> >---
> >Note:
> >- This patch depends on the series "[PATCH V3 0/4] Vendor stats
> >  support in vdpasim_net"
> >---
> > drivers/vdpa/vdpa_sim/vdpa_sim.c | 170 ++++---------------------------
> > drivers/vdpa/vdpa_sim/vdpa_sim.h |   2 +-
> > 2 files changed, 22 insertions(+), 150 deletions(-)
> >
> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >index 45d3f84b7937..187fa3a0e5d5 100644
> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >@@ -17,7 +17,6 @@
> > #include <linux/vringh.h>
> > #include <linux/vdpa.h>
> > #include <linux/vhost_iotlb.h>
> >-#include <linux/iova.h>
> > #include <uapi/linux/vdpa.h>
> >
> > #include "vdpa_sim.h"
> >@@ -45,13 +44,6 @@ static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
> >       return container_of(vdpa, struct vdpasim, vdpa);
> > }
> >
> >-static struct vdpasim *dev_to_sim(struct device *dev)
> >-{
> >-      struct vdpa_device *vdpa = dev_to_vdpa(dev);
> >-
> >-      return vdpa_to_sim(vdpa);
> >-}
> >-
> > static void vdpasim_vq_notify(struct vringh *vring)
> > {
> >       struct vdpasim_virtqueue *vq =
> >@@ -104,8 +96,12 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
> >                                &vdpasim->iommu_lock);
> >       }
> >
> >-      for (i = 0; i < vdpasim->dev_attr.nas; i++)
> >+      for (i = 0; i < vdpasim->dev_attr.nas; i++) {
> >               vhost_iotlb_reset(&vdpasim->iommu[i]);
> >+              vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX,
> >+                                    0, VHOST_MAP_RW);
> >+              vdpasim->iommu_pt[i] = true;
> >+      }
> >
> >       vdpasim->running = true;
> >       spin_unlock(&vdpasim->iommu_lock);
> >@@ -115,133 +111,6 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
> >       ++vdpasim->generation;
> > }
> >
> >-static int dir_to_perm(enum dma_data_direction dir)
> >-{
> >-      int perm = -EFAULT;
> >-
> >-      switch (dir) {
> >-      case DMA_FROM_DEVICE:
> >-              perm = VHOST_MAP_WO;
> >-              break;
> >-      case DMA_TO_DEVICE:
> >-              perm = VHOST_MAP_RO;
> >-              break;
> >-      case DMA_BIDIRECTIONAL:
> >-              perm = VHOST_MAP_RW;
> >-              break;
> >-      default:
> >-              break;
> >-      }
> >-
> >-      return perm;
> >-}
> >-
> >-static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
> >-                                  size_t size, unsigned int perm)
> >-{
> >-      struct iova *iova;
> >-      dma_addr_t dma_addr;
> >-      int ret;
> >-
> >-      /* We set the limit_pfn to the maximum (ULONG_MAX - 1) */
> >-      iova = alloc_iova(&vdpasim->iova, size >> iova_shift(&vdpasim->iova),
> >-                        ULONG_MAX - 1, true);
> >-      if (!iova)
> >-              return DMA_MAPPING_ERROR;
> >-
> >-      dma_addr = iova_dma_addr(&vdpasim->iova, iova);
> >-
> >-      spin_lock(&vdpasim->iommu_lock);
> >-      ret = vhost_iotlb_add_range(&vdpasim->iommu[0], (u64)dma_addr,
> >-                                  (u64)dma_addr + size - 1, (u64)paddr, perm);
> >-      spin_unlock(&vdpasim->iommu_lock);
> >-
> >-      if (ret) {
> >-              __free_iova(&vdpasim->iova, iova);
> >-              return DMA_MAPPING_ERROR;
> >-      }
> >-
> >-      return dma_addr;
> >-}
> >-
> >-static void vdpasim_unmap_range(struct vdpasim *vdpasim, dma_addr_t dma_addr,
> >-                              size_t size)
> >-{
> >-      spin_lock(&vdpasim->iommu_lock);
> >-      vhost_iotlb_del_range(&vdpasim->iommu[0], (u64)dma_addr,
> >-                            (u64)dma_addr + size - 1);
> >-      spin_unlock(&vdpasim->iommu_lock);
> >-
> >-      free_iova(&vdpasim->iova, iova_pfn(&vdpasim->iova, dma_addr));
> >-}
> >-
> >-static dma_addr_t vdpasim_map_page(struct device *dev, struct page *page,
> >-                                 unsigned long offset, size_t size,
> >-                                 enum dma_data_direction dir,
> >-                                 unsigned long attrs)
> >-{
> >-      struct vdpasim *vdpasim = dev_to_sim(dev);
> >-      phys_addr_t paddr = page_to_phys(page) + offset;
> >-      int perm = dir_to_perm(dir);
> >-
> >-      if (perm < 0)
> >-              return DMA_MAPPING_ERROR;
> >-
> >-      return vdpasim_map_range(vdpasim, paddr, size, perm);
> >-}
> >-
> >-static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
> >-                             size_t size, enum dma_data_direction dir,
> >-                             unsigned long attrs)
> >-{
> >-      struct vdpasim *vdpasim = dev_to_sim(dev);
> >-
> >-      vdpasim_unmap_range(vdpasim, dma_addr, size);
> >-}
> >-
> >-static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
> >-                                  dma_addr_t *dma_addr, gfp_t flag,
> >-                                  unsigned long attrs)
> >-{
> >-      struct vdpasim *vdpasim = dev_to_sim(dev);
> >-      phys_addr_t paddr;
> >-      void *addr;
> >-
> >-      addr = kmalloc(size, flag);
> >-      if (!addr) {
> >-              *dma_addr = DMA_MAPPING_ERROR;
> >-              return NULL;
> >-      }
> >-
> >-      paddr = virt_to_phys(addr);
> >-
> >-      *dma_addr = vdpasim_map_range(vdpasim, paddr, size, VHOST_MAP_RW);
> >-      if (*dma_addr == DMA_MAPPING_ERROR) {
> >-              kfree(addr);
> >-              return NULL;
> >-      }
> >-
> >-      return addr;
> >-}
> >-
> >-static void vdpasim_free_coherent(struct device *dev, size_t size,
> >-                                void *vaddr, dma_addr_t dma_addr,
> >-                                unsigned long attrs)
> >-{
> >-      struct vdpasim *vdpasim = dev_to_sim(dev);
> >-
> >-      vdpasim_unmap_range(vdpasim, dma_addr, size);
> >-
> >-      kfree(vaddr);
> >-}
> >-
> >-static const struct dma_map_ops vdpasim_dma_ops = {
> >-      .map_page = vdpasim_map_page,
> >-      .unmap_page = vdpasim_unmap_page,
> >-      .alloc = vdpasim_alloc_coherent,
> >-      .free = vdpasim_free_coherent,
> >-};
> >-
> > static const struct vdpa_config_ops vdpasim_config_ops;
> > static const struct vdpa_config_ops vdpasim_batch_config_ops;
> >
> >@@ -289,7 +158,6 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >       dev->dma_mask = &dev->coherent_dma_mask;
> >       if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
> >               goto err_iommu;
> >-      set_dma_ops(dev, &vdpasim_dma_ops);
> >       vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
> >
> >       vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
> >@@ -306,6 +174,11 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >       if (!vdpasim->iommu)
> >               goto err_iommu;
> >
> >+      vdpasim->iommu_pt = kmalloc_array(vdpasim->dev_attr.nas,
> >+                                        sizeof(*vdpasim->iommu_pt), GFP_KERNEL);
> >+      if (!vdpasim->iommu_pt)
> >+              goto err_iommu;
> >+
> >       for (i = 0; i < vdpasim->dev_attr.nas; i++)
> >               vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
> >
> >@@ -317,13 +190,6 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >               vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
> >                                &vdpasim->iommu_lock);
> >
> >-      ret = iova_cache_get();
> >-      if (ret)
> >-              goto err_iommu;
> >-
> >-      /* For simplicity we use an IOVA allocator with byte granularity */
> >-      init_iova_domain(&vdpasim->iova, 1, 0);
> >-
> >       vdpasim->vdpa.dma_dev = dev;
> >
> >       return vdpasim;
> >@@ -639,6 +505,7 @@ static int vdpasim_set_map(struct vdpa_device *vdpa, unsigned int asid,
> >
> >       iommu = &vdpasim->iommu[asid];
> >       vhost_iotlb_reset(iommu);
> >+      vdpasim->iommu_pt[asid] = false;
> >
> >       for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
> >            map = vhost_iotlb_itree_next(map, start, last)) {
> >@@ -667,6 +534,10 @@ static int vdpasim_dma_map(struct vdpa_device *vdpa, unsigned int asid,
> >               return -EINVAL;
> >
> >       spin_lock(&vdpasim->iommu_lock);
> >+      if (vdpasim->iommu_pt[asid]) {
> >+              vhost_iotlb_reset(&vdpasim->iommu[asid]);
> >+              vdpasim->iommu_pt[asid] = false;
> >+      }
> >       ret = vhost_iotlb_add_range_ctx(&vdpasim->iommu[asid], iova,
> >                                       iova + size - 1, pa, perm, opaque);
> >       spin_unlock(&vdpasim->iommu_lock);
> >@@ -682,6 +553,11 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
> >       if (asid >= vdpasim->dev_attr.nas)
> >               return -EINVAL;
> >
> >+      if (vdpasim->iommu_pt[asid]) {
>
> We are in the vdpasim_dma_unmap, so if vdpasim->iommu_pt[asid] is true,
> should be better to return an error, since this case should not happen?

So it's a question of how to behave when unmap is called without a
map. I think we can leave the code as is or if we wish, it needs a
separate patch.

(We didn't error this previously anyhow).

Thanks

>
> The rest LGTM!
>
> Thanks,
> Stefano
>
> >+              vhost_iotlb_reset(&vdpasim->iommu[asid]);
> >+              vdpasim->iommu_pt[asid] = false;
> >+      }
> >+
> >       spin_lock(&vdpasim->iommu_lock);
> >       vhost_iotlb_del_range(&vdpasim->iommu[asid], iova, iova + size - 1);
> >       spin_unlock(&vdpasim->iommu_lock);
> >@@ -701,15 +577,11 @@ static void vdpasim_free(struct vdpa_device *vdpa)
> >               vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
> >       }
> >
> >-      if (vdpa_get_dma_dev(vdpa)) {
> >-              put_iova_domain(&vdpasim->iova);
> >-              iova_cache_put();
> >-      }
> >-
> >       kvfree(vdpasim->buffer);
> >       for (i = 0; i < vdpasim->dev_attr.nas; i++)
> >               vhost_iotlb_reset(&vdpasim->iommu[i]);
> >       kfree(vdpasim->iommu);
> >+      kfree(vdpasim->iommu_pt);
> >       kfree(vdpasim->vqs);
> >       kfree(vdpasim->config);
> > }
> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> >index d2a08c0abad7..770ef3408619 100644
> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> >@@ -64,7 +64,7 @@ struct vdpasim {
> >       /* virtio config according to device type */
> >       void *config;
> >       struct vhost_iotlb *iommu;
> >-      struct iova_domain iova;
> >+      bool *iommu_pt;
> >       void *buffer;
> >       u32 status;
> >       u32 generation;
> >--
> >2.25.1
> >
>

