Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17657143F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjE2GOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjE2GO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:14:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B3BB
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685340865; x=1716876865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tTttI7ks79EVJT0Lkkg7CgRwuqqX+cQLYrih/1r1FtU=;
  b=ZS60TbM6qYbN/Q3CVL42COpkGiFTtmto2DACxT0SSW21D9JEoDmHh7Cx
   ZHNrykD1KPtmB0FZc+9nL+MNg3sr9yZ3ZCxkFizkchdiDHy6wAg568PPg
   XdwLE+2T3omXzYVzcqxW3BWshiZe4UK+gVgGmqGt/iAyiJYf6BLlNOUiM
   IudLGi0St3ihKDDHY2Qmrumqs3J+AQT3tYjF3uFCdDy/hXYXvHoHBWylP
   qh5kQGpLN7oEMgdY6c+beM648+nu+q5ZgfwYH0V5chQtSr0Qgk4HYEQYb
   Pz12B7hf4p20YEDh+YPy0bgQsTSDsPEAqMUvCequ6LAOSsA+m8Q5rlCKx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="357881834"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="357881834"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:14:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="1036079999"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="1036079999"
Received: from azhao3-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.126])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 23:14:22 -0700
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
Subject: [PATCH -V3 3/5] swap: remove __swp_swapcount()
Date:   Mon, 29 May 2023 14:13:53 +0800
Message-Id: <20230529061355.125791-4-ying.huang@intel.com>
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

__swp_swapcount() just encloses the calling to swap_swapcount() with
get/put_swap_device().  It is called in __read_swap_cache_async()
only, which encloses the calling with get/put_swap_device() already.
So, __read_swap_cache_async() can call swap_swapcount() directly.

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
 include/linux/swap.h |  4 ++--
 mm/swap_state.c      |  2 +-
 mm/swapfile.c        | 20 +-------------------
 3 files changed, 4 insertions(+), 22 deletions(-)

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
index a8450b4a110c..ef32353c18a6 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -447,7 +447,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * as SWAP_HAS_CACHE.  That's done in later part of code or
 		 * else swap_off will be aborted if we return NULL.
 		 */
-		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
+		if (!swap_swapcount(si, entry) && swap_slot_cache_enabled)
 			goto fail_put_swap;
 
 		/*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8419cba9c192..e9cce775fb25 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1443,7 +1443,7 @@ int __swap_count(swp_entry_t entry)
  * This does not give an exact answer when swap count is continued,
  * but does include the high COUNT_CONTINUED flag to allow for that.
  */
-static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
+int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
 {
 	pgoff_t offset = swp_offset(entry);
 	struct swap_cluster_info *ci;
@@ -1455,24 +1455,6 @@ static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
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
-- 
2.39.2

