Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6A694A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjBMPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBMPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:13:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85391CAE8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676301144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q44SzMdooSXMXJeRZpOwcElNDmoy9RihuEQ1QO7JM9c=;
        b=AzJZZ/OX2/p6y1B/1mF9PD1w5CYvRqCiPJA4XvL91avzeP2LtDb+vuSCxPblJxE92o/Ac5
        AVzwwJwm5fpa6t70beTxlXFlT3IrIDdM3DRpFAU2ltcp9PIrwJJ0cRVZbTSKLPcgYbAWL0
        RBhD4JnXHsf5LCcs+uq7WfhO2J/VhsY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-401-WTHV8oKPPOatZr8O2Eq-1g-1; Mon, 13 Feb 2023 10:12:23 -0500
X-MC-Unique: WTHV8oKPPOatZr8O2Eq-1g-1
Received: by mail-wm1-f72.google.com with SMTP id p14-20020a05600c468e00b003e0107732f4so6301681wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q44SzMdooSXMXJeRZpOwcElNDmoy9RihuEQ1QO7JM9c=;
        b=2FQbpyc8wCMozRZOXhiIIt476ThLXUXEQZdSm6KMmarp4S33uWQM8xTURZEUmfOYLJ
         PQvNnRAFBkOaoxaYz0T5sr4MT3zmOFyAjdg/6i9lJ8BkLuMo0uS3oFxU5lJrU0NOkUo8
         QTNMMTv266KLA75OFnNJBykZjs9+QLtxOW1BWPBtv4Z1mJopndCj2XQA9f6BwRNqAUvM
         0j3ik1E1rsZ6aQfU6R8UllY6O+gGTBs6FZBIZb8v15/rlPt/iw5bfD34y6C6RnewyZee
         loIsblVxSgsi+tZHJlZSiB4nI6Yix4pv/ifff7ROYRGp51xpdIRChHzcB7UlxSll0sTL
         7+0Q==
X-Gm-Message-State: AO0yUKX/2qNNnn6dwMyRIcpoDaG0RxvTEEmhRTGamdsbGZ1QJNUWA0BO
        pbYJQnvcaBGN3XO8TO1L91wGJxwTdtlzZNAglHUyJfX0a8AUKmiD7HWYtNMBx9R1bqBwyMMeZy5
        KwrtaG7JgWpSa26BNADSWkKEsJLRekg==
X-Received: by 2002:a05:600c:601a:b0:3dc:42e7:f626 with SMTP id az26-20020a05600c601a00b003dc42e7f626mr19173257wmb.26.1676301142296;
        Mon, 13 Feb 2023 07:12:22 -0800 (PST)
X-Google-Smtp-Source: AK7set+jSOVTfdI4/1RwvFCtOf9bbApfXLC1oIVs5XF/of2Pf26darj2/ZKwUYO/IFWKiFJxUX7bWA==
X-Received: by 2002:a05:600c:601a:b0:3dc:42e7:f626 with SMTP id az26-20020a05600c601a00b003dc42e7f626mr19173242wmb.26.1676301142038;
        Mon, 13 Feb 2023 07:12:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003dd1c45a7b0sm14991291wms.23.2023.02.13.07.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:12:21 -0800 (PST)
Message-ID: <92597a6b-3c4e-ad11-a5ba-f7d3919b6ba1@redhat.com>
Date:   Mon, 13 Feb 2023 16:12:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/userfaultfd: Support operation on multiple VMAs
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@collabora.com, Paul Gofman <pgofman@codeweavers.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230213104323.1792839-1-usama.anjum@collabora.com>
 <bb1c9707-d127-43c9-b5ec-5e5dad282726@redhat.com>
 <ca5ce36f-5821-a946-1c41-d1905c88c9f3@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ca5ce36f-5821-a946-1c41-d1905c88c9f3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.23 16:04, Muhammad Usama Anjum wrote:
> Hi David,
> 
> Thank you for quick review!
> 
> On 2/13/23 4:44 PM, David Hildenbrand wrote:
>> On 13.02.23 11:43, Muhammad Usama Anjum wrote:
>>> mwriteprotect_range() errors out if [start, end) doesn't fall in one
>>> VMA. We are facing a use case where multiple VMAs are present in one
>>> range of interest. For example, the following pseudocode reproduces the
>>> error which we are trying to fix:
>>>
>>> - Allocate memory of size 16 pages with PROT_NONE with mmap
>>> - Register userfaultfd
>>> - Change protection of the first half (1 to 8 pages) of memory to
>>>     PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
>>> - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
>>>     out.
>>>
>>> This is a simple use case where user may or may not know if the memory
>>> area has been divided into multiple VMAs.
>>>
>>> Reported-by: Paul Gofman <pgofman@codeweavers.com>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>    mm/userfaultfd.c | 36 +++++++++++++++++++-----------------
>>>    1 file changed, 19 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>>> index 65ad172add27..46e0a014af68 100644
>>> --- a/mm/userfaultfd.c
>>> +++ b/mm/userfaultfd.c
>>> @@ -738,9 +738,11 @@ int mwriteprotect_range(struct mm_struct *dst_mm,
>>> unsigned long start,
>>>                unsigned long len, bool enable_wp,
>>>                atomic_t *mmap_changing)
>>>    {
>>> +    unsigned long end = start + len;
>>>        struct vm_area_struct *dst_vma;
>>>        unsigned long page_mask;
>>>        int err;
>>> +    VMA_ITERATOR(vmi, dst_mm, start);
>>>          /*
>>>         * Sanitize the command parameters:
>>> @@ -762,26 +764,26 @@ int mwriteprotect_range(struct mm_struct *dst_mm,
>>> unsigned long start,
>>>        if (mmap_changing && atomic_read(mmap_changing))
>>>            goto out_unlock;
>>>    -    err = -ENOENT;
>>> -    dst_vma = find_dst_vma(dst_mm, start, len);
>>> -
>>> -    if (!dst_vma)
>>> -        goto out_unlock;
>>> -    if (!userfaultfd_wp(dst_vma))
>>> -        goto out_unlock;
>>> -    if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
>>> -        goto out_unlock;
>>> +    for_each_vma_range(vmi, dst_vma, end) {
>>> +        err = -ENOENT;
>>>    -    if (is_vm_hugetlb_page(dst_vma)) {
>>> -        err = -EINVAL;
>>> -        page_mask = vma_kernel_pagesize(dst_vma) - 1;
>>> -        if ((start & page_mask) || (len & page_mask))
>>> -            goto out_unlock;
>>> -    }
>>> +        if (!dst_vma->vm_userfaultfd_ctx.ctx)
>>> +            break;
>>> +        if (!userfaultfd_wp(dst_vma))
>>> +            break;
>>> +        if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
>>> +            break;
>>>    -    uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
>>> +        if (is_vm_hugetlb_page(dst_vma)) {
>>> +            err = -EINVAL;
>>> +            page_mask = vma_kernel_pagesize(dst_vma) - 1;
>>> +            if ((start & page_mask) || (len & page_mask))
>>> +                break;
>>> +        }
>>>    -    err = 0;
>>> +        uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
>>
>> I suspect you should be adjusting the range to only cover that specific VMA
>> here.
> Sorry, you are right. I don't know why it is still working with the
> blunder. Will send a v2.

Maybe worth adding some sanity checks (VM_WARN_ONCE()) in there (e.g., 
change_protection()) to catch that.

-- 
Thanks,

David / dhildenb

