Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C44C664207
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbjAJNg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjAJNgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:36:36 -0500
Received: from out30-8.freemail.mail.aliyun.com (out30-8.freemail.mail.aliyun.com [115.124.30.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1EDBC8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:36:33 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VZJUhj7_1673357788;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VZJUhj7_1673357788)
          by smtp.aliyun-inc.com;
          Tue, 10 Jan 2023 21:36:28 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mm: compaction: Move list validation into compact_zone()
Date:   Tue, 10 Jan 2023 21:36:19 +0800
Message-Id: <15cf54f7d762e87b04ac3cc74536f7d1ebbcd8cd.1673342761.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
References: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the cc.freepages and cc.migratepages list validation into compact_zone()
to remove some duplicate code.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 5e6f5e35748d..f8e8addc8664 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2488,6 +2488,9 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	trace_mm_compaction_end(cc, start_pfn, end_pfn, sync, ret);
 
+	VM_BUG_ON(!list_empty(&cc->freepages));
+	VM_BUG_ON(!list_empty(&cc->migratepages));
+
 	return ret;
 }
 
@@ -2526,9 +2529,6 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
 
 	ret = compact_zone(&cc, &capc);
 
-	VM_BUG_ON(!list_empty(&cc.freepages));
-	VM_BUG_ON(!list_empty(&cc.migratepages));
-
 	/*
 	 * Make sure we hide capture control first before we read the captured
 	 * page pointer, otherwise an interrupt could free and capture a page
@@ -2659,9 +2659,6 @@ static void proactive_compact_node(pg_data_t *pgdat)
 		cc.zone = zone;
 
 		compact_zone(&cc, NULL);
-
-		VM_BUG_ON(!list_empty(&cc.freepages));
-		VM_BUG_ON(!list_empty(&cc.migratepages));
 	}
 }
 
@@ -2689,9 +2686,6 @@ static void compact_node(int nid)
 		cc.zone = zone;
 
 		compact_zone(&cc, NULL);
-
-		VM_BUG_ON(!list_empty(&cc.freepages));
-		VM_BUG_ON(!list_empty(&cc.migratepages));
 	}
 }
 
@@ -2868,9 +2862,6 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 				     cc.total_migrate_scanned);
 		count_compact_events(KCOMPACTD_FREE_SCANNED,
 				     cc.total_free_scanned);
-
-		VM_BUG_ON(!list_empty(&cc.freepages));
-		VM_BUG_ON(!list_empty(&cc.migratepages));
 	}
 
 	/*
-- 
2.27.0

