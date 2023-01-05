Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8A165E8E3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjAEKWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjAEKUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:20:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD85559F8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n190-20020a25dac7000000b007447d7a25e4so35872606ybf.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zYgA7vTy+UiW0jcHBjsT9jPj1JCczIw3Dv3/VC3unlc=;
        b=aZrPoex/pVw6R2bZjUd0s/eQeCQD6Z+ZR1pwJBBdpF4+ODpwC87+571DSmG52tQd2A
         huBv6LZpBuHxyiw0O3CiSCiBc811ySkiBmjVOpz7sDguClfGeqjOyal8IA+Ji11V8jkN
         bEFusYMrdUdHMUBqX7dtj5Cx+qMWmrKu+iN47FofwRZruFCBAY5cfV+BlJmz8ohPVsX3
         hreD3U4vshXW0/FmhhWMhII3bpHEdeySPmB3+xk2RkaW9C04IumqG5jIlCikAQysXd4v
         Ip9f+khY1/cJbjOG79FTa5wulnPT7jLwfHVYArewSw1+oGaupqCkA/OQmR8a7Mqa+kJj
         +N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYgA7vTy+UiW0jcHBjsT9jPj1JCczIw3Dv3/VC3unlc=;
        b=F0Om2jCRxZo/VppyAFG9F1Oo5Ba6TmrOHMQl00tPo3DhUnSb7S4SJkgV18rCXWncvm
         R9Yprnsj5NB6DQe5NUJxa5lUUx/s3xApa/kbviDVeXD2PcYGs/il7w72LHuP2HgZQ6yy
         2w4eOitr7BYec/XUWeF7luANM2QuaRat6MBsdd9djLwghbdw7qwccqL+ABn5qA8Yq2GV
         d7s4qTPmsDdWkpGSGKWnkVkKWi5vfN5uckiIc9CAD74EJYoRcauKii2vtg1K5CVd0bjQ
         o2sAdDoJZxPYwIkv+IMQi+66Q3OdiqBj2CZGIWGfxU3rMCxX1mcqEisWmdFHfuqwCcYF
         bQsw==
X-Gm-Message-State: AFqh2kq7qhxDaS+sAR+5klDgB//wEFvTjfwoQTtQ8Jn/9AZHxpSyyicy
        lHLU+O80M3pWzxtou1vyVko0hJ0PHYLFHKiY
X-Google-Smtp-Source: AMrXdXuxfUQNLilPrRGqsslWu2QZEFsqppw9mENfwOLUFmAwgaOYPQkWmXE3a1h40OvKVj2fDKV0vtvou6nlsSLw
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a0d:d454:0:b0:482:a03a:3fcd with SMTP
 id w81-20020a0dd454000000b00482a03a3fcdmr3459124ywd.99.1672913972517; Thu, 05
 Jan 2023 02:19:32 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:24 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-27-jthoughton@google.com>
Subject: [PATCH 26/46] hugetlb: add HGM support for copy_hugetlb_page_range
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

This allows fork() to work with high-granularity mappings. The page
table structure is copied such that partially mapped regions will remain
partially mapped in the same way for the new process.

A page's reference count is incremented for *each* portion of it that is
mapped in the page table. For example, if you have a PMD-mapped 1G page,
the reference count and mapcount will be incremented by 512.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 75 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 718572444a73..21a5116f509b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5106,7 +5106,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *src_vma)
 {
 	pte_t *src_pte, *dst_pte, entry;
-	struct page *ptepage;
+	struct hugetlb_pte src_hpte, dst_hpte;
+	struct page *ptepage, *hpage;
 	unsigned long addr;
 	bool cow = is_cow_mapping(src_vma->vm_flags);
 	struct hstate *h = hstate_vma(src_vma);
@@ -5126,26 +5127,34 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	} else {
 		/*
 		 * For shared mappings the vma lock must be held before
-		 * calling hugetlb_walk() in the src vma. Otherwise, the
-		 * returned ptep could go away if part of a shared pmd and
-		 * another thread calls huge_pmd_unshare.
+		 * calling hugetlb_full_walk() in the src vma. Otherwise, the
+		 * returned hpte could go away if
+		 *  - part of a shared pmd and another thread calls
+		 *  - huge_pmd_unshare, or
+		 *  - another thread collapses a high-granularity mapping.
 		 */
 		hugetlb_vma_lock_read(src_vma);
 	}
 
 	last_addr_mask = hugetlb_mask_last_page(h);
-	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
+	addr = src_vma->vm_start;
+	while (addr < src_vma->vm_end) {
 		spinlock_t *src_ptl, *dst_ptl;
-		src_pte = hugetlb_walk(src_vma, addr, sz);
-		if (!src_pte) {
-			addr |= last_addr_mask;
+		unsigned long hpte_sz;
+
+		if (hugetlb_full_walk(&src_hpte, src_vma, addr)) {
+			addr = (addr | last_addr_mask) + sz;
 			continue;
 		}
-		dst_pte = huge_pte_alloc(dst, dst_vma, addr, sz);
-		if (!dst_pte) {
-			ret = -ENOMEM;
+		ret = hugetlb_full_walk_alloc(&dst_hpte, dst_vma, addr,
+				hugetlb_pte_size(&src_hpte));
+		if (ret)
 			break;
-		}
+
+		src_pte = src_hpte.ptep;
+		dst_pte = dst_hpte.ptep;
+
+		hpte_sz = hugetlb_pte_size(&src_hpte);
 
 		/*
 		 * If the pagetables are shared don't copy or take references.
@@ -5155,13 +5164,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		 * another vma. So page_count of ptep page is checked instead
 		 * to reliably determine whether pte is shared.
 		 */
-		if (page_count(virt_to_page(dst_pte)) > 1) {
-			addr |= last_addr_mask;
+		if (hugetlb_pte_size(&dst_hpte) == sz &&
+		    page_count(virt_to_page(dst_pte)) > 1) {
+			addr = (addr | last_addr_mask) + sz;
 			continue;
 		}
 
-		dst_ptl = huge_pte_lock(h, dst, dst_pte);
-		src_ptl = huge_pte_lockptr(huge_page_shift(h), src, src_pte);
+		dst_ptl = hugetlb_pte_lock(&dst_hpte);
+		src_ptl = hugetlb_pte_lockptr(&src_hpte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry = huge_ptep_get(src_pte);
 again:
@@ -5205,10 +5215,15 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 */
 			if (userfaultfd_wp(dst_vma))
 				set_huge_pte_at(dst, addr, dst_pte, entry);
+		} else if (!hugetlb_pte_present_leaf(&src_hpte, entry)) {
+			/* Retry the walk. */
+			spin_unlock(src_ptl);
+			spin_unlock(dst_ptl);
+			continue;
 		} else {
-			entry = huge_ptep_get(src_pte);
 			ptepage = pte_page(entry);
-			get_page(ptepage);
+			hpage = compound_head(ptepage);
+			get_page(hpage);
 
 			/*
 			 * Failing to duplicate the anon rmap is a rare case
@@ -5220,25 +5235,31 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * need to be without the pgtable locks since we could
 			 * sleep during the process.
 			 */
-			if (!PageAnon(ptepage)) {
-				page_dup_file_rmap(ptepage, true);
-			} else if (page_try_dup_anon_rmap(ptepage, true,
+			if (!PageAnon(hpage)) {
+				page_dup_file_rmap(hpage, true);
+			} else if (page_try_dup_anon_rmap(hpage, true,
 							  src_vma)) {
 				pte_t src_pte_old = entry;
 				struct page *new;
 
+				if (hugetlb_pte_size(&src_hpte) != sz) {
+					put_page(hpage);
+					ret = -EINVAL;
+					break;
+				}
+
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				/* Do not use reserve as it's private owned */
 				new = alloc_huge_page(dst_vma, addr, 1);
 				if (IS_ERR(new)) {
-					put_page(ptepage);
+					put_page(hpage);
 					ret = PTR_ERR(new);
 					break;
 				}
-				copy_user_huge_page(new, ptepage, addr, dst_vma,
+				copy_user_huge_page(new, hpage, addr, dst_vma,
 						    npages);
-				put_page(ptepage);
+				put_page(hpage);
 
 				/* Install the new huge page if src pte stable */
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
@@ -5256,6 +5277,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				hugetlb_install_page(dst_vma, dst_pte, addr, new);
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
+				addr += hugetlb_pte_size(&src_hpte);
 				continue;
 			}
 
@@ -5272,10 +5294,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			}
 
 			set_huge_pte_at(dst, addr, dst_pte, entry);
-			hugetlb_count_add(npages, dst);
+			hugetlb_count_add(
+					hugetlb_pte_size(&dst_hpte) / PAGE_SIZE,
+					dst);
 		}
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
+		addr += hugetlb_pte_size(&src_hpte);
 	}
 
 	if (cow) {
-- 
2.39.0.314.g84b9a713c41-goog

