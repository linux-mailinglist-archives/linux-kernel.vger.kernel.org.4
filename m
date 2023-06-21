Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D1F737D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjFUIg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUIgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:36:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BBE186
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:36:20 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QmGzX2mwBzTlQS;
        Wed, 21 Jun 2023 16:35:36 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 21 Jun 2023 16:36:17 +0800
Message-ID: <c1992fd5-5318-990c-1b63-9ab88243546a@huawei.com>
Date:   Wed, 21 Jun 2023 16:36:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH -next v2 1/2] mm: compaction: convert to use a folio in
 isolate_migratepages_block()
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <jgowans@amazon.com>, <yuzhao@google.com>
References: <20230619110718.65679-1-wangkefeng.wang@huawei.com>
 <ccab6877-7b48-e5c2-5264-67b8148849da@linux.alibaba.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ccab6877-7b48-e5c2-5264-67b8148849da@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/21 14:20, Baolin Wang wrote:
> Hi
> 
> On 6/19/2023 7:07 PM, Kefeng Wang wrote:
>> Directly use a folio instead of page_folio() when page successfully
>> isolated (hugepage and movable page) and after folio_get_nontail_page(),
>> which removes several calls to compound_head().
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>> v2:
>> - update comments and use node_stat_mod_folio, per Matthew Wilcox
>> - add missed PageLRU conversion and rebase on next-20230619
>>
>>   mm/compaction.c | 84 ++++++++++++++++++++++++++-----------------------
>>   1 file changed, 44 insertions(+), 40 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 6149a2d324be..0334eefe4bfa 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -795,6 +795,7 @@ isolate_migratepages_block(struct compact_control 
>> *cc, unsigned long low_pfn,
>>       struct lruvec *lruvec;
>>       unsigned long flags = 0;
>>       struct lruvec *locked = NULL;
>> +    struct folio *folio = NULL;
>>       struct page *page = NULL, *valid_page = NULL;
>>       struct address_space *mapping;
>>       unsigned long start_pfn = low_pfn;
>> @@ -891,7 +892,7 @@ isolate_migratepages_block(struct compact_control 
>> *cc, unsigned long low_pfn,
>>           if (!valid_page && pageblock_aligned(low_pfn)) {
>>               if (!isolation_suitable(cc, page)) {
>>                   low_pfn = end_pfn;
>> -                page = NULL;
>> +                folio = NULL;
>>                   goto isolate_abort;
>>               }
>>               valid_page = page;
>> @@ -923,7 +924,8 @@ isolate_migratepages_block(struct compact_control 
>> *cc, unsigned long low_pfn,
>>                    * Hugepage was successfully isolated and placed
>>                    * on the cc->migratepages list.
>>                    */
>> -                low_pfn += compound_nr(page) - 1;
>> +                folio = page_folio(page);
>> +                low_pfn += folio_nr_pages(folio) - 1;
>>                   goto isolate_success_no_list;
>>               }
>> @@ -991,8 +993,10 @@ isolate_migratepages_block(struct compact_control 
>> *cc, unsigned long low_pfn,
>>                       locked = NULL;
>>                   }
>> -                if (isolate_movable_page(page, mode))
>> +                if (isolate_movable_page(page, mode)) {
>> +                    folio = page_folio(page);
>>                       goto isolate_success;
>> +                }
>>               }
>>               goto isolate_fail;
>> @@ -1003,7 +1007,8 @@ isolate_migratepages_block(struct 
>> compact_control *cc, unsigned long low_pfn,
>>            * sure the page is not being freed elsewhere -- the
>>            * page release code relies on it.
>>            */
>> -        if (unlikely(!get_page_unless_zero(page)))
>> +        folio = folio_get_nontail_page(page);
> 
> I'm just curious, how can you make sure the 'page' is not a tail page? 
> Since the validation is lockless.

folio_get_nontail_page is added by commit "3c1ea2c729ef (mm: add
folio_get_nontail_page())", see more comments [1]

[1] https://lore.kernel.org/lkml/Y86sRiKAAOz2myNe@casper.infradead.org/

> 
