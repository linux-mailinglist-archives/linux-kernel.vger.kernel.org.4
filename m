Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75A9744635
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 05:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGAD1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 23:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGAD0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 23:26:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AF144A2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 19:57:53 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QtGyl2VkBzLn1h;
        Sat,  1 Jul 2023 10:55:43 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 1 Jul 2023 10:57:50 +0800
Message-ID: <530c0778-577d-2476-24f4-612e80551d21@huawei.com>
Date:   Sat, 1 Jul 2023 10:57:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] mm: remove page_rmapping()
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <willy@infradead.org>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20230630121310.165700-1-zhangpeng362@huawei.com>
 <20230630121310.165700-2-zhangpeng362@huawei.com>
 <b235b65b-3b1d-9d97-5461-b5a2ed4dfccc@oracle.com>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <b235b65b-3b1d-9d97-5461-b5a2ed4dfccc@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/1 0:03, Sidhartha Kumar wrote:

> On 6/30/23 5:13 AM, Peng Zhang wrote:
>> From: ZhangPeng <zhangpeng362@huawei.com>
>>
>> After converting the last user to folio_raw_mapping(), we can safely
>> remove the function.
>>
>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>> ---
>>   include/linux/mm.h | 1 -
>>   mm/memory.c        | 2 +-
>>   mm/util.c          | 6 ------
>>   3 files changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 9ecb8b9c07f6..8c7eba7370b2 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2129,7 +2129,6 @@ static inline void *folio_address(const struct 
>> folio *folio)
>>       return page_address(&folio->page);
>>   }
>>   -extern void *page_rmapping(struct page *page);
>>   extern pgoff_t __page_file_index(struct page *page);
>>     /*
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 21fab2727209..6921df44a99f 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -2979,7 +2979,7 @@ static vm_fault_t 
>> fault_dirty_shared_page(struct vm_fault *vmf)
>>        * pinned by vma->vm_file's reference.  We rely on unlock_page()'s
>>        * release semantics to prevent the compiler from undoing this 
>> copying.
>>        */
>
>
>     struct page *page = vmf->page;
>
>     ...
>
>     dirtied = set_page_dirty(page);
>     VM_BUG_ON_PAGE(PageAnon(page), page);
>
> Can this earlier part of the function be converted to folios so a 
> folio can be passed directly in folio_raw_mapping()?

Thanks for your feedback.

I convert the last user to use a folio in patch 2. I'll reverse the order of the two patches.

Best Regards,
Peng

>> -    mapping = page_rmapping(page);
>> +    mapping = folio_raw_mapping(page_folio(page));
>>       unlock_page(page);
>>         if (!page_mkwrite)
>> diff --git a/mm/util.c b/mm/util.c
>> index dd12b9531ac4..5e9305189c3f 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -734,12 +734,6 @@ void *vcalloc(size_t n, size_t size)
>>   }
>>   EXPORT_SYMBOL(vcalloc);
>>   -/* Neutral page->mapping pointer to address_space or anon_vma or 
>> other */
>> -void *page_rmapping(struct page *page)
>> -{
>> -    return folio_raw_mapping(page_folio(page));
>> -}
>> -
>>   struct anon_vma *folio_anon_vma(struct folio *folio)
>>   {
>>       unsigned long mapping = (unsigned long)folio->mapping;
>
