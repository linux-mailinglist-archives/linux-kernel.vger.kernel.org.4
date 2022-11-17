Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C3C62D386
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiKQGd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKQGd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:33:26 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AD1118
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 22:33:23 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NCVTZ59KNzHvyx;
        Thu, 17 Nov 2022 14:32:50 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 14:33:22 +0800
Received: from huawei.com (10.175.113.32) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 14:33:21 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <sstabellini@kernel.org>, <robin.murphy@arm.com>,
        <jgross@suse.com>, <oleksandr_tyshchenko@epam.com>,
        <ardb@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sunnanyong@huawei.com>,
        <wangkefeng.wang@huawei.com>
Subject: [RFC PATCH] arm64: mm: Add invalidate back in arch_sync_dma_for_device when FROM_DEVICE
Date:   Thu, 17 Nov 2022 15:21:00 +0800
Message-ID: <20221117072100.2720512-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit c50f11c6196f ("arm64: mm: Don't invalidate FROM_DEVICE
buffers at start of DMA transfer") replaces invalidate with clean
when DMA_FROM_DEVICE, this changes the behavior of functions like
dma_map_single() and dma_sync_single_for_device(*, *, *, DMA_FROM_DEVICE),
then it may make some drivers works unwell because the implementation
of these DMA APIs lose the original cache invalidation.

Situation 1:
We can see that a lot of drivers in mainline have called the
dma_sync_single_for_device(*, *, *, DMA_FROM_DEVICE) for sync,
they would get cache invalidated before implementation changed,
but now they got cache clean, which may violate the original
expectation of the drivers and result in errors.

Situation 2:
After backporting the above commit, we find a network card driver go
wrong with cache inconsistency when doing DMA transfer: CPU got the
stale data in cache when reading DMA data received from device.
A similar phenomenon happens on sata disk drivers, it involves
mainline modules like libata, scsi, ahci etc, and is hard to find
out which line of code results in the error.

It seems that some dirvers may go wrong and have to match the
implementation changes of the DMA APIs, and it would be confused
because the behavior of these DMA APIs on arm64 are different
from other archs.

Add invalidate back in arch_sync_dma_for_device() to keep drivers
compatible by replace dcache_clean_poc with dcache_clean_inval_poc
when DMA_FROM_DEVICE.

Fixes: c50f11c6196f ("arm64: mm: Don't invalidate FROM_DEVICE buffers at start of DMA transfer")
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 arch/arm64/mm/dma-mapping.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3cb101e8cb29..07f6a3089c64 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -18,7 +18,10 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 {
 	unsigned long start = (unsigned long)phys_to_virt(paddr);
 
-	dcache_clean_poc(start, start + size);
+	if (dir == DMA_FROM_DEVICE)
+		dcache_clean_inval_poc(start, start + size);
+	else
+		dcache_clean_poc(start, start + size);
 }
 
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
-- 
2.25.1

