Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108D167F65B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjA1IdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjA1IdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:33:15 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C616932E76
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:33:11 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VaH.9zi_1674894787;
Received: from localhost(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VaH.9zi_1674894787)
          by smtp.aliyun-inc.com;
          Sat, 28 Jan 2023 16:33:08 +0800
From:   "GuoRui.Yu" <GuoRui.Yu@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, linux-coco@lists.linux.dev
Cc:     GuoRui.Yu@linux.alibaba.com, robin.murphy@arm.com
Subject: [PATCH 2/4] swiotlb: Add a new cc-swiotlb implementation for Confidential VMs
Date:   Sat, 28 Jan 2023 16:32:52 +0800
Message-Id: <20230128083254.86012-3-GuoRui.Yu@linux.alibaba.com>
X-Mailer: git-send-email 2.29.2.540.g3cf59784d4
In-Reply-To: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
References: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under COnfidential COmputing (CoCo) scenarios, the VMM cannot access
guest memory directly but requires the guest to explicitly mark the
memory as shared (decrypted). To make the streaming DMA mappings work,
the current implementation relays on legacy SWIOTLB to bounce the DMA
buffer between private (encrypted) and shared (decrypted) memory.

However, the legacy swiotlb is designed for compatibility rather than
efficiency and CoCo purpose, which will inevitably introduce some
unnecessary restrictions.
1. Fixed immutable swiotlb size cannot accommodate to requirements of
   multiple devices. And 1GiB (current maximum size) of swiotlb in our
   testbed cannot afford multiple disks reads/writes simultaneously.
2. Fixed immutable IO_TLB_SIZE (2KiB) cannot satisfy various kinds of
   devices. At the moment, the minimal size of a swiotlb buffer is 2KiB,
   which will waste memory on small network packets (under 512 bytes)
   and decrease efficiency on a large block (up to 256KiB) size
   reads/writes of disks. And it is hard to have a trade-off on legacy
   swiotlb to rule them all.
3. The legacy swiotlb cannot efficiently support larger swiotlb buffers.
   In the worst case, the current implementation requires a full scan of
   the entire swiotlb buffer, which can cause severe performance hits.

Instead of keeping "infecting" the legacy swiotlb code with CoCo logic,
this patch tries to introduce a new cc-swiotlb for Confidential VMs.

Confidential VMs usually have reasonable modern devices (virtio devices,
NVME, etc.), which can access memory above 4GiB, cc-swiotlb could
allocate TLB buffers dynamically on-demand, and this design solves
problem 1.

In addition, the cc-swiotlb manages TLB buffers by different sizes
(512B, 2KiB, 4KiB, 16KiB, and 512KiB), which solves problems 2 and 3.

Signed-off-by: GuoRui.Yu <GuoRui.Yu@linux.alibaba.com>
---
 arch/x86/Kconfig             |   3 +-
 arch/x86/include/asm/iommu.h |   2 +-
 arch/x86/kernel/pci-dma.c    |   6 +-
 drivers/base/core.c          |   2 +-
 drivers/iommu/amd/Kconfig    |   2 +-
 drivers/iommu/dma-iommu.c    |   2 +-
 drivers/iommu/intel/Kconfig  |   2 +-
 include/linux/device.h       |   2 +-
 include/linux/swiotlb.h      |  19 +-
 kernel/dma/Kconfig           |  10 +
 kernel/dma/Makefile          |   1 +
 kernel/dma/cc-swiotlb.c      | 492 +++++++++++++++++++++++++++++++++++
 kernel/dma/common-swiotlb.c  |   1 +
 kernel/dma/direct.c          |   4 +-
 kernel/dma/direct.h          |   4 +-
 15 files changed, 537 insertions(+), 15 deletions(-)
 create mode 100644 kernel/dma/cc-swiotlb.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..bce367fc4b55 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -31,7 +31,7 @@ config X86_64
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
-	select SWIOTLB
+	select SWIOTLB if !X86_MEM_ENCRYPT
 	select ARCH_HAS_ELFCORE_COMPAT
 	select ZONE_DMA32
 
@@ -1535,6 +1535,7 @@ config X86_CPA_STATISTICS
 config X86_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select DYNAMIC_PHYSICAL_MASK
+	select SWIOTLB if !CC_SWIOTLB
 	def_bool n
 
 config AMD_MEM_ENCRYPT
diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index 2fd52b65deac..a4fbe92b2321 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -11,7 +11,7 @@ extern int iommu_detected;
 extern int iommu_merge;
 extern int panic_on_overflow;
 
-#ifdef CONFIG_SWIOTLB
+#if defined(CONFIG_SWIOTLB) || defined(CONFIG_CC_SWIOTLB)
 extern bool x86_swiotlb_enable;
 #else
 #define x86_swiotlb_enable false
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 30bbe4abb5d6..41ad97bfc5be 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -37,7 +37,7 @@ int no_iommu __read_mostly;
 /* Set this to 1 if there is a HW IOMMU in the system */
 int iommu_detected __read_mostly = 0;
 
-#ifdef CONFIG_SWIOTLB
+#if defined(CONFIG_SWIOTLB) || defined(CONFIG_CC_SWIOTLB)
 bool x86_swiotlb_enable;
 static unsigned int x86_swiotlb_flags;
 
@@ -169,7 +169,7 @@ static __init int iommu_setup(char *p)
 			disable_dac_quirk = true;
 			return 1;
 		}
-#ifdef CONFIG_SWIOTLB
+#if defined(CONFIG_SWIOTLB) || defined(CONFIG_CC_SWIOTLB)
 		if (!strncmp(p, "soft", 4))
 			x86_swiotlb_enable = true;
 #endif
@@ -192,7 +192,7 @@ static int __init pci_iommu_init(void)
 {
 	x86_init.iommu.iommu_init();
 
-#ifdef CONFIG_SWIOTLB
+#if defined(CONFIG_SWIOTLB) || defined(CONFIG_CC_SWIOTLB)
 	/* An IOMMU turned us off. */
 	if (x86_swiotlb_enable) {
 		pr_info("PCI-DMA: Using software bounce buffering for IO (SWIOTLB)\n");
diff --git a/drivers/base/core.c b/drivers/base/core.c
index a3e14143ec0c..0a0b35f8b5c3 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2955,7 +2955,7 @@ void device_initialize(struct device *dev)
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	dev->dma_coherent = dma_default_coherent;
 #endif
-#ifdef CONFIG_SWIOTLB
+#if defined(CONFIG_SWIOTLB) || defined(CONFIG_CC_SWIOTLB)
 	dev->dma_io_tlb_mem = &io_tlb_default_mem;
 #endif
 }
diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 9b5fc3356bf2..f8dcb67d02cc 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -2,7 +2,7 @@
 # AMD IOMMU support
 config AMD_IOMMU
 	bool "AMD IOMMU support"
-	select SWIOTLB
+	select SWIOTLB if !X86_MEM_ENCRYPT
 	select PCI_MSI
 	select PCI_ATS
 	select PCI_PRI
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f798c44e0903..06f6ad1ef59c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -519,7 +519,7 @@ static bool dev_is_untrusted(struct device *dev)
 
 static bool dev_use_swiotlb(struct device *dev)
 {
-	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
+	return (IS_ENABLED(CONFIG_SWIOTLB) || IS_ENABLED(CONFIG_CC_SWIOTLB)) && dev_is_untrusted(dev);
 }
 
 /**
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index b7dff5092fd2..1f56f78b1880 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -17,7 +17,7 @@ config INTEL_IOMMU
 	select IOMMU_IOVA
 	select NEED_DMA_MAP_STATE
 	select DMAR_TABLE
-	select SWIOTLB
+	select SWIOTLB if !X86_MEM_ENCRYPT
 	select IOASID
 	select PCI_ATS
 	select PCI_PRI
diff --git a/include/linux/device.h b/include/linux/device.h
index 44e3acae7b36..b5b082d7d1de 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -607,7 +607,7 @@ struct device {
 	struct cma *cma_area;		/* contiguous memory area for dma
 					   allocations */
 #endif
-#ifdef CONFIG_SWIOTLB
+#if defined(CONFIG_SWIOTLB) || defined(CONFIG_CC_SWIOTLB)
 	struct io_tlb_mem *dma_io_tlb_mem;
 #endif
 	/* arch specific additions */
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index c5e74d3f9cbf..0384784ebce4 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -106,6 +106,23 @@ struct io_tlb_mem {
 	struct io_tlb_area *areas;
 	struct io_tlb_slot *slots;
 };
+#elif defined(CONFIG_CC_SWIOTLB)
+
+/**
+ * struct io_tlb_mem - io tlb memory pool descriptor
+ *
+ * @force_bounce: %true if swiotlb bouncing is forced
+ * @mapping: the mapping relations between the END address of backing memory and
+ * 	     original DMA address.
+ */
+struct io_tlb_mem {
+	bool force_bounce;
+	struct xarray* mapping;
+	struct dentry *debugfs;
+};
+#endif
+
+#if defined(CONFIG_SWIOTLB) || defined(CONFIG_CC_SWIOTLB)
 extern struct io_tlb_mem io_tlb_default_mem;
 
 bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr);
@@ -155,7 +172,7 @@ static inline bool is_swiotlb_active(struct device *dev)
 static inline void swiotlb_adjust_size(unsigned long size)
 {
 }
-#endif /* CONFIG_SWIOTLB */
+#endif /* CONFIG_SWIOTLB || CONFIG_CC_SWIOTLB */
 
 extern void swiotlb_print_info(void);
 
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 56866aaa2ae1..7e6b20d2091f 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -78,8 +78,18 @@ config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 
 config SWIOTLB
 	bool
+	depends on !CC_SWIOTLB
 	select NEED_DMA_MAP_STATE
 
+config CC_SWIOTLB
+	bool "Enable cc-swiotlb for Confidential VMs"
+	default n
+	select NEED_DMA_MAP_STATE
+	help
+	  This enables a cc-swiotlb implementation for Confidential VMs,
+	  which allows allocating the SWIOTLB buffer allocation on runtime.
+	  If unsure, say "n".
+
 config DMA_RESTRICTED_POOL
 	bool "DMA Restricted Pool"
 	depends on OF && OF_RESERVED_MEM && SWIOTLB
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index fc0ea13bc089..80c68292da3d 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_DMA_CMA)			+= contiguous.o
 obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o common-swiotlb.o
+obj-$(CONFIG_CC_SWIOTLB)		+= cc-swiotlb.o common-swiotlb.o
 obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
 obj-$(CONFIG_MMU)			+= remap.o
 obj-$(CONFIG_DMA_MAP_BENCHMARK)		+= map_benchmark.o
diff --git a/kernel/dma/cc-swiotlb.c b/kernel/dma/cc-swiotlb.c
new file mode 100644
index 000000000000..e85d3ce2272f
--- /dev/null
+++ b/kernel/dma/cc-swiotlb.c
@@ -0,0 +1,492 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Confiditial Computing VM DMA mapping support.
+ * Copyright (C) 2023 Guorui Yu <GuoRui.Yu@linux.alibaba.com>
+ */
+
+#define pr_fmt(fmt) "cc-swiotlb: " fmt
+
+#include <linux/cc_platform.h>
+#include <linux/types.h>
+#include <linux/ctype.h>
+#include <linux/init.h>
+#include <linux/printk.h>
+#include <linux/xarray.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/io.h>
+#include <linux/dma-direct.h>
+#include <linux/set_memory.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
+#include <linux/highmem.h>
+#include <linux/pfn.h>
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#endif
+
+#include <linux/swiotlb.h>
+
+#define INVALID_PHYS_ADDR (~(phys_addr_t)0)
+
+struct io_tlb_slot {
+	phys_addr_t orig_addr;
+	unsigned int alloc_size;
+	unsigned int orig_size;
+	struct list_head node;
+	void *va;
+};
+
+struct io_tlb_mem io_tlb_default_mem;
+static struct task_struct *kccd_tsk;
+static DECLARE_WAIT_QUEUE_HEAD(kccd_waitq);
+
+enum SLOT_SIZE {
+	SIZE_512B,
+	SIZE_2K,
+	SIZE_4K,
+	SIZE_16K,
+	SIZE_512K,
+	NR_OF_SIZES
+};
+
+const unsigned int SLOT_SIZES[NR_OF_SIZES] = {512, 2048, 4096, 16 * 1024, 512 * 1024};
+unsigned int WATERMARK_SLOT_SIZE[NR_OF_SIZES] = {256, 16384, 8192, 1024, 32};
+
+struct slot_terrace {
+	struct list_head slots_by_size[NR_OF_SIZES];
+	spinlock_t lock_by_size[NR_OF_SIZES];
+	atomic_t free_count_by_size[NR_OF_SIZES];
+	atomic_t total_count_by_size[NR_OF_SIZES];
+};
+
+static struct slot_terrace terrace;
+
+bool is_swiotlb_active(struct device *dev)
+{
+	return dev->dma_io_tlb_mem->mapping != NULL;
+}
+EXPORT_SYMBOL_GPL(is_swiotlb_active);
+
+bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_slot *slot;
+	phys_addr_t slot_end = paddr;
+	bool found = false;
+
+	if (!is_swiotlb_active(dev))
+		return false;
+
+	slot = xa_find_after(mem->mapping, (unsigned long*)&slot_end, ULONG_MAX, XA_PRESENT);
+	if (slot && slot_end - slot->orig_size <= paddr && paddr < slot_end)
+		found = true;
+
+	return found;
+}
+
+static inline ssize_t tr_index(size_t size, unsigned long align_mask) {
+	ssize_t i;
+
+	for (i = 0; i < NR_OF_SIZES; i++) {
+		if (size <= SLOT_SIZES[i] && !(align_mask & SLOT_SIZES[i]))
+			break;
+	}
+	if (unlikely(i == NR_OF_SIZES)) {
+		WARN(1, "Try to allocate too large TLB with size %zu align_mask %lx\n", size, align_mask);
+		return -ENOMEM;
+	}
+	return i;
+}
+
+static bool cc_should_populate(void)
+{
+	size_t i;
+
+	for (i = 0; i < NR_OF_SIZES; i++) {
+		if (atomic_read(&terrace.free_count_by_size[i]) < WATERMARK_SLOT_SIZE[i] / 2)
+			return true;
+	}
+	return false;
+}
+
+static struct io_tlb_slot *__cc_alloc_slot_from_list(size_t alloc_size, unsigned long align_mask)
+{
+	struct io_tlb_slot *slot = NULL;
+	unsigned long flags;
+	spinlock_t *lock;
+	struct list_head *head;
+	atomic_t *count;
+	ssize_t i;
+
+	i = tr_index(alloc_size, align_mask);
+	if (unlikely(i < 0))
+		return NULL;
+
+	lock = &terrace.lock_by_size[i];
+	head = &terrace.slots_by_size[i];
+	count = &terrace.free_count_by_size[i];
+
+	spin_lock_irqsave(lock, flags);
+
+	if (list_empty(head)) {
+		spin_unlock_irqrestore(lock, flags);
+		return NULL;
+	}
+
+	slot = list_first_entry(head, struct io_tlb_slot, node);
+	list_del_init(&slot->node);
+	atomic_dec(count);
+
+	spin_unlock_irqrestore(lock, flags);
+
+	if (cc_should_populate())
+		wake_up(&kccd_waitq);
+
+	return slot;
+}
+
+static void __cc_free_slot_to_list(struct io_tlb_slot *slot)
+{
+	unsigned long flags;
+	ssize_t i;
+
+	for (i = 0; i < NR_OF_SIZES; i++) {
+		if (slot->orig_size <= SLOT_SIZES[i])
+			break;
+	}
+
+	slot->orig_addr = INVALID_PHYS_ADDR;
+	slot->alloc_size = 0;
+
+	spin_lock_irqsave(&terrace.lock_by_size[i], flags);
+	list_add(&slot->node, &terrace.slots_by_size[i]);
+	atomic_inc(&terrace.free_count_by_size[i]);
+	spin_unlock_irqrestore(&terrace.lock_by_size[i], flags);
+}
+
+/*
+ * Bounce: copy the swiotlb buffer from or back to the original dma location
+ */
+void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
+			   enum dma_data_direction dir)
+{
+	phys_addr_t orig_addr, tlb_end, slot_start, slot_end = tlb_addr ;
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_slot *slot;
+	unsigned long pfn;
+	void *backing_addr;
+	size_t alloc_size;
+
+	slot = xa_find_after(mem->mapping, (unsigned long*)&slot_end, ULONG_MAX, XA_PRESENT);
+	if (!slot) {
+		dev_WARN_ONCE(dev, 1, "TLB buffer not found.\n");
+		return;
+	}
+
+	orig_addr = slot->orig_addr;
+	alloc_size = slot->alloc_size;
+	slot_start = slot_end - slot->orig_size;
+	tlb_end = tlb_addr + size;
+
+	pfn = PFN_DOWN(orig_addr);
+	if (PageHighMem(pfn_to_page(pfn))) {
+		dev_WARN_ONCE(dev, 1, "Unexpected high memory.\n");
+		return;
+	}
+
+	if (size > alloc_size) {
+		dev_WARN_ONCE(dev, 1,
+			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu.\n",
+			alloc_size, size);
+		size = alloc_size;
+	}
+
+	backing_addr = slot->va + (tlb_addr - slot_start);
+
+	if (dir == DMA_TO_DEVICE) {
+		memcpy(backing_addr, phys_to_virt(orig_addr), size);
+	} else {
+		memcpy(phys_to_virt(orig_addr), backing_addr, size);
+	}
+}
+
+static struct io_tlb_slot* cc_swiotlb_get_slots(struct device *dev,
+						phys_addr_t orig_addr,
+						size_t alloc_size,
+						unsigned long alloc_align_mask,
+						phys_addr_t *slot_end)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_slot *slot;
+	unsigned long index, flags;
+	int ret;
+
+	alloc_align_mask = max((unsigned long)dma_get_min_align_mask(dev), alloc_align_mask);
+	slot = __cc_alloc_slot_from_list(alloc_size, alloc_align_mask);
+	if (!slot) {
+		dev_warn_once(dev, "Fail to alloc cc swiotlb slot\n");
+		return NULL;
+	}
+
+	slot->alloc_size = alloc_size;
+	slot->orig_addr = orig_addr;
+	index = __pa(slot->va) + slot->orig_size;
+	*slot_end = index;
+
+	xa_lock_irqsave(mem->mapping, flags);
+	ret = __xa_insert(mem->mapping, (unsigned long)index, slot, GFP_NOWAIT);
+	xa_unlock_irqrestore(mem->mapping, flags);
+	if (ret) {
+		dev_warn_ratelimited(dev, "Fail to insert index with error 0x%x\n", ret);
+		__cc_free_slot_to_list(slot);
+		return NULL;
+	}
+
+	return slot;
+}
+
+void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_slot *slot;
+	phys_addr_t slot_end = tlb_addr;
+	unsigned long flags;
+
+	slot = xa_find_after(mem->mapping, (unsigned long*)&slot_end, ULONG_MAX, XA_PRESENT);
+	if (!slot || tlb_addr >= slot_end || tlb_addr < slot_end - slot->orig_size) {
+		dev_warn_ratelimited(dev, "Failed to release slots since no coresponding slot is found\n");
+		return;
+	}
+
+	xa_lock_irqsave(mem->mapping, flags);
+	slot = __xa_erase(mem->mapping, slot_end);
+	xa_unlock_irqrestore(mem->mapping, flags);
+	if (!slot)
+		return;
+
+	__cc_free_slot_to_list(slot);
+}
+
+phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
+		size_t mapping_size, size_t alloc_size,
+		unsigned int alloc_align_mask, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	unsigned int offset = orig_addr & dma_get_min_align_mask(dev);
+	phys_addr_t tlb_addr;
+	struct io_tlb_slot *slot;
+	phys_addr_t slot_end;
+
+	if (!mem)
+		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
+
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
+
+	if (mapping_size > alloc_size) {
+		dev_warn_once(dev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
+			      mapping_size, alloc_size);
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
+
+	slot = cc_swiotlb_get_slots(dev, orig_addr, alloc_size + offset, alloc_align_mask, &slot_end);
+	if (slot == NULL) {
+		if (!(attrs & DMA_ATTR_NO_WARN))
+			dev_warn_ratelimited(dev, "No memory for cc-swiotlb buffer (sz: %zd bytes)\n",
+					     alloc_size);
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
+
+	tlb_addr = slot_end - slot->orig_size + offset;
+
+	/*
+	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
+	 * to the tlb buffer, if we knew for sure the device will
+	 * overwirte the entire current content. But we don't. Thus
+	 * unconditional bounce may prevent leaking swiotlb content (i.e.
+	 * kernel memory) to user-space.
+	 */
+	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE);
+	return tlb_addr;
+}
+
+void swiotlb_print_info(void)
+{
+	pr_info("Use dynamic allocated swiotlb buffer\n");
+}
+
+size_t swiotlb_max_mapping_size(struct device *dev)
+{
+	return SLOT_SIZES[NR_OF_SIZES - 1];
+}
+
+static void cc_populate_pages(void)
+{
+	void *vaddr;
+	unsigned long flags;
+	struct io_tlb_slot *slots;
+	size_t i, j, k;
+	const size_t max_bytes_per_alloc = (MAX_ORDER_NR_PAGES << PAGE_SHIFT);
+	size_t remain_alloc_size, rounds, round_size, round_slot_nr;
+
+	for (i = 0; i < NR_OF_SIZES; i++) {
+		if (atomic_read(&terrace.free_count_by_size[i]) > WATERMARK_SLOT_SIZE[i])
+			continue;
+
+		remain_alloc_size = SLOT_SIZES[i] * WATERMARK_SLOT_SIZE[i];
+		rounds = (remain_alloc_size + max_bytes_per_alloc - 1) / max_bytes_per_alloc;
+
+		for (k = 0; k < rounds && remain_alloc_size; k++) {
+			round_size = (remain_alloc_size / max_bytes_per_alloc > 0)?
+				max_bytes_per_alloc:
+				remain_alloc_size;
+			remain_alloc_size -= round_size;
+
+			vaddr = alloc_pages_exact(round_size, GFP_KERNEL);
+			if (!vaddr) {
+				pr_warn_ratelimited("No memory for cc swiotlb!\n");
+				return;
+			}
+
+			if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+				set_memory_decrypted((unsigned long)vaddr, round_size >> PAGE_SHIFT);
+
+			round_slot_nr = round_size / SLOT_SIZES[i];
+			slots = kmalloc(sizeof(struct io_tlb_slot) * round_slot_nr, GFP_KERNEL);
+			if (!slots) {
+				pr_warn_ratelimited("No memory for cc swiotlb metadata!\n");
+				if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+					set_memory_encrypted((unsigned long)vaddr, round_size >> PAGE_SHIFT);
+				free_pages_exact(vaddr, round_size);
+				return;
+			}
+
+			spin_lock_irqsave(&terrace.lock_by_size[i], flags);
+			for (j = 0; j < round_slot_nr; j++) {
+				slots[j].va = vaddr + SLOT_SIZES[i] * j;
+				slots[j].alloc_size = 0;
+				slots[j].orig_addr = INVALID_PHYS_ADDR;
+				slots[j].orig_size = SLOT_SIZES[i];
+
+				list_add_tail(&slots[j].node, &terrace.slots_by_size[i]);
+			}
+			atomic_add(round_slot_nr, &terrace.free_count_by_size[i]);
+			atomic_add(round_slot_nr, &terrace.total_count_by_size[i]);
+			spin_unlock_irqrestore(&terrace.lock_by_size[i], flags);
+		}
+	}
+}
+
+static int kccd(void *p)
+{
+	set_freezable();
+
+	if (cc_should_populate())
+		cc_populate_pages();
+
+	while (!kthread_should_stop()) {
+		if (try_to_freeze())
+			continue;
+
+		wait_event_freezable(kccd_waitq,
+				     kthread_should_stop() ||
+				     cc_should_populate());
+
+		if (cc_should_populate())
+			cc_populate_pages();
+
+		cond_resched();
+	}
+
+	return 0;
+}
+
+static int __init cc_page_populator_init(void)
+{
+	struct task_struct *tsk;
+	size_t i;
+
+	if (!io_tlb_default_mem.force_bounce)
+		return 0;
+
+	for (i = 0; i < NR_OF_SIZES; i++) {
+		spin_lock_init(&terrace.lock_by_size[i]);
+		atomic_set(&terrace.free_count_by_size[i], 0);
+		atomic_set(&terrace.total_count_by_size[i], 0);
+		INIT_LIST_HEAD(&terrace.slots_by_size[i]);
+	}
+
+	tsk = kthread_run(kccd, NULL, "kccd");
+	if (IS_ERR(tsk))
+		return 1;
+
+	kccd_tsk = tsk;
+
+	return 0;
+}
+
+arch_initcall(cc_page_populator_init);
+
+void __init swiotlb_init(bool addressing_limit, unsigned int flags)
+{
+	io_tlb_default_mem.mapping = memblock_alloc(sizeof(struct xarray), PAGE_SIZE);
+	if (!io_tlb_default_mem.mapping) {
+		pr_warn("%s: failed to allocate mapping structure\n", __func__);
+		return;
+	}
+
+	io_tlb_default_mem.force_bounce = cc_platform_has(CC_ATTR_MEM_ENCRYPT);
+
+	xa_init_flags(io_tlb_default_mem.mapping, 0);
+
+	/* cc swiotlb allocates IO TLB at runtime, no need to reserve memory. */
+}
+
+void __init swiotlb_exit(void)
+{
+	pr_warn("cc-swiotlb does not support turning at runtime.\n");
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
+					 const char *dirname)
+{
+	mem->debugfs = debugfs_create_dir(dirname, io_tlb_default_mem.debugfs);
+	debugfs_create_atomic_t("io_tlb_free_512b", 0400, mem->debugfs,
+				&terrace.free_count_by_size[SIZE_512B]);
+	debugfs_create_atomic_t("io_tlb_free_2k", 0400, mem->debugfs,
+				&terrace.free_count_by_size[SIZE_2K]);
+	debugfs_create_atomic_t("io_tlb_free_4k", 0400, mem->debugfs,
+				&terrace.free_count_by_size[SIZE_4K]);
+	debugfs_create_atomic_t("io_tlb_free_16k", 0400, mem->debugfs,
+				&terrace.free_count_by_size[SIZE_16K]);
+	debugfs_create_atomic_t("io_tlb_free_512k", 0400, mem->debugfs,
+				&terrace.free_count_by_size[SIZE_512K]);
+
+	debugfs_create_atomic_t("io_tlb_total_512b", 0400, mem->debugfs,
+				&terrace.total_count_by_size[SIZE_512B]);
+	debugfs_create_atomic_t("io_tlb_total_2k", 0400, mem->debugfs,
+				&terrace.total_count_by_size[SIZE_2K]);
+	debugfs_create_atomic_t("io_tlb_total_4k", 0400, mem->debugfs,
+				&terrace.total_count_by_size[SIZE_4K]);
+	debugfs_create_atomic_t("io_tlb_total_16k", 0400, mem->debugfs,
+				&terrace.total_count_by_size[SIZE_16K]);
+	debugfs_create_atomic_t("io_tlb_total_512k", 0400, mem->debugfs,
+				&terrace.total_count_by_size[SIZE_512K]);
+}
+
+static int __init __maybe_unused swiotlb_create_default_debugfs(void)
+{
+	swiotlb_create_debugfs_files(&io_tlb_default_mem, "swiotlb");
+	return 0;
+}
+
+late_initcall(swiotlb_create_default_debugfs);
+#endif
+
+unsigned long swiotlb_size_or_default(void) { return 0; }
+void __init swiotlb_update_mem_attributes(void) {}
+void __init swiotlb_adjust_size(unsigned long size) {}
+void __init swiotlb_hint_cpus(int cpus) {}
diff --git a/kernel/dma/common-swiotlb.c b/kernel/dma/common-swiotlb.c
index d477d5f2a71b..553325d5c9cd 100644
--- a/kernel/dma/common-swiotlb.c
+++ b/kernel/dma/common-swiotlb.c
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/cc_platform.h>
 #include <linux/dma-direct.h>
 #include <linux/swiotlb.h>
 
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 63859a101ed8..67a0ff973732 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -405,7 +405,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 }
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
-    defined(CONFIG_SWIOTLB)
+    defined(CONFIG_SWIOTLB) || defined(CONFIG_CC_SWIOTLB)
 void dma_direct_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
 {
@@ -428,7 +428,7 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
-    defined(CONFIG_SWIOTLB)
+    defined(CONFIG_SWIOTLB) || defined(CONFIG_CC_SWIOTLB)
 void dma_direct_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
 {
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index e38ffc5e6bdd..e3050ae59839 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -23,7 +23,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 size_t dma_direct_max_mapping_size(struct device *dev);
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
-    defined(CONFIG_SWIOTLB)
+    defined(CONFIG_SWIOTLB) || defined(CONFIG_CC_SWIOTLB)
 void dma_direct_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir);
 #else
@@ -35,7 +35,7 @@ static inline void dma_direct_sync_sg_for_device(struct device *dev,
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
-    defined(CONFIG_SWIOTLB)
+    defined(CONFIG_SWIOTLB) || defined(CONFIG_CC_SWIOTLB)
 void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
 void dma_direct_sync_sg_for_cpu(struct device *dev,
-- 
2.31.1

