Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AAD65E8D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjAEKVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjAEKT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A63559C2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y66-20020a25c845000000b00733b5049b6fso36235986ybf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lp3NkrzzsDy9ah3gYP7Di6ebFhCh/hI0r9EhbhKs3qA=;
        b=gcqO4fumRx0zgQZPFIbbvhj2RDn3uzOiEjenn5HSn/KoUqOlS6cvCBPlQZqdnokXAv
         yuBgbgVdZ68dWkcgWO302Mw9PxijLJ23xw6JxoY2ObqFFf3QxAWs1BdbmgNwKsp6kjEu
         8GFqq0LZlvusyfldGmkc6FfTZZ/RbptJV8SUrxL5hGv7ZFxVYZY2rxA32ezUN4HQKndZ
         n4NkO1TfQAKi7YjlKvn942sD0+vyg8DNgNqttkJLun2/ieyUyjjedHWOdKf/Toc3RDXd
         NYkM9a5g7CgZdcmSy/hZ0BvTwMl6CAeI0KwuHwV/HKzTEVBfjxeq4ELE0Z8GmCd1b9Ya
         6emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lp3NkrzzsDy9ah3gYP7Di6ebFhCh/hI0r9EhbhKs3qA=;
        b=R8SICv1wYg3x3KFPJulWGMRhG124aXwkCJfttKj8x6001atFQHIAFFnfjSoFWLBE4Q
         HONNi0Hny5r5CpD125qflLBxc2dL0BP6WHOPRK6LXM2R3G1Y6/00MQIuIjTLVcQ6UhxV
         idFfCZYPj2qRkigrFOEnM69TNDZjrpEHSEeeSmuUWq/bjuCuKbUp82JyNywbfArniG7S
         GueWfLjmHGLa7o8R1dtDZ/4FvMD4e4iC42Tr5ALwS7pzxRgganTmbd9BOUBdK6oKWgtd
         +3DprPyV8GnEEkJqR5D6JlU95yTj2GkSFDimvPHBchNF70rZFc5gkAisOQS86Xcpg2MO
         M9jA==
X-Gm-Message-State: AFqh2krCTcQG4vr4N8fM/breQyUs39o1Rpdm9H9t03bbJFij4/2svi0d
        9JQ9RZY9k6qS3h6Ua2u45Z9TiYUO+FIMIp7y
X-Google-Smtp-Source: AMrXdXtIJM/w1a8XxNEazXxZ6FOVAPFAuY6o16gkUOQyGBaWZ7iAlnjKjopmkNnTtIe8ZRhqObJ/lwIhr3EKSgQ+
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:13c2:0:b0:716:10cb:dc2e with SMTP
 id 185-20020a2513c2000000b0071610cbdc2emr6990557ybt.530.1672913962037; Thu,
 05 Jan 2023 02:19:22 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:16 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-19-jthoughton@google.com>
Subject: [PATCH 18/46] hugetlb: add HGM support for hugetlb_change_protection
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
 mm/hugetlb.c | 59 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dfd6c1491ac3..73672d806172 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6798,15 +6798,15 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
@@ -6824,28 +6824,30 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	last_addr_mask = hugetlb_mask_last_page(h);
-	for (; address < end; address += psize) {
+	while (address < end) {
 		spinlock_t *ptl;
-		ptep = hugetlb_walk(vma, address, psize);
-		if (!ptep) {
-			address |= last_addr_mask;
+
+		if (hugetlb_full_walk(&hpte, vma, address)) {
+			address = (address | last_addr_mask) + psize;
 			continue;
 		}
-		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, address, ptep)) {
+
+		ptl = hugetlb_pte_lock(&hpte);
+		if (hugetlb_pte_size(&hpte) == psize &&
+		    huge_pmd_unshare(mm, vma, address, hpte.ptep)) {
 			/*
 			 * When uffd-wp is enabled on the vma, unshare
 			 * shouldn't happen at all.  Warn about it if it
 			 * happened due to some reason.
 			 */
 			WARN_ON_ONCE(uffd_wp || uffd_wp_resolve);
-			pages++;
+			base_pages += psize / PAGE_SIZE;
 			spin_unlock(ptl);
 			shared_pmd = true;
-			address |= last_addr_mask;
+			address = (address | last_addr_mask) + psize;
 			continue;
 		}
-		pte = huge_ptep_get(ptep);
+		pte = huge_ptep_get(hpte.ptep);
 		if (unlikely(is_hugetlb_entry_hwpoisoned(pte))) {
 			/* Nothing to do. */
 		} else if (unlikely(is_hugetlb_entry_migration(pte))) {
@@ -6861,7 +6863,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 					entry = make_readable_migration_entry(
 								swp_offset(entry));
 				newpte = swp_entry_to_pte(entry);
-				pages++;
+				base_pages += hugetlb_pte_size(&hpte) / PAGE_SIZE;
 			}
 
 			if (uffd_wp)
@@ -6869,34 +6871,49 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			else if (uffd_wp_resolve)
 				newpte = pte_swp_clear_uffd_wp(newpte);
 			if (!pte_same(pte, newpte))
-				set_huge_pte_at(mm, address, ptep, newpte);
+				set_huge_pte_at(mm, address, hpte.ptep, newpte);
 		} else if (unlikely(is_pte_marker(pte))) {
 			/* No other markers apply for now. */
 			WARN_ON_ONCE(!pte_marker_uffd_wp(pte));
 			if (uffd_wp_resolve)
 				/* Safe to modify directly (non-present->none). */
-				huge_pte_clear(mm, address, ptep, psize);
+				huge_pte_clear(mm, address, hpte.ptep,
+						hugetlb_pte_size(&hpte));
 		} else if (!huge_pte_none(pte)) {
 			pte_t old_pte;
-			unsigned int shift = huge_page_shift(hstate_vma(vma));
+			unsigned int shift = hpte.shift;
 
-			old_pte = huge_ptep_modify_prot_start(vma, address, ptep);
+			if (unlikely(!hugetlb_pte_present_leaf(&hpte, pte))) {
+				/*
+				 * Someone split the PTE from under us, so retry
+				 * the walk,
+				 */
+				spin_unlock(ptl);
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
 				pte = huge_pte_mkuffd_wp(pte);
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
 				/* Safe to modify directly (none->non-present). */
-				set_huge_pte_at(mm, address, ptep,
+				set_huge_pte_at(mm, address, hpte.ptep,
 						make_pte_marker(PTE_MARKER_UFFD_WP));
 		}
 		spin_unlock(ptl);
+		address += hugetlb_pte_size(&hpte);
 	}
 	/*
 	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare
@@ -6919,7 +6936,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	hugetlb_vma_unlock_write(vma);
 	mmu_notifier_invalidate_range_end(&range);
 
-	return pages << h->order;
+	return base_pages;
 }
 
 /* Return true if reservation was successful, false otherwise.  */
-- 
2.39.0.314.g84b9a713c41-goog

