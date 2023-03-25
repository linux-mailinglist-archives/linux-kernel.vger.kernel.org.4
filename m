Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6212C6C8BED
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjCYG4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjCYG4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:56:24 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6850717CE7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:56:22 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pk8sx0rzjz17NfJ;
        Sat, 25 Mar 2023 14:53:09 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 14:56:18 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <vishal.moola@gmail.com>,
        <muchun.song@linux.dev>, <sidhartha.kumar@oracle.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v3 5/6] mm: convert copy_user_huge_page() to copy_user_folio()
Date:   Sat, 25 Mar 2023 14:56:07 +0800
Message-ID: <20230325065608.601391-6-zhangpeng362@huawei.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Replace copy_user_huge_page() with copy_user_folio(). copy_user_folio()
does the same as copy_user_huge_page(), but takes in folios instead of
pages. Convert copy_user_gigantic_page() to take in folios.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 include/linux/mm.h |  8 ++++----
 mm/hugetlb.c       | 12 ++++++------
 mm/memory.c        | 28 ++++++++++++++--------------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 69dfadee23e8..6a787fe66ea1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3542,10 +3542,10 @@ extern const struct attribute_group memory_failure_attr_group;
 extern void clear_huge_page(struct page *page,
 			    unsigned long addr_hint,
 			    unsigned int pages_per_huge_page);
-extern void copy_user_huge_page(struct page *dst, struct page *src,
-				unsigned long addr_hint,
-				struct vm_area_struct *vma,
-				unsigned int pages_per_huge_page);
+void copy_user_folio(struct folio *dst, struct folio *src,
+		      unsigned long addr_hint,
+		      struct vm_area_struct *vma,
+		      unsigned int pages_per_huge_page);
 long copy_folio_from_user(struct folio *dst_folio,
 			   const void __user *usr_src,
 			   bool allow_pagefault);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1cfd20e5fe8b..85657f9007ee 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5093,8 +5093,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					ret = PTR_ERR(new_folio);
 					break;
 				}
-				copy_user_huge_page(&new_folio->page, ptepage, addr, dst_vma,
-						    npages);
+				copy_user_folio(new_folio, page_folio(ptepage), addr, dst_vma,
+						npages);
 				put_page(ptepage);
 
 				/* Install the new hugetlb folio if src pte stable */
@@ -5602,8 +5602,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_release_all;
 	}
 
-	copy_user_huge_page(&new_folio->page, old_page, address, vma,
-			    pages_per_huge_page(h));
+	copy_user_folio(new_folio, page_folio(old_page), address, vma,
+			pages_per_huge_page(h));
 	__folio_mark_uptodate(new_folio);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, haddr,
@@ -6244,8 +6244,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			*foliop = NULL;
 			goto out;
 		}
-		copy_user_huge_page(&folio->page, &(*foliop)->page, dst_addr, dst_vma,
-				    pages_per_huge_page(h));
+		copy_user_folio(folio, *foliop, dst_addr, dst_vma,
+				pages_per_huge_page(h));
 		folio_put(*foliop);
 		*foliop = NULL;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index faf79742e0b6..4752f0e829b6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5716,21 +5716,21 @@ void clear_huge_page(struct page *page,
 	process_huge_page(addr_hint, pages_per_huge_page, clear_subpage, page);
 }
 
-static void copy_user_gigantic_page(struct page *dst, struct page *src,
-				    unsigned long addr,
-				    struct vm_area_struct *vma,
-				    unsigned int pages_per_huge_page)
+static void copy_user_gigantic_page(struct folio *dst, struct folio *src,
+				     unsigned long addr,
+				     struct vm_area_struct *vma,
+				     unsigned int pages_per_huge_page)
 {
 	int i;
-	struct page *dst_base = dst;
-	struct page *src_base = src;
+	struct page *dst_page;
+	struct page *src_page;
 
 	for (i = 0; i < pages_per_huge_page; i++) {
-		dst = nth_page(dst_base, i);
-		src = nth_page(src_base, i);
+		dst_page = folio_page(dst, i);
+		src_page = folio_page(src, i);
 
 		cond_resched();
-		copy_user_highpage(dst, src, addr + i*PAGE_SIZE, vma);
+		copy_user_highpage(dst_page, src_page, addr + i*PAGE_SIZE, vma);
 	}
 }
 
@@ -5748,15 +5748,15 @@ static void copy_subpage(unsigned long addr, int idx, void *arg)
 			   addr, copy_arg->vma);
 }
 
-void copy_user_huge_page(struct page *dst, struct page *src,
-			 unsigned long addr_hint, struct vm_area_struct *vma,
-			 unsigned int pages_per_huge_page)
+void copy_user_folio(struct folio *dst, struct folio *src,
+		      unsigned long addr_hint, struct vm_area_struct *vma,
+		      unsigned int pages_per_huge_page)
 {
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
 	struct copy_subpage_arg arg = {
-		.dst = dst,
-		.src = src,
+		.dst = &dst->page,
+		.src = &src->page,
 		.vma = vma,
 	};
 
-- 
2.25.1

