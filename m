Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B72C65E8D8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjAEKVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjAEKT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:57 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88972559C8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:23 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-482d3bf0266so243517007b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BXNpcEQhxfziaYYe5JKwye/WpzbaEjEGrnqAXOzwqC4=;
        b=V/Jfcp7ceK8WRpWk4kcE61X4AiMfGhPqZ8JiYFyiLAHzV69wvdHEzn4wPN7LIZk4CE
         bihTqKci5bcgrW5kSTMvQE87sTXKrY8emKYYInvNKBClO/fvmBJhy9VMt8s5XVUBJAvy
         cjyveafAHg6xtMfAOLygapq7E3ypRwoV1bqQRPlA4hyPfPYlp0LcL9Go83tyAqpX/AKd
         +fsGh7mpBN3witwaQC4bf1miNUfGCnDqMY9vU+x/X6z3JTCZFv94ilBZkurucEqHB8a0
         FYbuUHfSwENyyzNyQOZRtyZ3QM703eKUjEsRRXQp4MeRqBusXwkmY1T3GybPKQ9WLMUE
         ioXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXNpcEQhxfziaYYe5JKwye/WpzbaEjEGrnqAXOzwqC4=;
        b=HkU6CTGZdKhddrlq3MdC5mg6hzPeTX/CGt5Xb18Tkv9Kjs8lCmlO+MWYCGbiVkC59g
         T5ZODGrrEhMxmq/sF7jBoiCKLVHAichh9Yf37zKu9kIPpr3gzxjo8Cr5nvUuly5HtdbK
         xtAih13vczDveKvcvQYHUVxmLGGBNf9KocbHW+5/l1pbrEq9aBCiejmMiWqCBn8T5mIB
         rwKR9SQTlNWzLP7jWCVz05l0cyXmjI/hayL2XgARpx8wc1YPY1ClADeFRS/0cMUaSRJh
         R/zdE0Dx8wdnxeoCFxWQ9ieR9EB8xFWuoUPSYmoqM8gv9hRZKjOFCF2SPzrkdJpKjEso
         Vmow==
X-Gm-Message-State: AFqh2kqsiuPz2jlTfCmeSe2yPHjjdBZXM8Dzg7PExl/Ed+X9gDelhkHZ
        UMMlx6a6Py9k4wR+byvectFe0ODnx/6pM4Iv
X-Google-Smtp-Source: AMrXdXupC7GphFewk1Xzzmqq7XH6NNJJ3a9/fKMNJsKu0/gJPDtKjqvWd7TDuXpuJuJCOPC8zIthAjF3AmrDJE5r
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:c50f:0:b0:6fc:b841:cf42 with SMTP
 id v15-20020a25c50f000000b006fcb841cf42mr5162375ybe.372.1672913963216; Thu,
 05 Jan 2023 02:19:23 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:17 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-20-jthoughton@google.com>
Subject: [PATCH 19/46] hugetlb: add HGM support for follow_hugetlb_page
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables high-granularity mapping support in GUP.

In case it is confusing, pfn_offset is the offset (in PAGE_SIZE units)
that vaddr points to within the subpage that hpte points to.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 59 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 73672d806172..30fea414d9ee 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6532,11 +6532,9 @@ static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 }
 
 static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
-					       unsigned int flags, pte_t *pte,
+					       unsigned int flags, pte_t pteval,
 					       bool *unshare)
 {
-	pte_t pteval = huge_ptep_get(pte);
-
 	*unshare = false;
 	if (is_swap_pte(pteval))
 		return true;
@@ -6611,11 +6609,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	int err = -EFAULT, refs;
 
 	while (vaddr < vma->vm_end && remainder) {
-		pte_t *pte;
+		pte_t *ptep, pte;
 		spinlock_t *ptl = NULL;
 		bool unshare = false;
 		int absent;
-		struct page *page;
+		unsigned long pages_per_hpte;
+		struct page *page, *subpage;
+		struct hugetlb_pte hpte;
 
 		/*
 		 * If we have a pending SIGKILL, don't keep faulting pages and
@@ -6632,13 +6632,19 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * each hugepage.  We have to make sure we get the
 		 * first, for the page indexing below to work.
 		 *
-		 * Note that page table lock is not held when pte is null.
+		 * hugetlb_full_walk will mask the address appropriately.
+		 *
+		 * Note that page table lock is not held when ptep is null.
 		 */
-		pte = hugetlb_walk(vma, vaddr & huge_page_mask(h),
-				   huge_page_size(h));
-		if (pte)
-			ptl = huge_pte_lock(h, mm, pte);
-		absent = !pte || huge_pte_none(huge_ptep_get(pte));
+		if (hugetlb_full_walk(&hpte, vma, vaddr)) {
+			ptep = NULL;
+			absent = true;
+		} else {
+			ptl = hugetlb_pte_lock(&hpte);
+			ptep = hpte.ptep;
+			pte = huge_ptep_get(ptep);
+			absent = huge_pte_none(pte);
+		}
 
 		/*
 		 * When coredumping, it suits get_dump_page if we just return
@@ -6649,13 +6655,20 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		if (absent && (flags & FOLL_DUMP) &&
 		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
-			if (pte)
+			if (ptep)
 				spin_unlock(ptl);
 			hugetlb_vma_unlock_read(vma);
 			remainder = 0;
 			break;
 		}
 
+		if (!absent && pte_present(pte) &&
+				!hugetlb_pte_present_leaf(&hpte, pte)) {
+			/* We raced with someone splitting the PTE, so retry. */
+			spin_unlock(ptl);
+			continue;
+		}
+
 		/*
 		 * We need call hugetlb_fault for both hugepages under migration
 		 * (in which case hugetlb_fault waits for the migration,) and
@@ -6671,7 +6684,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			vm_fault_t ret;
 			unsigned int fault_flags = 0;
 
-			if (pte)
+			if (ptep)
 				spin_unlock(ptl);
 			hugetlb_vma_unlock_read(vma);
 
@@ -6720,8 +6733,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			continue;
 		}
 
-		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
-		page = pte_page(huge_ptep_get(pte));
+		pfn_offset = (vaddr & ~hugetlb_pte_mask(&hpte)) >> PAGE_SHIFT;
+		subpage = pte_page(pte);
+		pages_per_hpte = hugetlb_pte_size(&hpte) / PAGE_SIZE;
+		page = compound_head(subpage);
 
 		VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 			       !PageAnonExclusive(page), page);
@@ -6731,22 +6746,22 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * and skip the same_page loop below.
 		 */
 		if (!pages && !vmas && !pfn_offset &&
-		    (vaddr + huge_page_size(h) < vma->vm_end) &&
-		    (remainder >= pages_per_huge_page(h))) {
-			vaddr += huge_page_size(h);
-			remainder -= pages_per_huge_page(h);
-			i += pages_per_huge_page(h);
+		    (vaddr + pages_per_hpte < vma->vm_end) &&
+		    (remainder >= pages_per_hpte)) {
+			vaddr += pages_per_hpte;
+			remainder -= pages_per_hpte;
+			i += pages_per_hpte;
 			spin_unlock(ptl);
 			hugetlb_vma_unlock_read(vma);
 			continue;
 		}
 
 		/* vaddr may not be aligned to PAGE_SIZE */
-		refs = min3(pages_per_huge_page(h) - pfn_offset, remainder,
+		refs = min3(pages_per_hpte - pfn_offset, remainder,
 		    (vma->vm_end - ALIGN_DOWN(vaddr, PAGE_SIZE)) >> PAGE_SHIFT);
 
 		if (pages || vmas)
-			record_subpages_vmas(nth_page(page, pfn_offset),
+			record_subpages_vmas(nth_page(subpage, pfn_offset),
 					     vma, refs,
 					     likely(pages) ? pages + i : NULL,
 					     vmas ? vmas + i : NULL);
-- 
2.39.0.314.g84b9a713c41-goog

