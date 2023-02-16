Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B0A699084
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjBPJxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBPJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:53:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9F137577;
        Thu, 16 Feb 2023 01:53:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 50AED2035C;
        Thu, 16 Feb 2023 09:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676541213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RxHW2WWUGp1yNDTBMPzHvEZBuQ5roo80DeS3wMBao2c=;
        b=fIpukfaMMsgb90WuH1FwV6H6oY0JeOot/iAlPx9+JgaOV/cPl2K/+CkFsxc1Lad9dNc1Y+
        ZYSy1bwuHLcez/+RmUUauPVWHTZYIvez9zFybGfKcBoFq8H+PPIsV2NbHmyNxftKtWEwNJ
        7/XIXudkAm7dXv0AOEnAroIKC3pSV9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676541213;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RxHW2WWUGp1yNDTBMPzHvEZBuQ5roo80DeS3wMBao2c=;
        b=bZ17fkkOlWGP4Nym//DRwm/BKHLdSdZ5BWqTWJBxCMd03T25gG5fxogL7jn/h9YgQrJKtg
        nQYLyu5wv8xpqTAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31396139B5;
        Thu, 16 Feb 2023 09:53:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SjZ9Cx397WMlNAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Feb 2023 09:53:33 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Mel Gorman <mgorman@techsingularity.net>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Alexander Halbuer <halbuer@sra.uni-hannover.de>
Subject: [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
Date:   Thu, 16 Feb 2023 10:51:31 +0100
Message-Id: <20230216095131.17336-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically, we have performed sanity checks on all struct pages being
allocated or freed, making sure they have no unexpected page flags or
certain field values. This can detect insufficient cleanup and some
cases of use-after-free, although on its own it can't always identify
the culprit. The result is a warning and the "bad page" being leaked.

The checks do need some cpu cycles, so in 4.7 with commits 479f854a207c
("mm, page_alloc: defer debugging checks of pages allocated from the
PCP") and 4db7548ccbd9 ("mm, page_alloc: defer debugging checks of freed
pages until a PCP drain") they were no longer performed in the hot paths
when allocating and freeing from pcplists, but only when pcplists are
bypassed, refilled or drained. For debugging purposes, with
CONFIG_DEBUG_VM enabled the checks were instead still done in the
hot paths and not when refilling or draining pcplists.

With 4462b32c9285 ("mm, page_alloc: more extensive free page checking
with debug_pagealloc"), enabling debug_pagealloc also moved the sanity
checks back to hot pahs. When both debug_pagealloc and CONFIG_DEBUG_VM
are enabled, the checks are done both in hotpaths and pcplist
refill/drain.

Even though the non-debug default today might seem to be a sensible
tradeoff between overhead and ability to detect bad pages, on closer
look it's arguably not. As most allocations go through the pcplists,
catching any bad pages when refilling or draining pcplists has only a
small chance, insufficient for debugging or serious hardening purposes.
On the other hand the cost of the checks is concentrated in the already
expensive drain/refill batching operations, and those are done under the
often contended zone lock. That was recently identified as an issue for
page allocation and the zone lock contention reduced by moving the
checks outside of the locked section with a patch "mm: reduce lock
contention of pcp buffer refill", but the cost of the checks is still
visible compared to their removal [1]. In the pcplist draining path
free_pcppages_bulk() the checks are still done under zone->lock.

Thus, remove the checks from pcplist refill and drain paths completely.
Introduce a static key check_pages_enabled to control checks during page
allocation a freeing (whether pcplist is used or bypassed). The static
key is enabled if either is true:
- kernel is built with CONFIG_DEBUG_VM=y (debugging)
- debug_pagealloc or page poisoning is boot-time enabled (debugging)
- init_on_alloc or init_on_free is boot-time enabled (hardening)

The resulting user visible changes:
- no checks when draining/refilling pcplists - less overhead, with
  likely no practical reduction of ability to catch bad pages
- no checks when bypassing pcplists in default config (no
  debugging/hardening) - less overhead etc. as above
- on typical hardened kernels [2], checks are now performed on each page
  allocation/free (previously only when bypassing/draining/refilling
  pcplists) - the init_on_alloc/init_on_free enabled should be sufficient
  indication for preferring more costly alloc/free operations for
  hardening purposes and we shouldn't need to introduce another toggle
- code (various wrappers) removal and simplification

[1] https://lore.kernel.org/all/68ba44d8-6899-c018-dcb3-36f3a96e6bea@sra.uni-hannover.de/
[2] https://lore.kernel.org/all/63ebc499.a70a0220.9ac51.29ea@mx.google.com/

Reported-by: Alexander Halbuer <halbuer@sra.uni-hannover.de>
Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 188 ++++++++++++++----------------------------------
 1 file changed, 53 insertions(+), 135 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 713643fd132b..0113df51cd9c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -253,6 +253,9 @@ EXPORT_SYMBOL(init_on_alloc);
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 EXPORT_SYMBOL(init_on_free);
 
+/* perform sanity checks on struct pages being allocated or freed */
+DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
+
 static bool _init_on_alloc_enabled_early __read_mostly
 				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
 static int __init early_init_on_alloc(char *buf)
@@ -893,6 +896,7 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
 void __init init_mem_debugging_and_hardening(void)
 {
 	bool page_poisoning_requested = false;
+	bool want_check_pages = false;
 
 #ifdef CONFIG_PAGE_POISONING
 	/*
@@ -904,6 +908,7 @@ void __init init_mem_debugging_and_hardening(void)
 	      debug_pagealloc_enabled())) {
 		static_branch_enable(&_page_poisoning_enabled);
 		page_poisoning_requested = true;
+		want_check_pages = true;
 	}
 #endif
 
@@ -915,31 +920,42 @@ void __init init_mem_debugging_and_hardening(void)
 		_init_on_free_enabled_early = false;
 	}
 
-	if (_init_on_alloc_enabled_early)
+	if (_init_on_alloc_enabled_early) {
+		want_check_pages = true;
 		static_branch_enable(&init_on_alloc);
-	else
+	} else {
 		static_branch_disable(&init_on_alloc);
+	}
 
-	if (_init_on_free_enabled_early)
+	if (_init_on_free_enabled_early) {
+		want_check_pages = true;
 		static_branch_enable(&init_on_free);
-	else
+	} else {
 		static_branch_disable(&init_on_free);
+	}
 
 	if (IS_ENABLED(CONFIG_KMSAN) &&
 	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early))
 		pr_info("mem auto-init: please make sure init_on_alloc and init_on_free are disabled when running KMSAN\n");
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-	if (!debug_pagealloc_enabled())
-		return;
-
-	static_branch_enable(&_debug_pagealloc_enabled);
-
-	if (!debug_guardpage_minorder())
-		return;
+	if (debug_pagealloc_enabled()) {
+		want_check_pages = true;
+		static_branch_enable(&_debug_pagealloc_enabled);
 
-	static_branch_enable(&_debug_guardpage_enabled);
+		if (debug_guardpage_minorder())
+			static_branch_enable(&_debug_guardpage_enabled);
+	}
 #endif
+
+	/*
+	 * Any page debugging or hardening option also enables sanity checking
+	 * of struct pages being allocated or freed. With CONFIG_DEBUG_VM it's
+	 * enabled already.
+	 */
+	if (!IS_ENABLED(CONFIG_DEBUG_VM) && want_check_pages) {
+		static_branch_enable(&check_pages_enabled);
+	}
 }
 
 static inline void set_buddy_order(struct page *page, unsigned int order)
@@ -1395,7 +1411,7 @@ static void kernel_init_pages(struct page *page, int numpages)
 }
 
 static __always_inline bool free_pages_prepare(struct page *page,
-			unsigned int order, bool check_free, fpi_t fpi_flags)
+			unsigned int order, fpi_t fpi_flags)
 {
 	int bad = 0;
 	bool init = want_init_on_free();
@@ -1432,9 +1448,11 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		for (i = 1; i < (1 << order); i++) {
 			if (compound)
 				bad += free_tail_pages_check(page, page + i);
-			if (unlikely(free_page_is_bad(page + i))) {
-				bad++;
-				continue;
+			if (static_branch_unlikely(&check_pages_enabled)) {
+				if (unlikely(free_page_is_bad(page + i))) {
+					bad++;
+					continue;
+				}
 			}
 			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 		}
@@ -1443,10 +1461,12 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		page->mapping = NULL;
 	if (memcg_kmem_online() && PageMemcgKmem(page))
 		__memcg_kmem_uncharge_page(page, order);
-	if (check_free && free_page_is_bad(page))
-		bad++;
-	if (bad)
-		return false;
+	if (static_branch_unlikely(&check_pages_enabled)) {
+		if (free_page_is_bad(page))
+			bad++;
+		if (bad)
+			return false;
+	}
 
 	page_cpupid_reset_last(page);
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
@@ -1492,46 +1512,6 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	return true;
 }
 
-#ifdef CONFIG_DEBUG_VM
-/*
- * With DEBUG_VM enabled, order-0 pages are checked immediately when being freed
- * to pcp lists. With debug_pagealloc also enabled, they are also rechecked when
- * moved from pcp lists to free lists.
- */
-static bool free_pcp_prepare(struct page *page, unsigned int order)
-{
-	return free_pages_prepare(page, order, true, FPI_NONE);
-}
-
-/* return true if this page has an inappropriate state */
-static bool bulkfree_pcp_prepare(struct page *page)
-{
-	if (debug_pagealloc_enabled_static())
-		return free_page_is_bad(page);
-	else
-		return false;
-}
-#else
-/*
- * With DEBUG_VM disabled, order-0 pages being freed are checked only when
- * moving from pcp lists to free list in order to reduce overhead. With
- * debug_pagealloc enabled, they are checked also immediately when being freed
- * to the pcp lists.
- */
-static bool free_pcp_prepare(struct page *page, unsigned int order)
-{
-	if (debug_pagealloc_enabled_static())
-		return free_pages_prepare(page, order, true, FPI_NONE);
-	else
-		return free_pages_prepare(page, order, false, FPI_NONE);
-}
-
-static bool bulkfree_pcp_prepare(struct page *page)
-{
-	return free_page_is_bad(page);
-}
-#endif /* CONFIG_DEBUG_VM */
-
 /*
  * Frees a number of pages from the PCP lists
  * Assumes all pages on list are in same zone.
@@ -1591,9 +1571,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
-			if (bulkfree_pcp_prepare(page))
-				continue;
-
 			/* MIGRATE_ISOLATE page should not go to pcplists */
 			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
 			/* Pageblock could have been isolated meanwhile */
@@ -1706,7 +1683,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (!free_pages_prepare(page, order, true, fpi_flags))
+	if (!free_pages_prepare(page, order, fpi_flags))
 		return;
 
 	/*
@@ -2382,7 +2359,7 @@ static void check_new_page_bad(struct page *page)
 /*
  * This page is about to be returned from the page allocator
  */
-static inline int check_new_page(struct page *page)
+static int check_new_page(struct page *page)
 {
 	if (likely(page_expected_state(page,
 				PAGE_FLAGS_CHECK_AT_PREP|__PG_HWPOISON)))
@@ -2392,56 +2369,20 @@ static inline int check_new_page(struct page *page)
 	return 1;
 }
 
-static bool check_new_pages(struct page *page, unsigned int order)
+static inline bool check_new_pages(struct page *page, unsigned int order)
 {
-	int i;
-	for (i = 0; i < (1 << order); i++) {
-		struct page *p = page + i;
+	if (static_branch_unlikely(&check_pages_enabled)) {
+		for (int i = 0; i < (1 << order); i++) {
+			struct page *p = page + i;
 
-		if (unlikely(check_new_page(p)))
-			return true;
+			if (unlikely(check_new_page(p)))
+				return true;
+		}
 	}
 
 	return false;
 }
 
-#ifdef CONFIG_DEBUG_VM
-/*
- * With DEBUG_VM enabled, order-0 pages are checked for expected state when
- * being allocated from pcp lists. With debug_pagealloc also enabled, they are
- * also checked when pcp lists are refilled from the free lists.
- */
-static inline bool check_pcp_refill(struct page *page, unsigned int order)
-{
-	if (debug_pagealloc_enabled_static())
-		return check_new_pages(page, order);
-	else
-		return false;
-}
-
-static inline bool check_new_pcp(struct page *page, unsigned int order)
-{
-	return check_new_pages(page, order);
-}
-#else
-/*
- * With DEBUG_VM disabled, free order-0 pages are checked for expected state
- * when pcp lists are being refilled from the free lists. With debug_pagealloc
- * enabled, they are also checked when being allocated from the pcp lists.
- */
-static inline bool check_pcp_refill(struct page *page, unsigned int order)
-{
-	return check_new_pages(page, order);
-}
-static inline bool check_new_pcp(struct page *page, unsigned int order)
-{
-	if (debug_pagealloc_enabled_static())
-		return check_new_pages(page, order);
-	else
-		return false;
-}
-#endif /* CONFIG_DEBUG_VM */
-
 static inline bool should_skip_kasan_unpoison(gfp_t flags)
 {
 	/* Don't skip if a software KASAN mode is enabled. */
@@ -3136,9 +3077,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			int migratetype, unsigned int alloc_flags)
 {
 	unsigned long flags;
-	int i, allocated = 0;
-	struct list_head *prev_tail = list->prev;
-	struct page *pos, *n;
+	int i;
 
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
@@ -3163,31 +3102,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 					      -(1 << order));
 	}
 
-	/*
-	 * i pages were removed from the buddy list even if some leak due
-	 * to check_pcp_refill failing so adjust NR_FREE_PAGES based
-	 * on i. Do not confuse with 'allocated' which is the number of
-	 * pages added to the pcp list.
-	 */
 	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
 	spin_unlock_irqrestore(&zone->lock, flags);
 
-	/*
-	 * Pages are appended to the pcp list without checking to reduce the
-	 * time holding the zone lock. Checking the appended pages happens right
-	 * after the critical section while still holding the pcp lock.
-	 */
-	pos = list_first_entry(prev_tail, struct page, pcp_list);
-	list_for_each_entry_safe_from(pos, n, list, pcp_list) {
-		if (unlikely(check_pcp_refill(pos, order))) {
-			list_del(&pos->pcp_list);
-			continue;
-		}
-
-		allocated++;
-	}
-
-	return allocated;
+	return i;
 }
 
 #ifdef CONFIG_NUMA
@@ -3398,7 +3316,7 @@ static bool free_unref_page_prepare(struct page *page, unsigned long pfn,
 {
 	int migratetype;
 
-	if (!free_pcp_prepare(page, order))
+	if (!free_pages_prepare(page, order, FPI_NONE))
 		return false;
 
 	migratetype = get_pfnblock_migratetype(page, pfn);
@@ -3804,7 +3722,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		page = list_first_entry(list, struct page, pcp_list);
 		list_del(&page->pcp_list);
 		pcp->count -= 1 << order;
-	} while (check_new_pcp(page, order));
+	} while (check_new_pages(page, order));
 
 	return page;
 }
-- 
2.39.1

