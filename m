Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998BD70BE7A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjEVMiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjEVMiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:38:03 -0400
Received: from out-51.mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3520F9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:37:44 -0700 (PDT)
Message-ID: <07317766-c901-34a9-360a-e916db4b9045@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684759063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Vf55yronjbw4sVFWMpRa3/wf12y9L5bS4sB8okVwQ4=;
        b=jXaiovzBiCse3JJSew7ABrQpqiKz5q/ZNG2KpsWelvRJoTKqKtEfMjviU4AIEkWIALNHIa
        kKysD7sKdNbc9KmProLOOQcLCexRdc8wGwbuYN5BCz6J4Jzg4/JZOqmE7pZ2Nv7Capzcto
        RSdtUQKNc2JoTgSP/J8hXW/Vtmv5SXs=
Date:   Mon, 22 May 2023 20:37:31 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 17/31] mm/various: give up if pte_offset_map[_lock]()
 fails
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <c299eba-4e17-c645-1115-ccd1fd9956bd@google.com>
 <f8468e50-9f54-f22d-59a7-3a48369d2f05@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <f8468e50-9f54-f22d-59a7-3a48369d2f05@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/22 20:24, Qi Zheng wrote:
> 
> 
> On 2023/5/22 13:10, Hugh Dickins wrote:
>> Following the examples of nearby code, various functions can just give
>> up if pte_offset_map() or pte_offset_map_lock() fails.  And there's no
>> need for a preliminary pmd_trans_unstable() or other such check, since
>> such cases are now safely handled inside.
>>
>> Signed-off-by: Hugh Dickins <hughd@google.com>
>> ---
>>   mm/gup.c            | 9 ++++++---
>>   mm/ksm.c            | 7 ++++---
>>   mm/memcontrol.c     | 8 ++++----
>>   mm/memory-failure.c | 8 +++++---
>>   mm/migrate.c        | 3 +++
>>   mm/swap_state.c     | 3 +++
>>   6 files changed, 25 insertions(+), 13 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 3ecb7a40075f..308a56f0b156 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -305,6 +305,9 @@ void migration_entry_wait(struct mm_struct *mm, 
>> pmd_t *pmd,
>>       swp_entry_t entry;
>>       ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
>> +    if (!ptep)
>> +        return;
> 
> Maybe we should return false and let the caller handle the failure.
> 
>> +
>>       pte = *ptep;
>>       pte_unmap(ptep);
>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>> index b76a65ac28b3..db2ec85ef332 100644
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -734,6 +734,9 @@ static void swap_ra_info(struct vm_fault *vmf,
>>       /* Copy the PTEs because the page table may be unmapped */
>>       orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
>> +    if (!pte)
>> +        return;
> 
> Ditto?

Oh, I see that you handle it in the PATCH[22/31].

> 
>> +
>>       if (fpfn == pfn + 1) {
>>           lpfn = fpfn;
>>           rpfn = fpfn + win;
> 

-- 
Thanks,
Qi
