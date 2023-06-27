Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6B073F968
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjF0J6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjF0J6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:58:18 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558342D60;
        Tue, 27 Jun 2023 02:56:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qr0Fs2cCrz9v7HG;
        Tue, 27 Jun 2023 17:45:53 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.45.153.185])
        by APP1 (Coremail) with SMTP id LxC2BwBnwdzesZpknnvHAw--.39096S6;
        Tue, 27 Jun 2023 10:56:05 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR ARM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list),
        linux-mips@vger.kernel.org (open list:MIPS),
        iommu@lists.linux.dev (open list:XEN SWIOTLB SUBSYSTEM)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, petr@tesarici.cz
Subject: [PATCH v3 4/7] swiotlb: if swiotlb is full, fall back to a transient memory pool
Date:   Tue, 27 Jun 2023 11:54:26 +0200
Message-Id: <34c2a1ba721a7bc496128aac5e20724e4077f1ab.1687859323.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
References: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBnwdzesZpknnvHAw--.39096S6
X-Coremail-Antispam: 1UD129KBjvAXoW3Cr4UZr48ZrW8XFyfAry5urg_yoW8AryfXo
        W7CFn7Ww4fJryUCF45GFZ7GF47Za1kKF48AF4fuayqgayjvryYgrW3ta15X3sxur1xKFWx
        Ar1Sqa4fWF4xAry8n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOT7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
        Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
        84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
        WxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j
        6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
        C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
        6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
        8vn2kIc2xKxwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWx
        JrUvcSsGvfC2KfnxnUUI43ZEXa7VUU_Ma5UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

Try to allocate a transient memory pool if no suitable slots can be found,
except when allocating from a restricted pool. The transient pool is just
enough big for this one bounce buffer. It is inserted into a per-device
list of transient memory pools, and it is freed again when the bounce
buffer is unmapped.

Transient memory pools are kept in an RCU list. A memory barrier is
required after adding a new entry, because any address within a transient
buffer must be immediately recognized as belonging to the SWIOTLB, even if
it is passed to another CPU.

Deletion does not require any synchronization beyond RCU ordering
guarantees. After a buffer is unmapped, its physical addresses may no
longer be passed to the DMA API, so the memory range of the corresponding
stale entry in the RCU list never matches. If the memory range gets
allocated again, then it happens only after a RCU quiescent state.

Since bounce buffers can now be allocated from different pools, add a
parameter to swiotlb_alloc_pool() to let the caller know which memory pool
is used. Add swiotlb_find_pool() to find the memory pool corresponding to
an address. This function is now also used by is_swiotlb_buffer(), because
a simple boundary check is no longer sufficient.

The logic in swiotlb_alloc_tlb() is taken from __dma_direct_alloc_pages(),
simplified and enhanced to use coherent memory pools if needed.

Note that this is not the most efficient way to provide a bounce buffer,
but when a DMA buffer can't be mapped, something may (and will) actually
break. At that point it is better to make an allocation, even if it may be
an expensive operation.

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 include/linux/device.h      |   4 +
 include/linux/dma-mapping.h |   2 +
 include/linux/swiotlb.h     |  13 +-
 kernel/dma/direct.c         |   2 +-
 kernel/dma/swiotlb.c        | 265 ++++++++++++++++++++++++++++++++++--
 5 files changed, 272 insertions(+), 14 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 83081aa99e6a..a1ee4c5924b8 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -510,6 +510,8 @@ struct device_physical_location {
  * @dma_mem:	Internal for coherent mem override.
  * @cma_area:	Contiguous memory area for dma allocations
  * @dma_io_tlb_mem: Software IO TLB allocator.  Not for driver use.
+ * @dma_io_tlb_pools:	List of transient swiotlb memory pools.
+ * @dma_io_tlb_lock:	Protects changes to the list of active pools.
  * @archdata:	For arch-specific additions.
  * @of_node:	Associated device tree node.
  * @fwnode:	Associated device node supplied by platform firmware.
@@ -615,6 +617,8 @@ struct device {
 #endif
 #ifdef CONFIG_SWIOTLB
 	struct io_tlb_mem *dma_io_tlb_mem;
+	struct list_head dma_io_tlb_pools;
+	spinlock_t dma_io_tlb_lock;
 #endif
 	/* arch specific additions */
 	struct dev_archdata	archdata;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 0ee20b764000..c36c5a546787 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -417,6 +417,8 @@ static inline void dma_sync_sgtable_for_device(struct device *dev,
 #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
 #define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
 
+bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size);
+
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 0aa6868cb68c..ae1688438850 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -63,6 +63,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 
 /**
  * struct io_tlb_pool - IO TLB memory pool descriptor
+ * @node:	Member of the IO TLB memory pool list.
  * @start:	The start address of the swiotlb memory pool. Used to do a quick
  *		range check to see if the memory was in fact allocated by this
  *		API.
@@ -77,22 +78,27 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
  *		see setup_io_tlb_npages().
  * @used:	The number of used IO TLB slots.
  * @late_alloc:	%true if allocated using the page allocator.
+ * @transient:  %true if transient memory pool.
  * @nareas:	Number of areas in the pool.
  * @area_nslabs: Number of slots in each area.
  * @areas:	Array of memory area descriptors.
  * @slots:	Array of slot descriptors.
+ * @rcu:	RCU head for swiotlb_dyn_free().
  */
 struct io_tlb_pool {
+	struct list_head node;
 	phys_addr_t start;
 	phys_addr_t end;
 	void *vaddr;
 	unsigned long nslabs;
 	unsigned long used;
 	bool late_alloc;
+	bool transient;
 	unsigned int nareas;
 	unsigned int area_nslabs;
 	struct io_tlb_area *areas;
 	struct io_tlb_slot *slots;
+	struct rcu_head rcu;
 };
 
 /**
@@ -120,6 +126,8 @@ struct io_tlb_mem {
 #endif
 };
 
+struct io_tlb_pool *swiotlb_find_pool(struct device *dev, phys_addr_t paddr);
+
 /**
  * is_swiotlb_buffer() - check if a physical address belongs to a swiotlb
  * @dev:        Device which has mapped the buffer.
@@ -133,9 +141,8 @@ struct io_tlb_mem {
  */
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-
-	return mem && paddr >= mem->pool->start && paddr < mem->pool->end;
+	return dev->dma_io_tlb_mem &&
+		!!swiotlb_find_pool(dev, paddr);
 }
 
 static inline bool is_swiotlb_force_bounce(struct device *dev)
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5595d1d5cdcc..820561cab38d 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -66,7 +66,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 	return 0;
 }
 
-static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
+bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
 	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys);
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4c5de91bda57..06b4fa7c2e9b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -35,6 +35,7 @@
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/pfn.h>
+#include <linux/rculist.h>
 #include <linux/scatterlist.h>
 #include <linux/set_memory.h>
 #include <linux/spinlock.h>
@@ -500,6 +501,157 @@ void __init swiotlb_exit(void)
 	memset(mem, 0, sizeof(*mem));
 }
 
+/**
+ * alloc_dma_pages() - allocate pages to be used for DMA
+ * @gfp:	GFP flags for the allocation.
+ * @bytes:	Size of the buffer.
+ *
+ * Allocate pages from the buddy allocator. If successful, make the allocated
+ * pages decrypted that they can be used for DMA.
+ *
+ * Return: Decrypted pages, or %NULL on failure.
+ */
+static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes)
+{
+	unsigned int order = get_order(bytes);
+	struct page *page;
+	void *vaddr;
+
+	page = alloc_pages(gfp, order);
+	if (!page)
+		return NULL;
+
+	vaddr = page_address(page);
+	if (set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes))) {
+		__free_pages(page, order);
+		return NULL;
+	}
+
+	return page;
+}
+
+/**
+ * swiotlb_alloc_tlb() - allocate a dynamic IO TLB buffer
+ * @dev:	Device for which a memory pool is allocated.
+ * @bytes:	Size of the buffer.
+ * @phys_limit:	Maximum allowed physical address of the buffer.
+ * @gfp:	GFP flags for the allocation.
+ *
+ * Return: Allocated pages, or %NULL on allocation failure.
+ */
+static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
+		u64 phys_limit, gfp_t gfp)
+{
+	struct page *page;
+
+	/*
+	 * Allocate from the atomic pools if memory is encrypted and
+	 * the allocation is atomic, because decrypting may block.
+	 */
+	if (dev && force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp)) {
+		void *vaddr;
+
+		return IS_ENABLED(CONFIG_DMA_COHERENT_POOL)
+			? dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
+					      dma_coherent_ok)
+			: NULL;
+	}
+
+	gfp &= ~GFP_ZONEMASK;
+	if (phys_limit <= DMA_BIT_MASK(zone_dma_bits))
+		gfp |= __GFP_DMA;
+	else if (phys_limit <= DMA_BIT_MASK(32))
+		gfp |= __GFP_DMA32;
+
+	while ((page = alloc_dma_pages(gfp, bytes)) &&
+	       page_to_phys(page) + bytes - 1 > phys_limit) {
+		/* allocated, but too high */
+		__free_pages(page, get_order(bytes));
+
+		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
+		    phys_limit < DMA_BIT_MASK(64) &&
+		    !(gfp & (__GFP_DMA32 | __GFP_DMA)))
+			gfp |= __GFP_DMA32;
+		else if (IS_ENABLED(CONFIG_ZONE_DMA) &&
+			 !(gfp & __GFP_DMA))
+			gfp = (gfp & ~__GFP_DMA32) | __GFP_DMA;
+		else
+			return NULL;
+	}
+
+	return page;
+}
+
+/**
+ * swiotlb_free_tlb() - free a dynamically allocated IO TLB buffer
+ * @vaddr:	Virtual address of the buffer.
+ * @bytes:	Size of the buffer.
+ */
+static void swiotlb_free_tlb(void *vaddr, size_t bytes)
+{
+	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
+	    dma_free_from_pool(NULL, vaddr, bytes))
+		return;
+
+	/* Intentional leak if pages cannot be encrypted again. */
+	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
+		__free_pages(virt_to_page(vaddr), get_order(bytes));
+}
+
+/**
+ * swiotlb_alloc_pool() - allocate a new IO TLB memory pool
+ * @dev:	Device for which a memory pool is allocated.
+ * @nslabs:	Desired number of slabs.
+ * @phys_limit:	Maximum DMA buffer physical address.
+ * @gfp:	GFP flags for the allocations.
+ *
+ * Allocate and initialize a new IO TLB memory pool.
+ *
+ * Return: New memory pool, or %NULL on allocation failure.
+ */
+static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
+		unsigned int nslabs, u64 phys_limit, gfp_t gfp)
+{
+	struct io_tlb_pool *pool;
+	struct page *tlb;
+	size_t pool_size;
+	size_t tlb_size;
+
+	pool_size = sizeof(*pool) + array_size(sizeof(*pool->areas), 1) +
+		array_size(sizeof(*pool->slots), nslabs);
+	pool = kzalloc(pool_size, gfp);
+	if (!pool)
+		goto error;
+	pool->areas = (void *)pool + sizeof(*pool);
+	pool->slots = (void *)pool->areas + sizeof(*pool->areas);
+
+	tlb_size = nslabs << IO_TLB_SHIFT;
+	tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp);
+	if (!tlb)
+		goto error_tlb;
+
+	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), nslabs, true, 1);
+	return pool;
+
+error_tlb:
+	kfree(pool);
+error:
+	return NULL;
+}
+
+/**
+ * swiotlb_dyn_free() - RCU callback to free a memory pool
+ * @rcu:	RCU head in the corresponding struct io_tlb_pool.
+ */
+static void swiotlb_dyn_free(struct rcu_head *rcu)
+{
+	struct io_tlb_pool *pool = container_of(rcu, struct io_tlb_pool, rcu);
+	size_t tlb_size = pool->end - pool->start;
+
+	swiotlb_free_tlb(pool->vaddr, tlb_size);
+	kfree(pool);
+}
+
 /**
  * swiotlb_dev_init() - initialize swiotlb fields in &struct device
  * @dev:	Device to be initialized.
@@ -507,6 +659,56 @@ void __init swiotlb_exit(void)
 void swiotlb_dev_init(struct device *dev)
 {
 	dev->dma_io_tlb_mem = &io_tlb_default_mem;
+	INIT_LIST_HEAD(&dev->dma_io_tlb_pools);
+	spin_lock_init(&dev->dma_io_tlb_lock);
+}
+
+/**
+ * swiotlb_find_pool() - find the IO TLB pool for a physical address
+ * @dev:        Device which has mapped the DMA buffer.
+ * @paddr:      Physical address within the DMA buffer.
+ *
+ * Find the IO TLB memory pool descriptor which contains the given physical
+ * address, if any.
+ *
+ * Return: Memory pool which contains @paddr, or %NULL if none.
+ */
+struct io_tlb_pool *swiotlb_find_pool(struct device *dev, phys_addr_t paddr)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_pool *pool = mem->pool;
+
+	if (paddr >= pool->start && paddr < pool->end)
+		return pool;
+
+	/* Pairs with smp_wmb() in swiotlb_find_slots(). */
+	smp_rmb();
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(pool, &dev->dma_io_tlb_pools, node) {
+		if (paddr >= pool->start && paddr < pool->end)
+			goto out;
+	}
+	pool = NULL;
+out:
+	rcu_read_unlock();
+	return pool;
+}
+
+/**
+ * swiotlb_del_pool() - remove an IO TLB pool from a device
+ * @dev:	Owning device.
+ * @pool:	Memory pool to be removed.
+ */
+static void swiotlb_del_pool(struct device *dev, struct io_tlb_pool *pool)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->dma_io_tlb_lock, flags);
+	list_del_rcu(&pool->node);
+	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
+
+	call_rcu(&pool->rcu, swiotlb_dyn_free);
 }
 
 /*
@@ -523,7 +725,7 @@ static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
 static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
 			   enum dma_data_direction dir)
 {
-	struct io_tlb_pool *mem = dev->dma_io_tlb_mem->pool;
+	struct io_tlb_pool *mem = swiotlb_find_pool(dev, tlb_addr);
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
@@ -796,6 +998,7 @@ static int pool_find_slots(struct device *dev, struct io_tlb_pool *pool,
  * @alloc_size: Total requested size of the bounce buffer,
  *		including initial alignment padding.
  * @alloc_align_mask:	Required alignment of the allocated buffer.
+ * @retpool:	Used memory pool, updated on return.
  *
  * Search through the whole software IO TLB to find a sequence of slots that
  * match the allocation constraints.
@@ -803,10 +1006,46 @@ static int pool_find_slots(struct device *dev, struct io_tlb_pool *pool,
  * Return: Index of the first allocated slot, or -1 on error.
  */
 static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
-		size_t alloc_size, unsigned int alloc_align_mask)
+		size_t alloc_size, unsigned int alloc_align_mask,
+		struct io_tlb_pool **retpool)
 {
-	return pool_find_slots(dev, dev->dma_io_tlb_mem->pool, orig_addr,
-			       alloc_size, alloc_align_mask);
+	struct io_tlb_pool *pool;
+	unsigned long flags;
+	u64 phys_limit;
+	int index;
+
+	pool = dev->dma_io_tlb_mem->pool;
+	index = pool_find_slots(dev, pool, orig_addr,
+				alloc_size, alloc_align_mask);
+	if (index >= 0)
+		goto found;
+
+	if (dev->dma_io_tlb_mem->for_alloc)
+		return -1;
+
+	phys_limit = min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
+	pool = swiotlb_alloc_pool(dev, nr_slots(alloc_size), phys_limit,
+				  GFP_NOWAIT | __GFP_NOWARN);
+	if (!pool)
+		return -1;
+
+	index = pool_find_slots(dev, pool, orig_addr,
+				alloc_size, alloc_align_mask);
+	if (index < 0) {
+		swiotlb_dyn_free(&pool->rcu);
+		return -1;
+	}
+
+	pool->transient = true;
+	spin_lock_irqsave(&dev->dma_io_tlb_lock, flags);
+	list_add_rcu(&pool->node, &dev->dma_io_tlb_pools);
+	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
+
+	/* Pairs with smp_rmb() in swiotlb_find_pool(). */
+	smp_wmb();
+found:
+	*retpool = pool;
+	return index;
 }
 
 /**
@@ -869,7 +1108,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	}
 
 	index = swiotlb_find_slots(dev, orig_addr,
-				   alloc_size + offset, alloc_align_mask);
+				   alloc_size + offset, alloc_align_mask, &pool);
 	if (index == -1) {
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
@@ -883,7 +1122,6 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * This is needed when we sync the memory.  Then we sync the buffer if
 	 * needed.
 	 */
-	pool = mem->pool;
 	for (i = 0; i < nr_slots(alloc_size + offset); i++)
 		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
 	tlb_addr = slot_addr(pool->start, index) + offset;
@@ -900,7 +1138,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 
 static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 {
-	struct io_tlb_pool *mem = dev->dma_io_tlb_mem->pool;
+	struct io_tlb_pool *mem = swiotlb_find_pool(dev, tlb_addr);
 	unsigned long flags;
 	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
 	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
@@ -954,6 +1192,8 @@ void swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
 			      size_t mapping_size, enum dma_data_direction dir,
 			      unsigned long attrs)
 {
+	struct io_tlb_pool *pool;
+
 	/*
 	 * First, sync the memory before unmapping the entry
 	 */
@@ -961,7 +1201,13 @@ void swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
 	    (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_FROM_DEVICE);
 
-	swiotlb_release_slots(dev, tlb_addr);
+	pool = swiotlb_find_pool(dev, tlb_addr);
+	if (pool->transient) {
+		dec_used(dev->dma_io_tlb_mem, pool->nslabs);
+		swiotlb_del_pool(dev, pool);
+	} else {
+		swiotlb_release_slots(dev, tlb_addr);
+	}
 }
 
 void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
@@ -1145,11 +1391,10 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 	if (!mem)
 		return NULL;
 
-	index = swiotlb_find_slots(dev, 0, size, 0);
+	index = swiotlb_find_slots(dev, 0, size, 0, &pool);
 	if (index == -1)
 		return NULL;
 
-	pool = mem->pool;
 	tlb_addr = slot_addr(pool->start, index);
 
 	return pfn_to_page(PFN_DOWN(tlb_addr));
-- 
2.25.1

