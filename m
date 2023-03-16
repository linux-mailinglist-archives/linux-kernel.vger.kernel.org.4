Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A406BCD87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCPLHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjCPLHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:07:03 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1317F81CCE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:06:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Ve-NM83_1678964813;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ve-NM83_1678964813)
          by smtp.aliyun-inc.com;
          Thu, 16 Mar 2023 19:06:54 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, osalvador@suse.de, vbabka@suse.cz,
        william.lam@bytedance.com, mike.kravetz@oracle.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm: compaction: consider the number of scanning compound pages in isolate fail path
Date:   Thu, 16 Mar 2023 19:06:46 +0800
Message-Id: <73d6250a90707649cc010731aedc27f946d722ed.1678962352.git.baolin.wang@linux.alibaba.com>
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
Changes from v1:
 - Move the compound pages statistics after sanity order checking.
---
 mm/compaction.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 5a9501e0ae01..7e645cdfc2e9 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -586,6 +586,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 			if (likely(order < MAX_ORDER)) {
 				blockpfn += (1UL << order) - 1;
 				cursor += (1UL << order) - 1;
+				nr_scanned += (1UL << order) - 1;
 			}
 			goto isolate_fail;
 		}
@@ -904,6 +905,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 				if (ret == -EBUSY)
 					ret = 0;
 				low_pfn += compound_nr(page) - 1;
+				nr_scanned += compound_nr(page) - 1;
 				goto isolate_fail;
 			}
 
@@ -938,8 +940,10 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			 * a valid page order. Consider only values in the
 			 * valid order range to prevent low_pfn overflow.
 			 */
-			if (freepage_order > 0 && freepage_order < MAX_ORDER)
+			if (freepage_order > 0 && freepage_order < MAX_ORDER) {
 				low_pfn += (1UL << freepage_order) - 1;
+				nr_scanned += (1UL << freepage_order) - 1;
+			}
 			continue;
 		}
 
@@ -954,8 +958,10 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (PageCompound(page) && !cc->alloc_contig) {
 			const unsigned int order = compound_order(page);
 
-			if (likely(order < MAX_ORDER))
+			if (likely(order < MAX_ORDER)) {
 				low_pfn += (1UL << order) - 1;
+				nr_scanned += (1UL << order) - 1;
+			}
 			goto isolate_fail;
 		}
 
@@ -1077,6 +1083,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			 */
 			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
 				low_pfn += compound_nr(page) - 1;
+				nr_scanned += compound_nr(page) - 1;
 				SetPageLRU(page);
 				goto isolate_fail_put;
 			}
-- 
2.27.0

