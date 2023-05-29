Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021A571524B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 01:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjE2X1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 19:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjE2X1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 19:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45B8B5
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 16:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685402787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=65LgbrtBRhu2Gloy186N9fhSPg2JoxQNA2xa4tlJHX8=;
        b=K1VzZY4tDZydylxRQraVFy1XWInKesFX5XUMKD0YIPjVpcSu76d5fTl6F6SH4RVA3FrC1o
        lU/X9mGWz+PEoWt+1+6YWCRQ9E5ENVqW6QsLc02hgA8LCX3IF8lM7BLUiRxK6dRim74ZfH
        0BaMuQUWJ6KTtXT9eYjnoujgBBD5BVI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-FHYHdPhBP9CHMKyYq9D_5A-1; Mon, 29 May 2023 19:26:24 -0400
X-MC-Unique: FHYHdPhBP9CHMKyYq9D_5A-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74faf5008bbso52049585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 16:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685402784; x=1687994784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65LgbrtBRhu2Gloy186N9fhSPg2JoxQNA2xa4tlJHX8=;
        b=gcGUNrq6SyIeINfrOT26C6cWDvVoflp5iBSCP5add/MjEX8wsa48Tmc8i9bjiBhKyF
         O4NoEEOzYOPtDhBwtTD3HJ4RY9NvAX9IitkzANKeYmDvtxcFmVQr2XZUONojCNNDbVom
         Bnc+WFWc8/Vmuc/CXWYeWzaJfp2r3rdOFyTeYR+ritgZiHXZCPuVEIfushTtnbUwKd9P
         irxFAM4zMBSSSewXpoMQakmB6rnRfO4kuClKYkkibhHguRQqdmXDl5sK8wLaQxtfvDhG
         4eVZNXHFn01ChJ7dfp1lHMyWzhzqJrfqSJCb6FFJaHMm5gIh6/MeSrXxrS+hMAhWc48E
         jerg==
X-Gm-Message-State: AC+VfDzAmCkjepEdlVhoGWavER1AVUtAFsfa+zYdVexSp3iYW1VIZoSZ
        oZrLAn/4fkrfuXjKuKKGDwnsIkTT1LT9I5Va+REmKqqGBcqiEMtGINpxGtyqVdEo07KOMTBMcxF
        F0HrdRDa1HCeQeTV8gSFhcKA0
X-Received: by 2002:a05:6214:5087:b0:626:2f1b:b41c with SMTP id kk7-20020a056214508700b006262f1bb41cmr377756qvb.3.1685402784152;
        Mon, 29 May 2023 16:26:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ425m5mBSmdPS3/SmV0V5rHHR4woCRhczrYLRRsaKbWVnOl7enVIp/DN+dC4THA+qJNyLwUSg==
X-Received: by 2002:a05:6214:5087:b0:626:2f1b:b41c with SMTP id kk7-20020a056214508700b006262f1bb41cmr377734qvb.3.1685402783771;
        Mon, 29 May 2023 16:26:23 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id f16-20020ad45590000000b0062014184907sm4047556qvx.107.2023.05.29.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 16:26:22 -0700 (PDT)
Date:   Mon, 29 May 2023 19:26:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
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
Subject: Re: [PATCH 09/12] mm/khugepaged: retract_page_tables() without mmap
 or vma lock
Message-ID: <ZHU0m+QIChZNdOdg@x1n>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <2e9996fa-d238-e7c-1194-834a2bd1f60@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e9996fa-d238-e7c-1194-834a2bd1f60@google.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 11:25:15PM -0700, Hugh Dickins wrote:
> Simplify shmem and file THP collapse's retract_page_tables(), and relax
> its locking: to improve its success rate and to lessen impact on others.
> 
> Instead of its MADV_COLLAPSE case doing set_huge_pmd() at target_addr of
> target_mm, leave that part of the work to madvise_collapse() calling
> collapse_pte_mapped_thp() afterwards: just adjust collapse_file()'s
> result code to arrange for that.  That spares retract_page_tables() four
> arguments; and since it will be successful in retracting all of the page
> tables expected of it, no need to track and return a result code itself.
> 
> It needs i_mmap_lock_read(mapping) for traversing the vma interval tree,
> but it does not need i_mmap_lock_write() for that: page_vma_mapped_walk()
> allows for pte_offset_map_lock() etc to fail, and uses pmd_lock() for
> THPs.  retract_page_tables() just needs to use those same spinlocks to
> exclude it briefly, while transitioning pmd from page table to none: so
> restore its use of pmd_lock() inside of which pte lock is nested.
> 
> Users of pte_offset_map_lock() etc all now allow for them to fail:
> so retract_page_tables() now has no use for mmap_write_trylock() or
> vma_try_start_write().  In common with rmap and page_vma_mapped_walk(),
> it does not even need the mmap_read_lock().
> 
> But those users do expect the page table to remain a good page table,
> until they unlock and rcu_read_unlock(): so the page table cannot be
> freed immediately, but rather by the recently added pte_free_defer().
> 
> retract_page_tables() can be enhanced to replace_page_tables(), which
> inserts the final huge pmd without mmap lock: going through an invalid
> state instead of pmd_none() followed by fault.  But that does raise some
> questions, and requires a more complicated pte_free_defer() for powerpc
> (when its arch_needs_pgtable_deposit() for shmem and file THPs).  Leave
> that enhancement to a later release.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/khugepaged.c | 169 +++++++++++++++++-------------------------------
>  1 file changed, 60 insertions(+), 109 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 1083f0e38a07..4fd408154692 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1617,9 +1617,8 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>  		break;
>  	case SCAN_PMD_NONE:
>  		/*
> -		 * In MADV_COLLAPSE path, possible race with khugepaged where
> -		 * all pte entries have been removed and pmd cleared.  If so,
> -		 * skip all the pte checks and just update the pmd mapping.
> +		 * All pte entries have been removed and pmd cleared.
> +		 * Skip all the pte checks and just update the pmd mapping.
>  		 */
>  		goto maybe_install_pmd;
>  	default:
> @@ -1748,123 +1747,73 @@ static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_sl
>  	mmap_write_unlock(mm);
>  }
>  
> -static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> -			       struct mm_struct *target_mm,
> -			       unsigned long target_addr, struct page *hpage,
> -			       struct collapse_control *cc)
> +static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  {
>  	struct vm_area_struct *vma;
> -	int target_result = SCAN_FAIL;
>  
> -	i_mmap_lock_write(mapping);
> +	i_mmap_lock_read(mapping);
>  	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
> -		int result = SCAN_FAIL;
> -		struct mm_struct *mm = NULL;
> -		unsigned long addr = 0;
> -		pmd_t *pmd;
> -		bool is_target = false;
> +		struct mm_struct *mm;
> +		unsigned long addr;
> +		pmd_t *pmd, pgt_pmd;
> +		spinlock_t *pml;
> +		spinlock_t *ptl;
>  
>  		/*
>  		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
> -		 * got written to. These VMAs are likely not worth investing
> -		 * mmap_write_lock(mm) as PMD-mapping is likely to be split
> -		 * later.
> +		 * got written to. These VMAs are likely not worth removing
> +		 * page tables from, as PMD-mapping is likely to be split later.
>  		 *
> -		 * Note that vma->anon_vma check is racy: it can be set up after
> -		 * the check but before we took mmap_lock by the fault path.
> -		 * But page lock would prevent establishing any new ptes of the
> -		 * page, so we are safe.
> -		 *
> -		 * An alternative would be drop the check, but check that page
> -		 * table is clear before calling pmdp_collapse_flush() under
> -		 * ptl. It has higher chance to recover THP for the VMA, but
> -		 * has higher cost too. It would also probably require locking
> -		 * the anon_vma.
> +		 * Note that vma->anon_vma check is racy: it can be set after
> +		 * the check, but page locks (with XA_RETRY_ENTRYs in holes)
> +		 * prevented establishing new ptes of the page. So we are safe
> +		 * to remove page table below, without even checking it's empty.
>  		 */
> -		if (READ_ONCE(vma->anon_vma)) {
> -			result = SCAN_PAGE_ANON;
> -			goto next;
> -		}
> +		if (READ_ONCE(vma->anon_vma))
> +			continue;

Not directly related to current patch, but I just realized there seems to
have similar issue as what ab0c3f1251b4 wanted to fix.

IIUC any shmem vma that used to have uprobe/bp installed will have anon_vma
set here, then does it mean that any vma used to get debugged will never be
able to merge into a thp (with either madvise or khugepaged)?

I think it'll only make a difference when the page cache is not huge yet
when bp was uninstalled, but then it becomes a thp candidate somehow.  Even
if so, I think the anon_vma should still be there.

Did I miss something, or maybe that's not even a problem?

> +
>  		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>  		if (addr & ~HPAGE_PMD_MASK ||
> -		    vma->vm_end < addr + HPAGE_PMD_SIZE) {
> -			result = SCAN_VMA_CHECK;
> -			goto next;
> -		}
> -		mm = vma->vm_mm;
> -		is_target = mm == target_mm && addr == target_addr;
> -		result = find_pmd_or_thp_or_none(mm, addr, &pmd);
> -		if (result != SCAN_SUCCEED)
> -			goto next;
> -		/*
> -		 * We need exclusive mmap_lock to retract page table.
> -		 *
> -		 * We use trylock due to lock inversion: we need to acquire
> -		 * mmap_lock while holding page lock. Fault path does it in
> -		 * reverse order. Trylock is a way to avoid deadlock.
> -		 *
> -		 * Also, it's not MADV_COLLAPSE's job to collapse other
> -		 * mappings - let khugepaged take care of them later.
> -		 */
> -		result = SCAN_PTE_MAPPED_HUGEPAGE;
> -		if ((cc->is_khugepaged || is_target) &&
> -		    mmap_write_trylock(mm)) {
> -			/* trylock for the same lock inversion as above */
> -			if (!vma_try_start_write(vma))
> -				goto unlock_next;
> -
> -			/*
> -			 * Re-check whether we have an ->anon_vma, because
> -			 * collapse_and_free_pmd() requires that either no
> -			 * ->anon_vma exists or the anon_vma is locked.
> -			 * We already checked ->anon_vma above, but that check
> -			 * is racy because ->anon_vma can be populated under the
> -			 * mmap lock in read mode.
> -			 */
> -			if (vma->anon_vma) {
> -				result = SCAN_PAGE_ANON;
> -				goto unlock_next;
> -			}
> -			/*
> -			 * When a vma is registered with uffd-wp, we can't
> -			 * recycle the pmd pgtable because there can be pte
> -			 * markers installed.  Skip it only, so the rest mm/vma
> -			 * can still have the same file mapped hugely, however
> -			 * it'll always mapped in small page size for uffd-wp
> -			 * registered ranges.
> -			 */
> -			if (hpage_collapse_test_exit(mm)) {
> -				result = SCAN_ANY_PROCESS;
> -				goto unlock_next;
> -			}
> -			if (userfaultfd_wp(vma)) {
> -				result = SCAN_PTE_UFFD_WP;
> -				goto unlock_next;
> -			}
> -			collapse_and_free_pmd(mm, vma, addr, pmd);
> -			if (!cc->is_khugepaged && is_target)
> -				result = set_huge_pmd(vma, addr, pmd, hpage);
> -			else
> -				result = SCAN_SUCCEED;
> -
> -unlock_next:
> -			mmap_write_unlock(mm);
> -			goto next;
> -		}
> -		/*
> -		 * Calling context will handle target mm/addr. Otherwise, let
> -		 * khugepaged try again later.
> -		 */
> -		if (!is_target) {
> -			khugepaged_add_pte_mapped_thp(mm, addr);
> +		    vma->vm_end < addr + HPAGE_PMD_SIZE)
>  			continue;
> -		}
> -next:
> -		if (is_target)
> -			target_result = result;
> +
> +		mm = vma->vm_mm;
> +		if (find_pmd_or_thp_or_none(mm, addr, &pmd) != SCAN_SUCCEED)
> +			continue;
> +
> +		if (hpage_collapse_test_exit(mm))
> +			continue;
> +		/*
> +		 * When a vma is registered with uffd-wp, we cannot recycle
> +		 * the page table because there may be pte markers installed.
> +		 * Other vmas can still have the same file mapped hugely, but
> +		 * skip this one: it will always be mapped in small page size
> +		 * for uffd-wp registered ranges.
> +		 *
> +		 * What if VM_UFFD_WP is set a moment after this check?  No
> +		 * problem, huge page lock is still held, stopping new mappings
> +		 * of page which might then get replaced by pte markers: only
> +		 * existing markers need to be protected here.  (We could check
> +		 * after getting ptl below, but this comment distracting there!)
> +		 */
> +		if (userfaultfd_wp(vma))
> +			continue;

IIUC here with the new code we only hold (1) hpage lock, and (2)
i_mmap_lock read.  Then could it possible that right after checking this
and found !UFFD_WP, but then someone quickly (1) register uffd-wp on this
vma, then UFFDIO_WRITEPROTECT to install some pte markers, before below
pgtable locks taken?

The thing is installation of pte markers may not need either of the locks
iiuc..

Would taking mmap read lock help in this case?

Thanks,

> +
> +		/* Huge page lock is still held, so page table must be empty */
> +		pml = pmd_lock(mm, pmd);
> +		ptl = pte_lockptr(mm, pmd);
> +		if (ptl != pml)
> +			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> +		pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
> +		if (ptl != pml)
> +			spin_unlock(ptl);
> +		spin_unlock(pml);
> +
> +		mm_dec_nr_ptes(mm);
> +		page_table_check_pte_clear_range(mm, addr, pgt_pmd);
> +		pte_free_defer(mm, pmd_pgtable(pgt_pmd));
>  	}
> -	i_mmap_unlock_write(mapping);
> -	return target_result;
> +	i_mmap_unlock_read(mapping);
>  }
>  
>  /**
> @@ -2261,9 +2210,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  
>  	/*
>  	 * Remove pte page tables, so we can re-fault the page as huge.
> +	 * If MADV_COLLAPSE, adjust result to call collapse_pte_mapped_thp().
>  	 */
> -	result = retract_page_tables(mapping, start, mm, addr, hpage,
> -				     cc);
> +	retract_page_tables(mapping, start);
> +	if (cc && !cc->is_khugepaged)
> +		result = SCAN_PTE_MAPPED_HUGEPAGE;
>  	unlock_page(hpage);
>  
>  	/*
> -- 
> 2.35.3
> 

-- 
Peter Xu

