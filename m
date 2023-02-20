Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4167569C5F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBTH0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTH0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:26:12 -0500
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E7D5FE3A1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:26:10 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.64.13])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 6AE5D1100AB036;
        Mon, 20 Feb 2023 15:26:07 +0800 (CST)
Received: from [172.24.140.142] (10.79.65.101) by
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 20 Feb 2023 15:26:06 +0800
Message-ID: <cde76de6-7c47-d5c4-9fa3-4c3707b15328@didichuxing.com>
Date:   Mon, 20 Feb 2023 15:26:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 2/2] sched/fair: Introduce SIS_SHORT to wake up short
 task on current CPU
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 10.79.64.13
From:   Honglei Wang <wanghonglei@didichuxing.com>
In-Reply-To: <Y/L98AVIqkBPVkWG@chenyu5-mobl1>
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



On 2023/2/20 12:58, Chen Yu wrote:
> On 2023-02-17 at 16:35:24 +0800, Honglei Wang wrote:
>>
>>
>> On 2023/2/16 20:55, Abel Wu wrote:
>>> Hi Chen,
>>>
>>> I've tested this patchset (with modification) on our Redis proxy
>>> servers, and the results seems promising.
>>>
>>> On 2/3/23 1:18 PM, Chen Yu wrote:
>>>> ...
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index aa16611c7263..d50097e5fcc1 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -6489,6 +6489,20 @@ static int wake_wide(struct task_struct *p)
>>>>        return 1;
>>>>    }
>>>> +/*
>>>> + * If a task switches in and then voluntarily relinquishes the
>>>> + * CPU quickly, it is regarded as a short duration task.
>>>> + *
>>>> + * SIS_SHORT tries to wake up the short wakee on current CPU. This
>>>> + * aims to avoid race condition among CPUs due to frequent context
>>>> + * switch.
>>>> + */
>>>> +static inline int is_short_task(struct task_struct *p)
>>>> +{
>>>> +    return sched_feat(SIS_SHORT) && p->se.dur_avg &&
>>>> +           ((p->se.dur_avg * 8) < sysctl_sched_min_granularity);
>>>> +}
>>>
>>> I changed the factor to fit into the shape of tasks in question.
>>>
>>>       static inline int is_short_task(struct task_struct *p)
>>>       {
>>>           u64 dur = sysctl_sched_min_granularity / 8;
>>>
>>>           if (!sched_feat(SIS_SHORT) || !p->se.dur_avg)
>>>               return false;
>>>
>>>           /*
>>>            * Bare tracepoint to allow dynamically changing
>>>            * the threshold.
>>>            */
>>>           trace_sched_short_task_tp(p, &dur);
>>>
>>>           return p->se.dur_avg < dur;
>>>       }
>>>
>>> I'm not sure it is the right way to provide such flexibility, but
>>> definition of 'short' can be workload specific.
>>>
>>>> +
>>>>    /*
>>>>     * The purpose of wake_affine() is to quickly determine on which
>>>> CPU we can run
>>>>     * soonest. For the purpose of speed we only consider the waking
>>>> and previous
>>>> @@ -6525,6 +6539,11 @@ wake_affine_idle(int this_cpu, int prev_cpu,
>>>> int sync)
>>>>        if (available_idle_cpu(prev_cpu))
>>>>            return prev_cpu;
>>>> +    /* The only running task is a short duration one. */
>>>> +    if (cpu_rq(this_cpu)->nr_running == 1 &&
>>>> +        is_short_task(rcu_dereference(cpu_curr(this_cpu))))
>>>> +        return this_cpu;
>>>
>>> Since proxy server handles simple data delivery, the tasks are
>>> generally short running ones and hate task stacking which may
>>> introduce scheduling latency (even there are only 2 short tasks
>>> competing each other). So this part brings slight regression on
>>> the proxy case. But I still think this is good for most cases.
>>>
>>> Speaking of task stacking, I found wake_affine_weight() can be
>>> much more dangerous. It chooses the less loaded one between the
>>> prev & this cpu as a candidate, so 'small' tasks can be easily
>>> stacked on this cpu when wake up several tasks at one time if
>>> this cpu is unloaded. This really hurts if the 'small' tasks are
>>> latency-sensitive, although wake_affine_weight() does the right
>>> thing from the point of view of 'load'.
>>>
>>> The following change greatly reduced the p99lat of Redis service
>>> from 150ms to 0.9ms, at exactly the same throughput (QPS).
>>>
>>> @@ -5763,6 +5787,9 @@ wake_affine_weight(struct sched_domain *sd, struct
>>> task_struct *p,
>>>       s64 this_eff_load, prev_eff_load;
>>>       unsigned long task_load;
>>>
>>> +    if (is_short_task(p))
>>> +        return nr_cpumask_bits;
>>> +
>>>       this_eff_load = cpu_load(cpu_rq(this_cpu));
>>>
>>>       if (sync) {
>>>
>>> I know that 'short' tasks are not necessarily 'small' tasks, e.g.
>>> sleeping duration is small or have large weights, but this works
>>> really well for this case. This is partly because delivering data
>>> is memory bandwidth intensive hence prefer cache hot cpus. And I
>>> think this is also applicable to the general purposes: do NOT let
>>> the short running tasks suffering from cache misses caused by
>>> migration.
>>>
>>
>> Redis is a bit special. It runs quick and really sensitive on schedule
>> latency. The purpose of this 'short task' feature from Yu is to mitigate the
>> migration and tend to place the waking task on local cpu, this is somehow on
>> the opposite side of workload such as Redis. The changes you did remind me
>> of the latency-prio stuff. Maybe we can do something base on both the 'short
>> task' and 'latency-prio' to make your changes more general. thoughts?
>>
> Looks reasonable, I suppose you were refering to 'latency nice' proposed by
> Vincent. For now I'd like to keep this patch simple enough, later we can
> extend it.
> 

Yep, agree to keep this patch as is for now.

Thanks,
Honglei

> thanks,
> Chenyu
