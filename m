Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570B670B5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjEVHKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjEVHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:09:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAAB137
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684739376; x=1716275376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i1WT96efAZrjTV7W7kwHNRkRI/omQzn1KtV16Slt7b8=;
  b=Y1H0lgri+4aHfmT4yJe3hn3E1+4D02IKt9f+sS0xc0xDVusyfPNxjQs1
   81IfaqhXQaIRVNuNhYqfIYSgtrat/Y57SN3ut+BO9dLwI0V6YNCiljikB
   p7bceeAbo26jBbK8r9WMk96dqdxqcYYRRubhdgspM9wNiBZ2tG2L659hY
   nvZLOwKGvhOIzcifTWccBMITw6AXOYx7+zYZjya2AI6CXwi9EqjCZFJEF
   uZblpGnvUKLYeZbVXWPMvXAuBJnXtKV7aMA+JFw907BKxLJMSS00Sc6R5
   DxtjkqPsV3/uv0dwTtqTJVX/wNI6B6p2TvqrvxWXdiyuJqkI5W9JK1sA1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="337436989"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="337436989"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="773212692"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="773212692"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.5.152])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:09:25 -0700
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
Subject: [PATCH -V2 2/5] swap, __read_swap_cache_async(): enlarge get/put_swap_device protection range
Date:   Mon, 22 May 2023 15:09:02 +0800
Message-Id: <20230522070905.16773-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522070905.16773-1-ying.huang@intel.com>
References: <20230522070905.16773-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the function a little easier to be understood because we
don't need to consider swapoff.  And this makes it possible to remove
get/put_swap_device() calling in some functions called by
__read_swap_cache_async().

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
 mm/swap_state.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

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
-- 
2.39.2

