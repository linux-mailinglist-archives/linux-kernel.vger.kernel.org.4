Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562E972EE62
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbjFMVzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbjFMVzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC63A1BDC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686693260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/X3bGqn1q+zHUVNMkc4k9dYCbdcixuWgARgx8VaUnYY=;
        b=DrjKZY1QVUNpXUpJtKdtOL0qFmlbABWMUw19bDqxY2o6kclWhKL9qB0Z/jjxlljYlS+5en
        CuKG1XSruWkpb6BDA9LxKQ/fG4ELeruHNDeaKgBGal1OebTOhawKCsRY4mryiT1dqZUVpH
        b8ePr3WE+AQCh1LVYZEtx4GO7RJYE64=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Re07rdKCOm2k1DNzHMMkmQ-1; Tue, 13 Jun 2023 17:54:12 -0400
X-MC-Unique: Re07rdKCOm2k1DNzHMMkmQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f9eb7d5202so4777581cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686693248; x=1689285248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/X3bGqn1q+zHUVNMkc4k9dYCbdcixuWgARgx8VaUnYY=;
        b=AoG4240tIPryGS/LdRBWR8xQyCpgjnejGQUnPAPdbeN4hZ6kqZQTxJZ+aV6g/HICic
         hS7x4F8i3phNpHJpehqFiawf9cAigQegz1gXVA7WD6z2w1Wra037M4/atXkd3tQ/4yYt
         iUjN0EQAMtux7VEfW8CIouwK/5qdFk2vB+Zr1BsmGTlVasFpeumxVgSiqnpSHs9sRmVx
         0/+cMmXIeaPSZ+GBPlr+BbD0uJ7GKWvDnySgqOq6kbPlmAKtUjtlTV3+0XUY0Z3u9YlY
         YkLsuESMQjjkC52Q5yRRYHhQKUCoPImpdTnlk6PoiIz3INwLC0TGvWdCvaMIMnCDBI3w
         bHrw==
X-Gm-Message-State: AC+VfDxDVXEQ9rWrMRMaipLfD9DrgACEZYdXHvVslhiPfJK++0xgKuQF
        21hpUICY886M+0HmWdY8sSfPIPToU3MW1cNzxhsL7073ScEVHcrKDs8oyOzK/AhnJT6K4I3htpx
        ySXeiUaxVZ9cN6u8JgtSU8nubi3b4VL00DZo3GXGce9MlghQVUyxkcg4T4rjXHxALVmsqzVT10U
        FQoGel1w==
X-Received: by 2002:a05:622a:1a02:b0:3f6:ab9a:3d8e with SMTP id f2-20020a05622a1a0200b003f6ab9a3d8emr17758141qtb.4.1686693247628;
        Tue, 13 Jun 2023 14:54:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5w87HGnELUi5EkIzhKvNW57lYdNaWbCEMcUpk8sbBZqYIrssusFuVowDO7JEjTYM2qoSnZFw==
X-Received: by 2002:a05:622a:1a02:b0:3f6:ab9a:3d8e with SMTP id f2-20020a05622a1a0200b003f6ab9a3d8emr17758109qtb.4.1686693247132;
        Tue, 13 Jun 2023 14:54:07 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id fz24-20020a05622a5a9800b003f9bccc3182sm4522330qtb.32.2023.06.13.14.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:54:06 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 7/7] mm/gup: Retire follow_hugetlb_page()
Date:   Tue, 13 Jun 2023 17:53:46 -0400
Message-Id: <20230613215346.1022773-8-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613215346.1022773-1-peterx@redhat.com>
References: <20230613215346.1022773-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now __get_user_pages() should be well prepared to handle thp completely,
as long as hugetlb gup requests even without the hugetlb's special path.

Time to retire follow_hugetlb_page().

Tweak the comments in follow_page_mask() to reflect reality, by dropping
the "follow_page()" description.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h |  12 ---
 mm/gup.c                |  19 ----
 mm/hugetlb.c            | 223 ----------------------------------------
 3 files changed, 254 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0d6f389d98de..44e5836eed15 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -133,9 +133,6 @@ int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
 struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 				      unsigned long address, unsigned int flags,
 				      unsigned int *page_mask);
-long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
-			 struct page **, unsigned long *, unsigned long *,
-			 long, unsigned int, int *);
 void unmap_hugepage_range(struct vm_area_struct *,
 			  unsigned long, unsigned long, struct page *,
 			  zap_flags_t);
@@ -305,15 +302,6 @@ static inline struct page *hugetlb_follow_page_mask(
 	BUILD_BUG(); /* should never be compiled in if !CONFIG_HUGETLB_PAGE*/
 }
 
-static inline long follow_hugetlb_page(struct mm_struct *mm,
-			struct vm_area_struct *vma, struct page **pages,
-			unsigned long *position, unsigned long *nr_pages,
-			long i, unsigned int flags, int *nonblocking)
-{
-	BUG();
-	return 0;
-}
-
 static inline int copy_hugetlb_page_range(struct mm_struct *dst,
 					  struct mm_struct *src,
 					  struct vm_area_struct *dst_vma,
diff --git a/mm/gup.c b/mm/gup.c
index cdabc8ea783b..a65b80953b7a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -789,9 +789,6 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	 * Call hugetlb_follow_page_mask for hugetlb vmas as it will use
 	 * special hugetlb page table walking code.  This eliminates the
 	 * need to check for hugetlb entries in the general walking code.
-	 *
-	 * hugetlb_follow_page_mask is only for follow_page() handling here.
-	 * Ordinary GUP uses follow_hugetlb_page for hugetlb processing.
 	 */
 	if (is_vm_hugetlb_page(vma))
 		return hugetlb_follow_page_mask(vma, address, flags,
@@ -1149,22 +1146,6 @@ static long __get_user_pages(struct mm_struct *mm,
 			ret = check_vma_flags(vma, gup_flags);
 			if (ret)
 				goto out;
-
-			if (is_vm_hugetlb_page(vma)) {
-				i = follow_hugetlb_page(mm, vma, pages,
-							&start, &nr_pages, i,
-							gup_flags, locked);
-				if (!*locked) {
-					/*
-					 * We've got a VM_FAULT_RETRY
-					 * and we've lost mmap_lock.
-					 * We must stop here.
-					 */
-					BUG_ON(gup_flags & FOLL_NOWAIT);
-					goto out;
-				}
-				continue;
-			}
 		}
 retry:
 		/*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 31d8f18bc2e4..b7ff413ff68b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6425,37 +6425,6 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 }
 #endif /* CONFIG_USERFAULTFD */
 
-static void record_subpages(struct page *page, struct vm_area_struct *vma,
-			    int refs, struct page **pages)
-{
-	int nr;
-
-	for (nr = 0; nr < refs; nr++) {
-		if (likely(pages))
-			pages[nr] = nth_page(page, nr);
-	}
-}
-
-static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
-					       unsigned int flags, pte_t *pte,
-					       bool *unshare)
-{
-	pte_t pteval = huge_ptep_get(pte);
-
-	*unshare = false;
-	if (is_swap_pte(pteval))
-		return true;
-	if (huge_pte_write(pteval))
-		return false;
-	if (flags & FOLL_WRITE)
-		return true;
-	if (gup_must_unshare(vma, flags, pte_page(pteval))) {
-		*unshare = true;
-		return true;
-	}
-	return false;
-}
-
 struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 				      unsigned long address, unsigned int flags,
 				      unsigned int *page_mask)
@@ -6518,198 +6487,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	return page;
 }
 
-long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct page **pages, unsigned long *position,
-			 unsigned long *nr_pages, long i, unsigned int flags,
-			 int *locked)
-{
-	unsigned long pfn_offset;
-	unsigned long vaddr = *position;
-	unsigned long remainder = *nr_pages;
-	struct hstate *h = hstate_vma(vma);
-	int err = -EFAULT, refs;
-
-	while (vaddr < vma->vm_end && remainder) {
-		pte_t *pte;
-		spinlock_t *ptl = NULL;
-		bool unshare = false;
-		int absent;
-		struct page *page;
-
-		/*
-		 * If we have a pending SIGKILL, don't keep faulting pages and
-		 * potentially allocating memory.
-		 */
-		if (fatal_signal_pending(current)) {
-			remainder = 0;
-			break;
-		}
-
-		hugetlb_vma_lock_read(vma);
-		/*
-		 * Some archs (sparc64, sh*) have multiple pte_ts to
-		 * each hugepage.  We have to make sure we get the
-		 * first, for the page indexing below to work.
-		 *
-		 * Note that page table lock is not held when pte is null.
-		 */
-		pte = hugetlb_walk(vma, vaddr & huge_page_mask(h),
-				   huge_page_size(h));
-		if (pte)
-			ptl = huge_pte_lock(h, mm, pte);
-		absent = !pte || huge_pte_none(huge_ptep_get(pte));
-
-		/*
-		 * When coredumping, it suits get_dump_page if we just return
-		 * an error where there's an empty slot with no huge pagecache
-		 * to back it.  This way, we avoid allocating a hugepage, and
-		 * the sparse dumpfile avoids allocating disk blocks, but its
-		 * huge holes still show up with zeroes where they need to be.
-		 */
-		if (absent && (flags & FOLL_DUMP) &&
-		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
-			if (pte)
-				spin_unlock(ptl);
-			hugetlb_vma_unlock_read(vma);
-			remainder = 0;
-			break;
-		}
-
-		/*
-		 * We need call hugetlb_fault for both hugepages under migration
-		 * (in which case hugetlb_fault waits for the migration,) and
-		 * hwpoisoned hugepages (in which case we need to prevent the
-		 * caller from accessing to them.) In order to do this, we use
-		 * here is_swap_pte instead of is_hugetlb_entry_migration and
-		 * is_hugetlb_entry_hwpoisoned. This is because it simply covers
-		 * both cases, and because we can't follow correct pages
-		 * directly from any kind of swap entries.
-		 */
-		if (absent ||
-		    __follow_hugetlb_must_fault(vma, flags, pte, &unshare)) {
-			vm_fault_t ret;
-			unsigned int fault_flags = 0;
-
-			if (pte)
-				spin_unlock(ptl);
-			hugetlb_vma_unlock_read(vma);
-
-			if (flags & FOLL_WRITE)
-				fault_flags |= FAULT_FLAG_WRITE;
-			else if (unshare)
-				fault_flags |= FAULT_FLAG_UNSHARE;
-			if (locked) {
-				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
-					FAULT_FLAG_KILLABLE;
-				if (flags & FOLL_INTERRUPTIBLE)
-					fault_flags |= FAULT_FLAG_INTERRUPTIBLE;
-			}
-			if (flags & FOLL_NOWAIT)
-				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
-					FAULT_FLAG_RETRY_NOWAIT;
-			if (flags & FOLL_TRIED) {
-				/*
-				 * Note: FAULT_FLAG_ALLOW_RETRY and
-				 * FAULT_FLAG_TRIED can co-exist
-				 */
-				fault_flags |= FAULT_FLAG_TRIED;
-			}
-			ret = hugetlb_fault(mm, vma, vaddr, fault_flags);
-			if (ret & VM_FAULT_ERROR) {
-				err = vm_fault_to_errno(ret, flags);
-				remainder = 0;
-				break;
-			}
-			if (ret & VM_FAULT_RETRY) {
-				if (locked &&
-				    !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
-					*locked = 0;
-				*nr_pages = 0;
-				/*
-				 * VM_FAULT_RETRY must not return an
-				 * error, it will return zero
-				 * instead.
-				 *
-				 * No need to update "position" as the
-				 * caller will not check it after
-				 * *nr_pages is set to 0.
-				 */
-				return i;
-			}
-			continue;
-		}
-
-		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
-		page = pte_page(huge_ptep_get(pte));
-
-		VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
-			       !PageAnonExclusive(page), page);
-
-		/*
-		 * If subpage information not requested, update counters
-		 * and skip the same_page loop below.
-		 */
-		if (!pages && !pfn_offset &&
-		    (vaddr + huge_page_size(h) < vma->vm_end) &&
-		    (remainder >= pages_per_huge_page(h))) {
-			vaddr += huge_page_size(h);
-			remainder -= pages_per_huge_page(h);
-			i += pages_per_huge_page(h);
-			spin_unlock(ptl);
-			hugetlb_vma_unlock_read(vma);
-			continue;
-		}
-
-		/* vaddr may not be aligned to PAGE_SIZE */
-		refs = min3(pages_per_huge_page(h) - pfn_offset, remainder,
-		    (vma->vm_end - ALIGN_DOWN(vaddr, PAGE_SIZE)) >> PAGE_SHIFT);
-
-		if (pages)
-			record_subpages(nth_page(page, pfn_offset),
-					vma, refs,
-					likely(pages) ? pages + i : NULL);
-
-		if (pages) {
-			/*
-			 * try_grab_folio() should always succeed here,
-			 * because: a) we hold the ptl lock, and b) we've just
-			 * checked that the huge page is present in the page
-			 * tables. If the huge page is present, then the tail
-			 * pages must also be present. The ptl prevents the
-			 * head page and tail pages from being rearranged in
-			 * any way. As this is hugetlb, the pages will never
-			 * be p2pdma or not longterm pinable. So this page
-			 * must be available at this point, unless the page
-			 * refcount overflowed:
-			 */
-			if (WARN_ON_ONCE(!try_grab_folio(pages[i], refs,
-							 flags))) {
-				spin_unlock(ptl);
-				hugetlb_vma_unlock_read(vma);
-				remainder = 0;
-				err = -ENOMEM;
-				break;
-			}
-		}
-
-		vaddr += (refs << PAGE_SHIFT);
-		remainder -= refs;
-		i += refs;
-
-		spin_unlock(ptl);
-		hugetlb_vma_unlock_read(vma);
-	}
-	*nr_pages = remainder;
-	/*
-	 * setting position is actually required only if remainder is
-	 * not zero but it's faster not to add a "if (remainder)"
-	 * branch.
-	 */
-	*position = vaddr;
-
-	return i ? i : err;
-}
-
 long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
-- 
2.40.1

