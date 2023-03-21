Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5290A6C37C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCURG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCURGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:06:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81320532A6;
        Tue, 21 Mar 2023 10:05:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 439D2B818D3;
        Tue, 21 Mar 2023 17:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D557C433A0;
        Tue, 21 Mar 2023 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418356;
        bh=UNeFcb5PNOhwqohZU+Jc2J8lUuh4fggG90Bd0WQdoSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbrXwF/kWX943Eora0PJmXJuxATEdUYCAPvoSgcIKCZJN2+aVQ3+4FbdbyaX7bFPu
         /UCIEShcsyTs0b349/pkEgxG0v9MvQUm10kAiG25e8SlRbLmuVE0keHHqMtyb02mjT
         37yRRmT8heaLbWNDw5y8ztkpYs0qagpbvs7cAdTDffAtzNFBzqRb5zizcPx63j8e+d
         fs62HRzsup8cLdnMthq6A5r2MnkK2VKvxGdOpN4yBqsraDyazwIDsZVNUCDTePcmqQ
         58NrKKA65LXKm2NwaoHuT4qdRwk2ck2hjd6d1/hCqXqCDff/5DYT/SRynEpt+hqFIj
         0N//T5rQMIV2w==
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
Subject: [PATCH v2 07/14] init,mm: move mm_init() to mm/mm_init.c and rename it to mm_core_init()
Date:   Tue, 21 Mar 2023 19:05:06 +0200
Message-Id: <20230321170513.2401534-8-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230321170513.2401534-1-rppt@kernel.org>
References: <20230321170513.2401534-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Make mm_init() a part of mm/ codebase. mm_core_init() better describes
what the function does and does not clash with mm_init() in kernel/fork.c

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  1 +
 init/main.c        | 71 ++------------------------------------------
 mm/mm_init.c       | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ee755bb4e1c1..2d7f095136fc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -39,6 +39,7 @@ struct pt_regs;
 
 extern int sysctl_page_lock_unfairness;
 
+void mm_core_init(void);
 void init_mm_internals(void);
 
 #ifndef CONFIG_NUMA		/* Don't use mapnrs, do it properly */
diff --git a/init/main.c b/init/main.c
index 4423906177c1..8a20b4c25f24 100644
--- a/init/main.c
+++ b/init/main.c
@@ -803,73 +803,6 @@ static inline void initcall_debug_enable(void)
 }
 #endif
 
-/* Report memory auto-initialization states for this boot. */
-static void __init report_meminit(void)
-{
-	const char *stack;
-
-	if (IS_ENABLED(CONFIG_INIT_STACK_ALL_PATTERN))
-		stack = "all(pattern)";
-	else if (IS_ENABLED(CONFIG_INIT_STACK_ALL_ZERO))
-		stack = "all(zero)";
-	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL))
-		stack = "byref_all(zero)";
-	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF))
-		stack = "byref(zero)";
-	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_USER))
-		stack = "__user(zero)";
-	else
-		stack = "off";
-
-	pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s\n",
-		stack, want_init_on_alloc(GFP_KERNEL) ? "on" : "off",
-		want_init_on_free() ? "on" : "off");
-	if (want_init_on_free())
-		pr_info("mem auto-init: clearing system memory may take some time...\n");
-}
-
-/*
- * Set up kernel memory allocators
- */
-static void __init mm_init(void)
-{
-	/* Initializations relying on SMP setup */
-	build_all_zonelists(NULL);
-	page_alloc_init_cpuhp();
-
-	/*
-	 * page_ext requires contiguous pages,
-	 * bigger than MAX_ORDER unless SPARSEMEM.
-	 */
-	page_ext_init_flatmem();
-	init_mem_debugging_and_hardening();
-	kfence_alloc_pool();
-	report_meminit();
-	kmsan_init_shadow();
-	stack_depot_early_init();
-	mem_init();
-	mem_init_print_info();
-	kmem_cache_init();
-	/*
-	 * page_owner must be initialized after buddy is ready, and also after
-	 * slab is ready so that stack_depot_init() works properly
-	 */
-	page_ext_init_flatmem_late();
-	kmemleak_init();
-	pgtable_init();
-	debug_objects_mem_init();
-	vmalloc_init();
-	/* If no deferred init page_ext now, as vmap is fully initialized */
-	if (!deferred_struct_pages)
-		page_ext_init();
-	/* Should be run before the first non-init thread is created */
-	init_espfix_bsp();
-	/* Should be run after espfix64 is set up. */
-	pti_init();
-	kmsan_init_runtime();
-	mm_cache_init();
-}
-
 #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
 DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
 			   randomize_kstack_offset);
@@ -993,13 +926,13 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 
 	/*
 	 * These use large bootmem allocations and must precede
-	 * kmem_cache_init()
+	 * initalization of page allocator
 	 */
 	setup_log_buf(0);
 	vfs_caches_init_early();
 	sort_main_extable();
 	trap_init();
-	mm_init();
+	mm_core_init();
 	poking_init();
 	ftrace_init();
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 2e60c7186132..bba73f1fb277 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -20,9 +20,15 @@
 #include <linux/nmi.h>
 #include <linux/buffer_head.h>
 #include <linux/kmemleak.h>
+#include <linux/kfence.h>
+#include <linux/page_ext.h>
+#include <linux/pti.h>
+#include <linux/pgtable.h>
 #include "internal.h"
 #include "shuffle.h"
 
+#include <asm/setup.h>
+
 #ifdef CONFIG_DEBUG_MEMORY_INIT
 int __meminitdata mminit_loglevel;
 
@@ -2524,3 +2530,70 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 	}
 	__free_pages_core(page, order);
 }
+
+/* Report memory auto-initialization states for this boot. */
+static void __init report_meminit(void)
+{
+	const char *stack;
+
+	if (IS_ENABLED(CONFIG_INIT_STACK_ALL_PATTERN))
+		stack = "all(pattern)";
+	else if (IS_ENABLED(CONFIG_INIT_STACK_ALL_ZERO))
+		stack = "all(zero)";
+	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL))
+		stack = "byref_all(zero)";
+	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF))
+		stack = "byref(zero)";
+	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_USER))
+		stack = "__user(zero)";
+	else
+		stack = "off";
+
+	pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s\n",
+		stack, want_init_on_alloc(GFP_KERNEL) ? "on" : "off",
+		want_init_on_free() ? "on" : "off");
+	if (want_init_on_free())
+		pr_info("mem auto-init: clearing system memory may take some time...\n");
+}
+
+/*
+ * Set up kernel memory allocators
+ */
+void __init mm_core_init(void)
+{
+	/* Initializations relying on SMP setup */
+	build_all_zonelists(NULL);
+	page_alloc_init_cpuhp();
+
+	/*
+	 * page_ext requires contiguous pages,
+	 * bigger than MAX_ORDER unless SPARSEMEM.
+	 */
+	page_ext_init_flatmem();
+	init_mem_debugging_and_hardening();
+	kfence_alloc_pool();
+	report_meminit();
+	kmsan_init_shadow();
+	stack_depot_early_init();
+	mem_init();
+	mem_init_print_info();
+	kmem_cache_init();
+	/*
+	 * page_owner must be initialized after buddy is ready, and also after
+	 * slab is ready so that stack_depot_init() works properly
+	 */
+	page_ext_init_flatmem_late();
+	kmemleak_init();
+	pgtable_init();
+	debug_objects_mem_init();
+	vmalloc_init();
+	/* If no deferred init page_ext now, as vmap is fully initialized */
+	if (!deferred_struct_pages)
+		page_ext_init();
+	/* Should be run before the first non-init thread is created */
+	init_espfix_bsp();
+	/* Should be run after espfix64 is set up. */
+	pti_init();
+	kmsan_init_runtime();
+	mm_cache_init();
+}
-- 
2.35.1

