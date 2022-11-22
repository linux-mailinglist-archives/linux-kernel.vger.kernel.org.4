Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82009633D41
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiKVNNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiKVNNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:13:07 -0500
Received: from outbound-smtp19.blacknight.com (outbound-smtp19.blacknight.com [46.22.139.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989562654A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:13:04 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 467661C3841
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 13:13:03 +0000 (GMT)
Received: (qmail 22136 invoked from network); 22 Nov 2022 13:13:03 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 22 Nov 2022 13:13:02 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/2] mm/page_alloc: Simplify locking during free_unref_page_list
Date:   Tue, 22 Nov 2022 13:12:29 +0000
Message-Id: <20221122131229.5263-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221122131229.5263-1-mgorman@techsingularity.net>
References: <20221122131229.5263-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While freeing a large list, the zone lock will be released and reacquired
to avoid long hold times since commit c24ad77d962c ("mm/page_alloc.c: avoid
excessive IRQ disabled times in free_unref_page_list()"). As suggested
by Vlastimil Babka, the lockrelease/reacquire logic can be simplified by
reusing the logic that acquires a different lock when changing zones.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 445066617204..08e32daf0918 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3518,13 +3518,19 @@ void free_unref_page_list(struct list_head *list)
 		list_del(&page->lru);
 		migratetype = get_pcppage_migratetype(page);
 
-		/* Different zone, different pcp lock. */
-		if (zone != locked_zone) {
+		/*
+		 * Either different zone requiring a different pcp lock or
+		 * excessive lock hold times when freeing a large list of
+		 * pages.
+		 */
+		if (zone != locked_zone || batch_count == SWAP_CLUSTER_MAX) {
 			if (pcp) {
 				pcp_spin_unlock(pcp);
 				pcp_trylock_finish(UP_flags);
 			}
 
+			batch_count = 0;
+
 			/*
 			 * trylock is necessary as pages may be getting freed
 			 * from IRQ or SoftIRQ context after an IO completion.
@@ -3539,7 +3545,6 @@ void free_unref_page_list(struct list_head *list)
 				continue;
 			}
 			locked_zone = zone;
-			batch_count = 0;
 		}
 
 		/*
@@ -3551,19 +3556,7 @@ void free_unref_page_list(struct list_head *list)
 
 		trace_mm_page_free_batched(page);
 		free_unref_page_commit(zone, pcp, page, migratetype, 0);
-
-		/*
-		 * Guard against excessive lock hold times when freeing
-		 * a large list of pages. Lock will be reacquired if
-		 * necessary on the next iteration.
-		 */
-		if (++batch_count == SWAP_CLUSTER_MAX) {
-			pcp_spin_unlock(pcp);
-			pcp_trylock_finish(UP_flags);
-			batch_count = 0;
-			pcp = NULL;
-			locked_zone = NULL;
-		}
+		batch_count++;
 	}
 
 	if (pcp) {
-- 
2.35.3

