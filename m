Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50745F020B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiI3A7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiI3A66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:58:58 -0400
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4051D1E05CB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:58:56 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.64.13])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 993C6B00A383E;
        Fri, 30 Sep 2022 08:58:53 +0800 (CST)
Received: from [172.24.140.16] (10.79.65.101) by
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 30 Sep 2022 08:58:53 +0800
Message-ID: <4ad76a27-dfb4-23be-fdb3-49c0780df670@didichuxing.com>
Date:   Fri, 30 Sep 2022 08:58:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Content-Language: en-US
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Chen Yu <yu.c.chen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 10.79.64.13
From:   Honglei Wang <wanghonglei@didichuxing.com>
In-Reply-To: <2c50baa4-beef-54b9-74fe-1cbf6e8f8dbd@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.79.65.101]
X-ClientProxiedBy: ZJY02-PUBMBX-01.didichuxing.com (10.79.65.31) To
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,


On 2022/9/30 01:34, K Prateek Nayak wrote:
> Hello Honglei,
> 
> Thank you for looking into this.
> 
> On 9/29/2022 12:29 PM, Honglei Wang wrote:
>>
>> [..snip..]
>>
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index 914096c5b1ae..7519ab5b911c 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -6020,6 +6020,19 @@ static int wake_wide(struct task_struct *p)
>>>>>        return 1;
>>>>>    }
>>>>>    +/*
>>>>> + * If a task switches in and then voluntarily relinquishes the
>>>>> + * CPU quickly, it is regarded as a short running task.
>>>>> + * sysctl_sched_min_granularity is chosen as the threshold,
>>>>> + * as this value is the minimal slice if there are too many
>>>>> + * runnable tasks, see __sched_period().
>>>>> + */
>>>>> +static int is_short_task(struct task_struct *p)
>>>>> +{
>>>>> +    return (p->se.sum_exec_runtime <=
>>>>> +        (p->nvcsw * sysctl_sched_min_granularity));
>>>>> +}
>>>>> +
>>>>>    /*
>>>>>     * The purpose of wake_affine() is to quickly determine on which CPU we can run
>>>>>     * soonest. For the purpose of speed we only consider the waking and previous
>>>>> @@ -6050,7 +6063,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>>>>>        if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
>>>>>            return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
>>>>>    -    if (sync && cpu_rq(this_cpu)->nr_running == 1)
>>>>> +    if ((sync && cpu_rq(this_cpu)->nr_running == 1) ||
>>>>> +        is_short_task(cpu_curr(this_cpu)))
>>
>> Seems it a bit breaks idle (or will be idle) purpose of wake_affine_idle() here. Maybe we can do it something like this?
>>
>> if ((sync || is_short_task(cpu_curr(this_cpu))) && cpu_rq(this_cpu)->nr_running == 1)
> 
> I believe this will still cause performance degradation on split-LLC
> system for Stream like workloads. Based on the logs below, we can
> have a situation as follows:
> 
> 	stream-4135    [029] d..2.   353.580957: select_task_rq_fair: wake_affine_idle: Select this_cpu: sync(0) rq->nr_running(1) is_short_task(1)
> 
> Where sync is 0 but is_short_task() may return 1 and the
> current_rq->nr_running is 1. This will lead to two Stream threads
> getting placed on same LLC during wakeup which will cause cache
> contention and performance degradation.
> 

What I meant was that we should not break the purpose of 
wake_affine_idle(). 'nr_running == 1' makes sure there won't be a long 
queue here, and this might be helpful in the benchmark tests as well. 
Probably the short code section I sent was not considerate.. It's just 
kinda clue.

I see your test result in another mail. It's great and is exactly what I 
was thinking we should test.

Thanks,
Honglei

>>
>> Thanks,
>> Honglei
>>
>>>>
>>>> This change seems to optimize for affine wakeup which benefits
>>>> tasks with producer-consumer pattern but is not ideal for Stream.
>>>> Currently the logic ends will do an affine wakeup even if sync
>>>> flag is not set:
>>>>
>>>>             stream-4135    [029] d..2.   353.580953: sched_waking: comm=stream pid=4129 prio=120 target_cpu=082
>>>>             stream-4135    [029] d..2.   353.580957: select_task_rq_fair: wake_affine_idle: Select this_cpu: sync(0) rq->nr_running(1) is_short_task(1)
>>>>             stream-4135    [029] d..2.   353.580960: sched_migrate_task: comm=stream pid=4129 prio=120 orig_cpu=82 dest_cpu=30
>>>>             <idle>-0       [030] dNh2.   353.580993: sched_wakeup: comm=stream pid=4129 prio=120 target_cpu=030
> 
> This is the exact situation observed during our testing.
> 
>>>>
>>>> [..snip..]
>>>>   
> --
> Thanks and Regards,
> Prateek
