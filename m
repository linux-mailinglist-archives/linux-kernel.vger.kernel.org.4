Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63D86EE1B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjDYMOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjDYMOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:14:33 -0400
Received: from out0-195.mail.aliyun.com (out0-195.mail.aliyun.com [140.205.0.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7A64EF1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:14:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=yanyan.yan@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.SQAyIdK_1682424865;
Received: from 30.177.18.177(mailfrom:yanyan.yan@antgroup.com fp:SMTPD_---.SQAyIdK_1682424865)
          by smtp.aliyun-inc.com;
          Tue, 25 Apr 2023 20:14:26 +0800
Message-ID: <3ac59e0f-507f-4603-033b-e493c290cf9f@antgroup.com>
Date:   Tue, 25 Apr 2023 20:14:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/3] sched/debug: use int type and fix wrong print for
 rq->nr_uninterruptible
From:   "=?UTF-8?B?5pmP6ImzKOmHh+iLkyk=?=" <yanyan.yan@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        "Tiwei Bie" <tiwei.btw@antgroup.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>
References: <20230412030731.24990-1-yanyan.yan@antgroup.com>
 <20230412030731.24990-2-yanyan.yan@antgroup.com>
 <269db8cf-4ff0-70e4-80f3-36970d0a2169@antgroup.com>
In-Reply-To: <269db8cf-4ff0-70e4-80f3-36970d0a2169@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/19 15:46, 晏艳 写道:
>
>
> 在 2023/4/12 11:07, 晏艳(采苓) 写道:
>> commit e6fe3f422be1 ("sched: Make multiple runqueue task counters
>> 32-bit") changed rq->nr_uninterruptible from 'unsigned long'
>> to 'unsigned int', but left the wrong print to
>> /sys/kernel/debug/sched/debug and to the console.
>>
>> For example:
>> Current type is 'unsigned int' and value is fffffff7, and the print
>> will run the sentences,
>> "do {                                    \
>>      if (sizeof(rq->x) == 4)                     \
>>          SEQ_printf(m, "  .%-30s: %ld\n", #x, (long)(rq->x));    \
>>      else                                \
>>          SEQ_printf(m, "  .%-30s: %Ld\n", #x, (long long)(rq->x));\
>> } while (0)"
>>
>> The result will be 4294967287 on 64-bit machines to print (long)(rq->x)
>> while old type 'unsigned long' will print -9.
>>
>> And the other places that use its value will cast to int to return
>> expected output, so we convert its type from 'unsigned int' to int.
>>
>> Signed-off-by: Yan Yan<yanyan.yan@antgroup.com>
>> ---
>>   kernel/sched/loadavg.c | 2 +-
>>   kernel/sched/sched.h   | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
> Ping, any comment?
>
> thanks,
> -Yan Yan

Ping, any comment?

thanks,

-Yan Yan

>> diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
>> index 52c8f8226b0d..b9867495fe8b 100644
>> --- a/kernel/sched/loadavg.c
>> +++ b/kernel/sched/loadavg.c
>> @@ -80,7 +80,7 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
>>   	long nr_active, delta = 0;
>>   
>>   	nr_active = this_rq->nr_running - adjust;
>> -	nr_active += (int)this_rq->nr_uninterruptible;
>> +	nr_active += this_rq->nr_uninterruptible;
>>   
>>   	if (nr_active != this_rq->calc_load_active) {
>>   		delta = nr_active - this_rq->calc_load_active;
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 060616944d7a..23c643948331 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1006,7 +1006,7 @@ struct rq {
>>   	 * one CPU and if it got migrated afterwards it may decrease
>>   	 * it on another CPU. Always updated under the runqueue lock:
>>   	 */
>> -	unsigned int		nr_uninterruptible;
>> +	int			nr_uninterruptible;
>>   
>>   	struct task_struct __rcu	*curr;
>>   	struct task_struct	*idle;
