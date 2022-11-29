Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DFF63C377
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiK2PSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiK2PSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:18:08 -0500
Received: from outbound-smtp26.blacknight.com (outbound-smtp26.blacknight.com [81.17.249.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DBDE05
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:18:07 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id CDDB4CAC8E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 15:18:05 +0000 (GMT)
Received: (qmail 5862 invoked from network); 29 Nov 2022 15:18:05 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 29 Nov 2022 15:18:05 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 5/6] mm/page_alloc: Give GFP_ATOMIC and non-blocking allocations access to reserves
Date:   Tue, 29 Nov 2022 15:17:00 +0000
Message-Id: <20221129151701.23261-6-mgorman@techsingularity.net>
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

Explicit GFP_ATOMIC allocations get flagged ALLOC_HARDER which is a bit
vague. In preparation for removing __GFP_ATOMIC, give GFP_ATOMIC and
other non-blocking allocation requests equal access to reserve.  Rename
ALLOC_HARDER to ALLOC_NON_BLOCK to make it more clear what the flag
means.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/internal.h   |  7 +++++--
 mm/page_alloc.c | 23 +++++++++++++----------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 370500718732..98b1e526559d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -743,7 +743,10 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_OOM		ALLOC_NO_WATERMARKS
 #endif
 
-#define ALLOC_HARDER		 0x10 /* try to alloc harder */
+#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. Allow access
+				       * to 25% of the min watermark or
+				       * 62.5% if __GFP_HIGH is set.
+				       */
 #define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
 				       * of the min watermark.
 				       */
@@ -758,7 +761,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
 /* Flags that allow allocations below the min watermark. */
-#define ALLOC_RESERVES (ALLOC_HARDER|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
+#define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
 
 enum ttu_flags;
 struct tlbflush_unmap_batch;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 85a87d0ac57a..6bee987ec9a3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3994,7 +3994,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 		 * if it cannot get memory quickly, particularly if it's
 		 * also __GFP_HIGH.
 		 */
-		if (alloc_flags & (ALLOC_HARDER|ALLOC_HIGHATOMIC))
+		if (alloc_flags & (ALLOC_NON_BLOCK|ALLOC_HIGHATOMIC))
 			min -= min / 4;
 
 		/*
@@ -4846,28 +4846,30 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 	 * The caller may dip into page reserves a bit more if the caller
 	 * cannot run direct reclaim, or if the caller has realtime scheduling
 	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
-	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_MIN_RESERVE(__GFP_HIGH).
+	 * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
 	 */
 	alloc_flags |= (__force int)
 		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
 
-	if (gfp_mask & __GFP_ATOMIC) {
+	if (!(gfp_mask & __GFP_RECLAIM)) {
 		/*
 		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
 		 * if it can't schedule.
 		 */
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
-			alloc_flags |= ALLOC_HARDER;
+			alloc_flags |= ALLOC_NON_BLOCK;
 
 			if (order > 0)
 				alloc_flags |= ALLOC_HIGHATOMIC;
 		}
 
 		/*
-		 * Ignore cpuset mems for GFP_ATOMIC rather than fail, see the
-		 * comment for __cpuset_node_allowed().
+		 * Ignore cpuset mems for non-blocking __GFP_HIGH (probably
+		 * GFP_ATOMIC) rather than fail, see the comment for
+		 * __cpuset_node_allowed().
 		 */
-		alloc_flags &= ~ALLOC_CPUSET;
+		if (alloc_flags & ALLOC_MIN_RESERVE)
+			alloc_flags &= ~ALLOC_CPUSET;
 	} else if (unlikely(rt_task(current)) && in_task())
 		alloc_flags |= ALLOC_MIN_RESERVE;
 
@@ -5299,11 +5301,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 		/*
 		 * Help non-failing allocations by giving them access to memory
-		 * reserves but do not use ALLOC_NO_WATERMARKS because this
+		 * reserves normally used for high priority non-blocking
+		 * allocations but do not use ALLOC_NO_WATERMARKS because this
 		 * could deplete whole memory reserves which would just make
-		 * the situation worse
+		 * the situation worse.
 		 */
-		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE|ALLOC_HARDER, ac);
+		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE|ALLOC_NON_BLOCK, ac);
 		if (page)
 			goto got_pg;
 
-- 
2.35.3

