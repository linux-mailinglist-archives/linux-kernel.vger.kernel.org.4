Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53476607C73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiJUQi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiJUQiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1537A2852BF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y65-20020a25c844000000b006bb773548d5so3743999ybf.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0hHBKIF8uIcOgxC/q0OXlvofpo6KadXA1H0O4ltk1Y=;
        b=AHId1r8qc07ghUEt5/Ex2Zf0W0zSQGOUnXdHCxNiJR1Hno1KO2tg3IaYi5fsBFFREt
         zaTPG3ZOZ7ZDI5SYZUSdd164/SBx2RNgUpq7SyZUqrxObCinLqY5HPhh4EIS39CFsVS9
         CAn3ANMOBawas/OIPX5suHRWyjuMGO9l7g4fyyzNwadwFTopQQE0DuLsY9+NrFeWg5Jp
         XA17TZNaMI18gkKs5ImobgIPXu4MoBCgWZQKQetYF2kcQudpcNWu4meOa0LoiWW9Y37P
         EB6D21RUxMU62JbTdgEoQX2uHO4k4jpr8V5zyAH7bZhv3mCQ5m7YGVKOsgczQDIKG0Ut
         QxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0hHBKIF8uIcOgxC/q0OXlvofpo6KadXA1H0O4ltk1Y=;
        b=gGiKvW4yfmuqjOqvqJMqQkSospW5ebCqBPjG6i/HbkO+sR6cDD+fllx6aryCdy35CE
         cfb4xdNYkH4WF55R7/RByqtIfvLBNzdsig7dC42t7z9Ifuvgex6BXelY9Ljlyf8FX9qc
         yeb4/Qkl86mUlunrYPjpBXjG0K+G5KwLu5cS32cst4+qskJVEMuVrefFt5EkFuodlQxL
         KNdOyHh147vXPs6qpe/UIcRrY9EFgUiPqsxzl/p7Cso1yAASvorokwA1dRucDkPKw1ec
         weDqkj6TZtgZaB+/LioGiu29IwziiYCM0m457bNfn7rPZsYPIv+w4mvSQpCX7wv+hSOr
         YZTg==
X-Gm-Message-State: ACrzQf2vYXoh2aZ5dAZ5e1dd0PUQGBEZgNX5UIx/EeIuOjYYrntXht65
        n4Q79NCvltOK18U9hss2qbhmq9LlluAg6KN2
X-Google-Smtp-Source: AMsMyM7nODxEiDN1Wi5inkQKcjcQQAwFn793cgLw4B+EMkRaGKkCeMDbET3p13SOVpqGZZeaUP7OxVoC63X5F8f7
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a0d:c5c4:0:b0:34a:7ab0:7b29 with SMTP
 id h187-20020a0dc5c4000000b0034a7ab07b29mr18365233ywd.294.1666370252562; Fri,
 21 Oct 2022 09:37:32 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:33 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-18-jthoughton@google.com>
Subject: [RFC PATCH v2 17/47] hugetlb: make hugetlb_change_protection
 compatible with HGM
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

The main change here is to do a high-granularity walk and pulling the
shift from the walk (not from the hstate).

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 65 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 227150c25763..2d096cef53cd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6654,15 +6654,15 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long start = address;
-	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0, psize = huge_page_size(h);
+	unsigned long base_pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
+	struct hugetlb_pte hpte;
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -6680,31 +6680,38 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	last_addr_mask = hugetlb_mask_last_page(h);
-	for (; address < end; address += psize) {
+	while (address < end) {
 		spinlock_t *ptl;
-		ptep = huge_pte_offset(mm, address, psize);
+		pte_t *ptep = huge_pte_offset(mm, address, psize);
+
 		if (!ptep) {
 			address |= last_addr_mask;
+			address += huge_page_size(h);
 			continue;
 		}
-		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, address, ptep)) {
+		hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h),
+				hpage_size_to_level(psize));
+		hugetlb_hgm_walk(mm, vma, &hpte, address, PAGE_SIZE,
+					/*stop_at_none=*/true);
+
+		ptl = hugetlb_pte_lock(mm, &hpte);
+		if (huge_pmd_unshare(mm, vma, address, hpte.ptep)) {
 			/*
 			 * When uffd-wp is enabled on the vma, unshare
 			 * shouldn't happen at all.  Warn about it if it
 			 * happened due to some reason.
 			 */
 			WARN_ON_ONCE(uffd_wp || uffd_wp_resolve);
-			pages++;
+			base_pages += hugetlb_pte_size(&hpte) / PAGE_SIZE;
 			spin_unlock(ptl);
 			shared_pmd = true;
 			address |= last_addr_mask;
-			continue;
+			goto next_hpte;
 		}
-		pte = huge_ptep_get(ptep);
+		pte = huge_ptep_get(hpte.ptep);
 		if (unlikely(is_hugetlb_entry_hwpoisoned(pte))) {
 			spin_unlock(ptl);
-			continue;
+			goto next_hpte;
 		}
 		if (unlikely(is_hugetlb_entry_migration(pte))) {
 			swp_entry_t entry = pte_to_swp_entry(pte);
@@ -6724,11 +6731,11 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 					newpte = pte_swp_mkuffd_wp(newpte);
 				else if (uffd_wp_resolve)
 					newpte = pte_swp_clear_uffd_wp(newpte);
-				set_huge_pte_at(mm, address, ptep, newpte);
-				pages++;
+				set_huge_pte_at(mm, address, hpte.ptep, newpte);
+				base_pages += hugetlb_pte_size(&hpte) / PAGE_SIZE;
 			}
 			spin_unlock(ptl);
-			continue;
+			goto next_hpte;
 		}
 		if (unlikely(pte_marker_uffd_wp(pte))) {
 			/*
@@ -6736,21 +6743,37 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			 * no need for huge_ptep_modify_prot_start/commit().
 			 */
 			if (uffd_wp_resolve)
-				huge_pte_clear(mm, address, ptep, psize);
+				huge_pte_clear(mm, address, hpte.ptep,
+						hugetlb_pte_size(&hpte));
 		}
 		if (!huge_pte_none(pte)) {
 			pte_t old_pte;
-			unsigned int shift = huge_page_shift(hstate_vma(vma));
+			unsigned int shift = hpte.shift;
 
-			old_pte = huge_ptep_modify_prot_start(vma, address, ptep);
+			/*
+			 * Because we are holding the VMA lock for writing, pte
+			 * will always be a leaf. WARN if it is not.
+			 */
+			if (unlikely(!hugetlb_pte_present_leaf(&hpte, pte))) {
+				spin_unlock(ptl);
+				WARN_ONCE(1, "Unexpected non-leaf PTE: ptep:%p, address:0x%lx\n",
+					     hpte.ptep, address);
+				continue;
+			}
+
+			old_pte = huge_ptep_modify_prot_start(
+					vma, address, hpte.ptep);
 			pte = huge_pte_modify(old_pte, newprot);
-			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
+			pte = arch_make_huge_pte(
+					pte, shift, vma->vm_flags);
 			if (uffd_wp)
 				pte = huge_pte_mkuffd_wp(huge_pte_wrprotect(pte));
 			else if (uffd_wp_resolve)
 				pte = huge_pte_clear_uffd_wp(pte);
-			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
-			pages++;
+			huge_ptep_modify_prot_commit(
+					vma, address, hpte.ptep,
+					old_pte, pte);
+			base_pages += hugetlb_pte_size(&hpte) / PAGE_SIZE;
 		} else {
 			/* None pte */
 			if (unlikely(uffd_wp))
@@ -6759,6 +6782,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 						make_pte_marker(PTE_MARKER_UFFD_WP));
 		}
 		spin_unlock(ptl);
+next_hpte:
+		address += hugetlb_pte_size(&hpte);
 	}
 	/*
 	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare
@@ -6781,7 +6806,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	hugetlb_vma_unlock_write(vma);
 	mmu_notifier_invalidate_range_end(&range);
 
-	return pages << h->order;
+	return base_pages;
 }
 
 /* Return true if reservation was successful, false otherwise.  */
-- 
2.38.0.135.g90850a2211-goog

