Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3E0694A28
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjBMPFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjBMPE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:04:59 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39AC1E1E6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:04:52 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.179.179])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B4A2D66020C9;
        Mon, 13 Feb 2023 15:04:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676300691;
        bh=FFqNTh+pB9jzq4L/qxAe2P9DHqtSP7GObqnLLJOP62Y=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=RJVlpdbXOUDvG6eFedao3CmykJitwVSB9lbpAeQgCgKwRD8DBXEqlwXWP5mY2yG7H
         HmjEPxQ8rjHHIiis2fTwZ3Jch1334xdQcp6DMXcX1Yre/wDtIAT7v4Ao3P9x2s5Acn
         Yg90o5cvO7bUWQ8VYfbxnRcV7ZkwMSDo1MymHlyFKjnHDMmH0jfB1xQ3qeKQ5xj8im
         OP+wvZxy8nZBZ/YHhxejuJIAthFIQAUQn4SAWgwRj1+pqDb0Oz7/8YH4zT5fDppM3G
         mFmI727ud5T8AU/FcevIpg4pYRWJ8tqT2OexLGpUA+n2enK4CuLCHm2X6qjnKrN4rw
         CxD70vfnAUCHA==
Message-ID: <ca5ce36f-5821-a946-1c41-d1905c88c9f3@collabora.com>
Date:   Mon, 13 Feb 2023 20:04:45 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, Paul Gofman <pgofman@codeweavers.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: Support operation on multiple VMAs
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230213104323.1792839-1-usama.anjum@collabora.com>
 <bb1c9707-d127-43c9-b5ec-5e5dad282726@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <bb1c9707-d127-43c9-b5ec-5e5dad282726@redhat.com>
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

Hi David,

Thank you for quick review!

On 2/13/23 4:44 PM, David Hildenbrand wrote:
> On 13.02.23 11:43, Muhammad Usama Anjum wrote:
>> mwriteprotect_range() errors out if [start, end) doesn't fall in one
>> VMA. We are facing a use case where multiple VMAs are present in one
>> range of interest. For example, the following pseudocode reproduces the
>> error which we are trying to fix:
>>
>> - Allocate memory of size 16 pages with PROT_NONE with mmap
>> - Register userfaultfd
>> - Change protection of the first half (1 to 8 pages) of memory to
>>    PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
>> - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
>>    out.
>>
>> This is a simple use case where user may or may not know if the memory
>> area has been divided into multiple VMAs.
>>
>> Reported-by: Paul Gofman <pgofman@codeweavers.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   mm/userfaultfd.c | 36 +++++++++++++++++++-----------------
>>   1 file changed, 19 insertions(+), 17 deletions(-)
>>
>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> index 65ad172add27..46e0a014af68 100644
>> --- a/mm/userfaultfd.c
>> +++ b/mm/userfaultfd.c
>> @@ -738,9 +738,11 @@ int mwriteprotect_range(struct mm_struct *dst_mm,
>> unsigned long start,
>>               unsigned long len, bool enable_wp,
>>               atomic_t *mmap_changing)
>>   {
>> +    unsigned long end = start + len;
>>       struct vm_area_struct *dst_vma;
>>       unsigned long page_mask;
>>       int err;
>> +    VMA_ITERATOR(vmi, dst_mm, start);
>>         /*
>>        * Sanitize the command parameters:
>> @@ -762,26 +764,26 @@ int mwriteprotect_range(struct mm_struct *dst_mm,
>> unsigned long start,
>>       if (mmap_changing && atomic_read(mmap_changing))
>>           goto out_unlock;
>>   -    err = -ENOENT;
>> -    dst_vma = find_dst_vma(dst_mm, start, len);
>> -
>> -    if (!dst_vma)
>> -        goto out_unlock;
>> -    if (!userfaultfd_wp(dst_vma))
>> -        goto out_unlock;
>> -    if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
>> -        goto out_unlock;
>> +    for_each_vma_range(vmi, dst_vma, end) {
>> +        err = -ENOENT;
>>   -    if (is_vm_hugetlb_page(dst_vma)) {
>> -        err = -EINVAL;
>> -        page_mask = vma_kernel_pagesize(dst_vma) - 1;
>> -        if ((start & page_mask) || (len & page_mask))
>> -            goto out_unlock;
>> -    }
>> +        if (!dst_vma->vm_userfaultfd_ctx.ctx)
>> +            break;
>> +        if (!userfaultfd_wp(dst_vma))
>> +            break;
>> +        if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
>> +            break;
>>   -    uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
>> +        if (is_vm_hugetlb_page(dst_vma)) {
>> +            err = -EINVAL;
>> +            page_mask = vma_kernel_pagesize(dst_vma) - 1;
>> +            if ((start & page_mask) || (len & page_mask))
>> +                break;
>> +        }
>>   -    err = 0;
>> +        uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
> 
> I suspect you should be adjusting the range to only cover that specific VMA
> here.
Sorry, you are right. I don't know why it is still working with the
blunder. Will send a v2.

Thanks,
Usama

-- 
BR,
Muhammad Usama Anjum
