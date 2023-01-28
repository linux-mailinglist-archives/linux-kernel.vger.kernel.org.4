Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFE467F65D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjA1Ide (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjA1IdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:33:17 -0500
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA683BD83
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:33:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VaH2ZNo_1674894789;
Received: from localhost(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VaH2ZNo_1674894789)
          by smtp.aliyun-inc.com;
          Sat, 28 Jan 2023 16:33:10 +0800
From:   "GuoRui.Yu" <GuoRui.Yu@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, linux-coco@lists.linux.dev
Cc:     GuoRui.Yu@linux.alibaba.com, robin.murphy@arm.com
Subject: [PATCH 4/4] cc-swiotlb: Allow set swiotlb watermark from cmdline
Date:   Sat, 28 Jan 2023 16:32:54 +0800
Message-Id: <20230128083254.86012-5-GuoRui.Yu@linux.alibaba.com>
X-Mailer: git-send-email 2.29.2.540.g3cf59784d4
In-Reply-To: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
References: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
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

Signed-off-by: GuoRui.Yu <GuoRui.Yu@linux.alibaba.com>
---
 .../admin-guide/kernel-parameters.txt         | 11 ++++++
 kernel/dma/cc-swiotlb.c                       | 34 ++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..ad510e392998 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6090,6 +6090,17 @@
 			         wouldn't be automatically used by the kernel
 			noforce -- Never use bounce buffers (for debugging)
 
+	cc_swiotlb=	[X86]
+			Format: { [<int>, <int>, <int>, <int>]| force ]}
+			Set the swiotlb TLB buffer initial size for Confidential Computing like
+			TDX and SEV-SNP.
+			<int> -- Number of I/O TLB of 256 bytes
+			<int> -- Number of I/O TLB of 4 KiB
+			<int> -- Number of I/O TLB of 64 KiB
+			<int> -- Number of I/O TLB of 256 KiB
+			force -- force using of cc bounce buffers even if they
+			         wouldn't be automatically used by the kernel (for debugging)
+
 	switches=	[HW,M68k]
 
 	sysctl.*=	[KNL]
diff --git a/kernel/dma/cc-swiotlb.c b/kernel/dma/cc-swiotlb.c
index e85d3ce2272f..ff1cc52189b9 100644
--- a/kernel/dma/cc-swiotlb.c
+++ b/kernel/dma/cc-swiotlb.c
@@ -52,6 +52,32 @@ enum SLOT_SIZE {
 
 const unsigned int SLOT_SIZES[NR_OF_SIZES] = {512, 2048, 4096, 16 * 1024, 512 * 1024};
 unsigned int WATERMARK_SLOT_SIZE[NR_OF_SIZES] = {256, 16384, 8192, 1024, 32};
+static bool swiotlb_force_bounce = false;
+
+static int __init
+setup_io_tlb_watermark(char *str)
+{
+	int i;
+	size_t size;
+
+	for (i = 0; i < NR_OF_SIZES; i++) {
+		if (isdigit(*str)) {
+			size = simple_strtoul(str, &str, 0);
+			WATERMARK_SLOT_SIZE[i] = size;
+
+			if (*str == ',')
+				++str;
+		}
+		else
+			break;
+	}
+
+	if (!strcmp(str, "force"))
+		swiotlb_force_bounce = true;
+
+	return 0;
+}
+early_param("cc_swiotlb", setup_io_tlb_watermark);
 
 struct slot_terrace {
 	struct list_head slots_by_size[NR_OF_SIZES];
@@ -330,6 +356,7 @@ static void cc_populate_pages(void)
 	size_t i, j, k;
 	const size_t max_bytes_per_alloc = (MAX_ORDER_NR_PAGES << PAGE_SHIFT);
 	size_t remain_alloc_size, rounds, round_size, round_slot_nr;
+	size_t size = 0;
 
 	for (i = 0; i < NR_OF_SIZES; i++) {
 		if (atomic_read(&terrace.free_count_by_size[i]) > WATERMARK_SLOT_SIZE[i])
@@ -377,6 +404,11 @@ static void cc_populate_pages(void)
 			spin_unlock_irqrestore(&terrace.lock_by_size[i], flags);
 		}
 	}
+
+	for (i = 0; i < NR_OF_SIZES; i++) {
+		size += (size_t)atomic_read(&terrace.total_count_by_size[i]) * SLOT_SIZES[i];
+	}
+	pr_info("bounce buffer size adjusted to %luMB", size >> 20);
 }
 
 static int kccd(void *p)
@@ -437,7 +469,7 @@ void __init swiotlb_init(bool addressing_limit, unsigned int flags)
 		return;
 	}
 
-	io_tlb_default_mem.force_bounce = cc_platform_has(CC_ATTR_MEM_ENCRYPT);
+	io_tlb_default_mem.force_bounce = cc_platform_has(CC_ATTR_MEM_ENCRYPT) || swiotlb_force_bounce;
 
 	xa_init_flags(io_tlb_default_mem.mapping, 0);
 
-- 
2.31.1

