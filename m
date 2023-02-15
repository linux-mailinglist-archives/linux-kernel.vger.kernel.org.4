Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831C369772A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjBOHJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjBOHJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:09:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A440034F44
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:08:59 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B1BF660216F;
        Wed, 15 Feb 2023 07:08:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676444898;
        bh=ChDjJkCuCzKkndRhJOaAa+sClVQTRZyR1TjtKO9OSt4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=asjBPqvo3CZ28KvPCvIVR1w7N9wllVSUPaE/EC2HQ4mmt/yByRTkB+Mn4lVLQL+Ml
         tIh9zazvn1GEnE0BSXfPK1tLRTTNCw0X6LDwCpY410jYQn2GDzEOTza7fOrQTtXYU/
         /p6iAy+WqSha37GvpwBXRLe7dT+Nw4l69qXtMC3Q2oVr0LPs1SvB1PwXPWmbXoktkt
         y5J2MPwg04Fbug08Yf/w9eVbII6ZIAKw2tU6MGco/DJgFi1mEQXsPHqmWzKQK65eKH
         Aark6fKj38Vg360nCW+QkD6i7zDGIY/hNXuCeWY4jlxf/YJVhXukSEMtIB29GeACMl
         bcJBpdARzvXnw==
Content-Type: multipart/mixed; boundary="------------iEx36eCvzn0HQr4ilRpuSoFw"
Message-ID: <c9d3a306-0c5e-ad58-cffc-3c4c6b8b7433@collabora.com>
Date:   Wed, 15 Feb 2023 12:08:11 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Gofman <pgofman@codeweavers.com>, david@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/userfaultfd: Support WP on multiple VMAs
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230213163124.2850816-1-usama.anjum@collabora.com>
 <Y+prUgFQqmytC/5M@x1n> <9f0278d7-54f1-960e-ffdf-eeb2572ff6d1@collabora.com>
 <Y+qnb/Ix8P5J3Kl4@x1n> <0549bd0e-85c4-1547-3eaa-16c8a8883837@collabora.com>
 <Y+wCDUpuDcSDSQAK@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y+wCDUpuDcSDSQAK@x1n>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------iEx36eCvzn0HQr4ilRpuSoFw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Peter,

Thank you for your review!

On 2/15/23 2:50 AM, Peter Xu wrote:
> On Tue, Feb 14, 2023 at 01:49:50PM +0500, Muhammad Usama Anjum wrote:
>> On 2/14/23 2:11 AM, Peter Xu wrote:
>>> On Mon, Feb 13, 2023 at 10:50:39PM +0500, Muhammad Usama Anjum wrote:
>>>> On 2/13/23 9:54 PM, Peter Xu wrote:
>>>>> On Mon, Feb 13, 2023 at 09:31:23PM +0500, Muhammad Usama Anjum wrote:
>>>>>> mwriteprotect_range() errors out if [start, end) doesn't fall in one
>>>>>> VMA. We are facing a use case where multiple VMAs are present in one
>>>>>> range of interest. For example, the following pseudocode reproduces the
>>>>>> error which we are trying to fix:
>>>>>>
>>>>>> - Allocate memory of size 16 pages with PROT_NONE with mmap
>>>>>> - Register userfaultfd
>>>>>> - Change protection of the first half (1 to 8 pages) of memory to
>>>>>>   PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
>>>>>> - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
>>>>>>   out.
>>>>>>
>>>>>> This is a simple use case where user may or may not know if the memory
>>>>>> area has been divided into multiple VMAs.
>>>>>>
>>>>>> Reported-by: Paul Gofman <pgofman@codeweavers.com>
>>>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>>> ---
>>>>>> Changes since v1:
>>>>>> - Correct the start and ending values passed to uffd_wp_range()
>>>>>> ---
>>>>>>  mm/userfaultfd.c | 38 ++++++++++++++++++++++----------------
>>>>>>  1 file changed, 22 insertions(+), 16 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>>>>>> index 65ad172add27..bccea08005a8 100644
>>>>>> --- a/mm/userfaultfd.c
>>>>>> +++ b/mm/userfaultfd.c
>>>>>> @@ -738,9 +738,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>>>>>>  			unsigned long len, bool enable_wp,
>>>>>>  			atomic_t *mmap_changing)
>>>>>>  {
>>>>>> +	unsigned long end = start + len;
>>>>>> +	unsigned long _start, _end;
>>>>>>  	struct vm_area_struct *dst_vma;
>>>>>>  	unsigned long page_mask;
>>>>>>  	int err;
>>>>>
>>>>> I think this needs to be initialized or it can return anything when range
>>>>> not mapped.
>>>> It is being initialized to -EAGAIN already. It is not visible in this patch.
>>>
>>> I see, though -EAGAIN doesn't look suitable at all.  The old retcode for
>>> !vma case is -ENOENT, so I think we'd better keep using it if we want to
>>> have this patch.
>> I'll update in next version.
>>
>>>
>>>>
>>>>>
>>>>>> +	VMA_ITERATOR(vmi, dst_mm, start);
>>>>>>  
>>>>>>  	/*
>>>>>>  	 * Sanitize the command parameters:
>>>>>> @@ -762,26 +765,29 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>>>>>>  	if (mmap_changing && atomic_read(mmap_changing))
>>>>>>  		goto out_unlock;
>>>>>>  
>>>>>> -	err = -ENOENT;
>>>>>> -	dst_vma = find_dst_vma(dst_mm, start, len);
>>>>>> +	for_each_vma_range(vmi, dst_vma, end) {
>>>>>> +		err = -ENOENT;
>>>>>>  
>>>>>> -	if (!dst_vma)
>>>>>> -		goto out_unlock;
>>>>>> -	if (!userfaultfd_wp(dst_vma))
>>>>>> -		goto out_unlock;
>>>>>> -	if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
>>>>>> -		goto out_unlock;
>>>>>> +		if (!dst_vma->vm_userfaultfd_ctx.ctx)
>>>>>> +			break;
>>>>>> +		if (!userfaultfd_wp(dst_vma))
>>>>>> +			break;
>>>>>> +		if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
>>>>>> +			break;
>>>>>>  
>>>>>> -	if (is_vm_hugetlb_page(dst_vma)) {
>>>>>> -		err = -EINVAL;
>>>>>> -		page_mask = vma_kernel_pagesize(dst_vma) - 1;
>>>>>> -		if ((start & page_mask) || (len & page_mask))
>>>>>> -			goto out_unlock;
>>>>>> -	}
>>>>>> +		if (is_vm_hugetlb_page(dst_vma)) {
>>>>>> +			err = -EINVAL;
>>>>>> +			page_mask = vma_kernel_pagesize(dst_vma) - 1;
>>>>>> +			if ((start & page_mask) || (len & page_mask))
>>>>>> +				break;
>>>>>> +		}
>>>>>>  
>>>>>> -	uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
>>>>>> +		_start = (dst_vma->vm_start > start) ? dst_vma->vm_start : start;
>>>>>> +		_end = (dst_vma->vm_end < end) ? dst_vma->vm_end : end;
>>>>>>  
>>>>>> -	err = 0;
>>>>>> +		uffd_wp_range(dst_mm, dst_vma, _start, _end - _start, enable_wp);
>>>>>> +		err = 0;
>>>>>> +	}
>>>>>>  out_unlock:
>>>>>>  	mmap_read_unlock(dst_mm);
>>>>>>  	return err;
>>>>>
>>>>> This whole patch also changes the abi, so I'm worried whether there can be
>>>>> app that relies on the existing behavior.
>>>> Even if a app is dependent on it, this change would just don't return error
>>>> if there are multiple VMAs under the hood and handle them correctly. Most
>>>> apps wouldn't care about VMAs anyways. I don't know if there would be any
>>>> drastic behavior change, other than the behavior becoming nicer.
>>>
>>> So this logic existed since the initial version of uffd-wp.  It has a good
>>> thing that it strictly checks everything and it makes sense since uffd-wp
>>> is per-vma attribute.  In short, the old code fails clearly.
>>>
>>> While the new proposal is not: if -ENOENT we really have no idea what
>>> happened at all; some ranges can be wr-protected but we don't know where
>>> starts to go wrong.
>> The return error codes can be made to return in better way somewhat. The
>> return error codes shouldn't block a correct functionality enhancement patch.
>>
>>>
>>> Now I'm looking at the original problem..
>>>
>>>  - Allocate memory of size 16 pages with PROT_NONE with mmap
>>>  - Register userfaultfd
>>>  - Change protection of the first half (1 to 8 pages) of memory to
>>>    PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
>>>  - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
>>>    out.
>>>
>>> Why the user app should wr-protect 16 pages at all?
>> Taking arguments from Paul here.
>>
>> The app is free to insert guard pages inside the range (with PROT_NONE) and
>> change the protection of memory freely. Not sure why it is needed to
>> complicate things by denying any flexibility. We should never restrict what
>> is possible and what not. All of these different access attributes and
>> their any combination of interaction _must_ work without question. The
>> application should be free to change protection on any sub-range and it
>> shouldn't break the PAGE_IS_WRITTEN + UFFD_WRITE_PROTECT promise which
>> PAGEMAP_IOCTL (patches are in progress) and UFFD makes.
> 
> Because uffd-wp has a limitation on e.g. it cannot nest so far.  I'm fine
> with allowing mprotect() happening, but just to mention so far it cannot do
> "any combinations" yet.
> 
>>
>>>
>>> If so, uffd_wp_range() will be ran upon a PROT_NONE range which doesn't
>>> make sense at all, no matter whether the user is aware of vma concept or
>>> not...  because it's destined that it's a vain effort.
>> It is not a vain effort. The user want to watch/find the dirty pages of a
>> range while working with it: reserve and watch at once while Write
>> protecting or un-protecting as needed. There may be several different use
>> cases. Inserting guard pages to catch out of range access, map something
>> only when it is needed; unmap or PROT_NONE pages when they are set free in
>> the app etc.
> 
> Fair enough.
> 
>>
>>>
>>> So IMHO it's the user app needs fixing here, not the interface?  I think
>>> it's the matter of whether the monitor is aware of mprotect() being
>>> invoked.
>> No. The common practice is to allocate a big memory chunk at once and have
>> own allocator over it (whether it is some specific allocator in a game or a
>> .net allocator with garbage collector). From the usage point of view it is
>> very limiting to demand constant memory attributes for the whole range.
>>
>> That said, if we do have the way to do exactly what we want with reset
>> through pagemap fd and it is just UFFD ioctl will be working differently,
>> it is not a blocker of course, just weird api design.
> 
> Do you mean you'll disable ENGAGE_WP && !GET in your other series?  Yes, if
> this will service your goal, it'll be perfect to remove that interface.
No, we cannot remove it.

> 
>>
>>>
>>> In short, I hope we're working on things that helps at least someone, and
>>> we should avoid working on things that does not have clear benefit yet.
>>> With the WP_ENGAGE new interface being proposed, I just didn't see any
>>> benefit of changing the current interface, especially if the change can
>>> bring uncertainties itself (e.g., should we fail upon !uffd-wp vmas, or
>>> should we skip?).
>> We can work on solving uncertainties in case of error conditions. Fail if
>> !uffd-wp vma comes.
> 
> Let me try to double check with you here:
> 
> I assume you want to skip any vma that is not mapped at all, as the loop
> already does so.  So it'll succeed if there're memory holes.
> 
> You also want to explicitly fail if some vma is not registered with uffd-wp
> when walking the vma list, am I right?  IOW, the tracee _won't_ ever have a
> chance to unregister uffd-wp itself, right?
Yes, fail if any VMA doesn't have uffd-wp. This fail means the
write-protection or un-protection failed on a region of memory with error
-ENOENT. This is already happening in this current patch. The unregister
code would remain same. The register and unregister ioctls are already
going over all the VMAs in a range. I'm not rigid on anything. Let me
define the interface below.

> 
>>
>>>
>>>>
>>>>>
>>>>> Is this for the new pagemap effort?  Can this just be done in the new
>>>>> interface rather than changing the old?
>>>> We found this bug while working on pagemap patches. It is already being
>>>> handled in the new interface. We just thought that this use case can happen
>>>> pretty easily and unknowingly. So the support should be added.
>>>
>>> Thanks.  My understanding is that it would have been reported if it
>>> affected any existing uffd-wp user.
>> I would consider the UFFD WP a recent functionality and it may not being
>> used in wide range of app scenarios.
> 
> Yes I think so.
> 
> Existing users should in most cases be applying the ioctl upon valid vmas
> somehow.  I think the chance is low that someone relies on the errcode to
> make other decisions, but I just cannot really tell because the user app
> can do many weird things.
Correct. The user can use any combination of operation
(mmap/mprotect/uffd). They must work in harmony.

> 
>>
>>>
>>>>
>>>> Also mwriteprotect_range() gives a pretty straight forward way to WP or
>>>> un-WP a range. Async WP can be used in coordination with pagemap file
>>>> (PM_UFFD_WP flag in PTE) as well. There may be use cases for it. On another
>>>> note, I don't see any use cases of WP async and PM_UFFD_WP flag as
>>>> !PM_UFFD_WP flag doesn't give direct information if the page is written for
>>>> !present pages.
>>>
>>> Currently we do maintain PM_UFFD_WP even for swap entries, so if it was
>>> written then I think we'll know even if the page was swapped out:
>>>
>>> 	} else if (is_swap_pte(pte)) {
>>> 		if (pte_swp_uffd_wp(pte))
>>> 			flags |= PM_UFFD_WP;
>>> 		if (pte_marker_entry_uffd_wp(entry))
>>> 			flags |= PM_UFFD_WP;
>>>
>>> So it's working?
>>>
>>>>
>>>>>
>>>>> Side note: in your other pagemap series, you can optimize "WP_ENGAGE &&
>>>>> !GET" to not do generic pgtable walk at all, but use what it does in this
>>>>> patch for the initial round or wr-protect.
>>>> Yeah, it is implemented with some optimizations.
>>>
>>> IIUC in your latest public version is not optimized, but I can check the
>>> new version when it comes.
>> I've some optimizations in next version keeping the code lines minimum. The
>> best optimization would be to add a page walk dedicated for this engaging
>> write-protect. I don't want to do that. Lets try to improve this patch in
>> how ever way possible. So that WP from UFFD ioctl can be used.
> 
> If you want to do this there, I think it can be simply/mostly a copy-paste
> of this patch over there by looping over the vmas and apply the protections.
I wouldn't want to do this. PAGEMAP IOCTL performing an operation
anonymously to UFFD_WP wouldn't look good when we can improve UFFD_WP itself.

> 
> I think it's fine to do it with ioctl(UFFDIO_WP), but I want to be crystal
> clear on what interface you're looking for before changing it, and let's
> define it properly.
Thank you. Let me crystal clear why we have sent this patch and what
difference we want.

Just like UFFDIO_REGISTER and UFFDIO_UNREGISTER don't care if the requested
range has multiple VMAs in the memory region, we want the same thing with
UFFDIO_WRITEPROTCET. It looks more uniform and obvious to us as user
doesn't care about VMAs. The user only cares about the memory he wants to
write-protect. So just update the inside code of UFFDIO_WRITEPROTECT such
that it starts to act like UFFDIO_REGISTER/UFFDIO_UNREGISTER. It shouldn't
complain if there are multiple VMAs involved under the hood.

This patch is visiting all the VMAs in the memory range. The attached
patches are my wip v3. If you feel like there can be better way to achieve
this, please don't hesitate to send the v3 yourself.

Thank you so much!

-- 
BR,
Muhammad Usama Anjum
--------------iEx36eCvzn0HQr4ilRpuSoFw
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-mm-userfaultfd-Support-WP-on-multiple-VMAs.patch"
Content-Disposition: attachment;
 filename="0001-mm-userfaultfd-Support-WP-on-multiple-VMAs.patch"
Content-Transfer-Encoding: base64

RnJvbSBmNjkwNjlkZGRkYTIwNmIxOTA3MDZlZWY3YjJkYWQzYTY3YTZkZjEwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNdWhhbW1hZCBVc2FtYSBBbmp1bSA8dXNhbWEuYW5q
dW1AY29sbGFib3JhLmNvbT4KRGF0ZTogVGh1LCA5IEZlYiAyMDIzIDE2OjEzOjIzICswNTAw
ClN1YmplY3Q6IFtQQVRDSCB2MyAxLzJdIG1tL3VzZXJmYXVsdGZkOiBTdXBwb3J0IFdQIG9u
IG11bHRpcGxlIFZNQXMKVG86IHBldGVyeEByZWRoYXQuY29tLCBkYXZpZEByZWRoYXQuY29t
CkNjOiB1c2FtYS5hbmp1bUBjb2xsYWJvcmEuY29tLCBrZXJuZWxAY29sbGFib3JhLmNvbQoK
bXdyaXRlcHJvdGVjdF9yYW5nZSgpIGVycm9ycyBvdXQgaWYgW3N0YXJ0LCBlbmQpIGRvZXNu
J3QgZmFsbCBpbiBvbmUKVk1BLiBXZSBhcmUgZmFjaW5nIGEgdXNlIGNhc2Ugd2hlcmUgbXVs
dGlwbGUgVk1BcyBhcmUgcHJlc2VudCBpbiBvbmUKcmFuZ2Ugb2YgaW50ZXJlc3QuIEZvciBl
eGFtcGxlLCB0aGUgZm9sbG93aW5nIHBzZXVkb2NvZGUgcmVwcm9kdWNlcyB0aGUKZXJyb3Ig
d2hpY2ggd2UgYXJlIHRyeWluZyB0byBmaXg6CgotIEFsbG9jYXRlIG1lbW9yeSBvZiBzaXpl
IDE2IHBhZ2VzIHdpdGggUFJPVF9OT05FIHdpdGggbW1hcAotIFJlZ2lzdGVyIHVzZXJmYXVs
dGZkCi0gQ2hhbmdlIHByb3RlY3Rpb24gb2YgdGhlIGZpcnN0IGhhbGYgKDEgdG8gOCBwYWdl
cykgb2YgbWVtb3J5IHRvCiAgUFJPVF9SRUFEIHwgUFJPVF9XUklURS4gVGhpcyBicmVha3Mg
dGhlIG1lbW9yeSBhcmVhIGluIHR3byBWTUFzLgotIE5vdyBVRkZESU9fV1JJVEVQUk9URUNU
X01PREVfV1Agb24gdGhlIHdob2xlIG1lbW9yeSBvZiAxNiBwYWdlcyBlcnJvcnMKICBvdXQu
CgpUaGlzIGlzIGEgc2ltcGxlIHVzZSBjYXNlIHdoZXJlIHVzZXIgbWF5IG9yIG1heSBub3Qg
a25vdyBpZiB0aGUgbWVtb3J5CmFyZWEgaGFzIGJlZW4gZGl2aWRlZCBpbnRvIG11bHRpcGxl
IFZNQXMuCgpSZXBvcnRlZC1ieTogUGF1bCBHb2ZtYW4gPHBnb2ZtYW5AY29kZXdlYXZlcnMu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBNdWhhbW1hZCBVc2FtYSBBbmp1bSA8dXNhbWEuYW5qdW1A
Y29sbGFib3JhLmNvbT4KLS0tCkNoYW5nZXMgc2luY2UgdjI6Ci0gQ29ycmVjdCB0aGUgcmV0
dXJuIGVycm9yIGNvZGUKCkNoYW5nZXMgc2luY2UgdjE6Ci0gQ29ycmVjdCB0aGUgc3RhcnQg
YW5kIGVuZGluZyB2YWx1ZXMgcGFzc2VkIHRvIHVmZmRfd3BfcmFuZ2UoKQotLS0KIG1tL3Vz
ZXJmYXVsdGZkLmMgfCA0NSArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9tbS91c2VyZmF1bHRmZC5jIGIvbW0vdXNlcmZhdWx0ZmQu
YwppbmRleCA2NWFkMTcyYWRkMjcuLmEzYjQ4YTk5Yjk0MiAxMDA2NDQKLS0tIGEvbW0vdXNl
cmZhdWx0ZmQuYworKysgYi9tbS91c2VyZmF1bHRmZC5jCkBAIC03MzgsOSArNzM4LDEyIEBA
IGludCBtd3JpdGVwcm90ZWN0X3JhbmdlKHN0cnVjdCBtbV9zdHJ1Y3QgKmRzdF9tbSwgdW5z
aWduZWQgbG9uZyBzdGFydCwKIAkJCXVuc2lnbmVkIGxvbmcgbGVuLCBib29sIGVuYWJsZV93
cCwKIAkJCWF0b21pY190ICptbWFwX2NoYW5naW5nKQogeworCXVuc2lnbmVkIGxvbmcgZW5k
ID0gc3RhcnQgKyBsZW47CisJdW5zaWduZWQgbG9uZyBfc3RhcnQsIF9lbmQ7CiAJc3RydWN0
IHZtX2FyZWFfc3RydWN0ICpkc3Rfdm1hOwogCXVuc2lnbmVkIGxvbmcgcGFnZV9tYXNrOwot
CWludCBlcnI7CisJaW50IGVyciA9IC1FTk9FTlQ7CisJVk1BX0lURVJBVE9SKHZtaSwgZHN0
X21tLCBzdGFydCk7CiAKIAkvKgogCSAqIFNhbml0aXplIHRoZSBjb21tYW5kIHBhcmFtZXRl
cnM6CkBAIC03NTgsMzAgKzc2MSwzNCBAQCBpbnQgbXdyaXRlcHJvdGVjdF9yYW5nZShzdHJ1
Y3QgbW1fc3RydWN0ICpkc3RfbW0sIHVuc2lnbmVkIGxvbmcgc3RhcnQsCiAJICogb3BlcmF0
aW9uIChlLmcuIG1yZW1hcCkgcnVubmluZyBpbiBwYXJhbGxlbCwgYmFpbCBvdXQgYW5kCiAJ
ICogcmVxdWVzdCB0aGUgdXNlciB0byByZXRyeSBsYXRlcgogCSAqLwotCWVyciA9IC1FQUdB
SU47Ci0JaWYgKG1tYXBfY2hhbmdpbmcgJiYgYXRvbWljX3JlYWQobW1hcF9jaGFuZ2luZykp
CisJaWYgKG1tYXBfY2hhbmdpbmcgJiYgYXRvbWljX3JlYWQobW1hcF9jaGFuZ2luZykpIHsK
KwkJZXJyID0gLUVBR0FJTjsKIAkJZ290byBvdXRfdW5sb2NrOworCX0KIAotCWVyciA9IC1F
Tk9FTlQ7Ci0JZHN0X3ZtYSA9IGZpbmRfZHN0X3ZtYShkc3RfbW0sIHN0YXJ0LCBsZW4pOwor
CWZvcl9lYWNoX3ZtYV9yYW5nZSh2bWksIGRzdF92bWEsIGVuZCkgeworCQllcnIgPSAtRU5P
RU5UOwogCi0JaWYgKCFkc3Rfdm1hKQotCQlnb3RvIG91dF91bmxvY2s7Ci0JaWYgKCF1c2Vy
ZmF1bHRmZF93cChkc3Rfdm1hKSkKLQkJZ290byBvdXRfdW5sb2NrOwotCWlmICghdm1hX2Nh
bl91c2VyZmF1bHQoZHN0X3ZtYSwgZHN0X3ZtYS0+dm1fZmxhZ3MpKQotCQlnb3RvIG91dF91
bmxvY2s7CisJCWlmICghZHN0X3ZtYS0+dm1fdXNlcmZhdWx0ZmRfY3R4LmN0eCkKKwkJCWJy
ZWFrOworCQlpZiAoIXVzZXJmYXVsdGZkX3dwKGRzdF92bWEpKQorCQkJYnJlYWs7CisJCWlm
ICghdm1hX2Nhbl91c2VyZmF1bHQoZHN0X3ZtYSwgZHN0X3ZtYS0+dm1fZmxhZ3MpKQorCQkJ
YnJlYWs7CiAKLQlpZiAoaXNfdm1faHVnZXRsYl9wYWdlKGRzdF92bWEpKSB7Ci0JCWVyciA9
IC1FSU5WQUw7Ci0JCXBhZ2VfbWFzayA9IHZtYV9rZXJuZWxfcGFnZXNpemUoZHN0X3ZtYSkg
LSAxOwotCQlpZiAoKHN0YXJ0ICYgcGFnZV9tYXNrKSB8fCAobGVuICYgcGFnZV9tYXNrKSkK
LQkJCWdvdG8gb3V0X3VubG9jazsKLQl9CisJCWlmIChpc192bV9odWdldGxiX3BhZ2UoZHN0
X3ZtYSkpIHsKKwkJCWVyciA9IC1FSU5WQUw7CisJCQlwYWdlX21hc2sgPSB2bWFfa2VybmVs
X3BhZ2VzaXplKGRzdF92bWEpIC0gMTsKKwkJCWlmICgoc3RhcnQgJiBwYWdlX21hc2spIHx8
IChsZW4gJiBwYWdlX21hc2spKQorCQkJCWJyZWFrOworCQl9CiAKLQl1ZmZkX3dwX3Jhbmdl
KGRzdF9tbSwgZHN0X3ZtYSwgc3RhcnQsIGxlbiwgZW5hYmxlX3dwKTsKKwkJX3N0YXJ0ID0g
KGRzdF92bWEtPnZtX3N0YXJ0ID4gc3RhcnQpID8gZHN0X3ZtYS0+dm1fc3RhcnQgOiBzdGFy
dDsKKwkJX2VuZCA9IChkc3Rfdm1hLT52bV9lbmQgPCBlbmQpID8gZHN0X3ZtYS0+dm1fZW5k
IDogZW5kOwogCi0JZXJyID0gMDsKKwkJdWZmZF93cF9yYW5nZShkc3RfbW0sIGRzdF92bWEs
IF9zdGFydCwgX2VuZCAtIF9zdGFydCwgZW5hYmxlX3dwKTsKKwkJZXJyID0gMDsKKwl9CiBv
dXRfdW5sb2NrOgogCW1tYXBfcmVhZF91bmxvY2soZHN0X21tKTsKIAlyZXR1cm4gZXJyOwot
LSAKMi4zOS4xCgo=
--------------iEx36eCvzn0HQr4ilRpuSoFw
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-mm-userfaultfd-add-VM_WARN_ONCE.patch"
Content-Disposition: attachment;
 filename="0002-mm-userfaultfd-add-VM_WARN_ONCE.patch"
Content-Transfer-Encoding: base64

RnJvbSBhYzExOWIyMmFhMDAyNDhlZDY3YzdhYzZlMjg1YTEyMzkxOTQzYjE1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNdWhhbW1hZCBVc2FtYSBBbmp1bSA8dXNhbWEuYW5q
dW1AY29sbGFib3JhLmNvbT4KRGF0ZTogTW9uLCAxMyBGZWIgMjAyMyAyMToxNTowMSArMDUw
MApTdWJqZWN0OiBbUEFUQ0ggdjMgMi8yXSBtbS91c2VyZmF1bHRmZDogYWRkIFZNX1dBUk5f
T05DRSgpClRvOiBwZXRlcnhAcmVkaGF0LmNvbSwgZGF2aWRAcmVkaGF0LmNvbQpDYzogdXNh
bWEuYW5qdW1AY29sbGFib3JhLmNvbSwga2VybmVsQGNvbGxhYm9yYS5jb20KCkFkZCBWTV9X
QVJOX09OQ0UoKSB0byB1ZmZkX3dwX3JhbmdlKCkgdG8gZGV0ZWN0IHJhbmdlIChzdGFydCwg
bGVuKSBhYnVzZS4KClNpZ25lZC1vZmYtYnk6IE11aGFtbWFkIFVzYW1hIEFuanVtIDx1c2Ft
YS5hbmp1bUBjb2xsYWJvcmEuY29tPgotLS0KIG1tL3VzZXJmYXVsdGZkLmMgfCAyICsrCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbW0vdXNlcmZh
dWx0ZmQuYyBiL21tL3VzZXJmYXVsdGZkLmMKaW5kZXggYTNiNDhhOTliOTQyLi4wNTM2ZTIz
YmE1ZjQgMTAwNjQ0Ci0tLSBhL21tL3VzZXJmYXVsdGZkLmMKKysrIGIvbW0vdXNlcmZhdWx0
ZmQuYwpAQCAtNzE2LDYgKzcxNiw4IEBAIHZvaWQgdWZmZF93cF9yYW5nZShzdHJ1Y3QgbW1f
c3RydWN0ICpkc3RfbW0sIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqZHN0X3ZtYSwKIAl1bnNp
Z25lZCBpbnQgbW1fY3BfZmxhZ3M7CiAJc3RydWN0IG1tdV9nYXRoZXIgdGxiOwogCisJVk1f
V0FSTl9PTkNFKHN0YXJ0IDwgZHN0X3ZtYS0+dm1fc3RhcnQgfHwgc3RhcnQgKyBsZW4gPiBk
c3Rfdm1hLT52bV9lbmQsCisJCSAgICAgIlRoZSBhZGRyZXNzIHJhbmdlIGV4Y2VlZHMgVk1B
IGJvdW5kYXJ5LlxuIik7CiAJaWYgKGVuYWJsZV93cCkKIAkJbW1fY3BfZmxhZ3MgPSBNTV9D
UF9VRkZEX1dQOwogCWVsc2UKLS0gCjIuMzkuMQoK

--------------iEx36eCvzn0HQr4ilRpuSoFw--
