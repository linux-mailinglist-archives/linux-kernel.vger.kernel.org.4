Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6386D5BE6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiITNMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiITNMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:12:18 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9488A402E2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:12:16 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 28KDBRE4083462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Tue, 20 Sep 2022 21:11:27 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 20 Sep 2022 21:11:28 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <steve.kang@unisoc.com>
Subject: [RFC PATCH] mm: track bad page via kmemleak
Date:   Tue, 20 Sep 2022 21:11:08 +0800
Message-ID: <1663679468-16757-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 28KDBRE4083462
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Bad pages will failed go back to allocator and leaved as orphan pages, track
them down via kmemleak.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/page_alloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d4..24f682e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1408,7 +1408,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			__memcg_kmem_uncharge_page(page, order);
 		reset_page_owner(page, order);
 		page_table_check_free(page, order);
-		return false;
+		goto err;
 	}
 
 	/*
@@ -1442,7 +1442,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	if (check_free)
 		bad += check_free_page(page);
 	if (bad)
-		return false;
+		goto err;
 
 	page_cpupid_reset_last(page);
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
@@ -1486,6 +1486,10 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	debug_pagealloc_unmap_pages(page, 1 << order);
 
 	return true;
+err:
+	kmemleak_alloc(page_address(page), PAGE_SIZE << order, 1, GFP_KERNEL);
+	return false;
+
 }
 
 #ifdef CONFIG_DEBUG_VM
-- 
1.9.1

