Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0762E268
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbiKQRAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbiKQQ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:59:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B21A10FC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668704342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4cmPUfyrbYqV//vMjzGn5Ur9cHgGnBmKe1hezXRDrKk=;
        b=F3c8uPbpHiG9NhIdGlq5GNeS3m6K5PlNVz6ALsDlIVpQWeiv4uG8LT9XohrsXan4aD6kUx
        TSocDGkQGWJPh0Ez7ZT/yWLqTYIzv/vT4ngClCFppD77CVMA0oQ7zXIxxx86v4zkpB7n2o
        Ni3XlO7GmVTof0Vqh7XOQI8valV3X3Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-567-i-NaZfPsMYiw_7mRiygfbw-1; Thu, 17 Nov 2022 11:59:01 -0500
X-MC-Unique: i-NaZfPsMYiw_7mRiygfbw-1
Received: by mail-qt1-f198.google.com with SMTP id n12-20020ac85a0c000000b003a5849497f9so2187461qta.20
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cmPUfyrbYqV//vMjzGn5Ur9cHgGnBmKe1hezXRDrKk=;
        b=lQ4ulBTxqYO9nrhImY92Ammy81JqI5nYu0NNbVAxJzCS+OI19UOKrHIsHf9C3/7tC4
         nd1EZ4ImAVD7dfve7snLT+0letdGG7fevvIcd7BqNnm8Uoz7MI5Lu9hIbTz1WJsbx5Xp
         7kFfLrZsHif/L/GqxAxmsk+7fEvu/emtv946J1KPobNTdRXXq57b0XmMfBo6DhY+y005
         MHWvN9UX3QBrNZPbqNBClDOvPHJhEyltB9d4CMZfSLvHiUr1rhNWbdfRcJwVN77uGyv9
         tb5oPGo07aSgfbfcjIyYAC/jmrlKUhvNVjZ1UOlB2PxgsY6DVKAdHb9f/7FvxxZysMaL
         jlKA==
X-Gm-Message-State: ANoB5pnDymu987kgKyn7NwipQbEEu+voW/rlf+J9CkYrung0/IJB0ZFG
        3hqXzAiwYhYadFgjd7m0GwXOetX5Ed8B+XniHNCucSQCt+XaWYIKNaT4rOFX2DunR9DXbyQ0KR6
        UyfOH2VO1w+Ka0q1ZuWv+YUdJ
X-Received: by 2002:ae9:c116:0:b0:6fa:da78:6945 with SMTP id z22-20020ae9c116000000b006fada786945mr2359416qki.367.1668704340374;
        Thu, 17 Nov 2022 08:59:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7gcPTcPnmZUrsmVr809qdVnUP1wuSPjs5Xoiy3oW2uhFNXcE4e/EnE01+A/igU5CHqlCh/lA==
X-Received: by 2002:ae9:c116:0:b0:6fa:da78:6945 with SMTP id z22-20020ae9c116000000b006fada786945mr2359392qki.367.1668704340000;
        Thu, 17 Nov 2022 08:59:00 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id de13-20020a05620a370d00b006e99290e83fsm770446qkb.107.2022.11.17.08.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:58:59 -0800 (PST)
Date:   Thu, 17 Nov 2022 11:58:58 -0500
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
Subject: Re: [RFC PATCH v2 34/47] hugetlb: userfaultfd: add support for
 high-granularity UFFDIO_CONTINUE
Message-ID: <Y3ZoUqXvIrmYwWeu@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-35-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-35-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:50PM +0000, James Houghton wrote:
> Changes here are similar to the changes made for hugetlb_no_page.
> 
> Pass vmf->real_address to userfaultfd_huge_must_wait because
> vmf->address is rounded down to the hugepage size, and a
> high-granularity page table walk would look up the wrong PTE. Also
> change the call to userfaultfd_must_wait in the same way for
> consistency.
> 
> This commit introduces hugetlb_alloc_largest_pte which is used to find
> the appropriate PTE size to map pages with UFFDIO_CONTINUE.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  fs/userfaultfd.c        | 33 +++++++++++++++---
>  include/linux/hugetlb.h | 14 +++++++-
>  mm/hugetlb.c            | 76 +++++++++++++++++++++++++++++++++--------
>  mm/userfaultfd.c        | 46 +++++++++++++++++--------
>  4 files changed, 135 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 3a3e9ef74dab..0204108e3882 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -245,14 +245,22 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>  	struct mm_struct *mm = ctx->mm;
>  	pte_t *ptep, pte;
>  	bool ret = true;
> +	struct hugetlb_pte hpte;
> +	unsigned long sz = vma_mmu_pagesize(vma);
> +	unsigned int shift = huge_page_shift(hstate_vma(vma));
>  
>  	mmap_assert_locked(mm);
>  
> -	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
> +	ptep = huge_pte_offset(mm, address, sz);
>  
>  	if (!ptep)
>  		goto out;
>  
> +	hugetlb_pte_populate(&hpte, ptep, shift, hpage_size_to_level(sz));
> +	hugetlb_hgm_walk(mm, vma, &hpte, address, PAGE_SIZE,
> +			/*stop_at_none=*/true);

Side note: I had a feeling that we may want a helper function to walk the
whole hugetlb pgtable, that may contain huge_pte_offset() and the hgm walk.
Not really needed for this series, but maybe for the future.

> +	ptep = hpte.ptep;
> +
>  	ret = false;
>  	pte = huge_ptep_get(ptep);
>  
> @@ -498,6 +506,14 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  
>  	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
>  
> +	if (is_vm_hugetlb_page(vmf->vma) && hugetlb_hgm_enabled(vmf->vma))
> +		/*
> +		 * Lock the VMA lock so we can do a high-granularity walk in
> +		 * userfaultfd_huge_must_wait. We have to grab this lock before
> +		 * we set our state to blocking.
> +		 */
> +		hugetlb_vma_lock_read(vmf->vma);

Yeah this will help with/without hgm, afaict.  Maybe when I rework my other
patchset I'll just take the vma lock unconditionally for this path.

> +
>  	spin_lock_irq(&ctx->fault_pending_wqh.lock);
>  	/*
>  	 * After the __add_wait_queue the uwq is visible to userland
> @@ -513,12 +529,15 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
>  
>  	if (!is_vm_hugetlb_page(vmf->vma))
> -		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
> -						  reason);
> +		must_wait = userfaultfd_must_wait(ctx, vmf->real_address,
> +				vmf->flags, reason);
>  	else
>  		must_wait = userfaultfd_huge_must_wait(ctx, vmf->vma,
> -						       vmf->address,
> +						       vmf->real_address,
>  						       vmf->flags, reason);
> +
> +	if (is_vm_hugetlb_page(vmf->vma) && hugetlb_hgm_enabled(vmf->vma))
> +		hugetlb_vma_unlock_read(vmf->vma);
>  	mmap_read_unlock(mm);
>  
>  	if (likely(must_wait && !READ_ONCE(ctx->released))) {
> @@ -1463,6 +1482,12 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  			mas_pause(&mas);
>  		}
>  	next:
> +		if (is_vm_hugetlb_page(vma) && (ctx->features &
> +					UFFD_FEATURE_MINOR_HUGETLBFS_HGM)) {
> +			ret = enable_hugetlb_hgm(vma);
> +			if (ret)
> +				break;

[1]

> +		}
>  		/*
>  		 * In the vma_merge() successful mprotect-like case 8:
>  		 * the next vma was merged into the current one and
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index e25f97cdd086..00c22a84a1c6 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -250,7 +250,8 @@ unsigned long hugetlb_total_pages(void);
>  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long address, unsigned int flags);
>  #ifdef CONFIG_USERFAULTFD
> -int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
> +int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> +				struct hugetlb_pte *dst_hpte,
>  				struct vm_area_struct *dst_vma,
>  				unsigned long dst_addr,
>  				unsigned long src_addr,
> @@ -1272,6 +1273,9 @@ static inline enum hugetlb_level hpage_size_to_level(unsigned long sz)
>  bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
>  bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
>  int enable_hugetlb_hgm(struct vm_area_struct *vma);
> +int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
> +			      struct vm_area_struct *vma, unsigned long start,
> +			      unsigned long end);
>  #else
>  static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
>  {
> @@ -1285,6 +1289,14 @@ static inline int enable_hugetlb_hgm(struct vm_area_struct *vma)
>  {
>  	return -EINVAL;
>  }
> +
> +static inline
> +int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
> +			      struct vm_area_struct *vma, unsigned long start,
> +			      unsigned long end)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  static inline spinlock_t *huge_pte_lock(struct hstate *h,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6eaec40d66ad..c25d3cd73ac9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6325,7 +6325,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   * modifications for huge pages.
>   */
>  int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> -			    pte_t *dst_pte,
> +			    struct hugetlb_pte *dst_hpte,
>  			    struct vm_area_struct *dst_vma,
>  			    unsigned long dst_addr,
>  			    unsigned long src_addr,
> @@ -6336,13 +6336,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
>  	struct hstate *h = hstate_vma(dst_vma);
>  	struct address_space *mapping = dst_vma->vm_file->f_mapping;
> -	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> +	unsigned long haddr = dst_addr & huge_page_mask(h);
> +	pgoff_t idx = vma_hugecache_offset(h, dst_vma, haddr);
>  	unsigned long size;
>  	int vm_shared = dst_vma->vm_flags & VM_SHARED;
>  	pte_t _dst_pte;
>  	spinlock_t *ptl;
>  	int ret = -ENOMEM;
> -	struct page *page;
> +	struct page *page, *subpage;
>  	int writable;
>  	bool page_in_pagecache = false;
>  
> @@ -6357,12 +6358,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  		 * a non-missing case. Return -EEXIST.
>  		 */
>  		if (vm_shared &&
> -		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
> +		    hugetlbfs_pagecache_present(h, dst_vma, haddr)) {
>  			ret = -EEXIST;
>  			goto out;
>  		}
>  
> -		page = alloc_huge_page(dst_vma, dst_addr, 0);
> +		page = alloc_huge_page(dst_vma, haddr, 0);
>  		if (IS_ERR(page)) {
>  			ret = -ENOMEM;
>  			goto out;
> @@ -6378,13 +6379,13 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			/* Free the allocated page which may have
>  			 * consumed a reservation.
>  			 */
> -			restore_reserve_on_error(h, dst_vma, dst_addr, page);
> +			restore_reserve_on_error(h, dst_vma, haddr, page);
>  			put_page(page);
>  
>  			/* Allocate a temporary page to hold the copied
>  			 * contents.
>  			 */
> -			page = alloc_huge_page_vma(h, dst_vma, dst_addr);
> +			page = alloc_huge_page_vma(h, dst_vma, haddr);
>  			if (!page) {
>  				ret = -ENOMEM;
>  				goto out;
> @@ -6398,14 +6399,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  		}
>  	} else {
>  		if (vm_shared &&
> -		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
> +		    hugetlbfs_pagecache_present(h, dst_vma, haddr)) {
>  			put_page(*pagep);
>  			ret = -EEXIST;
>  			*pagep = NULL;
>  			goto out;
>  		}
>  
> -		page = alloc_huge_page(dst_vma, dst_addr, 0);
> +		page = alloc_huge_page(dst_vma, haddr, 0);
>  		if (IS_ERR(page)) {
>  			put_page(*pagep);
>  			ret = -ENOMEM;
> @@ -6447,7 +6448,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  		page_in_pagecache = true;
>  	}
>  
> -	ptl = huge_pte_lock(h, dst_mm, dst_pte);
> +	ptl = hugetlb_pte_lock(dst_mm, dst_hpte);
>  
>  	ret = -EIO;
>  	if (PageHWPoison(page))
> @@ -6459,7 +6460,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	 * page backing it, then access the page.
>  	 */
>  	ret = -EEXIST;
> -	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
> +	if (!huge_pte_none_mostly(huge_ptep_get(dst_hpte->ptep)))
>  		goto out_release_unlock;
>  
>  	if (page_in_pagecache) {
> @@ -6478,7 +6479,11 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	else
>  		writable = dst_vma->vm_flags & VM_WRITE;
>  
> -	_dst_pte = make_huge_pte(dst_vma, page, writable);
> +	subpage = hugetlb_find_subpage(h, page, dst_addr);
> +	WARN_ON_ONCE(subpage != page && !hugetlb_hgm_enabled(dst_vma));
> +
> +	_dst_pte = make_huge_pte_with_shift(dst_vma, subpage, writable,
> +			dst_hpte->shift);
>  	/*
>  	 * Always mark UFFDIO_COPY page dirty; note that this may not be
>  	 * extremely important for hugetlbfs for now since swapping is not
> @@ -6491,12 +6496,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	if (wp_copy)
>  		_dst_pte = huge_pte_mkuffd_wp(_dst_pte);
>  
> -	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> +	set_huge_pte_at(dst_mm, dst_addr, dst_hpte->ptep, _dst_pte);
>  
> -	hugetlb_count_add(pages_per_huge_page(h), dst_mm);
> +	hugetlb_count_add(hugetlb_pte_size(dst_hpte) / PAGE_SIZE, dst_mm);
>  
>  	/* No need to invalidate - it was non-present before */
> -	update_mmu_cache(dst_vma, dst_addr, dst_pte);
> +	update_mmu_cache(dst_vma, dst_addr, dst_hpte->ptep);
>  
>  	spin_unlock(ptl);
>  	if (!is_continue)
> @@ -7875,6 +7880,47 @@ static unsigned int __shift_for_hstate(struct hstate *h)
>  			       (tmp_h) <= &hstates[hugetlb_max_hstate]; \
>  			       (tmp_h)++)
>  
> +/*
> + * Allocate a HugeTLB PTE that maps as much of [start, end) as possible with a
> + * single page table entry. The allocated HugeTLB PTE is returned in @hpte.
> + */
> +int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
> +			      struct vm_area_struct *vma, unsigned long start,
> +			      unsigned long end)
> +{
> +	struct hstate *h = hstate_vma(vma), *tmp_h;
> +	unsigned int shift;
> +	unsigned long sz;
> +	int ret;
> +	pte_t *ptep;
> +
> +	for_each_hgm_shift(h, tmp_h, shift) {

The fallback to PAGE_SIZE (in __shift_for_hstate()) is not obvious.  Would
it be clearer we handle PAGE_SIZE explicitly here?

> +		sz = 1UL << shift;
> +
> +		if (!IS_ALIGNED(start, sz) || start + sz > end)
> +			continue;
> +		goto found;
> +	}
> +	return -EINVAL;
> +found:
> +	ptep = huge_pte_alloc(mm, vma, start, huge_page_size(h));
> +	if (!ptep)
> +		return -ENOMEM;
> +
> +	hugetlb_pte_populate(hpte, ptep, huge_page_shift(h),
> +			hpage_size_to_level(huge_page_size(h)));
> +
> +	ret = hugetlb_hgm_walk(mm, vma, hpte, start, 1L << shift,
> +			/*stop_at_none=*/false);
> +	if (ret)
> +		return ret;
> +
> +	if (hpte->shift > shift)
> +		return -EEXIST;
> +
> +	return 0;
> +}
> +
>  #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
>  
>  /*
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e24e8a47ce8a..c4a8e6666ea6 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -315,14 +315,16 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  {
>  	int vm_shared = dst_vma->vm_flags & VM_SHARED;
>  	ssize_t err;
> -	pte_t *dst_pte;
>  	unsigned long src_addr, dst_addr;
>  	long copied;
>  	struct page *page;
> -	unsigned long vma_hpagesize;
> +	unsigned long vma_hpagesize, target_pagesize;
>  	pgoff_t idx;
>  	u32 hash;
>  	struct address_space *mapping;
> +	bool use_hgm = uffd_ctx_has_hgm(&dst_vma->vm_userfaultfd_ctx) &&
> +		mode == MCOPY_ATOMIC_CONTINUE;
> +	struct hstate *h = hstate_vma(dst_vma);
>  
>  	/*
>  	 * There is no default zero huge page for all huge page sizes as
> @@ -340,12 +342,13 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  	copied = 0;
>  	page = NULL;
>  	vma_hpagesize = vma_kernel_pagesize(dst_vma);
> +	target_pagesize = use_hgm ? PAGE_SIZE : vma_hpagesize;

Nit: "target_pagesize" is slightly misleading?  Because hgm can do e.g. 2M
on 1G too.  I feel like what you want to check here is the minimum
requirement, hence.. "min_pagesize"?

>  
>  	/*
> -	 * Validate alignment based on huge page size
> +	 * Validate alignment based on the targeted page size.
>  	 */
>  	err = -EINVAL;
> -	if (dst_start & (vma_hpagesize - 1) || len & (vma_hpagesize - 1))
> +	if (dst_start & (target_pagesize - 1) || len & (target_pagesize - 1))
>  		goto out_unlock;
>  
>  retry:
> @@ -362,6 +365,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  		err = -EINVAL;
>  		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
>  			goto out_unlock;
> +		if (use_hgm && !hugetlb_hgm_enabled(dst_vma))
> +			goto out_unlock;

Nit: this seems not needed, because enabling the hgm feature for uffd
requires to enable it in hugetlb already when register uffd above [1].

>  
>  		vm_shared = dst_vma->vm_flags & VM_SHARED;
>  	}
> @@ -376,13 +381,15 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  	}
>  
>  	while (src_addr < src_start + len) {
> +		struct hugetlb_pte hpte;
> +		pte_t *dst_pte;
>  		BUG_ON(dst_addr >= dst_start + len);
>  
>  		/*
>  		 * Serialize via vma_lock and hugetlb_fault_mutex.
> -		 * vma_lock ensures the dst_pte remains valid even
> -		 * in the case of shared pmds.  fault mutex prevents
> -		 * races with other faulting threads.
> +		 * vma_lock ensures the hpte.ptep remains valid even
> +		 * in the case of shared pmds and page table collapsing.
> +		 * fault mutex prevents races with other faulting threads.
>  		 */
>  		idx = linear_page_index(dst_vma, dst_addr);
>  		mapping = dst_vma->vm_file->f_mapping;
> @@ -390,23 +397,33 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  		mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  		hugetlb_vma_lock_read(dst_vma);
>  
> -		err = -ENOMEM;
> +		err = 0;
>  		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
> -		if (!dst_pte) {
> +		if (!dst_pte)
> +			err = -ENOMEM;
> +		else {
> +			hugetlb_pte_populate(&hpte, dst_pte, huge_page_shift(h),
> +					hpage_size_to_level(huge_page_size(h)));
> +			if (use_hgm)
> +				err = hugetlb_alloc_largest_pte(&hpte,
> +						dst_mm, dst_vma, dst_addr,
> +						dst_start + len);

dst_addr, not dst_start?

> +		}
> +		if (err) {
>  			hugetlb_vma_unlock_read(dst_vma);
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  			goto out_unlock;
>  		}
>  
>  		if (mode != MCOPY_ATOMIC_CONTINUE &&
> -		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
> +		    !huge_pte_none_mostly(huge_ptep_get(hpte.ptep))) {
>  			err = -EEXIST;
>  			hugetlb_vma_unlock_read(dst_vma);
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  			goto out_unlock;
>  		}
>  
> -		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
> +		err = hugetlb_mcopy_atomic_pte(dst_mm, &hpte, dst_vma,
>  					       dst_addr, src_addr, mode, &page,
>  					       wp_copy);
>  
> @@ -418,6 +435,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  		if (unlikely(err == -ENOENT)) {
>  			mmap_read_unlock(dst_mm);
>  			BUG_ON(!page);
> +			BUG_ON(hpte.shift != huge_page_shift(h));
>  
>  			err = copy_huge_page_from_user(page,
>  						(const void __user *)src_addr,
> @@ -435,9 +453,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  			BUG_ON(page);
>  
>  		if (!err) {
> -			dst_addr += vma_hpagesize;
> -			src_addr += vma_hpagesize;
> -			copied += vma_hpagesize;
> +			dst_addr += hugetlb_pte_size(&hpte);
> +			src_addr += hugetlb_pte_size(&hpte);
> +			copied += hugetlb_pte_size(&hpte);
>  
>  			if (fatal_signal_pending(current))
>  				err = -EINTR;
> -- 
> 2.38.0.135.g90850a2211-goog
> 

-- 
Peter Xu

