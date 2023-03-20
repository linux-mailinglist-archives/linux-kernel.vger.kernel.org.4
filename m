Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2E6C11E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjCTM34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjCTM3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:29:48 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473D427D6C;
        Mon, 20 Mar 2023 05:29:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PgDMv19cBz9y4Sr;
        Mon, 20 Mar 2023 20:20:27 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.48.148.162])
        by APP2 (Coremail) with SMTP id GxC2BwBnOF9kURhkkqGyAQ--.46782S5;
        Mon, 20 Mar 2023 13:28:59 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS)
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
Subject: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce buffers
Date:   Mon, 20 Mar 2023 13:28:15 +0100
Message-Id: <0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnOF9kURhkkqGyAQ--.46782S5
X-Coremail-Antispam: 1UD129KBjvAXoW3ZFykKry5CFyxCr17uFyxAFb_yoW8Jr1fto
        WxAF13Wr1fKw1UGrZ0kFZrJF47Zayvka1rAr4fZ3yYga9FyryYgw12gF4rJwn3Ww18KFWx
        Ar9Iga48Xan7Ar48n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOe7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
        Wl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0264kExV
        AvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
        W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
        07jeKZXUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

The software IO TLB was designed with the assumption that it is not
used much, especially on 64-bit systems, so a small fixed memory
area (currently 64 MiB) is sufficient to handle the few cases which
still require a bounce buffer. However, these cases are not so rare
in some circumstances.

First, if SEV is active, all DMA must be done through shared
unencrypted pages, and SWIOTLB is used to make this happen without
changing device drivers. The software IO TLB size is increased to
6% of total memory in sev_setup_arch(), but that is more of an
approximation. The actual requirements may vary depending on which
drivers are used and the amount of I/O.

Second, on the Raspberry Pi 4, swiotlb is used by dma-buf for pages
moved from the rendering GPU (v3d driver), which can access all
memory, to the display output (vc4 driver), which is connected to a
bus with an address limit of 1 GiB and no IOMMU. These buffers can
be large (several megabytes) and cannot be handled by SWIOTLB,
because they exceed maximum segment size of 256 KiB. Such mapping
failures can be easily reproduced on a Raspberry Pi4: Starting
GNOME remote desktop results in a flood of kernel messages like
these:

[  387.937625] vc4-drm gpu: swiotlb buffer is full (sz: 524288 bytes), total 32768 (slots), used 3136 (slots)
[  387.960381] vc4-drm gpu: swiotlb buffer is full (sz: 815104 bytes), total 32768 (slots), used 2 (slots)

This second example cannot be even solved without increasing the
segment size (and the complexity of {map,unmap}_single size). At
that point, it's better to allocate bounce buffers dynamically with
dma_direct_alloc_pages().

One caveat is that the DMA API often takes only the address of a
buffer, and the implementation (direct or IOMMU) checks whether it
belongs to the software IO TLB. This is easy if the IO TLB is a
single chunk of physically contiguous memory, but not if some
buffers are allocated dynamically. Testing on a Raspberry Pi 4
shows that there can be 1k+ such buffers. This requires something
better than a linked list. I'm using a maple tree to track
dynamically allocated buffers. This data structure was invented for
a similar use case, but there are some challenges:

1. The value is limited to ULONG_MAX, which is too little both for
   physical addresses (e.g. x86 PAE or 32-bit ARM LPAE) and DMA
   addresses (e.g. Xen guests on 32-bit ARM).

2. Since buffers are currently allocated with page granularity, a
   PFN can be used instead. However, some values are reserved by
   the maple tree implementation. Liam suggests to use
   xa_mk_value() in that case, but that reduces the usable range by
   half. Luckily, 31 bits are still enough to hold a PFN on all
   32-bit platforms.

3. Software IO TLB is used from interrupt context. The maple tree
   implementation is not IRQ-safe (MT_FLAGS_LOCK_IRQ does nothing
   AFAICS). Instead, I use an external lock, spin_lock_irqsave() and
   spin_unlock_irqrestore().

Note that bounce buffers are never allocated dynamically if the
software IO TLB is in fact a DMA restricted pool, which is intended
to be stay in its designated location in physical memory.

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 include/linux/swiotlb.h |  11 ++-
 kernel/dma/swiotlb.c    | 156 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 157 insertions(+), 10 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index b71adba03dc7..0ef27d6491b9 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/limits.h>
+#include <linux/maple_tree.h>
 #include <linux/spinlock.h>
 
 struct device;
@@ -87,6 +88,8 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
  * @for_alloc:  %true if the pool is used for memory allocation
  * @nareas:  The area number in the pool.
  * @area_nslabs: The slot number in the area.
+ * @dyn_lock:	Protect dynamically allocated slots.
+ * @dyn_slots:	Dynamically allocated slots.
  */
 struct io_tlb_mem {
 	phys_addr_t start;
@@ -102,9 +105,13 @@ struct io_tlb_mem {
 	unsigned int area_nslabs;
 	struct io_tlb_area *areas;
 	struct io_tlb_slot *slots;
+	spinlock_t dyn_lock;
+	struct maple_tree dyn_slots;
 };
 extern struct io_tlb_mem io_tlb_default_mem;
 
+bool is_swiotlb_dyn(struct io_tlb_mem *mem, phys_addr_t paddr);
+
 static inline bool is_swiotlb_fixed(struct io_tlb_mem *mem, phys_addr_t paddr)
 {
 	return paddr >= mem->start && paddr < mem->end;
@@ -114,7 +121,9 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 
-	return mem && is_swiotlb_fixed(mem, paddr);
+	return mem &&
+		(is_swiotlb_fixed(mem, paddr) ||
+		 is_swiotlb_dyn(mem, paddr));
 }
 
 static inline bool is_swiotlb_force_bounce(struct device *dev)
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e8608bcb205e..c6a0b8f2aa6f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -41,6 +41,7 @@
 #include <linux/string.h>
 #include <linux/swiotlb.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 #include <linux/of.h>
 #include <linux/of_fdt.h>
@@ -68,6 +69,13 @@ struct io_tlb_slot {
 	unsigned int list;
 };
 
+struct io_tlb_dyn_slot {
+	phys_addr_t orig_addr;
+	size_t alloc_size;
+	struct page *page;
+	dma_addr_t dma_addr;
+};
+
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
 
@@ -292,6 +300,10 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 		mem->slots[i].alloc_size = 0;
 	}
 
+	spin_lock_init(&mem->dyn_lock);
+	mt_init_flags(&mem->dyn_slots, MT_FLAGS_LOCK_EXTERN);
+	mt_set_external_lock(&mem->dyn_slots, &mem->dyn_lock);
+
 	/*
 	 * If swiotlb_unencrypted_base is set, the bounce buffer memory will
 	 * be remapped and cleared in swiotlb_update_mem_attributes.
@@ -516,6 +528,115 @@ void __init swiotlb_exit(void)
 	memset(mem, 0, sizeof(*mem));
 }
 
+static struct io_tlb_dyn_slot *swiotlb_dyn_slot(struct io_tlb_mem *mem,
+						phys_addr_t paddr)
+{
+	unsigned long index = (uintptr_t)xa_mk_value(PHYS_PFN(paddr));
+	struct io_tlb_dyn_slot *slot;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mem->dyn_lock, flags);
+	slot = mt_find(&mem->dyn_slots, &index, index);
+	spin_unlock_irqrestore(&mem->dyn_lock, flags);
+	return slot;
+}
+
+bool is_swiotlb_dyn(struct io_tlb_mem *mem, phys_addr_t paddr)
+{
+	return !!swiotlb_dyn_slot(mem, paddr);
+}
+
+static void swiotlb_dyn_bounce(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, enum dma_data_direction dir)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_dyn_slot *slot = swiotlb_dyn_slot(mem, tlb_addr);
+	unsigned int tlb_offset;
+	unsigned char *vaddr;
+
+	if (!slot)
+		return;
+
+	tlb_offset = tlb_addr - page_to_phys(slot->page);
+	vaddr = page_address(slot->page) + tlb_offset;
+
+	swiotlb_copy(dev, slot->orig_addr, vaddr, size, slot->alloc_size,
+		     tlb_offset, dir);
+}
+
+static phys_addr_t swiotlb_dyn_map(struct device *dev, phys_addr_t orig_addr,
+		size_t alloc_size, unsigned int alloc_align_mask,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_dyn_slot *slot;
+	unsigned long index;
+	unsigned long flags;
+	phys_addr_t paddr;
+	gfp_t gfp;
+	int err;
+
+	/* Allocation has page granularity. Avoid small buffers. */
+	if (alloc_size < PAGE_SIZE)
+		goto err;
+
+	/* DMA direct does not deal with physical address constraints. */
+	if (alloc_align_mask || dma_get_min_align_mask(dev))
+		goto err;
+
+	gfp = (attrs & DMA_ATTR_MAY_SLEEP) ? GFP_KERNEL : GFP_NOWAIT;
+	slot = kmalloc(sizeof(*slot), gfp | __GFP_NOWARN);
+	if (!slot)
+		goto err;
+
+	slot->orig_addr = orig_addr;
+	slot->alloc_size = alloc_size;
+	slot->page = dma_direct_alloc_pages(dev, PAGE_ALIGN(alloc_size),
+					    &slot->dma_addr, dir,
+					    gfp | __GFP_NOWARN);
+	if (!slot->page)
+		goto err_free_slot;
+
+	paddr = page_to_phys(slot->page);
+	index = (uintptr_t)xa_mk_value(PHYS_PFN(paddr));
+	spin_lock_irqsave(&mem->dyn_lock, flags);
+	err = mtree_store_range(&mem->dyn_slots, index,
+				index + PFN_UP(alloc_size) - 1,
+				slot, GFP_NOWAIT | __GFP_NOWARN);
+	spin_unlock_irqrestore(&mem->dyn_lock, flags);
+	if (err)
+		goto err_free_dma;
+
+	return paddr;
+
+err_free_dma:
+	dma_direct_free_pages(dev, slot->alloc_size, slot->page,
+			      slot->dma_addr, dir);
+
+err_free_slot:
+	kfree(slot);
+err:
+	return (phys_addr_t)DMA_MAPPING_ERROR;
+}
+
+static void swiotlb_dyn_unmap(struct device *dev, phys_addr_t tlb_addr,
+			      enum dma_data_direction dir)
+{
+	unsigned long index = (uintptr_t)xa_mk_value(PHYS_PFN(tlb_addr));
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_dyn_slot *slot;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mem->dyn_lock, flags);
+	slot = mt_find(&mem->dyn_slots, &index, index);
+	mtree_erase(&mem->dyn_slots, index);
+	spin_unlock_irqrestore(&mem->dyn_lock, flags);
+
+	dma_direct_free_pages(dev, slot->alloc_size, slot->page,
+			      slot->dma_addr, dir);
+	kfree(slot);
+}
+
 /*
  * Return the offset into a iotlb slot required to keep the device happy.
  */
@@ -524,11 +645,8 @@ static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
 	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
 }
 
-/*
- * Bounce: copy the swiotlb buffer from or back to the original dma location
- */
-static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
-			   enum dma_data_direction dir)
+static void swiotlb_fixed_bounce(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, enum dma_data_direction dir)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
@@ -608,6 +726,18 @@ static void swiotlb_copy(struct device *dev, phys_addr_t orig_addr,
 	}
 }
 
+/*
+ * Bounce: copy the swiotlb buffer from or back to the original dma location
+ */
+static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
+			   enum dma_data_direction dir)
+{
+	if (is_swiotlb_fixed(dev->dma_io_tlb_mem, tlb_addr))
+		swiotlb_fixed_bounce(dev, tlb_addr, size, dir);
+	else
+		swiotlb_dyn_bounce(dev, tlb_addr, size, dir);
+}
+
 static inline phys_addr_t slot_addr(phys_addr_t start, phys_addr_t idx)
 {
 	return start + (idx << IO_TLB_SHIFT);
@@ -799,8 +929,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
-	tlb_addr = swiotlb_fixed_map(dev, orig_addr, alloc_size,
-				     alloc_align_mask, attrs);
+	tlb_addr = (phys_addr_t)DMA_MAPPING_ERROR;
+	if (!is_swiotlb_for_alloc(dev))
+		tlb_addr = swiotlb_dyn_map(dev, orig_addr, alloc_size,
+					   alloc_align_mask, dir, attrs);
+	if (tlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
+		tlb_addr = swiotlb_fixed_map(dev, orig_addr, alloc_size,
+					     alloc_align_mask, attrs);
 
 	if (tlb_addr == (phys_addr_t)DMA_MAPPING_ERROR) {
 		if (!(attrs & DMA_ATTR_NO_WARN))
@@ -882,7 +1017,10 @@ void swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
 	    (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_FROM_DEVICE);
 
-	swiotlb_release_slots(dev, tlb_addr);
+	if (is_swiotlb_fixed(dev->dma_io_tlb_mem, tlb_addr))
+		swiotlb_release_slots(dev, tlb_addr);
+	else
+		swiotlb_dyn_unmap(dev, tlb_addr, dir);
 }
 
 void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
@@ -1013,7 +1151,7 @@ bool swiotlb_free(struct device *dev, struct page *page, size_t size)
 {
 	phys_addr_t tlb_addr = page_to_phys(page);
 
-	if (!is_swiotlb_buffer(dev, tlb_addr))
+	if (!is_swiotlb_fixed(dev->dma_io_tlb_mem, tlb_addr))
 		return false;
 
 	swiotlb_release_slots(dev, tlb_addr);
-- 
2.25.1

