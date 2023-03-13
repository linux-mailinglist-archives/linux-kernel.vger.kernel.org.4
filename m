Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCDA6B743D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCMKhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCMKhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:37:51 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A8B5FA46
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:37:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vdl6q9P_1678703846;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vdl6q9P_1678703846)
          by smtp.aliyun-inc.com;
          Mon, 13 Mar 2023 18:37:26 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, osalvador@suse.de, vbabka@suse.cz,
        william.lam@bytedance.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: compaction: consider the number of scanning compound pages in isolate fail path
Date:   Mon, 13 Mar 2023 18:37:16 +0800
Message-Id: <1bc1c955b03603c4e14f56dfbbef9f637f18dbbd.1678703534.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit b717d6b93b54 ("mm: compaction: include compound page count
for scanning in pageblock isolation") had added compound page statistics
for scanning in pageblock isolation, to make sure the number of scanned
pages are always larger than the number of isolated pages when isolating
mirgratable or free pageblock.

However, when failed to isolate the pages when scanning the mirgratable or
free pageblock, the isolation failure path did not consider the scanning
statistics of the compound pages, which can show the incorrect number of
scanned pages in tracepoints or the vmstats to make people confusing about
the page scanning pressure in memory compaction.

Thus we should take into account the number of scanning pages when failed
to isolate the compound pages to make the statistics accurate.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 5a9501e0ae01..c9d9ad958e2a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -587,6 +587,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 				blockpfn += (1UL << order) - 1;
 				cursor += (1UL << order) - 1;
 			}
+			nr_scanned += (1UL << order) - 1;
 			goto isolate_fail;
 		}
 
@@ -873,9 +874,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			cond_resched();
 		}
 
-		nr_scanned++;
-
 		page = pfn_to_page(low_pfn);
+		nr_scanned += compound_nr(page);
 
 		/*
 		 * Check if the pageblock has already been marked skipped.
@@ -1077,6 +1077,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			 */
 			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
 				low_pfn += compound_nr(page) - 1;
+				nr_scanned += compound_nr(page) - 1;
 				SetPageLRU(page);
 				goto isolate_fail_put;
 			}
@@ -1097,7 +1098,6 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 isolate_success_no_list:
 		cc->nr_migratepages += compound_nr(page);
 		nr_isolated += compound_nr(page);
-		nr_scanned += compound_nr(page) - 1;
 
 		/*
 		 * Avoid isolating too much unless this block is being
-- 
2.27.0

