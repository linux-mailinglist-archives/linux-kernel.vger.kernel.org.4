Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B67274CF1A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjGJHwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjGJHvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:51:54 -0400
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571523A84
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:50:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688975406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q0vhRlBTeULR80skrZFYKvSx31/Ubeonn4r0lIgH5eg=;
        b=FDrKxT7kix7z4dmE02nN3Z9PdkA1Xp+Z/rtKMFvrMD4R7SPHM3mgNbPjgCeKuPtSaG9CAt
        XrT0fxeKeCiUmiU1eP1Po3BqEGLYaDhYSVhUWjGWd8Ic0Nkl5aWTMYx0dL7x7KTJ/A+oEM
        2w2IgqPPM3OpVXR8M+7ONLY0LKSE+24=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, akpm@linux-foundation.org,
        paulmck@kernel.org, catalin.marinas@arm.com, rdunlap@infradead.org,
        peterz@infradead.org, rostedt@goodmis.org, kim.phillips@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-mm@kvack.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] dma-contiguous: support numa CMA for specified node
Date:   Mon, 10 Jul 2023 15:49:44 +0800
Message-Id: <20230710074944.3501810-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel parameter 'cma_pernuma=' only supports reserving the same
size of CMA area for each node. We need to reserve different sizes of
CMA area for specified nodes if these devices belong to different nodes.

Change kernel parameter from 'cma_pernuma=' to 'numa_cma='. If node
isn't specified, it will reserve CMA area for per-numa node. if the node
is specified, it will reserve CMA area for the specified node.

At the same time, print the node id in cma_declare_contiguous_nid() if
enabled CONFIG_NUMA.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 .../admin-guide/kernel-parameters.txt         | 17 ++--
 kernel/dma/Kconfig                            | 11 +--
 kernel/dma/contiguous.c                       | 90 +++++++++++++------
 mm/cma.c                                      | 12 ++-
 4 files changed, 89 insertions(+), 41 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdf0ab6716c8..b287647f0873 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -695,14 +695,19 @@
 			altogether. For more information, see
 			kernel/dma/contiguous.c
 
-	cma_pernuma=nn[MG]
+	numa_cma=nn[MG] or (node format)
+			    <node>:nn[MG][,<node>:nn[MG]]
 			[KNL,CMA]
-			Sets the size of kernel per-numa memory area for
+			Sets the size of kernel numa memory area for
 			contiguous memory allocations. A value of 0 disables
-			per-numa CMA altogether. And If this option is not
-			specified, the default value is 0.
-			With per-numa CMA enabled, DMA users on node nid will
-			first try to allocate buffer from the pernuma area
+			numa CMA altogether. If this option is not specified,
+			the default value is 0. If node isn't specified, it
+			will reserve CMA area for per-numa node, if the node
+			is specified, it will reserve CMA area for the
+			specified node.
+
+			With numa CMA enabled, DMA users on node nid will
+			first try to allocate buffer from the numa area
 			which is located in node nid, if the allocation fails,
 			they will fallback to the global default memory area.
 
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 7afde9bc529f..f07fb97ef3e8 100644
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
 
-	  You can set the size of pernuma CMA by specifying "cma_pernuma=size"
-	  on the kernel's command line.
+	  You can set the size of pernuma CMA by specifying "numa_cma=size"
+	  or set the node id and its size of CMA by specifying "numa_cma=
+	  <node>:size[,<node>:size]" on the kernel's command line.
 
 comment "Default contiguous memory area size:"
 
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 26a8e5365fcd..bf62d78abff7 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -50,6 +50,7 @@
 #include <linux/sizes.h>
 #include <linux/dma-map-ops.h>
 #include <linux/cma.h>
+#include <linux/nospec.h>
 
 #ifdef CONFIG_CMA_SIZE_MBYTES
 #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
@@ -96,17 +97,44 @@ static int __init early_cma(char *p)
 }
 early_param("cma", early_cma);
 
-#ifdef CONFIG_DMA_PERNUMA_CMA
+#ifdef CONFIG_DMA_NUMA_CMA
 
-static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
+static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
 static phys_addr_t pernuma_size_bytes __initdata;
+static phys_addr_t numa_cma_size_in_node[MAX_NUMNODES] __initdata;
 
-static int __init early_cma_pernuma(char *p)
+static int __init early_numa_cma(char *p)
 {
-	pernuma_size_bytes = memparse(p, &p);
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
+			numa_cma_size_in_node[nid] = tmp;
+
+			if (*s == ',')
+				s++;
+			else
+				break;
+		} else {
+			pernuma_size_bytes = memparse(p, &p);
+			break;
+		}
+	}
+
 	return 0;
 }
-early_param("cma_pernuma", early_cma_pernuma);
+early_param("numa_cma", early_numa_cma);
 #endif
 
 #ifdef CONFIG_CMA_SIZE_PERCENTAGE
@@ -127,34 +155,42 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
 
 #endif
 
-#ifdef CONFIG_DMA_PERNUMA_CMA
-static void __init dma_pernuma_cma_reserve(void)
+#ifdef CONFIG_DMA_NUMA_CMA
+static void __init dma_numa_cma_reserve(void)
 {
+	phys_addr_t size;
 	int nid;
 
-	if (!pernuma_size_bytes)
-		return;
-
-	for_each_online_node(nid) {
+	for_each_node(nid) {
 		int ret;
 		char name[CMA_MAX_NAME];
-		struct cma **cma = &dma_contiguous_pernuma_area[nid];
+		struct cma **numa_cma;
 
-		snprintf(name, sizeof(name), "pernuma%d", nid);
-		ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
-						 0, false, name, cma, nid);
-		if (ret) {
-			pr_warn("%s: reservation failed: err %d, node %d", __func__,
-				ret, nid);
+		if (!node_online(nid)) {
+			if (pernuma_size_bytes || numa_cma_size_in_node[nid])
+				pr_warn("invalid node %d specified\n", nid);
 			continue;
 		}
 
-		pr_debug("%s: reserved %llu MiB on node %d\n", __func__,
-			(unsigned long long)pernuma_size_bytes / SZ_1M, nid);
+		if (pernuma_size_bytes)
+			size = pernuma_size_bytes;
+		else
+			size = numa_cma_size_in_node[nid];
+
+		if (!size)
+			continue;
+
+		numa_cma = &dma_contiguous_numa_area[nid];
+		snprintf(name, sizeof(name), "numa%d", nid);
+		ret = cma_declare_contiguous_nid(0, size, 0, 0, 0, false,
+						 name, numa_cma, nid);
+		if (ret)
+			pr_warn("%s: reservation failed: err %d, node %d", __func__,
+				ret, nid);
 	}
 }
 #else
-static inline void __init dma_pernuma_cma_reserve(void)
+static inline void __init dma_numa_cma_reserve(void)
 {
 }
 #endif
@@ -175,7 +211,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 	phys_addr_t selected_limit = limit;
 	bool fixed = false;
 
-	dma_pernuma_cma_reserve();
+	dma_numa_cma_reserve();
 
 	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
 
@@ -309,7 +345,7 @@ static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
  */
 struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 {
-#ifdef CONFIG_DMA_PERNUMA_CMA
+#ifdef CONFIG_DMA_NUMA_CMA
 	int nid = dev_to_node(dev);
 #endif
 
@@ -321,9 +357,9 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 	if (size <= PAGE_SIZE)
 		return NULL;
 
-#ifdef CONFIG_DMA_PERNUMA_CMA
+#ifdef CONFIG_DMA_NUMA_CMA
 	if (nid != NUMA_NO_NODE && !(gfp & (GFP_DMA | GFP_DMA32))) {
-		struct cma *cma = dma_contiguous_pernuma_area[nid];
+		struct cma *cma = dma_contiguous_numa_area[nid];
 		struct page *page;
 
 		if (cma) {
@@ -362,8 +398,8 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 		/*
 		 * otherwise, page is from either per-numa cma or default cma
 		 */
-#ifdef CONFIG_DMA_PERNUMA_CMA
-		if (cma_release(dma_contiguous_pernuma_area[page_to_nid(page)],
+#ifdef CONFIG_DMA_NUMA_CMA
+		if (cma_release(dma_contiguous_numa_area[page_to_nid(page)],
 					page, count))
 			return;
 #endif
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

