Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43B9737352
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjFTRzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjFTRz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8567D1718
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687283683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gojzR5WISxJHEnX2DoI8Gc/njk+/NnRGSK3Ash3pL8g=;
        b=iOI3bPv+xr48HZZGnWrmOqBbmqilMTxzmj1VCz+LX7vzrU2kTTT18XA8BLBaD+jYg3LLqb
        FTflUWO4EzufN7K2kJWZBotWRUjfRbSkvom9zCvmtOE5TJrTE3QK+1wh5T6eIXrSKZvwXB
        5e5UNY8EVbpoAqBjonutJVQcAvaAXbo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-Yye6eZkpOZ2yjDNtqHVNgg-1; Tue, 20 Jun 2023 13:54:42 -0400
X-MC-Unique: Yye6eZkpOZ2yjDNtqHVNgg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f8f1b55a6fso19748175e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687283681; x=1689875681;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gojzR5WISxJHEnX2DoI8Gc/njk+/NnRGSK3Ash3pL8g=;
        b=bsMp+cLAnzJjftorhtB3dgIgaKsEu3MyycNqttcBu3Ae4/eP6gDYuUz++sVa0+TkJL
         3ncz0SoDfuMo2672O46fyM/OC99x63+fGfMmU11XYVHpZQiQ4IrBy9VdyeUTdoQSYzi9
         twGcdtCM5MsKxt9P0IukKhlsOHJwLGt3ypK6UX2SddmNWurROzdCKB10kyxJZwLZNBVO
         ea7WwTGb6giyZ/8tBh7gaTTlrMXnK667+I70zuqPdE8PPl6ycO761LZxop76ZWrCDrfm
         F6/KCtw1Po+61cvtyP0yUVWEzaz7emp+h4rTQ2K/JdPWercfEFikgSiQDNq8B8w4Xpxd
         r+KQ==
X-Gm-Message-State: AC+VfDyny7aG8CsKFa/RedTQtDjg5l00j8Q1rZLJUKzdKq31CnvxN98p
        OkRGURpLswIMZxFrWKr3IzX3HIdHW6kirADB9aNtsWClVVqj8eKcvCdcBb86mB4ad/b/D6cVHzu
        7hpuvkEPXimsvgbZdg1ekHXMm
X-Received: by 2002:a05:600c:ca:b0:3f9:163:35d5 with SMTP id u10-20020a05600c00ca00b003f9016335d5mr7001409wmm.2.1687283681231;
        Tue, 20 Jun 2023 10:54:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7RU4XOxcrLw34Rla3rHgIIwFUKGh8fFSldVk9HR3d2qDl4YY7i/K9tCJPRB6NaRYSC80vonQ==
X-Received: by 2002:a05:600c:ca:b0:3f9:163:35d5 with SMTP id u10-20020a05600c00ca00b003f9016335d5mr7001387wmm.2.1687283680802;
        Tue, 20 Jun 2023 10:54:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:d200:8745:c520:8bf6:b587? (p200300cbc739d2008745c5208bf6b587.dip0.t-ipconnect.de. [2003:cb:c739:d200:8745:c520:8bf6:b587])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b002fae7408544sm2458409wrs.108.2023.06.20.10.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 10:54:40 -0700 (PDT)
Message-ID: <d574221c-acf8-0520-f266-e9eeeab0105a@redhat.com>
Date:   Tue, 20 Jun 2023 19:54:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/8] mm/hugetlb: Add page_mask for
 hugetlb_follow_page_mask()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20230619231044.112894-1-peterx@redhat.com>
 <20230619231044.112894-4-peterx@redhat.com>
 <d1f6c2c5-07d0-d430-49b3-68e9f5978534@redhat.com> <ZJHTqsCsLUAprEPc@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZJHTqsCsLUAprEPc@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.23 18:28, Peter Xu wrote:
> On Tue, Jun 20, 2023 at 05:23:09PM +0200, David Hildenbrand wrote:
>> On 20.06.23 01:10, Peter Xu wrote:
>>> follow_page() doesn't need it, but we'll start to need it when unifying gup
>>> for hugetlb.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    include/linux/hugetlb.h | 8 +++++---
>>>    mm/gup.c                | 3 ++-
>>>    mm/hugetlb.c            | 5 ++++-
>>>    3 files changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index beb7c63d2871..2e2d89e79d6c 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -131,7 +131,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>>>    int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
>>>    			    struct vm_area_struct *, struct vm_area_struct *);
>>>    struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>>> -				unsigned long address, unsigned int flags);
>>> +				      unsigned long address, unsigned int flags,
>>> +				      unsigned int *page_mask);
>>>    long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
>>>    			 struct page **, unsigned long *, unsigned long *,
>>>    			 long, unsigned int, int *);
>>> @@ -297,8 +298,9 @@ static inline void adjust_range_if_pmd_sharing_possible(
>>>    {
>>>    }
>>> -static inline struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>>> -				unsigned long address, unsigned int flags)
>>> +static inline struct page *hugetlb_follow_page_mask(
>>> +    struct vm_area_struct *vma, unsigned long address, unsigned int flags,
>>> +    unsigned int *page_mask)
>>>    {
>>>    	BUILD_BUG(); /* should never be compiled in if !CONFIG_HUGETLB_PAGE*/
>>>    }
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index abcd841d94b7..9fc9271cba8d 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -780,7 +780,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
>>>    	 * Ordinary GUP uses follow_hugetlb_page for hugetlb processing.
>>>    	 */
>>>    	if (is_vm_hugetlb_page(vma))
>>> -		return hugetlb_follow_page_mask(vma, address, flags);
>>> +		return hugetlb_follow_page_mask(vma, address, flags,
>>> +						&ctx->page_mask);
>>>    	pgd = pgd_offset(mm, address);
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 9a6918c4250a..fbf6a09c0ec4 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -6454,7 +6454,8 @@ static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
>>>    }
>>>    struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>>> -				unsigned long address, unsigned int flags)
>>> +				      unsigned long address, unsigned int flags,
>>> +				      unsigned int *page_mask)
>>>    {
>>>    	struct hstate *h = hstate_vma(vma);
>>>    	struct mm_struct *mm = vma->vm_mm;
>>> @@ -6499,6 +6500,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>>>    			page = NULL;
>>>    			goto out;
>>>    		}
>>> +
>>> +		*page_mask = ~huge_page_mask(h) >> PAGE_SHIFT;
>>
>> As discussed, can be simplified. But can be done on top (or not at all, but
>> it is confusing code).
> 
> Since we decided to make this prettier..  At last I decided to go with this:
> 
> 		*page_mask = (1U << huge_page_order(h)) - 1;
> 
> The previous suggestion of PHYS_PFN() will do two shifts over PAGE_SIZE
> (the other one in huge_page_size()) which might be unnecessary, also, PHYS_
> can be slightly misleading too as prefix.
> 
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> I'll take this with above change, please shoot if not applicable.  Thanks,
> 

Perfectly fine :)

-- 
Cheers,

David / dhildenb

