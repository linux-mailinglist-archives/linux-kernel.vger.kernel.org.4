Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A8970B5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjEVHKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjEVHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:09:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD844184
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684739376; x=1716275376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gm3LH1lmJVZ4Ay531OQCa0nV/AljYlwBGJj9BjRnG/w=;
  b=HwYCYQzTelpqkmc7BUCMu4WvJkRkoqcP1nwSIR+rgfVE4eDYtf03t8W6
   NA2CkomX1YYMisL4Y2PQuN2gbXE/pyIjjUpEVtxLcPA9VQIM6oIi+v++X
   /pIrh5v3n86H2tlmnBrkMvLV1aYjV0EdCDVDzNWviqviAygd1wV2hhJmr
   VY3y7msFGgFBP+ni0cPklIDomEoJ9gIxcsqafieZ3x6RLiv90lT52UpIc
   IwsBR6h3GdIIJup6DRvbCZ/MXyXnAeebNB/tqC21V3vRqV55Nv9gGBo/n
   DzJNRoPDT4VieYsyBuFmNNiwkPsSyEosYR8n11BL8AuS1qPSAvro8iCJt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="337437017"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="337437017"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="773212698"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="773212698"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.5.152])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:09:28 -0700
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
Subject: [PATCH -V2 3/5] swap: remove __swp_swapcount()
Date:   Mon, 22 May 2023 15:09:03 +0800
Message-Id: <20230522070905.16773-4-ying.huang@intel.com>
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
---
 include/linux/swap.h |  4 ++--
 mm/swapfile.c        | 20 +-------------------
 2 files changed, 3 insertions(+), 21 deletions(-)

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

