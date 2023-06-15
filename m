Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9CA731398
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245501AbjFOJWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243895AbjFOJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:22:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B68211C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:22:05 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QhcB744kVz18MPq;
        Thu, 15 Jun 2023 17:17:03 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 17:22:00 +0800
Message-ID: <f51f8028-ac7b-2c7d-0526-24c227f80c5c@huawei.com>
Date:   Thu, 15 Jun 2023 17:22:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] memblock: use the helper macro for_each_zone
To:     Mike Rapoport <rppt@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>
References: <20230612125102.1674568-1-zhangpeng362@huawei.com>
 <20230614114627.GW52412@kernel.org>
Content-Language: en-US
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20230614114627.GW52412@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/14 19:46, Mike Rapoport wrote:

> On Mon, Jun 12, 2023 at 08:51:02PM +0800, Peng Zhang wrote:
>> From: ZhangPeng <zhangpeng362@huawei.com>
>>
>> Let's use the helper macro for_each_zone to iterate over all memory
>> zones and reset the node managed pages. After that, we can remove the
>> unused function reset_node_managed_pages.
> Are you sure it's safe to use for_each_zone() in all users of
> reset_all_zones_managed_pages()?
>   

Thanks for your review.

Using for_each_zone() is indeed unsafe in some users of
reset_all_zones_managed_pages(). Please ignore.

Thanks,
Peng

>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>> ---
>>   mm/memblock.c | 14 +++-----------
>>   1 file changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index da4264528e1e..af552604c3fb 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -2122,23 +2122,15 @@ static unsigned long __init free_low_memory_core_early(void)
>>   
>>   static int reset_managed_pages_done __initdata;
>>   
>> -static void __init reset_node_managed_pages(pg_data_t *pgdat)
>> -{
>> -	struct zone *z;
>> -
>> -	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
>> -		atomic_long_set(&z->managed_pages, 0);
>> -}
>> -
>>   void __init reset_all_zones_managed_pages(void)
>>   {
>> -	struct pglist_data *pgdat;
>> +	struct zone *z;
>>   
>>   	if (reset_managed_pages_done)
>>   		return;
>>   
>> -	for_each_online_pgdat(pgdat)
>> -		reset_node_managed_pages(pgdat);
>> +	for_each_zone(z)
>> +		atomic_long_set(&z->managed_pages, 0);
>>   
>>   	reset_managed_pages_done = 1;
>>   }
>> -- 
>> 2.25.1
>>
