Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5440A72BF0F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjFLKb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjFLKbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:31:06 -0400
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com [47.90.199.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4CC422A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:12:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VkxCZ1s_1686564619;
Received: from 30.97.48.52(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VkxCZ1s_1686564619)
          by smtp.aliyun-inc.com;
          Mon, 12 Jun 2023 18:10:20 +0800
Message-ID: <337d90f3-7c95-d5b8-de30-fb72e441a18b@linux.alibaba.com>
Date:   Mon, 12 Jun 2023 18:10:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] mm: compaction: skip memory hole rapidly when isolating
 migratable pages
To:     David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <8cc668b77c8eb2fa78058b3d81386ebed9c5a9cd.1686294549.git.baolin.wang@linux.alibaba.com>
 <87sfax6v7c.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d8444045-9497-1073-5cf9-e2959197701d@linux.alibaba.com>
 <55e05ac0-041d-75eb-4707-e053dc3f2976@redhat.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <55e05ac0-041d-75eb-4707-e053dc3f2976@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2023 5:54 PM, David Hildenbrand wrote:
> On 12.06.23 11:36, Baolin Wang wrote:
>>
>>
>> On 6/12/2023 2:39 PM, Huang, Ying wrote:
>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>
>>>> On some machines, the normal zone can have a large memory hole like
>>>> below memory layout, and we can see the range from 0x100000000 to
>>>> 0x1800000000 is a hole. So when isolating some migratable pages, the
>>>> scanner can meet the hole and it will take more time to skip the large
>>>> hole. From my measurement, I can see the isolation scanner will take
>>>> 80us ~ 100us to skip the large hole [0x100000000 - 0x1800000000].
>>>>
>>>> So adding a new helper to fast search next online memory section
>>>> to skip the large hole can help to find next suitable pageblock
>>>> efficiently. With this patch, I can see the large hole scanning only
>>>> takes < 1us.
>>>>
>>>> [    0.000000] Zone ranges:
>>>> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
>>>> [    0.000000]   DMA32    empty
>>>> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
>>>> [    0.000000] Movable zone start for each node
>>>> [    0.000000] Early memory node ranges
>>>> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000000fffffffff]
>>>> [    0.000000]   node   0: [mem 0x0000001800000000-0x0000001fa3c7ffff]
>>>> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
>>>> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
>>>> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
>>>> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
>>>> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
>>>> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
>>>> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
>>>> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7ffffff]
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>    include/linux/mmzone.h | 10 ++++++++++
>>>>    mm/compaction.c        | 23 ++++++++++++++++++++++-
>>>>    2 files changed, 32 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>>> index 5a7ada0413da..87e6c535d895 100644
>>>> --- a/include/linux/mmzone.h
>>>> +++ b/include/linux/mmzone.h
>>>> @@ -2000,6 +2000,16 @@ static inline unsigned long 
>>>> next_present_section_nr(unsigned long section_nr)
>>>>        return -1;
>>>>    }
>>>> +static inline unsigned long next_online_section_nr(unsigned long 
>>>> section_nr)
>>>> +{
>>>> +    while (++section_nr <= __highest_present_section_nr) {
>>>> +        if (online_section_nr(section_nr))
>>>> +            return section_nr;
>>>> +    }
>>>> +
>>>> +    return -1UL;
>>>> +}
>>>> +
>>>>    /*
>>>>     * These are _only_ used during initialisation, therefore they
>>>>     * can use __initdata ...  They could have names to indicate
>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>> index 3398ef3a55fe..3a55fdd20c49 100644
>>>> --- a/mm/compaction.c
>>>> +++ b/mm/compaction.c
>>>> @@ -229,6 +229,21 @@ static void reset_cached_positions(struct zone 
>>>> *zone)
>>>>                    pageblock_start_pfn(zone_end_pfn(zone) - 1);
>>>>    }
>>>> +static unsigned long skip_hole_pageblock(unsigned long start_pfn)
>>>> +{
>>>> +    unsigned long next_online_nr;
>>>> +    unsigned long start_nr = pfn_to_section_nr(start_pfn);
>>>> +
>>>> +    if (online_section_nr(start_nr))
>>>> +        return -1UL;
>>>
>>> Define a macro for the maigic "-1UL"?  Which is used for multiple times
>>> in the patch.
>>
>> I am struggling to find a readable macro for these '-1UL', since the
>> '-1UL' in next_online_section_nr() indicates that it can not find an
>> online section. However the '-1' in skip_hole_pageblock() indicates that
>> it can not find an online pfn.
> 
> Maybe something like
> 
> #define SECTION_NR_INVALID -1UL

Actually we already have a NR_MEM_SECTIONS macro, which means it is an 
invalid section if the section nr >= NR_MEM_SECTIONS. So using 
NR_MEM_SECTIONS seems more suitable?

>> So after more thinking, I will change to return 'NR_MEM_SECTIONS' if can
>> not find next online section in next_online_section_nr(). And in
>> skip_hole_pageblock(), I will change to return 0 if can not find next
>> online pfn. What do you think?
> 
> Well, 0 "might be" (and most likely is) a valid section number, so you'd 
> simulate some kind-of a wraparound. I guess I'd prefer 
> SECTION_NR_INVALID instead.

0 means can not find next online pfn number, not a section number in 
skip_hole_pageblock().
