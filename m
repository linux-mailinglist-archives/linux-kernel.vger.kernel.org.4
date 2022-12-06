Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9767644001
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiLFJlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiLFJlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:41:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC2D1CFD9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670319617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TW5dHJarb7+FFAmmzS1Os44E3J0QfUoAGmh4ld8vUpU=;
        b=i9yCub0lViqnj8ukHX4Pg2LxR6MRoSywYM0iUv7RQN75PauKntyVzPM8RTApDBumfrMJCf
        gCvun/IPlXL0Isg1xsLp7I2gI/NpqeP+Nbyl25gtGUi8UbmTWPT/Omo1mm6djq3CxVKbkE
        OZlzsxftW8uaJD6o1T1DWSXb9NxBZL0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-259-e_P1z54oMQG1SfHbb2G6Kw-1; Tue, 06 Dec 2022 04:40:14 -0500
X-MC-Unique: e_P1z54oMQG1SfHbb2G6Kw-1
Received: by mail-wm1-f70.google.com with SMTP id 9-20020a1c0209000000b003d1c0a147f6so3570036wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 01:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TW5dHJarb7+FFAmmzS1Os44E3J0QfUoAGmh4ld8vUpU=;
        b=w6bNZCXvv/TRHKBU1oP2bOiXQ1XVhe/KuL+Rppk+jSAigG7XANBBNT/zfl6+Mg5PVU
         qsGNiV6kwfw5H7v/nRiimkXqdAKXgO+FEf1jYKMpxYOiPyI1sM/SKlpkbKVPD0Yjv1Wu
         Kyfukd8Vn47tiNH26SmlonlgVieRdAKsqG7f2nhAJD08EJSJd/mqCNLiGxtWYAjJYi8g
         JzUGwTYjTIPGDxEl9m5CF41eZE5oEPMQuft9UFqHNcUoAyZpkNZRJ2RizRzaJXY0wMFH
         EGDu9geCkaRwzUkWZk6W8zG0uq/3Wa0w3QzDjvTWac1JQlyo4B5UY4xsPO8ru0SPkixT
         3WLg==
X-Gm-Message-State: ANoB5pkvzQA6uGDjIz8XALSHje+xrbGuRKlVrp7XHDtvfCmZFoiflFij
        zDX9KPb/vbw1EE7Z0mMonYG7lcQZIPpQA7gHVWSsYxkPh0Iayf6J9T/q7YD7aajaaElWFw5NFJq
        s9oOFeiS+YvGtVcuUm9QMkQmA
X-Received: by 2002:a05:600c:3d98:b0:3cf:e9a4:325f with SMTP id bi24-20020a05600c3d9800b003cfe9a4325fmr61640502wmb.98.1670319613324;
        Tue, 06 Dec 2022 01:40:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7MtVVtl9RFgBHMNRf56gOZudqLVuxoYvL6ZChVKkkD30HPJrmCQbk5WjN+rcIYKSw8XOV2sA==
X-Received: by 2002:a05:600c:3d98:b0:3cf:e9a4:325f with SMTP id bi24-20020a05600c3d9800b003cfe9a4325fmr61640458wmb.98.1670319612945;
        Tue, 06 Dec 2022 01:40:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4f00:41f1:185d:4f9f:d1c2? (p200300cbc7054f0041f1185d4f9fd1c2.dip0.t-ipconnect.de. [2003:cb:c705:4f00:41f1:185d:4f9f:d1c2])
        by smtp.gmail.com with ESMTPSA id z8-20020adfdf88000000b002258235bda3sm16231837wrl.61.2022.12.06.01.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 01:40:12 -0800 (PST)
Message-ID: <e679e859-8c08-36e6-24c4-6fea50fe485b@redhat.com>
Date:   Tue, 6 Dec 2022 10:40:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 12/17] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220428083441.37290-1-david@redhat.com>
 <20220428083441.37290-13-david@redhat.com>
 <90dd6a93-4500-e0de-2bf0-bf522c311b0c@huawei.com>
 <3c7fd5da-b3f8-5562-45a9-f83d7dbcdd7d@redhat.com>
 <d51a7163-b082-d43a-1d0d-13ebf8cb538d@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <d51a7163-b082-d43a-1d0d-13ebf8cb538d@huawei.com>
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

On 06.12.22 10:37, Miaohe Lin wrote:
> On 2022/12/6 16:43, David Hildenbrand wrote:
>>>>
>>>
>>> Hi David, sorry for the late respond and a possible inconsequential question. :)
>>
>> Better late than never! Thanks for the review, independently at which time it happens :)
>>
>>>
>>> <snip>
>>>
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 7a71ed679853..5add8bbd47cd 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -4772,7 +4772,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>>>>                        is_hugetlb_entry_hwpoisoned(entry))) {
>>>>                swp_entry_t swp_entry = pte_to_swp_entry(entry);
>>>>    -            if (is_writable_migration_entry(swp_entry) && cow) {
>>>> +            if (!is_readable_migration_entry(swp_entry) && cow) {
>>>>                    /*
>>>>                     * COW mappings require pages in both
>>>>                     * parent and child to be set to read.
>>>> @@ -5172,6 +5172,8 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>>>>            set_huge_ptep_writable(vma, haddr, ptep);
>>>>            return 0;
>>>>        }
>>>> +    VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page),
>>>> +               old_page);
>>>>          /*
>>>>         * If the process that created a MAP_PRIVATE mapping is about to
>>>> @@ -6169,12 +6171,17 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>>>>            }
>>>>            if (unlikely(is_hugetlb_entry_migration(pte))) {
>>>>                swp_entry_t entry = pte_to_swp_entry(pte);
>>>> +            struct page *page = pfn_swap_entry_to_page(entry);
>>>>    -            if (is_writable_migration_entry(entry)) {
>>>> +            if (!is_readable_migration_entry(entry)) {
>>>
>>> In hugetlb_change_protection(), is_writable_migration_entry() is changed to !is_readable_migration_entry(),
>>> but
>>>
>>>>                    pte_t newpte;
>>>>    -                entry = make_readable_migration_entry(
>>>> -                            swp_offset(entry));
>>>> +                if (PageAnon(page))
>>>> +                    entry = make_readable_exclusive_migration_entry(
>>>> +                                swp_offset(entry));
>>>> +                else
>>>> +                    entry = make_readable_migration_entry(
>>>> +                                swp_offset(entry));
>>>>                    newpte = swp_entry_to_pte(entry);
>>>>                    set_huge_swap_pte_at(mm, address, ptep,
>>>>                                 newpte, huge_page_size(h));
>>>
>>> <snip>
>>>
>>>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>>>> index b69ce7a7b2b7..56060acdabd3 100644
>>>> --- a/mm/mprotect.c
>>>> +++ b/mm/mprotect.c
>>>> @@ -152,6 +152,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>>>>                pages++;
>>>>            } else if (is_swap_pte(oldpte)) {
>>>>                swp_entry_t entry = pte_to_swp_entry(oldpte);
>>>> +            struct page *page = pfn_swap_entry_to_page(entry);
>>>>                pte_t newpte;
>>>>                  if (is_writable_migration_entry(entry)) {
>>>
>>> In change_pte_range(), is_writable_migration_entry() is not changed to !is_readable_migration_entry().
>>
>> Yes, and also in change_huge_pmd(), is_writable_migration_entry() stays unchanged.
>>
>>> Is this done intentionally? Could you tell me why there's such a difference? I'm confused. It's very
>>> kind of you if you can answer my puzzle.
>>
>> For change protection, the only relevant part is to convert writable -> readable or writable -> readable_exclusive.
>>
>> If an entry is already readable or readable_exclusive, there is nothing to do. The only issues would be when turning a readable one into a readable_exclusive one or a readable_exclusive one into a readable one.
>>
>>
>> In hugetlb_change_protection(), the "!is_readable_migration_entry" could in fact be turned into a "is_writable_migration_entry()". Right now, it would convert writable -> readable or writable -> readable_exclusive AND readable -> readable AND readable_exclusive -> readable_exclusive, which isn't necessary but also shouldn't hurt either.
> 
> Many thanks for your explanation. It's really helpful. :)
> 
>>
>>
>> So yeah, it's not consistent but shouldn't be problematic. Do you see an issue with that?
> 
> No, I don't see any issue with that. I just wonder whether we can change "!is_readable_migration_entry" to "is_writable_migration_entry()" to make code
> more consistent and avoid possible future puzzle. Also we can further remove this harmless unnecessary migration entry conversion. But this should
> be a separate cleanup patch anyway.

Want to send a patch? :)

Thanks!

-- 
Thanks,

David / dhildenb

