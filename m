Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD4F659695
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiL3JOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbiL3JOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:14:36 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4BA192B4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:14:35 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Njzx33NcrzqTL2;
        Fri, 30 Dec 2022 17:09:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 30 Dec 2022 17:14:33 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] mm: huge_memory: convert split_huge_pages_all() to use a folio
Date:   Fri, 30 Dec 2022 17:30:20 +0800
Message-ID: <20221230093020.9664-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Straightforwardly convert split_huge_pages_all() to use a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
- adjust indenting of code pointed by Matthew

 mm/huge_memory.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 266c4b557946..46e86293935b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2932,6 +2932,7 @@ static void split_huge_pages_all(void)
 {
 	struct zone *zone;
 	struct page *page;
+	struct folio *folio;
 	unsigned long pfn, max_zone_pfn;
 	unsigned long total = 0, split = 0;
 
@@ -2944,24 +2945,32 @@ static void split_huge_pages_all(void)
 			int nr_pages;
 
 			page = pfn_to_online_page(pfn);
-			if (!page || !get_page_unless_zero(page))
+			if (!page || PageTail(page))
+				continue;
+			folio = page_folio(page);
+			if (!folio_try_get(folio))
 				continue;
 
-			if (zone != page_zone(page))
+			if (unlikely(page_folio(page) != folio))
+				goto next;
+
+			if (zone != folio_zone(folio))
 				goto next;
 
-			if (!PageHead(page) || PageHuge(page) || !PageLRU(page))
+			if (!folio_test_large(folio) ||
+			    folio_test_hugetlb(folio) ||
+			    !folio_test_lru(folio))
 				goto next;
 
 			total++;
-			lock_page(page);
-			nr_pages = thp_nr_pages(page);
-			if (!split_huge_page(page))
+			folio_lock(folio);
+			nr_pages = folio_nr_pages(folio);
+			if (!split_folio(folio))
 				split++;
 			pfn += nr_pages - 1;
-			unlock_page(page);
+			folio_unlock(folio);
 next:
-			put_page(page);
+			folio_put(folio);
 			cond_resched();
 		}
 	}
-- 
2.35.3

