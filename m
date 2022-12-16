Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FC864E83D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLPImt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiLPImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:42:40 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA2B37216
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:42:38 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NYMyj3tt2zmWYH;
        Fri, 16 Dec 2022 16:41:33 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 16:42:34 +0800
Message-ID: <6003e02b-6fc9-2f50-7198-2ef8b541ecad@huawei.com>
Date:   Fri, 16 Dec 2022 16:42:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next resend v3] mm: hwposion: support recovery from
 ksm_might_need_to_copy()
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>
References: <20221213030557.143432-1-wangkefeng.wang@huawei.com>
 <20221213120523.141588-1-wangkefeng.wang@huawei.com>
 <20221216014729.GA2116060@hori.linux.bs1.fc.nec.co.jp>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221216014729.GA2116060@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/16 9:47, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Dec 13, 2022 at 08:05:23PM +0800, Kefeng Wang wrote:
>> When the kernel copy a page from ksm_might_need_to_copy(), but runs
>> into an uncorrectable error, it will crash since poisoned page is
>> consumed by kernel, this is similar to Copy-on-write poison recovery,
> 
> Maybe you mean "this is similar to the issue recently fixed by
> Copy-on-write poison recovery."?  And if this sentence ends here,
> please put "." instead of ",".

That what I mean, will update the changelog.
> 
>> When an error is detected during the page copy, return VM_FAULT_HWPOISON
>> in do_swap_page(), and install a hwpoison entry in unuse_pte() when
>> swapoff, which help us to avoid system crash.  Note, memory failure on
>> a KSM page will be skipped, but still call memory_failure_queue() to
>> be consistent with general memory failure process.
> 
> Thank you for the work.  I have a few comment below ...
> 
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>> v3 resend:
>> - enhance unuse_pte() if ksm_might_need_to_copy() return -EHWPOISON
>> - fix issue found by lkp
>>
>>   mm/ksm.c      |  8 ++++++--
>>   mm/memory.c   |  3 +++
>>   mm/swapfile.c | 20 ++++++++++++++------
>>   3 files changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index dd02780c387f..83e2f74ae7da 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -2629,8 +2629,12 @@ struct page *ksm_might_need_to_copy(struct page *page,
>>   		new_page = NULL;
>>   	}
>>   	if (new_page) {
>> -		copy_user_highpage(new_page, page, address, vma);
>> -
>> +		if (copy_mc_user_highpage(new_page, page, address, vma)) {
>> +			put_page(new_page);
>> +			new_page = ERR_PTR(-EHWPOISON);
>> +			memory_failure_queue(page_to_pfn(page), 0);
>> +			return new_page;
> 
> Simply return ERR_PTR(-EHWPOISON)?

OK.

> 
>> +		}
>>   		SetPageDirty(new_page);
>>   		__SetPageUptodate(new_page);
>>   		__SetPageLocked(new_page);
>> diff --git a/mm/memory.c b/mm/memory.c
>> index aad226daf41b..5b2c137dfb2a 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3840,6 +3840,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>   		if (unlikely(!page)) {
>>   			ret = VM_FAULT_OOM;
>>   			goto out_page;
>> +		} else if (unlikely(PTR_ERR(page) == -EHWPOISON)) {
>> +			ret = VM_FAULT_HWPOISON;
>> +			goto out_page;
>>   		}
>>   		folio = page_folio(page);
>>   
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 908a529bca12..0efb1c2c2415 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1763,12 +1763,15 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>   	struct page *swapcache;
>>   	spinlock_t *ptl;
>>   	pte_t *pte, new_pte;
>> +	bool hwposioned = false;
>>   	int ret = 1;
>>   
>>   	swapcache = page;
>>   	page = ksm_might_need_to_copy(page, vma, addr);
>>   	if (unlikely(!page))
>>   		return -ENOMEM;
>> +	else if (unlikely(PTR_ERR(page) == -EHWPOISON))
>> +		hwposioned = true;
>>   
>>   	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
>>   	if (unlikely(!pte_same_as_swp(*pte, swp_entry_to_pte(entry)))) {
>> @@ -1776,15 +1779,19 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>   		goto out;
>>   	}
>>   
>> -	if (unlikely(!PageUptodate(page))) {
>> -		pte_t pteval;
>> +	if (hwposioned || !PageUptodate(page)) {
>> +		swp_entry_t swp_entry;
>>   
>>   		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>> -		pteval = swp_entry_to_pte(make_swapin_error_entry());
>> -		set_pte_at(vma->vm_mm, addr, pte, pteval);
>> -		swap_free(entry);
>> +		if (hwposioned) {
>> +			swp_entry = make_hwpoison_entry(swapcache);
>> +			page = swapcache;
> 
> This might work for the process accessing to the broken page, but ksm
> pages are likely to be shared by multiple processes, so it would be
> much nicer if you can convert all mapping entries for the error ksm page
> into hwpoisoned ones.  Maybe in this thorough approach,
> hwpoison_user_mappings() is updated to call try_to_unmap() for ksm pages.
> But it's not necessary to do this together with applying mcsafe-memcpy,
> because recovery action and mcsafe-memcpy can be done independently.

Yes, the memory failure won't handle KSM page (commit 01e00f880ca7 
"HWPOISON: fix oops on ksm pages"), we could support it later,

> 
> Thanks,
> Naoya Horiguchi
> 
>> +		} else {
>> +			swp_entry = make_swapin_error_entry();
>> +		}
>> +		new_pte = swp_entry_to_pte(swp_entry);
>>   		ret = 0;
>> -		goto out;
>> +		goto setpte;
>>   	}
>>   
>>   	/* See do_swap_page() */
>> @@ -1816,6 +1823,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>   		new_pte = pte_mksoft_dirty(new_pte);
>>   	if (pte_swp_uffd_wp(*pte))
>>   		new_pte = pte_mkuffd_wp(new_pte);
>> +setpte:
>>   	set_pte_at(vma->vm_mm, addr, pte, new_pte);
>>   	swap_free(entry);
>>   out:
>> -- 
>> 2.35.3
> 
>      
