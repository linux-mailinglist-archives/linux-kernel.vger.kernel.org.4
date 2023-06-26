Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F373A73E004
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjFZNCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjFZNCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:02:04 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61902BD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:02:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QqSQ54S3Sz9xFQP
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:51:09 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.202.159])
        by APP2 (Coremail) with SMTP id GxC2BwDXXWQljJlk1fGzAw--.36557S3;
        Mon, 26 Jun 2023 14:01:40 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, petr@tesarici.cz
Subject: [PATCH v1 1/2] swiotlb: Always set the number of areas before allocating the pool
Date:   Mon, 26 Jun 2023 15:01:03 +0200
Message-Id: <d8c7dedcbfb53ceaa5202f6a144c71c75db900f3.1687784289.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687784289.git.petr.tesarik.ext@huawei.com>
References: <cover.1687784289.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDXXWQljJlk1fGzAw--.36557S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyDXFWxuF1DJFykJFyrZwb_yoW5GrWxpr
        yfZa4jyFWSqF1xAFyUAayxJFy0k3WkCryjkryY9ryfJr45JF1fXrWDKFWjqr95tay7Zr4j
        qayrZr4YgrnxX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0Ew4C26cxK6c8Ij28Icw
        CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
        6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
        vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
        vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUnvtZUUUUU=
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

The number of areas defaults to the number of possible CPUs. However, the
total number of slots may have to be increased after adjusting the number
of areas. Consequently, the number of areas must be determined before
allocating the memory pool. This is even explained with a comment in
swiotlb_init_remap(), but swiotlb_init_late() adjusts the number of areas
after slots are already allocated. The areas may end up being smaller than
IO_TLB_SEGSIZE, which breaks per-area locking.

While fixing swiotlb_init_late(), move all relevant comments before the
definition of swiotlb_adjust_nareas() and convert them to kernel-doc.

Fixes: 20347fca71a3 ("swiotlb: split up the global swiotlb lock")
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 kernel/dma/swiotlb.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index af2e304c672c..16f53d8c51bc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -115,9 +115,16 @@ static bool round_up_default_nslabs(void)
 	return true;
 }
 
+/**
+ * swiotlb_adjust_nareas() - adjust the number of areas and slots
+ * @nareas:	Desired number of areas. Zero is treated as 1.
+ *
+ * Adjust the default number of areas in a memory pool.
+ * The default size of the memory pool may also change to meet minimum area
+ * size requirements.
+ */
 static void swiotlb_adjust_nareas(unsigned int nareas)
 {
-	/* use a single area when non is specified */
 	if (!nareas)
 		nareas = 1;
 	else if (!is_power_of_2(nareas))
@@ -298,10 +305,6 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (swiotlb_force_disable)
 		return;
 
-	/*
-	 * default_nslabs maybe changed when adjust area number.
-	 * So allocate bounce buffer after adjusting area number.
-	 */
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
 
@@ -363,6 +366,9 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (swiotlb_force_disable)
 		return 0;
 
+	if (!default_nareas)
+		swiotlb_adjust_nareas(num_possible_cpus());
+
 retry:
 	order = get_order(nslabs << IO_TLB_SHIFT);
 	nslabs = SLABS_PER_PAGE << order;
@@ -397,9 +403,6 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 			(PAGE_SIZE << order) >> 20);
 	}
 
-	if (!default_nareas)
-		swiotlb_adjust_nareas(num_possible_cpus());
-
 	area_order = get_order(array_size(sizeof(*mem->areas),
 		default_nareas));
 	mem->areas = (struct io_tlb_area *)
-- 
2.25.1

