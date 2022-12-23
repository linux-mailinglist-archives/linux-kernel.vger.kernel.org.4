Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B798654C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiLWGBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWGBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:01:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E375962EF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671775231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tV0aITuMxX7JXMP8l/mhTvmsIIk8GUyyDmCSCHHJZEE=;
        b=H+sBxmFaUedHVdtmRujiWiZSIGGRmf2Rx4fBaQyh070B1NLFn+ue1Erx2/d+LluLnYP/kQ
        M8etJRmdgnn2gzxekXDNmKU1YJCQ30kzOcED7je02U4E2oCYGulELletBpQiHVn+z4Z/OD
        UUiwIJV4c0V47VEk4C7z4XvohQcm4Tw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-QWPt_bOKN46b2cPvy3DvJw-1; Fri, 23 Dec 2022 01:00:27 -0500
X-MC-Unique: QWPt_bOKN46b2cPvy3DvJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0424129ABA32;
        Fri, 23 Dec 2022 06:00:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F8532026D4B;
        Fri, 23 Dec 2022 06:00:23 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     sgarzare@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com, hch@lst.de
Subject: [PATCH] vdpa_sim: get rid of DMA ops
Date:   Fri, 23 Dec 2022 14:00:21 +0800
Message-Id: <20221223060021.28011-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to (ab)use the DMA ops for setting up identical mappings in
the IOTLB. This patch tries to get rid of the those unnecessary DMA
ops by maintaining a simple identical/passthrough mappings by
default. When bound to virtio_vdpa driver, DMA API will simply use PA
as the IOVA and we will be all fine. When the vDPA bus tries to setup
customized mapping (e.g when bound to vhost-vDPA), the
identical/passthrough mapping will be removed.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Note:
- This patch depends on the series "[PATCH V3 0/4] Vendor stats
  support in vdpasim_net"
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 170 ++++---------------------------
 drivers/vdpa/vdpa_sim/vdpa_sim.h |   2 +-
 2 files changed, 22 insertions(+), 150 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 45d3f84b7937..187fa3a0e5d5 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -17,7 +17,6 @@
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
 #include <linux/vhost_iotlb.h>
-#include <linux/iova.h>
 #include <uapi/linux/vdpa.h>
 
 #include "vdpa_sim.h"
@@ -45,13 +44,6 @@ static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
 	return container_of(vdpa, struct vdpasim, vdpa);
 }
 
-static struct vdpasim *dev_to_sim(struct device *dev)
-{
-	struct vdpa_device *vdpa = dev_to_vdpa(dev);
-
-	return vdpa_to_sim(vdpa);
-}
-
 static void vdpasim_vq_notify(struct vringh *vring)
 {
 	struct vdpasim_virtqueue *vq =
@@ -104,8 +96,12 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
 				 &vdpasim->iommu_lock);
 	}
 
-	for (i = 0; i < vdpasim->dev_attr.nas; i++)
+	for (i = 0; i < vdpasim->dev_attr.nas; i++) {
 		vhost_iotlb_reset(&vdpasim->iommu[i]);
+		vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX,
+				      0, VHOST_MAP_RW);
+		vdpasim->iommu_pt[i] = true;
+	}
 
 	vdpasim->running = true;
 	spin_unlock(&vdpasim->iommu_lock);
@@ -115,133 +111,6 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
 	++vdpasim->generation;
 }
 
-static int dir_to_perm(enum dma_data_direction dir)
-{
-	int perm = -EFAULT;
-
-	switch (dir) {
-	case DMA_FROM_DEVICE:
-		perm = VHOST_MAP_WO;
-		break;
-	case DMA_TO_DEVICE:
-		perm = VHOST_MAP_RO;
-		break;
-	case DMA_BIDIRECTIONAL:
-		perm = VHOST_MAP_RW;
-		break;
-	default:
-		break;
-	}
-
-	return perm;
-}
-
-static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
-				    size_t size, unsigned int perm)
-{
-	struct iova *iova;
-	dma_addr_t dma_addr;
-	int ret;
-
-	/* We set the limit_pfn to the maximum (ULONG_MAX - 1) */
-	iova = alloc_iova(&vdpasim->iova, size >> iova_shift(&vdpasim->iova),
-			  ULONG_MAX - 1, true);
-	if (!iova)
-		return DMA_MAPPING_ERROR;
-
-	dma_addr = iova_dma_addr(&vdpasim->iova, iova);
-
-	spin_lock(&vdpasim->iommu_lock);
-	ret = vhost_iotlb_add_range(&vdpasim->iommu[0], (u64)dma_addr,
-				    (u64)dma_addr + size - 1, (u64)paddr, perm);
-	spin_unlock(&vdpasim->iommu_lock);
-
-	if (ret) {
-		__free_iova(&vdpasim->iova, iova);
-		return DMA_MAPPING_ERROR;
-	}
-
-	return dma_addr;
-}
-
-static void vdpasim_unmap_range(struct vdpasim *vdpasim, dma_addr_t dma_addr,
-				size_t size)
-{
-	spin_lock(&vdpasim->iommu_lock);
-	vhost_iotlb_del_range(&vdpasim->iommu[0], (u64)dma_addr,
-			      (u64)dma_addr + size - 1);
-	spin_unlock(&vdpasim->iommu_lock);
-
-	free_iova(&vdpasim->iova, iova_pfn(&vdpasim->iova, dma_addr));
-}
-
-static dma_addr_t vdpasim_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size,
-				   enum dma_data_direction dir,
-				   unsigned long attrs)
-{
-	struct vdpasim *vdpasim = dev_to_sim(dev);
-	phys_addr_t paddr = page_to_phys(page) + offset;
-	int perm = dir_to_perm(dir);
-
-	if (perm < 0)
-		return DMA_MAPPING_ERROR;
-
-	return vdpasim_map_range(vdpasim, paddr, size, perm);
-}
-
-static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
-			       size_t size, enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-	struct vdpasim *vdpasim = dev_to_sim(dev);
-
-	vdpasim_unmap_range(vdpasim, dma_addr, size);
-}
-
-static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
-				    dma_addr_t *dma_addr, gfp_t flag,
-				    unsigned long attrs)
-{
-	struct vdpasim *vdpasim = dev_to_sim(dev);
-	phys_addr_t paddr;
-	void *addr;
-
-	addr = kmalloc(size, flag);
-	if (!addr) {
-		*dma_addr = DMA_MAPPING_ERROR;
-		return NULL;
-	}
-
-	paddr = virt_to_phys(addr);
-
-	*dma_addr = vdpasim_map_range(vdpasim, paddr, size, VHOST_MAP_RW);
-	if (*dma_addr == DMA_MAPPING_ERROR) {
-		kfree(addr);
-		return NULL;
-	}
-
-	return addr;
-}
-
-static void vdpasim_free_coherent(struct device *dev, size_t size,
-				  void *vaddr, dma_addr_t dma_addr,
-				  unsigned long attrs)
-{
-	struct vdpasim *vdpasim = dev_to_sim(dev);
-
-	vdpasim_unmap_range(vdpasim, dma_addr, size);
-
-	kfree(vaddr);
-}
-
-static const struct dma_map_ops vdpasim_dma_ops = {
-	.map_page = vdpasim_map_page,
-	.unmap_page = vdpasim_unmap_page,
-	.alloc = vdpasim_alloc_coherent,
-	.free = vdpasim_free_coherent,
-};
-
 static const struct vdpa_config_ops vdpasim_config_ops;
 static const struct vdpa_config_ops vdpasim_batch_config_ops;
 
@@ -289,7 +158,6 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	dev->dma_mask = &dev->coherent_dma_mask;
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
 		goto err_iommu;
-	set_dma_ops(dev, &vdpasim_dma_ops);
 	vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
 
 	vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
@@ -306,6 +174,11 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	if (!vdpasim->iommu)
 		goto err_iommu;
 
+	vdpasim->iommu_pt = kmalloc_array(vdpasim->dev_attr.nas,
+					  sizeof(*vdpasim->iommu_pt), GFP_KERNEL);
+	if (!vdpasim->iommu_pt)
+		goto err_iommu;
+
 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
 		vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
 
@@ -317,13 +190,6 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 		vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
 				 &vdpasim->iommu_lock);
 
-	ret = iova_cache_get();
-	if (ret)
-		goto err_iommu;
-
-	/* For simplicity we use an IOVA allocator with byte granularity */
-	init_iova_domain(&vdpasim->iova, 1, 0);
-
 	vdpasim->vdpa.dma_dev = dev;
 
 	return vdpasim;
@@ -639,6 +505,7 @@ static int vdpasim_set_map(struct vdpa_device *vdpa, unsigned int asid,
 
 	iommu = &vdpasim->iommu[asid];
 	vhost_iotlb_reset(iommu);
+	vdpasim->iommu_pt[asid] = false;
 
 	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
 	     map = vhost_iotlb_itree_next(map, start, last)) {
@@ -667,6 +534,10 @@ static int vdpasim_dma_map(struct vdpa_device *vdpa, unsigned int asid,
 		return -EINVAL;
 
 	spin_lock(&vdpasim->iommu_lock);
+	if (vdpasim->iommu_pt[asid]) {
+		vhost_iotlb_reset(&vdpasim->iommu[asid]);
+		vdpasim->iommu_pt[asid] = false;
+	}
 	ret = vhost_iotlb_add_range_ctx(&vdpasim->iommu[asid], iova,
 					iova + size - 1, pa, perm, opaque);
 	spin_unlock(&vdpasim->iommu_lock);
@@ -682,6 +553,11 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
 	if (asid >= vdpasim->dev_attr.nas)
 		return -EINVAL;
 
+	if (vdpasim->iommu_pt[asid]) {
+		vhost_iotlb_reset(&vdpasim->iommu[asid]);
+		vdpasim->iommu_pt[asid] = false;
+	}
+
 	spin_lock(&vdpasim->iommu_lock);
 	vhost_iotlb_del_range(&vdpasim->iommu[asid], iova, iova + size - 1);
 	spin_unlock(&vdpasim->iommu_lock);
@@ -701,15 +577,11 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 		vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
 	}
 
-	if (vdpa_get_dma_dev(vdpa)) {
-		put_iova_domain(&vdpasim->iova);
-		iova_cache_put();
-	}
-
 	kvfree(vdpasim->buffer);
 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
 		vhost_iotlb_reset(&vdpasim->iommu[i]);
 	kfree(vdpasim->iommu);
+	kfree(vdpasim->iommu_pt);
 	kfree(vdpasim->vqs);
 	kfree(vdpasim->config);
 }
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index d2a08c0abad7..770ef3408619 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -64,7 +64,7 @@ struct vdpasim {
 	/* virtio config according to device type */
 	void *config;
 	struct vhost_iotlb *iommu;
-	struct iova_domain iova;
+	bool *iommu_pt;
 	void *buffer;
 	u32 status;
 	u32 generation;
-- 
2.25.1

