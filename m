Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C16964B210
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiLMJOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiLMJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:12:58 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5716615836
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:11:22 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NWXgX3slFzqSsf;
        Tue, 13 Dec 2022 17:07:04 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 17:11:20 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <damon@lists.linux.dev>, <vishal.moola@gmail.com>,
        <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 4/8] mm: damon: add temporary damon_get_folio()
Date:   Tue, 13 Dec 2022 17:27:31 +0800
Message-ID: <20221213092735.187924-5-wangkefeng.wang@huawei.com>
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

Introduce a temporary wrapper function damon_get_folio(), which
help us to convert damon related function to use folios, and it
will be droped once the conversion is completed.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/ops-common.c | 18 +++++++++---------
 mm/damon/ops-common.h |  8 +++++++-
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 75409601f934..40b79b022129 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -13,24 +13,24 @@
 #include "ops-common.h"
 
 /*
- * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
+ * Get an online folio for a pfn if it's in the LRU list.  Otherwise, returns
  * NULL.
  *
- * The body of this function is stolen from the 'page_idle_get_page()'.  We
+ * The body of this function is stolen from the 'folio_idle_get_folio()'.  We
  * steal rather than reuse it because the code is quite simple.
  */
-struct page *damon_get_page(unsigned long pfn)
+struct folio *damon_get_folio(unsigned long pfn)
 {
-	struct page *page = pfn_to_online_page(pfn);
+	struct folio *folio = pfn_to_online_folio(pfn);
 
-	if (!page || !PageLRU(page) || !get_page_unless_zero(page))
+	if (!folio || !folio_test_lru(folio) || !folio_try_get(folio))
 		return NULL;
 
-	if (unlikely(!PageLRU(page))) {
-		put_page(page);
-		page = NULL;
+	if (unlikely(!folio_test_lru(folio))) {
+		folio_put(folio);
+		folio = NULL;
 	}
-	return page;
+	return folio;
 }
 
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 8d82d3722204..4ee607813981 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -7,7 +7,13 @@
 
 #include <linux/damon.h>
 
-struct page *damon_get_page(unsigned long pfn);
+struct folio *damon_get_folio(unsigned long pfn);
+static inline struct page *damon_get_page(unsigned long pfn)
+{
+	struct folio *folio = damon_get_folio(pfn);
+
+	return &folio->page;
+}
 
 void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
 void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
-- 
2.35.3

