Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E8702B99
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbjEOLhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbjEOLfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:35:51 -0400
Received: from outbound-smtp41.blacknight.com (outbound-smtp41.blacknight.com [46.22.139.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E154F19A6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:34:29 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp41.blacknight.com (Postfix) with ESMTPS id 8D811230D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:34:28 +0100 (IST)
Received: (qmail 27031 invoked from network); 15 May 2023 11:34:28 -0000
Received: from unknown (HELO localhost.localdomain) (mgorman@techsingularity.net@[193.118.249.27])
  by 81.17.254.9 with ESMTPA; 15 May 2023 11:34:28 -0000
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
Subject: [PATCH 3/4] mm: compaction: Update pageblock skip when first migration candidate is not at the start
Date:   Mon, 15 May 2023 12:33:43 +0100
Message-Id: <20230515113344.6869-4-mgorman@techsingularity.net>
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

isolate_migratepages_block should mark a pageblock as skip if scanning
started on an aligned pageblock boundary but it only updates the skip
flag if the first migration candidate is also aligned. Tracing during
a compaction stress load (mmtests: workload-usemem-stress-numa-compact)
that many pageblocks are not marked skip causing excessive scanning of
blocks that had been recently checked. Update pageblock skip based on
"valid_page" which is set if scanning started on a pageblock boundary.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index accc6568091a..d7be990b1d60 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -392,18 +392,14 @@ void reset_isolation_suitable(pg_data_t *pgdat)
  * Sets the pageblock skip bit if it was clear. Note that this is a hint as
  * locks are not required for read/writers. Returns true if it was already set.
  */
-static bool test_and_set_skip(struct compact_control *cc, struct page *page,
-							unsigned long pfn)
+static bool test_and_set_skip(struct compact_control *cc, struct page *page)
 {
 	bool skip;
 
-	/* Do no update if skip hint is being ignored */
+	/* Do not update if skip hint is being ignored */
 	if (cc->ignore_skip_hint)
 		return false;
 
-	if (!pageblock_aligned(pfn))
-		return false;
-
 	skip = get_pageblock_skip(page);
 	if (!skip && !cc->no_set_skip_hint)
 		set_pageblock_skip(page);
@@ -470,8 +466,7 @@ static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
 {
 }
 
-static bool test_and_set_skip(struct compact_control *cc, struct page *page,
-							unsigned long pfn)
+static bool test_and_set_skip(struct compact_control *cc, struct page *page)
 {
 	return false;
 }
@@ -1075,9 +1070,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			lruvec_memcg_debug(lruvec, page_folio(page));
 
 			/* Try get exclusive access under lock */
-			if (!skip_updated) {
+			if (!skip_updated && valid_page) {
 				skip_updated = true;
-				if (test_and_set_skip(cc, page, low_pfn))
+				if (test_and_set_skip(cc, valid_page))
 					goto isolate_abort;
 			}
 
-- 
2.35.3

