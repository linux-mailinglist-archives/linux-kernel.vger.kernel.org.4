Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF922702B94
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbjEOLgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241317AbjEOLeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:34:09 -0400
Received: from outbound-smtp35.blacknight.com (outbound-smtp35.blacknight.com [46.22.139.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E075E49
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:34:08 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 36DD022AB
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:34:07 +0100 (IST)
Received: (qmail 25659 invoked from network); 15 May 2023 11:34:07 -0000
Received: from unknown (HELO localhost.localdomain) (mgorman@techsingularity.net@[193.118.249.27])
  by 81.17.254.9 with ESMTPA; 15 May 2023 11:34:06 -0000
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
Subject: [PATCH 1/4] mm: compaction: Ensure rescanning only happens on partially scanned pageblocks
Date:   Mon, 15 May 2023 12:33:41 +0100
Message-Id: <20230515113344.6869-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230515113344.6869-1-mgorman@techsingularity.net>
References: <20230515113344.6869-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

compact_zone() intends to rescan pageblocks if there is a failure to
migrate "within the current order-aligned block". However, the pageblock
scan may already be complete and moved to the next block causing the
next pageblock to be "rescanned". Ensure only the most recent pageblock
is rescanned.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index c8bcdea15f5f..81791c124bb8 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2464,8 +2464,9 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 			 * fast_find_migrateblock revisiting blocks that were
 			 * recently partially scanned.
 			 */
-			if (cc->direct_compaction && !cc->finish_pageblock &&
-						(cc->mode < MIGRATE_SYNC)) {
+			if (!pageblock_aligned(cc->migrate_pfn) &&
+			    cc->direct_compaction && !cc->finish_pageblock &&
+			    (cc->mode < MIGRATE_SYNC)) {
 				cc->finish_pageblock = true;
 
 				/*
-- 
2.35.3

