Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96EA69B6CE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjBRAaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjBRA3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4426BDF7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o14-20020a25810e000000b0095d2ada3d26so1816863ybk.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+tSPnCkiv+4IG9wAhN3nJiAPBMdRQ7SRBdMiKhfpNi8=;
        b=tIIvrAMRq+3HXFL5rW8Lh7/gCEy2v7mBrYIzZnmVImsr6rHLUrJkHvESEkKIKnP2HA
         ETKeSXB6gqBCteIJ68LmS1NgcW8NqFCp4N0/v9eSUb5HNjRwRpHF7O8+s4KVElrP4dI4
         Zjvu8aQ6Opgdsvu/yAqPR0lJhv574KFnXRf4LH++FsPR7lEug2Wl9pAFrHWFu0GZq42N
         Vy0SevF4NJaR0vgAKFGoEdFDQKl01vAhAwbwFzmxhSRiOGi2HQEkv51SNB+xC5ZLD4Tm
         F1M7gD13G/x1ohwgsWJjFr2DhGgQpTZDe/17U0ZGQKm1J8xgGRPTne6Pgw+hiXkqL9v1
         Pi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tSPnCkiv+4IG9wAhN3nJiAPBMdRQ7SRBdMiKhfpNi8=;
        b=2jPgZkFUViozVZ5jdoVD8eX8E9BfxcdbQBBu/MRq9Eqythmw03kh5CbbaoQqNVOB2I
         EQyOXwNu+dgDhgYOTsp/suhR8X0COTvOll1FKwOC0Ci4Wn/Q6RyHPyNs0rm7cDD8FUs8
         DMgcjsBkbouiTbgTl/gl/HACx4thgm2UClCffL0uql1GE6e7KLLO9be3luNmB3Vx7nCW
         ACFcxS/rQAcVvramB9TxP2scXwTnyQR+kHVlbbcpX+A/Gffqc3kZ3LZwu6dlqx3mxE6h
         /veBKvXwfVgfOAtFepMixUKyOkE8fF0moZPpUyJvluONW+bnRLaRkfqRBCju715EYtgV
         oV+A==
X-Gm-Message-State: AO0yUKXiGhVRyion8IEAQKlTv/bwfwq3WeQYtvMRgoPnkEnk5YJrfPKg
        fdeBX05Qqqo9IXtLmkuA80akt2EywcZOz1Kw
X-Google-Smtp-Source: AK7set8J1uc8tp8/hEWZItT5UxOZqGWxRV48NY6+J5XvomWx6cLnGWfxbZYO/6vWe6Thx7C5x8jbEtY4jfNJnPC8
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:46d6:0:b0:52e:e3a8:d0b9 with SMTP
 id t205-20020a8146d6000000b0052ee3a8d0b9mr1575870ywa.509.1676680141961; Fri,
 17 Feb 2023 16:29:01 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:52 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-20-jthoughton@google.com>
Subject: [PATCH v2 19/46] hugetlb: add HGM support to hugetlb_change_protection
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ecf1a28dbaaa..7321c6602d6f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6900,15 +6900,15 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long start = address;
-	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	long pages = 0, psize = huge_page_size(h);
+	long base_pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
+	struct hugetlb_pte hpte;
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -6926,39 +6926,43 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	last_addr_mask = hugetlb_mask_last_page(h);
-	for (; address < end; address += psize) {
+	while (address < end) {
 		spinlock_t *ptl;
-		ptep = hugetlb_walk(vma, address, psize);
-		if (!ptep) {
+		if (hugetlb_full_walk(&hpte, vma, address)) {
 			if (!uffd_wp) {
-				address |= last_addr_mask;
+				address = (address | last_addr_mask) + psize;
 				continue;
 			}
 			/*
 			 * Userfaultfd wr-protect requires pgtable
 			 * pre-allocations to install pte markers.
+			 *
+			 * Use hugetlb_full_walk_alloc to allocate
+			 * the hstate-level PTE.
 			 */
-			ptep = huge_pte_alloc(mm, vma, address, psize);
-			if (!ptep) {
-				pages = -ENOMEM;
+			if (hugetlb_full_walk_alloc(&hpte, vma,
+						    address, psize)) {
+				base_pages = -ENOMEM;
 				break;
 			}
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
@@ -6974,7 +6978,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 					entry = make_readable_migration_entry(
 								swp_offset(entry));
 				newpte = swp_entry_to_pte(entry);
-				pages++;
+				base_pages += hugetlb_pte_size(&hpte) / PAGE_SIZE;
 			}
 
 			if (uffd_wp)
@@ -6982,34 +6986,49 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
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
+
+			if (unlikely(!hugetlb_pte_present_leaf(&hpte, pte))) {
+				/*
+				 * Someone split the PTE from under us, so retry
+				 * the walk,
+				 */
+				spin_unlock(ptl);
+				continue;
+			}
 
-			old_pte = huge_ptep_modify_prot_start(vma, address, ptep);
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
@@ -7032,7 +7051,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 	hugetlb_vma_unlock_write(vma);
 	mmu_notifier_invalidate_range_end(&range);
 
-	return pages > 0 ? (pages << h->order) : pages;
+	return base_pages;
 }
 
 /* Return true if reservation was successful, false otherwise.  */
-- 
2.39.2.637.g21b0678d19-goog

