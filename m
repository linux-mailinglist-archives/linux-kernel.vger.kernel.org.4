Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA996ECB77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjDXLkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDXLkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:40:37 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B13A8C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:40:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vgu6NWh_1682336430;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vgu6NWh_1682336430)
          by smtp.aliyun-inc.com;
          Mon, 24 Apr 2023 19:40:31 +0800
Message-ID: <8d4059e3-2e6d-3f0c-2881-13b9bd07aa6c@linux.alibaba.com>
Date:   Mon, 24 Apr 2023 19:40:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] mm/page_alloc: add some comments to explain the
 possible hole in __pageblock_pfn_to_page()
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, vbabka@suse.cz, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <9fc85cce8908938f4fd75ff50bc981c073779aa5.1682229876.git.baolin.wang@linux.alibaba.com>
 <0733a4cf57109a4136de5ae46fac83fb15bdd528.1682229876.git.baolin.wang@linux.alibaba.com>
 <ZEZRv0ycAI0Ated1@dhcp22.suse.cz>
 <9a20c0b5-9d8a-2b1d-570a-61c17a4ce5e8@linux.alibaba.com>
 <ZEZpP/ab+zk7GgX7@dhcp22.suse.cz>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZEZpP/ab+zk7GgX7@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/2023 7:34 PM, Michal Hocko wrote:
> On Mon 24-04-23 19:20:43, Baolin Wang wrote:
>>
>>
>> On 4/24/2023 5:54 PM, Michal Hocko wrote:
>>> On Sun 23-04-23 18:59:11, Baolin Wang wrote:
>>>> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(), which
>>>> checks whether the given zone contains holes, and uses pfn_to_online_page()
>>>> to validate if the start pfn is online and valid, as well as using pfn_valid()
>>>> to validate the end pfn.
>>>>
>>>> However, the __pageblock_pfn_to_page() function may return non-NULL even
>>>> if the end pfn of a pageblock is in a memory hole in some situations. For
>>>> example, if the pageblock order is MAX_ORDER, which will fall into 2
>>>> sub-sections, and the end pfn of the pageblock may be hole even though
>>>> the start pfn is online and valid.
>>>>
>>>> This did not break anything until now, but the zone continuous is fragile
>>>> in this possible scenario. So as previous discussion[1], it is better to
>>>> add some comments to explain this possible issue in case there are some
>>>> future pfn walkers that rely on this.
>>>>
>>>> [1] https://lore.kernel.org/all/87r0sdsmr6.fsf@yhuang6-desk2.ccr.corp.intel.com/
>>>
>>> Do I remember correctly you've had a specific configuration that would
>>> trigger this case?
>>
>> Yes, I provided an example in previous thread [2] so show the
>> __pageblock_pfn_to_page() is fragile in some cases.
>>
>> [2] https://lore.kernel.org/all/52dfdd2e-9c99-eac4-233e-59919a24323e@linux.alibaba.com/
> 
> Please make it a part of the changelog.

Sure.

>   
>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>> Changes from v1:
>>>>    - Update the comments per Ying and Mike, thanks.
>>>> ---
>>>>    mm/page_alloc.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 6457b64fe562..9756d66f471c 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -1502,6 +1502,13 @@ void __free_pages_core(struct page *page, unsigned int order)
>>>>     * interleaving within a single pageblock. It is therefore sufficient to check
>>>>     * the first and last page of a pageblock and avoid checking each individual
>>>>     * page in a pageblock.
>>>> + *
>>>> + * Note: the function may return non-NULL even if the end pfn of a pageblock
>>>> + * is in a memory hole in some situations. For example, if the pageblock
>>>> + * order is MAX_ORDER, which will fall into 2 sub-sections, and the end pfn
>>>> + * of the pageblock may be hole even though the start pfn is online and valid.
>>>> + * This did not break anything until now, but be careful about this possible
>>>> + * issue when checking whether all pfns of a pageblock are valid.
>>>
>>> It is not really clear what you should be doing (other than to be
>>> careful which is not helpful much TBH) when you encounter this
>>> situation. If the reality changes and this would break in the future
>>> what would breakage look like? What should be done about that?
>>
>> That depends on what the future pfn walkers do, which may access some hole
>> memory with zero-init page frame. For example, if checking the
>> __PageMovable() for a zero-init page frame, that will crash the system. But
>> I can not list all the possible cases.
>>
>> So how about below words?
>>
>>   * Note: the function may return non-NULL even if the end pfn of a pageblock
>>   * is in a memory hole in some situations. For example, if the pageblock
>>   * order is MAX_ORDER, which will fall into 2 sub-sections, and the end pfn
>>   * of the pageblock may be hole even though the start pfn is online and
>> valid.
>>   * This did not break anything until now, but be careful about this possible
>>   * issue when checking whether all pfns of a pageblock are valid, that may
>>   * lead to accessing empty page frame, and the worst case can crash the
>> system.
>>   * So you should use pfn_to_onlie_page() instead of pfn_valid() to valid the
>>   * pfns in a pageblock if such case happens.
> 
> Does that mean that struct page is not initialized and PagePoisoned will
> trigger or it is just zero-prefilled?

In the example I provided[2], these page frames of the hole memory are 
zero-prefilled.

[2] 
https://lore.kernel.org/all/52dfdd2e-9c99-eac4-233e-59919a24323e@linux.alibaba.com/
