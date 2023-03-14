Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2786B9207
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCNLrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjCNLrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:47:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ED29AA32
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:47:23 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PbWs54lWBz17KsY;
        Tue, 14 Mar 2023 19:44:25 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 19:47:20 +0800
Message-ID: <3b4337fa-77a1-101b-ba93-b7781ecdf925@huawei.com>
Date:   Tue, 14 Mar 2023 19:47:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/3] userfaultfd: convert __mcopy_atomic_hugetlb() to use
 a folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <vishal.moola@gmail.com>, <sidhartha.kumar@oracle.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20230314033734.481904-1-zhangpeng362@huawei.com>
 <20230314033734.481904-3-zhangpeng362@huawei.com>
 <ZBAw21yANYPFKMi4@casper.infradead.org>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <ZBAw21yANYPFKMi4@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/14 16:31, Matthew Wilcox wrote:

> On Tue, Mar 14, 2023 at 03:37:33AM +0000, Peng Zhang wrote:
>> +++ b/include/linux/mm.h
>> @@ -3546,9 +3546,8 @@ extern void copy_user_huge_page(struct page *dst, struct page *src,
>>   				unsigned long addr_hint,
>>   				struct vm_area_struct *vma,
>>   				unsigned int pages_per_huge_page);
>> -extern long copy_huge_page_from_user(struct page *dst_page,
>> +extern long copy_large_folio_from_user(struct folio *dst_folio,
> You can drop the 'extern'.

Got it.

>> +++ b/mm/memory.c
>> @@ -5769,26 +5769,28 @@ void copy_user_huge_page(struct page *dst, struct page *src,
>>   	process_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &arg);
>>   }
>>   
>> -long copy_huge_page_from_user(struct page *dst_page,
>> +long copy_large_folio_from_user(struct folio *dst_folio,
>>   				const void __user *usr_src,
>> -				unsigned int pages_per_huge_page,
>>   				bool allow_pagefault)
>>   {
>>   	void *page_kaddr;
>>   	unsigned long i, rc = 0;
>> -	unsigned long ret_val = pages_per_huge_page * PAGE_SIZE;
>> +	unsigned int nr_pages = folio_nr_pages(dst_folio);
>> +	unsigned long ret_val = nr_pages * PAGE_SIZE;
>>   	struct page *subpage;
>> +	struct folio *inner_folio;
> What is an 'inner folio'?
>
>> -	for (i = 0; i < pages_per_huge_page; i++) {
>> -		subpage = nth_page(dst_page, i);
>> +	for (i = 0; i < nr_pages; i++) {
>> +		subpage = folio_page(dst_folio, i);
>> +		inner_folio = page_folio(subpage);
>>   		if (allow_pagefault)
>> -			page_kaddr = kmap(subpage);
>> +			page_kaddr = kmap_local_folio(inner_folio, 0);
> This doesn't do what you think it does.  Did you test this?
>
>>   		else
>>   			page_kaddr = kmap_atomic(subpage);
> Pretty sure all this should be converted to kmap_local and the atomic
> bits should go away.
>
>>   		rc = copy_from_user(page_kaddr,
>>   				usr_src + i * PAGE_SIZE, PAGE_SIZE);
>>   		if (allow_pagefault)
>> -			kunmap(subpage);
>> +			kunmap_local(page_kaddr);
>>   		else
>>   			kunmap_atomic(page_kaddr);
>>   
>> @@ -5796,7 +5798,7 @@ long copy_huge_page_from_user(struct page *dst_page,
>>   		if (rc)
>>   			break;
>>   
>> -		flush_dcache_page(subpage);
>> +		flush_dcache_folio(inner_folio);
> The flush should probably be pulled outside the loop.
>
>> +			err = copy_large_folio_from_user(folio,
>> +						(const void __user *) src_addr, true);
> I wonder if this shouldn't be 'copy_folio_from_user()'.  after all,
> it'll work for any size folio, right?

Thanks for your review.

I'll rename copy_large_folio_from_user() to copy_folio_from_user().
I'll delete the inner_folio. kmap() and kmap_atomic() will be
converted to the following code.

	page_kaddr = kmap_local_page(subpage);
	if (!allow_pagefault)
		pagefault_disable();
	rc = copy_from_user(page_kaddr,
			usr_src + i * PAGE_SIZE, PAGE_SIZE);
	if (!allow_pagefault)
		pagefault_enable();
	kunmap_local(page_kaddr);

flush_dcache_folio() will be placed outside the loop.

I'll fix all this in a v2 of this patch series.


Thanks,
Peng.

