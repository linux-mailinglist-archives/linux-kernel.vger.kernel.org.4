Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E84686BD0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjBAQdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjBAQdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:33:15 -0500
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 08:32:57 PST
Received: from mailout2n.rrzn.uni-hannover.de (mailout2n.rrzn.uni-hannover.de [130.75.2.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B59F4202
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:32:57 -0800 (PST)
Received: from beifus.sra.uni-hannover.de (lab.sra.uni-hannover.de [130.75.33.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id CD1991F4B8;
        Wed,  1 Feb 2023 17:27:28 +0100 (CET)
From:   Alexander Halbuer <halbuer@sra.uni-hannover.de>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Alexander Halbuer <halbuer@sra.uni-hannover.de>
Subject: [PATCH] mm: reduce lock contention of pcp buffer refill
Date:   Wed,  1 Feb 2023 17:25:49 +0100
Message-Id: <20230201162549.68384-1-halbuer@sra.uni-hannover.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.7 at mailout2n
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `rmqueue_bulk` function batches the allocation of multiple elements to
refill the per-CPU buffers into a single hold of the zone lock. Each
element is allocated and checked using the `check_pcp_refill` function.
The check touches every related struct page which is especially expensive
for higher order allocations (huge pages). This patch reduces the time
holding the lock by moving the check out of the critical section similar
to the `rmqueue_buddy` function which allocates a single element.
Measurements of parallel allocation-heavy workloads show a reduction of
the average huge page allocation latency of 50 percent for two cores and
nearly 90 percent for 24 cores.

Signed-off-by: Alexander Halbuer <halbuer@sra.uni-hannover.de>
---
 mm/page_alloc.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..4b80438b1f59 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3119,6 +3119,8 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 {
 	unsigned long flags;
 	int i, allocated = 0;
+	struct list_head *prev_tail = list->prev;
+	struct page *pos, *n;
 
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
@@ -3127,9 +3129,6 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		if (unlikely(page == NULL))
 			break;
 
-		if (unlikely(check_pcp_refill(page, order)))
-			continue;
-
 		/*
 		 * Split buddy pages returned by expand() are received here in
 		 * physical page order. The page is added to the tail of
@@ -3141,7 +3140,6 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 * pages are ordered properly.
 		 */
 		list_add_tail(&page->pcp_list, list);
-		allocated++;
 		if (is_migrate_cma(get_pcppage_migratetype(page)))
 			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
 					      -(1 << order));
@@ -3155,6 +3153,22 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	 */
 	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
 	spin_unlock_irqrestore(&zone->lock, flags);
+
+	/*
+	 * Pages are appended to the pcp list without checking to reduce the
+	 * time holding the zone lock. Checking the appended pages happens right
+	 * after the critical section while still holding the pcp lock.
+	 */
+	pos = list_first_entry(prev_tail, struct page, pcp_list);
+	list_for_each_entry_safe_from(pos, n, list, pcp_list) {
+		if (unlikely(check_pcp_refill(pos, order))) {
+			list_del(&pos->pcp_list);
+			continue;
+		}
+
+		allocated++;
+	}
+
 	return allocated;
 }
 
-- 
2.39.1

