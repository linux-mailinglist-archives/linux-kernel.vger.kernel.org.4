Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4AE6EA46B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjDUHNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDUHNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:13:30 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE56B8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:13:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vgbk75J_1682061204;
Received: from 30.221.129.177(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vgbk75J_1682061204)
          by smtp.aliyun-inc.com;
          Fri, 21 Apr 2023 15:13:25 +0800
Message-ID: <e112881b-f2c0-2c8e-e5d4-b0323a3b8f16@linux.alibaba.com>
Date:   Fri, 21 Apr 2023 15:13:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/page_alloc: consider pfn holes after pfn_valid() in
 __pageblock_pfn_to_page()
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, vbabka@suse.cz, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <62e231a8f2e50c04dcadc7a0cfaa6dea5ce1ec05.1681296022.git.baolin.wang@linux.alibaba.com>
 <94bfa3cc-674e-25b0-e7e2-d74c970acef7@redhat.com>
 <ac8bb4e9-e7f5-f9da-bca0-ac7ef6d68c23@linux.alibaba.com>
 <87cz3zt3u6.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <52dfdd2e-9c99-eac4-233e-59919a24323e@linux.alibaba.com>
 <874jp9uapj.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <874jp9uapj.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2023 12:21 PM, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On 4/20/2023 3:22 PM, Huang, Ying wrote:
>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>
>>>> On 4/12/2023 7:25 PM, David Hildenbrand wrote:
>>>>> On 12.04.23 12:45, Baolin Wang wrote:
>>>>>> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(),
>>>>>> which checks whether the given zone contains holes, and uses pfn_valid()
>>>>>> to check if the end pfn is valid. However pfn_valid() can not make sure
>>>>>> the end pfn is not a hole if the size of a pageblock is larger than the
>>>>>> size of a sub-mem_section, since the struct page getting by pfn_to_page()
>>>>>> may represent a hole or an unusable page frame, which may cause incorrect
>>>>>> zone contiguous is set.
>>>>>>
>>>>>> Though another user of pageblock_pfn_to_page() in compaction seems work
>>>>>> well now, it is better to avoid scanning or touching these offline pfns.
>>>>>> So like commit 2d070eab2e82 ("mm: consider zone which is not fully
>>>>>> populated to have holes"), we should also use pfn_to_online_page() for
>>>>>> the end pfn to make sure it is a valid pfn with usable page frame.
>>>>>> Meanwhile the pfn_valid() for end pfn can be dropped now.
>>>>>>
>>>>>> Moreover we've already used pfn_to_online_page() for start pfn to make
>>>>>> sure it is online and valid, so the pfn_valid() for the start pfn is
>>>>>> unnecessary, drop it.
>>>>> pageblocks are supposed to fall into a single memory section, so in
>>>>> mos > cases, if the start is online, so is the end.
>>>>
>>>> Yes, the granularity of memory hotplug is a mem_section.
>>>>
>>>> However, suppose the pageblock order is MAX_ORDER-1, and the size of a
>>>> sub-section is 2M, that means a pageblock will fall into 2 sub
>>>> mem-section, and if there is a hole in the zone, that means the 2nd
>>>> sub mem-section can be invalid without setting subsection_map bitmap.
>>>>
>>>> So the start is online can make sure the end pfn of a pageblock is
>>>> online, but a valid start pfn can not make sure the end pfn is valid
>>>> in the bitmap of ms->usage->subsection_map.
>>> arch_add_memory
>>>     add_pages
>>>       __add_pages
>>>         sparse_add_section /* set subsection_map */
>>> arch_add_memory() is only called by add_memory_resource() and
>>> pagemap_range() (called add_pages() too).  In add_memory_resource(),
>>> check_hotplug_memory_range() will enforce a strict hotplug range
>>> alignment requirement (128 MB on x86_64).  pagemap_range() are used for
>>> ZONE_DEVICE only.  That is, for normal memory, hotplug granularity is
>>> much larger than 2MB.
>>> IIUC, the situation you mentioned above is impossible.  Or do I miss
>>> something?
>>
>> Thanks for your input. Your example is correct, but this is not the
>> case I want to describe. My case is not about the memory hotplug,
>> instead about the early memory holes when initialzing the memory. Let
>> me try to describe explicity:
>>
>> First suppose the pageblock order is MAX_ORDER-1, and see below memory
>> layout as an example:
>>
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
>> [    0.000000]   DMA32    empty
>> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000001fa3c7ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
>> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
>> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
>> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
>> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7dfffff]
>>
>> Focus on the last memory range, and there is a hole for the range [mem
>> 0x0000001fa7590000-0x0000001fa7dfffff]. That means the last pageblock
>> will contain the range from 0x1fa7c00000 to 0x1fa7ffffff, since the
>> pageblock must be 4M aligned. And in this page block, these pfns will
>> fall into 2 sub-section (the sub-section size is 2M aligned).
>>
>> So, the 1st sub-section (indicates pfn range: 0x1fa7c00000 -
>> 0x1fa7dfffff ) in this pageblock is valid by
>> free_area_init()--->subsection_map_init(), but the 2nd sub-section
>> (indicates pfn range: 0x1fa7e00000 - 0x1fa7ffffff ) in this pageblock
>> is not valid.
>>
>> The problem is, if we just check the pageblock start of the hole pfn
>> (such as 0x1fa7dfffff) to make sure the hole pfn (0x1fa7dfffff) is
>> also valid, which is NOT correct. So that is what I mean "the start is
>> online can make sure the end pfn of a pageblock is online, but a valid
>> start pfn can not make sure the end pfn is valid in the bitmap of
>> ms->usage->subsection_map."
>>
>> Hope I make it clear. Does that make sense to you? Thanks.
> 
> Thanks for your detailed description.  You are right, it's possible that
> the second subsection of a pageblock is a hole.
> 
> It's good to remove unnecessary pfn_valid(start_pfn) check in your
> original patch.  But it appears unnecessary to replace

OK. I will split this into a separate patch.

> pfn_valid(end_pfn) with pfn_to_online_page(end_pfn).  Yes, it's possible
> that there's a hole in a page block.  But it appears that this will not
> break anything.  Per my understanding, even if we had fixed this one,

Yes, it will not break anything now, the worst case is the compaction 
will waste more time to scan unnecessary hole pfns, though I did not 
have a performance report to show this issue.

Another concern is that the zone->contiguous is fragile IMO, and not 
sure if there are pfn walkers will meet the holes though the 
zone->contiguous = 1 in future.

So at least we can add some comments for __pageblock_pfn_to_page() to 
describe this issue? what do you think?

> there may be other smaller memory holes in a pageblock represented as
> reserved pages
