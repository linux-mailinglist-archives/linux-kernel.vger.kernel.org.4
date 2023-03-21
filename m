Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFE6C37C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCURHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjCURGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:06:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F8624BEA;
        Tue, 21 Mar 2023 10:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A1A061D0F;
        Tue, 21 Mar 2023 17:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812AFC4339E;
        Tue, 21 Mar 2023 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418371;
        bh=fqHaVBEvzabne3Dop/TkCX/BaEIQUJvhFGbckVVeK4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EswGc4q0QKmJ7EyhCkitVV0N/4ViId31sNORi954j8wnF/z0Piph4dSyMRuZXT10B
         b4KTwFQDgSUf68C8Jy4KFF1qFuZmAyzpyBOZzyXo0YcpImj2kItQE2Z/rWH90IArLh
         BLVoShVB5l7vZAezjAlG7xRqJ/SOrSXbTGEDFx1cNWjSy+u5sNTid6qd9v4xpb13N9
         0QEg0DQIP6zfBM1gdULTCdjKt1bdCwWWMEsu3JLuYRZ8YViyE9UKpJQY4N9pVRcFQM
         eXVjTXOcDceZTfRls65Qp3Hxifo5eomdIn+n2rVV79KZNxNcabX9tgwegKbMv33jp+
         zKtajkzcBNKng==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 11/14] mm: move mem_init_print_info() to mm_init.c
Date:   Tue, 21 Mar 2023 19:05:10 +0200
Message-Id: <20230321170513.2401534-12-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230321170513.2401534-1-rppt@kernel.org>
References: <20230321170513.2401534-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

mem_init_print_info() is only called from mm_core_init().

Move it close to the caller and make it static.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  1 -
 mm/internal.h      |  1 +
 mm/mm_init.c       | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c    | 53 ----------------------------------------------
 4 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2fecabb1a328..e249208f8fbe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2925,7 +2925,6 @@ extern unsigned long free_reserved_area(void *start, void *end,
 					int poison, const char *s);
 
 extern void adjust_managed_page_count(struct page *page, long count);
-extern void mem_init_print_info(void);
 
 extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
 
diff --git a/mm/internal.h b/mm/internal.h
index 4750e3a7fd0d..02273c5e971f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -201,6 +201,7 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
 /*
  * in mm/page_alloc.c
  */
+#define K(x) ((x) << (PAGE_SHIFT-10))
 
 extern char * const zone_names[MAX_NR_ZONES];
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index ff70da11e797..8adadf51bbd2 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -24,6 +24,8 @@
 #include <linux/page_ext.h>
 #include <linux/pti.h>
 #include <linux/pgtable.h>
+#include <linux/swap.h>
+#include <linux/cma.h>
 #include "internal.h"
 #include "shuffle.h"
 
@@ -2649,6 +2651,57 @@ static void __init report_meminit(void)
 		pr_info("mem auto-init: clearing system memory may take some time...\n");
 }
 
+static void __init mem_init_print_info(void)
+{
+	unsigned long physpages, codesize, datasize, rosize, bss_size;
+	unsigned long init_code_size, init_data_size;
+
+	physpages = get_num_physpages();
+	codesize = _etext - _stext;
+	datasize = _edata - _sdata;
+	rosize = __end_rodata - __start_rodata;
+	bss_size = __bss_stop - __bss_start;
+	init_data_size = __init_end - __init_begin;
+	init_code_size = _einittext - _sinittext;
+
+	/*
+	 * Detect special cases and adjust section sizes accordingly:
+	 * 1) .init.* may be embedded into .data sections
+	 * 2) .init.text.* may be out of [__init_begin, __init_end],
+	 *    please refer to arch/tile/kernel/vmlinux.lds.S.
+	 * 3) .rodata.* may be embedded into .text or .data sections.
+	 */
+#define adj_init_size(start, end, size, pos, adj) \
+	do { \
+		if (&start[0] <= &pos[0] && &pos[0] < &end[0] && size > adj) \
+			size -= adj; \
+	} while (0)
+
+	adj_init_size(__init_begin, __init_end, init_data_size,
+		     _sinittext, init_code_size);
+	adj_init_size(_stext, _etext, codesize, _sinittext, init_code_size);
+	adj_init_size(_sdata, _edata, datasize, __init_begin, init_data_size);
+	adj_init_size(_stext, _etext, codesize, __start_rodata, rosize);
+	adj_init_size(_sdata, _edata, datasize, __start_rodata, rosize);
+
+#undef	adj_init_size
+
+	pr_info("Memory: %luK/%luK available (%luK kernel code, %luK rwdata, %luK rodata, %luK init, %luK bss, %luK reserved, %luK cma-reserved"
+#ifdef	CONFIG_HIGHMEM
+		", %luK highmem"
+#endif
+		")\n",
+		K(nr_free_pages()), K(physpages),
+		codesize / SZ_1K, datasize / SZ_1K, rosize / SZ_1K,
+		(init_data_size + init_code_size) / SZ_1K, bss_size / SZ_1K,
+		K(physpages - totalram_pages() - totalcma_pages),
+		K(totalcma_pages)
+#ifdef	CONFIG_HIGHMEM
+		, K(totalhigh_pages())
+#endif
+		);
+}
+
 /*
  * Set up kernel memory allocators
  */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2f333c26170c..bb0099f7da93 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5239,8 +5239,6 @@ static bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask
 	return !node_isset(nid, *nodemask);
 }
 
-#define K(x) ((x) << (PAGE_SHIFT-10))
-
 static void show_migration_types(unsigned char type)
 {
 	static const char types[MIGRATE_TYPES] = {
@@ -6200,57 +6198,6 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 	return pages;
 }
 
-void __init mem_init_print_info(void)
-{
-	unsigned long physpages, codesize, datasize, rosize, bss_size;
-	unsigned long init_code_size, init_data_size;
-
-	physpages = get_num_physpages();
-	codesize = _etext - _stext;
-	datasize = _edata - _sdata;
-	rosize = __end_rodata - __start_rodata;
-	bss_size = __bss_stop - __bss_start;
-	init_data_size = __init_end - __init_begin;
-	init_code_size = _einittext - _sinittext;
-
-	/*
-	 * Detect special cases and adjust section sizes accordingly:
-	 * 1) .init.* may be embedded into .data sections
-	 * 2) .init.text.* may be out of [__init_begin, __init_end],
-	 *    please refer to arch/tile/kernel/vmlinux.lds.S.
-	 * 3) .rodata.* may be embedded into .text or .data sections.
-	 */
-#define adj_init_size(start, end, size, pos, adj) \
-	do { \
-		if (&start[0] <= &pos[0] && &pos[0] < &end[0] && size > adj) \
-			size -= adj; \
-	} while (0)
-
-	adj_init_size(__init_begin, __init_end, init_data_size,
-		     _sinittext, init_code_size);
-	adj_init_size(_stext, _etext, codesize, _sinittext, init_code_size);
-	adj_init_size(_sdata, _edata, datasize, __init_begin, init_data_size);
-	adj_init_size(_stext, _etext, codesize, __start_rodata, rosize);
-	adj_init_size(_sdata, _edata, datasize, __start_rodata, rosize);
-
-#undef	adj_init_size
-
-	pr_info("Memory: %luK/%luK available (%luK kernel code, %luK rwdata, %luK rodata, %luK init, %luK bss, %luK reserved, %luK cma-reserved"
-#ifdef	CONFIG_HIGHMEM
-		", %luK highmem"
-#endif
-		")\n",
-		K(nr_free_pages()), K(physpages),
-		codesize / SZ_1K, datasize / SZ_1K, rosize / SZ_1K,
-		(init_data_size + init_code_size) / SZ_1K, bss_size / SZ_1K,
-		K(physpages - totalram_pages() - totalcma_pages),
-		K(totalcma_pages)
-#ifdef	CONFIG_HIGHMEM
-		, K(totalhigh_pages())
-#endif
-		);
-}
-
 static int page_alloc_cpu_dead(unsigned int cpu)
 {
 	struct zone *zone;
-- 
2.35.1

