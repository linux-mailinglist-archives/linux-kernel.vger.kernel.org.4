Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C41698CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjBPG0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBPG0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:26:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053E43431E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:25:59 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E4F24660215E;
        Thu, 16 Feb 2023 06:25:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676528758;
        bh=1ial1JJObt12T3Kp6byVv2e1A2nh+6cD1rBxSdG3+zw=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=VBVm9IbyjOQj1OE4+VpDakhHNZgt2+4wBvVID0Ykh/UB2laHxbjkoI4JOyb1Rk7GQ
         Cps6Cwl8Vo8keQ6y8m3ualrWZxA9zKpi4pnmwo/yr2ScjWs4UwNbkDZ5QUMxRamgXL
         3sO1o6/zE3H31wA2rNscI5CZuTsQqlpxoEcrK/7tM8yIfxTaLa+bGu5TH27q8PxJO5
         oKyE/5fS+zIpFRFzUFO7fi8kYu7EWi8n/6uDjN8lW66JBatqWKMI6XTcF+U8nBZyeZ
         GntZ2zMmtiJTK888FsyM1x3fl6xbcydHBmbc7qw9cFxhxGS2JmSjLx7tTCexdUuYtE
         J3X4zrLDsKBlA==
Message-ID: <e35c7af0-d115-9808-61b5-cf8ab4356a35@collabora.com>
Date:   Thu, 16 Feb 2023 11:25:51 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Gofman <pgofman@codeweavers.com>, david@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/userfaultfd: Support WP on multiple VMAs
To:     Peter Xu <peterx@redhat.com>
References: <20230213163124.2850816-1-usama.anjum@collabora.com>
 <Y+prUgFQqmytC/5M@x1n> <9f0278d7-54f1-960e-ffdf-eeb2572ff6d1@collabora.com>
 <Y+qnb/Ix8P5J3Kl4@x1n> <0549bd0e-85c4-1547-3eaa-16c8a8883837@collabora.com>
 <Y+wCDUpuDcSDSQAK@x1n> <c9d3a306-0c5e-ad58-cffc-3c4c6b8b7433@collabora.com>
 <Y+1SdZqwS7LbcfaQ@x1n>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y+1SdZqwS7LbcfaQ@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/23 2:45 AM, Peter Xu wrote:
> On Wed, Feb 15, 2023 at 12:08:11PM +0500, Muhammad Usama Anjum wrote:
>> Hi Peter,
>>
>> Thank you for your review!
>>
>> On 2/15/23 2:50 AM, Peter Xu wrote:
>>> On Tue, Feb 14, 2023 at 01:49:50PM +0500, Muhammad Usama Anjum wrote:
>>>> On 2/14/23 2:11 AM, Peter Xu wrote:
>>>>> On Mon, Feb 13, 2023 at 10:50:39PM +0500, Muhammad Usama Anjum wrote:
>>>>>> On 2/13/23 9:54 PM, Peter Xu wrote:
>>>>>>> On Mon, Feb 13, 2023 at 09:31:23PM +0500, Muhammad Usama Anjum wrote:
>>>>>>>> mwriteprotect_range() errors out if [start, end) doesn't fall in one
>>>>>>>> VMA. We are facing a use case where multiple VMAs are present in one
>>>>>>>> range of interest. For example, the following pseudocode reproduces the
>>>>>>>> error which we are trying to fix:
>>>>>>>>
>>>>>>>> - Allocate memory of size 16 pages with PROT_NONE with mmap
>>>>>>>> - Register userfaultfd
>>>>>>>> - Change protection of the first half (1 to 8 pages) of memory to
>>>>>>>>   PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
>>>>>>>> - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
>>>>>>>>   out.
>>>>>>>>
>>>>>>>> This is a simple use case where user may or may not know if the memory
>>>>>>>> area has been divided into multiple VMAs.
>>>>>>>>
>>>>>>>> Reported-by: Paul Gofman <pgofman@codeweavers.com>
>>>>>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>>>>> ---
>>>>>>>> Changes since v1:
>>>>>>>> - Correct the start and ending values passed to uffd_wp_range()
>>>>>>>> ---
>>>>>>>>  mm/userfaultfd.c | 38 ++++++++++++++++++++++----------------
>>>>>>>>  1 file changed, 22 insertions(+), 16 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>>>>>>>> index 65ad172add27..bccea08005a8 100644
>>>>>>>> --- a/mm/userfaultfd.c
>>>>>>>> +++ b/mm/userfaultfd.c
>>>>>>>> @@ -738,9 +738,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>>>>>>>>  			unsigned long len, bool enable_wp,
>>>>>>>>  			atomic_t *mmap_changing)
>>>>>>>>  {
>>>>>>>> +	unsigned long end = start + len;
>>>>>>>> +	unsigned long _start, _end;
>>>>>>>>  	struct vm_area_struct *dst_vma;
>>>>>>>>  	unsigned long page_mask;
>>>>>>>>  	int err;
>>>>>>>
>>>>>>> I think this needs to be initialized or it can return anything when range
>>>>>>> not mapped.
>>>>>> It is being initialized to -EAGAIN already. It is not visible in this patch.
>>>>>
>>>>> I see, though -EAGAIN doesn't look suitable at all.  The old retcode for
>>>>> !vma case is -ENOENT, so I think we'd better keep using it if we want to
>>>>> have this patch.
>>>> I'll update in next version.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +	VMA_ITERATOR(vmi, dst_mm, start);
>>>>>>>>  
>>>>>>>>  	/*
>>>>>>>>  	 * Sanitize the command parameters:
>>>>>>>> @@ -762,26 +765,29 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>>>>>>>>  	if (mmap_changing && atomic_read(mmap_changing))
>>>>>>>>  		goto out_unlock;
>>>>>>>>  
>>>>>>>> -	err = -ENOENT;
>>>>>>>> -	dst_vma = find_dst_vma(dst_mm, start, len);
>>>>>>>> +	for_each_vma_range(vmi, dst_vma, end) {
>>>>>>>> +		err = -ENOENT;
>>>>>>>>  
>>>>>>>> -	if (!dst_vma)
>>>>>>>> -		goto out_unlock;
>>>>>>>> -	if (!userfaultfd_wp(dst_vma))
>>>>>>>> -		goto out_unlock;
>>>>>>>> -	if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
>>>>>>>> -		goto out_unlock;
>>>>>>>> +		if (!dst_vma->vm_userfaultfd_ctx.ctx)
>>>>>>>> +			break;
>>>>>>>> +		if (!userfaultfd_wp(dst_vma))
>>>>>>>> +			break;
>>>>>>>> +		if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
>>>>>>>> +			break;
>>>>>>>>  
>>>>>>>> -	if (is_vm_hugetlb_page(dst_vma)) {
>>>>>>>> -		err = -EINVAL;
>>>>>>>> -		page_mask = vma_kernel_pagesize(dst_vma) - 1;
>>>>>>>> -		if ((start & page_mask) || (len & page_mask))
>>>>>>>> -			goto out_unlock;
>>>>>>>> -	}
>>>>>>>> +		if (is_vm_hugetlb_page(dst_vma)) {
>>>>>>>> +			err = -EINVAL;
>>>>>>>> +			page_mask = vma_kernel_pagesize(dst_vma) - 1;
>>>>>>>> +			if ((start & page_mask) || (len & page_mask))
>>>>>>>> +				break;
>>>>>>>> +		}
>>>>>>>>  
>>>>>>>> -	uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
>>>>>>>> +		_start = (dst_vma->vm_start > start) ? dst_vma->vm_start : start;
>>>>>>>> +		_end = (dst_vma->vm_end < end) ? dst_vma->vm_end : end;
>>>>>>>>  
>>>>>>>> -	err = 0;
>>>>>>>> +		uffd_wp_range(dst_mm, dst_vma, _start, _end - _start, enable_wp);
>>>>>>>> +		err = 0;
>>>>>>>> +	}
>>>>>>>>  out_unlock:
>>>>>>>>  	mmap_read_unlock(dst_mm);
>>>>>>>>  	return err;
>>>>>>>
>>>>>>> This whole patch also changes the abi, so I'm worried whether there can be
>>>>>>> app that relies on the existing behavior.
>>>>>> Even if a app is dependent on it, this change would just don't return error
>>>>>> if there are multiple VMAs under the hood and handle them correctly. Most
>>>>>> apps wouldn't care about VMAs anyways. I don't know if there would be any
>>>>>> drastic behavior change, other than the behavior becoming nicer.
>>>>>
>>>>> So this logic existed since the initial version of uffd-wp.  It has a good
>>>>> thing that it strictly checks everything and it makes sense since uffd-wp
>>>>> is per-vma attribute.  In short, the old code fails clearly.
>>>>>
>>>>> While the new proposal is not: if -ENOENT we really have no idea what
>>>>> happened at all; some ranges can be wr-protected but we don't know where
>>>>> starts to go wrong.
>>>> The return error codes can be made to return in better way somewhat. The
>>>> return error codes shouldn't block a correct functionality enhancement patch.
>>>>
>>>>>
>>>>> Now I'm looking at the original problem..
>>>>>
>>>>>  - Allocate memory of size 16 pages with PROT_NONE with mmap
>>>>>  - Register userfaultfd
>>>>>  - Change protection of the first half (1 to 8 pages) of memory to
>>>>>    PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
>>>>>  - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
>>>>>    out.
>>>>>
>>>>> Why the user app should wr-protect 16 pages at all?
>>>> Taking arguments from Paul here.
>>>>
>>>> The app is free to insert guard pages inside the range (with PROT_NONE) and
>>>> change the protection of memory freely. Not sure why it is needed to
>>>> complicate things by denying any flexibility. We should never restrict what
>>>> is possible and what not. All of these different access attributes and
>>>> their any combination of interaction _must_ work without question. The
>>>> application should be free to change protection on any sub-range and it
>>>> shouldn't break the PAGE_IS_WRITTEN + UFFD_WRITE_PROTECT promise which
>>>> PAGEMAP_IOCTL (patches are in progress) and UFFD makes.
>>>
>>> Because uffd-wp has a limitation on e.g. it cannot nest so far.  I'm fine
>>> with allowing mprotect() happening, but just to mention so far it cannot do
>>> "any combinations" yet.
>>>
>>>>
>>>>>
>>>>> If so, uffd_wp_range() will be ran upon a PROT_NONE range which doesn't
>>>>> make sense at all, no matter whether the user is aware of vma concept or
>>>>> not...  because it's destined that it's a vain effort.
>>>> It is not a vain effort. The user want to watch/find the dirty pages of a
>>>> range while working with it: reserve and watch at once while Write
>>>> protecting or un-protecting as needed. There may be several different use
>>>> cases. Inserting guard pages to catch out of range access, map something
>>>> only when it is needed; unmap or PROT_NONE pages when they are set free in
>>>> the app etc.
>>>
>>> Fair enough.
>>>
>>>>
>>>>>
>>>>> So IMHO it's the user app needs fixing here, not the interface?  I think
>>>>> it's the matter of whether the monitor is aware of mprotect() being
>>>>> invoked.
>>>> No. The common practice is to allocate a big memory chunk at once and have
>>>> own allocator over it (whether it is some specific allocator in a game or a
>>>> .net allocator with garbage collector). From the usage point of view it is
>>>> very limiting to demand constant memory attributes for the whole range.
>>>>
>>>> That said, if we do have the way to do exactly what we want with reset
>>>> through pagemap fd and it is just UFFD ioctl will be working differently,
>>>> it is not a blocker of course, just weird api design.
>>>
>>> Do you mean you'll disable ENGAGE_WP && !GET in your other series?  Yes, if
>>> this will service your goal, it'll be perfect to remove that interface.
>> No, we cannot remove it.
> 
> If this patch can land, I assume ioctl(UFFDIO_WP) can start to service the
> dirty tracking purpose, then why do you still need "ENGAGE_WP && !GET"?
We don't need it. We need the following operations only:
1 GET
2 ENGAGE_WP + GET
When we have these two operations, we had added the following as well:
3 ENGAGE_WP + !GET or only ENGAGE_WP
This (3) can be removed from ioctl(PAGEMAP_IOCTL) if reviewers ask. I can
remove it in favour of this ioctl(UFFDIO_WP) patch for sure.

> 
> Note, I'm not asking to drop ENGAGE_WP entirely, only when !GET.
> 
>>
>>>
>>>>
>>>>>
>>>>> In short, I hope we're working on things that helps at least someone, and
>>>>> we should avoid working on things that does not have clear benefit yet.
>>>>> With the WP_ENGAGE new interface being proposed, I just didn't see any
>>>>> benefit of changing the current interface, especially if the change can
>>>>> bring uncertainties itself (e.g., should we fail upon !uffd-wp vmas, or
>>>>> should we skip?).
>>>> We can work on solving uncertainties in case of error conditions. Fail if
>>>> !uffd-wp vma comes.
>>>
>>> Let me try to double check with you here:
>>>
>>> I assume you want to skip any vma that is not mapped at all, as the loop
>>> already does so.  So it'll succeed if there're memory holes.
>>>
>>> You also want to explicitly fail if some vma is not registered with uffd-wp
>>> when walking the vma list, am I right?  IOW, the tracee _won't_ ever have a
>>> chance to unregister uffd-wp itself, right?
>> Yes, fail if any VMA doesn't have uffd-wp. This fail means the
>> write-protection or un-protection failed on a region of memory with error
>> -ENOENT. This is already happening in this current patch. The unregister
>> code would remain same. The register and unregister ioctls are already
>> going over all the VMAs in a range. I'm not rigid on anything. Let me
>> define the interface below.
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Is this for the new pagemap effort?  Can this just be done in the new
>>>>>>> interface rather than changing the old?
>>>>>> We found this bug while working on pagemap patches. It is already being
>>>>>> handled in the new interface. We just thought that this use case can happen
>>>>>> pretty easily and unknowingly. So the support should be added.
>>>>>
>>>>> Thanks.  My understanding is that it would have been reported if it
>>>>> affected any existing uffd-wp user.
>>>> I would consider the UFFD WP a recent functionality and it may not being
>>>> used in wide range of app scenarios.
>>>
>>> Yes I think so.
>>>
>>> Existing users should in most cases be applying the ioctl upon valid vmas
>>> somehow.  I think the chance is low that someone relies on the errcode to
>>> make other decisions, but I just cannot really tell because the user app
>>> can do many weird things.
>> Correct. The user can use any combination of operation
>> (mmap/mprotect/uffd). They must work in harmony.
> 
> No uffd - that's exactly what I'm saying: mprotect is fine here, but uffd
> is probably not, not in a nested way.  When you try to UFFDIO_REGISTER upon
> some range that already been registered (by the tracee), it'll fail for you
> immediately:
> 
> 		/*
> 		 * Check that this vma isn't already owned by a
> 		 * different userfaultfd. We can't allow more than one
> 		 * userfaultfd to own a single vma simultaneously or we
> 		 * wouldn't know which one to deliver the userfaults to.
> 		 */
> 		ret = -EBUSY;
> 		if (cur->vm_userfaultfd_ctx.ctx &&
> 		    cur->vm_userfaultfd_ctx.ctx != ctx)
> 			goto out_unlock;
> 
> So if this won't work for you, then AFAICT uffd-wp won't work for you (just
> like soft-dirty but in another way, sorry), at least not until someone
> starts to work on the nested.
I was referring to a case where user registers the WP on multiple VMAs and
all the VMAs haven't been registered before. It would work. Right?

> 
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Also mwriteprotect_range() gives a pretty straight forward way to WP or
>>>>>> un-WP a range. Async WP can be used in coordination with pagemap file
>>>>>> (PM_UFFD_WP flag in PTE) as well. There may be use cases for it. On another
>>>>>> note, I don't see any use cases of WP async and PM_UFFD_WP flag as
>>>>>> !PM_UFFD_WP flag doesn't give direct information if the page is written for
>>>>>> !present pages.
>>>>>
>>>>> Currently we do maintain PM_UFFD_WP even for swap entries, so if it was
>>>>> written then I think we'll know even if the page was swapped out:
>>>>>
>>>>> 	} else if (is_swap_pte(pte)) {
>>>>> 		if (pte_swp_uffd_wp(pte))
>>>>> 			flags |= PM_UFFD_WP;
>>>>> 		if (pte_marker_entry_uffd_wp(entry))
>>>>> 			flags |= PM_UFFD_WP;
>>>>>
>>>>> So it's working?
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Side note: in your other pagemap series, you can optimize "WP_ENGAGE &&
>>>>>>> !GET" to not do generic pgtable walk at all, but use what it does in this
>>>>>>> patch for the initial round or wr-protect.
>>>>>> Yeah, it is implemented with some optimizations.
>>>>>
>>>>> IIUC in your latest public version is not optimized, but I can check the
>>>>> new version when it comes.
>>>> I've some optimizations in next version keeping the code lines minimum. The
>>>> best optimization would be to add a page walk dedicated for this engaging
>>>> write-protect. I don't want to do that. Lets try to improve this patch in
>>>> how ever way possible. So that WP from UFFD ioctl can be used.
>>>
>>> If you want to do this there, I think it can be simply/mostly a copy-paste
>>> of this patch over there by looping over the vmas and apply the protections.
>> I wouldn't want to do this. PAGEMAP IOCTL performing an operation
>> anonymously to UFFD_WP wouldn't look good when we can improve UFFD_WP itself.
>>
>>>
>>> I think it's fine to do it with ioctl(UFFDIO_WP), but I want to be crystal
>>> clear on what interface you're looking for before changing it, and let's
>>> define it properly.
>> Thank you. Let me crystal clear why we have sent this patch and what
>> difference we want.
>>
>> Just like UFFDIO_REGISTER and UFFDIO_UNREGISTER don't care if the requested
>> range has multiple VMAs in the memory region, we want the same thing with
>> UFFDIO_WRITEPROTCET. It looks more uniform and obvious to us as user
>> doesn't care about VMAs. The user only cares about the memory he wants to
>> write-protect. So just update the inside code of UFFDIO_WRITEPROTECT such
>> that it starts to act like UFFDIO_REGISTER/UFFDIO_UNREGISTER. It shouldn't
>> complain if there are multiple VMAs involved under the hood.
>>
>> This patch is visiting all the VMAs in the memory range. The attached
>> patches are my wip v3. If you feel like there can be better way to achieve
>> this, please don't hesitate to send the v3 yourself.
> 
> As I said I think you have a point, and let's cross finger this is fine
> (which I mostly agree with).
Thank you so much! I'm sending the v3 in a while.

> 
> We can fail on !uffd-wp vmas, sounds reasonable to me.  But let's sync up
> with above to make sure this works for you.
> 
> Since you've got a patch here, let me comment directly below.
> 
>>
>> Thank you so much!
>>
>> -- 
>> BR,
>> Muhammad Usama Anjum
> 
>> From f69069dddda206b190706eef7b2dad3a67a6df10 Mon Sep 17 00:00:00 2001
>> From: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Date: Thu, 9 Feb 2023 16:13:23 +0500
>> Subject: [PATCH v3 1/2] mm/userfaultfd: Support WP on multiple VMAs
>> To: peterx@redhat.com, david@redhat.com
>> Cc: usama.anjum@collabora.com, kernel@collabora.com
>>
>> mwriteprotect_range() errors out if [start, end) doesn't fall in one
>> VMA. We are facing a use case where multiple VMAs are present in one
>> range of interest. For example, the following pseudocode reproduces the
>> error which we are trying to fix:
>>
>> - Allocate memory of size 16 pages with PROT_NONE with mmap
>> - Register userfaultfd
>> - Change protection of the first half (1 to 8 pages) of memory to
>>   PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
>> - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
>>   out.
>>
>> This is a simple use case where user may or may not know if the memory
>> area has been divided into multiple VMAs.
>>
>> Reported-by: Paul Gofman <pgofman@codeweavers.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v2:
>> - Correct the return error code
>>
>> Changes since v1:
>> - Correct the start and ending values passed to uffd_wp_range()
>> ---
>>  mm/userfaultfd.c | 45 ++++++++++++++++++++++++++-------------------
>>  1 file changed, 26 insertions(+), 19 deletions(-)
>>
>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> index 65ad172add27..a3b48a99b942 100644
>> --- a/mm/userfaultfd.c
>> +++ b/mm/userfaultfd.c
>> @@ -738,9 +738,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>>  			unsigned long len, bool enable_wp,
>>  			atomic_t *mmap_changing)
>>  {
>> +	unsigned long end = start + len;
>> +	unsigned long _start, _end;
>>  	struct vm_area_struct *dst_vma;
>>  	unsigned long page_mask;
>> -	int err;
>> +	int err = -ENOENT;
>> +	VMA_ITERATOR(vmi, dst_mm, start);
>>  
>>  	/*
>>  	 * Sanitize the command parameters:
>> @@ -758,30 +761,34 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>>  	 * operation (e.g. mremap) running in parallel, bail out and
>>  	 * request the user to retry later
>>  	 */
>> -	err = -EAGAIN;
>> -	if (mmap_changing && atomic_read(mmap_changing))
>> +	if (mmap_changing && atomic_read(mmap_changing)) {
>> +		err = -EAGAIN;
>>  		goto out_unlock;
>> +	}
> 
> Let's keep the original code and simply set -ENOENT afterwards.
Will update in v3.

> 
>>  
>> -	err = -ENOENT;
>> -	dst_vma = find_dst_vma(dst_mm, start, len);
>> +	for_each_vma_range(vmi, dst_vma, end) {
>> +		err = -ENOENT;
>>  
>> -	if (!dst_vma)
>> -		goto out_unlock;
>> -	if (!userfaultfd_wp(dst_vma))
>> -		goto out_unlock;
>> -	if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
>> -		goto out_unlock;
>> +		if (!dst_vma->vm_userfaultfd_ctx.ctx)
>> +			break;
> 
> What is this check for?
I'd copied it from find_dst_vma(). Will update in v3.

> 
>> +		if (!userfaultfd_wp(dst_vma))
>> +			break;
>> +		if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
>> +			break;
> 
> I think this is not useful at all (even in the old code)?  It could have
> sneaked in somehow when I took the code over from Shaohua/Andrea.  Maybe we
> should clean it up since at it.
Will update in v3.

> 
>>  
>> -	if (is_vm_hugetlb_page(dst_vma)) {
>> -		err = -EINVAL;
>> -		page_mask = vma_kernel_pagesize(dst_vma) - 1;
>> -		if ((start & page_mask) || (len & page_mask))
>> -			goto out_unlock;
>> -	}
>> +		if (is_vm_hugetlb_page(dst_vma)) {
>> +			err = -EINVAL;
>> +			page_mask = vma_kernel_pagesize(dst_vma) - 1;
>> +			if ((start & page_mask) || (len & page_mask))
>> +				break;
>> +		}
>>  
>> -	uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
>> +		_start = (dst_vma->vm_start > start) ? dst_vma->vm_start : start;
>> +		_end = (dst_vma->vm_end < end) ? dst_vma->vm_end : end;
> 
> Maybe:
> 
>                 _start = MAX(dst_vma->vm_start, start);
>                 _end = MIN(dst_vma->vm_end, end);
> 
> ?
Very clever. Thanks. Will update in v3.

> 
>>  
>> -	err = 0;
>> +		uffd_wp_range(dst_mm, dst_vma, _start, _end - _start, enable_wp);
>> +		err = 0;
>> +	}
>>  out_unlock:
>>  	mmap_read_unlock(dst_mm);
>>  	return err;
>> -- 
>> 2.39.1
>>
> 
>> From ac119b22aa00248ed67c7ac6e285a12391943b15 Mon Sep 17 00:00:00 2001
>> From: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Date: Mon, 13 Feb 2023 21:15:01 +0500
>> Subject: [PATCH v3 2/2] mm/userfaultfd: add VM_WARN_ONCE()
>> To: peterx@redhat.com, david@redhat.com
>> Cc: usama.anjum@collabora.com, kernel@collabora.com
>>
>> Add VM_WARN_ONCE() to uffd_wp_range() to detect range (start, len) abuse.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  mm/userfaultfd.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> index a3b48a99b942..0536e23ba5f4 100644
>> --- a/mm/userfaultfd.c
>> +++ b/mm/userfaultfd.c
>> @@ -716,6 +716,8 @@ void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
>>  	unsigned int mm_cp_flags;
>>  	struct mmu_gather tlb;
>>  
>> +	VM_WARN_ONCE(start < dst_vma->vm_start || start + len > dst_vma->vm_end,
>> +		     "The address range exceeds VMA boundary.\n");
>>  	if (enable_wp)
>>  		mm_cp_flags = MM_CP_UFFD_WP;
>>  	else
>> -- 
>> 2.39.1
>>
> 
> 

-- 
BR,
Muhammad Usama Anjum
