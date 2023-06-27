Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC5B73F956
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjF0J5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjF0J5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:57:13 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1398D30E5;
        Tue, 27 Jun 2023 02:56:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qr0CM3Cphz9v7cZ;
        Tue, 27 Jun 2023 17:43:43 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.45.153.185])
        by APP1 (Coremail) with SMTP id LxC2BwBnwdzesZpknnvHAw--.39096S4;
        Tue, 27 Jun 2023 10:55:33 +0100 (CET)
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
Subject: [PATCH v3 2/7] swiotlb: add documentation and rename swiotlb_do_find_slots()
Date:   Tue, 27 Jun 2023 11:54:24 +0200
Message-Id: <d9b376ead66c70a3cafc797c485d3da93e06fb78.1687859323.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
References: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBnwdzesZpknnvHAw--.39096S4
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWfGF48Gr13WrW3tFWUArb_yoW7XF43pF
        4rKFs0qFZ8Jr1xC3sFkw48uF1Ska1kK347uayS9ryF9rnxJr9agFyqyrW5Xa4rJrs7uF4U
        Ja4avrW8GF45Xr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
        vfC2KfnxnUUI43ZEXa7VUURwZ5UUUUU==
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

Add some kernel-doc comments and move the existing documentation of struct
io_tlb_slot to its correct location. The latter was forgotten in commit
942a8186eb445 ("swiotlb: move struct io_tlb_slot to swiotlb.c").

Use the opportunity to give swiotlb_do_find_slots() a more descriptive
name, which makes it clear how it differs from swiotlb_find_slots().

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 include/linux/swiotlb.h | 15 ++++++++----
 kernel/dma/swiotlb.c    | 52 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index b38045be532d..9f486843a66a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -77,10 +77,6 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
  *		@end. For default swiotlb, this is command line adjustable via
  *		setup_io_tlb_npages.
  * @used:	The number of used IO TLB block.
- * @list:	The free list describing the number of free entries available
- *		from each index.
- * @orig_addr:	The original address corresponding to a mapped entry.
- * @alloc_size:	Size of the allocated buffer.
  * @debugfs:	The dentry to debugfs.
  * @late_alloc:	%true if allocated using the page allocator
  * @force_bounce: %true if swiotlb bouncing is forced
@@ -113,6 +109,17 @@ struct io_tlb_mem {
 #endif
 };
 
+/**
+ * is_swiotlb_buffer() - check if a physical address belongs to a swiotlb
+ * @dev:        Device which has mapped the buffer.
+ * @paddr:      Physical address within the DMA buffer.
+ *
+ * Check if @paddr points into a bounce buffer.
+ *
+ * Return:
+ * * %true if @paddr points into a bounce buffer
+ * * %false otherwise
+ */
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 63d318059f27..888c25a9bfcc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -62,6 +62,13 @@
 
 #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
 
+/**
+ * struct io_tlb_slot - IO TLB slot descriptor
+ * @orig_addr:	The original address corresponding to a mapped entry.
+ * @alloc_size:	Size of the allocated buffer.
+ * @list:	The free list describing the number of free entries available
+ *		from each index.
+ */
 struct io_tlb_slot {
 	phys_addr_t orig_addr;
 	size_t alloc_size;
@@ -632,11 +639,22 @@ static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
 }
 #endif /* CONFIG_DEBUG_FS */
 
-/*
- * Find a suitable number of IO TLB entries size that will fit this request and
- * allocate a buffer from that IO TLB pool.
+/**
+ * area_find_slots() - search for slots in one IO TLB memory area
+ * @dev:	Device which maps the buffer.
+ * @area_index:	Index of the IO TLB memory area to be searched.
+ * @orig_addr:	Original (non-bounced) IO buffer address.
+ * @alloc_size: Total requested size of the bounce buffer,
+ *		including initial alignment padding.
+ * @alloc_align_mask:	Required alignment of the allocated buffer.
+ *
+ * Find a suitable sequence of IO TLB entries for the request and allocate
+ * a buffer from the given IO TLB memory area.
+ * This function takes care of locking.
+ *
+ * Return: Index of the first allocated slot, or -1 on error.
  */
-static int swiotlb_do_find_slots(struct device *dev, int area_index,
+static int area_find_slots(struct device *dev, int area_index,
 		phys_addr_t orig_addr, size_t alloc_size,
 		unsigned int alloc_align_mask)
 {
@@ -731,6 +749,19 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 	return slot_index;
 }
 
+/**
+ * swiotlb_find_slots() - search for slots in the whole swiotlb
+ * @dev:	Device which maps the buffer.
+ * @orig_addr:	Original (non-bounced) IO buffer address.
+ * @alloc_size: Total requested size of the bounce buffer,
+ *		including initial alignment padding.
+ * @alloc_align_mask:	Required alignment of the allocated buffer.
+ *
+ * Search through the whole software IO TLB to find a sequence of slots that
+ * match the allocation constraints.
+ *
+ * Return: Index of the first allocated slot, or -1 on error.
+ */
 static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 		size_t alloc_size, unsigned int alloc_align_mask)
 {
@@ -739,8 +770,8 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	int i = start, index;
 
 	do {
-		index = swiotlb_do_find_slots(dev, i, orig_addr, alloc_size,
-					      alloc_align_mask);
+		index = area_find_slots(dev, i, orig_addr, alloc_size,
+					alloc_align_mask);
 		if (index >= 0)
 			return index;
 		if (++i >= mem->nareas)
@@ -750,6 +781,15 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	return -1;
 }
 
+/**
+ * mem_used() - get number of used slots in an allocator
+ * @mem:	Software IO TLB allocator.
+ *
+ * The result is not accurate, because there is no locking of individual
+ * areas.
+ *
+ * Return: Approximate number of used slots.
+ */
 static unsigned long mem_used(struct io_tlb_mem *mem)
 {
 	int i;
-- 
2.25.1

