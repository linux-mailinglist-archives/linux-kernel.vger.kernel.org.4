Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0306E08FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDMIe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDMIe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:34:56 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ABF2108
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:34:55 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PxtDY0lZhz50FXF;
        Thu, 13 Apr 2023 16:34:53 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 33D8Ykbp007431;
        Thu, 13 Apr 2023 16:34:46 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 13 Apr 2023 16:34:49 +0800 (CST)
Date:   Thu, 13 Apr 2023 16:34:49 +0800 (CST)
X-Zmail-TransId: 2b036437bea9356-74909
X-Mailer: Zmail v1.0
Message-ID: <202304131634494948454@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <iamjoonsoo.kim@lge.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIG1tOiB3b3JraW5nc2V0OiB1cGRhdGUgZGVzY3JpcHRpb24gb2YgdGhlIHNvdXJjZSBmaWxl?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 33D8Ykbp007431
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6437BEAD.000/4PxtDY0lZhz50FXF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

The calculation of workingset size is the core logic of handling refault,
it had been updated several times[1][2] after workingset.c was created[3].
But the description hadn't been updated accordingly, this mismatch may
confuse the readers.
So we update the description to make it consistent to the code. 

[1] commit 34e58cac6d8f ("mm: workingset: let cache workingset challenge anon")
[2] commit aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")
[3] commit a528910e12ec ("mm: thrash detection-based file cache sizing")

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
change for v2 - Update commit of workingset_refault() suggested Johannes Weiner.
See https://lore.kernel.org/all/20230316143007.GC116016@cmpxchg.org/
---
 mm/workingset.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index a304e8571d54..b864eec49ddd 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -111,9 +111,20 @@
  *
  *   NR_inactive + (R - E) <= NR_inactive + NR_active
  *
- * which can be further simplified to
+ * If we have swap we should consider about NR_inactive_anon and
+ * NR_active_anon, so for page cache and anonymous respectively:
  *
- *   (R - E) <= NR_active
+ *   NR_inactive_file + (R - E) <= NR_inactive_file + NR_active_file
+ *   + NR_inactive_anon + NR_active_anon
+ *
+ *   NR_inactive_anon + (R - E) <= NR_inactive_anon + NR_active_anon
+ *   + NR_inactive_file + NR_active_file
+ *
+ * Which can be further simplified to:
+ *
+ *   (R - E) <= NR_active_file + NR_inactive_anon + NR_active_anon
+ *
+ *   (R - E) <= NR_active_anon + NR_inactive_file + NR_active_file
  *
  * Put into words, the refault distance (out-of-cache) can be seen as
  * a deficit in inactive list space (in-cache).  If the inactive list
@@ -130,14 +141,14 @@
  * are no longer in active use.
  *
  * So when a refault distance of (R - E) is observed and there are at
- * least (R - E) active pages, the refaulting page is activated
- * optimistically in the hope that (R - E) active pages are actually
+ * least (R - E) pages in the userspace workingset, the refaulting page
+ * is activated optimistically in the hope that (R - E) pages are actually
  * used less frequently than the refaulting page - or even not used at
  * all anymore.
  *
  * That means if inactive cache is refaulting with a suitable refault
  * distance, we assume the cache workingset is transitioning and put
- * pressure on the current active list.
+ * pressure on the current workingset.
  *
  * If this is wrong and demotion kicks in, the pages which are truly
  * used more frequently will be reactivated while the less frequently
@@ -468,7 +479,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 	 * don't activate pages that couldn't stay resident even if
 	 * all the memory was available to the workingset. For page
 	 * cache whether workingset competition needs to consider
-	 * anon or not depends on having swap.
+	 * anon or not depends on having free swap sapce.
 	 */
 	workingset_size = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
 	/* For anonymous page */
-- 
2.25.1
