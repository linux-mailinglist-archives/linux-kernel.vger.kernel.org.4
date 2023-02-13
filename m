Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB2A694E68
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjBMRuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBMRuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:50:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB2A14E9C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:50:47 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.179.179])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CAB226600357;
        Mon, 13 Feb 2023 17:50:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676310645;
        bh=xeODPhDIfFUyaS2Gon5ykxRQvpUcZt1AbKfG1EsXaCE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=jMSob38MBuOfwjSoUmGu4kU2zAju9fanwAIlMOujFuggRlI6nkVfcrQIl+nHLx7tY
         PilEa5cLKzGgYuakyeiC9tQKGCw5ui2j0pQZ6V0MiwZ/7u9kT7tr7xxZiP4N2rLbyj
         R4oO1PpxyilWHV1ziQZR33f1HfuP/eJX5iEoFno8qhHJn9mj+gamdUxpEucFem4/Hm
         vluSpuDKNmXTDU0gNhlywP6DM74eKIqDXgWJJcRMikfEzOp8ft+/Pe2YfVAE3Frk5o
         ot79JUNS+okr6DJNQnKjHerNTlxN0D9sO3FJDXvg7ttRTpDxugM6qhPCKyhA56bkFa
         zTtR/wfs00GrQ==
Message-ID: <9f0278d7-54f1-960e-ffdf-eeb2572ff6d1@collabora.com>
Date:   Mon, 13 Feb 2023 22:50:39 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>, david@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, Paul Gofman <pgofman@codeweavers.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/userfaultfd: Support WP on multiple VMAs
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230213163124.2850816-1-usama.anjum@collabora.com>
 <Y+prUgFQqmytC/5M@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y+prUgFQqmytC/5M@x1n>
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

On 2/13/23 9:54 PM, Peter Xu wrote:
> On Mon, Feb 13, 2023 at 09:31:23PM +0500, Muhammad Usama Anjum wrote:
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
>> Changes since v1:
>> - Correct the start and ending values passed to uffd_wp_range()
>> ---
>>  mm/userfaultfd.c | 38 ++++++++++++++++++++++----------------
>>  1 file changed, 22 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> index 65ad172add27..bccea08005a8 100644
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
>>  	int err;
> 
> I think this needs to be initialized or it can return anything when range
> not mapped.
It is being initialized to -EAGAIN already. It is not visible in this patch.

> 
>> +	VMA_ITERATOR(vmi, dst_mm, start);
>>  
>>  	/*
>>  	 * Sanitize the command parameters:
>> @@ -762,26 +765,29 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>>  	if (mmap_changing && atomic_read(mmap_changing))
>>  		goto out_unlock;
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
>> +		if (!userfaultfd_wp(dst_vma))
>> +			break;
>> +		if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
>> +			break;
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
>>  
>> -	err = 0;
>> +		uffd_wp_range(dst_mm, dst_vma, _start, _end - _start, enable_wp);
>> +		err = 0;
>> +	}
>>  out_unlock:
>>  	mmap_read_unlock(dst_mm);
>>  	return err;
> 
> This whole patch also changes the abi, so I'm worried whether there can be
> app that relies on the existing behavior.
Even if a app is dependent on it, this change would just don't return error
if there are multiple VMAs under the hood and handle them correctly. Most
apps wouldn't care about VMAs anyways. I don't know if there would be any
drastic behavior change, other than the behavior becoming nicer.

> 
> Is this for the new pagemap effort?  Can this just be done in the new
> interface rather than changing the old?
We found this bug while working on pagemap patches. It is already being
handled in the new interface. We just thought that this use case can happen
pretty easily and unknowingly. So the support should be added.

Also mwriteprotect_range() gives a pretty straight forward way to WP or
un-WP a range. Async WP can be used in coordination with pagemap file
(PM_UFFD_WP flag in PTE) as well. There may be use cases for it. On another
note, I don't see any use cases of WP async and PM_UFFD_WP flag as
!PM_UFFD_WP flag doesn't give direct information if the page is written for
!present pages.

> 
> Side note: in your other pagemap series, you can optimize "WP_ENGAGE &&
> !GET" to not do generic pgtable walk at all, but use what it does in this
> patch for the initial round or wr-protect.
Yeah, it is implemented with some optimizations.

> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum
