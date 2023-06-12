Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116A972BBE7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjFLJS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjFLJRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:17:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CC81420E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:10:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E60EE1FB;
        Mon, 12 Jun 2023 02:11:41 -0700 (PDT)
Received: from [192.168.68.121] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDF8E3F663;
        Mon, 12 Jun 2023 02:10:51 -0700 (PDT)
Message-ID: <65a42ee0-170c-ec7c-519b-e66cdd901a52@arm.com>
Date:   Mon, 12 Jun 2023 10:10:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 28/32] mm/memory: allow pte_offset_map[_lock]() to fail
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <bb548d50-e99a-f29e-eab1-a43bef2a1287@google.com>
 <20230609130632.ec6ffe72fc5f7952af4a3e54@linux-foundation.org>
 <11a9744a-e7f-33d0-474-c2f2eb7e079@google.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <11a9744a-e7f-33d0-474-c2f2eb7e079@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 21:11, Hugh Dickins wrote:
> On Fri, 9 Jun 2023, Andrew Morton wrote:
>> On Thu, 8 Jun 2023 18:43:38 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
>>
>>> copy_pte_range(): use pte_offset_map_nolock(), and allow for it to fail;
>>> but with a comment on some further assumptions that are being made there.
>>>
>>> zap_pte_range() and zap_pmd_range(): adjust their interaction so that
>>> a pte_offset_map_lock() failure in zap_pte_range() leads to a retry in
>>> zap_pmd_range(); remove call to pmd_none_or_trans_huge_or_clear_bad().
>>>
>>> Allow pte_offset_map_lock() to fail in many functions.  Update comment
>>> on calling pte_alloc() in do_anonymous_page().  Remove redundant calls
>>> to pmd_trans_unstable(), pmd_devmap_trans_unstable(), pmd_none() and
>>> pmd_bad(); but leave pmd_none_or_clear_bad() calls in free_pmd_range()
>>> and copy_pmd_range(), those do simplify the next level down.
>>>
>>> ...
>>>
>>> @@ -3728,11 +3737,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>  			vmf->page = pfn_swap_entry_to_page(entry);
>>>  			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>>  					vmf->address, &vmf->ptl);
>>> -			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
>>> -				spin_unlock(vmf->ptl);
>>> -				goto out;
>>> -			}
>>> -
>>> +			if (unlikely(!vmf->pte ||
>>> +				     !pte_same(*vmf->pte, vmf->orig_pte)))
>>> +				goto unlock;
>>>  			/*
>>>  			 * Get a page reference while we know the page can't be
>>>  			 * freed.
>>
>> This hunk falls afoul of
>> https://lkml.kernel.org/r/20230602092949.545577-5-ryan.roberts@arm.com.
>>
>> I did this:
>>
>> @@ -3729,7 +3738,8 @@ vm_fault_t do_swap_page(struct vm_fault
>>  			vmf->page = pfn_swap_entry_to_page(entry);
>>  			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>  					vmf->address, &vmf->ptl);
>> -			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
>> +			if (unlikely(!vmf->pte ||
>> +				     !pte_same(*vmf->pte, vmf->orig_pte)))
>>  				goto unlock;
>>  
>>  			/*
> 
> Yes, that's exactly right: thanks, Andrew.

FWIW, I agree.

Thanks,
Ryan


> 
> Hugh

