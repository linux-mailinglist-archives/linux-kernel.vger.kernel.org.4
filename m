Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59716952CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjBMVMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjBMVME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:12:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C88EF76C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676322675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XiJVIcYvNscRtU3tTbpdym+x/nlMCndCxJHWfBusVBY=;
        b=jGFln04okta/PPuZlebfl71MlhdEjZTb6Sj4bL/dbspFwJakvdA6D/+M9Otv61z8Ko5iOf
        IopTRO2qTWMvCu/ub4lM+DEjlS/45svDLEeooKCOKYUb5j3NUIUHqMxt2jUxXzunJe316z
        n5AFK3kdYRUtJL8wbwKk/3ixAhjbgyw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-122-YiprPQpVP5eM3F7DHnqhVA-1; Mon, 13 Feb 2023 16:11:14 -0500
X-MC-Unique: YiprPQpVP5eM3F7DHnqhVA-1
Received: by mail-qv1-f69.google.com with SMTP id ob12-20020a0562142f8c00b004c6c72bf1d0so7458640qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XiJVIcYvNscRtU3tTbpdym+x/nlMCndCxJHWfBusVBY=;
        b=MY6df9Uo6+zkGG5WqkQAnKRO/lu1bexXgZAcWXuqSK2u1IHDtleC4f0sMzT6JzZ+Z2
         tPqeRZLdGNVm3mdvTEML1pYtqubbQexCVm73SWrX4Ufn7KQIj1aaCQPOiznenJJ7jFKA
         rqIMfnjgGDGKENpMNp1fwe6QxrgdAd9QKszRnei0o/TYGEccjCuliEdQIov4dFdJBgr4
         L1sr6SmnX8rTiMGuPETs3woSnhYkkrO23wvjBaMcrOpJtxIJFOrgePL9UJFmjmApqyDk
         60u8kpyoH4oGWi5OZl5Zb6P+at4mSqBSPuwxr17Pa91+lE/gcSrs6hR6O77czP/NIE3O
         XdQw==
X-Gm-Message-State: AO0yUKVxW1llsGHAMqkjoBKnDeGByaIQlw8hxHnZfaSeL48AM/z+4xFu
        NS4sVJ4MxJlRvX5g05g+7k7I7B8Z+i6EI9OnzazegQqzam5b4IBzm3HJ17lrrYIrslRwVg++W55
        DS53cmlEll5oObcUndOia1/Fq
X-Received: by 2002:ac8:5e11:0:b0:3b9:fc92:a6 with SMTP id h17-20020ac85e11000000b003b9fc9200a6mr48707386qtx.6.1676322673482;
        Mon, 13 Feb 2023 13:11:13 -0800 (PST)
X-Google-Smtp-Source: AK7set8sSrs7hORs24WhXhw32Ev+Zs22yA69THTIL/t2cxEqBzMSvFcHbAuV4vp/ndv4tFzVWQMPew==
X-Received: by 2002:ac8:5e11:0:b0:3b9:fc92:a6 with SMTP id h17-20020ac85e11000000b003b9fc9200a6mr48707348qtx.6.1676322673086;
        Mon, 13 Feb 2023 13:11:13 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id i9-20020ac80049000000b003b646123691sm9966107qtg.31.2023.02.13.13.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 13:11:12 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:11:11 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     david@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, Paul Gofman <pgofman@codeweavers.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/userfaultfd: Support WP on multiple VMAs
Message-ID: <Y+qnb/Ix8P5J3Kl4@x1n>
References: <20230213163124.2850816-1-usama.anjum@collabora.com>
 <Y+prUgFQqmytC/5M@x1n>
 <9f0278d7-54f1-960e-ffdf-eeb2572ff6d1@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f0278d7-54f1-960e-ffdf-eeb2572ff6d1@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:50:39PM +0500, Muhammad Usama Anjum wrote:
> On 2/13/23 9:54 PM, Peter Xu wrote:
> > On Mon, Feb 13, 2023 at 09:31:23PM +0500, Muhammad Usama Anjum wrote:
> >> mwriteprotect_range() errors out if [start, end) doesn't fall in one
> >> VMA. We are facing a use case where multiple VMAs are present in one
> >> range of interest. For example, the following pseudocode reproduces the
> >> error which we are trying to fix:
> >>
> >> - Allocate memory of size 16 pages with PROT_NONE with mmap
> >> - Register userfaultfd
> >> - Change protection of the first half (1 to 8 pages) of memory to
> >>   PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
> >> - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
> >>   out.
> >>
> >> This is a simple use case where user may or may not know if the memory
> >> area has been divided into multiple VMAs.
> >>
> >> Reported-by: Paul Gofman <pgofman@codeweavers.com>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >> Changes since v1:
> >> - Correct the start and ending values passed to uffd_wp_range()
> >> ---
> >>  mm/userfaultfd.c | 38 ++++++++++++++++++++++----------------
> >>  1 file changed, 22 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> >> index 65ad172add27..bccea08005a8 100644
> >> --- a/mm/userfaultfd.c
> >> +++ b/mm/userfaultfd.c
> >> @@ -738,9 +738,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> >>  			unsigned long len, bool enable_wp,
> >>  			atomic_t *mmap_changing)
> >>  {
> >> +	unsigned long end = start + len;
> >> +	unsigned long _start, _end;
> >>  	struct vm_area_struct *dst_vma;
> >>  	unsigned long page_mask;
> >>  	int err;
> > 
> > I think this needs to be initialized or it can return anything when range
> > not mapped.
> It is being initialized to -EAGAIN already. It is not visible in this patch.

I see, though -EAGAIN doesn't look suitable at all.  The old retcode for
!vma case is -ENOENT, so I think we'd better keep using it if we want to
have this patch.

> 
> > 
> >> +	VMA_ITERATOR(vmi, dst_mm, start);
> >>  
> >>  	/*
> >>  	 * Sanitize the command parameters:
> >> @@ -762,26 +765,29 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> >>  	if (mmap_changing && atomic_read(mmap_changing))
> >>  		goto out_unlock;
> >>  
> >> -	err = -ENOENT;
> >> -	dst_vma = find_dst_vma(dst_mm, start, len);
> >> +	for_each_vma_range(vmi, dst_vma, end) {
> >> +		err = -ENOENT;
> >>  
> >> -	if (!dst_vma)
> >> -		goto out_unlock;
> >> -	if (!userfaultfd_wp(dst_vma))
> >> -		goto out_unlock;
> >> -	if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
> >> -		goto out_unlock;
> >> +		if (!dst_vma->vm_userfaultfd_ctx.ctx)
> >> +			break;
> >> +		if (!userfaultfd_wp(dst_vma))
> >> +			break;
> >> +		if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
> >> +			break;
> >>  
> >> -	if (is_vm_hugetlb_page(dst_vma)) {
> >> -		err = -EINVAL;
> >> -		page_mask = vma_kernel_pagesize(dst_vma) - 1;
> >> -		if ((start & page_mask) || (len & page_mask))
> >> -			goto out_unlock;
> >> -	}
> >> +		if (is_vm_hugetlb_page(dst_vma)) {
> >> +			err = -EINVAL;
> >> +			page_mask = vma_kernel_pagesize(dst_vma) - 1;
> >> +			if ((start & page_mask) || (len & page_mask))
> >> +				break;
> >> +		}
> >>  
> >> -	uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
> >> +		_start = (dst_vma->vm_start > start) ? dst_vma->vm_start : start;
> >> +		_end = (dst_vma->vm_end < end) ? dst_vma->vm_end : end;
> >>  
> >> -	err = 0;
> >> +		uffd_wp_range(dst_mm, dst_vma, _start, _end - _start, enable_wp);
> >> +		err = 0;
> >> +	}
> >>  out_unlock:
> >>  	mmap_read_unlock(dst_mm);
> >>  	return err;
> > 
> > This whole patch also changes the abi, so I'm worried whether there can be
> > app that relies on the existing behavior.
> Even if a app is dependent on it, this change would just don't return error
> if there are multiple VMAs under the hood and handle them correctly. Most
> apps wouldn't care about VMAs anyways. I don't know if there would be any
> drastic behavior change, other than the behavior becoming nicer.

So this logic existed since the initial version of uffd-wp.  It has a good
thing that it strictly checks everything and it makes sense since uffd-wp
is per-vma attribute.  In short, the old code fails clearly.

While the new proposal is not: if -ENOENT we really have no idea what
happened at all; some ranges can be wr-protected but we don't know where
starts to go wrong.

Now I'm looking at the original problem..

 - Allocate memory of size 16 pages with PROT_NONE with mmap
 - Register userfaultfd
 - Change protection of the first half (1 to 8 pages) of memory to
   PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
 - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
   out.

Why the user app should wr-protect 16 pages at all?

If so, uffd_wp_range() will be ran upon a PROT_NONE range which doesn't
make sense at all, no matter whether the user is aware of vma concept or
not...  because it's destined that it's a vain effort.

So IMHO it's the user app needs fixing here, not the interface?  I think
it's the matter of whether the monitor is aware of mprotect() being
invoked.

In short, I hope we're working on things that helps at least someone, and
we should avoid working on things that does not have clear benefit yet.
With the WP_ENGAGE new interface being proposed, I just didn't see any
benefit of changing the current interface, especially if the change can
bring uncertainties itself (e.g., should we fail upon !uffd-wp vmas, or
should we skip?).

> 
> > 
> > Is this for the new pagemap effort?  Can this just be done in the new
> > interface rather than changing the old?
> We found this bug while working on pagemap patches. It is already being
> handled in the new interface. We just thought that this use case can happen
> pretty easily and unknowingly. So the support should be added.

Thanks.  My understanding is that it would have been reported if it
affected any existing uffd-wp user.

> 
> Also mwriteprotect_range() gives a pretty straight forward way to WP or
> un-WP a range. Async WP can be used in coordination with pagemap file
> (PM_UFFD_WP flag in PTE) as well. There may be use cases for it. On another
> note, I don't see any use cases of WP async and PM_UFFD_WP flag as
> !PM_UFFD_WP flag doesn't give direct information if the page is written for
> !present pages.

Currently we do maintain PM_UFFD_WP even for swap entries, so if it was
written then I think we'll know even if the page was swapped out:

	} else if (is_swap_pte(pte)) {
		if (pte_swp_uffd_wp(pte))
			flags |= PM_UFFD_WP;
		if (pte_marker_entry_uffd_wp(entry))
			flags |= PM_UFFD_WP;

So it's working?

> 
> > 
> > Side note: in your other pagemap series, you can optimize "WP_ENGAGE &&
> > !GET" to not do generic pgtable walk at all, but use what it does in this
> > patch for the initial round or wr-protect.
> Yeah, it is implemented with some optimizations.

IIUC in your latest public version is not optimized, but I can check the
new version when it comes.

Thanks,

-- 
Peter Xu

