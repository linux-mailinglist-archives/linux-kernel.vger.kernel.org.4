Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C72B63C36E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiK2PSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiK2PRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:17:53 -0500
Received: from outbound-smtp03.blacknight.com (outbound-smtp03.blacknight.com [81.17.249.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5171F629
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:17:46 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id BECE4C0C21
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 15:17:44 +0000 (GMT)
Received: (qmail 4822 invoked from network); 29 Nov 2022 15:17:44 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 29 Nov 2022 15:17:44 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/6] mm/page_alloc: Explicitly record high-order atomic allocations in alloc_flags
Date:   Tue, 29 Nov 2022 15:16:58 +0000
Message-Id: <20221129151701.23261-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221129151701.23261-1-mgorman@techsingularity.net>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A high-order ALLOC_HARDER allocation is assumed to be atomic. While that
is accurate, it changes later in the series. In preparation, explicitly
record high-order atomic allocations in gfp_to_alloc_flags().

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/internal.h   |  1 +
 mm/page_alloc.c | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index d503e57a57a1..9a9d9b5ee87f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -754,6 +754,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #else
 #define ALLOC_NOFRAGMENT	  0x0
 #endif
+#define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
 enum ttu_flags;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index da746e9eb2cf..e2b65767dda0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3710,7 +3710,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 		 * reserved for high-order atomic allocation, so order-0
 		 * request should skip it.
 		 */
-		if (order > 0 && alloc_flags & ALLOC_HARDER)
+		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
@@ -4028,8 +4028,10 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			return true;
 		}
 #endif
-		if (alloc_harder && !free_area_empty(area, MIGRATE_HIGHATOMIC))
+		if ((alloc_flags & ALLOC_HIGHATOMIC) &&
+		    !free_area_empty(area, MIGRATE_HIGHATOMIC)) {
 			return true;
+		}
 	}
 	return false;
 }
@@ -4291,7 +4293,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(order && (alloc_flags & ALLOC_HARDER)))
+			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
 				reserve_highatomic_pageblock(page, zone, order);
 
 			return page;
@@ -4818,7 +4820,7 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 }
 
 static inline unsigned int
-gfp_to_alloc_flags(gfp_t gfp_mask)
+gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 {
 	unsigned int alloc_flags = ALLOC_WMARK_MIN | ALLOC_CPUSET;
 
@@ -4844,8 +4846,13 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
 		 * if it can't schedule.
 		 */
-		if (!(gfp_mask & __GFP_NOMEMALLOC))
+		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
 			alloc_flags |= ALLOC_HARDER;
+
+			if (order > 0)
+				alloc_flags |= ALLOC_HIGHATOMIC;
+		}
+
 		/*
 		 * Ignore cpuset mems for GFP_ATOMIC rather than fail, see the
 		 * comment for __cpuset_node_allowed().
@@ -5053,7 +5060,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * kswapd needs to be woken up, and to avoid the cost of setting up
 	 * alloc_flags precisely. So we do that now.
 	 */
-	alloc_flags = gfp_to_alloc_flags(gfp_mask);
+	alloc_flags = gfp_to_alloc_flags(gfp_mask, order);
 
 	/*
 	 * We need to recalculate the starting point for the zonelist iterator
-- 
2.35.3

