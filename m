Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA0364B212
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiLMJOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiLMJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:12:58 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35C6140E3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:11:21 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NWXlL52MTzlVjH;
        Tue, 13 Dec 2022 17:10:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 17:11:19 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <damon@lists.linux.dev>, <vishal.moola@gmail.com>,
        <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 3/8] mm: huge_memory: convert split_huge_pages_all() to use folios
Date:   Tue, 13 Dec 2022 17:27:30 +0800
Message-ID: <20221213092735.187924-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
References: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Straightforwardly convert split_huge_pages_all() to use folio function.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/huge_memory.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index abe6cfd92ffa..02092dd10aa4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2933,7 +2933,7 @@ static struct shrinker deferred_split_shrinker = {
 static void split_huge_pages_all(void)
 {
 	struct zone *zone;
-	struct page *page;
+	struct folio *folio;
 	unsigned long pfn, max_zone_pfn;
 	unsigned long total = 0, split = 0;
 
@@ -2945,25 +2945,27 @@ static void split_huge_pages_all(void)
 		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
 			int nr_pages;
 
-			page = pfn_to_online_page(pfn);
-			if (!page || !get_page_unless_zero(page))
+			folio = pfn_to_online_folio(pfn);
+			if (!folio || !folio_try_get(folio))
 				continue;
 
-			if (zone != page_zone(page))
+			if (zone != folio_zone(folio))
 				goto next;
 
-			if (!PageHead(page) || PageHuge(page) || !PageLRU(page))
+			if (!folio_test_large(folio)
+				|| folio_test_hugetlb(folio)
+				|| !folio_test_lru(folio))
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

