Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB974D158
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGJJ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGJJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:26:39 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C911B1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:26:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vn0gHB3_1688981190;
Received: from 30.97.48.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vn0gHB3_1688981190)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 17:26:31 +0800
Message-ID: <36747b09-8141-019f-85dd-59f3d4623ec1@linux.alibaba.com>
Date:   Mon, 10 Jul 2023 17:26:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] mm: compaction: skip the memory hole rapidly when
 isolating free pages
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <b21cd8e2e32b9a1d9bc9e43ebf8acaf35e87f8df.1688715750.git.baolin.wang@linux.alibaba.com>
 <d2ba7e41ee566309b594311207ffca736375fc16.1688715750.git.baolin.wang@linux.alibaba.com>
 <87pm50fg88.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87pm50fg88.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/2023 2:11 PM, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On my machine with below memory layout, and I can see it will take more
>> time to skip the larger memory hole (range: 0x100000000 - 0x1800000000)
>> when isolating free pages. So adding a new helper to skip the memory
>> hole rapidly, which can reduce the time consumed from about 70us to less
>> than 1us.
>>
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
>> [    0.000000]   DMA32    empty
>> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
> 
> The memory hole is at the beginning of zone NORMAL?  If so, should zone

No, the memory hole range is 0x1000000000 - 0x1800000000, and the normal 
zone is start from 0x100000000.

I'm sorry I made a typo in the commit message, which confuses you. The 
memory hole range should be: 0x1000000000 - 0x1800000000. I updated the 
commit message to the following and addressed David's comment:

"
Just like commit 9721fd82351d ("mm: compaction: skip memory hole rapidly
when isolating migratable pages"), I can see it will also take more
time to skip the larger memory hole (range: 0x1000000000 - 0x1800000000)
when isolating free pages on my machine with below memory layout. So 
like commit 9721fd82351d, adding a new helper to skip the memory hole 
rapidly, which can reduce the time consumed from about 70us to less than 
1us.

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x0000000fffffffff]
[    0.000000]   node   0: [mem 0x0000001800000000-0x0000001fa3c7ffff]
[    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
[    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
[    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
[    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
[    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
[    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
[    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
[    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7ffffff]
"

> NORMAL start at 0x1800000000?  And, the free pages will not be scanned
> there?  Or my understanding were wrong. >
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000000fffffffff]
>> [    0.000000]   node   0: [mem 0x0000001800000000-0x0000001fa3c7ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
>> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
>> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
>> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7ffffff]
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/compaction.c | 30 +++++++++++++++++++++++++++++-
>>   1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 43358efdbdc2..9641e2131901 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -249,11 +249,31 @@ static unsigned long skip_offline_sections(unsigned long start_pfn)
>>   
>>   	return 0;
>>   }
>> +
>> +static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
>> +{
>> +	unsigned long start_nr = pfn_to_section_nr(start_pfn);
>> +
>> +	if (!start_nr || online_section_nr(start_nr))
>> +		return 0;
>> +
>> +	while (start_nr-- > 0) {
>> +		if (online_section_nr(start_nr))
>> +			return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;
>> +	}
>> +
>> +	return 0;
>> +}
>>   #else
>>   static unsigned long skip_offline_sections(unsigned long start_pfn)
>>   {
>>   	return 0;
>>   }
>> +
>> +static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
>> +{
>> +	return 0;
>> +}
>>   #endif
>>   
>>   /*
>> @@ -1668,8 +1688,16 @@ static void isolate_freepages(struct compact_control *cc)
>>   
>>   		page = pageblock_pfn_to_page(block_start_pfn, block_end_pfn,
>>   									zone);
>> -		if (!page)
>> +		if (!page) {
>> +			unsigned long next_pfn;
>> +
>> +			next_pfn = skip_offline_sections_reverse(block_start_pfn);
>> +			if (next_pfn)
>> +				block_start_pfn = max(pageblock_start_pfn(next_pfn),
>> +						      low_pfn);
>> +
>>   			continue;
>> +		}
>>   
>>   		/* Check the block is suitable for migration */
>>   		if (!suitable_migration_target(cc, page))
