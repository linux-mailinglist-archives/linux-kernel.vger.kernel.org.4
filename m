Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55F973F96B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjF0J7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjF0J6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:58:40 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78AF35AE;
        Tue, 27 Jun 2023 02:57:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qr0DH62DDz9xGXS;
        Tue, 27 Jun 2023 17:44:31 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.45.153.185])
        by APP1 (Coremail) with SMTP id LxC2BwBnwdzesZpknnvHAw--.39096S7;
        Tue, 27 Jun 2023 10:56:21 +0100 (CET)
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
Subject: [PATCH v3 5/7] swiotlb: determine potential physical address limit
Date:   Tue, 27 Jun 2023 11:54:27 +0200
Message-Id: <ca2a1e6ef6cc91a932c223a4c0b784267d565680.1687859323.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
References: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBnwdzesZpknnvHAw--.39096S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4fJr1DCF4Dtr1kuF1DAwb_yoW5WF48pF
        y8Aa1rtFsFqF1xAryxC3W7AFn3Ka1kC3y7urWa9r15Ar13Gr1rKrsrKr4Yqr1FqF409F4I
        vFyFvayYvF4aqw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUml14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
        Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
        IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
        xan2IY04v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_
        Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
        JbIYCTnIWIevJa73UjIFyTuYvjfU1WlkDUUUU
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

The value returned by default_swiotlb_limit() should not change, because it
is used to decide whether DMA can be used. To allow allocating memory pools
on the fly, use the maximum possible physical address rather than the
highest address used by the default pool.

For swiotlb_init_remap(), this is either an arch-specific limit used by
memblock_alloc_low(), or the highest directly mapped physical address if
the initialization flags include SWIOTLB_ANY. For swiotlb_init_late(), the
highest address is determined by the GFP flags.

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 include/linux/swiotlb.h |  2 ++
 kernel/dma/swiotlb.c    | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index ae1688438850..4a3af1c216d0 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -105,6 +105,7 @@ struct io_tlb_pool {
  * struct io_tlb_mem - Software IO TLB allocator
  * @pool:	IO TLB memory pool descriptor.
  * @nslabs:	Total number of IO TLB slabs in all pools.
+ * @phys_limit:	Maximum allowed physical address.
  * @debugfs:	The dentry to debugfs.
  * @force_bounce: %true if swiotlb bouncing is forced
  * @for_alloc:  %true if the pool is used for memory allocation
@@ -117,6 +118,7 @@ struct io_tlb_pool {
 struct io_tlb_mem {
 	struct io_tlb_pool *pool;
 	unsigned long nslabs;
+	u64 phys_limit;
 	struct dentry *debugfs;
 	bool force_bounce;
 	bool for_alloc;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 06b4fa7c2e9b..5bb83097ade6 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -333,6 +333,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 
 	io_tlb_default_mem.force_bounce =
 		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
+	io_tlb_default_mem.phys_limit = flags & SWIOTLB_ANY
+		? virt_to_phys(high_memory - 1)
+		: ARCH_LOW_ADDRESS_LIMIT;
 
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
@@ -400,6 +403,12 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 		return 0;
 
 	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
+	io_tlb_default_mem.phys_limit =
+		IS_ENABLED(CONFIG_ZONE_DMA) && (gfp_mask & __GFP_DMA)
+		? DMA_BIT_MASK(zone_dma_bits)
+		: (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp_mask & __GFP_DMA32)
+		   ? DMA_BIT_MASK(32)
+		   : virt_to_phys(high_memory - 1));
 
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
@@ -1308,7 +1317,7 @@ phys_addr_t default_swiotlb_start(void)
  */
 phys_addr_t default_swiotlb_limit(void)
 {
-	return io_tlb_default_pool.end - 1;
+	return io_tlb_default_mem.phys_limit;
 }
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.25.1

