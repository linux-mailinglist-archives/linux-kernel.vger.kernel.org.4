Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA06643EF3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiLFIpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiLFIpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:45:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967A0D12B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670316244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rchCSzvIhJmofJ14lURjIDvExoo3wjMkCA1LFuzN0Nw=;
        b=LW7l5S2zXOSaddFBvOFXYeTe9L/SBLqjZmvkrU/YUOLiiIaBZuD71ghepxC3rmv5zvT87x
        NynVg6oCNxldYQ3oUCOKIOIhNmDEzpnqTU87gqpIldyr0FXdhrQCzaOUjrx6n88zBXIw5l
        jqp9o4XEtghnUchekO0+eCArE05omTQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-WfxSc0H7PfqxIEoFfUDY3g-1; Tue, 06 Dec 2022 03:44:03 -0500
X-MC-Unique: WfxSc0H7PfqxIEoFfUDY3g-1
Received: by mail-wr1-f69.google.com with SMTP id w11-20020adfbacb000000b002418a90da01so2970663wrg.16
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rchCSzvIhJmofJ14lURjIDvExoo3wjMkCA1LFuzN0Nw=;
        b=J21hf7MjSlIzZr6Rm1l4qmQq97ro8tRamZuPfda6sYOcDUnB8qv8KE0u/gjZQKy17s
         kkr2qt5Z37drkW4yaiB6oeuubGESi3ie6OxEu+GqpzNKsqqvncO04CMWr0tzGQNeMFm2
         ugCkZ30aub9qor6W+mr4Mji8jnbJtCqc9CpFCLmZZixDVlKm5aMwnIAdlhBBMt7+OviA
         NT8Y3AMHijpeqThf0RP61PjcV+V1h2pL4jQ0E8PL3L6GR2FYa85tEM+LSMB1kEY0Gp6f
         pHhquZfMpvtUNnpm2PAv83QBJ26AA4UL/5POPEqqWRATH2do+j+yAzOXLlYn9OEbDD7w
         BbLQ==
X-Gm-Message-State: ANoB5pksdiflZm3JL79Ks3g9roZgyfVvmIXsjdhUzT+LkdedaGqsYqe7
        LibUunZEoJqXmLJnVXSvqlRzEuHxB8CPXRmfgoSdI8xAAiNE5O2/j8Hc6z0s1S9xg5u2vIL/9cH
        kwRDPptf1jLxZU+EZ6H/gETsU
X-Received: by 2002:a05:600c:2284:b0:3d0:837c:8561 with SMTP id 4-20020a05600c228400b003d0837c8561mr13530507wmf.168.1670316242129;
        Tue, 06 Dec 2022 00:44:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7meK9L/oB9w73FT8xJQxdaEnVKJSpNaU6D+8hFkbPQKgSwqvBvVroKxqIGf/5P8g0lh/Nvag==
X-Received: by 2002:a05:600c:2284:b0:3d0:837c:8561 with SMTP id 4-20020a05600c228400b003d0837c8561mr13530479wmf.168.1670316241747;
        Tue, 06 Dec 2022 00:44:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4f00:41f1:185d:4f9f:d1c2? (p200300cbc7054f0041f1185d4f9fd1c2.dip0.t-ipconnect.de. [2003:cb:c705:4f00:41f1:185d:4f9f:d1c2])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c2cb000b003c6bbe910fdsm30281604wmc.9.2022.12.06.00.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:44:01 -0800 (PST)
Message-ID: <3c7fd5da-b3f8-5562-45a9-f83d7dbcdd7d@redhat.com>
Date:   Tue, 6 Dec 2022 09:43:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
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
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 12/17] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
In-Reply-To: <90dd6a93-4500-e0de-2bf0-bf522c311b0c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
> 
> Hi David, sorry for the late respond and a possible inconsequential question. :)

Better late than never! Thanks for the review, independently at which 
time it happens :)

> 
> <snip>
> 
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 7a71ed679853..5add8bbd47cd 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -4772,7 +4772,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>>   				    is_hugetlb_entry_hwpoisoned(entry))) {
>>   			swp_entry_t swp_entry = pte_to_swp_entry(entry);
>>   
>> -			if (is_writable_migration_entry(swp_entry) && cow) {
>> +			if (!is_readable_migration_entry(swp_entry) && cow) {
>>   				/*
>>   				 * COW mappings require pages in both
>>   				 * parent and child to be set to read.
>> @@ -5172,6 +5172,8 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>>   		set_huge_ptep_writable(vma, haddr, ptep);
>>   		return 0;
>>   	}
>> +	VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page),
>> +		       old_page);
>>   
>>   	/*
>>   	 * If the process that created a MAP_PRIVATE mapping is about to
>> @@ -6169,12 +6171,17 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>>   		}
>>   		if (unlikely(is_hugetlb_entry_migration(pte))) {
>>   			swp_entry_t entry = pte_to_swp_entry(pte);
>> +			struct page *page = pfn_swap_entry_to_page(entry);
>>   
>> -			if (is_writable_migration_entry(entry)) {
>> +			if (!is_readable_migration_entry(entry)) {
> 
> In hugetlb_change_protection(), is_writable_migration_entry() is changed to !is_readable_migration_entry(),
> but
> 
>>   				pte_t newpte;
>>   
>> -				entry = make_readable_migration_entry(
>> -							swp_offset(entry));
>> +				if (PageAnon(page))
>> +					entry = make_readable_exclusive_migration_entry(
>> +								swp_offset(entry));
>> +				else
>> +					entry = make_readable_migration_entry(
>> +								swp_offset(entry));
>>   				newpte = swp_entry_to_pte(entry);
>>   				set_huge_swap_pte_at(mm, address, ptep,
>>   						     newpte, huge_page_size(h));
> 
> <snip>
> 
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index b69ce7a7b2b7..56060acdabd3 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -152,6 +152,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>>   			pages++;
>>   		} else if (is_swap_pte(oldpte)) {
>>   			swp_entry_t entry = pte_to_swp_entry(oldpte);
>> +			struct page *page = pfn_swap_entry_to_page(entry);
>>   			pte_t newpte;
>>   
>>   			if (is_writable_migration_entry(entry)) {
> 
> In change_pte_range(), is_writable_migration_entry() is not changed to !is_readable_migration_entry().

Yes, and also in change_huge_pmd(), is_writable_migration_entry() stays 
unchanged.

> Is this done intentionally? Could you tell me why there's such a difference? I'm confused. It's very
> kind of you if you can answer my puzzle.

For change protection, the only relevant part is to convert writable -> 
readable or writable -> readable_exclusive.

If an entry is already readable or readable_exclusive, there is nothing 
to do. The only issues would be when turning a readable one into a 
readable_exclusive one or a readable_exclusive one into a readable one.


In hugetlb_change_protection(), the "!is_readable_migration_entry" could 
in fact be turned into a "is_writable_migration_entry()". Right now, it 
would convert writable -> readable or writable -> readable_exclusive AND 
readable -> readable AND readable_exclusive -> readable_exclusive, which 
isn't necessary but also shouldn't hurt either.


So yeah, it's not consistent but shouldn't be problematic. Do you see an 
issue with that?

It would be great to extend the "selftest/vm cow" test to also cover 
migration entries, however, that requires slightly more work and "luck" 
to fork() while migration is happening.

Thanks!

-- 
Thanks,

David / dhildenb

