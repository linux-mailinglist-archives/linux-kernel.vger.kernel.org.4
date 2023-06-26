Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68B773E008
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjFZNCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjFZNCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:02:10 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7917FC2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:02:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QqSQB5PXjz9xFQ7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:51:14 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.202.159])
        by APP2 (Coremail) with SMTP id GxC2BwDXXWQljJlk1fGzAw--.36557S4;
        Mon, 26 Jun 2023 14:01:46 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, petr@tesarici.cz
Subject: [PATCH v1 2/2] swiotlb: Reduce the number of areas to match actual memory pool size
Date:   Mon, 26 Jun 2023 15:01:04 +0200
Message-Id: <097dffeb406cef6596499c8dbdafb28d05f7501b.1687784289.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687784289.git.petr.tesarik.ext@huawei.com>
References: <cover.1687784289.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDXXWQljJlk1fGzAw--.36557S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1xur4UKr1xCF18GFyrCrg_yoWrGFy3pr
        yfWa4UtFWFqFn7CFW2y3y8CFySka4vyrnFkF9xC3sxXw1UGF1SkrWqkFWUJFWrtF4kuF4f
        X3yrZF45uanxJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0Ew4C26cxK6c8Ij28Icw
        CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
        6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
        vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
        vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRLqXdUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

Although the desired size of the SWIOTLB memory pool is increased in
swiotlb_adjust_nareas() to match the number of areas, the actual allocation
may be smaller, which may require reducing the number of areas.

For example, Xen uses swiotlb_init_late(), which in turn uses the page
allocator. On x86, page size is 4 KiB and MAX_ORDER is 10 (1024 pages),
resulting in a maximum memory pool size of 4 MiB. This corresponds to 2048
slots of 2 KiB each. The minimum area size is 128 (IO_TLB_SEGSIZE),
allowing at most 2048 / 128 = 16 areas.

If num_possible_cpus() is greater than the maximum number of areas, areas
are smaller than IO_TLB_SEGSIZE and contiguous groups of free slots will
span multiple areas. When allocating and freeing slots, only one area will
be properly locked, causing race conditions on the unlocked slots and
ultimately data corruption, kernel hangs and crashes.

Fixes: 20347fca71a3 ("swiotlb: split up the global swiotlb lock")
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 kernel/dma/swiotlb.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 16f53d8c51bc..079df5ad38d0 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -138,6 +138,23 @@ static void swiotlb_adjust_nareas(unsigned int nareas)
 			(default_nslabs << IO_TLB_SHIFT) >> 20);
 }
 
+/**
+ * limit_nareas() - get the maximum number of areas for a given memory pool size
+ * @nareas:	Desired number of areas.
+ * @nslots:	Total number of slots in the memory pool.
+ *
+ * Limit the number of areas to the maximum possible number of areas in
+ * a memory pool of the given size.
+ *
+ * Return: Maximum possible number of areas.
+ */
+static unsigned int limit_nareas(unsigned int nareas, unsigned long nslots)
+{
+	if (nslots < nareas * IO_TLB_SEGSIZE)
+		nareas = nslots / IO_TLB_SEGSIZE;
+	return nareas;
+}
+
 static int __init
 setup_io_tlb_npages(char *str)
 {
@@ -297,6 +314,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long nslabs;
+	unsigned int nareas;
 	size_t alloc_size;
 	void *tlb;
 
@@ -309,10 +327,12 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		swiotlb_adjust_nareas(num_possible_cpus());
 
 	nslabs = default_nslabs;
+	nareas = limit_nareas(default_nareas, nslabs);
 	while ((tlb = swiotlb_memblock_alloc(nslabs, flags, remap)) == NULL) {
 		if (nslabs <= IO_TLB_MIN_SLABS)
 			return;
 		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
+		nareas = limit_nareas(nareas, nslabs);
 	}
 
 	if (default_nslabs != nslabs) {
@@ -358,6 +378,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
+	unsigned int nareas;
 	unsigned char *vstart = NULL;
 	unsigned int order, area_order;
 	bool retried = false;
@@ -403,8 +424,8 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 			(PAGE_SIZE << order) >> 20);
 	}
 
-	area_order = get_order(array_size(sizeof(*mem->areas),
-		default_nareas));
+	nareas = limit_nareas(default_nareas, nslabs);
+	area_order = get_order(array_size(sizeof(*mem->areas), nareas));
 	mem->areas = (struct io_tlb_area *)
 		__get_free_pages(GFP_KERNEL | __GFP_ZERO, area_order);
 	if (!mem->areas)
@@ -418,7 +439,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	set_memory_decrypted((unsigned long)vstart,
 			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
 	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, 0, true,
-				default_nareas);
+				nareas);
 
 	swiotlb_print_info();
 	return 0;
-- 
2.25.1

