Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6396F67B3AB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjAYNpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbjAYNpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:45:41 -0500
Received: from outbound-smtp26.blacknight.com (outbound-smtp26.blacknight.com [81.17.249.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669823AA0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 05:45:30 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id ED3771E038
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:45:28 +0000 (GMT)
Received: (qmail 22502 invoked from network); 25 Jan 2023 13:45:28 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 25 Jan 2023 13:45:28 -0000
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
Subject: [PATCH 4/4] mm, compaction: Finish pageblocks on complete migration failure
Date:   Wed, 25 Jan 2023 13:44:34 +0000
Message-Id: <20230125134434.18017-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230125134434.18017-1-mgorman@techsingularity.net>
References: <20230125134434.18017-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7efc3b726103 ("mm/compaction: fix set skip in
fast_find_migrateblock") address an issue where a pageblock selected
by fast_find_migrateblock() was ignored. Unfortunately, the same fix
resulted in numerous reports of khugepaged or kcompactd stalling for
long periods of time or consuming 100% of CPU.

Tracing showed that there was a lot of rescanning between a small subset
of pageblocks because the conditions for marking the block skip are not
met. The scan is not reaching the end of the pageblock because enough
pages were isolated but none were migrated successfully. Eventually it
circles back to the same block.

Pageblock skip tracking tries to minimise both latency and excessive
scanning but tracking exactly when a block is fully scanned requires an
excessive amount of state. This patch forcibly rescans a pageblock when
all isolated pages fail to migrate even though it could be for transient
reasons such as page writeback or page dirty. This will sometimes migrate
too many pages but pageblocks will be marked skip and forward progress
will be made.

"Usemen" from the mmtests configuration
workload-usemem-stress-numa-compact was used to stress compaction.
The compaction trace events were recorded using a 6.2-rc5 kernel that
includes commit 7efc3b726103 and count of unique ranges were measured. The
top 5 ranges were

   3076 range=(0x10ca00-0x10cc00)
   3076 range=(0x110a00-0x110c00)
   3098 range=(0x13b600-0x13b800)
   3104 range=(0x141c00-0x141e00)
  11424 range=(0x11b600-0x11b800)

While this workload is very different than what the bugs reported,
the pattern of the same subset of blocks being repeatedly scanned is
observed. At one point, *only* the range range=(0x11b600 ~ 0x11b800)
was scanned for 2 seconds. 14 seconds passed between the first
migration-related event and the last.

With the series applied including this patch, the top 5 ranges were

      1 range=(0x11607e-0x116200)
      1 range=(0x116200-0x116278)
      1 range=(0x116278-0x116400)
      1 range=(0x116400-0x116424)
      1 range=(0x116424-0x116600)

Only unique ranges were scanned and the time between the first
migration-related event was 0.11 milliseconds.

Fixes: 7efc3b726103 ("mm/compaction: fix set skip in fast_find_migrateblock")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 4b3a0238879c..937ec2f05f2c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2394,6 +2394,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 			cc->finish_pageblock = true;
 		}
 
+rescan:
 		switch (isolate_migratepages(cc)) {
 		case ISOLATE_ABORT:
 			ret = COMPACT_CONTENDED;
@@ -2436,15 +2437,28 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 				goto out;
 			}
 			/*
-			 * We failed to migrate at least one page in the current
-			 * order-aligned block, so skip the rest of it.
+			 * If an ASYNC or SYNC_LIGHT fails to migrate a page
+			 * within the current order-aligned block, scan the
+			 * remainder of the pageblock. This will mark the
+			 * pageblock "skip" to avoid rescanning in the near
+			 * future. This will isolate more pages than necessary
+			 * for the request but avoid loops due to
+			 * fast_find_migrateblock revisiting blocks that were
+			 * recently partially scanned.
 			 */
-			if (cc->direct_compaction &&
-						(cc->mode == MIGRATE_ASYNC)) {
-				cc->migrate_pfn = block_end_pfn(
-						cc->migrate_pfn - 1, cc->order);
-				/* Draining pcplists is useless in this case */
-				last_migrated_pfn = 0;
+			if (cc->direct_compaction && !cc->finish_pageblock &&
+						(cc->mode < MIGRATE_SYNC)) {
+				cc->finish_pageblock = true;
+
+				/*
+				 * Draining pcplists does not help THP if
+				 * any page failed to migrate. Even after
+				 * drain, the pageblock will not be free.
+				 */
+				if (cc->order == COMPACTION_HPAGE_ORDER)
+					last_migrated_pfn = 0;
+
+				goto rescan;
 			}
 		}
 
-- 
2.35.3

