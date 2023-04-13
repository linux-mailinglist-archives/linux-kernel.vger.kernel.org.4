Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2297F6E0D64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDMMX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDMMXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:23:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16FE359A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:23:52 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PxzDZ4VB2znbw1;
        Thu, 13 Apr 2023 20:20:14 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Apr
 2023 20:23:50 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Tony Luck <tony.luck@intel.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <muchun.song@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next v2] mm: hwpoison: support recovery from HugePage copy-on-write faults
Date:   Thu, 13 Apr 2023 21:13:49 +0800
Message-ID: <20230413131349.2524210-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy-on-write of hugetlb user pages with uncorrectable errors will result
in a kernel crash. This is because the copy is performed in kernel mode
and in general we can not handle accessing memory with such errors while
in kernel mode. Commit a873dfe1032a ("mm, hwpoison: try to recover from
copy-on write faults") introduced the routine copy_user_highpage_mc() to
gracefully handle copying of user pages with uncorrectable errors. However,
the separate hugetlb copy-on-write code paths were not modified as part
of commit a873dfe1032a.

Modify hugetlb copy-on-write code paths to use copy_mc_user_highpage()
so that they can also gracefully handle uncorrectable errors in user
pages. This involves changing the hugetlb specific routine
copy_user_large_folio() from type void to int so that it can return an error.
Modify the hugetlb userfaultfd code in the same way so that it can return
-EHWPOISON if it encounters an uncorrectable error.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
v2:
- Update changelog and code based on newest branch, thanks for Mike's changelog.
 include/linux/mm.h |  6 ++---
 mm/hugetlb.c       | 17 ++++++++++---
 mm/memory.c        | 59 +++++++++++++++++++++++++++++-----------------
 3 files changed, 55 insertions(+), 27 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 88df1f146121..46c9ae9a7f9b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3730,9 +3730,9 @@ extern const struct attribute_group memory_failure_attr_group;
 extern void clear_huge_page(struct page *page,
 			    unsigned long addr_hint,
 			    unsigned int pages_per_huge_page);
-void copy_user_large_folio(struct folio *dst, struct folio *src,
-			   unsigned long addr_hint,
-			   struct vm_area_struct *vma);
+int copy_user_large_folio(struct folio *dst, struct folio *src,
+			  unsigned long addr_hint,
+			  struct vm_area_struct *vma);
 long copy_folio_from_user(struct folio *dst_folio,
 			   const void __user *usr_src,
 			   bool allow_pagefault);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 80c0bf2a4f64..155bb6712be1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5142,10 +5142,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					ret = PTR_ERR(new_folio);
 					break;
 				}
-				copy_user_large_folio(new_folio,
+				ret = copy_user_large_folio(new_folio,
 						      page_folio(ptepage),
 						      addr, dst_vma);
 				put_page(ptepage);
+				if (ret) {
+					folio_put(new_folio);
+					break;
+				}
 
 				/* Install the new hugetlb folio if src pte stable */
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
@@ -5662,7 +5666,10 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_release_all;
 	}
 
-	copy_user_large_folio(new_folio, page_folio(old_page), address, vma);
+	if (copy_user_large_folio(new_folio, page_folio(old_page), address, vma)) {
+		ret = VM_FAULT_HWPOISON_LARGE;
+		goto out_release_all;
+	}
 	__folio_mark_uptodate(new_folio);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, haddr,
@@ -6305,9 +6312,13 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			*foliop = NULL;
 			goto out;
 		}
-		copy_user_large_folio(folio, *foliop, dst_addr, dst_vma);
+		ret = copy_user_large_folio(folio, *foliop, dst_addr, dst_vma);
 		folio_put(*foliop);
 		*foliop = NULL;
+		if (ret) {
+			folio_put(folio);
+			goto out;
+		}
 	}
 
 	/*
diff --git a/mm/memory.c b/mm/memory.c
index 1607f0862f65..f2a33337631c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5734,12 +5734,12 @@ EXPORT_SYMBOL(__might_fault);
  * operation.  The target subpage will be processed last to keep its
  * cache lines hot.
  */
-static inline void process_huge_page(
+static inline int process_huge_page(
 	unsigned long addr_hint, unsigned int pages_per_huge_page,
-	void (*process_subpage)(unsigned long addr, int idx, void *arg),
+	int (*process_subpage)(unsigned long addr, int idx, void *arg),
 	void *arg)
 {
-	int i, n, base, l;
+	int i, n, base, l, ret;
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
 
@@ -5753,7 +5753,9 @@ static inline void process_huge_page(
 		/* Process subpages at the end of huge page */
 		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
 			cond_resched();
-			process_subpage(addr + i * PAGE_SIZE, i, arg);
+			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
+			if (ret)
+				return ret;
 		}
 	} else {
 		/* If target subpage in second half of huge page */
@@ -5762,7 +5764,9 @@ static inline void process_huge_page(
 		/* Process subpages at the begin of huge page */
 		for (i = 0; i < base; i++) {
 			cond_resched();
-			process_subpage(addr + i * PAGE_SIZE, i, arg);
+			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
+			if (ret)
+				return ret;
 		}
 	}
 	/*
@@ -5774,10 +5778,15 @@ static inline void process_huge_page(
 		int right_idx = base + 2 * l - 1 - i;
 
 		cond_resched();
-		process_subpage(addr + left_idx * PAGE_SIZE, left_idx, arg);
+		ret = process_subpage(addr + left_idx * PAGE_SIZE, left_idx, arg);
+		if (ret)
+			return ret;
 		cond_resched();
-		process_subpage(addr + right_idx * PAGE_SIZE, right_idx, arg);
+		ret = process_subpage(addr + right_idx * PAGE_SIZE, right_idx, arg);
+		if (ret)
+			return ret;
 	}
+	return 0;
 }
 
 static void clear_gigantic_page(struct page *page,
@@ -5795,11 +5804,12 @@ static void clear_gigantic_page(struct page *page,
 	}
 }
 
-static void clear_subpage(unsigned long addr, int idx, void *arg)
+static int clear_subpage(unsigned long addr, int idx, void *arg)
 {
 	struct page *page = arg;
 
 	clear_user_highpage(page + idx, addr);
+	return 0;
 }
 
 void clear_huge_page(struct page *page,
@@ -5816,7 +5826,7 @@ void clear_huge_page(struct page *page,
 	process_huge_page(addr_hint, pages_per_huge_page, clear_subpage, page);
 }
 
-static void copy_user_gigantic_page(struct folio *dst, struct folio *src,
+static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
 				     unsigned long addr,
 				     struct vm_area_struct *vma,
 				     unsigned int pages_per_huge_page)
@@ -5830,8 +5840,13 @@ static void copy_user_gigantic_page(struct folio *dst, struct folio *src,
 		src_page = folio_page(src, i);
 
 		cond_resched();
-		copy_user_highpage(dst_page, src_page, addr + i*PAGE_SIZE, vma);
+		if (copy_mc_user_highpage(dst_page, src_page,
+					  addr + i*PAGE_SIZE, vma)) {
+			memory_failure_queue(page_to_pfn(src_page), 0);
+			return -EHWPOISON;
+		}
 	}
+	return 0;
 }
 
 struct copy_subpage_arg {
@@ -5840,16 +5855,20 @@ struct copy_subpage_arg {
 	struct vm_area_struct *vma;
 };
 
-static void copy_subpage(unsigned long addr, int idx, void *arg)
+static int copy_subpage(unsigned long addr, int idx, void *arg)
 {
 	struct copy_subpage_arg *copy_arg = arg;
 
-	copy_user_highpage(copy_arg->dst + idx, copy_arg->src + idx,
-			   addr, copy_arg->vma);
+	if (copy_mc_user_highpage(copy_arg->dst + idx, copy_arg->src + idx,
+				  addr, copy_arg->vma)) {
+		memory_failure_queue(page_to_pfn(copy_arg->src + idx), 0);
+		return -EHWPOISON;
+	}
+	return 0;
 }
 
-void copy_user_large_folio(struct folio *dst, struct folio *src,
-			   unsigned long addr_hint, struct vm_area_struct *vma)
+int copy_user_large_folio(struct folio *dst, struct folio *src,
+			  unsigned long addr_hint, struct vm_area_struct *vma)
 {
 	unsigned int pages_per_huge_page = folio_nr_pages(dst);
 	unsigned long addr = addr_hint &
@@ -5860,13 +5879,11 @@ void copy_user_large_folio(struct folio *dst, struct folio *src,
 		.vma = vma,
 	};
 
-	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
-		copy_user_gigantic_page(dst, src, addr, vma,
-					pages_per_huge_page);
-		return;
-	}
+	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES))
+		return copy_user_gigantic_page(dst, src, addr, vma,
+					       pages_per_huge_page);
 
-	process_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &arg);
+	return process_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &arg);
 }
 
 long copy_folio_from_user(struct folio *dst_folio,
-- 
2.25.1

