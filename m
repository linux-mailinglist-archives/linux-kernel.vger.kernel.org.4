Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FA16AAE50
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 06:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCEFas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 00:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCEFaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 00:30:46 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD11CD53A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 21:30:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vd5I5eW_1677994236;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd5I5eW_1677994236)
          by smtp.aliyun-inc.com;
          Sun, 05 Mar 2023 13:30:41 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm/page_alloc: avoid high-order page allocation warn with __GFP_NOFAIL
Date:   Sun,  5 Mar 2023 13:30:35 +0800
Message-Id: <20230305053035.1911-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

My knowledge of this is somewhat limited, however, since vmalloc already
supported __GFP_NOFAIL in commit 9376130c390a ("mm/vmalloc: add
support for __GFP_NOFAIL").  __GFP_NOFAIL could trigger the following
stack and allocate high-order pages when CONFIG_HAVE_ARCH_HUGE_VMALLOC
is enabled:

 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2286
 vm_area_alloc_pages mm/vmalloc.c:2989 [inline]
 __vmalloc_area_node mm/vmalloc.c:3057 [inline]
 __vmalloc_node_range+0x978/0x13c0 mm/vmalloc.c:3227
 kvmalloc_node+0x156/0x1a0 mm/util.c:606
 kvmalloc include/linux/slab.h:737 [inline]
 kvmalloc_array include/linux/slab.h:755 [inline]
 kvcalloc include/linux/slab.h:760 [inline]
 (codebase: Linux 6.2-rc2)

Don't warn such cases since high-order pages with __GFP_NOFAIL is
somewhat legel.

Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mm/page_alloc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..0618716c49df 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3822,12 +3822,6 @@ struct page *rmqueue(struct zone *preferred_zone,
 {
 	struct page *page;
 
-	/*
-	 * We most definitely don't want callers attempting to
-	 * allocate greater than order-1 page units with __GFP_NOFAIL.
-	 */
-	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
-
 	if (likely(pcp_allowed_order(order))) {
 		/*
 		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
-- 
2.24.4

