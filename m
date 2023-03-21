Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811226C2C83
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCUIeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCUIdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:33:32 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988AC460A3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:32:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Pgl3x5Vfcz9v7Yh
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 16:23:25 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.48.151.252])
        by APP2 (Coremail) with SMTP id GxC2BwBHHGNkaxlkK1q2AQ--.49312S4;
        Tue, 21 Mar 2023 09:32:02 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jianxiong Gao <jxgao@google.com>,
        David Stevens <stevensd@chromium.org>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
Subject: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
Date:   Tue, 21 Mar 2023 09:31:27 +0100
Message-Id: <c90887e4d75344abe219cc5e12f7c6dab980cfce.1679382779.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
References: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBHHGNkaxlkK1q2AQ--.49312S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWryrKw13Wr1fXw1kCryxuFg_yoW5XF4fpF
        yfWrnYqFWDJF18Aayjka4kWF4F93s7Gay3GF4Yg343ZrykJF9akF9rKF1YqFyFgr4kCFW7
        uF1aqa10vw1UZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
        JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
        WUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAa
        w2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc5l1DUUUU
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

Explicit alignment and page alignment are used only to calculate
the stride, not when checking actual slot physical address.

Originally, only page alignment was implemented, and that worked,
because the whole SWIOTLB is allocated on a page boundary, so
aligning the start index was sufficient to ensure a page-aligned
slot.

When Christoph Hellwig added support for min_align_mask, the index
could be incremented in the search loop, potentially finding an
unaligned slot if minimum device alignment is between IO_TLB_SIZE
and PAGE_SIZE. The bug could go unnoticed, because the slot size
is 2 KiB, and the most common page size is 4 KiB, so there is no
alignment value in between.

IIUC the intention has been to find a slot that conforms to all
alignment constraints: device minimum alignment, an explicit
alignment (given as function parameter) and optionally page
alignment (if allocation size is >= PAGE_SIZE). The most
restrictive mask can be trivially computed with logical AND. The
rest can stay.

Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
Fixes: e81e99bacc9f ("swiotlb: Support aligned swiotlb buffers")
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 kernel/dma/swiotlb.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 3856e2b524b4..5b919ef832b6 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -634,22 +634,26 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 	BUG_ON(!nslots);
 	BUG_ON(area_index >= mem->nareas);
 
+	/*
+	 * For allocations of PAGE_SIZE or larger only look for page aligned
+	 * allocations.
+	 */
+	if (alloc_size >= PAGE_SIZE)
+		iotlb_align_mask &= PAGE_MASK;
+	iotlb_align_mask &= alloc_align_mask;
+
 	/*
 	 * For mappings with an alignment requirement don't bother looping to
-	 * unaligned slots once we found an aligned one.  For allocations of
-	 * PAGE_SIZE or larger only look for page aligned allocations.
+	 * unaligned slots once we found an aligned one.
 	 */
 	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
-	if (alloc_size >= PAGE_SIZE)
-		stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
-	stride = max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
 
 	spin_lock_irqsave(&area->lock, flags);
 	if (unlikely(nslots > mem->area_nslabs - area->used))
 		goto not_found;
 
 	slot_base = area_index * mem->area_nslabs;
-	index = wrap_area_index(mem, ALIGN(area->index, stride));
+	index = area->index;
 
 	for (slots_checked = 0; slots_checked < mem->area_nslabs; ) {
 		slot_index = slot_base + index;
-- 
2.39.2

