Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF16F6C124E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCTMto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjCTMtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:49:21 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B18922DC4;
        Mon, 20 Mar 2023 05:48:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PgDM03lywz9v7YD;
        Mon, 20 Mar 2023 20:19:40 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.48.148.162])
        by APP2 (Coremail) with SMTP id GxC2BwBnOF9kURhkkqGyAQ--.46782S4;
        Mon, 20 Mar 2023 13:28:51 +0100 (CET)
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
Subject: [RFC v1 2/4] swiotlb: Move code around in preparation for dynamic bounce buffers
Date:   Mon, 20 Mar 2023 13:28:14 +0100
Message-Id: <932dee179c950e98713f8636f0c9d95a6a37b640.1679309810.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnOF9kURhkkqGyAQ--.46782S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4kZF4DXF1UtF1xuFWUXFb_yoW7Cw4xpF
        4xJFyrKFZ3tF18C3sF9a1kGF1F9w1kK3y3JFWa9ryF9a4DXrn0qFZ8CrWjg3WFqFWv9FW7
        Xr98ZF4rKF47Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
        Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAKzI0EY4
        vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
        0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5
        -B_UUUUU=
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

In preparation for the introduction of dynamically allocated
bounce buffers, separate out common code and code which handles
non-dynamic bounce buffers.

No functional change, but this commit should make the addition of
dynamic allocations easier to review.

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 include/linux/swiotlb.h |  7 ++++-
 kernel/dma/swiotlb.c    | 64 +++++++++++++++++++++++++++++------------
 2 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 35bc4e281c21..b71adba03dc7 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -105,11 +105,16 @@ struct io_tlb_mem {
 };
 extern struct io_tlb_mem io_tlb_default_mem;
 
+static inline bool is_swiotlb_fixed(struct io_tlb_mem *mem, phys_addr_t paddr)
+{
+	return paddr >= mem->start && paddr < mem->end;
+}
+
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 
-	return mem && paddr >= mem->start && paddr < mem->end;
+	return mem && is_swiotlb_fixed(mem, paddr);
 }
 
 static inline bool is_swiotlb_force_bounce(struct device *dev)
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a34c38bbe28f..e8608bcb205e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -78,6 +78,10 @@ phys_addr_t swiotlb_unencrypted_base;
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 static unsigned long default_nareas;
 
+static void swiotlb_copy(struct device *dev, phys_addr_t orig_addr,
+		unsigned char *vaddr, size_t size, size_t alloc_size,
+		unsigned int tlb_offset, enum dma_data_direction dir);
+
 /**
  * struct io_tlb_area - IO TLB memory area descriptor
  *
@@ -530,7 +534,6 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
-	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
 	unsigned int tlb_offset, orig_addr_offset;
 
@@ -547,6 +550,18 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	}
 
 	tlb_offset -= orig_addr_offset;
+	swiotlb_copy(dev, orig_addr, vaddr, size, alloc_size, tlb_offset, dir);
+}
+
+/*
+ * Copy swiotlb buffer content, checking for overflows.
+ */
+static void swiotlb_copy(struct device *dev, phys_addr_t orig_addr,
+		unsigned char *vaddr, size_t size, size_t alloc_size,
+		unsigned int tlb_offset, enum dma_data_direction dir)
+{
+	unsigned long pfn = PFN_DOWN(orig_addr);
+
 	if (tlb_offset > alloc_size) {
 		dev_WARN_ONCE(dev, 1,
 			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu+%u.\n",
@@ -738,15 +753,35 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
 	return used;
 }
 
+static phys_addr_t swiotlb_fixed_map(struct device *dev, phys_addr_t orig_addr,
+			size_t alloc_size, unsigned int alloc_align_mask,
+			unsigned long attrs)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
+	int index = swiotlb_find_slots(dev, orig_addr,
+				       alloc_size + offset, alloc_align_mask);
+	unsigned int i;
+
+	if (index == -1)
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+
+	/*
+	 * Save away the mapping from the original address to the DMA address.
+	 * This is needed when we sync the memory.  Then we sync the buffer if
+	 * needed.
+	 */
+	for (i = 0; i < nr_slots(alloc_size + offset); i++)
+		mem->slots[index + i].orig_addr = slot_addr(orig_addr, i);
+	return slot_addr(mem->start, index) + offset;
+}
+
 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		unsigned int alloc_align_mask, enum dma_data_direction dir,
 		unsigned long attrs)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
-	unsigned int i;
-	int index;
 	phys_addr_t tlb_addr;
 
 	if (!mem || !mem->nslabs) {
@@ -764,24 +799,17 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
-	index = swiotlb_find_slots(dev, orig_addr,
-				   alloc_size + offset, alloc_align_mask);
-	if (index == -1) {
+	tlb_addr = swiotlb_fixed_map(dev, orig_addr, alloc_size,
+				     alloc_align_mask, attrs);
+
+	if (tlb_addr == (phys_addr_t)DMA_MAPPING_ERROR) {
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
-	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-				 alloc_size, mem->nslabs, mem_used(mem));
-		return (phys_addr_t)DMA_MAPPING_ERROR;
+				"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
+				alloc_size, mem->nslabs, mem_used(mem));
+		return tlb_addr;
 	}
 
-	/*
-	 * Save away the mapping from the original address to the DMA address.
-	 * This is needed when we sync the memory.  Then we sync the buffer if
-	 * needed.
-	 */
-	for (i = 0; i < nr_slots(alloc_size + offset); i++)
-		mem->slots[index + i].orig_addr = slot_addr(orig_addr, i);
-	tlb_addr = slot_addr(mem->start, index) + offset;
 	/*
 	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
 	 * to the tlb buffer, if we knew for sure the device will
-- 
2.25.1

