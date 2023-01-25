Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94DA67B3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbjAYNpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjAYNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:45:16 -0500
Received: from outbound-smtp57.blacknight.com (outbound-smtp57.blacknight.com [46.22.136.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B958642
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 05:44:59 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id D07F3FAB20
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:44:57 +0000 (GMT)
Received: (qmail 20634 invoked from network); 25 Jan 2023 13:44:57 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 25 Jan 2023 13:44:57 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/4] mm, compaction: Rename compact_control->rescan to finish_pageblock
Date:   Wed, 25 Jan 2023 13:44:31 +0000
Message-Id: <20230125134434.18017-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125134434.18017-1-mgorman@techsingularity.net>
References: <20230125134434.18017-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rescan field was not well named albeit accurate at the time. Rename the
field to finish_pageblock to indicate that the remainder of the pageblock
should be scanned regardless of COMPACT_CLUSTER_MAX. The intent is that
pageblocks with transient failures get marked for skipping to avoid
revisiting the same pageblock.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 24 ++++++++++++------------
 mm/internal.h   |  6 +++++-
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index ca1603524bbe..c018b0e65720 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1102,12 +1102,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 		/*
 		 * Avoid isolating too much unless this block is being
-		 * rescanned (e.g. dirty/writeback pages, parallel allocation)
+		 * fully scanned (e.g. dirty/writeback pages, parallel allocation)
 		 * or a lock is contended. For contention, isolate quickly to
 		 * potentially remove one source of contention.
 		 */
 		if (cc->nr_migratepages >= COMPACT_CLUSTER_MAX &&
-		    !cc->rescan && !cc->contended) {
+		    !cc->finish_pageblock && !cc->contended) {
 			++low_pfn;
 			break;
 		}
@@ -1172,14 +1172,14 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	}
 
 	/*
-	 * Updated the cached scanner pfn once the pageblock has been scanned
+	 * Update the cached scanner pfn once the pageblock has been scanned.
 	 * Pages will either be migrated in which case there is no point
 	 * scanning in the near future or migration failed in which case the
 	 * failure reason may persist. The block is marked for skipping if
 	 * there were no pages isolated in the block or if the block is
 	 * rescanned twice in a row.
 	 */
-	if (low_pfn == end_pfn && (!nr_isolated || cc->rescan)) {
+	if (low_pfn == end_pfn && (!nr_isolated || cc->finish_pageblock)) {
 		if (valid_page && !skip_updated)
 			set_pageblock_skip(valid_page);
 		update_cached_migrate(cc, low_pfn);
@@ -2374,17 +2374,17 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		unsigned long iteration_start_pfn = cc->migrate_pfn;
 
 		/*
-		 * Avoid multiple rescans which can happen if a page cannot be
-		 * isolated (dirty/writeback in async mode) or if the migrated
-		 * pages are being allocated before the pageblock is cleared.
-		 * The first rescan will capture the entire pageblock for
-		 * migration. If it fails, it'll be marked skip and scanning
-		 * will proceed as normal.
+		 * Avoid multiple rescans of the same pageblock which can
+		 * happen if a page cannot be isolated (dirty/writeback in
+		 * async mode) or if the migrated pages are being allocated
+		 * before the pageblock is cleared.  The first rescan will
+		 * capture the entire pageblock for migration. If it fails,
+		 * it'll be marked skip and scanning will proceed as normal.
 		 */
-		cc->rescan = false;
+		cc->finish_pageblock = false;
 		if (pageblock_start_pfn(last_migrated_pfn) ==
 		    pageblock_start_pfn(iteration_start_pfn)) {
-			cc->rescan = true;
+			cc->finish_pageblock = true;
 		}
 
 		switch (isolate_migratepages(cc)) {
diff --git a/mm/internal.h b/mm/internal.h
index bcf75a8b032d..21466d0ab22f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -422,7 +422,11 @@ struct compact_control {
 	bool proactive_compaction;	/* kcompactd proactive compaction */
 	bool whole_zone;		/* Whole zone should/has been scanned */
 	bool contended;			/* Signal lock contention */
-	bool rescan;			/* Rescanning the same pageblock */
+	bool finish_pageblock;		/* Scan the remainder of a pageblock. Used
+					 * when there are potentially transient
+					 * isolation or migration failures to
+					 * ensure forward progress.
+					 */
 	bool alloc_contig;		/* alloc_contig_range allocation */
 };
 
-- 
2.35.3

