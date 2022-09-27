Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDD45EBAC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 08:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiI0GfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 02:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiI0GfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 02:35:10 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBB44621F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:35:07 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mc8v60z5FzHqJj;
        Tue, 27 Sep 2022 14:32:50 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 14:35:05 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 14:35:05 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: rmap: rename page_not_mapped() to folio_not_mapped()
Date:   Tue, 27 Sep 2022 14:38:26 +0800
Message-ID: <20220927063826.159590-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2f031c6f042c ("mm/rmap: Convert rmap_walk() to
take a folio"), page_not_mapped() takes folio as parameter,
rename it to be consistent.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/rmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 2ec925e5fa6a..df228602cf0e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1801,7 +1801,7 @@ static bool invalid_migration_vma(struct vm_area_struct *vma, void *arg)
 	return vma_is_temporary_stack(vma);
 }
 
-static int page_not_mapped(struct folio *folio)
+static int folio_not_mapped(struct folio *folio)
 {
 	return !folio_mapped(folio);
 }
@@ -1822,7 +1822,7 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
 	struct rmap_walk_control rwc = {
 		.rmap_one = try_to_unmap_one,
 		.arg = (void *)flags,
-		.done = page_not_mapped,
+		.done = folio_not_mapped,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
 
@@ -2150,7 +2150,7 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 	struct rmap_walk_control rwc = {
 		.rmap_one = try_to_migrate_one,
 		.arg = (void *)flags,
-		.done = page_not_mapped,
+		.done = folio_not_mapped,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
 
@@ -2297,7 +2297,7 @@ static bool folio_make_device_exclusive(struct folio *folio,
 	};
 	struct rmap_walk_control rwc = {
 		.rmap_one = page_make_device_exclusive_one,
-		.done = page_not_mapped,
+		.done = folio_not_mapped,
 		.anon_lock = folio_lock_anon_vma_read,
 		.arg = &args,
 	};
-- 
2.35.3

