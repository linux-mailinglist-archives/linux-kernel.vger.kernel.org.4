Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F61C70EBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbjEXDRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239323AbjEXDQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:16:37 -0400
Received: from out-39.mta0.migadu.com (out-39.mta0.migadu.com [IPv6:2001:41d0:1004:224b::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C269410CA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:15:02 -0700 (PDT)
Message-ID: <03e44919-fa89-5719-466e-90e7738633aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684898070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zptm10s4FWGNuDqotiyHNqzSBWdZWYYk5Du9kKCZq8I=;
        b=kOtI8EGAFZbUN6zzUkFOdQ7CpFoauCOESyTYomdMRtcOTlEUhcsE42MNvndJvZOd3gUMQo
        ejuQdwiPfEqilZ3otUWcc5/SBH9AysOULQNtSrZv6mav4fMXXIROLmhlI87cA/bRHAEHd1
        SlYbN19jkfBj7okOi721QZIhvExMeXU=
Date:   Wed, 24 May 2023 11:14:17 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 05/31] mm/filemap: allow pte_offset_map_lock() to fail
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
 <3e6d4f8-9f4d-fa7e-304e-1494dddd45b@google.com>
 <8f6057b5-362b-a0f6-2f2f-579debe48fce@linux.dev>
 <fb9a9d57-dbd7-6a6e-d1cb-8dcd64c829a6@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <fb9a9d57-dbd7-6a6e-d1cb-8dcd64c829a6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/24 10:35, Hugh Dickins wrote:
> On Mon, 22 May 2023, Qi Zheng wrote:
>> On 2023/5/22 12:54, Hugh Dickins wrote:
>>> filemap_map_pages() allow pte_offset_map_lock() to fail; and remove the
>>> pmd_devmap_trans_unstable() check from filemap_map_pmd(), which can safely
>>> return to filemap_map_pages() and let pte_offset_map_lock() discover that.
>>>
>>> Signed-off-by: Hugh Dickins <hughd@google.com>
>>> ---
>>>    mm/filemap.c | 12 +++++-------
>>>    1 file changed, 5 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>> index 28b42ee848a4..9e129ad43e0d 100644
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -3408,13 +3408,6 @@ static bool filemap_map_pmd(struct vm_fault *vmf,
>>> struct folio *folio,
>>>     if (pmd_none(*vmf->pmd))
>>>      pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
>>>    -	/* See comment in handle_pte_fault() */
>>> -	if (pmd_devmap_trans_unstable(vmf->pmd)) {
>>> -		folio_unlock(folio);
>>> -		folio_put(folio);
>>> -		return true;
>>> -	}
>>> -
>>>    	return false;
>>>    }
>>>    
>>> @@ -3501,6 +3494,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>>>    
>>>     addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>>>     vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
>>> +	if (!vmf->pte) {
>>> +		folio_unlock(folio);
>>> +		folio_put(folio);
>>
>> Missing:
>> 		ret = VM_FAULT_NOPAGE;
>> ?
> 
> No, not missed.  Here ret is 0, which leads do_read_fault() to try
> __do_fault() afterwards.  Whereas VM_FAULT_NOPAGE would send it back
> to userspace to retry the whole fault.  Either will work, but I think
> the intention of VM_FAULT_NOPAGE here in filemap_map_pages() is to say
> "the page you want is now inserted", which is probably not the case.

Got it. Thanks for the explanation.

> 
> Hugh

-- 
Thanks,
Qi
