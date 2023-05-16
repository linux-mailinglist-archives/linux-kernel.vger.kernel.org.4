Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66B27044B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 07:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjEPFcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 01:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjEPFcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 01:32:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA1635A6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 22:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684215137; x=1715751137;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VV9cOBZQtObVAsWGl0aQ/fA+/wUKQxhDDkpPyYOxuDY=;
  b=Fjmb9YtIFqMenUDLkSHGJE8Vo7C3+dnpRQBIqydacjBWdmeiXTGIh+39
   l9yxB2z+iAmgD4qabiJLKVvcWUJfpw/nkq7xRLcw7JmZxPzBQwBJIrnDS
   7PXnsz3TNV4qyhWgdf/FpMIAY5fpN0/cNJLpcY2mGDAx2zMg47J3nhp29
   +Eq2qB8MyfNfFwt9FkOJe5RxarYl88+7l27Geom1jJabWuW7ZPMlHuUYv
   gBmuMdiVaV5CKxKBFXrfExk2pAiRYD4SOviDOIQVJdZMhaQzd3KLYhSy8
   8BQqjaUV5W0NcbXH+MfG17Bq0XkLAjfBtHr9HZGKkA+2Yf24MsxO4rjif
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="348886043"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="348886043"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 22:32:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="825430750"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="825430750"
Received: from dzhan22-mobl2.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.30.63])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 22:32:10 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
Subject: [PATCH] swap: cleanup get/put_swap_device usage
Date:   Tue, 16 May 2023 13:29:57 +0800
Message-Id: <20230516052957.175432-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The general rule to use a swap entry is as follows.

When we get a swap entry, if there isn't some other way to prevent
swapoff, such as page lock for swap cache, page table lock, etc., the
swap entry may become invalid because of swapoff.  Then, we need to
enclose all swap related functions with get_swap_device() and
put_swap_device(), unless the swap functions call
get/put_swap_device() by themselves.

Add the rule as comments of get_swap_device(), and cleanup some
functions which call get/put_swap_device().

1. Enlarge the get/put_swap_device() protection range in
__read_swap_cache_async().  This makes the function a little easier to
be understood because we don't need to consider swapoff.  And this
makes it possible to remove get/put_swap_device() calling in some
function called by __read_swap_cache_async().

2. Remove get/put_swap_device() in __swap_count().  Which is call in
do_swap_page() only, which encloses the call with get/put_swap_device()
already.

3. Remove get/put_swap_device() in __swp_swapcount().  Which is call
in __read_swap_cache_async() only, which encloses the call with
get/put_swap_device() already.

4. Remove get/put_swap_device() in __swap_duplicate(). Which is called
by

- swap_shmem_alloc(): the swap cache is locked.

- copy_nonpresent_pte() -> swap_duplicate() and try_to_unmap_one() ->
swap_duplicate(): the page table lock is held.

- __read_swap_cache_async() -> swapcache_prepare(): enclosed with
get/put_swap_device() already.

Other get/put_swap_device() usages are checked too.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
---
 include/linux/swap.h |  4 ++--
 mm/swap_state.c      | 33 ++++++++++++++++++++-----------
 mm/swapfile.c        | 47 ++++++++++++--------------------------------
 3 files changed, 37 insertions(+), 47 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3c69cb653cb9..f6bd51aa05ea 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -512,7 +512,7 @@ int find_first_swap(dev_t *device);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t swapdev_block(int, pgoff_t);
 extern int __swap_count(swp_entry_t entry);
-extern int __swp_swapcount(swp_entry_t entry);
+extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry);
 extern int swp_swapcount(swp_entry_t entry);
 extern struct swap_info_struct *page_swap_info(struct page *);
 extern struct swap_info_struct *swp_swap_info(swp_entry_t entry);
@@ -590,7 +590,7 @@ static inline int __swap_count(swp_entry_t entry)
 	return 0;
 }
 
-static inline int __swp_swapcount(swp_entry_t entry)
+static inline int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
 {
 	return 0;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b76a65ac28b3..a1028fe7214e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -417,9 +417,13 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 {
 	struct swap_info_struct *si;
 	struct folio *folio;
+	struct page *page;
 	void *shadow = NULL;
 
 	*new_page_allocated = false;
+	si = get_swap_device(entry);
+	if (!si)
+		return NULL;
 
 	for (;;) {
 		int err;
@@ -428,14 +432,12 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * called after swap_cache_get_folio() failed, re-calling
 		 * that would confuse statistics.
 		 */
-		si = get_swap_device(entry);
-		if (!si)
-			return NULL;
 		folio = filemap_get_folio(swap_address_space(entry),
 						swp_offset(entry));
-		put_swap_device(si);
-		if (!IS_ERR(folio))
-			return folio_file_page(folio, swp_offset(entry));
+		if (!IS_ERR(folio)) {
+			page = folio_file_page(folio, swp_offset(entry));
+			goto got_page;
+		}
 
 		/*
 		 * Just skip read ahead for unused swap slot.
@@ -445,8 +447,8 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * as SWAP_HAS_CACHE.  That's done in later part of code or
 		 * else swap_off will be aborted if we return NULL.
 		 */
-		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
-			return NULL;
+		if (!swap_swapcount(si, entry) && swap_slot_cache_enabled)
+			goto fail;
 
 		/*
 		 * Get a new page to read into from swap.  Allocate it now,
@@ -455,7 +457,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 */
 		folio = vma_alloc_folio(gfp_mask, 0, vma, addr, false);
 		if (!folio)
-			return NULL;
+                        goto fail;
 
 		/*
 		 * Swap entry may have been freed since our caller observed it.
@@ -466,7 +468,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 
 		folio_put(folio);
 		if (err != -EEXIST)
-			return NULL;
+			goto fail;
 
 		/*
 		 * We might race against __delete_from_swap_cache(), and
@@ -500,12 +502,17 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	/* Caller will initiate read into locked folio */
 	folio_add_lru(folio);
 	*new_page_allocated = true;
-	return &folio->page;
+	page = &folio->page;
+got_page:
+	put_swap_device(si);
+	return page;
 
 fail_unlock:
 	put_swap_folio(folio, entry);
 	folio_unlock(folio);
 	folio_put(folio);
+fail:
+	put_swap_device(si);
 	return NULL;
 }
 
@@ -514,6 +521,10 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
  * and reading the disk if it is not already cached.
  * A failure return means that either the page allocation failed or that
  * the swap entry is no longer in use.
+ *
+ * get/put_swap_device() aren't needed to call this function, because
+ * __read_swap_cache_async() call them and swap_readpage() holds the
+ * swap cache folio lock.
  */
 struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				   struct vm_area_struct *vma,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 274bbf797480..0c1cb935b2eb 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1219,6 +1219,13 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
 }
 
 /*
+ * When we get a swap entry, if there isn't some other way to prevent
+ * swapoff, such as page lock for swap cache, page table lock, etc.,
+ * the swap entry may become invalid because of swapoff.  Then, we
+ * need to enclose all swap related functions with get_swap_device()
+ * and put_swap_device(), unless the swap functions call
+ * get/put_swap_device() by themselves.
+ *
  * Check whether swap entry is valid in the swap device.  If so,
  * return pointer to swap_info_struct, and keep the swap entry valid
  * via preventing the swap device from being swapoff, until
@@ -1227,9 +1234,8 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
  * Notice that swapoff or swapoff+swapon can still happen before the
  * percpu_ref_tryget_live() in get_swap_device() or after the
  * percpu_ref_put() in put_swap_device() if there isn't any other way
- * to prevent swapoff, such as page lock, page table lock, etc.  The
- * caller must be prepared for that.  For example, the following
- * situation is possible.
+ * to prevent swapoff.  The caller must be prepared for that.  For
+ * example, the following situation is possible.
  *
  *   CPU1				CPU2
  *   do_swap_page()
@@ -1432,16 +1438,10 @@ void swapcache_free_entries(swp_entry_t *entries, int n)
 
 int __swap_count(swp_entry_t entry)
 {
-	struct swap_info_struct *si;
+	struct swap_info_struct *si = swp_swap_info(entry);
 	pgoff_t offset = swp_offset(entry);
-	int count = 0;
 
-	si = get_swap_device(entry);
-	if (si) {
-		count = swap_count(si->swap_map[offset]);
-		put_swap_device(si);
-	}
-	return count;
+	return swap_count(si->swap_map[offset]);
 }
 
 /*
@@ -1449,7 +1449,7 @@ int __swap_count(swp_entry_t entry)
  * This does not give an exact answer when swap count is continued,
  * but does include the high COUNT_CONTINUED flag to allow for that.
  */
-static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
+int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
 {
 	pgoff_t offset = swp_offset(entry);
 	struct swap_cluster_info *ci;
@@ -1461,24 +1461,6 @@ static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
 	return count;
 }
 
-/*
- * How many references to @entry are currently swapped out?
- * This does not give an exact answer when swap count is continued,
- * but does include the high COUNT_CONTINUED flag to allow for that.
- */
-int __swp_swapcount(swp_entry_t entry)
-{
-	int count = 0;
-	struct swap_info_struct *si;
-
-	si = get_swap_device(entry);
-	if (si) {
-		count = swap_swapcount(si, entry);
-		put_swap_device(si);
-	}
-	return count;
-}
-
 /*
  * How many references to @entry are currently swapped out?
  * This considers COUNT_CONTINUED so it returns exact answer.
@@ -3288,9 +3270,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 	unsigned char has_cache;
 	int err;
 
-	p = get_swap_device(entry);
-	if (!p)
-		return -EINVAL;
+	p = swp_swap_info(entry);
 
 	offset = swp_offset(entry);
 	ci = lock_cluster_or_swap_info(p, offset);
@@ -3337,7 +3317,6 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 
 unlock_out:
 	unlock_cluster_or_swap_info(p, ci);
-	put_swap_device(p);
 	return err;
 }
 
-- 
2.39.2

