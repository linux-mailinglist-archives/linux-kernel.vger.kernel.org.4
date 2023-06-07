Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BFD72597C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbjFGJGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbjFGJFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:05:37 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14526AC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:04:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Qbh3j43pzz9y9NL
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:54:25 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.45.148.106])
        by APP2 (Coremail) with SMTP id GxC2BwDHgEcaSIBkxRwSAw--.4167S2;
        Wed, 07 Jun 2023 10:04:33 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, petr@tesarici.cz
Subject: [PATCH v1 1/1] swiotlb: use the atomic counter of total used slabs if available
Date:   Wed,  7 Jun 2023 11:04:18 +0200
Message-Id: <20230607090418.653-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDHgEcaSIBkxRwSAw--.4167S2
X-Coremail-Antispam: 1UD129KBjvJXoWruw1fAw43Xw45Aw4kZry5Arb_yoW8Jry3pF
        1xJ3WFgFWqqF1Ik39Iv395ua4a9w48K3y3XFZ3t3saga4Dta4F9r97KrWjqFWFvFW8GrW3
        JasaqFWFyr4UGwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY
        0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
        vE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8T89tUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

If DEBUG_FS is enabled, the cost of keeping an exact number of total
used slabs is already paid. In this case, there is no reason to use an
inexact number for statistics and kernel messages.

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 kernel/dma/swiotlb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index af2e304c672c..775f7bb10ab1 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -717,6 +717,15 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	return -1;
 }
 
+#ifdef CONFIG_DEBUG_FS
+
+static unsigned long mem_used(struct io_tlb_mem *mem)
+{
+	return atomic_long_read(&mem->total_used);
+}
+
+#else /* !CONFIG_DEBUG_FS */
+
 static unsigned long mem_used(struct io_tlb_mem *mem)
 {
 	int i;
@@ -727,6 +736,8 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
 	return used;
 }
 
+#endif /* CONFIG_DEBUG_FS */
+
 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		unsigned int alloc_align_mask, enum dma_data_direction dir,
-- 
2.25.1

