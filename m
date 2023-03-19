Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472B36C05EA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCSWCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjCSWB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:01:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918C71D909;
        Sun, 19 Mar 2023 15:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04FB1B80D28;
        Sun, 19 Mar 2023 22:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56DEC4339B;
        Sun, 19 Mar 2023 22:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679263258;
        bh=Ku/Uu0hCGZmfa3FpxlgXCqadz2KVOyqdqD9q1uKHmwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5K4QQ46qKwNSCgWcOY2eoUQDG6tMOpzrVlfzMqd5KxSDU8D54PeXg7BVDbq88NAy
         7qTkcbcGwgHcOiLDqN8zW2dwEl9CQ2/ZNPFDPQEgyWthnciohBW/LqLaGTv5rcaOxa
         1nFGfP3zT3Kxeqh8smJtVZwsXNG4Z5pDoKozcP4ncrAfv9xOF6FlBA/J45wfO58IB6
         OXsJRt6r7PccybHaqWRB+ls1lMAEIO9qlvxm8l8I46JCYdZ3H/RaViKbjvWqL1pKcP
         JQTWfTfu4giRjda+PXnQooYJl3x/nDL/M7LYoJjobqh4D/jU1/N5DVZzAEHxc6znBz
         hS5OotitB1CUw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 10/15] mm: move init_mem_debugging_and_hardening() to mm/mm_init.c
Date:   Mon, 20 Mar 2023 00:00:03 +0200
Message-Id: <20230319220008.2138576-11-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319220008.2138576-1-rppt@kernel.org>
References: <20230319220008.2138576-1-rppt@kernel.org>
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

init_mem_debugging_and_hardening() is only called from mm_core_init().

Move it close to the caller and make it static.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h |  1 -
 mm/internal.h      |  8 ++++
 mm/mm_init.c       | 89 +++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c    | 95 ----------------------------------------------
 4 files changed, 97 insertions(+), 96 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c3c67d8bc833..2fecabb1a328 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3394,7 +3394,6 @@ extern int apply_to_existing_page_range(struct mm_struct *mm,
 				   unsigned long address, unsigned long size,
 				   pte_fn_t fn, void *data);
 
-extern void __init init_mem_debugging_and_hardening(void);
 #ifdef CONFIG_PAGE_POISONING
 extern void __kernel_poison_pages(struct page *page, int numpages);
 extern void __kernel_unpoison_pages(struct page *page, int numpages);
diff --git a/mm/internal.h b/mm/internal.h
index 6b154b4a538f..827499e39d78 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -204,6 +204,14 @@ pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
 
 extern char * const zone_names[MAX_NR_ZONES];
 
+/* perform sanity checks on struct pages being allocated or freed */
+DECLARE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
+
+static inline bool is_check_pages_enabled(void)
+{
+	return static_branch_unlikely(&check_pages_enabled);
+}
+
 /*
  * Structure for holding the mostly immutable allocation parameters passed
  * between functions involved in allocations, including the alloc_pages*
diff --git a/mm/mm_init.c b/mm/mm_init.c
index a91fbb57c4cc..ae6bd26cf5a2 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2517,6 +2517,95 @@ static void __init pgtable_init(void)
 	pgtable_cache_init();
 }
 
+static bool _init_on_alloc_enabled_early __read_mostly
+				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
+static int __init early_init_on_alloc(char *buf)
+{
+
+	return kstrtobool(buf, &_init_on_alloc_enabled_early);
+}
+early_param("init_on_alloc", early_init_on_alloc);
+
+static bool _init_on_free_enabled_early __read_mostly
+				= IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON);
+static int __init early_init_on_free(char *buf)
+{
+	return kstrtobool(buf, &_init_on_free_enabled_early);
+}
+early_param("init_on_free", early_init_on_free);
+
+DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
+
+/*
+ * Enable static keys related to various memory debugging and hardening options.
+ * Some override others, and depend on early params that are evaluated in the
+ * order of appearance. So we need to first gather the full picture of what was
+ * enabled, and then make decisions.
+ */
+static void __init init_mem_debugging_and_hardening(void)
+{
+	bool page_poisoning_requested = false;
+	bool want_check_pages = false;
+
+#ifdef CONFIG_PAGE_POISONING
+	/*
+	 * Page poisoning is debug page alloc for some arches. If
+	 * either of those options are enabled, enable poisoning.
+	 */
+	if (page_poisoning_enabled() ||
+	     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
+	      debug_pagealloc_enabled())) {
+		static_branch_enable(&_page_poisoning_enabled);
+		page_poisoning_requested = true;
+		want_check_pages = true;
+	}
+#endif
+
+	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
+	    page_poisoning_requested) {
+		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
+			"will take precedence over init_on_alloc and init_on_free\n");
+		_init_on_alloc_enabled_early = false;
+		_init_on_free_enabled_early = false;
+	}
+
+	if (_init_on_alloc_enabled_early) {
+		want_check_pages = true;
+		static_branch_enable(&init_on_alloc);
+	} else {
+		static_branch_disable(&init_on_alloc);
+	}
+
+	if (_init_on_free_enabled_early) {
+		want_check_pages = true;
+		static_branch_enable(&init_on_free);
+	} else {
+		static_branch_disable(&init_on_free);
+	}
+
+	if (IS_ENABLED(CONFIG_KMSAN) &&
+	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early))
+		pr_info("mem auto-init: please make sure init_on_alloc and init_on_free are disabled when running KMSAN\n");
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	if (debug_pagealloc_enabled()) {
+		want_check_pages = true;
+		static_branch_enable(&_debug_pagealloc_enabled);
+
+		if (debug_guardpage_minorder())
+			static_branch_enable(&_debug_guardpage_enabled);
+	}
+#endif
+
+	/*
+	 * Any page debugging or hardening option also enables sanity checking
+	 * of struct pages being allocated or freed. With CONFIG_DEBUG_VM it's
+	 * enabled already.
+	 */
+	if (!IS_ENABLED(CONFIG_DEBUG_VM) && want_check_pages)
+		static_branch_enable(&check_pages_enabled);
+}
+
 /* Report memory auto-initialization states for this boot. */
 static void __init report_meminit(void)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1276bfe7a30..2f333c26170c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -240,31 +240,6 @@ EXPORT_SYMBOL(init_on_alloc);
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 EXPORT_SYMBOL(init_on_free);
 
-/* perform sanity checks on struct pages being allocated or freed */
-static DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
-
-static inline bool is_check_pages_enabled(void)
-{
-	return static_branch_unlikely(&check_pages_enabled);
-}
-
-static bool _init_on_alloc_enabled_early __read_mostly
-				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
-static int __init early_init_on_alloc(char *buf)
-{
-
-	return kstrtobool(buf, &_init_on_alloc_enabled_early);
-}
-early_param("init_on_alloc", early_init_on_alloc);
-
-static bool _init_on_free_enabled_early __read_mostly
-				= IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON);
-static int __init early_init_on_free(char *buf)
-{
-	return kstrtobool(buf, &_init_on_free_enabled_early);
-}
-early_param("init_on_free", early_init_on_free);
-
 /*
  * A cached value of the page's pageblock's migratetype, used when the page is
  * put on a pcplist. Used to avoid the pageblock migratetype lookup when
@@ -798,76 +773,6 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
 				unsigned int order, int migratetype) {}
 #endif
 
-/*
- * Enable static keys related to various memory debugging and hardening options.
- * Some override others, and depend on early params that are evaluated in the
- * order of appearance. So we need to first gather the full picture of what was
- * enabled, and then make decisions.
- */
-void __init init_mem_debugging_and_hardening(void)
-{
-	bool page_poisoning_requested = false;
-	bool want_check_pages = false;
-
-#ifdef CONFIG_PAGE_POISONING
-	/*
-	 * Page poisoning is debug page alloc for some arches. If
-	 * either of those options are enabled, enable poisoning.
-	 */
-	if (page_poisoning_enabled() ||
-	     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
-	      debug_pagealloc_enabled())) {
-		static_branch_enable(&_page_poisoning_enabled);
-		page_poisoning_requested = true;
-		want_check_pages = true;
-	}
-#endif
-
-	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
-	    page_poisoning_requested) {
-		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
-			"will take precedence over init_on_alloc and init_on_free\n");
-		_init_on_alloc_enabled_early = false;
-		_init_on_free_enabled_early = false;
-	}
-
-	if (_init_on_alloc_enabled_early) {
-		want_check_pages = true;
-		static_branch_enable(&init_on_alloc);
-	} else {
-		static_branch_disable(&init_on_alloc);
-	}
-
-	if (_init_on_free_enabled_early) {
-		want_check_pages = true;
-		static_branch_enable(&init_on_free);
-	} else {
-		static_branch_disable(&init_on_free);
-	}
-
-	if (IS_ENABLED(CONFIG_KMSAN) &&
-	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early))
-		pr_info("mem auto-init: please make sure init_on_alloc and init_on_free are disabled when running KMSAN\n");
-
-#ifdef CONFIG_DEBUG_PAGEALLOC
-	if (debug_pagealloc_enabled()) {
-		want_check_pages = true;
-		static_branch_enable(&_debug_pagealloc_enabled);
-
-		if (debug_guardpage_minorder())
-			static_branch_enable(&_debug_guardpage_enabled);
-	}
-#endif
-
-	/*
-	 * Any page debugging or hardening option also enables sanity checking
-	 * of struct pages being allocated or freed. With CONFIG_DEBUG_VM it's
-	 * enabled already.
-	 */
-	if (!IS_ENABLED(CONFIG_DEBUG_VM) && want_check_pages)
-		static_branch_enable(&check_pages_enabled);
-}
-
 static inline void set_buddy_order(struct page *page, unsigned int order)
 {
 	set_page_private(page, order);
-- 
2.35.1

