Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D4A71449C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjE2G0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjE2G0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:26:01 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48B819D
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:25:26 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ba71cd7ce7fso4329577276.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685341520; x=1687933520;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JHIvVFDDeb0UmLqYECNwvBDzrNYvPV2mAJt9DuZsGqI=;
        b=vy4bOZeB/A66J4j9HnNgzhCNnvZdPQ/qYVsp6cHRESlm/+NNE5/wIBuX4BQPZZXi+U
         yfOv5KIuNFZIGxmT2J41Omwq2WuOLtYXkDCRVQFlDnKL7Sb2EkLjAGyVqgxk6YwVvXsq
         4Pf+i37X+4QiOjtG5wU2Llmv4Y51UqbqrD37XCP8fC+Il7S+6dvF57+wSKT3pOZKo9Wq
         XS9k4OAS6EFviHg6GY7NWmUx1fP6lsswTyubgGRjqDpTcAziJzjScdUEu1t3l5BKVD8B
         YHHYTZOtafVUcsfZZNCTBvgZT4szHnXqQAoJ2bUIgqmZt8ZRwlANX5NxU9BJDyCisuqK
         1k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685341520; x=1687933520;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHIvVFDDeb0UmLqYECNwvBDzrNYvPV2mAJt9DuZsGqI=;
        b=X1seUOMyj7jfzRHrkYe93ecLtOc2235jqhNC8mhp4BeU1FG72wKNZ8DdyiBX1bBG1z
         1C3CL3mXmnA8cXWMCKG/Tj3wk0bDFkkeEOXkaeJs8/P51kjPVDeJj6eXyFb5RgbKYT9r
         8Y5WNNALph/R/31dtaXzE/qHI/OTTfCqZ4Tl7qImHGYWCZMT8rinjqokkZ7oStTQVmUl
         c/K22pK7B1eaeoWcY1IC++Ig4+hDlImUpSk8xzplWuibPHnyCD6omEEWu3Idr0a5GjB6
         d7tsVC860izk8oPlrHB42KIvMWwjwLo1SA1BloL/eybwpL1WyxO8OfR6SBHnaACg0g9F
         JPGg==
X-Gm-Message-State: AC+VfDzWhFo1jr8nCwbSQ5cZQdNmY5yvne+IHfB9U0JSBVpKMugjHag6
        3wGOEmkJQpctXbKp5F2gg3jdSA==
X-Google-Smtp-Source: ACHHUZ760oJ9OUejnylCEVSFBks584YyNq1hzCWCB4cpQetH+OHnL70ZjQyryA07DRyxberP/3hpcA==
X-Received: by 2002:a25:ae87:0:b0:b9e:7082:971e with SMTP id b7-20020a25ae87000000b00b9e7082971emr9144162ybj.45.1685341519867;
        Sun, 28 May 2023 23:25:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x18-20020a258592000000b00ba88763e5b5sm2667181ybk.2.2023.05.28.23.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:25:19 -0700 (PDT)
Date:   Sun, 28 May 2023 23:25:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 09/12] mm/khugepaged: retract_page_tables() without mmap or
 vma lock
In-Reply-To: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
Message-ID: <2e9996fa-d238-e7c-1194-834a2bd1f60@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify shmem and file THP collapse's retract_page_tables(), and relax
its locking: to improve its success rate and to lessen impact on others.

Instead of its MADV_COLLAPSE case doing set_huge_pmd() at target_addr of
target_mm, leave that part of the work to madvise_collapse() calling
collapse_pte_mapped_thp() afterwards: just adjust collapse_file()'s
result code to arrange for that.  That spares retract_page_tables() four
arguments; and since it will be successful in retracting all of the page
tables expected of it, no need to track and return a result code itself.

It needs i_mmap_lock_read(mapping) for traversing the vma interval tree,
but it does not need i_mmap_lock_write() for that: page_vma_mapped_walk()
allows for pte_offset_map_lock() etc to fail, and uses pmd_lock() for
THPs.  retract_page_tables() just needs to use those same spinlocks to
exclude it briefly, while transitioning pmd from page table to none: so
restore its use of pmd_lock() inside of which pte lock is nested.

Users of pte_offset_map_lock() etc all now allow for them to fail:
so retract_page_tables() now has no use for mmap_write_trylock() or
vma_try_start_write().  In common with rmap and page_vma_mapped_walk(),
it does not even need the mmap_read_lock().

But those users do expect the page table to remain a good page table,
until they unlock and rcu_read_unlock(): so the page table cannot be
freed immediately, but rather by the recently added pte_free_defer().

retract_page_tables() can be enhanced to replace_page_tables(), which
inserts the final huge pmd without mmap lock: going through an invalid
state instead of pmd_none() followed by fault.  But that does raise some
questions, and requires a more complicated pte_free_defer() for powerpc
(when its arch_needs_pgtable_deposit() for shmem and file THPs).  Leave
that enhancement to a later release.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/khugepaged.c | 169 +++++++++++++++++-------------------------------
 1 file changed, 60 insertions(+), 109 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1083f0e38a07..4fd408154692 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1617,9 +1617,8 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		break;
 	case SCAN_PMD_NONE:
 		/*
-		 * In MADV_COLLAPSE path, possible race with khugepaged where
-		 * all pte entries have been removed and pmd cleared.  If so,
-		 * skip all the pte checks and just update the pmd mapping.
+		 * All pte entries have been removed and pmd cleared.
+		 * Skip all the pte checks and just update the pmd mapping.
 		 */
 		goto maybe_install_pmd;
 	default:
@@ -1748,123 +1747,73 @@ static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_sl
 	mmap_write_unlock(mm);
 }
 
-static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
-			       struct mm_struct *target_mm,
-			       unsigned long target_addr, struct page *hpage,
-			       struct collapse_control *cc)
+static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 {
 	struct vm_area_struct *vma;
-	int target_result = SCAN_FAIL;
 
-	i_mmap_lock_write(mapping);
+	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
-		int result = SCAN_FAIL;
-		struct mm_struct *mm = NULL;
-		unsigned long addr = 0;
-		pmd_t *pmd;
-		bool is_target = false;
+		struct mm_struct *mm;
+		unsigned long addr;
+		pmd_t *pmd, pgt_pmd;
+		spinlock_t *pml;
+		spinlock_t *ptl;
 
 		/*
 		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
-		 * got written to. These VMAs are likely not worth investing
-		 * mmap_write_lock(mm) as PMD-mapping is likely to be split
-		 * later.
+		 * got written to. These VMAs are likely not worth removing
+		 * page tables from, as PMD-mapping is likely to be split later.
 		 *
-		 * Note that vma->anon_vma check is racy: it can be set up after
-		 * the check but before we took mmap_lock by the fault path.
-		 * But page lock would prevent establishing any new ptes of the
-		 * page, so we are safe.
-		 *
-		 * An alternative would be drop the check, but check that page
-		 * table is clear before calling pmdp_collapse_flush() under
-		 * ptl. It has higher chance to recover THP for the VMA, but
-		 * has higher cost too. It would also probably require locking
-		 * the anon_vma.
+		 * Note that vma->anon_vma check is racy: it can be set after
+		 * the check, but page locks (with XA_RETRY_ENTRYs in holes)
+		 * prevented establishing new ptes of the page. So we are safe
+		 * to remove page table below, without even checking it's empty.
 		 */
-		if (READ_ONCE(vma->anon_vma)) {
-			result = SCAN_PAGE_ANON;
-			goto next;
-		}
+		if (READ_ONCE(vma->anon_vma))
+			continue;
+
 		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		if (addr & ~HPAGE_PMD_MASK ||
-		    vma->vm_end < addr + HPAGE_PMD_SIZE) {
-			result = SCAN_VMA_CHECK;
-			goto next;
-		}
-		mm = vma->vm_mm;
-		is_target = mm == target_mm && addr == target_addr;
-		result = find_pmd_or_thp_or_none(mm, addr, &pmd);
-		if (result != SCAN_SUCCEED)
-			goto next;
-		/*
-		 * We need exclusive mmap_lock to retract page table.
-		 *
-		 * We use trylock due to lock inversion: we need to acquire
-		 * mmap_lock while holding page lock. Fault path does it in
-		 * reverse order. Trylock is a way to avoid deadlock.
-		 *
-		 * Also, it's not MADV_COLLAPSE's job to collapse other
-		 * mappings - let khugepaged take care of them later.
-		 */
-		result = SCAN_PTE_MAPPED_HUGEPAGE;
-		if ((cc->is_khugepaged || is_target) &&
-		    mmap_write_trylock(mm)) {
-			/* trylock for the same lock inversion as above */
-			if (!vma_try_start_write(vma))
-				goto unlock_next;
-
-			/*
-			 * Re-check whether we have an ->anon_vma, because
-			 * collapse_and_free_pmd() requires that either no
-			 * ->anon_vma exists or the anon_vma is locked.
-			 * We already checked ->anon_vma above, but that check
-			 * is racy because ->anon_vma can be populated under the
-			 * mmap lock in read mode.
-			 */
-			if (vma->anon_vma) {
-				result = SCAN_PAGE_ANON;
-				goto unlock_next;
-			}
-			/*
-			 * When a vma is registered with uffd-wp, we can't
-			 * recycle the pmd pgtable because there can be pte
-			 * markers installed.  Skip it only, so the rest mm/vma
-			 * can still have the same file mapped hugely, however
-			 * it'll always mapped in small page size for uffd-wp
-			 * registered ranges.
-			 */
-			if (hpage_collapse_test_exit(mm)) {
-				result = SCAN_ANY_PROCESS;
-				goto unlock_next;
-			}
-			if (userfaultfd_wp(vma)) {
-				result = SCAN_PTE_UFFD_WP;
-				goto unlock_next;
-			}
-			collapse_and_free_pmd(mm, vma, addr, pmd);
-			if (!cc->is_khugepaged && is_target)
-				result = set_huge_pmd(vma, addr, pmd, hpage);
-			else
-				result = SCAN_SUCCEED;
-
-unlock_next:
-			mmap_write_unlock(mm);
-			goto next;
-		}
-		/*
-		 * Calling context will handle target mm/addr. Otherwise, let
-		 * khugepaged try again later.
-		 */
-		if (!is_target) {
-			khugepaged_add_pte_mapped_thp(mm, addr);
+		    vma->vm_end < addr + HPAGE_PMD_SIZE)
 			continue;
-		}
-next:
-		if (is_target)
-			target_result = result;
+
+		mm = vma->vm_mm;
+		if (find_pmd_or_thp_or_none(mm, addr, &pmd) != SCAN_SUCCEED)
+			continue;
+
+		if (hpage_collapse_test_exit(mm))
+			continue;
+		/*
+		 * When a vma is registered with uffd-wp, we cannot recycle
+		 * the page table because there may be pte markers installed.
+		 * Other vmas can still have the same file mapped hugely, but
+		 * skip this one: it will always be mapped in small page size
+		 * for uffd-wp registered ranges.
+		 *
+		 * What if VM_UFFD_WP is set a moment after this check?  No
+		 * problem, huge page lock is still held, stopping new mappings
+		 * of page which might then get replaced by pte markers: only
+		 * existing markers need to be protected here.  (We could check
+		 * after getting ptl below, but this comment distracting there!)
+		 */
+		if (userfaultfd_wp(vma))
+			continue;
+
+		/* Huge page lock is still held, so page table must be empty */
+		pml = pmd_lock(mm, pmd);
+		ptl = pte_lockptr(mm, pmd);
+		if (ptl != pml)
+			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+		pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
+		if (ptl != pml)
+			spin_unlock(ptl);
+		spin_unlock(pml);
+
+		mm_dec_nr_ptes(mm);
+		page_table_check_pte_clear_range(mm, addr, pgt_pmd);
+		pte_free_defer(mm, pmd_pgtable(pgt_pmd));
 	}
-	i_mmap_unlock_write(mapping);
-	return target_result;
+	i_mmap_unlock_read(mapping);
 }
 
 /**
@@ -2261,9 +2210,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
 	/*
 	 * Remove pte page tables, so we can re-fault the page as huge.
+	 * If MADV_COLLAPSE, adjust result to call collapse_pte_mapped_thp().
 	 */
-	result = retract_page_tables(mapping, start, mm, addr, hpage,
-				     cc);
+	retract_page_tables(mapping, start);
+	if (cc && !cc->is_khugepaged)
+		result = SCAN_PTE_MAPPED_HUGEPAGE;
 	unlock_page(hpage);
 
 	/*
-- 
2.35.3

