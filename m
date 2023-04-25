Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388896EE1DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjDYM31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjDYM30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:29:26 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C18E43
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:29:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vh-Qtpb_1682425758;
Received: from 30.15.221.179(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vh-Qtpb_1682425758)
          by smtp.aliyun-inc.com;
          Tue, 25 Apr 2023 20:29:19 +0800
Message-ID: <98fa0a22-77d1-cdb3-1ce2-48a00c3ed5a9@linux.alibaba.com>
Date:   Tue, 25 Apr 2023 20:29:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/2] mm/page_alloc: add some comments to explain the
 possible hole in __pageblock_pfn_to_page()
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
        rppt@kernel.org, mgorman@techsingularity.net, vbabka@suse.cz,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <c3868b58c6714c09a43440d7d02c7b4eed6e03f6.1682342634.git.baolin.wang@linux.alibaba.com>
 <50b5e05dbb007e3a969ac946bc9ee0b2b77b185f.1682342634.git.baolin.wang@linux.alibaba.com>
 <87zg6wkdy8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <060aab79-8170-56ad-797d-9d339f6c0b61@linux.alibaba.com>
 <ZEeXyZuTGT7CDuU7@dhcp22.suse.cz>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZEeXyZuTGT7CDuU7@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/2023 5:05 PM, Michal Hocko wrote:
> On Tue 25-04-23 09:27:23, Baolin Wang wrote:
>>
>>
>> On 4/25/2023 8:22 AM, Huang, Ying wrote:
>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> [...]
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 6457b64fe562..bd124390c79b 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -1502,6 +1502,15 @@ void __free_pages_core(struct page *page, unsigned int order)
>>>>     * interleaving within a single pageblock. It is therefore sufficient to check
>>>>     * the first and last page of a pageblock and avoid checking each individual
>>>>     * page in a pageblock.
>>>> + *
>>>> + * Note: the function may return non-NULL struct page even for a page block
>>>> + * which contains a memory hole (i.e. there is no physical memory for a subset
>>>> + * of the pfn range). For example, if the pageblock order is MAX_ORDER, which
>>>> + * will fall into 2 sub-sections, and the end pfn of the pageblock may be hole
>>>> + * even though the start pfn is online and valid. This should be safe most of
>>>> + * the time because struct pages are still zero pre-filled and pfn walkers
>>>
>>> I don't think the pfn is just zero-filled even it's a hole.  Can you
>>> confirm that?  In memmap_init() and memmap_init_zone_range(),
>>> init_unavailable_range() is called to initialize the struct page.
>>
>> Yes, what I mean is the page frames were initialized to zero firstly, and
>> some fields were initialized to default value. The "zero pre-filled" seems
>> confusing, may be change to "initialized"?
> 
> Huang Ying is correct. Holes should have struct pages initialized and
> init_unavailable_range actually marks those pages reserved. Which
> is really good because they mean "do not touch unless this page is
> yours". For some reason I thought those struct pages are simply zero
> filled. I was clearly wrong. Maybe it would be good to reference
> init_unavailable_range in the comment so that it is easier to track the
> whole code path.

OK, will do as you and Huang Ying suggested. Thank you both.

> Sorry about that!

never mind:)
