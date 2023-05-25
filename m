Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FD3710C77
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbjEYMya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjEYMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:54:21 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C5D187
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:54:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjSMoYJ_1685019255;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VjSMoYJ_1685019255)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 20:54:16 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] mm: compaction: add trace event for fast freepages isolation
Date:   Thu, 25 May 2023 20:54:00 +0800
Message-Id: <78d2932d0160d122c15372aceb3f2c45460a17fc.1685018752.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1685018752.git.baolin.wang@linux.alibaba.com>
References: <cover.1685018752.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fast_isolate_freepages() can also isolate freepages, but we can not
know the fast isolation efficiency to understand the fast isolation pressure.
So add a trace event to show some numbers to help to understand the efficiency
for fast freepages isolation.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/trace/events/compaction.h | 11 +++++++++++
 mm/compaction.c                   |  6 +++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index 3313eb83c117..2b2a975efd20 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -64,6 +64,17 @@ DEFINE_EVENT(mm_compaction_isolate_template, mm_compaction_isolate_freepages,
 	TP_ARGS(start_pfn, end_pfn, nr_scanned, nr_taken)
 );
 
+DEFINE_EVENT(mm_compaction_isolate_template, mm_compaction_fast_isolate_freepages,
+
+	TP_PROTO(
+		unsigned long start_pfn,
+		unsigned long end_pfn,
+		unsigned long nr_scanned,
+		unsigned long nr_taken),
+
+	TP_ARGS(start_pfn, end_pfn, nr_scanned, nr_taken)
+);
+
 #ifdef CONFIG_COMPACTION
 TRACE_EVENT(mm_compaction_migratepages,
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 65d8d9223acc..eccec84dae82 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1438,7 +1438,7 @@ static int next_search_order(struct compact_control *cc, int order)
 static void fast_isolate_freepages(struct compact_control *cc)
 {
 	unsigned int limit = max(1U, freelist_scan_limit(cc) >> 1);
-	unsigned int nr_scanned = 0;
+	unsigned int nr_scanned = 0, total_isolated = 0;
 	unsigned long low_pfn, min_pfn, highest = 0;
 	unsigned long nr_isolated = 0;
 	unsigned long distance;
@@ -1537,6 +1537,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 				set_page_private(page, order);
 				nr_isolated = 1 << order;
 				nr_scanned += nr_isolated - 1;
+				total_isolated += nr_isolated;
 				cc->nr_freepages += nr_isolated;
 				list_add_tail(&page->lru, &cc->freepages);
 				count_compact_events(COMPACTISOLATED, nr_isolated);
@@ -1557,6 +1558,9 @@ static void fast_isolate_freepages(struct compact_control *cc)
 			limit = max(1U, limit >> 1);
 	}
 
+	trace_mm_compaction_fast_isolate_freepages(min_pfn, cc->free_pfn,
+						   nr_scanned, total_isolated);
+
 	if (!page) {
 		cc->fast_search_fail++;
 		if (scan_start) {
-- 
2.27.0

