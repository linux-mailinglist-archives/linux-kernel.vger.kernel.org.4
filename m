Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2BF6058FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiJTHtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiJTHtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:49:17 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6CC1757B3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:49:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VSeILu6_1666252152;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VSeILu6_1666252152)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 15:49:13 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, ying.huang@intel.com, ziy@nvidia.com,
        shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        jingshan@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: gup: Re-pin pages in case of trying several times to migrate
Date:   Thu, 20 Oct 2022 15:49:00 +0800
Message-Id: <cc48dc1e4db8c33289f168cf380ab3641f45f8ad.1666251624.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The migrate_pages() will return the number of {normal page, THP, hugetlb}
that were not migrated, or an error code. That means it can still return
the number of failure count, though the pages have been migrated
successfully with several times re-try.

So we should not use the return value of migrate_pages() to determin
if there are pages are failed to migrate. Instead we can validate the
'movable_page_list' to see if there are pages remained in the list,
which are failed to migrate. That can mitigate the failure of longterm
pinning.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/gup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 5182aba..bd8cfcd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1914,9 +1914,10 @@ static int migrate_longterm_unpinnable_pages(
 			.gfp_mask = GFP_USER | __GFP_NOWARN,
 		};
 
-		if (migrate_pages(movable_page_list, alloc_migration_target,
-				  NULL, (unsigned long)&mtc, MIGRATE_SYNC,
-				  MR_LONGTERM_PIN, NULL)) {
+		ret = migrate_pages(movable_page_list, alloc_migration_target,
+				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
+				    MR_LONGTERM_PIN, NULL);
+		if (ret < 0 || !list_empty(movable_page_list)) {
 			ret = -ENOMEM;
 			goto err;
 		}
-- 
1.8.3.1

