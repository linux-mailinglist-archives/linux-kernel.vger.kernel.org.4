Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25D064779F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLHVCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiLHVCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:02:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25DEBFF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670533312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVzt3hEvVKmirkShWRFT/f18dZYrhrH4zy5lPi2xfE8=;
        b=QsPAnYJPHqj+ya6/yv5P0xNMI9JL7VJwO4P2ZIOTnU2VH98oLgekX0M9WksAA485CrpeP6
        JT3obOunHQ6tYCwDhgh8fUwISA8rJtUhbQsWPWdq5KuF/78mkmthe86fHVTwNq1ImkXbXr
        jmckXyhQvTd+NT3HhUZqQz9aeihkjao=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-348-xSjzzqE8NY-ZTZuNLI8rgQ-1; Thu, 08 Dec 2022 16:01:51 -0500
X-MC-Unique: xSjzzqE8NY-ZTZuNLI8rgQ-1
Received: by mail-vs1-f71.google.com with SMTP id q28-20020a056102205c00b003b0cb47410bso769925vsr.20
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 13:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVzt3hEvVKmirkShWRFT/f18dZYrhrH4zy5lPi2xfE8=;
        b=6vNJh630ZMcTqUGF8zLPZVqlRhyX91J/3K39aYfjBfoO/9c90joZhYzjnVNaFuuJLG
         sVZnpKIOirzjrP499vlv/r9MWRwY9X82LAcLL2MHEVkuf20OJ+D/yd/ZG4RRs+FZEFhp
         YbM6NT5oFcY4BZZ0qCJIYRum+Jo23uXgV2L3loWIwZpXxtcKn0T7ZwvERy7OtE7UHrOB
         q8rjiaO5jih0w3aSWl1hwCJTxkkMEN5Dc/pAle7JcYmGELXZcCnyfzrBbTd+P9i+KDW9
         SaCCYEKafHjuA8aQN32gFo8liUgzRxEVb1DJGERSQsAF8fpBwAbSGWYc5aBMX21hDBdF
         XS+w==
X-Gm-Message-State: ANoB5pl8GmbAnwD+l/3oI7GY9P7tqoQHyrgBjhoYtfUsW4NDFRGsmGmT
        dqPPcTg4i/+AdkLiBi6/gIBJD8Iv64TVDExqL9GJI1EZc66Mxmnu5qs2btfIkkymPkNrunWcHCf
        XwWa4pNRcjipT5Ne4FGmOZC4T
X-Received: by 2002:a1f:a705:0:b0:3af:2f12:c9d2 with SMTP id q5-20020a1fa705000000b003af2f12c9d2mr1648429vke.3.1670533310942;
        Thu, 08 Dec 2022 13:01:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4d/GUuJc3kVNDuJ8r82nlGsRFmGfKd/+nOwDLcHsBN3Z1SwVWHCQsCqv/JcBXQqgG/gaWRUQ==
X-Received: by 2002:a1f:a705:0:b0:3af:2f12:c9d2 with SMTP id q5-20020a1fa705000000b003af2f12c9d2mr1648405vke.3.1670533310607;
        Thu, 08 Dec 2022 13:01:50 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id w17-20020a05620a425100b006eef13ef4c8sm20538281qko.94.2022.12.08.13.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:01:50 -0800 (PST)
Date:   Thu, 8 Dec 2022 16:01:48 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 09/10] mm/hugetlb: Introduce hugetlb_walk()
Message-ID: <Y5JQvElUNz6yGsrT@x1n>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203156.651077-1-peterx@redhat.com>
 <3b5579e8-8e51-a2e2-4c93-6709f8833723@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b5579e8-8e51-a2e2-4c93-6709f8833723@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 04:12:31PM -0800, John Hubbard wrote:
> On 12/7/22 12:31, Peter Xu wrote:
> > huge_pte_offset() is the main walker function for hugetlb pgtables.  The
> > name is not really representing what it does, though.
> > 
> > Instead of renaming it, introduce a wrapper function called hugetlb_walk()
> > which will use huge_pte_offset() inside.  Assert on the locks when walking
> > the pgtable.
> > 
> > Note, the vma lock assertion will be a no-op for private mappings.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   fs/hugetlbfs/inode.c    |  4 +---
> >   fs/userfaultfd.c        |  6 ++----
> >   include/linux/hugetlb.h | 39 +++++++++++++++++++++++++++++++++++++++
> >   mm/hugetlb.c            | 32 +++++++++++++-------------------
> >   mm/page_vma_mapped.c    |  2 +-
> >   mm/pagewalk.c           |  4 +---
> >   6 files changed, 57 insertions(+), 30 deletions(-)
> > 
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index fdb16246f46e..48f1a8ad2243 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -388,9 +388,7 @@ static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
> >   {
> >   	pte_t *ptep, pte;
> > -	ptep = huge_pte_offset(vma->vm_mm, addr,
> > -			huge_page_size(hstate_vma(vma)));
> > -
> > +	ptep = hugetlb_walk(vma, addr, huge_page_size(hstate_vma(vma)));
> >   	if (!ptep)
> >   		return false;
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index a602f008dde5..f31fe1a9f4c5 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -237,14 +237,12 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
> >   					 unsigned long flags,
> >   					 unsigned long reason)
> >   {
> > -	struct mm_struct *mm = ctx->mm;
> >   	pte_t *ptep, pte;
> >   	bool ret = true;
> > -	mmap_assert_locked(mm);
> > -
> > -	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
> > +	mmap_assert_locked(ctx->mm);
> > +	ptep = hugetlb_walk(vma, address, vma_mmu_pagesize(vma));
> >   	if (!ptep)
> >   		goto out;
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 81efd9b9baa2..1c20cbbf3d22 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -2,6 +2,7 @@
> >   #ifndef _LINUX_HUGETLB_H
> >   #define _LINUX_HUGETLB_H
> > +#include <linux/mm.h>
> >   #include <linux/mm_types.h>
> >   #include <linux/mmdebug.h>
> >   #include <linux/fs.h>
> > @@ -196,6 +197,11 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
> >    * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
> >    * Returns the pte_t* if found, or NULL if the address is not mapped.
> >    *
> > + * IMPORTANT: we should normally not directly call this function, instead
> > + * this is only a common interface to implement arch-specific walker.
> > + * Please consider using the hugetlb_walk() helper to make sure of the
> > + * correct locking is satisfied.
> 
> Or:
> 
> "Please use hugetlb_walk() instead, because that will attempt to verify
> the locking for you."

Ok.

> 
> > + *
> >    * Since this function will walk all the pgtable pages (including not only
> >    * high-level pgtable page, but also PUD entry that can be unshared
> >    * concurrently for VM_SHARED), the caller of this function should be
> > @@ -1229,4 +1235,37 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
> >   #define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
> >   #endif
> > +static inline bool
> > +__vma_shareable_flags_pmd(struct vm_area_struct *vma)
> > +{
> > +	return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
> > +		vma->vm_private_data;
> > +}
> > +
> > +/*
> > + * Safe version of huge_pte_offset() to check the locks.  See comments
> > + * above huge_pte_offset().
> > + */
> 
> It is odd to say that functionA() is a safe version of functionB(), if the
> names are completely different.
> 
> At this point, it is very clear that huge_pte_offset() should be renamed.
> I'd suggest something like one of these:
> 
>     __hugetlb_walk()
>     hugetlb_walk_raw()

We can.

Not only because that's an arch api for years (didn't want to touch more
arch code unless necessary), but also since we have hugetlb_walk() that'll
be the future interface not huge_pte_offset().

Actually it's good when that's the only thing people can find from its name
when they want to have a huge pgtable walk. :)

So totally makes sense to do so, but I don't strongly feel like doing it in
this patchset if you're okay with it.

> 
> > +static inline pte_t *
> > +hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
> > +{
> > +#if defined(CONFIG_HUGETLB_PAGE) && \
> > +	defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
> > +	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
> > +
> > +	/*
> > +	 * If pmd sharing possible, locking needed to safely walk the
> > +	 * hugetlb pgtables.  More information can be found at the comment
> > +	 * above huge_pte_offset() in the same file.
> > +	 *
> > +	 * NOTE: lockdep_is_held() is only defined with CONFIG_LOCKDEP.
> > +	 */
> > +	if (__vma_shareable_flags_pmd(vma))
> > +		WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
> > +			     !lockdep_is_held(
> > +				 &vma->vm_file->f_mapping->i_mmap_rwsem));
> > +#endif
> > +	return huge_pte_offset(vma->vm_mm, addr, sz);
> > +}
> 
> Let's please not slice up C functions with ifdefs. Instead, stick to the
> standard approach of
> 
> #ifdef X
> functionC()
> {
> 	...implementation
> }
> #else
> functionC()
> {
> 	...simpler or shorter or stub implementation
> }

Personally I like the slicing because it clearly tells what's the
difference with/without the macros defined.

Thanks,

-- 
Peter Xu

