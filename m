Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F126743BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjF3MNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjF3MNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:13:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31690170E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:13:24 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QsvMZ5K4JzTldR;
        Fri, 30 Jun 2023 20:12:26 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 20:13:21 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <willy@infradead.org>, <sidhartha.kumar@oracle.com>,
        <akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH 1/2] mm: remove page_rmapping()
Date:   Fri, 30 Jun 2023 20:13:09 +0800
Message-ID: <20230630121310.165700-2-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630121310.165700-1-zhangpeng362@huawei.com>
References: <20230630121310.165700-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

After converting the last user to folio_raw_mapping(), we can safely
remove the function.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 include/linux/mm.h | 1 -
 mm/memory.c        | 2 +-
 mm/util.c          | 6 ------
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9ecb8b9c07f6..8c7eba7370b2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2129,7 +2129,6 @@ static inline void *folio_address(const struct folio *folio)
 	return page_address(&folio->page);
 }
 
-extern void *page_rmapping(struct page *page);
 extern pgoff_t __page_file_index(struct page *page);
 
 /*
diff --git a/mm/memory.c b/mm/memory.c
index 21fab2727209..6921df44a99f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2979,7 +2979,7 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
 	 * pinned by vma->vm_file's reference.  We rely on unlock_page()'s
 	 * release semantics to prevent the compiler from undoing this copying.
 	 */
-	mapping = page_rmapping(page);
+	mapping = folio_raw_mapping(page_folio(page));
 	unlock_page(page);
 
 	if (!page_mkwrite)
diff --git a/mm/util.c b/mm/util.c
index dd12b9531ac4..5e9305189c3f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -734,12 +734,6 @@ void *vcalloc(size_t n, size_t size)
 }
 EXPORT_SYMBOL(vcalloc);
 
-/* Neutral page->mapping pointer to address_space or anon_vma or other */
-void *page_rmapping(struct page *page)
-{
-	return folio_raw_mapping(page_folio(page));
-}
-
 struct anon_vma *folio_anon_vma(struct folio *folio)
 {
 	unsigned long mapping = (unsigned long)folio->mapping;
-- 
2.25.1

