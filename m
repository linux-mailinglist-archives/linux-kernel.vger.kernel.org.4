Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506556ECA8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjDXKqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjDXKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:46:46 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCD91FE0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:46:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VgtI39q_1682333200;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VgtI39q_1682333200)
          by smtp.aliyun-inc.com;
          Mon, 24 Apr 2023 18:46:41 +0800
Message-ID: <7525a9f6-b431-4404-2878-898e52905d4a@linux.alibaba.com>
Date:   Mon, 24 Apr 2023 18:46:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] mm/page_alloc: drop the unnecessary pfn_valid()
 for start pfn
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, vbabka@suse.cz, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <9fc85cce8908938f4fd75ff50bc981c073779aa5.1682229876.git.baolin.wang@linux.alibaba.com>
 <ZEZQ9EpUY8Mj5TwQ@dhcp22.suse.cz>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZEZQ9EpUY8Mj5TwQ@dhcp22.suse.cz>
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



On 4/24/2023 5:50 PM, Michal Hocko wrote:
> On Sun 23-04-23 18:59:10, Baolin Wang wrote:
>> We've already used pfn_to_online_page() for start pfn to make sure
> 
> Who is we? I do not see any note explicitly requiring that start_pfn has
> to be valid for __pageblock_pfn_to_page.

Sorry for confusing, what I mean is the __pageblock_pfn_to_page() 
function, which has used pfn_to_online_page() for start pfn. So the 
pfn_valid() in __pageblock_pfn_to_page() for start pfn is unnecessary.

I will update the commit log to make it clear.

>> it is online and valid, so the pfn_valid() for the start pfn is
>> unnecessary, drop it.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> ---
>> Changes from v1:
>>   - Collect reviewed tags. Thanks David and Ying.
>> ---
>>   mm/page_alloc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 9de2a18519a1..6457b64fe562 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1512,7 +1512,7 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>>   	/* end_pfn is one past the range we are checking */
>>   	end_pfn--;
>>   
>> -	if (!pfn_valid(start_pfn) || !pfn_valid(end_pfn))
>> +	if (!pfn_valid(end_pfn))
>>   		return NULL;
>>   
>>   	start_page = pfn_to_online_page(start_pfn);
>> -- 
>> 2.27.0
> 
