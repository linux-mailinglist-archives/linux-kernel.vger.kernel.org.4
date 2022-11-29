Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D43563C370
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiK2PSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbiK2PSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:18:04 -0500
Received: from outbound-smtp35.blacknight.com (outbound-smtp35.blacknight.com [46.22.139.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D0011C27
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:17:56 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 520BC1C60
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 15:17:55 +0000 (GMT)
Received: (qmail 5288 invoked from network); 29 Nov 2022 15:17:55 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 29 Nov 2022 15:17:55 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/6] mm/page_alloc: Explicitly define what alloc flags deplete min reserves
Date:   Tue, 29 Nov 2022 15:16:59 +0000
Message-Id: <20221129151701.23261-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221129151701.23261-1-mgorman@techsingularity.net>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there are more ALLOC_ flags that affect reserves, define what flags
affect reserves and clarify the effect of each flag.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/internal.h   |  3 +++
 mm/page_alloc.c | 36 +++++++++++++++++++++++-------------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9a9d9b5ee87f..370500718732 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -757,6 +757,9 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
+/* Flags that allow allocations below the min watermark. */
+#define ALLOC_RESERVES (ALLOC_HARDER|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
+
 enum ttu_flags;
 struct tlbflush_unmap_batch;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e2b65767dda0..85a87d0ac57a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3944,15 +3944,14 @@ ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
 static inline long __zone_watermark_unusable_free(struct zone *z,
 				unsigned int order, unsigned int alloc_flags)
 {
-	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
 	long unusable_free = (1 << order) - 1;
 
 	/*
-	 * If the caller does not have rights to ALLOC_HARDER then subtract
-	 * the high-atomic reserves. This will over-estimate the size of the
-	 * atomic reserve but it avoids a search.
+	 * If the caller does not have rights to reserves below the min
+	 * watermark then subtract the high-atomic reserves. This will
+	 * over-estimate the size of the atomic reserve but it avoids a search.
 	 */
-	if (likely(!alloc_harder))
+	if (likely(!(alloc_flags & ALLOC_RESERVES)))
 		unusable_free += z->nr_reserved_highatomic;
 
 #ifdef CONFIG_CMA
@@ -3976,25 +3975,36 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 {
 	long min = mark;
 	int o;
-	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
 
 	/* free_pages may go negative - that's OK */
 	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
 
-	if (alloc_flags & ALLOC_MIN_RESERVE)
-		min -= min / 2;
+	if (alloc_flags & ALLOC_RESERVES) {
+		/*
+		 * __GFP_HIGH allows access to 50% of the min reserve as well
+		 * as OOM.
+		 */
+		if (alloc_flags & ALLOC_MIN_RESERVE)
+			min -= min / 2;
 
-	if (unlikely(alloc_harder)) {
 		/*
-		 * OOM victims can try even harder than normal ALLOC_HARDER
+		 * Non-blocking allocations can access some of the reserve
+		 * with more access if also __GFP_HIGH. The reasoning is that
+		 * a non-blocking caller may incur a more severe penalty
+		 * if it cannot get memory quickly, particularly if it's
+		 * also __GFP_HIGH.
+		 */
+		if (alloc_flags & (ALLOC_HARDER|ALLOC_HIGHATOMIC))
+			min -= min / 4;
+
+		/*
+		 * OOM victims can try even harder than the normal reserve
 		 * users on the grounds that it's definitely going to be in
 		 * the exit path shortly and free memory. Any allocation it
 		 * makes during the free path will be small and short-lived.
 		 */
 		if (alloc_flags & ALLOC_OOM)
 			min -= min / 2;
-		else
-			min -= min / 4;
 	}
 
 	/*
@@ -5293,7 +5303,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		 * could deplete whole memory reserves which would just make
 		 * the situation worse
 		 */
-		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_HARDER, ac);
+		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE|ALLOC_HARDER, ac);
 		if (page)
 			goto got_pg;
 
-- 
2.35.3

