Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CC5607224
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJUI10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJUI1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:27:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8766D202711
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:27:05 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtyCy4cKBzpVWk;
        Fri, 21 Oct 2022 16:23:42 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:27:01 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:27:01 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Miaohe Lin <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/3] mm: memory-failure: make put_ref_page() more useful
Date:   Fri, 21 Oct 2022 16:46:09 +0800
Message-ID: <20221021084611.53765-1-wangkefeng.wang@huawei.com>
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

Pass pfn/flags to put_ref_page(), then check MF_COUNT_INCREASED
and drop refcount to make the code look cleaner.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory-failure.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index bead6bccc7f2..b94152abb1c9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1913,17 +1913,25 @@ static inline unsigned long free_raw_hwp_pages(struct page *hpage, bool flag)
 }
 #endif	/* CONFIG_HUGETLB_PAGE */
 
+/* Drop the extra refcount in case we come from madvise() */
+static void put_ref_page(unsigned long pfn, int flags)
+{
+	struct page *page;
+
+	if (!(flags & MF_COUNT_INCREASED))
+		return;
+
+	page = pfn_to_page(pfn);
+	if (page)
+		put_page(page);
+}
+
 static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
-	struct page *page = pfn_to_page(pfn);
 	int rc = -ENXIO;
 
-	if (flags & MF_COUNT_INCREASED)
-		/*
-		 * Drop the extra refcount in case we come from madvise().
-		 */
-		put_page(page);
+	put_ref_page(pfn, flags);
 
 	/* device metadata space is not recoverable */
 	if (!pgmap_pfn_valid(pgmap, pfn))
@@ -2516,12 +2524,6 @@ static int soft_offline_in_use_page(struct page *page)
 	return ret;
 }
 
-static void put_ref_page(struct page *page)
-{
-	if (page)
-		put_page(page);
-}
-
 /**
  * soft_offline_page - Soft offline a page.
  * @pfn: pfn to soft-offline
@@ -2550,19 +2552,17 @@ int soft_offline_page(unsigned long pfn, int flags)
 {
 	int ret;
 	bool try_again = true;
-	struct page *page, *ref_page = NULL;
+	struct page *page;
 
 	WARN_ON_ONCE(!pfn_valid(pfn) && (flags & MF_COUNT_INCREASED));
 
 	if (!pfn_valid(pfn))
 		return -ENXIO;
-	if (flags & MF_COUNT_INCREASED)
-		ref_page = pfn_to_page(pfn);
 
 	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
 	page = pfn_to_online_page(pfn);
 	if (!page) {
-		put_ref_page(ref_page);
+		put_ref_page(pfn, flags);
 		return -EIO;
 	}
 
@@ -2570,7 +2570,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 	if (PageHWPoison(page)) {
 		pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
-		put_ref_page(ref_page);
+		put_ref_page(pfn, flags);
 		mutex_unlock(&mf_mutex);
 		return 0;
 	}
-- 
2.35.3

