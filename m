Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4254E5BF87F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiIUIBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiIUIBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:01:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4B8861FE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:00:58 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXW305QXdzmWJR;
        Wed, 21 Sep 2022 15:57:00 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 16:00:56 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 16:00:55 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Liu Zixian <liuzixian4@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: hugetlb: fix UAF in hugetlb_handle_userfault
Date:   Wed, 21 Sep 2022 16:34:40 +0800
Message-ID: <20220921083440.1267903-1-liushixin2@huawei.com>
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

The vma_lock and hugetlb_fault_mutex are dropped before handling
userfault and reacquire them again after handle_userfault(), but
reacquire the vma_lock could lead to UAF[1] due to the following
race,

hugetlb_fault
  hugetlb_no_page
    /*unlock vma_lock */
    hugetlb_handle_userfault
      handle_userfault
        /* unlock mm->mmap_lock*/
                                           vm_mmap_pgoff
                                             do_mmap
                                               mmap_region
                                                 munmap_vma_range
                                                   /* clean old vma */
        /* lock vma_lock again  <--- UAF */
    /* unlock vma_lock */

Since the vma_lock will unlock immediately after hugetlb_handle_userfault(),
let's drop the unneeded lock and unlock in hugetlb_handle_userfault() to fix
the issue.

[1] https://lore.kernel.org/linux-mm/20220921014457.1668-1-liuzixian4@huawei.com/
Reported-by: Liu Zixian <liuzixian4@huawei.com>
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/hugetlb.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9b8526d27c29..5a5d466692cf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5489,7 +5489,6 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 						  unsigned long addr,
 						  unsigned long reason)
 {
-	vm_fault_t ret;
 	u32 hash;
 	struct vm_fault vmf = {
 		.vma = vma,
@@ -5508,17 +5507,12 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 
 	/*
 	 * vma_lock and hugetlb_fault_mutex must be
-	 * dropped before handling userfault.  Reacquire
-	 * after handling fault to make calling code simpler.
+	 * dropped before handling userfault.
 	 */
 	hugetlb_vma_unlock_read(vma);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	ret = handle_userfault(&vmf, reason);
-	mutex_lock(&hugetlb_fault_mutex_table[hash]);
-	hugetlb_vma_lock_read(vma);
-
-	return ret;
+	return handle_userfault(&vmf, reason);
 }
 
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
@@ -5537,6 +5531,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_page, new_pagecache_page = false;
 	bool reserve_alloc = false;
+	u32 hash = hugetlb_fault_mutex_hash(mapping, idx);
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -5547,7 +5542,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	if (is_vma_resv_set(vma, HPAGE_RESV_UNMAPPED)) {
 		pr_warn_ratelimited("PID %d killed due to inadequate hugepage pool\n",
 			   current->pid);
-		return ret;
+		goto out;
 	}
 
 	/*
@@ -5561,12 +5556,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		if (idx >= size)
 			goto out;
 		/* Check for page in userfault range */
-		if (userfaultfd_missing(vma)) {
-			ret = hugetlb_handle_userfault(vma, mapping, idx,
+		if (userfaultfd_missing(vma))
+			return hugetlb_handle_userfault(vma, mapping, idx,
 						       flags, haddr, address,
 						       VM_UFFD_MISSING);
-			goto out;
-		}
 
 		page = alloc_huge_page(vma, haddr, 0);
 		if (IS_ERR(page)) {
@@ -5634,10 +5627,9 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		if (userfaultfd_minor(vma)) {
 			unlock_page(page);
 			put_page(page);
-			ret = hugetlb_handle_userfault(vma, mapping, idx,
+			return hugetlb_handle_userfault(vma, mapping, idx,
 						       flags, haddr, address,
 						       VM_UFFD_MINOR);
-			goto out;
 		}
 	}
 
@@ -5695,6 +5687,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	unlock_page(page);
 out:
+	hugetlb_vma_unlock_read(vma);
+	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	return ret;
 
 backout:
@@ -5792,11 +5786,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	entry = huge_ptep_get(ptep);
 	/* PTE markers should be handled the same way as none pte */
-	if (huge_pte_none_mostly(entry)) {
-		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
+	if (huge_pte_none_mostly(entry))
+		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
 				      entry, flags);
-		goto out_mutex;
-	}
 
 	ret = 0;
 
-- 
2.25.1

