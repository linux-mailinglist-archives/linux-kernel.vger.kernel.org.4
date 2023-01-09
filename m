Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31976629BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbjAIPS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbjAIPRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:17:47 -0500
Received: from outbound-smtp24.blacknight.com (outbound-smtp24.blacknight.com [81.17.249.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CD238AE4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:16:55 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id 7D6D2C0D26
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:16:54 +0000 (GMT)
Received: (qmail 16592 invoked from network); 9 Jan 2023 15:16:54 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 9 Jan 2023 15:16:54 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/7] mm/page_alloc: Rename ALLOC_HIGH to ALLOC_MIN_RESERVE
Date:   Mon,  9 Jan 2023 15:16:25 +0000
Message-Id: <20230109151631.24923-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230109151631.24923-1-mgorman@techsingularity.net>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__GFP_HIGH aliases to ALLOC_HIGH but the name does not really hint
what it means. As ALLOC_HIGH is internal to the allocator, rename
it to ALLOC_MIN_RESERVE to document that the min reserves can
be depleted.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/internal.h   | 4 +++-
 mm/page_alloc.c | 8 ++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index bcf75a8b032d..403e4386626d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -736,7 +736,9 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #endif
 
 #define ALLOC_HARDER		 0x10 /* try to alloc harder */
-#define ALLOC_HIGH		 0x20 /* __GFP_HIGH set */
+#define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
+				       * of the min watermark.
+				       */
 #define ALLOC_CPUSET		 0x40 /* check for correct cpuset */
 #define ALLOC_CMA		 0x80 /* allow allocations from CMA areas */
 #ifdef CONFIG_ZONE_DMA32
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..244c1e675dc8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3976,7 +3976,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 	/* free_pages may go negative - that's OK */
 	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
 
-	if (alloc_flags & ALLOC_HIGH)
+	if (alloc_flags & ALLOC_MIN_RESERVE)
 		min -= min / 2;
 
 	if (unlikely(alloc_harder)) {
@@ -4818,18 +4818,18 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 	unsigned int alloc_flags = ALLOC_WMARK_MIN | ALLOC_CPUSET;
 
 	/*
-	 * __GFP_HIGH is assumed to be the same as ALLOC_HIGH
+	 * __GFP_HIGH is assumed to be the same as ALLOC_MIN_RESERVE
 	 * and __GFP_KSWAPD_RECLAIM is assumed to be the same as ALLOC_KSWAPD
 	 * to save two branches.
 	 */
-	BUILD_BUG_ON(__GFP_HIGH != (__force gfp_t) ALLOC_HIGH);
+	BUILD_BUG_ON(__GFP_HIGH != (__force gfp_t) ALLOC_MIN_RESERVE);
 	BUILD_BUG_ON(__GFP_KSWAPD_RECLAIM != (__force gfp_t) ALLOC_KSWAPD);
 
 	/*
 	 * The caller may dip into page reserves a bit more if the caller
 	 * cannot run direct reclaim, or if the caller has realtime scheduling
 	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
-	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_HIGH (__GFP_HIGH).
+	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_MIN_RESERVE(__GFP_HIGH).
 	 */
 	alloc_flags |= (__force int)
 		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
-- 
2.35.3

