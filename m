Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0020D67F65A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjA1IdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjA1IdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:33:13 -0500
Received: from out30-1.freemail.mail.aliyun.com (out30-1.freemail.mail.aliyun.com [115.124.30.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246E832E6A
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:33:09 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VaGx7Lw_1674894786;
Received: from localhost(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VaGx7Lw_1674894786)
          by smtp.aliyun-inc.com;
          Sat, 28 Jan 2023 16:33:06 +0800
From:   "GuoRui.Yu" <GuoRui.Yu@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, linux-coco@lists.linux.dev
Cc:     GuoRui.Yu@linux.alibaba.com, robin.murphy@arm.com
Subject: [PATCH 1/4] swiotlb: Split common code from swiotlb.{c,h}
Date:   Sat, 28 Jan 2023 16:32:51 +0800
Message-Id: <20230128083254.86012-2-GuoRui.Yu@linux.alibaba.com>
X-Mailer: git-send-email 2.29.2.540.g3cf59784d4
In-Reply-To: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
References: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split swiotlb_bounce, swiotlb_release_slots, and is_swiotlb_buffer from
swiotlb.{c,h} to common-swiotlb.c, and prepare for the new swiotlb
implementaion.

Signed-off-by: GuoRui.Yu <GuoRui.Yu@linux.alibaba.com>
---
 include/linux/swiotlb.h     | 10 ++---
 kernel/dma/Makefile         |  2 +-
 kernel/dma/common-swiotlb.c | 74 +++++++++++++++++++++++++++++++++
 kernel/dma/swiotlb.c        | 82 ++++---------------------------------
 4 files changed, 88 insertions(+), 80 deletions(-)
 create mode 100644 kernel/dma/common-swiotlb.c

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 35bc4e281c21..c5e74d3f9cbf 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -58,6 +58,9 @@ void swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
 		size_t size, enum dma_data_direction dir);
 dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
+void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
+			   enum dma_data_direction dir);
+void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr);
 
 #ifdef CONFIG_SWIOTLB
 
@@ -105,12 +108,7 @@ struct io_tlb_mem {
 };
 extern struct io_tlb_mem io_tlb_default_mem;
 
-static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
-{
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-
-	return mem && paddr >= mem->start && paddr < mem->end;
-}
+bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr);
 
 static inline bool is_swiotlb_force_bounce(struct device *dev)
 {
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index 21926e46ef4f..fc0ea13bc089 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_DMA_OPS)			+= dummy.o
 obj-$(CONFIG_DMA_CMA)			+= contiguous.o
 obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
-obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
+obj-$(CONFIG_SWIOTLB)			+= swiotlb.o common-swiotlb.o
 obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
 obj-$(CONFIG_MMU)			+= remap.o
 obj-$(CONFIG_DMA_MAP_BENCHMARK)		+= map_benchmark.o
diff --git a/kernel/dma/common-swiotlb.c b/kernel/dma/common-swiotlb.c
new file mode 100644
index 000000000000..d477d5f2a71b
--- /dev/null
+++ b/kernel/dma/common-swiotlb.c
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/dma-direct.h>
+#include <linux/swiotlb.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/swiotlb.h>
+
+/*
+ * Create a swiotlb mapping for the buffer at @paddr, and in case of DMAing
+ * to the device copy the data into it as well.
+ */
+dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	phys_addr_t swiotlb_addr;
+	dma_addr_t dma_addr;
+
+	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
+
+	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, size, 0, dir,
+			attrs);
+	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
+		return DMA_MAPPING_ERROR;
+
+	/* Ensure that the address returned is DMA'ble */
+	dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
+	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
+		swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
+			attrs | DMA_ATTR_SKIP_CPU_SYNC);
+		dev_WARN_ONCE(dev, 1,
+			"swiotlb addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
+			&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
+		return DMA_MAPPING_ERROR;
+	}
+
+	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(swiotlb_addr, size, dir);
+	return dma_addr;
+}
+
+/*
+ * tlb_addr is the physical address of the bounce buffer to unmap.
+ */
+void swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
+			      size_t mapping_size, enum dma_data_direction dir,
+			      unsigned long attrs)
+{
+	/*
+	 * First, sync the memory before unmapping the entry
+	 */
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
+		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_FROM_DEVICE);
+
+	swiotlb_release_slots(dev, tlb_addr);
+}
+
+void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, enum dma_data_direction dir)
+{
+	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+		swiotlb_bounce(dev, tlb_addr, size, DMA_TO_DEVICE);
+	else
+		BUG_ON(dir != DMA_FROM_DEVICE);
+}
+
+void swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, enum dma_data_direction dir)
+{
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		swiotlb_bounce(dev, tlb_addr, size, DMA_FROM_DEVICE);
+	else
+		BUG_ON(dir != DMA_TO_DEVICE);
+}
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a34c38bbe28f..f3ff4de08653 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -48,9 +48,6 @@
 #include <linux/slab.h>
 #endif
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/swiotlb.h>
-
 #define SLABS_PER_PAGE (1 << (PAGE_SHIFT - IO_TLB_SHIFT))
 
 /*
@@ -523,7 +520,7 @@ static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
 /*
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
-static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
+void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
 			   enum dma_data_direction dir)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
@@ -793,7 +790,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	return tlb_addr;
 }
 
-static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
+void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned long flags;
@@ -840,74 +837,6 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	spin_unlock_irqrestore(&area->lock, flags);
 }
 
-/*
- * tlb_addr is the physical address of the bounce buffer to unmap.
- */
-void swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
-			      size_t mapping_size, enum dma_data_direction dir,
-			      unsigned long attrs)
-{
-	/*
-	 * First, sync the memory before unmapping the entry
-	 */
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_FROM_DEVICE);
-
-	swiotlb_release_slots(dev, tlb_addr);
-}
-
-void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
-		size_t size, enum dma_data_direction dir)
-{
-	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
-		swiotlb_bounce(dev, tlb_addr, size, DMA_TO_DEVICE);
-	else
-		BUG_ON(dir != DMA_FROM_DEVICE);
-}
-
-void swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
-		size_t size, enum dma_data_direction dir)
-{
-	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
-		swiotlb_bounce(dev, tlb_addr, size, DMA_FROM_DEVICE);
-	else
-		BUG_ON(dir != DMA_TO_DEVICE);
-}
-
-/*
- * Create a swiotlb mapping for the buffer at @paddr, and in case of DMAing
- * to the device copy the data into it as well.
- */
-dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir, unsigned long attrs)
-{
-	phys_addr_t swiotlb_addr;
-	dma_addr_t dma_addr;
-
-	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
-
-	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, size, 0, dir,
-			attrs);
-	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
-		return DMA_MAPPING_ERROR;
-
-	/* Ensure that the address returned is DMA'ble */
-	dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
-	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
-		swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
-			attrs | DMA_ATTR_SKIP_CPU_SYNC);
-		dev_WARN_ONCE(dev, 1,
-			"swiotlb addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
-			&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
-		return DMA_MAPPING_ERROR;
-	}
-
-	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arch_sync_dma_for_device(swiotlb_addr, size, dir);
-	return dma_addr;
-}
-
 size_t swiotlb_max_mapping_size(struct device *dev)
 {
 	int min_align_mask = dma_get_min_align_mask(dev);
@@ -924,6 +853,13 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE - min_align;
 }
 
+bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+
+	return mem && paddr >= mem->start && paddr < mem->end;
+}
+
 bool is_swiotlb_active(struct device *dev)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-- 
2.31.1

