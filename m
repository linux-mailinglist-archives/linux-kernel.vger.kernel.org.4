Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC9E69700F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjBNVu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjBNVu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:50:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC024C89
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676411409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vd2D3kh6MSl0+HEN6i6jUwW/5XgFEq3zA+v5AiLWsl0=;
        b=V7pxAzQgwJ+X8C5by2YeivSQRiC3+4GjzUtmmbn4BXmb0raXg3FeA3aJBtPLanFX5sIySb
        KbPUu6O5T3c79Ck81vmknWqv4LTfcfja/9Ev8UtkyUFvogEv8lPd4GGYQd1gxz3RodDn5y
        YV4UXNGlMqkQbvmyOBHvRY3ShZD63yg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-580-_l2VAFJ8PDSUyB2E3BgOKQ-1; Tue, 14 Feb 2023 16:50:07 -0500
X-MC-Unique: _l2VAFJ8PDSUyB2E3BgOKQ-1
Received: by mail-qv1-f71.google.com with SMTP id w2-20020a0cc702000000b0055c8ef137ddso9476576qvi.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676411407;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd2D3kh6MSl0+HEN6i6jUwW/5XgFEq3zA+v5AiLWsl0=;
        b=qoc8og8llEQ5H983XAi6D67fFdCpC1ypFQqXFZa098xdOgyxbskuTzDDPza8L+aZ6t
         LJZTAu1e1LO4ksH4mfHaSUmC2SALipbAShF7GyPpg/um5h6V3lsjuQBQgrqk4c+vVlQR
         JSfNo4wPIs2R7GZfU6VlaKdfD6WJM53qwLinFbn/GIFGx0K4zcYB9giHcr96GrWZn7TT
         zt+4AFT8s99OmGT9bdAmUfQzjmbJvykU9c/Oddqof5r+ZkDKeC2y/5ey8a+n7EZ7GtNW
         0sdblD2TKVoxXbcIk5VAvBLiii32FRmMUA8Yed6uwAdoDrsRMgKJocC+I6FS73M2NQVa
         OOVg==
X-Gm-Message-State: AO0yUKWsIqM0jpTT7iEWks1odWQ30P+zNC/JRxWP2nitJoPI1vPxCNBu
        WQCubsfICumZDw+TGSy5M4WoomUohWrux+ob4nK2OxmaJyNpYx0fVj5sOs8tWTOwuMdgx3KpPmZ
        RyoXt/B20z2U2FGvN5AvBsaiQ
X-Received: by 2002:a05:622a:118a:b0:39c:da22:47b8 with SMTP id m10-20020a05622a118a00b0039cda2247b8mr7708483qtk.1.1676411407338;
        Tue, 14 Feb 2023 13:50:07 -0800 (PST)
X-Google-Smtp-Source: AK7set9TMggUZoRSSsqv/6SNCp+qa0t1KSHcK3Ju4tKU9FTle9jkwRzB+AkKjTtCtUOeYnEc7sHTsQ==
X-Received: by 2002:a05:622a:118a:b0:39c:da22:47b8 with SMTP id m10-20020a05622a118a00b0039cda2247b8mr7708439qtk.1.1676411406915;
        Tue, 14 Feb 2023 13:50:06 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id z12-20020ac87cac000000b003b9bc00c2f1sm11692685qtv.94.2023.02.14.13.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:50:06 -0800 (PST)
Date:   Tue, 14 Feb 2023 16:50:05 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Paul Gofman <pgofman@codeweavers.com>, david@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/userfaultfd: Support WP on multiple VMAs
Message-ID: <Y+wCDUpuDcSDSQAK@x1n>
References: <20230213163124.2850816-1-usama.anjum@collabora.com>
 <Y+prUgFQqmytC/5M@x1n>
 <9f0278d7-54f1-960e-ffdf-eeb2572ff6d1@collabora.com>
 <Y+qnb/Ix8P5J3Kl4@x1n>
 <0549bd0e-85c4-1547-3eaa-16c8a8883837@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0549bd0e-85c4-1547-3eaa-16c8a8883837@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:49:50PM +0500, Muhammad Usama Anjum wrote:
> On 2/14/23 2:11 AM, Peter Xu wrote:
> > On Mon, Feb 13, 2023 at 10:50:39PM +0500, Muhammad Usama Anjum wrote:
> >> On 2/13/23 9:54 PM, Peter Xu wrote:
> >>> On Mon, Feb 13, 2023 at 09:31:23PM +0500, Muhammad Usama Anjum wrote:
> >>>> mwriteprotect_range() errors out if [start, end) doesn't fall in one
> >>>> VMA. We are facing a use case where multiple VMAs are present in one
> >>>> range of interest. For example, the following pseudocode reproduces the
> >>>> error which we are trying to fix:
> >>>>
> >>>> - Allocate memory of size 16 pages with PROT_NONE with mmap
> >>>> - Register userfaultfd
> >>>> - Change protection of the first half (1 to 8 pages) of memory to
> >>>>   PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
> >>>> - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
> >>>>   out.
> >>>>
> >>>> This is a simple use case where user may or may not know if the memory
> >>>> area has been divided into multiple VMAs.
> >>>>
> >>>> Reported-by: Paul Gofman <pgofman@codeweavers.com>
> >>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >>>> ---
> >>>> Changes since v1:
> >>>> - Correct the start and ending values passed to uffd_wp_range()
> >>>> ---
> >>>>  mm/userfaultfd.c | 38 ++++++++++++++++++++++----------------
> >>>>  1 file changed, 22 insertions(+), 16 deletions(-)
> >>>>
> >>>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> >>>> index 65ad172add27..bccea08005a8 100644
> >>>> --- a/mm/userfaultfd.c
> >>>> +++ b/mm/userfaultfd.c
> >>>> @@ -738,9 +738,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> >>>>  			unsigned long len, bool enable_wp,
> >>>>  			atomic_t *mmap_changing)
> >>>>  {
> >>>> +	unsigned long end = start + len;
> >>>> +	unsigned long _start, _end;
> >>>>  	struct vm_area_struct *dst_vma;
> >>>>  	unsigned long page_mask;
> >>>>  	int err;
> >>>
> >>> I think this needs to be initialized or it can return anything when range
> >>> not mapped.
> >> It is being initialized to -EAGAIN already. It is not visible in this patch.
> > 
> > I see, though -EAGAIN doesn't look suitable at all.  The old retcode for
> > !vma case is -ENOENT, so I think we'd better keep using it if we want to
> > have this patch.
> I'll update in next version.
> 
> > 
> >>
> >>>
> >>>> +	VMA_ITERATOR(vmi, dst_mm, start);
> >>>>  
> >>>>  	/*
> >>>>  	 * Sanitize the command parameters:
> >>>> @@ -762,26 +765,29 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> >>>>  	if (mmap_changing && atomic_read(mmap_changing))
> >>>>  		goto out_unlock;
> >>>>  
> >>>> -	err = -ENOENT;
> >>>> -	dst_vma = find_dst_vma(dst_mm, start, len);
> >>>> +	for_each_vma_range(vmi, dst_vma, end) {
> >>>> +		err = -ENOENT;
> >>>>  
> >>>> -	if (!dst_vma)
> >>>> -		goto out_unlock;
> >>>> -	if (!userfaultfd_wp(dst_vma))
> >>>> -		goto out_unlock;
> >>>> -	if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
> >>>> -		goto out_unlock;
> >>>> +		if (!dst_vma->vm_userfaultfd_ctx.ctx)
> >>>> +			break;
> >>>> +		if (!userfaultfd_wp(dst_vma))
> >>>> +			break;
> >>>> +		if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
> >>>> +			break;
> >>>>  
> >>>> -	if (is_vm_hugetlb_page(dst_vma)) {
> >>>> -		err = -EINVAL;
> >>>> -		page_mask = vma_kernel_pagesize(dst_vma) - 1;
> >>>> -		if ((start & page_mask) || (len & page_mask))
> >>>> -			goto out_unlock;
> >>>> -	}
> >>>> +		if (is_vm_hugetlb_page(dst_vma)) {
> >>>> +			err = -EINVAL;
> >>>> +			page_mask = vma_kernel_pagesize(dst_vma) - 1;
> >>>> +			if ((start & page_mask) || (len & page_mask))
> >>>> +				break;
> >>>> +		}
> >>>>  
> >>>> -	uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
> >>>> +		_start = (dst_vma->vm_start > start) ? dst_vma->vm_start : start;
> >>>> +		_end = (dst_vma->vm_end < end) ? dst_vma->vm_end : end;
> >>>>  
> >>>> -	err = 0;
> >>>> +		uffd_wp_range(dst_mm, dst_vma, _start, _end - _start, enable_wp);
> >>>> +		err = 0;
> >>>> +	}
> >>>>  out_unlock:
> >>>>  	mmap_read_unlock(dst_mm);
> >>>>  	return err;
> >>>
> >>> This whole patch also changes the abi, so I'm worried whether there can be
> >>> app that relies on the existing behavior.
> >> Even if a app is dependent on it, this change would just don't return error
> >> if there are multiple VMAs under the hood and handle them correctly. Most
> >> apps wouldn't care about VMAs anyways. I don't know if there would be any
> >> drastic behavior change, other than the behavior becoming nicer.
> > 
> > So this logic existed since the initial version of uffd-wp.  It has a good
> > thing that it strictly checks everything and it makes sense since uffd-wp
> > is per-vma attribute.  In short, the old code fails clearly.
> > 
> > While the new proposal is not: if -ENOENT we really have no idea what
> > happened at all; some ranges can be wr-protected but we don't know where
> > starts to go wrong.
> The return error codes can be made to return in better way somewhat. The
> return error codes shouldn't block a correct functionality enhancement patch.
> 
> > 
> > Now I'm looking at the original problem..
> > 
> >  - Allocate memory of size 16 pages with PROT_NONE with mmap
> >  - Register userfaultfd
> >  - Change protection of the first half (1 to 8 pages) of memory to
> >    PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
> >  - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
> >    out.
> > 
> > Why the user app should wr-protect 16 pages at all?
> Taking arguments from Paul here.
> 
> The app is free to insert guard pages inside the range (with PROT_NONE) and
> change the protection of memory freely. Not sure why it is needed to
> complicate things by denying any flexibility. We should never restrict what
> is possible and what not. All of these different access attributes and
> their any combination of interaction _must_ work without question. The
> application should be free to change protection on any sub-range and it
> shouldn't break the PAGE_IS_WRITTEN + UFFD_WRITE_PROTECT promise which
> PAGEMAP_IOCTL (patches are in progress) and UFFD makes.

Because uffd-wp has a limitation on e.g. it cannot nest so far.  I'm fine
with allowing mprotect() happening, but just to mention so far it cannot do
"any combinations" yet.

> 
> > 
> > If so, uffd_wp_range() will be ran upon a PROT_NONE range which doesn't
> > make sense at all, no matter whether the user is aware of vma concept or
> > not...  because it's destined that it's a vain effort.
> It is not a vain effort. The user want to watch/find the dirty pages of a
> range while working with it: reserve and watch at once while Write
> protecting or un-protecting as needed. There may be several different use
> cases. Inserting guard pages to catch out of range access, map something
> only when it is needed; unmap or PROT_NONE pages when they are set free in
> the app etc.

Fair enough.

> 
> > 
> > So IMHO it's the user app needs fixing here, not the interface?  I think
> > it's the matter of whether the monitor is aware of mprotect() being
> > invoked.
> No. The common practice is to allocate a big memory chunk at once and have
> own allocator over it (whether it is some specific allocator in a game or a
> .net allocator with garbage collector). From the usage point of view it is
> very limiting to demand constant memory attributes for the whole range.
> 
> That said, if we do have the way to do exactly what we want with reset
> through pagemap fd and it is just UFFD ioctl will be working differently,
> it is not a blocker of course, just weird api design.

Do you mean you'll disable ENGAGE_WP && !GET in your other series?  Yes, if
this will service your goal, it'll be perfect to remove that interface.

> 
> > 
> > In short, I hope we're working on things that helps at least someone, and
> > we should avoid working on things that does not have clear benefit yet.
> > With the WP_ENGAGE new interface being proposed, I just didn't see any
> > benefit of changing the current interface, especially if the change can
> > bring uncertainties itself (e.g., should we fail upon !uffd-wp vmas, or
> > should we skip?).
> We can work on solving uncertainties in case of error conditions. Fail if
> !uffd-wp vma comes.

Let me try to double check with you here:

I assume you want to skip any vma that is not mapped at all, as the loop
already does so.  So it'll succeed if there're memory holes.

You also want to explicitly fail if some vma is not registered with uffd-wp
when walking the vma list, am I right?  IOW, the tracee _won't_ ever have a
chance to unregister uffd-wp itself, right?

> 
> > 
> >>
> >>>
> >>> Is this for the new pagemap effort?  Can this just be done in the new
> >>> interface rather than changing the old?
> >> We found this bug while working on pagemap patches. It is already being
> >> handled in the new interface. We just thought that this use case can happen
> >> pretty easily and unknowingly. So the support should be added.
> > 
> > Thanks.  My understanding is that it would have been reported if it
> > affected any existing uffd-wp user.
> I would consider the UFFD WP a recent functionality and it may not being
> used in wide range of app scenarios.

Yes I think so.

Existing users should in most cases be applying the ioctl upon valid vmas
somehow.  I think the chance is low that someone relies on the errcode to
make other decisions, but I just cannot really tell because the user app
can do many weird things.

> 
> > 
> >>
> >> Also mwriteprotect_range() gives a pretty straight forward way to WP or
> >> un-WP a range. Async WP can be used in coordination with pagemap file
> >> (PM_UFFD_WP flag in PTE) as well. There may be use cases for it. On another
> >> note, I don't see any use cases of WP async and PM_UFFD_WP flag as
> >> !PM_UFFD_WP flag doesn't give direct information if the page is written for
> >> !present pages.
> > 
> > Currently we do maintain PM_UFFD_WP even for swap entries, so if it was
> > written then I think we'll know even if the page was swapped out:
> > 
> > 	} else if (is_swap_pte(pte)) {
> > 		if (pte_swp_uffd_wp(pte))
> > 			flags |= PM_UFFD_WP;
> > 		if (pte_marker_entry_uffd_wp(entry))
> > 			flags |= PM_UFFD_WP;
> > 
> > So it's working?
> > 
> >>
> >>>
> >>> Side note: in your other pagemap series, you can optimize "WP_ENGAGE &&
> >>> !GET" to not do generic pgtable walk at all, but use what it does in this
> >>> patch for the initial round or wr-protect.
> >> Yeah, it is implemented with some optimizations.
> > 
> > IIUC in your latest public version is not optimized, but I can check the
> > new version when it comes.
> I've some optimizations in next version keeping the code lines minimum. The
> best optimization would be to add a page walk dedicated for this engaging
> write-protect. I don't want to do that. Lets try to improve this patch in
> how ever way possible. So that WP from UFFD ioctl can be used.

If you want to do this there, I think it can be simply/mostly a copy-paste
of this patch over there by looping over the vmas and apply the protections.

I think it's fine to do it with ioctl(UFFDIO_WP), but I want to be crystal
clear on what interface you're looking for before changing it, and let's
define it properly.

Thanks,

-- 
Peter Xu

