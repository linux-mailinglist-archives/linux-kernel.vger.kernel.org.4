Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3186073BA33
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjFWOax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjFWOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CB32693
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687530590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4y7Ae1fpCTtvuEzdDqcTV3xAT7ebtLUCI261jHMfiY=;
        b=aOpdRePX05epkfIJ1+PllvD/LSb/gIoywseZvxx6MW7xZ8MpytP7U6UZ6y6LmJMbnAUmja
        2cHIHsZktrsVcc9xKIAOiglT1fsfsTtIVxoRvzHvnhotNqSr72Z00XOjoMvR3o3p53FE5L
        sqaFLjQSgg65kCzYM1qpJ15L38rE2Is=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-AJbP7ruMPdq5D673yA2xiA-1; Fri, 23 Jun 2023 10:29:48 -0400
X-MC-Unique: AJbP7ruMPdq5D673yA2xiA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f9e7a1caf2so2096151cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530588; x=1690122588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4y7Ae1fpCTtvuEzdDqcTV3xAT7ebtLUCI261jHMfiY=;
        b=QgeYBTlZDUQNrMxP7AL55sDBimdVuMKSUs+b9Qg1uOk7avjSeOVPQrV1Awhepx3wUX
         GkxsleGM1vRJ23bEOdUSJuj1jDOGRyOn4wrHJTtPiFQiyP7NwIybKDmeUy4DYa8W1H1S
         bNsqIiAZbXs4I/ugAOUn0JeXPcrQcrmMFXmZfora5QokBOdobJ73TeWjl10Pi4AfWVlF
         lV3tMU343kmwiB/7c3UPsu2Nxd9d9IhhzYEx1ODb5JixXoWUAw41hsJ145AEG2vVdfCu
         k2WVuE83V9G9Dbq2V1hDXf30zWUPtzM2mUIhG8oNXBP21wu7MEEsC+nfQg9rNsP9gzNg
         /Q6Q==
X-Gm-Message-State: AC+VfDzeqGIS1vihsEP1wJbZGeEk90OiyYUWgjFcA1RPtJYZ/LFMDc/N
        zjP3sZSCW3Dr4W9C+BAbQ1H4Y/zRoh5VELOU3Dew/0IlBhC82DW7b1EV3rmkjIVNiL7wU7Lj7xy
        mQLiQptu845bZtpKXjqiQJTod
X-Received: by 2002:a05:6214:5186:b0:62d:eceb:f7ce with SMTP id kl6-20020a056214518600b0062decebf7cemr8898634qvb.1.1687530588062;
        Fri, 23 Jun 2023 07:29:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xTPkKWLLEE9oaBVdmvOEL+EzktAffFIbQniQEAF//E5ihb/bIjet/WBRe0QH6WnGGRv1UOg==
X-Received: by 2002:a05:6214:5186:b0:62d:eceb:f7ce with SMTP id kl6-20020a056214518600b0062decebf7cemr8898615qvb.1.1687530587775;
        Fri, 23 Jun 2023 07:29:47 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cc989000000b0062821057ac7sm5104827qvk.39.2023.06.23.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:29:47 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 6/8] mm/gup: Retire follow_hugetlb_page()
Date:   Fri, 23 Jun 2023 10:29:34 -0400
Message-Id: <20230623142936.268456-7-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623142936.268456-1-peterx@redhat.com>
References: <20230623142936.268456-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now __get_user_pages() should be well prepared to handle thp completely,
as long as hugetlb gup requests even without the hugetlb's special path.

Time to retire follow_hugetlb_page().

Tweak misc comments to reflect reality of follow_hugetlb_page()'s removal.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c        |   2 +-
 include/linux/hugetlb.h |  12 ---
 mm/gup.c                |  19 ----
 mm/hugetlb.c            | 224 ----------------------------------------
 4 files changed, 1 insertion(+), 256 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7cecd49e078b..ae711f1d7a83 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -427,7 +427,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 *
 	 * We also don't do userfault handling during
 	 * coredumping. hugetlbfs has the special
-	 * follow_hugetlb_page() to skip missing pages in the
+	 * hugetlb_follow_page_mask() to skip missing pages in the
 	 * FOLL_DUMP case, anon memory also checks for FOLL_DUMP with
 	 * the no_page_table() helper in follow_page_mask(), but the
 	 * shmem_vm_ops->fault method is invoked even during
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2e2d89e79d6c..bb5024718fc1 100644
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
index 22e32cff9ac7..ac61244e6fca 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -775,9 +775,6 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	 * Call hugetlb_follow_page_mask for hugetlb vmas as it will use
 	 * special hugetlb page table walking code.  This eliminates the
 	 * need to check for hugetlb entries in the general walking code.
-	 *
-	 * hugetlb_follow_page_mask is only for follow_page() handling here.
-	 * Ordinary GUP uses follow_hugetlb_page for hugetlb processing.
 	 */
 	if (is_vm_hugetlb_page(vma))
 		return hugetlb_follow_page_mask(vma, address, flags,
@@ -1138,22 +1135,6 @@ static long __get_user_pages(struct mm_struct *mm,
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
index b4973edef9f2..50a3579782a5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5721,7 +5721,6 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 
 /*
  * Return whether there is a pagecache page to back given address within VMA.
- * Caller follow_hugetlb_page() holds page_table_lock so we cannot lock_page.
  */
 static bool hugetlbfs_pagecache_present(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
@@ -6422,37 +6421,6 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
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
@@ -6522,198 +6490,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
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

