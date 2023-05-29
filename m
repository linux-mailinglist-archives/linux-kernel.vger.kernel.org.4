Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD09F7143F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjE2GOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjE2GOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:14:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF1DB1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685340862; x=1716876862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Oxpi0PPziaQhMGSH3TrNy4IFICDc28ZfyvpBf2ejj4=;
  b=DlehFadix+4U+iWpL/fGaz7SLQ8p/smv5qoK/XfFKa6WPKzUKo4ZYRlF
   go98QSjc5Gt5s7PmqGZpaLv2+EiSntjVbIXIlrB7UYchNbq2tgZetQ2VJ
   St6zHzrnU8JyBItisGmohcSwjDj2Oi89j2iRzdaPN2gE0ItATH3LYP9p+
   s5ul0U7OVGd9ffArcwvwCyI8hzl8xE72sqvXYsf+NCTFLBxXXmVkzj9+J
   IokpS/30mPMXuSUS1tghh/MUuXRT/Nritu1yiZvdSUlbYh4B/6ZI0SHgp
   KHJF9UlDihAEIBLX98vENdrLrix9KR7G9yqHHiJ7YPMKH+3IwLMbEQqsL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="357881814"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="357881814"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="1036079991"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="1036079991"
Received: from azhao3-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.126])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:14:18 -0700
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
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Chris Li <chrisl@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH -V3 2/5] swap, __read_swap_cache_async(): enlarge get/put_swap_device protection range
Date:   Mon, 29 May 2023 14:13:52 +0800
Message-Id: <20230529061355.125791-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529061355.125791-1-ying.huang@intel.com>
References: <20230529061355.125791-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Cc: Chris Li <chrisl@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
---
 mm/swap_state.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index b76a65ac28b3..a8450b4a110c 100644
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
@@ -446,7 +448,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * else swap_off will be aborted if we return NULL.
 		 */
 		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
-			return NULL;
+			goto fail_put_swap;
 
 		/*
 		 * Get a new page to read into from swap.  Allocate it now,
@@ -455,7 +457,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 */
 		folio = vma_alloc_folio(gfp_mask, 0, vma, addr, false);
 		if (!folio)
-			return NULL;
+                        goto fail_put_swap;
 
 		/*
 		 * Swap entry may have been freed since our caller observed it.
@@ -466,7 +468,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 
 		folio_put(folio);
 		if (err != -EEXIST)
-			return NULL;
+			goto fail_put_swap;
 
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
+fail_put_swap:
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

