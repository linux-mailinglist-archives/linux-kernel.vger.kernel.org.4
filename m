Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA636C8BEA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjCYG40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjCYG4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:56:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2D015882
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:56:19 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pk8wK2wMczrSbW;
        Sat, 25 Mar 2023 14:55:13 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 14:56:16 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <vishal.moola@gmail.com>,
        <muchun.song@linux.dev>, <sidhartha.kumar@oracle.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v3 3/6] userfaultfd: convert copy_huge_page_from_user() to copy_folio_from_user()
Date:   Sat, 25 Mar 2023 14:56:05 +0800
Message-ID: <20230325065608.601391-4-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230325065608.601391-1-zhangpeng362@huawei.com>
References: <20230325065608.601391-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Replace copy_huge_page_from_user() with copy_folio_from_user().
copy_folio_from_user() does the same as copy_huge_page_from_user(), but
takes in a folio instead of a page. Convert page_kaddr to kaddr in
copy_folio_from_user() to do indenting cleanup.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 include/linux/mm.h |  7 +++----
 mm/hugetlb.c       |  5 ++---
 mm/memory.c        | 26 ++++++++++++--------------
 mm/userfaultfd.c   |  6 ++----
 4 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667824eb..69dfadee23e8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3546,10 +3546,9 @@ extern void copy_user_huge_page(struct page *dst, struct page *src,
 				unsigned long addr_hint,
 				struct vm_area_struct *vma,
 				unsigned int pages_per_huge_page);
-extern long copy_huge_page_from_user(struct page *dst_page,
-				const void __user *usr_src,
-				unsigned int pages_per_huge_page,
-				bool allow_pagefault);
+long copy_folio_from_user(struct folio *dst_folio,
+			   const void __user *usr_src,
+			   bool allow_pagefault);
 
 /**
  * vma_is_special_huge - Are transhuge page-table entries considered special?
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 07abcb6eb203..29ac064f69d6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6201,9 +6201,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			goto out;
 		}
 
-		ret = copy_huge_page_from_user(&folio->page,
-						(const void __user *) src_addr,
-						pages_per_huge_page(h), false);
+		ret = copy_folio_from_user(folio, (const void __user *) src_addr,
+					   false);
 
 		/* fallback to copy_from_user outside mmap_lock */
 		if (unlikely(ret)) {
diff --git a/mm/memory.c b/mm/memory.c
index 062bd215bea8..faf79742e0b6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5769,35 +5769,33 @@ void copy_user_huge_page(struct page *dst, struct page *src,
 	process_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &arg);
 }
 
-long copy_huge_page_from_user(struct page *dst_page,
-				const void __user *usr_src,
-				unsigned int pages_per_huge_page,
-				bool allow_pagefault)
+long copy_folio_from_user(struct folio *dst_folio,
+			   const void __user *usr_src,
+			   bool allow_pagefault)
 {
-	void *page_kaddr;
+	void *kaddr;
 	unsigned long i, rc = 0;
-	unsigned long ret_val = pages_per_huge_page * PAGE_SIZE;
+	unsigned int nr_pages = folio_nr_pages(dst_folio);
+	unsigned long ret_val = nr_pages * PAGE_SIZE;
 	struct page *subpage;
 
-	for (i = 0; i < pages_per_huge_page; i++) {
-		subpage = nth_page(dst_page, i);
-		page_kaddr = kmap_local_page(subpage);
+	for (i = 0; i < nr_pages; i++) {
+		subpage = folio_page(dst_folio, i);
+		kaddr = kmap_local_page(subpage);
 		if (!allow_pagefault)
 			pagefault_disable();
-		rc = copy_from_user(page_kaddr,
-				usr_src + i * PAGE_SIZE, PAGE_SIZE);
+		rc = copy_from_user(kaddr, usr_src + i * PAGE_SIZE, PAGE_SIZE);
 		if (!allow_pagefault)
 			pagefault_enable();
-		kunmap_local(page_kaddr);
+		kunmap_local(kaddr);
 
 		ret_val -= (PAGE_SIZE - rc);
 		if (rc)
 			break;
 
-		flush_dcache_page(subpage);
-
 		cond_resched();
 	}
+	flush_dcache_folio(dst_folio);
 	return ret_val;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 263191c37fb5..7b660bc07d71 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -425,10 +425,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 			mmap_read_unlock(dst_mm);
 			BUG_ON(!page);
 
-			err = copy_huge_page_from_user(page,
-						(const void __user *)src_addr,
-						vma_hpagesize / PAGE_SIZE,
-						true);
+			err = copy_folio_from_user(page_folio(page),
+						   (const void __user *)src_addr, true);
 			if (unlikely(err)) {
 				err = -EFAULT;
 				goto out;
-- 
2.25.1

