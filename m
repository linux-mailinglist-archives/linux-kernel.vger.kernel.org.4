Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453EE70042A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbjELJn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbjELJnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:43:16 -0400
Received: from out-18.mta0.migadu.com (out-18.mta0.migadu.com [IPv6:2001:41d0:1004:224b::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5413D12E95
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:42:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683884548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+3Cj7WM/5H/yN4K+1lxE1r8ARjSog11gtcnlJ0Ke9Cs=;
        b=LoyWQci7E7aehvM7RvdT5fPZDShGQ0N3hNobaGAYqQcwfBmJdJo6pX3oyMFuEuj73ybj1D
        kvJRMx80dPfs9ElFWf5o/QxBLIG4as4augYHlH0kmV7lyvL3hJrGCYfvR0m1Joc4JYGGif
        tnnA3xwaUSyksPgKlMMz11sZeCuICQY=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        paulmck@kernel.org, bp@suse.de, akpm@linux-foundation.org,
        peterz@infradead.org, rdunlap@infradead.org, kim.phillips@amd.com,
        rostedt@goodmis.org, thunder.leizhen@huawei.com, ardb@kernel.org,
        bhe@redhat.com, anshuman.khandual@arm.com,
        song.bao.hua@hisilicon.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] dma-contiguous: support per-numa CMA for all architectures
Date:   Fri, 12 May 2023 17:42:10 +0800
Message-Id: <20230512094210.141540-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit b7176c261cdb ("dma-contiguous: provide the ability to
reserve per-numa CMA"), Barry adds DMA_PERNUMA_CMA for ARM64.

But this feature is architecture independent, so support per-numa CMA
for all architectures, and enable it by default if NUMA.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 arch/arm64/mm/init.c                            | 2 --
 include/linux/dma-map-ops.h                     | 6 ------
 kernel/dma/Kconfig                              | 6 +++---
 kernel/dma/contiguous.c                         | 8 +++++++-
 5 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 56d9458276a6..ac0002b2e323 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -692,7 +692,7 @@
 			kernel/dma/contiguous.c
 
 	cma_pernuma=nn[MG]
-			[ARM64,KNL,CMA]
+			[KNL,CMA]
 			Sets the size of kernel per-numa memory area for
 			contiguous memory allocations. A value of 0 disables
 			per-numa CMA altogether. And If this option is not
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 66e70ca47680..d560aef6aafa 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -410,8 +410,6 @@ void __init bootmem_init(void)
 	arm64_hugetlb_cma_reserve();
 #endif
 
-	dma_pernuma_cma_reserve();
-
 	kvm_hyp_reserve();
 
 	/*
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 31f114f486c4..7af9949828ff 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -168,12 +168,6 @@ static inline void dma_free_contiguous(struct device *dev, struct page *page,
 }
 #endif /* CONFIG_DMA_CMA*/
 
-#ifdef CONFIG_DMA_PERNUMA_CMA
-void dma_pernuma_cma_reserve(void);
-#else
-static inline void dma_pernuma_cma_reserve(void) { }
-#endif /* CONFIG_DMA_PERNUMA_CMA */
-
 #ifdef CONFIG_DMA_DECLARE_COHERENT
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 		dma_addr_t device_addr, size_t size);
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 6677d0e64d27..79f83091e3a2 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -140,10 +140,10 @@ if  DMA_CMA
 
 config DMA_PERNUMA_CMA
 	bool "Enable separate DMA Contiguous Memory Area for each NUMA Node"
-	default NUMA && ARM64
+	default NUMA
 	help
-	  Enable this option to get pernuma CMA areas so that devices like
-	  ARM64 SMMU can get local memory by DMA coherent APIs.
+	  Enable this option to get pernuma CMA areas so that NUMA devices
+	  can get local memory by DMA coherent APIs.
 
 	  You can set the size of pernuma CMA by specifying "cma_pernuma=size"
 	  on the kernel's command line.
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 6ea80ae42622..26a8e5365fcd 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -128,7 +128,7 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
 #endif
 
 #ifdef CONFIG_DMA_PERNUMA_CMA
-void __init dma_pernuma_cma_reserve(void)
+static void __init dma_pernuma_cma_reserve(void)
 {
 	int nid;
 
@@ -153,6 +153,10 @@ void __init dma_pernuma_cma_reserve(void)
 			(unsigned long long)pernuma_size_bytes / SZ_1M, nid);
 	}
 }
+#else
+static inline void __init dma_pernuma_cma_reserve(void)
+{
+}
 #endif
 
 /**
@@ -171,6 +175,8 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 	phys_addr_t selected_limit = limit;
 	bool fixed = false;
 
+	dma_pernuma_cma_reserve();
+
 	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
 
 	if (size_cmdline != -1) {
-- 
2.25.1

