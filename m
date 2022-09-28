Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343485ED90C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiI1Jcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiI1JcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:32:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31316B8E5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:32:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mcrkh712Jz1P6t8;
        Wed, 28 Sep 2022 17:27:56 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 17:32:12 +0800
Subject: Re: [PATCH v3 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
 memory section with hwpoisoned hugepage
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>
References: <20220921091359.25889-1-naoya.horiguchi@linux.dev>
 <20220921091359.25889-2-naoya.horiguchi@linux.dev>
 <91a4759f-88e4-f9ac-aff5-41d2db5ecfdd@huawei.com>
 <20220928012647.GA597297@u2004.lan>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e75128b5-ea83-48b4-8371-d146ed391f86@huawei.com>
Date:   Wed, 28 Sep 2022 17:32:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220928012647.GA597297@u2004.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/28 9:26, Naoya Horiguchi wrote:
> On Sat, Sep 24, 2022 at 07:43:16PM +0800, Miaohe Lin wrote:
>> On 2022/9/21 17:13, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> HWPoisoned page is not supposed to be accessed once marked, but currently
>>> such accesses can happen during memory hotremove because do_migrate_range()
>>> can be called before dissolve_free_huge_pages() is called.
>>>
>>> Clear HPageMigratable for hwpoisoned hugepages to prevent them from being
>>> migrated.  This should be done in hugetlb_lock to avoid race against
>>> isolate_hugetlb().
>>>
>>> get_hwpoison_huge_page() needs to have a flag to show it's called from
>>> unpoison to take refcount of hwpoisoned hugepages, so add it.
>>>
>>> Reported-by: Miaohe Lin <linmiaohe@huawei.com>
>>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>
>> Thanks for your work, Naoya. Maybe something to improve below.
>>
>>> ---
>>> ChangeLog v2 -> v3
>>> - move to the approach of clearing HPageMigratable instead of shifting
>>>   dissolve_free_huge_pages.
>>> ---
>>>  include/linux/hugetlb.h |  4 ++--
>>>  mm/hugetlb.c            |  4 ++--
>>>  mm/memory-failure.c     | 12 ++++++++++--
>>>  3 files changed, 14 insertions(+), 6 deletions(-)
>>>
>>
>> <snip>
>>
>>> @@ -7267,7 +7267,7 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
>>>  		*hugetlb = true;
>>>  		if (HPageFreed(page))
>>>  			ret = 0;
>>> -		else if (HPageMigratable(page))
>>> +		else if (HPageMigratable(page) || unpoison)
>>
>> Is unpoison_memory() expected to restore the HPageMigratable flag as well ?
> 
> No it isn't. When unpoison_memory() unpoisons a hugepage, the hugepage
> is sent back to free hugepage pool, so I think that there's no need to
> restore HPageMigratable for it.

I tend to agree with you.

> 
>>
>>>  			ret = get_page_unless_zero(page);
>>>  		else
>>>  			ret = -EBUSY;
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index 145bb561ddb3..5942e1c0407e 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -1244,7 +1244,7 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
>>>  	int ret = 0;
>>>  	bool hugetlb = false;
>>>  
>>> -	ret = get_hwpoison_huge_page(head, &hugetlb);
>>> +	ret = get_hwpoison_huge_page(head, &hugetlb, false);
>>>  	if (hugetlb)
>>>  		return ret;
>>>  
>>> @@ -1334,7 +1334,7 @@ static int __get_unpoison_page(struct page *page)
>>>  	int ret = 0;
>>>  	bool hugetlb = false;
>>>  
>>> -	ret = get_hwpoison_huge_page(head, &hugetlb);
>>> +	ret = get_hwpoison_huge_page(head, &hugetlb, true);
>>>  	if (hugetlb)
>>>  		return ret;
>>>  
>>> @@ -1815,6 +1815,13 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>>>  		goto out;
>>>  	}
>>>  
>>> +	/*
>>> +	 * Clearing HPageMigratable for hwpoisoned hugepages to prevent them
>>> +	 * from being migrated by memory hotremove.
>>> +	 */
>>> +	if (count_increased)
>>> +		ClearHPageMigratable(head);
>>
>> I believe this can prevent hwpoisoned hugepages from being migrated though there still be some windows.
> 
> I'm not sure of "still racy" part, so could you elaborate it?
> Main scenario this patch tries to handle is like below:
> 
>   CPU 0                                   CPU 1                                   
>   get_huge_page_for_hwpoison                                                      
>     // take hugetlb_lock                                                          
>     __get_huge_page_for_hwpoison                                                  
>                                           scan_movable_pages                      
>                                             if HPageMigratable                    
>                                               goto found                          
>                                           do_migrate_range                        
>       if HPageMigratable                                                          
>         get_page_unless_zero                                                      
>       hugetlb_set_page_hwpoison                                                   
>       ClearHPageMigratable                                                        
>     // release hugetlb_lock                                                       
>                                             isolate_hugetlb                       
>                                               // take hugetlb_lock                
>                                               if !HPageMigratable                 
>                                                 // fails to isolate the hwpoisoned hugetlb.
> 
> Maybe the following could be possible.
> 
>   CPU 0                                   CPU 1
>                                           scan_movable_pages
>                                             if HPageMigratable
>                                               goto found
>                                           do_migrate_range
>                                             isolate_hugetlb
>                                               // the hugetlb is isolated,
>                                               // but it's not hwpoisoned yet.
>   get_huge_page_for_hwpoison
>     // take hugetlb_lock
>     __get_huge_page_for_hwpoison
>       if HPageMigratable
>         get_page_unless_zero
>       hugetlb_set_page_hwpoison
>       ClearHPageMigratable
>     // release hugetlb_lock

Yes, this is what I mean. For already isolated hugetlb pages, HPageMigratable flags can't help much.

> 
> In this case, the hugepage is maybe broken but not marked as hwpoison yet,
> so it's not detectable.
> 
>>
>>> +
>>>  	return ret;
>>>  out:
>>>  	if (count_increased)
>>> @@ -1862,6 +1869,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>>>  
>>>  	if (hwpoison_filter(p)) {
>>>  		hugetlb_clear_page_hwpoison(head);
>>> +		SetHPageMigratable(head);
>>
>> Would we set HPageMigratable flag for free hugetlb pages here? IIUC, they're not expected to have this flag set.
> 
> Thank you, you're right.  This should be done in "if (res == 1)" block.

If res == 1, it means hugetlb page refcnt is incremented. But it seems this does not necessarily mean
HPageMigratable is cleared by __get_huge_page_for_hwpoison() if the hugetlb page is already isolated.
If so, we might set HPageMigratable flag back for already isolated hugetlb pages?

> (hwpoison_filter often bothers me ...)

Agree, hwpoison_filter() makes things more complicated. ;)

Thanks,
Miaohe Lin

> 
>>
>> Thanks,
>> Miaohe Lin
> 
> Thank you very much!
> - Naoya Horiguchi
> .
> 

