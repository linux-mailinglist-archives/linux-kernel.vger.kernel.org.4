Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4606ED9D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjDYB1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjDYB1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:27:30 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2D75269
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:27:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VgxlMIn_1682386044;
Received: from 30.97.48.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VgxlMIn_1682386044)
          by smtp.aliyun-inc.com;
          Tue, 25 Apr 2023 09:27:25 +0800
Message-ID: <060aab79-8170-56ad-797d-9d339f6c0b61@linux.alibaba.com>
Date:   Tue, 25 Apr 2023 09:27:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/2] mm/page_alloc: add some comments to explain the
 possible hole in __pageblock_pfn_to_page()
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <c3868b58c6714c09a43440d7d02c7b4eed6e03f6.1682342634.git.baolin.wang@linux.alibaba.com>
 <50b5e05dbb007e3a969ac946bc9ee0b2b77b185f.1682342634.git.baolin.wang@linux.alibaba.com>
 <87zg6wkdy8.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87zg6wkdy8.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/2023 8:22 AM, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(), which
>> checks whether the given zone contains holes, and uses pfn_to_online_page()
>> to validate if the start pfn is online and valid, as well as using pfn_valid()
>> to validate the end pfn.
>>
>> However, the __pageblock_pfn_to_page() function may return non-NULL even
>> if the end pfn of a pageblock is in a memory hole in some situations. For
>> example, if the pageblock order is MAX_ORDER, which will fall into 2
>> sub-sections, and the end pfn of the pageblock may be hole even though
>> the start pfn is online and valid.
>>
>> See below memory layout as an example and suppose the pageblock order
>> is MAX_ORDER.
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
>> pageblock must be 4M aligned. And in this pageblock, these pfns will
>> fall into 2 sub-section (the sub-section size is 2M aligned).
>>
>> So, the 1st sub-section (indicates pfn range: 0x1fa7c00000 -
>> 0x1fa7dfffff ) in this pageblock is valid by calling subsection_map_init()
>> in free_area_init(), but the 2nd sub-section (indicates pfn range:
>> 0x1fa7e00000 - 0x1fa7ffffff ) in this pageblock is not valid.
>>
>> This did not break anything until now, but the zone continuous is fragile
>> in this possible scenario. So as previous discussion[1], it is better to
>> add some comments to explain this possible issue in case there are some
>> future pfn walkers that rely on this.
>>
>> [1] https://lore.kernel.org/all/87r0sdsmr6.fsf@yhuang6-desk2.ccr.corp.intel.com/
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>> Changes from v2:
>>   - Update the commit log and comments per Michal, thanks.
>> Changes from v1:
>>   - Update the comments per Ying and Mike, thanks.
>>
>> Note, I did not add Huang Ying's reviewed tag, since there are some
>> updates per Michal's suggestion. Ying, please review the v3. Thanks.
>> ---
>>   mm/page_alloc.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 6457b64fe562..bd124390c79b 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1502,6 +1502,15 @@ void __free_pages_core(struct page *page, unsigned int order)
>>    * interleaving within a single pageblock. It is therefore sufficient to check
>>    * the first and last page of a pageblock and avoid checking each individual
>>    * page in a pageblock.
>> + *
>> + * Note: the function may return non-NULL struct page even for a page block
>> + * which contains a memory hole (i.e. there is no physical memory for a subset
>> + * of the pfn range). For example, if the pageblock order is MAX_ORDER, which
>> + * will fall into 2 sub-sections, and the end pfn of the pageblock may be hole
>> + * even though the start pfn is online and valid. This should be safe most of
>> + * the time because struct pages are still zero pre-filled and pfn walkers
> 
> I don't think the pfn is just zero-filled even it's a hole.  Can you
> confirm that?  In memmap_init() and memmap_init_zone_range(),
> init_unavailable_range() is called to initialize the struct page.

Yes, what I mean is the page frames were initialized to zero firstly, 
and some fields were initialized to default value. The "zero pre-filled" 
seems confusing, may be change to "initialized"?
