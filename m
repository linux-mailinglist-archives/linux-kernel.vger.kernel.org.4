Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCB15B92B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIOCmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIOCmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:42:12 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA206AA0D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:42:10 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 28F2fEuC020951
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Thu, 15 Sep 2022 10:41:14 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 15 Sep 2022 10:41:13 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>
Subject: [PATCHv2] mm: No need to check pcp page when free it to buddy
Date:   Thu, 15 Sep 2022 10:40:54 +0800
Message-ID: <1663209654-14727-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 28F2fEuC020951
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

The pages on pcp list have been checked the validity via bellowing call chain.
It is no need to check it again when free them back to buddy by free_pcppages_bulk.

free_unref_page\free_unref_page_list
{
...
	//page's validity is checked here
	if (!free_unref_page_prepare(page, pfn, order))
		return;
...
	//page added to pcp->lists and status is ready for moving to buddy
	list_add(&page->lru, &pcp->lists[pindex]);

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: update code and comment for clarifying
---
---
 mm/page_alloc.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3d..1472ebc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1420,14 +1420,6 @@ static bool free_pcp_prepare(struct page *page, unsigned int order)
 {
 	return free_pages_prepare(page, order, true, FPI_NONE);
 }
-
-static bool bulkfree_pcp_prepare(struct page *page)
-{
-	if (debug_pagealloc_enabled_static())
-		return check_free_page(page);
-	else
-		return false;
-}
 #else
 /*
  * With DEBUG_VM disabled, order-0 pages being freed are checked only when
@@ -1442,11 +1434,6 @@ static bool free_pcp_prepare(struct page *page, unsigned int order)
 	else
 		return free_pages_prepare(page, order, false, FPI_NONE);
 }
-
-static bool bulkfree_pcp_prepare(struct page *page)
-{
-	return check_free_page(page);
-}
 #endif /* CONFIG_DEBUG_VM */
 
 /*
@@ -1512,9 +1499,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
-			if (bulkfree_pcp_prepare(page))
-				continue;
-
 			/* MIGRATE_ISOLATE page should not go to pcplists */
 			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
 			/* Pageblock could have been isolated meanwhile */
-- 
1.9.1

