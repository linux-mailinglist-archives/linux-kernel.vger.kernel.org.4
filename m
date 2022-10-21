Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B348D607C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiJUQjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiJUQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:21 -0400
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE122892D6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:40 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id 124-20020a671082000000b0039b07671c7aso1059586vsq.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5VzrQrgnFUgUGieOOqXon7u8Uw/+xZD2vuQWAKlM0E=;
        b=F0/10ArYlwy8KqPJwKkvyO4Kn3FHV6wsoqD58NMFi4c3hrL91LKlK8QvSpR/Gi5jq7
         8V938nHwYuBhcZy87Ak4geIo2bLTgzyOZnSBMzMsfaBHlybcG/7ybv/sJK8kQ71WN5JR
         ekEzvlX4a51pOlaarCmmZvNB7g071LCPtfavN9axUqYDW7ZwfJDHPNjILkcheYku32by
         t5iyhpbam+p3mqmNvdhDtz//VOQktYqdwwXSfb6PYrkvtME/W09eAN3rCIPNMTaIKzzZ
         8CK1TCpdG1tv5c3OF14+w2xwlejiF31gunYGANRvHbfBrQU2x5LoJVQkfQShQHGIvQ+H
         RCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5VzrQrgnFUgUGieOOqXon7u8Uw/+xZD2vuQWAKlM0E=;
        b=l2yMMrlsWRP0H88oULs4XspdT1FAIIyWTpLXCEx/gJ1CzHDtScnWWYgod0GzsLmY57
         kq52ZzlGRHzBWuBTdNBNQrMSRxzVQb/YI8Gd1MAvxguZfTJe48eDb42msWF6wZN+Pq05
         aXjYiHFcDf7QOwBdIO8M4UgbHOMDLxzx0kp5Xc9Tn3LfdOzPAmRhCg/ezyNuHssXqK+U
         rD3/AjZqMxXd3h9MVAV849mzoSuz7B6vOekp9gWp/HjT1EDPKoLM6Xv8597OD+P9VqZG
         IOg6W9SaTOfZxB/Nd2Kn2hCzYmrLzIjH4AAZaUkbuIMXoB1Ww8f1jgQR3vHORyK3A2XQ
         7zYg==
X-Gm-Message-State: ACrzQf1tmS4PDi2m5Wni7oW7DSKF16lU5qWdZTlJ0sTEEYzBeT+0jaeI
        jLOoRjaACT1nxjlECO5+BDQWYA8epS+nYyGi
X-Google-Smtp-Source: AMsMyM6h9KKXHsBwL7ULSdyiMpqDrdyzMiXVNXvrxTdzSehgColYTf8RW41Ifwt+YRo98GLNYVPintVIlqxk7ky0
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a1f:f288:0:b0:3ab:a997:901a with SMTP
 id q130-20020a1ff288000000b003aba997901amr12715913vkh.19.1666370259573; Fri,
 21 Oct 2022 09:37:39 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:41 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-26-jthoughton@google.com>
Subject: [RFC PATCH v2 25/47] hugetlb: add HGM support for copy_hugetlb_page_range
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
 mm/hugetlb.c | 81 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5783a8307a77..7d692907cbf3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4946,7 +4946,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *src_vma)
 {
 	pte_t *src_pte, *dst_pte, entry;
-	struct page *ptepage;
+	struct hugetlb_pte src_hpte, dst_hpte;
+	struct page *ptepage, *hpage;
 	unsigned long addr;
 	bool cow = is_cow_mapping(src_vma->vm_flags);
 	struct hstate *h = hstate_vma(src_vma);
@@ -4956,6 +4957,16 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	unsigned long last_addr_mask;
 	int ret = 0;
 
+	if (hugetlb_hgm_enabled(src_vma)) {
+		/*
+		 * src_vma might have high-granularity PTEs, and dst_vma will
+		 * need to copy those.
+		 */
+		ret = enable_hugetlb_hgm(dst_vma);
+		if (ret)
+			return ret;
+	}
+
 	if (cow) {
 		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_vma, src,
 					src_vma->vm_start,
@@ -4967,18 +4978,22 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		/*
 		 * For shared mappings the vma lock must be held before
 		 * calling huge_pte_offset in the src vma. Otherwise, the
-		 * returned ptep could go away if part of a shared pmd and
-		 * another thread calls huge_pmd_unshare.
+		 * returned ptep could go away if
+		 *  - part of a shared pmd and another thread calls
+		 *    huge_pmd_unshare, or
+		 *  - another thread collapses a high-granularity mapping.
 		 */
 		hugetlb_vma_lock_read(src_vma);
 	}
 
 	last_addr_mask = hugetlb_mask_last_page(h);
-	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
+	addr = src_vma->vm_start;
+	while (addr < src_vma->vm_end) {
 		spinlock_t *src_ptl, *dst_ptl;
+		unsigned long hpte_sz;
 		src_pte = huge_pte_offset(src, addr, sz);
 		if (!src_pte) {
-			addr |= last_addr_mask;
+			addr = (addr | last_addr_mask) + sz;
 			continue;
 		}
 		dst_pte = huge_pte_alloc(dst, dst_vma, addr, sz);
@@ -4987,6 +5002,26 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			break;
 		}
 
+		hugetlb_pte_populate(&src_hpte, src_pte, huge_page_shift(h),
+				hpage_size_to_level(huge_page_size(h)));
+		hugetlb_pte_populate(&dst_hpte, dst_pte, huge_page_shift(h),
+				hpage_size_to_level(huge_page_size(h)));
+
+		if (hugetlb_hgm_enabled(src_vma)) {
+			hugetlb_hgm_walk(src, src_vma, &src_hpte, addr,
+				      PAGE_SIZE, /*stop_at_none=*/true);
+			ret = hugetlb_hgm_walk(dst, dst_vma, &dst_hpte, addr,
+					hugetlb_pte_size(&src_hpte),
+					/*stop_at_none=*/false);
+			if (ret)
+				break;
+
+			src_pte = src_hpte.ptep;
+			dst_pte = dst_hpte.ptep;
+		}
+
+		hpte_sz = hugetlb_pte_size(&src_hpte);
+
 		/*
 		 * If the pagetables are shared don't copy or take references.
 		 *
@@ -4996,12 +5031,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		 * to reliably determine whether pte is shared.
 		 */
 		if (page_count(virt_to_page(dst_pte)) > 1) {
-			addr |= last_addr_mask;
+			addr = (addr | last_addr_mask) + sz;
 			continue;
 		}
 
-		dst_ptl = huge_pte_lock(h, dst, dst_pte);
-		src_ptl = huge_pte_lockptr(huge_page_shift(h), src, src_pte);
+		dst_ptl = hugetlb_pte_lock(dst, &dst_hpte);
+		src_ptl = hugetlb_pte_lockptr(src, &src_hpte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry = huge_ptep_get(src_pte);
 again:
@@ -5042,10 +5077,15 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -5058,24 +5098,29 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * sleep during the process.
 			 */
 			if (!PageAnon(ptepage)) {
-				page_dup_file_rmap(ptepage, true);
-			} else if (page_try_dup_anon_rmap(ptepage, true,
+				page_dup_file_rmap(hpage, true);
+			} else if (page_try_dup_anon_rmap(hpage, true,
 							  src_vma)) {
 				pte_t src_pte_old = entry;
 				struct page *new;
 
+				if (hugetlb_hgm_enabled(src_vma)) {
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
@@ -5093,6 +5138,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				hugetlb_install_page(dst_vma, dst_pte, addr, new);
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
+				addr += hugetlb_pte_size(&src_hpte);
 				continue;
 			}
 
@@ -5109,10 +5155,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
2.38.0.135.g90850a2211-goog

