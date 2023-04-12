Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B746DF4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjDLMQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjDLMQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:16:28 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A12B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:16:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VfwMQr5_1681301783;
Received: from 30.97.48.75(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VfwMQr5_1681301783)
          by smtp.aliyun-inc.com;
          Wed, 12 Apr 2023 20:16:24 +0800
Message-ID: <ac8bb4e9-e7f5-f9da-bca0-ac7ef6d68c23@linux.alibaba.com>
Date:   Wed, 12 Apr 2023 20:16:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm/page_alloc: consider pfn holes after pfn_valid() in
 __pageblock_pfn_to_page()
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <62e231a8f2e50c04dcadc7a0cfaa6dea5ce1ec05.1681296022.git.baolin.wang@linux.alibaba.com>
 <94bfa3cc-674e-25b0-e7e2-d74c970acef7@redhat.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <94bfa3cc-674e-25b0-e7e2-d74c970acef7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/2023 7:25 PM, David Hildenbrand wrote:
> On 12.04.23 12:45, Baolin Wang wrote:
>> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(),
>> which checks whether the given zone contains holes, and uses pfn_valid()
>> to check if the end pfn is valid. However pfn_valid() can not make sure
>> the end pfn is not a hole if the size of a pageblock is larger than the
>> size of a sub-mem_section, since the struct page getting by pfn_to_page()
>> may represent a hole or an unusable page frame, which may cause incorrect
>> zone contiguous is set.
>>
>> Though another user of pageblock_pfn_to_page() in compaction seems work
>> well now, it is better to avoid scanning or touching these offline pfns.
>> So like commit 2d070eab2e82 ("mm: consider zone which is not fully
>> populated to have holes"), we should also use pfn_to_online_page() for
>> the end pfn to make sure it is a valid pfn with usable page frame.
>> Meanwhile the pfn_valid() for end pfn can be dropped now.
>>
>> Moreover we've already used pfn_to_online_page() for start pfn to make
>> sure it is online and valid, so the pfn_valid() for the start pfn is
>> unnecessary, drop it.
> 
> pageblocks are supposed to fall into a single memory section, so in mos > cases, if the start is online, so is the end.

Yes, the granularity of memory hotplug is a mem_section.

However, suppose the pageblock order is MAX_ORDER-1, and the size of a 
sub-section is 2M, that means a pageblock will fall into 2 sub 
mem-section, and if there is a hole in the zone, that means the 2nd sub 
mem-section can be invalid without setting subsection_map bitmap.

So the start is online can make sure the end pfn of a pageblock is 
online, but a valid start pfn can not make sure the end pfn is valid in 
the bitmap of ms->usage->subsection_map.

> The exception to this rule is when we have a mixture of ZONE_DEVICE and 
> ZONE_* within the same section.
> 
> Then, indeed the end might not be online.
> 
> BUT, if the end is valid (-> ZONE_DEVICE), then the zone_id will differ. 
> [let's ignore any races for now, up to this point they are mostly of 
> theoretical nature]
> 
> So I don't think this change actually fixes something.
> 
> 
> Getting rid of the pfn_valid(start_pfn)  makes sense. Replacing the 

Yes, my motivation is try to optimize the __pageblock_pfn_to_page() 
which is hot when doing compaction, and I saw these pfn_valid() can be 
dropped.

> pfn_valid(end_pfn) by a pfn_to_online_page(end_pfn) could make that 
> function less efficient.
> 
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/page_alloc.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index d0eb280ec7e4..8076f519c572 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1512,9 +1512,6 @@ struct page *__pageblock_pfn_to_page(unsigned 
>> long start_pfn,
>>       /* end_pfn is one past the range we are checking */
>>       end_pfn--;
>> -    if (!pfn_valid(start_pfn) || !pfn_valid(end_pfn))
>> -        return NULL;
>> -
>>       start_page = pfn_to_online_page(start_pfn);
>>       if (!start_page)
>>           return NULL;
>> @@ -1522,7 +1519,9 @@ struct page *__pageblock_pfn_to_page(unsigned 
>> long start_pfn,
>>       if (page_zone(start_page) != zone)
>>           return NULL;
>> -    end_page = pfn_to_page(end_pfn);
>> +    end_page = pfn_to_online_page(end_pfn);
>> +    if (!end_page)
>> +        return NULL;
>>       /* This gives a shorter code than deriving page_zone(end_page) */
>>       if (page_zone_id(start_page) != page_zone_id(end_page))
> 
