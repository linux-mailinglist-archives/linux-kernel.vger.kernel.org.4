Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590F3670D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjAQXU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAQXUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:20:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89F35D122
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673989612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bKk9f7e5Yleo+prYdw0iH3hbLZ17vENtX6XlppAd1xw=;
        b=H+sW6L0CXJm9XMRluonQiNoGimekqkpvyghu5mfjbz07QC2i9BdSYyNKbKIRlGlveQvJM9
        XYSmo2cfFlYO6d2oouZ2zhUSzoQfliCbLBdFWDtVOqcUH1N5FB26+HtrvL04RddPKv59Yq
        Xbtlsa/En8Afufgs4ulTPzXALKcEoJg=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-281-vAVlsMtkMdSxN5Mb3yO5tQ-1; Tue, 17 Jan 2023 16:06:45 -0500
X-MC-Unique: vAVlsMtkMdSxN5Mb3yO5tQ-1
Received: by mail-yb1-f198.google.com with SMTP id i135-20020a25d18d000000b007e64108adb4so6338866ybg.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKk9f7e5Yleo+prYdw0iH3hbLZ17vENtX6XlppAd1xw=;
        b=JT1T5/bNbhqs6jMISJuHDWWAFwTvAsOM2J6aWGIyetQjmgwsj/IpxJJ+6PY+H4fhgx
         I0NQKk62QSbFzyuRbxvwDJhH328pkGJrYeqxi31Ay+xWGh1iK0+q4yZv0wVX1QCTBZ+9
         FReTZ7u0XpzEpBi59Gg2q+lCK9wd63khf798wkke+5Pf9NXIE3nrU3XwvuwH+la5EOwL
         AH4wX4DUrfLIJtz4Xdotzc2ZNP9/kaCW0wGB2+9Y2ukEhDoS1hCjl9BkQSxl/G8Xv8S3
         5PptMMhMVpF2qmwAKWrLUU3kZfosrT/WU6mg4TbEBH+xXX1CtrQwtwTSA39QZfNfGwy3
         ioEg==
X-Gm-Message-State: AFqh2krMQHnW42PrDjBVgn1ZsAKaaI6IAPIPuSCJmA/husfDo/O2x66C
        27KhZ+nbFKNq3MvFpqZ4lAHoB9Wsd/77Gj/Ccnfb4XMOC643wetzPtavSTRWFQGYGiXaY20H8C6
        gBJf3vHsX6zdzdwraw589d8KN
X-Received: by 2002:a05:7500:58a:b0:f0:2adf:ae3d with SMTP id n10-20020a057500058a00b000f02adfae3dmr376911gac.36.1673989605064;
        Tue, 17 Jan 2023 13:06:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtJDQrCN2P1BEejhV6KQl5Pj7xf4V6bwRkqIyA4ip/U/9RoNFp238q6BsVVuZ0FSLiMvE43Kw==
X-Received: by 2002:a05:7500:58a:b0:f0:2adf:ae3d with SMTP id n10-20020a057500058a00b000f02adfae3dmr376903gac.36.1673989604619;
        Tue, 17 Jan 2023 13:06:44 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a450500b006fa8299b4d5sm21132728qkp.100.2023.01.17.13.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 13:06:43 -0800 (PST)
Date:   Tue, 17 Jan 2023 16:06:40 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 35/46] hugetlb: add MADV_COLLAPSE for hugetlb
Message-ID: <Y8cN4G0ICoSSggS+@x1n>
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-36-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230105101844.1893104-36-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 10:18:33AM +0000, James Houghton wrote:
> This is a necessary extension to the UFFDIO_CONTINUE changes. When
> userspace finishes mapping an entire hugepage with UFFDIO_CONTINUE, the
> kernel has no mechanism to automatically collapse the page table to map
> the whole hugepage normally. We require userspace to inform us that they
> would like the mapping to be collapsed; they do this with MADV_COLLAPSE.
> 
> If userspace has not mapped all of a hugepage with UFFDIO_CONTINUE, but
> only some, hugetlb_collapse will cause the requested range to be mapped
> as if it were UFFDIO_CONTINUE'd already. The effects of any
> UFFDIO_WRITEPROTECT calls may be undone by a call to MADV_COLLAPSE for
> intersecting address ranges.
> 
> This commit is co-opting the same madvise mode that has been introduced
> to synchronously collapse THPs. The function that does THP collapsing
> has been renamed to madvise_collapse_thp.
> 
> As with the rest of the high-granularity mapping support, MADV_COLLAPSE
> is only supported for shared VMAs right now.
> 
> MADV_COLLAPSE has the same synchronization as huge_pmd_unshare.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/huge_mm.h |  12 +--
>  include/linux/hugetlb.h |   8 ++
>  mm/hugetlb.c            | 164 ++++++++++++++++++++++++++++++++++++++++
>  mm/khugepaged.c         |   4 +-
>  mm/madvise.c            |  18 ++++-
>  5 files changed, 197 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index a1341fdcf666..5d1e3c980f74 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -218,9 +218,9 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
>  
>  int hugepage_madvise(struct vm_area_struct *vma, unsigned long *vm_flags,
>  		     int advice);
> -int madvise_collapse(struct vm_area_struct *vma,
> -		     struct vm_area_struct **prev,
> -		     unsigned long start, unsigned long end);
> +int madvise_collapse_thp(struct vm_area_struct *vma,
> +			 struct vm_area_struct **prev,
> +			 unsigned long start, unsigned long end);
>  void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start,
>  			   unsigned long end, long adjust_next);
>  spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma);
> @@ -367,9 +367,9 @@ static inline int hugepage_madvise(struct vm_area_struct *vma,
>  	return -EINVAL;
>  }
>  
> -static inline int madvise_collapse(struct vm_area_struct *vma,
> -				   struct vm_area_struct **prev,
> -				   unsigned long start, unsigned long end)
> +static inline int madvise_collapse_thp(struct vm_area_struct *vma,
> +				       struct vm_area_struct **prev,
> +				       unsigned long start, unsigned long end)
>  {
>  	return -EINVAL;
>  }
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index c8524ac49b24..e1baf939afb6 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1298,6 +1298,8 @@ bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
>  int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
>  			      struct vm_area_struct *vma, unsigned long start,
>  			      unsigned long end);
> +int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
> +		     unsigned long start, unsigned long end);
>  #else
>  static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
>  {
> @@ -1318,6 +1320,12 @@ int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
>  {
>  	return -EINVAL;
>  }
> +static inline
> +int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
> +		     unsigned long start, unsigned long end)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  static inline spinlock_t *huge_pte_lock(struct hstate *h,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5b6215e03fe1..388c46c7e77a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7852,6 +7852,170 @@ int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
>  	return 0;
>  }
>  
> +static bool hugetlb_hgm_collapsable(struct vm_area_struct *vma)
> +{
> +	if (!hugetlb_hgm_eligible(vma))
> +		return false;
> +	if (!vma->vm_private_data)	/* vma lock required for collapsing */
> +		return false;
> +	return true;
> +}
> +
> +/*
> + * Collapse the address range from @start to @end to be mapped optimally.
> + *
> + * This is only valid for shared mappings. The main use case for this function
> + * is following UFFDIO_CONTINUE. If a user UFFDIO_CONTINUEs an entire hugepage
> + * by calling UFFDIO_CONTINUE once for each 4K region, the kernel doesn't know
> + * to collapse the mapping after the final UFFDIO_CONTINUE. Instead, we leave
> + * it up to userspace to tell us to do so, via MADV_COLLAPSE.
> + *
> + * Any holes in the mapping will be filled. If there is no page in the
> + * pagecache for a region we're collapsing, the PTEs will be cleared.
> + *
> + * If high-granularity PTEs are uffd-wp markers, those markers will be dropped.
> + */
> +int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
> +			    unsigned long start, unsigned long end)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	struct address_space *mapping = vma->vm_file->f_mapping;
> +	struct mmu_notifier_range range;
> +	struct mmu_gather tlb;
> +	unsigned long curr = start;
> +	int ret = 0;
> +	struct page *hpage, *subpage;
> +	pgoff_t idx;
> +	bool writable = vma->vm_flags & VM_WRITE;
> +	bool shared = vma->vm_flags & VM_SHARED;
> +	struct hugetlb_pte hpte;
> +	pte_t entry;
> +
> +	/*
> +	 * This is only supported for shared VMAs, because we need to look up
> +	 * the page to use for any PTEs we end up creating.
> +	 */
> +	if (!shared)
> +		return -EINVAL;
> +
> +	/* If HGM is not enabled, there is nothing to collapse. */
> +	if (!hugetlb_hgm_enabled(vma))
> +		return 0;
> +
> +	/*
> +	 * We lost the VMA lock after splitting, so we can't safely collapse.
> +	 * We could improve this in the future (like take the mmap_lock for
> +	 * writing and try again), but for now just fail with ENOMEM.
> +	 */
> +	if (unlikely(!hugetlb_hgm_collapsable(vma)))
> +		return -ENOMEM;
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
> +				start, end);
> +	mmu_notifier_invalidate_range_start(&range);
> +	tlb_gather_mmu(&tlb, mm);
> +
> +	/*
> +	 * Grab the VMA lock and mapping sem for writing. This will prevent
> +	 * concurrent high-granularity page table walks, so that we can safely
> +	 * collapse and free page tables.
> +	 *
> +	 * This is the same locking that huge_pmd_unshare requires.
> +	 */
> +	hugetlb_vma_lock_write(vma);
> +	i_mmap_lock_write(vma->vm_file->f_mapping);
> +
> +	while (curr < end) {
> +		ret = hugetlb_alloc_largest_pte(&hpte, mm, vma, curr, end);
> +		if (ret)
> +			goto out;
> +
> +		entry = huge_ptep_get(hpte.ptep);
> +
> +		/*
> +		 * There is no work to do if the PTE doesn't point to page
> +		 * tables.
> +		 */
> +		if (!pte_present(entry))
> +			goto next_hpte;
> +		if (hugetlb_pte_present_leaf(&hpte, entry))
> +			goto next_hpte;
> +
> +		idx = vma_hugecache_offset(h, vma, curr);
> +		hpage = find_get_page(mapping, idx);
> +
> +		if (hpage && !HPageMigratable(hpage)) {
> +			/*
> +			 * Don't collapse a mapping to a page that is pending
> +			 * a migration. Migration swap entries may have placed
> +			 * in the page table.
> +			 */
> +			ret = -EBUSY;
> +			put_page(hpage);
> +			goto out;
> +		}
> +
> +		if (hpage && PageHWPoison(hpage)) {
> +			/*
> +			 * Don't collapse a mapping to a page that is
> +			 * hwpoisoned.
> +			 */
> +			ret = -EHWPOISON;
> +			put_page(hpage);
> +			/*
> +			 * By setting ret to -EHWPOISON, if nothing else
> +			 * happens, we will tell userspace that we couldn't
> +			 * fully collapse everything due to poison.
> +			 *
> +			 * Skip this page, and continue to collapse the rest
> +			 * of the mapping.
> +			 */
> +			curr = (curr & huge_page_mask(h)) + huge_page_size(h);
> +			continue;
> +		}
> +
> +		/*
> +		 * Clear all the PTEs, and drop ref/mapcounts
> +		 * (on tlb_finish_mmu).
> +		 */
> +		__unmap_hugepage_range(&tlb, vma, curr,
> +			curr + hugetlb_pte_size(&hpte),
> +			NULL,
> +			ZAP_FLAG_DROP_MARKER);
> +		/* Free the PTEs. */
> +		hugetlb_free_pgd_range(&tlb,
> +				curr, curr + hugetlb_pte_size(&hpte),
> +				curr, curr + hugetlb_pte_size(&hpte));
> +		if (!hpage) {
> +			huge_pte_clear(mm, curr, hpte.ptep,
> +					hugetlb_pte_size(&hpte));
> +			goto next_hpte;
> +		}
> +
> +		page_dup_file_rmap(hpage, true);
> +
> +		subpage = hugetlb_find_subpage(h, hpage, curr);
> +		entry = make_huge_pte_with_shift(vma, subpage,
> +						 writable, hpte.shift);
> +		set_huge_pte_at(mm, curr, hpte.ptep, entry);
> +next_hpte:
> +		curr += hugetlb_pte_size(&hpte);
> +
> +		if (curr < end) {
> +			/* Don't hold the VMA lock for too long. */
> +			hugetlb_vma_unlock_write(vma);
> +			cond_resched();
> +			hugetlb_vma_lock_write(vma);

The intention is good here but IIUC this will cause vma lock to be taken
after the i_mmap_rwsem, which can cause circular deadlocks.  If to do this
properly we'll need to also release the i_mmap_rwsem.

However it may make the resched() logic over complicated, meanwhile for 2M
huge pages I think this will be called for each 2M range which can be too
fine grained, so it looks like the "cur < end" check is a bit too aggresive.

The other thing is I noticed that the long period of mmu notifier
invalidate between start -> end will (in reallife VM context) causing vcpu
threads spinning.

I _think_ it's because is_page_fault_stale() (when during a vmexit
following a kvm page fault) always reports true during the long procedure
of MADV_COLLAPSE if to be called upon a large range, so even if we release
both locks here it may not tremedously on the VM migration use case because
of the long-standing mmu notifier invalidation procedure.

To summarize.. I think a simpler start version of hugetlb MADV_COLLAPSE can
drop this "if" block, and let the userapp decide the step size of COLLAPSE?

> +		}
> +	}
> +out:
> +	i_mmap_unlock_write(vma->vm_file->f_mapping);
> +	hugetlb_vma_unlock_write(vma);
> +	tlb_finish_mmu(&tlb);
> +	mmu_notifier_invalidate_range_end(&range);
> +	return ret;
> +}
> +
>  #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */

-- 
Peter Xu

