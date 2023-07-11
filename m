Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D772E74EC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGKLIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjGKLIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:08:45 -0400
Received: from out-55.mta0.migadu.com (out-55.mta0.migadu.com [91.218.175.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9627198
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:08:43 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689073721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sAvPVqbMcp2TybCf1Z86U0frVvWU/WtmCXaxMcua7kM=;
        b=YmyQUNnNATJN4qAB7pRjjEKjAzHQCjxQ0BeEipq1lzdzcbiMkUmahQiJ2fh7x58Z29EBw1
        DeEeZl6J/Mb/pEhIzOgtnUliVLU7iAUrDuRFtFiGAza4TmvlKbvmdFDJSSFOxxEHCuKwT3
        ETqfC/V+yLTo77Z6XjJaFu3ODrje2nw=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, akpm@linux-foundation.org,
        paulmck@kernel.org, catalin.marinas@arm.com, rdunlap@infradead.org,
        rostedt@goodmis.org, kim.phillips@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-mm@kvack.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] dma-contiguous: support numa CMA for specified node
Date:   Tue, 11 Jul 2023 19:08:22 +0800
Message-Id: <20230711110822.1105785-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel parameter 'cma_pernuma=' only supports reserving the same
size of CMA area for each node. We need to reserve different sizes of
CMA area for specified nodes if these devices belong to different nodes.

Adding another kernel parameter 'numa_cma=' to reserve CMA area for
the specified node. If we want to use one of the parameters, we need to
enable DMA_NUMA_CMA.

At the same time, print the node id in cma_declare_contiguous_nid() if
CONFIG_NUMA is enabled.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 V1 -> V2: Add 'numa_cma=' and keep 'cma_pernuma=' kernel parameter.
---
 .../admin-guide/kernel-parameters.txt         |  11 ++
 kernel/dma/Kconfig                            |   9 +-
 kernel/dma/contiguous.c                       | 101 ++++++++++++++----
 mm/cma.c                                      |  12 ++-
 4 files changed, 104 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdf0ab6716c8..87ad8154b730 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -706,6 +706,17 @@
 			which is located in node nid, if the allocation fails,
 			they will fallback to the global default memory area.
 
+	numa_cma=<node>:nn[MG][,<node>:nn[MG]]
+			[KNL,CMA]
+			Sets the size of kernel numa memory area for
+			contiguous memory allocations. It will reserve CMA
+			area for the specified node.
+
+			With numa CMA enabled, DMA users on node nid will
+			first try to allocate buffer from the numa area
+			which is located in node nid, if the allocation fails,
+			they will fallback to the global default memory area.
+
 	cmo_free_hint=	[PPC] Format: { yes | no }
 			Specify whether pages are marked as being inactive
 			when they are freed.  This is used in CMO environments
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 7afde9bc529f..562463fe30ea 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -145,15 +145,16 @@ config DMA_CMA
 
 if  DMA_CMA
 
-config DMA_PERNUMA_CMA
-	bool "Enable separate DMA Contiguous Memory Area for each NUMA Node"
+config DMA_NUMA_CMA
+	bool "Enable separate DMA Contiguous Memory Area for NUMA Node"
 	default NUMA
 	help
-	  Enable this option to get pernuma CMA areas so that NUMA devices
+	  Enable this option to get numa CMA areas so that NUMA devices
 	  can get local memory by DMA coherent APIs.
 
 	  You can set the size of pernuma CMA by specifying "cma_pernuma=size"
-	  on the kernel's command line.
+	  or set the node id and its size of CMA by specifying "numa_cma=
+	  <node>:size[,<node>:size]" on the kernel's command line.
 
 comment "Default contiguous memory area size:"
 
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 26a8e5365fcd..f005c66f378c 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -50,6 +50,7 @@
 #include <linux/sizes.h>
 #include <linux/dma-map-ops.h>
 #include <linux/cma.h>
+#include <linux/nospec.h>
 
 #ifdef CONFIG_CMA_SIZE_MBYTES
 #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
@@ -96,11 +97,44 @@ static int __init early_cma(char *p)
 }
 early_param("cma", early_cma);
 
-#ifdef CONFIG_DMA_PERNUMA_CMA
+#ifdef CONFIG_DMA_NUMA_CMA
 
+static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
+static phys_addr_t numa_cma_size[MAX_NUMNODES] __initdata;
 static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
 static phys_addr_t pernuma_size_bytes __initdata;
 
+static int __init early_numa_cma(char *p)
+{
+	int nid, count = 0;
+	unsigned long tmp;
+	char *s = p;
+
+	while (*s) {
+		if (sscanf(s, "%lu%n", &tmp, &count) != 1)
+			break;
+
+		if (s[count] == ':') {
+			if (tmp >= MAX_NUMNODES)
+				break;
+			nid = array_index_nospec(tmp, MAX_NUMNODES);
+
+			s += count + 1;
+			tmp = memparse(s, &s);
+			numa_cma_size[nid] = tmp;
+
+			if (*s == ',')
+				s++;
+			else
+				break;
+		} else
+			break;
+	}
+
+	return 0;
+}
+early_param("numa_cma", early_numa_cma);
+
 static int __init early_cma_pernuma(char *p)
 {
 	pernuma_size_bytes = memparse(p, &p);
@@ -127,34 +161,47 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
 
 #endif
 
-#ifdef CONFIG_DMA_PERNUMA_CMA
-static void __init dma_pernuma_cma_reserve(void)
+#ifdef CONFIG_DMA_NUMA_CMA
+static void __init dma_numa_cma_reserve(void)
 {
 	int nid;
 
-	if (!pernuma_size_bytes)
-		return;
-
-	for_each_online_node(nid) {
+	for_each_node(nid) {
 		int ret;
 		char name[CMA_MAX_NAME];
-		struct cma **cma = &dma_contiguous_pernuma_area[nid];
-
-		snprintf(name, sizeof(name), "pernuma%d", nid);
-		ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
-						 0, false, name, cma, nid);
-		if (ret) {
-			pr_warn("%s: reservation failed: err %d, node %d", __func__,
-				ret, nid);
+		struct cma **cma;
+
+		if (!node_online(nid)) {
+			if (pernuma_size_bytes || numa_cma_size[nid])
+				pr_warn("invalid node %d specified\n", nid);
 			continue;
 		}
 
-		pr_debug("%s: reserved %llu MiB on node %d\n", __func__,
-			(unsigned long long)pernuma_size_bytes / SZ_1M, nid);
+		if (pernuma_size_bytes) {
+
+			cma = &dma_contiguous_pernuma_area[nid];
+			snprintf(name, sizeof(name), "pernuma%d", nid);
+			ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
+							 0, false, name, cma, nid);
+			if (ret)
+				pr_warn("%s: reservation failed: err %d, node %d", __func__,
+					ret, nid);
+		}
+
+		if (numa_cma_size[nid]) {
+
+			cma = &dma_contiguous_numa_area[nid];
+			snprintf(name, sizeof(name), "numa%d", nid);
+			ret = cma_declare_contiguous_nid(0, numa_cma_size[nid], 0, 0, 0, false,
+							 name, cma, nid);
+			if (ret)
+				pr_warn("%s: reservation failed: err %d, node %d", __func__,
+					ret, nid);
+		}
 	}
 }
 #else
-static inline void __init dma_pernuma_cma_reserve(void)
+static inline void __init dma_numa_cma_reserve(void)
 {
 }
 #endif
@@ -175,7 +222,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 	phys_addr_t selected_limit = limit;
 	bool fixed = false;
 
-	dma_pernuma_cma_reserve();
+	dma_numa_cma_reserve();
 
 	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
 
@@ -309,7 +356,7 @@ static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
  */
 struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 {
-#ifdef CONFIG_DMA_PERNUMA_CMA
+#ifdef CONFIG_DMA_NUMA_CMA
 	int nid = dev_to_node(dev);
 #endif
 
@@ -321,7 +368,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 	if (size <= PAGE_SIZE)
 		return NULL;
 
-#ifdef CONFIG_DMA_PERNUMA_CMA
+#ifdef CONFIG_DMA_NUMA_CMA
 	if (nid != NUMA_NO_NODE && !(gfp & (GFP_DMA | GFP_DMA32))) {
 		struct cma *cma = dma_contiguous_pernuma_area[nid];
 		struct page *page;
@@ -331,6 +378,13 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 			if (page)
 				return page;
 		}
+
+		cma = dma_contiguous_numa_area[nid];
+		if (cma) {
+			page = cma_alloc_aligned(cma, size, gfp);
+			if (page)
+				return page;
+		}
 	}
 #endif
 	if (!dma_contiguous_default_area)
@@ -362,10 +416,13 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 		/*
 		 * otherwise, page is from either per-numa cma or default cma
 		 */
-#ifdef CONFIG_DMA_PERNUMA_CMA
+#ifdef CONFIG_DMA_NUMA_CMA
 		if (cma_release(dma_contiguous_pernuma_area[page_to_nid(page)],
 					page, count))
 			return;
+		if (cma_release(dma_contiguous_numa_area[page_to_nid(page)],
+					page, count))
+			return;
 #endif
 		if (cma_release(dma_contiguous_default_area, page, count))
 			return;
diff --git a/mm/cma.c b/mm/cma.c
index 4880f72102fa..af5945932e9e 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -244,6 +244,7 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 {
 	phys_addr_t memblock_end = memblock_end_of_DRAM();
 	phys_addr_t highmem_start;
+	char nid_buf[32] = "";
 	int ret = 0;
 
 	/*
@@ -267,6 +268,10 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 	if (alignment && !is_power_of_2(alignment))
 		return -EINVAL;
 
+#ifdef CONFIG_NUMA
+	if (nid != NUMA_NO_NODE)
+		snprintf(nid_buf, sizeof(nid_buf), " on node %d", nid);
+#endif
 	/* Sanitise input arguments. */
 	alignment = max_t(phys_addr_t, alignment, CMA_MIN_ALIGNMENT_BYTES);
 	if (fixed && base & (alignment - 1)) {
@@ -372,14 +377,15 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 	if (ret)
 		goto free_mem;
 
-	pr_info("Reserved %ld MiB at %pa\n", (unsigned long)size / SZ_1M,
-		&base);
+	pr_info("Reserved %ld MiB at %pa%s\n", (unsigned long)size / SZ_1M,
+		&base, nid_buf);
 	return 0;
 
 free_mem:
 	memblock_phys_free(base, size);
 err:
-	pr_err("Failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
+	pr_err("Failed to reserve %ld MiB%s\n", (unsigned long)size / SZ_1M,
+	       nid_buf);
 	return ret;
 }
 
-- 
2.25.1

