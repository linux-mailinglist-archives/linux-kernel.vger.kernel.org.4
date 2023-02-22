Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5364B69F957
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjBVQxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjBVQxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:53:02 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0001BDC6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:52:56 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VcHP-D1_1677084772;
Received: from localhost(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VcHP-D1_1677084772)
          by smtp.aliyun-inc.com;
          Thu, 23 Feb 2023 00:52:52 +0800
From:   "GuoRui.Yu" <GuoRui.Yu@linux.alibaba.com>
To:     hch@lst.de, m.szyprowski@samsung.com
Cc:     robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, GuoRui.Yu@linux.alibaba.com,
        linux-mm@kvack.org
Subject: [PATCH] swiotlb: fix the deadlock in swiotlb_do_find_slots
Date:   Thu, 23 Feb 2023 00:52:51 +0800
Message-Id: <20230222165251.88700-1-GuoRui.Yu@linux.alibaba.com>
X-Mailer: git-send-email 2.29.2.540.g3cf59784d4
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

In general, if swiotlb is sufficient, the logic of index =
wrap_area_index(mem, index + 1) is fine, it will quickly take a slot and
release the area->lock; But if swiotlb is insufficient and the device
has min_align_mask requirements, such as NVME, we may not be able to
satisfy index == wrap and exit the loop properly. In this case, other
kernel threads will not be able to acquire the area->lock and release
the slot, resulting in a deadlock.

The current implementation of wrap_area_index does not involve a modulo
operation, so adjusting the wrap to ensure the loop ends is not trivial.
Introduce the index_nowrap variable to record the number of loops and
exit the loop after completing the traversal.

Backtraces:
Other CPUs are waiting this core to exit the swiotlb_do_find_slots
loop.
[10199.924391] RIP: 0010:swiotlb_do_find_slots+0x1fe/0x3e0
[10199.924403] Call Trace:
[10199.924404]  <TASK>
[10199.924405]  swiotlb_tbl_map_single+0xec/0x1f0
[10199.924407]  swiotlb_map+0x5c/0x260
[10199.924409]  ? nvme_pci_setup_prps+0x1ed/0x340
[10199.924411]  dma_direct_map_page+0x12e/0x1c0
[10199.924413]  nvme_map_data+0x304/0x370
[10199.924415]  nvme_prep_rq.part.0+0x31/0x120
[10199.924417]  nvme_queue_rq+0x77/0x1f0

...
[ 9639.596311] NMI backtrace for cpu 48
[ 9639.596336] Call Trace:
[ 9639.596337]
[ 9639.596338] _raw_spin_lock_irqsave+0x37/0x40
[ 9639.596341] swiotlb_do_find_slots+0xef/0x3e0
[ 9639.596344] swiotlb_tbl_map_single+0xec/0x1f0
[ 9639.596347] swiotlb_map+0x5c/0x260
[ 9639.596349] dma_direct_map_sg+0x7a/0x280
[ 9639.596352] __dma_map_sg_attrs+0x30/0x70
[ 9639.596355] dma_map_sgtable+0x1d/0x30
[ 9639.596356] nvme_map_data+0xce/0x370

...
[ 9639.595665] NMI backtrace for cpu 50
[ 9639.595682] Call Trace:
[ 9639.595682]
[ 9639.595683] _raw_spin_lock_irqsave+0x37/0x40
[ 9639.595686] swiotlb_release_slots.isra.0+0x86/0x180
[ 9639.595688] dma_direct_unmap_sg+0xcf/0x1a0
[ 9639.595690] nvme_unmap_data.part.0+0x43/0xc0

Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
Signed-off-by: GuoRui.Yu <GuoRui.Yu@linux.alibaba.com>
Signed-off-by: Xiaokang Hu <xiaokang.hxk@alibaba-inc.com>
---
 kernel/dma/swiotlb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a34c38bbe28f..638ba3ea94f4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -632,7 +632,7 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 	unsigned int iotlb_align_mask =
 		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
 	unsigned int nslots = nr_slots(alloc_size), stride;
-	unsigned int index, wrap, count = 0, i;
+	unsigned int index, index_nowrap = 0, wrap, count = 0, i;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned long flags;
 	unsigned int slot_base;
@@ -665,6 +665,7 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 		    (slot_addr(tbl_dma_addr, slot_index) &
 		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
 			index = wrap_area_index(mem, index + 1);
+			index_nowrap++;
 			continue;
 		}
 
@@ -680,7 +681,8 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 				goto found;
 		}
 		index = wrap_area_index(mem, index + stride);
-	} while (index != wrap);
+		index_nowrap += stride;
+	} while (index_nowrap < mem->area_nslabs);
 
 not_found:
 	spin_unlock_irqrestore(&area->lock, flags);
-- 
2.31.1

