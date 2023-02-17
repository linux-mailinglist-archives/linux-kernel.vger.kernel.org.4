Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7302B69AAFD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBQMFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBQMFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:05:13 -0500
Received: from mailout1n.rrzn.uni-hannover.de (mailout1n.rrzn.uni-hannover.de [130.75.2.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D64644DA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:05:10 -0800 (PST)
Received: from beifus.sra.uni-hannover.de (lab.sra.uni-hannover.de [130.75.33.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailout1n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id D48F7533;
        Fri, 17 Feb 2023 13:05:09 +0100 (CET)
From:   Alexander Halbuer <halbuer@sra.uni-hannover.de>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Halbuer <halbuer@sra.uni-hannover.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm, page_alloc: batch cma update on pcp buffer refill
Date:   Fri, 17 Feb 2023 13:05:04 +0100
Message-Id: <20230217120504.87043-1-halbuer@sra.uni-hannover.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.7 at mailout1n
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As proposed by Vlastimil Babka [1] this is an extension to the previous patch
"mm: reduce lock contention of pcp buffer refill". This version also moves the
is_migrate_cma() check from the critical section to the loop below.

The optimization has several advantages:
- Less time in critical section
- Batching update of NR_FREE_CMA_PAGES into a single call to
  mod_zone_page_state()
- Utilizing cache locality of the related struct page when doing the cma check
  is_migrate_cma() and the sanity check check_pcp_refill() in the same loop

However, this change only affects performance with CONFIG_CMA=true which
may not be the common case. Another possibly negative effect is that the
actual update of NR_FREE_CMA_PAGES is delayed beyond the release of the
zone lock resulting in a short time span of inaccuracy between the
counter and the actual number of cma pages in the zone.

The tables below compare this patch with the initial one using a
parallel allocation benchmark. The used kernel config is based on the default
debian config but with CONFIG_INIT_ON_ALLOC_DEFAULT_ON=FALSE and
CONFIG_CMA=TRUE. The benchmarks have been performed with the default sanity
checks enabled as the patch "mm, page_alloc: reduce page alloc/free sanity
checks" [2] was not enabled on my test branch.
The given times are average allocation times. The improvement is not
significant, but the general trend is visible.

Hopefully, without sanity checks and disabled cma, a compiler will be able
to optimize away the second loop entirely.

[1] https://lore.kernel.org/lkml/1d468148-936f-8816-eb71-1662f2d4945b@suse.cz/
[2] https://lore.kernel.org/linux-mm/20230216095131.17336-1-vbabka@suse.cz/

Normal Pages
+-------+---------+---------+---------+
| Cores | Patch 1 | Patch 2 | Patch 2 |
|       |    (ns) |    (ns) |    Diff |
+-------+---------+---------+---------+
|     1 |     132 |     129 | (-2.3%) |
|     2 |     147 |     145 | (-1.4%) |
|     3 |     148 |     147 | (-0.7%) |
|     4 |     175 |     173 | (-1.1%) |
|     6 |     263 |     255 | (-3.0%) |
|     8 |     347 |     337 | (-2.9%) |
|    10 |     432 |     421 | (-2.5%) |
|    12 |     516 |     505 | (-2.1%) |
|    14 |     604 |     590 | (-2.3%) |
|    16 |     695 |     680 | (-2.2%) |
|    20 |     869 |     844 | (-2.9%) |
|    24 |    1043 |    1015 | (-2.7%) |
+-------+---------+---------+---------+

Huge Pages
+-------+---------+---------+---------+
| Cores | Patch 1 | Patch 2 | Patch 2 |
|       |    (ns) |    (ns) |    Diff |
+-------+---------+---------+---------+
|     1 |    3177 |    3133 | (-1.4%) |
|     2 |    3486 |    3471 | (-0.4%) |
|     3 |    3644 |    3634 | (-0.3%) |
|     4 |    3669 |    3643 | (-0.7%) |
|     6 |    3587 |    3578 | (-0.3%) |
|     8 |    3635 |    3621 | (-0.4%) |
|    10 |    4015 |    3960 | (-1.4%) |
|    12 |    4681 |    4510 | (-3.7%) |
|    14 |    5398 |    5180 | (-4.0%) |
|    16 |    6239 |    5891 | (-5.6%) |
|    20 |    7864 |    7435 | (-5.5%) |
|    24 |    9011 |    8971 | (-0.4%) |
+-------+---------+---------+---------+

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Alexander Halbuer <halbuer@sra.uni-hannover.de>
---
 mm/page_alloc.c | 48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..f82a59eeb4fe 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3119,17 +3119,17 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 {
 	unsigned long flags;
 	int i, allocated = 0;
+	int cma_pages = 0;
+	struct list_head *prev_tail = list->prev;
+	struct page *pos, *n;
 
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		struct page *page = __rmqueue(zone, order, migratetype,
-								alloc_flags);
+		struct page *page =
+			__rmqueue(zone, order, migratetype, alloc_flags);
 		if (unlikely(page == NULL))
 			break;
 
-		if (unlikely(check_pcp_refill(page, order)))
-			continue;
-
 		/*
 		 * Split buddy pages returned by expand() are received here in
 		 * physical page order. The page is added to the tail of
@@ -3141,20 +3141,44 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 * pages are ordered properly.
 		 */
 		list_add_tail(&page->pcp_list, list);
-		allocated++;
-		if (is_migrate_cma(get_pcppage_migratetype(page)))
-			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
-					      -(1 << order));
 	}
 
 	/*
-	 * i pages were removed from the buddy list even if some leak due
-	 * to check_pcp_refill failing so adjust NR_FREE_PAGES based
-	 * on i. Do not confuse with 'allocated' which is the number of
+	 * i pages were removed from the buddy list so adjust NR_FREE_PAGES
+	 * based on i. Do not confuse with 'allocated' which is the number of
 	 * pages added to the pcp list.
 	 */
 	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
+
 	spin_unlock_irqrestore(&zone->lock, flags);
+
+	/*
+	 * Pages are appended to the pcp list without checking to reduce the
+	 * time holding the zone lock. Checking the appended pages happens right
+	 * after the critical section while still holding the pcp lock.
+	 */
+	pos = list_first_entry(prev_tail, struct page, pcp_list);
+	list_for_each_entry_safe_from(pos, n, list, pcp_list) {
+		/*
+		 * Count number of cma pages to batch update of
+		 * NR_FREE_CMA_PAGES into a single function call.
+		 */
+		if (is_migrate_cma(get_pcppage_migratetype(pos)))
+			cma_pages++;
+
+		if (unlikely(check_pcp_refill(pos, order))) {
+			list_del(&pos->pcp_list);
+			continue;
+		}
+
+		allocated++;
+	}
+
+	if (cma_pages > 0) {
+		mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
+				    -(cma_pages << order));
+	}
+
 	return allocated;
 }
 
-- 
2.39.2

