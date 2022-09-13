Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8DB5B76A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiIMQnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiIMQnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:43:19 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7317EBBA54
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:37:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPhRWsB_1663082976;
Received: from 30.27.95.99(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPhRWsB_1663082976)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 23:29:37 +0800
Message-ID: <9856e03f-a1da-1b56-b15a-1a644ae19b89@linux.alibaba.com>
Date:   Tue, 13 Sep 2022 23:29:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH] mm/damon: add MADV_COLLAPSE support in damos_action
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220913151755.103334-1-sj@kernel.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220913151755.103334-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  SJ,

在 2022/9/13 下午11:17, SeongJae Park 写道:
> Hi Xin,
>
> On Tue, 13 Sep 2022 19:47:35 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> MADV_COLLAPSE has large different with MDVA_HUGE in dealing with huge
>> pages, it doesn't need to rely on 'khugepage' thread to create THP.
>> So combining with it will give damon users more options.
> I think this is a simple and worthy change, but... could you put some more
> detailed explanation of the scenario that the action could be used?  Also, it
> would be good to have some evaluation results you got with this change.

Yes, internally, we use this feature mainly focus on two reason:

the fist one,

     prevent performance jitter casused by khugepage thread under memory 
pressure.

the second one,

     khugepage thread merge hugepages is  slowness then MADV_COLLAPSE.

>
> Als, to my understanding, MADV_COLLAPSE is not merged in the mainline yet,
> right?  I believe it will make it in v6.1-rc1.  That said, to make Andrew's
> burden less, how about delaying this change until MADV_COLLAPSE is mainlined?
> If you have some numbers showing clear and great benefit of this change, I
> think it would be worthy to add immediately, though.
>
>
> Thanks,
> SJ
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   include/linux/damon.h | 1 +
>>   mm/damon/vaddr.c      | 3 +++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index 016b6c9c03d6..c44f9410d997 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -97,6 +97,7 @@ enum damos_action {
>>   	DAMOS_PAGEOUT,
>>   	DAMOS_HUGEPAGE,
>>   	DAMOS_NOHUGEPAGE,
>> +	DAMOS_COLLAPSE,
>>   	DAMOS_LRU_PRIO,
>>   	DAMOS_LRU_DEPRIO,
>>   	DAMOS_STAT,		/* Do nothing but only record the stat */
>> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
>> index c2c08c1b316b..58c0d068563d 100644
>> --- a/mm/damon/vaddr.c
>> +++ b/mm/damon/vaddr.c
>> @@ -655,6 +655,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>>   	case DAMOS_NOHUGEPAGE:
>>   		madv_action = MADV_NOHUGEPAGE;
>>   		break;
>> +	case DAMOS_COLLAPSE:
>> +		madv_action = MADV_COLLAPSE;
>> +		break;
>>   	case DAMOS_STAT:
>>   		return 0;
>>   	default:
>> -- 
>> 2.31.0
