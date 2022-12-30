Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31B865940F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 02:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiL3Bgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 20:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiL3Bga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 20:36:30 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F3617896
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 17:36:27 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Njnr60fBkzRqNt;
        Fri, 30 Dec 2022 09:35:02 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 30 Dec 2022 09:36:25 +0800
Message-ID: <b36820e2-7cbe-87a6-91e5-bdfaade76f90@huawei.com>
Date:   Fri, 30 Dec 2022 09:36:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] mm: huge_memory: convert split_huge_pages_all() to use a
 folio
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
References: <20221229122503.149083-1-wangkefeng.wang@huawei.com>
 <20221229152822.a283198e5df331caaac88a55@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221229152822.a283198e5df331caaac88a55@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/30 7:28, Andrew Morton wrote:
> On Thu, 29 Dec 2022 20:25:03 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>> Straightforwardly convert split_huge_pages_all() to use a folio.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/huge_memory.c | 25 +++++++++++++++++--------
>>   1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 266c4b557946..c8cbe7f62eaa 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2932,6 +2932,7 @@ static void split_huge_pages_all(void)
>>   {
>>   	struct zone *zone;
>>   	struct page *page;
>> +	struct folio *folio;
>>   	unsigned long pfn, max_zone_pfn;
>>   	unsigned long total = 0, split = 0;
>>   
>> @@ -2944,24 +2945,32 @@ static void split_huge_pages_all(void)
>>   			int nr_pages;
>>   
>>   			page = pfn_to_online_page(pfn);
>> -			if (!page || !get_page_unless_zero(page))
>> +			if (!page || PageTail(page))
>> +				continue;
> 
> Why is the PageTail() test added?
This function is trying to split huge pages, it traverse all the pfn, 
the huge page already split when we met Head page, most importantly, 
get_page_unless_zero() will do nothing on Tail page too.
> 
>> +			folio = page_folio(page);
>> +			if (!folio_try_get(folio))
>>   				continue;
>>   
>> -			if (zone != page_zone(page))
>> +			if (unlikely(page_folio(page) != folio))
> 
> And this?

I think this is a double check in case of page is already changed by 
someone else, suggested by Matthew[1]

[1] 
https://lore.kernel.org/linux-mm/20221227195004.2809-1-sj@kernel.org/T/#m33047c152f6793bfebaa55cb1f4662fed73508d2
