Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B49B6D9A94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbjDFOiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjDFOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:38:28 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697B1CA0A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:36:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PskM76kxqz9xFrM
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 22:26:11 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.48.151.63])
        by APP2 (Coremail) with SMTP id GxC2BwDnizLG2C5kZfv8AQ--.49S2;
        Thu, 06 Apr 2023 15:36:00 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
Subject: [PATCH v1] swiotlb: fix a braino in the alignment check fix
Date:   Thu,  6 Apr 2023 16:35:39 +0200
Message-Id: <20230406143539.25-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDnizLG2C5kZfv8AQ--.49S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF43CF17Wr43Cw47Jr17Awb_yoW8tF13pF
        1xJF4ktFWUtr10qa42k3s8XFy0g34DKw17GrZIg34YgryDJF1DWr9F9ry2gryF9F4fGFy3
        uasI9rWjvFy7J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07je9a9UUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

The alignment mask in swiotlb_do_find_slots() masks off the high
bits which are not relevant for the alignment, so multiple
requirements are combined with a bitwise OR rather than AND.
In plain English, the stricter the alignment, the more bits must
be set in iotlb_align_mask.

Confusion may arise from the fact that the same variable is also
used to mask off the offset within a swiotlb slot, which is
achieved with a bitwise AND.

Fixes: 0eee5ae10256 ("swiotlb: fix slot alignment checks")
Reported-by: Dexuan Cui <decui@microsoft.com>
Link: https://lore.kernel.org/all/CAA42JLa1y9jJ7BgQvXeUYQh-K2mDNHd2BYZ4iZUz33r5zY7oAQ@mail.gmail.com/
Reported-by: Kelsey Steele <kelseysteele@linux.microsoft.com>
Link: https://lore.kernel.org/all/20230405003549.GA21326@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
Tested-by: Dexuan Cui <decui@microsoft.com>
---
 kernel/dma/swiotlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 5b919ef832b6..dac42a2ad588 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -623,7 +623,7 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
 	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask =
-		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
+		dma_get_min_align_mask(dev) | alloc_align_mask;
 	unsigned int nslots = nr_slots(alloc_size), stride;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned int index, slots_checked, count = 0, i;
@@ -639,8 +639,8 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 	 * allocations.
 	 */
 	if (alloc_size >= PAGE_SIZE)
-		iotlb_align_mask &= PAGE_MASK;
-	iotlb_align_mask &= alloc_align_mask;
+		iotlb_align_mask |= ~PAGE_MASK;
+	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
 
 	/*
 	 * For mappings with an alignment requirement don't bother looping to
-- 
2.25.1

