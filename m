Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8291C699A59
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBPQmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBPQmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:42:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293264CC97
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676565696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bGhOP28VyueXX4Bi5IrKSysrswJXvg2hNJ3iS4PanEE=;
        b=EccGF37Aj8U43UoWPOyKfwrTXiv4gDBQmWATp9h/czvxEe1MX/JPaoowjCgUT9x/hkHPRI
        ca6ctn92VYyMRUFmmQuiQPc0hJJsdkZ3xGN8UvO5rYEVhpYmVsjfCdi/S6EKlhd0MpqKOw
        HH24afgLvjpftDoqT7xF2yAFclfoLhU=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-Aq4LmizQMM-UffqMKgtwAw-1; Thu, 16 Feb 2023 11:41:35 -0500
X-MC-Unique: Aq4LmizQMM-UffqMKgtwAw-1
Received: by mail-io1-f72.google.com with SMTP id z23-20020a6b6517000000b00718172881acso1216499iob.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676565694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGhOP28VyueXX4Bi5IrKSysrswJXvg2hNJ3iS4PanEE=;
        b=ToZse72RECoDv9GV2RKBpM+PpFXZWQUVc1Ylzc1TRfTThal3qtVV5eIs9OAl4qDv4c
         zzeKe+/EWf3zVcR5NbpLcITSrggo8Ybt8SzIbGrKNFerTL396t49I6EKwHvWLowPEdo6
         v4qWABWriXkdLq1E5R0BuYmMqM+lZQWfvmRw2PsCLBfa8C1I3V41V3gcgRjHNK35xw+v
         XjYnN+P5C5b3cz0jFkbvxseQp/7czqzp22AvATI0zeBCnQVfdCR1TUy/H8J2NVIA6zS6
         C4r7Zdi0/G9vKxwO5028GoxvYU5PNrINrwlCdMVvhNNlOVOg1Whe7QzcbG9uZry6m0yV
         at2Q==
X-Gm-Message-State: AO0yUKUzzyJiPIzx3t56MoKAgrXiT1rN8C67UoK3vg1jplOPeFUJsCri
        l1EytCvzvfMmwJpAi4lettUhh1GZ9/X0vF3Q1NfPkCGP0n9iMiukMxhTFgqr0mK06hrk+rvO/bK
        AQy9JuaoD7gDxFsEJlLixlQLQ
X-Received: by 2002:a05:6e02:1a64:b0:314:9f2b:f63b with SMTP id w4-20020a056e021a6400b003149f2bf63bmr5589345ilv.2.1676565694229;
        Thu, 16 Feb 2023 08:41:34 -0800 (PST)
X-Google-Smtp-Source: AK7set8EQIpizwAeyF/gBQ87ce+QeJCbsggaFBRO0Ft/QkhDSyUr263BDqR9+/guGZoTRftR1ouFpw==
X-Received: by 2002:a05:6e02:1a64:b0:314:9f2b:f63b with SMTP id w4-20020a056e021a6400b003149f2bf63bmr5589316ilv.2.1676565693804;
        Thu, 16 Feb 2023 08:41:33 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id v14-20020a02b90e000000b003ab21c8fa84sm676437jan.121.2023.02.16.08.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 08:41:32 -0800 (PST)
Date:   Thu, 16 Feb 2023 11:41:31 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Paul Gofman <pgofman@codeweavers.com>, david@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/userfaultfd: Support WP on multiple VMAs
Message-ID: <Y+5cu9QMCy32ONBo@x1n>
References: <20230213163124.2850816-1-usama.anjum@collabora.com>
 <Y+prUgFQqmytC/5M@x1n>
 <9f0278d7-54f1-960e-ffdf-eeb2572ff6d1@collabora.com>
 <Y+qnb/Ix8P5J3Kl4@x1n>
 <0549bd0e-85c4-1547-3eaa-16c8a8883837@collabora.com>
 <Y+wCDUpuDcSDSQAK@x1n>
 <c9d3a306-0c5e-ad58-cffc-3c4c6b8b7433@collabora.com>
 <Y+1SdZqwS7LbcfaQ@x1n>
 <e35c7af0-d115-9808-61b5-cf8ab4356a35@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e35c7af0-d115-9808-61b5-cf8ab4356a35@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:25:51AM +0500, Muhammad Usama Anjum wrote:
> On 2/16/23 2:45 AM, Peter Xu wrote:
> > On Wed, Feb 15, 2023 at 12:08:11PM +0500, Muhammad Usama Anjum wrote:
> >> Hi Peter,
> >>
> >> Thank you for your review!
> >>
> >> On 2/15/23 2:50 AM, Peter Xu wrote:
> >>> On Tue, Feb 14, 2023 at 01:49:50PM +0500, Muhammad Usama Anjum wrote:
> >>>> On 2/14/23 2:11 AM, Peter Xu wrote:
> >>>>> On Mon, Feb 13, 2023 at 10:50:39PM +0500, Muhammad Usama Anjum wrote:
> >>>>>> On 2/13/23 9:54 PM, Peter Xu wrote:
> >>>>>>> On Mon, Feb 13, 2023 at 09:31:23PM +0500, Muhammad Usama Anjum wrote:
> >>>>>>>> mwriteprotect_range() errors out if [start, end) doesn't fall in one
> >>>>>>>> VMA. We are facing a use case where multiple VMAs are present in one
> >>>>>>>> range of interest. For example, the following pseudocode reproduces the
> >>>>>>>> error which we are trying to fix:
> >>>>>>>>
> >>>>>>>> - Allocate memory of size 16 pages with PROT_NONE with mmap
> >>>>>>>> - Register userfaultfd
> >>>>>>>> - Change protection of the first half (1 to 8 pages) of memory to
> >>>>>>>>   PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
> >>>>>>>> - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
> >>>>>>>>   out.
> >>>>>>>>
> >>>>>>>> This is a simple use case where user may or may not know if the memory
> >>>>>>>> area has been divided into multiple VMAs.
> >>>>>>>>
> >>>>>>>> Reported-by: Paul Gofman <pgofman@codeweavers.com>
> >>>>>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >>>>>>>> ---
> >>>>>>>> Changes since v1:
> >>>>>>>> - Correct the start and ending values passed to uffd_wp_range()
> >>>>>>>> ---
> >>>>>>>>  mm/userfaultfd.c | 38 ++++++++++++++++++++++----------------
> >>>>>>>>  1 file changed, 22 insertions(+), 16 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> >>>>>>>> index 65ad172add27..bccea08005a8 100644
> >>>>>>>> --- a/mm/userfaultfd.c
> >>>>>>>> +++ b/mm/userfaultfd.c
> >>>>>>>> @@ -738,9 +738,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> >>>>>>>>  			unsigned long len, bool enable_wp,
> >>>>>>>>  			atomic_t *mmap_changing)
> >>>>>>>>  {
> >>>>>>>> +	unsigned long end = start + len;
> >>>>>>>> +	unsigned long _start, _end;
> >>>>>>>>  	struct vm_area_struct *dst_vma;
> >>>>>>>>  	unsigned long page_mask;
> >>>>>>>>  	int err;
> >>>>>>>
> >>>>>>> I think this needs to be initialized or it can return anything when range
> >>>>>>> not mapped.
> >>>>>> It is being initialized to -EAGAIN already. It is not visible in this patch.
> >>>>>
> >>>>> I see, though -EAGAIN doesn't look suitable at all.  The old retcode for
> >>>>> !vma case is -ENOENT, so I think we'd better keep using it if we want to
> >>>>> have this patch.
> >>>> I'll update in next version.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> +	VMA_ITERATOR(vmi, dst_mm, start);
> >>>>>>>>  
> >>>>>>>>  	/*
> >>>>>>>>  	 * Sanitize the command parameters:
> >>>>>>>> @@ -762,26 +765,29 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> >>>>>>>>  	if (mmap_changing && atomic_read(mmap_changing))
> >>>>>>>>  		goto out_unlock;
> >>>>>>>>  
> >>>>>>>> -	err = -ENOENT;
> >>>>>>>> -	dst_vma = find_dst_vma(dst_mm, start, len);
> >>>>>>>> +	for_each_vma_range(vmi, dst_vma, end) {
> >>>>>>>> +		err = -ENOENT;
> >>>>>>>>  
> >>>>>>>> -	if (!dst_vma)
> >>>>>>>> -		goto out_unlock;
> >>>>>>>> -	if (!userfaultfd_wp(dst_vma))
> >>>>>>>> -		goto out_unlock;
> >>>>>>>> -	if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
> >>>>>>>> -		goto out_unlock;
> >>>>>>>> +		if (!dst_vma->vm_userfaultfd_ctx.ctx)
> >>>>>>>> +			break;
> >>>>>>>> +		if (!userfaultfd_wp(dst_vma))
> >>>>>>>> +			break;
> >>>>>>>> +		if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
> >>>>>>>> +			break;
> >>>>>>>>  
> >>>>>>>> -	if (is_vm_hugetlb_page(dst_vma)) {
> >>>>>>>> -		err = -EINVAL;
> >>>>>>>> -		page_mask = vma_kernel_pagesize(dst_vma) - 1;
> >>>>>>>> -		if ((start & page_mask) || (len & page_mask))
> >>>>>>>> -			goto out_unlock;
> >>>>>>>> -	}
> >>>>>>>> +		if (is_vm_hugetlb_page(dst_vma)) {
> >>>>>>>> +			err = -EINVAL;
> >>>>>>>> +			page_mask = vma_kernel_pagesize(dst_vma) - 1;
> >>>>>>>> +			if ((start & page_mask) || (len & page_mask))
> >>>>>>>> +				break;
> >>>>>>>> +		}
> >>>>>>>>  
> >>>>>>>> -	uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
> >>>>>>>> +		_start = (dst_vma->vm_start > start) ? dst_vma->vm_start : start;
> >>>>>>>> +		_end = (dst_vma->vm_end < end) ? dst_vma->vm_end : end;
> >>>>>>>>  
> >>>>>>>> -	err = 0;
> >>>>>>>> +		uffd_wp_range(dst_mm, dst_vma, _start, _end - _start, enable_wp);
> >>>>>>>> +		err = 0;
> >>>>>>>> +	}
> >>>>>>>>  out_unlock:
> >>>>>>>>  	mmap_read_unlock(dst_mm);
> >>>>>>>>  	return err;
> >>>>>>>
> >>>>>>> This whole patch also changes the abi, so I'm worried whether there can be
> >>>>>>> app that relies on the existing behavior.
> >>>>>> Even if a app is dependent on it, this change would just don't return error
> >>>>>> if there are multiple VMAs under the hood and handle them correctly. Most
> >>>>>> apps wouldn't care about VMAs anyways. I don't know if there would be any
> >>>>>> drastic behavior change, other than the behavior becoming nicer.
> >>>>>
> >>>>> So this logic existed since the initial version of uffd-wp.  It has a good
> >>>>> thing that it strictly checks everything and it makes sense since uffd-wp
> >>>>> is per-vma attribute.  In short, the old code fails clearly.
> >>>>>
> >>>>> While the new proposal is not: if -ENOENT we really have no idea what
> >>>>> happened at all; some ranges can be wr-protected but we don't know where
> >>>>> starts to go wrong.
> >>>> The return error codes can be made to return in better way somewhat. The
> >>>> return error codes shouldn't block a correct functionality enhancement patch.
> >>>>
> >>>>>
> >>>>> Now I'm looking at the original problem..
> >>>>>
> >>>>>  - Allocate memory of size 16 pages with PROT_NONE with mmap
> >>>>>  - Register userfaultfd
> >>>>>  - Change protection of the first half (1 to 8 pages) of memory to
> >>>>>    PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
> >>>>>  - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
> >>>>>    out.
> >>>>>
> >>>>> Why the user app should wr-protect 16 pages at all?
> >>>> Taking arguments from Paul here.
> >>>>
> >>>> The app is free to insert guard pages inside the range (with PROT_NONE) and
> >>>> change the protection of memory freely. Not sure why it is needed to
> >>>> complicate things by denying any flexibility. We should never restrict what
> >>>> is possible and what not. All of these different access attributes and
> >>>> their any combination of interaction _must_ work without question. The
> >>>> application should be free to change protection on any sub-range and it
> >>>> shouldn't break the PAGE_IS_WRITTEN + UFFD_WRITE_PROTECT promise which
> >>>> PAGEMAP_IOCTL (patches are in progress) and UFFD makes.
> >>>
> >>> Because uffd-wp has a limitation on e.g. it cannot nest so far.  I'm fine
> >>> with allowing mprotect() happening, but just to mention so far it cannot do
> >>> "any combinations" yet.
> >>>
> >>>>
> >>>>>
> >>>>> If so, uffd_wp_range() will be ran upon a PROT_NONE range which doesn't
> >>>>> make sense at all, no matter whether the user is aware of vma concept or
> >>>>> not...  because it's destined that it's a vain effort.
> >>>> It is not a vain effort. The user want to watch/find the dirty pages of a
> >>>> range while working with it: reserve and watch at once while Write
> >>>> protecting or un-protecting as needed. There may be several different use
> >>>> cases. Inserting guard pages to catch out of range access, map something
> >>>> only when it is needed; unmap or PROT_NONE pages when they are set free in
> >>>> the app etc.
> >>>
> >>> Fair enough.
> >>>
> >>>>
> >>>>>
> >>>>> So IMHO it's the user app needs fixing here, not the interface?  I think
> >>>>> it's the matter of whether the monitor is aware of mprotect() being
> >>>>> invoked.
> >>>> No. The common practice is to allocate a big memory chunk at once and have
> >>>> own allocator over it (whether it is some specific allocator in a game or a
> >>>> .net allocator with garbage collector). From the usage point of view it is
> >>>> very limiting to demand constant memory attributes for the whole range.
> >>>>
> >>>> That said, if we do have the way to do exactly what we want with reset
> >>>> through pagemap fd and it is just UFFD ioctl will be working differently,
> >>>> it is not a blocker of course, just weird api design.
> >>>
> >>> Do you mean you'll disable ENGAGE_WP && !GET in your other series?  Yes, if
> >>> this will service your goal, it'll be perfect to remove that interface.
> >> No, we cannot remove it.
> > 
> > If this patch can land, I assume ioctl(UFFDIO_WP) can start to service the
> > dirty tracking purpose, then why do you still need "ENGAGE_WP && !GET"?
> We don't need it. We need the following operations only:
> 1 GET
> 2 ENGAGE_WP + GET
> When we have these two operations, we had added the following as well:
> 3 ENGAGE_WP + !GET or only ENGAGE_WP
> This (3) can be removed from ioctl(PAGEMAP_IOCTL) if reviewers ask. I can
> remove it in favour of this ioctl(UFFDIO_WP) patch for sure.

Yes I prefer not having it if this works, because then they'll be
completely duplicated.

> 
> > 
> > Note, I'm not asking to drop ENGAGE_WP entirely, only when !GET.
> > 
> >>
> >>>
> >>>>
> >>>>>
> >>>>> In short, I hope we're working on things that helps at least someone, and
> >>>>> we should avoid working on things that does not have clear benefit yet.
> >>>>> With the WP_ENGAGE new interface being proposed, I just didn't see any
> >>>>> benefit of changing the current interface, especially if the change can
> >>>>> bring uncertainties itself (e.g., should we fail upon !uffd-wp vmas, or
> >>>>> should we skip?).
> >>>> We can work on solving uncertainties in case of error conditions. Fail if
> >>>> !uffd-wp vma comes.
> >>>
> >>> Let me try to double check with you here:
> >>>
> >>> I assume you want to skip any vma that is not mapped at all, as the loop
> >>> already does so.  So it'll succeed if there're memory holes.
> >>>
> >>> You also want to explicitly fail if some vma is not registered with uffd-wp
> >>> when walking the vma list, am I right?  IOW, the tracee _won't_ ever have a
> >>> chance to unregister uffd-wp itself, right?
> >> Yes, fail if any VMA doesn't have uffd-wp. This fail means the
> >> write-protection or un-protection failed on a region of memory with error
> >> -ENOENT. This is already happening in this current patch. The unregister
> >> code would remain same. The register and unregister ioctls are already
> >> going over all the VMAs in a range. I'm not rigid on anything. Let me
> >> define the interface below.
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Is this for the new pagemap effort?  Can this just be done in the new
> >>>>>>> interface rather than changing the old?
> >>>>>> We found this bug while working on pagemap patches. It is already being
> >>>>>> handled in the new interface. We just thought that this use case can happen
> >>>>>> pretty easily and unknowingly. So the support should be added.
> >>>>>
> >>>>> Thanks.  My understanding is that it would have been reported if it
> >>>>> affected any existing uffd-wp user.
> >>>> I would consider the UFFD WP a recent functionality and it may not being
> >>>> used in wide range of app scenarios.
> >>>
> >>> Yes I think so.
> >>>
> >>> Existing users should in most cases be applying the ioctl upon valid vmas
> >>> somehow.  I think the chance is low that someone relies on the errcode to
> >>> make other decisions, but I just cannot really tell because the user app
> >>> can do many weird things.
> >> Correct. The user can use any combination of operation
> >> (mmap/mprotect/uffd). They must work in harmony.
> > 
> > No uffd - that's exactly what I'm saying: mprotect is fine here, but uffd
> > is probably not, not in a nested way.  When you try to UFFDIO_REGISTER upon
> > some range that already been registered (by the tracee), it'll fail for you
> > immediately:
> > 
> > 		/*
> > 		 * Check that this vma isn't already owned by a
> > 		 * different userfaultfd. We can't allow more than one
> > 		 * userfaultfd to own a single vma simultaneously or we
> > 		 * wouldn't know which one to deliver the userfaults to.
> > 		 */
> > 		ret = -EBUSY;
> > 		if (cur->vm_userfaultfd_ctx.ctx &&
> > 		    cur->vm_userfaultfd_ctx.ctx != ctx)
> > 			goto out_unlock;
> > 
> > So if this won't work for you, then AFAICT uffd-wp won't work for you (just
> > like soft-dirty but in another way, sorry), at least not until someone
> > starts to work on the nested.
> I was referring to a case where user registers the WP on multiple VMAs and
> all the VMAs haven't been registered before. It would work. Right?

But what if the user wants to do that during when you're tracing it using
userfaultfd?  Can it happen?

Thanks,

-- 
Peter Xu

