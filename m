Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB056EF70F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbjDZPDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240651AbjDZPD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:03:29 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB345279
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:03:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vh3nnLS_1682521402;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vh3nnLS_1682521402)
          by smtp.aliyun-inc.com;
          Wed, 26 Apr 2023 23:03:23 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "Revert "mm/compaction: fix set skip in fast_find_migrateblock""
Date:   Wed, 26 Apr 2023 23:03:13 +0800
Message-Id: <3576e3520c044beb2a81860aecb2d4f597089300.1682521303.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 95e7a450b8190673675836bfef236262ceff084a.

When I tested thpscale with v6.3 kernel, I found the compaction efficiency
had a great regression compared to v6.2-rc1 kernel. See below numbers:
                                    v6.2-rc             v6.3
Percentage huge-3        81.35 (   0.00%)       32.97 ( -59.47%)
Percentage huge-5        89.92 (   0.00%)       41.70 ( -53.63%)
Percentage huge-7        92.41 (   0.00%)       34.08 ( -63.12%)
Percentage huge-12       90.29 (   0.00%)       41.10 ( -54.49%)
Percentage huge-18       82.38 (   0.00%)       41.24 ( -49.95%)
Percentage huge-24       80.34 (   0.00%)       35.99 ( -55.20%)
Percentage huge-30       88.90 (   0.00%)       44.20 ( -50.28%)
Percentage huge-32       90.69 (   0.00%)       79.57 ( -12.25%)

Ops Compaction stalls                 113790.00      207099.00
Ops Compaction success                 33983.00      19488.00
Ops Compaction failures                79807.00      187611.00
Ops Compaction efficiency                 29.86          9.41

After some investigation, I found the commit 95e7a450b819
("Revert mm/compaction: fix set skip in fast_find_migrateblock") caused
the regression. This commit revert the commit 7efc3b726103 ("mm/compaction:
fix set skip in fast_find_migrateblock") to fix a CPU stalling issue, which
is caused by compaction stucked in repeating fast_find_migrateblock().

And now the compaction stalling issue is addressed by commit cfccd2e63e7e
("mm, compaction: finish pageblocks on complete migration failure"). So
we should revert the temporary fix by commit 95e7a450b819, since the
fast pfn found by fast_find_migrateblock() really can help to isolate
some migratable pages.

After reverting the commit, the regression has gone.
                               v6.2-rc1                  v6.3           v6.3_patched
Percentage huge-3        81.35 (   0.00%)       32.97 ( -59.47%)       87.78 (   7.90%)
Percentage huge-5        89.92 (   0.00%)       41.70 ( -53.63%)       89.68 (  -0.27%)
Percentage huge-7        92.41 (   0.00%)       34.08 ( -63.12%)       85.89 (  -7.05%)
Percentage huge-12       90.29 (   0.00%)       41.10 ( -54.49%)       94.10 (   4.22%)
Percentage huge-18       82.38 (   0.00%)       41.24 ( -49.95%)       85.06 (   3.25%)
Percentage huge-24       80.34 (   0.00%)       35.99 ( -55.20%)       84.38 (   5.02%)
Percentage huge-30       88.90 (   0.00%)       44.20 ( -50.28%)       95.54 (   7.48%)
Percentage huge-32       90.69 (   0.00%)       79.57 ( -12.25%)       92.30 (   1.78%)

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 33650541bebc..567c8d41d01e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1860,7 +1860,6 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
 					pfn = cc->zone->zone_start_pfn;
 				cc->fast_search_fail = 0;
 				found_block = true;
-				set_pageblock_skip(freepage);
 				break;
 			}
 		}
-- 
2.27.0

