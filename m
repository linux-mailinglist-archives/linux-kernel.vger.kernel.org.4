Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF62702B96
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbjEOLhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241331AbjEOLff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:35:35 -0400
Received: from outbound-smtp62.blacknight.com (outbound-smtp62.blacknight.com [46.22.136.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E53B1985
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:34:19 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id DFC7FFAF8C
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:34:17 +0100 (IST)
Received: (qmail 26294 invoked from network); 15 May 2023 11:34:17 -0000
Received: from unknown (HELO localhost.localdomain) (mgorman@techsingularity.net@[193.118.249.27])
  by 81.17.254.9 with ESMTPA; 15 May 2023 11:34:17 -0000
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
Subject: [PATCH 2/4] mm: compaction: Only force pageblock scan completion when skip hints are obeyed
Date:   Mon, 15 May 2023 12:33:42 +0100
Message-Id: <20230515113344.6869-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230515113344.6869-1-mgorman@techsingularity.net>
References: <20230515113344.6869-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fast_find_migrateblock relies on skip hints to avoid rescanning a recently
selected pageblock but compact_zone() only forces the pageblock scan
completion to set the skip hint if in direct compaction.  While this
prevents direct compaction repeatedly scanning a subset of blocks due
to fast_find_migrateblock(), it does not prevent proactive compaction,
node compaction and kcompactd encountering the same problem described
in commit cfccd2e63e7e ("mm, compaction: finish pageblocks on complete
migration failure").

Force the scan completion of a pageblock to set the skip hint if skip
hints are obeyed to prevent fast_find_migrateblock() repeatedly selecting
a subset of pageblocks.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 81791c124bb8..accc6568091a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2456,7 +2456,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 			}
 			/*
 			 * If an ASYNC or SYNC_LIGHT fails to migrate a page
-			 * within the current order-aligned block, scan the
+			 * within the current order-aligned block and
+			 * fast_find_migrateblock may be used then scan the
 			 * remainder of the pageblock. This will mark the
 			 * pageblock "skip" to avoid rescanning in the near
 			 * future. This will isolate more pages than necessary
@@ -2465,7 +2466,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 			 * recently partially scanned.
 			 */
 			if (!pageblock_aligned(cc->migrate_pfn) &&
-			    cc->direct_compaction && !cc->finish_pageblock &&
+			    !cc->ignore_skip_hint && !cc->finish_pageblock &&
 			    (cc->mode < MIGRATE_SYNC)) {
 				cc->finish_pageblock = true;
 
-- 
2.35.3

