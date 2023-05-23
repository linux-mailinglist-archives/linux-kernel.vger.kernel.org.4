Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A9470D396
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbjEWGGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjEWGGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:06:47 -0400
Received: from out-22.mta0.migadu.com (out-22.mta0.migadu.com [IPv6:2001:41d0:1004:224b::16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF400184
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:06:42 -0700 (PDT)
Message-ID: <1d5d7f30-1a6a-5ea1-165f-65d34e7658e9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684821999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8s83yWjKEBRdyAGBchf6MMb6Nq3aGroiKLfQejbmR0=;
        b=xk0dWmlwCXKICTVc9DmQjv5ceHjo4q8uUonePnR7W+LLabpqyvgUOf8NEcyXgcfHg9Kcfw
        dQBGHiZyuP11qt/lT48Jwda8CZ9CYf+h9/W/GltBiXW1Ri93L7lJy3NT/8A6i4xxMZ384n
        a8C/+lJ+i8jo8A4W4VtoBFlEJ7nfA3Q=
Date:   Tue, 23 May 2023 14:06:26 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 13/31] mm/hmm: retry if pte_offset_map() fails
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
 <2edc4657-b6ff-3d6e-2342-6b60bfccc5b@google.com>
 <0e3c5937-2f04-25d9-98eb-01e4c2b04150@linux.dev> <87353n9354.fsf@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <87353n9354.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/23 10:39, Alistair Popple wrote:
> 
> Qi Zheng <qi.zheng@linux.dev> writes:
> 
>> On 2023/5/22 13:05, Hugh Dickins wrote:
>>> hmm_vma_walk_pmd() is called through mm_walk, but already has a goto
>>> again loop of its own, so take part in that if pte_offset_map() fails.
>>> Signed-off-by: Hugh Dickins <hughd@google.com>
>>> ---
>>>    mm/hmm.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>> diff --git a/mm/hmm.c b/mm/hmm.c
>>> index e23043345615..b1a9159d7c92 100644
>>> --- a/mm/hmm.c
>>> +++ b/mm/hmm.c
>>> @@ -381,6 +381,8 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>>>    	}
>>>      	ptep = pte_offset_map(pmdp, addr);
>>> +	if (!ptep)
>>> +		goto again;
>>>    	for (; addr < end; addr += PAGE_SIZE, ptep++, hmm_pfns++) {
>>>    		int r;
>>>    
>>
>> I haven't read the entire patch set yet, but taking a note here.
>> The hmm_vma_handle_pte() will unmap pte and then call
>> migration_entry_wait() to remap pte, so this may fail, we need to
>> handle this case like below:
> 
> I don't see a problem here. Sure, hmm_vma_handle_pte() might return
> -EBUSY but that will get returned up to hmm_range_fault() which will
> retry the whole thing again and presumably fail when looking at the PMD.

Yeah. There is no problem with this and the modification to
migration_entry_wait() can be simplified. My previous thought was that
we can finish the retry logic in hmm_vma_walk_pmd() without handing it
over to the caller. :)

> 
>> diff --git a/mm/hmm.c b/mm/hmm.c
>> index 6a151c09de5e..eb726ff0981c 100644
>> --- a/mm/hmm.c
>> +++ b/mm/hmm.c
>> @@ -276,7 +276,8 @@ static int hmm_vma_handle_pte(struct mm_walk
>> *walk, unsigned long addr,
>>                  if (is_migration_entry(entry)) {
>>                          pte_unmap(ptep);
>>                          hmm_vma_walk->last = addr;
>> -                       migration_entry_wait(walk->mm, pmdp, addr);
>> +                       if (!migration_entry_wait(walk->mm, pmdp, addr))
>> +                               return -EAGAIN;
>>                          return -EBUSY;
>>                  }
>>
>> @@ -386,6 +387,8 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>>
>>                  r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep,
>>                  hmm_pfns);
>>                  if (r) {
>> +                       if (r == -EAGAIN)
>> +                               goto again;
>>                          /* hmm_vma_handle_pte() did pte_unmap() */
>>                          return r;
>>                  }
>>
>> Of course, the migration_entry_wait() also needs to be modified.
> 

-- 
Thanks,
Qi
