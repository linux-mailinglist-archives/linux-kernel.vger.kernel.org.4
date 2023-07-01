Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB897744825
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 11:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjGAJMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 05:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 05:12:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3007EB9;
        Sat,  1 Jul 2023 02:12:04 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QtRFj2W33ztQS7;
        Sat,  1 Jul 2023 17:09:13 +0800 (CST)
Received: from huawei.com (10.67.174.205) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 1 Jul
 2023 17:12:00 +0800
From:   Chen Jiahao <chenjiahao16@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <conor.dooley@microchip.com>, <guoren@kernel.org>,
        <heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
        <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
        <bhe@redhat.com>, <thunder.leizhen@huawei.com>, <horms@kernel.org>
Subject: [PATCH -next v6 1/2] riscv: kdump: Implement crashkernel=X,[high,low]
Date:   Sat, 1 Jul 2023 17:11:37 +0000
Message-ID: <20230701171138.1491206-2-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701171138.1491206-1-chenjiahao16@huawei.com>
References: <20230701171138.1491206-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On riscv, the current crash kernel allocation logic is trying to
allocate within 32bit addressible memory region by default, if
failed, try to allocate without 4G restriction.

In need of saving DMA zone memory while allocating a relatively large
crash kernel region, allocating the reserved memory top down in
high memory, without overlapping the DMA zone, is a mature solution.
Here introduce the parameter option crashkernel=X,[high,low].

One can reserve the crash kernel from high memory above DMA zone range
by explicitly passing "crashkernel=X,high"; or reserve a memory range
below 4G with "crashkernel=X,low".

Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
Acked-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/setup.c |  5 +++
 arch/riscv/mm/init.c      | 84 +++++++++++++++++++++++++++++++++++----
 2 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 971fe776e2f8..376f5d49ce85 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -178,6 +178,11 @@ static void __init init_resources(void)
 		if (ret < 0)
 			goto error;
 	}
+	if (crashk_low_res.start != crashk_low_res.end) {
+		ret = add_resource(&iomem_resource, &crashk_low_res);
+		if (ret < 0)
+			goto error;
+	}
 #endif
 
 #ifdef CONFIG_CRASH_DUMP
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4b95d8999120..eeb31c2cc843 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1298,6 +1298,28 @@ static inline void setup_vm_final(void)
 }
 #endif /* CONFIG_MMU */
 
+/* Reserve 128M low memory by default for swiotlb buffer */
+#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
+
+static int __init reserve_crashkernel_low(unsigned long long low_size)
+{
+	unsigned long long low_base;
+
+	low_base = memblock_phys_alloc_range(low_size, PMD_SIZE, 0, dma32_phys_limit);
+	if (!low_base) {
+		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
+		return -ENOMEM;
+	}
+
+	pr_info("crashkernel low memory reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
+		low_base, low_base + low_size, low_size >> 20);
+
+	crashk_low_res.start = low_base;
+	crashk_low_res.end = low_base + low_size - 1;
+
+	return 0;
+}
+
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -1309,8 +1331,12 @@ static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_base = 0;
 	unsigned long long crash_size = 0;
+	unsigned long long crash_low_size = 0;
 	unsigned long search_start = memblock_start_of_DRAM();
-	unsigned long search_end = memblock_end_of_DRAM();
+	unsigned long search_end = (unsigned long)dma32_phys_limit;
+	char *cmdline = boot_command_line;
+	bool fixed_base = false;
+	bool high = false;
 
 	int ret = 0;
 
@@ -1326,14 +1352,36 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
+	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
-	if (ret || !crash_size)
+	if (ret == -ENOENT) {
+		/* Fallback to crashkernel=X,[high,low] */
+		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
+		if (ret || !crash_size)
+			return;
+
+		/*
+		 * crashkernel=Y,low is valid only when crashkernel=X,high
+		 * is passed.
+		 */
+		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
+		if (ret == -ENOENT)
+			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+		else if (ret)
+			return;
+
+		search_start = (unsigned long)dma32_phys_limit;
+		search_end = memblock_end_of_DRAM();
+		high = true;
+	} else if (ret || !crash_size) {
+		/* Invalid argument value specified */
 		return;
+	}
 
 	crash_size = PAGE_ALIGN(crash_size);
 
 	if (crash_base) {
+		fixed_base = true;
 		search_start = crash_base;
 		search_end = crash_base + crash_size;
 	}
@@ -1346,17 +1394,39 @@ static void __init reserve_crashkernel(void)
 	 * swiotlb can work on the crash kernel.
 	 */
 	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
-					       search_start,
-					       min(search_end, (unsigned long) SZ_4G));
+					       search_start, search_end);
 	if (crash_base == 0) {
-		/* Try again without restricting region to 32bit addressible memory */
+		if (fixed_base) {
+			pr_warn("crashkernel: allocating failed with given size@offset\n");
+			return;
+		}
+
+		if (high) {
+			/* Fall back to lower 32G reservation */
+			search_start = memblock_start_of_DRAM();
+			search_end = (unsigned long)dma32_phys_limit;
+		} else {
+			/* Try again above the region of 32bit addressible memory */
+			search_start = (unsigned long)dma32_phys_limit;
+			search_end = memblock_end_of_DRAM();
+		}
+
 		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
-						search_start, search_end);
+						       search_start, search_end);
 		if (crash_base == 0) {
 			pr_warn("crashkernel: couldn't allocate %lldKB\n",
 				crash_size >> 10);
 			return;
 		}
+
+		if (!crash_low_size)
+			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+	}
+
+	if ((crash_base >= dma32_phys_limit) && crash_low_size &&
+	     reserve_crashkernel_low(crash_low_size)) {
+		memblock_phys_free(crash_base, crash_size);
+		return;
 	}
 
 	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
-- 
2.34.1

