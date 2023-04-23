Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CECE6EBC40
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 03:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDWB1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 21:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDWB1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 21:27:35 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62FA10EC
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 18:27:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VghjePw_1682213247;
Received: from 30.97.48.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VghjePw_1682213247)
          by smtp.aliyun-inc.com;
          Sun, 23 Apr 2023 09:27:28 +0800
Message-ID: <1e4ca204-6813-a809-4361-4197103814b0@linux.alibaba.com>
Date:   Sun, 23 Apr 2023 09:27:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] mm/page_alloc: add some comments to explain the
 possible hole in __pageblock_pfn_to_page()
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, mhocko@suse.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <c2eee65ecd15779721af85c9ff109a35345b52d4.1682158312.git.baolin.wang@linux.alibaba.com>
 <02defcbe9d7a797a2257e5f6a28ff7ea78e394e5.1682158312.git.baolin.wang@linux.alibaba.com>
 <87cz3vs8nn.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87cz3vs8nn.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/23/2023 9:13 AM, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(), which
>> checks whether the given zone contains holes, and uses pfn_to_online_page()
>> to validate if the start pfn is online and valid, as well as using pfn_valid()
>> to validate the end pfn.
>>
>> However, though the start pfn of a pageblock is valid, it can not always
>> guarantee the end pfn of the pageblock is also valid (may be holes) in some
>> cases. For example, if the pageblock order is MAX_ORDER - 1, which will fall
>> into 2 sub-sections, and the end pfn of the pageblock may be hole even though
>> the start pfn is online and valid.
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
>>   mm/page_alloc.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 6457b64fe562..dc4005b32ae0 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1502,6 +1502,14 @@ void __free_pages_core(struct page *page, unsigned int order)
>>    * interleaving within a single pageblock. It is therefore sufficient to check
>>    * the first and last page of a pageblock and avoid checking each individual
>>    * page in a pageblock.
>> + *
>> + * Note: if the start pfn of a pageblock is valid, but it can not always guarantee
>> + * the end pfn of the pageblock is also valid (may be holes) in some cases. For
> 
> "valid" sounds confusing here.  pfn_valid() is true, but the pfn is
> considered invalid at some degree.  How about the following?
> 
> Note: the function may return non-NULL even if the end pfn of a
> pageblock is in a memory hole in some situations.  For
> 
>> + * example, if the pageblock order is MAX_ORDER - 1, which will fall into 2
>> + * sub-sections, and the end pfn of the pageblock may be hole even though the
>> + * start pfn is online and valid. This did not break anything until now, but be
>> + * careful this possible issue when checking if the whole pfns are valid of a
>                                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> whether all pfns of a pageblock are valid. ?
> 
>> + * pageblock.
>>    */
>>   struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>>   				     unsigned long end_pfn, struct zone *zone)
> 
> My English is poor.  So, feel free to ignore the comments.

Better than me:) . Will do in next version. Thanks.
