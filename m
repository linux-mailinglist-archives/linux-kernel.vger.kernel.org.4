Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204BE6E737C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjDSGro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjDSGrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:47:42 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B9D10CE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:47:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VgTpm5r_1681886857;
Received: from 30.97.48.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VgTpm5r_1681886857)
          by smtp.aliyun-inc.com;
          Wed, 19 Apr 2023 14:47:37 +0800
Message-ID: <2ef52fb4-ba74-a23e-4f5b-d4725c9fe289@linux.alibaba.com>
Date:   Wed, 19 Apr 2023 14:47:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/page_alloc: consider pfn holes after pfn_valid() in
 __pageblock_pfn_to_page()
To:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <62e231a8f2e50c04dcadc7a0cfaa6dea5ce1ec05.1681296022.git.baolin.wang@linux.alibaba.com>
 <94bfa3cc-674e-25b0-e7e2-d74c970acef7@redhat.com>
 <ac8bb4e9-e7f5-f9da-bca0-ac7ef6d68c23@linux.alibaba.com>
 <e9ac9692-c126-f78f-a6a2-a88eb986ccb7@suse.cz>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <e9ac9692-c126-f78f-a6a2-a88eb986ccb7@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 11:07 PM, Vlastimil Babka wrote:
> On 4/12/23 14:16, Baolin Wang wrote:
>>
>>
>> On 4/12/2023 7:25 PM, David Hildenbrand wrote:
>>> On 12.04.23 12:45, Baolin Wang wrote:
>>>> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(),
>>>> which checks whether the given zone contains holes, and uses pfn_valid()
>>>> to check if the end pfn is valid. However pfn_valid() can not make sure
>>>> the end pfn is not a hole if the size of a pageblock is larger than the
>>>> size of a sub-mem_section, since the struct page getting by pfn_to_page()
>>>> may represent a hole or an unusable page frame, which may cause incorrect
>>>> zone contiguous is set.
>>>>
>>>> Though another user of pageblock_pfn_to_page() in compaction seems work
>>>> well now, it is better to avoid scanning or touching these offline pfns.
>>>> So like commit 2d070eab2e82 ("mm: consider zone which is not fully
>>>> populated to have holes"), we should also use pfn_to_online_page() for
>>>> the end pfn to make sure it is a valid pfn with usable page frame.
>>>> Meanwhile the pfn_valid() for end pfn can be dropped now.
>>>>
>>>> Moreover we've already used pfn_to_online_page() for start pfn to make
>>>> sure it is online and valid, so the pfn_valid() for the start pfn is
>>>> unnecessary, drop it.
>>>
>>> pageblocks are supposed to fall into a single memory section, so in mos > cases, if the start is online, so is the end.
>>
>> Yes, the granularity of memory hotplug is a mem_section.
>>
>> However, suppose the pageblock order is MAX_ORDER-1, and the size of a
>> sub-section is 2M, that means a pageblock will fall into 2 sub
>> mem-section, and if there is a hole in the zone, that means the 2nd sub
>> mem-section can be invalid without setting subsection_map bitmap.
> 
> Can that really happen? I think the buddy merging in __free_one_page() would
> trip on that?

I do not think so IIUC. The hole pfns will not free to buddy system, and 
the buddy system did not change the ms->usage->subsection_map of the 
hole pfns, which indicates the hole pfns are invalid.
