Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D98717350
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjEaBoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjEaBoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:44:08 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66385F9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:44:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VjvObJY_1685497442;
Received: from 30.97.48.48(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VjvObJY_1685497442)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 09:44:03 +0800
Message-ID: <67234104-c059-1262-1c69-10b966700036@linux.alibaba.com>
Date:   Wed, 31 May 2023 09:44:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/6] mm: compaction: drop the redundant page validation in
 update_pageblock_skip()
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1685018752.git.baolin.wang@linux.alibaba.com>
 <5142e15b9295fe8c447dbb39b7907a20177a1413.1685018752.git.baolin.wang@linux.alibaba.com>
 <6feab6b0-ec49-8651-bc8e-14ec40249017@suse.cz>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <6feab6b0-ec49-8651-bc8e-14ec40249017@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 3:27 PM, Vlastimil Babka wrote:
> On 5/25/23 14:53, Baolin Wang wrote:
>> The caller has validated the page before calling pdate_pageblock_skip(),
>                                                     ^ u

Ah, sorry for typos. And I see Andrew has already helped to correct this 
typo. Thanks Andrew :)

>> thus drop the redundant page validation in update_pageblock_skip().
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks for your reviewing.

>> ---
>>   mm/compaction.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 163e2ec70aff..426bb6ce070b 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -436,9 +436,6 @@ static void update_pageblock_skip(struct compact_control *cc,
>>   	if (cc->no_set_skip_hint)
>>   		return;
>>   
>> -	if (!page)
>> -		return;
>> -
>>   	set_pageblock_skip(page);
>>   
>>   	/* Update where async and sync compaction should restart */
