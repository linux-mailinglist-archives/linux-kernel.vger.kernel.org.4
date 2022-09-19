Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A885BC1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiISDsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiISDsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:48:17 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6D9E021
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 20:48:15 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 28J3ldJv048412
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Mon, 19 Sep 2022 11:47:39 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 19 Sep 2022 11:47:38 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>
Subject: [PATCH] mm: check high-order page when free it to pcp
Date:   Mon, 19 Sep 2022 11:47:18 +0800
Message-ID: <1663559238-22918-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 28J3ldJv048412
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

High-order pcp page escaped from checking when both of DEBUG_VM and debug_pagealloc
are all disabled if it allocated again from pcp_list without going to global
free list, which should be introduced by 44042b4498.

fix:44042b4498

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3d..e77f3a7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1437,7 +1437,7 @@ static bool bulkfree_pcp_prepare(struct page *page)
  */
 static bool free_pcp_prepare(struct page *page, unsigned int order)
 {
-	if (debug_pagealloc_enabled_static())
+	if (debug_pagealloc_enabled_static() || order)
 		return free_pages_prepare(page, order, true, FPI_NONE);
 	else
 		return free_pages_prepare(page, order, false, FPI_NONE);
-- 
1.9.1

