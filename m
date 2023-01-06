Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA07065FB67
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjAFGXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjAFGXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:23:32 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0615332253
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 22:23:28 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NpCsr1H5czRr14;
        Fri,  6 Jan 2023 14:21:52 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 14:23:26 +0800
Message-ID: <d699a5dd-438e-2bae-b0ec-6820d9860a26@huawei.com>
Date:   Fri, 6 Jan 2023 14:23:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] mm: huge_memory: convert split_huge_pages_all() to use
 a folio
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
References: <20221230093020.9664-1-wangkefeng.wang@huawei.com>
 <20221230134535.240f49e0ad8bf6d82f8cc393@linux-foundation.org>
 <fcc4116a-e4cd-9542-60a6-905a4968e6ca@huawei.com>
 <20230105190658.f5d9a4bc9619ad6bec91a973@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230105190658.f5d9a4bc9619ad6bec91a973@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/6 11:06, Andrew Morton wrote:
> On Tue, 3 Jan 2023 09:58:36 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>>
>>
>> On 2022/12/31 5:45, Andrew Morton wrote:
>>> On Fri, 30 Dec 2022 17:30:20 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>
>>>> Straightforwardly convert split_huge_pages_all() to use a folio.
>>>>
>>>> ...
>>>>
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -2932,6 +2932,7 @@ static void split_huge_pages_all(void)
>>>>    {
>>>>    	struct zone *zone;
>>>>    	struct page *page;
>>>> +	struct folio *folio;
>>>>    	unsigned long pfn, max_zone_pfn;
>>>>    	unsigned long total = 0, split = 0;
>>>>    
>>>> @@ -2944,24 +2945,32 @@ static void split_huge_pages_all(void)
>>>>    			int nr_pages;
>>>>    
>>>>    			page = pfn_to_online_page(pfn);
>>>> -			if (!page || !get_page_unless_zero(page))
>>>> +			if (!page || PageTail(page))
>>>> +				continue;
>>>> +			folio = page_folio(page);
>>>> +			if (!folio_try_get(folio))
>>>>    				continue;
>>>>    
>>>> -			if (zone != page_zone(page))
>>>> +			if (unlikely(page_folio(page) != folio))
>>>> +				goto next;
>>>> +
>>>> +			if (zone != folio_zone(folio))
>>>>    				goto next;
>>>
>>> I'm still not understanding the above hunk.  Why is the
>>> "page_folio(page) != folio" check added?  Should it be commented?
>>
>> There is a comment in try_get_folio(), is it enough?
> 
> Nobody would think to look at a private function in gup.c.

Sorry，I mean that comment is to explain why adding a new recheck.

> 
> I suggest this folio_try_get() rule be documented at the
> folio_try_get() implementation site.
> 
> Most callers do perform this check, but not the ones in vmscan.c ?

Hope Matthew could give some advise, thanks

