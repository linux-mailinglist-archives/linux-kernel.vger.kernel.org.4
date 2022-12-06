Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28C3644224
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbiLFL3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiLFL2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:28:51 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C89E48
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 03:28:48 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NRJ7M2YcTz15Mxx;
        Tue,  6 Dec 2022 19:27:59 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 19:28:45 +0800
Subject: Re: [PATCH v4 12/17] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
To:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
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
        Oded Gabbay <oded.gabbay@gmail.com>, <linux-mm@kvack.org>
References: <20220428083441.37290-1-david@redhat.com>
 <20220428083441.37290-13-david@redhat.com>
 <90dd6a93-4500-e0de-2bf0-bf522c311b0c@huawei.com>
 <3c7fd5da-b3f8-5562-45a9-f83d7dbcdd7d@redhat.com>
 <d51a7163-b082-d43a-1d0d-13ebf8cb538d@huawei.com>
 <e679e859-8c08-36e6-24c4-6fea50fe485b@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <954b0bd3-bf7d-5c4b-5d76-8ac13b5ee8ac@huawei.com>
Date:   Tue, 6 Dec 2022 19:28:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e679e859-8c08-36e6-24c4-6fea50fe485b@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/6 17:40, David Hildenbrand wrote:
> On 06.12.22 10:37, Miaohe Lin wrote:
>> On 2022/12/6 16:43, David Hildenbrand wrote:
>>>>>
>>>>
>>>> Hi David, sorry for the late respond and a possible inconsequential question. :)
>>>
>>> Better late than never! Thanks for the review, independently at which time it happens :)
>>>
>>>>
>>>> <snip>
>>>>
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index 7a71ed679853..5add8bbd47cd 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -4772,7 +4772,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>>>>>                        is_hugetlb_entry_hwpoisoned(entry))) {
>>>>>                swp_entry_t swp_entry = pte_to_swp_entry(entry);
>>>>>    -            if (is_writable_migration_entry(swp_entry) && cow) {
>>>>> +            if (!is_readable_migration_entry(swp_entry) && cow) {
>>>>>                    /*
>>>>>                     * COW mappings require pages in both
>>>>>                     * parent and child to be set to read.
>>>>> @@ -5172,6 +5172,8 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>>>>>            set_huge_ptep_writable(vma, haddr, ptep);
>>>>>            return 0;
>>>>>        }
>>>>> +    VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page),
>>>>> +               old_page);
>>>>>          /*
>>>>>         * If the process that created a MAP_PRIVATE mapping is about to
>>>>> @@ -6169,12 +6171,17 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>>>>>            }
>>>>>            if (unlikely(is_hugetlb_entry_migration(pte))) {
>>>>>                swp_entry_t entry = pte_to_swp_entry(pte);
>>>>> +            struct page *page = pfn_swap_entry_to_page(entry);
>>>>>    -            if (is_writable_migration_entry(entry)) {
>>>>> +            if (!is_readable_migration_entry(entry)) {
>>>>
>>>> In hugetlb_change_protection(), is_writable_migration_entry() is changed to !is_readable_migration_entry(),
>>>> but
>>>>
>>>>>                    pte_t newpte;
>>>>>    -                entry = make_readable_migration_entry(
>>>>> -                            swp_offset(entry));
>>>>> +                if (PageAnon(page))
>>>>> +                    entry = make_readable_exclusive_migration_entry(
>>>>> +                                swp_offset(entry));
>>>>> +                else
>>>>> +                    entry = make_readable_migration_entry(
>>>>> +                                swp_offset(entry));
>>>>>                    newpte = swp_entry_to_pte(entry);
>>>>>                    set_huge_swap_pte_at(mm, address, ptep,
>>>>>                                 newpte, huge_page_size(h));
>>>>
>>>> <snip>
>>>>
>>>>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>>>>> index b69ce7a7b2b7..56060acdabd3 100644
>>>>> --- a/mm/mprotect.c
>>>>> +++ b/mm/mprotect.c
>>>>> @@ -152,6 +152,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>>>>>                pages++;
>>>>>            } else if (is_swap_pte(oldpte)) {
>>>>>                swp_entry_t entry = pte_to_swp_entry(oldpte);
>>>>> +            struct page *page = pfn_swap_entry_to_page(entry);
>>>>>                pte_t newpte;
>>>>>                  if (is_writable_migration_entry(entry)) {
>>>>
>>>> In change_pte_range(), is_writable_migration_entry() is not changed to !is_readable_migration_entry().
>>>
>>> Yes, and also in change_huge_pmd(), is_writable_migration_entry() stays unchanged.
>>>
>>>> Is this done intentionally? Could you tell me why there's such a difference? I'm confused. It's very
>>>> kind of you if you can answer my puzzle.
>>>
>>> For change protection, the only relevant part is to convert writable -> readable or writable -> readable_exclusive.
>>>
>>> If an entry is already readable or readable_exclusive, there is nothing to do. The only issues would be when turning a readable one into a readable_exclusive one or a readable_exclusive one into a readable one.
>>>
>>>
>>> In hugetlb_change_protection(), the "!is_readable_migration_entry" could in fact be turned into a "is_writable_migration_entry()". Right now, it would convert writable -> readable or writable -> readable_exclusive AND readable -> readable AND readable_exclusive -> readable_exclusive, which isn't necessary but also shouldn't hurt either.
>>
>> Many thanks for your explanation. It's really helpful. :)
>>
>>>
>>>
>>> So yeah, it's not consistent but shouldn't be problematic. Do you see an issue with that?
>>
>> No, I don't see any issue with that. I just wonder whether we can change "!is_readable_migration_entry" to "is_writable_migration_entry()" to make code
>> more consistent and avoid possible future puzzle. Also we can further remove this harmless unnecessary migration entry conversion. But this should
>> be a separate cleanup patch anyway.
> 
> Want to send a patch? :)

Queued in my todo list. ;)

Thanks!
Miaohe Lin


