Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC4B5B4397
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 03:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiIJBNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 21:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIJBMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 21:12:41 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10F9143414
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 18:12:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPDKArq_1662772319;
Received: from 192.168.1.6(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPDKArq_1662772319)
          by smtp.aliyun-inc.com;
          Sat, 10 Sep 2022 09:12:00 +0800
Message-ID: <56ecdabb-438a-6efe-6d1d-8d4eceda3652@linux.alibaba.com>
Date:   Sat, 10 Sep 2022 09:11:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH V4] mm/damon: Remove duplicate get_monitoring_region()
 definitions
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909213931.136283-1-sj@kernel.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220909213931.136283-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/10 上午5:39, SeongJae Park 写道:
> As my previous comments are almost only cosmetic trivial nits and I don't want
> to make this unnecessarily delayed long, I made the changes on my own and
> posted it:
> https://lore.kernel.org/damon/20220909213606.136221-1-sj@kernel.org/
Thanks a lot for your modification，your suggestion is reasonable too.
>
> Xin, if there was anything I missed or there is anything you disagree about my
> changes, please let me know.
>
>
> Thanks,
> SJ
>
> On Fri, 9 Sep 2022 20:45:20 +0000 SeongJae Park <sj@kernel.org> wrote:
>
>> On Fri, 9 Sep 2022 10:41:05 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>>
>>> In lru_sort.c and reclaim.c, they are all defining get_monitoring_region()
>>> function, there is no need to define it separately.
>>>
>>> As 'get_monitoring_region()' is not a 'static' function anymore, we try
>>> to use a prefix to distinguish with other functions, so there rename it
>>> to 'damon_find_biggest_system_ram'.
>>>
>>> Suggested-by: SeongJae Park <sj@kernel.org>
>>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>>> ---
>>>   include/linux/damon.h | 11 +++++++++++
>>>   mm/damon/core.c       | 29 +++++++++++++++++++++++++++++
>>>   mm/damon/lru_sort.c   | 37 ++-----------------------------------
>>>   mm/damon/reclaim.c    | 37 ++-----------------------------------
>>>   4 files changed, 44 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>>> index 7b1f4a488230..6c863b281fb2 100644
>>> --- a/include/linux/damon.h
>>> +++ b/include/linux/damon.h
>>> @@ -448,6 +448,16 @@ struct damon_ctx {
>>>   	struct list_head schemes;
>>>   };
>>>   
>>> +/**
>>> + * struct damon_system_ram_region - System RAM resource address region of [@start, @end).
>> I prefer 80 columns, let's break down this line.
>> https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-strings
>>
>> Also this struct is gonna be used by only damon_find_biggest_system_ram(), so I
>> think it might make more sense to move this into core.c.
>>
>> And, as this is not aimed to directly be used by external API users, I think it
>> would make more sense to hide from kernel doc (/* instead of /**).
>>
>>> + * @start:	Start address of the  (inclusive).
>> of the 'region'?
>>
>>> + * @end:	End address of the region (exclusive).
>> I like the nice explanation: whether its inclusive or exclusive.
>>
>>> + */
>>> +struct damon_system_ram_region {
>>> +	unsigned long start;
>>> +	unsigned long end;
>>> +};
>>> +
>> As this struct is only used by damon_find_biggest_system_ram(), I think it
>> might make more sense to move this into core.c?
>>
>> Below parts all look good.
>>
>> Also, this patch seems cannot cleanly applied on top of the latest
>> mm/mm-unstable branch.  Would need rebase.
>>
>>
>> Thanks,
>> SJ
>>
>> [...]
>>
