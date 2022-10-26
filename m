Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702C260EAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 23:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJZVoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 17:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJZVoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BD7C0D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666820666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FGEAcGAjAMPOazJHa2zAyqoTgNuI6YN3F8egocsHkTg=;
        b=UesbWBVROI0Rg+wb+LnokhXtDvaEynLU/7tE6PgYTDoOeexpG5SxBO3R6Sl02O0IZdmI6J
        PeAnc27ttEweXcns5P7IMEpVSCH9rmmVq2OGBPb95xsbST9/naQp+drnK8TFnGG+l1KGRU
        I01EOfvBT7N+Y/X5XMC+tuN4szARt7M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-196-YtY6g-kdP2-W4KkEwt0Ubg-1; Wed, 26 Oct 2022 17:44:25 -0400
X-MC-Unique: YtY6g-kdP2-W4KkEwt0Ubg-1
Received: by mail-qk1-f198.google.com with SMTP id u9-20020a05620a454900b006eeafac8ea4so15160263qkp.19
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGEAcGAjAMPOazJHa2zAyqoTgNuI6YN3F8egocsHkTg=;
        b=RT1lJSpyvGHFhbQAHzvxPn6J4aCpOxW/RMyU3BYJsR2SjGPnBTCBdn0/X565DEj6zO
         L1viz47BunET8JyseKT1m/05/8mMDizs0VenQGknwaO5ILCvH1Fh32WQXWCi88i9JNcN
         4v+EPIF+RardkyZiB7tC7qlqsqwQesooCydtUzXNk/xcIH7nwSHFwbNjdLhITi44F0eH
         s5wutD3UGHCNCfqFTl6jYs8eUk+YjpL3zoejyvKS33jXaWAt42udlc1Hsoy/3NVwzUNh
         lt086/b2Zf/Dh/zM4gDYg70suHeeUxTFb4FDYfeSwcGDmzEBdsfX2RD/WfDnoo177cpM
         isaw==
X-Gm-Message-State: ACrzQf0nl0g5G7jxbYGQLaQSsgnOnolKChIZBhE9e1VCMP9nQoMk7xTa
        V3zUvpQC55Jt91M7ltOJJzSYx3sA2EgNiX48s9Apvujo7APHlJaVddfEhbSxmbonm+z2ZCqJJVK
        Un0SMa3J2OcZUB0tfW6JhRDc4
X-Received: by 2002:a37:f61d:0:b0:6ec:cafa:4741 with SMTP id y29-20020a37f61d000000b006eccafa4741mr31814352qkj.761.1666820663336;
        Wed, 26 Oct 2022 14:44:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7HHTcYSpvmiPVnb/2bsgS5xXso9GWJqdZfKpadyAATz9h1MRXRKgSf2YjE5S4eVRVaZ0aPOg==
X-Received: by 2002:a37:f61d:0:b0:6ec:cafa:4741 with SMTP id y29-20020a37f61d000000b006eccafa4741mr31814329qkj.761.1666820663061;
        Wed, 26 Oct 2022 14:44:23 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bk30-20020a05620a1a1e00b006eeaf9160d6sm4644656qkb.24.2022.10.26.14.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:42:52 -0700 (PDT)
Date:   Wed, 26 Oct 2022 17:42:24 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Chen <harperchen1110@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] hugetlb: don't delete vma_lock in hugetlb
 MADV_DONTNEED processing
Message-ID: <Y1mpwKpwsiN6u6r7@x1n>
References: <20221023025047.470646-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221023025047.470646-1-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike,

On Sat, Oct 22, 2022 at 07:50:47PM -0700, Mike Kravetz wrote:

[...]

> -void __unmap_hugepage_range_final(struct mmu_gather *tlb,
> +static void __unmap_hugepage_range_locking(struct mmu_gather *tlb,
>  			  struct vm_area_struct *vma, unsigned long start,
>  			  unsigned long end, struct page *ref_page,
> -			  zap_flags_t zap_flags)
> +			  zap_flags_t zap_flags, bool final)
>  {
>  	hugetlb_vma_lock_write(vma);
>  	i_mmap_lock_write(vma->vm_file->f_mapping);
>  
>  	__unmap_hugepage_range(tlb, vma, start, end, ref_page, zap_flags);
>  
> -	/*
> -	 * Unlock and free the vma lock before releasing i_mmap_rwsem.  When
> -	 * the vma_lock is freed, this makes the vma ineligible for pmd
> -	 * sharing.  And, i_mmap_rwsem is required to set up pmd sharing.
> -	 * This is important as page tables for this unmapped range will
> -	 * be asynchrously deleted.  If the page tables are shared, there
> -	 * will be issues when accessed by someone else.
> -	 */
> -	__hugetlb_vma_unlock_write_free(vma);
> +	if (final) {
> +		/*
> +		 * Unlock and free the vma lock before releasing i_mmap_rwsem.
> +		 * When the vma_lock is freed, this makes the vma ineligible
> +		 * for pmd sharing.  And, i_mmap_rwsem is required to set up
> +		 * pmd sharing.  This is important as page tables for this
> +		 * unmapped range will be asynchrously deleted.  If the page
> +		 * tables are shared, there will be issues when accessed by
> +		 * someone else.
> +		 */
> +		__hugetlb_vma_unlock_write_free(vma);
> +		i_mmap_unlock_write(vma->vm_file->f_mapping);

Pure question: can we rely on hugetlb_vm_op_close() to destroy the hugetlb
vma lock?

I read the comment above, it seems we are trying to avoid racing with pmd
sharing, but I don't see how that could ever happen, since iiuc there
should only be two places that unmaps the vma (final==true):

  (1) munmap: we're holding write lock, so no page fault possible
  (2) exit_mmap: we've already reset current->mm so no page fault possible

> +	} else {
> +		i_mmap_unlock_write(vma->vm_file->f_mapping);
> +		hugetlb_vma_unlock_write(vma);
> +	}
> +}
>  
> -	i_mmap_unlock_write(vma->vm_file->f_mapping);
> +void __unmap_hugepage_range_final(struct mmu_gather *tlb,
> +			  struct vm_area_struct *vma, unsigned long start,
> +			  unsigned long end, struct page *ref_page,
> +			  zap_flags_t zap_flags)
> +{
> +	__unmap_hugepage_range_locking(tlb, vma, start, end, ref_page,
> +					zap_flags, true);
>  }
>  
> +#ifdef CONFIG_ADVISE_SYSCALLS
> +/*
> + * Similar setup as in zap_page_range().  madvise(MADV_DONTNEED) can not call
> + * zap_page_range for hugetlb vmas as __unmap_hugepage_range_final will delete
> + * the associated vma_lock.
> + */
> +void clear_hugetlb_page_range(struct vm_area_struct *vma, unsigned long start,
> +				unsigned long end)
> +{
> +	struct mmu_notifier_range range;
> +	struct mmu_gather tlb;
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
> +				start, end);

Is mmu_notifier_invalidate_range_start() missing here?

> +	tlb_gather_mmu(&tlb, vma->vm_mm);
> +	update_hiwater_rss(vma->vm_mm);
> +
> +	__unmap_hugepage_range_locking(&tlb, vma, start, end, NULL, 0, false);
> +
> +	mmu_notifier_invalidate_range_end(&range);
> +	tlb_finish_mmu(&tlb);
> +}
> +#endif
> +
>  void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
>  			  unsigned long end, struct page *ref_page,
>  			  zap_flags_t zap_flags)
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 2baa93ca2310..90577a669635 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -790,7 +790,10 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
>  static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
>  					unsigned long start, unsigned long end)
>  {
> -	zap_page_range(vma, start, end - start);
> +	if (!is_vm_hugetlb_page(vma))
> +		zap_page_range(vma, start, end - start);
> +	else
> +		clear_hugetlb_page_range(vma, start, end);
>  	return 0;
>  }

This does look a bit unfortunate - zap_page_range() contains yet another
is_vm_hugetlb_page() check (further down in unmap_single_vma), it can be
very confusing on which code path is really handling hugetlb.

The other mm_users check in v3 doesn't need this change, but was a bit
hackish to me, because IIUC we're clear on the call paths to trigger this
(unmap_vmas), so it seems clean to me to pass that info from the upper
stack.

Maybe we can have a new zap_flags passed into unmap_single_vma() showing
that it's destroying the vma?

Thanks,

-- 
Peter Xu

