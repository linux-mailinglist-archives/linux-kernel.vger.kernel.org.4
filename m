Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5D6963D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjBNMrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjBNMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:47:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65ED922A12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:47:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBBBD1042;
        Tue, 14 Feb 2023 04:48:06 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46D503F881;
        Tue, 14 Feb 2023 04:47:22 -0800 (PST)
Message-ID: <2d92b035-4bf7-5199-b852-540ff3edee98@arm.com>
Date:   Tue, 14 Feb 2023 13:47:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <9e935645-9baf-af9f-73bd-3eaeaec044a8@arm.com>
 <20230211175052.b7a4hddhkjk4j6qf@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230211175052.b7a4hddhkjk4j6qf@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 18:50, Qais Yousef wrote:
> On 02/09/23 19:02, Dietmar Eggemann wrote:
>> On 07/02/2023 10:45, Vincent Guittot wrote:
>>> On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:

[...]

>>>> Fix the logic by converting the variables into long and treating -1
>>>> value as 'not populated' instead of 0 which is a viable and correct
>>>> spare capacity value.
>>
>> The issue I see here is in case we don't have any spare capacity left,
>> the energy calculation (in terms CPU utilization) isn't correct anymore.
>>
>> Due to `effective_cpu_util()` returning `max=arch_scale_cpu_capacity()`
>> you never know how big the `busy_time` for the PD really is in this moment.
>>
>> eenv_pd_busy_time()
>>
>>   for_each_cpu(cpu, pd_cpus)
>>     busy_time += effective_cpu_util(..., ENERGY_UTIL, ...)
>>     ^^^^^^^^^
>>
>> with:
>>
>>   sum_util = min(busy_time + task_busy_time, pd_cap)
>>                  ^^^^^^^^^
>>
>>   freq = (1.25 * max_util / max) * max_freq
>>
>>   energy = (perf_state(freq)->cost / max) * sum_util
>>
>>
>> energy is not related to CPU utilization anymore (since there is no idle
>> time/spare capacity) left.
> 
> Am I right that what you're saying is that the energy calculation for the PD
> will be capped to a certain value and this is why you think the energy is
> incorrect?
> 
> What should be the correct energy (in theory at least)?

The energy value for the perf_state is correct but the decision based 
on `energy diff` in which PD to put the task might not be.

In case CPUx already has some tasks, its `pd_busy_time` contribution 
is still capped by its capacity_orig.

eenv_pd_busy_time() -> cpu_util_next()
                         return min(util, capacity_orig_of(cpu))

In this case we can't use `energy diff` anymore to make the decision 
where to put the task.

The base_energy of CPUx's PD is already so high that the 
`energy diff = cur_energy - base_energy` is small enough so that CPUx 
is selected as target again.

>> So EAS keeps packing on the cheaper PD/clamped OPP.

Sometimes yes, but there are occurrences in which a big CPU ends up
with the majority of the tasks. It depends on the start condition.

> Which is the desired behavior for uclamp_max?

Not sure. Essentially, EAS can't do its job properly if there is no idle 
time left. As soon as uclamp_max restricts the system (like in my
example) task placement decisions via EAS (min energy diff based) can be
wrong. 

> The only issue I see is that we want to distribute within a pd. Which is
> something I was going to work on and send after later - but can lump it in this
> series if it helps.

I assume you refer to

    } else if ((fits > max_fits) ||
        ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {

here?

>> E.g. Juno-r0 [446 1024 1024 446 446 446] with 6 8ms/16ms uclamp_max=440
>> tasks all running on little PD, cpumask=0x39. The big PD is idle but
>> never beats prev_cpu in terms of energy consumption for the wakee.
> 
> IIUC I'm not seeing this being a problem. The goal of capping with uclamp_max
> is two folds:
> 
> 	1. Prevent tasks from consuming energy.
> 	2. Keep them away from expensive CPUs.

Like I tried to reason about above, the energy diff based task placement
can't always assure this.

> 
> 2 is actually very important for 2 reasons:
> 
> 	a. Because of max aggregation - any uncapped tasks that wakes up will
> 	   cause a frequency spike on this 'expensive' cpu. We don't have
> 	   a mechanism to downmigrate it - which is another thing I'm working
> 	   on.

True. And it can also lead to CPU overutilization which then leads to
load-balancing kicking in.

> 	b. It is desired to keep these bigger cpu idle ready for more important
> 	   work.

But this is not happening all the time. Using the same workload
(6 8ms/16ms uclamp_max=440) on Juno-r0 [446 1024 1024 446 446 446]
sometimes ends up with all 6 tasks on big CPU1.

A corresponding EAS task placement looks like this one:

<idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[1]=0 cpu_util[f|e]=[446 994]  
<idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[2]=0 cpu_util[f|e]=[445 1004]

<idle>-0 [005] select_task_rq_fair: CPU5 cpu=1 busy_time=994 util=994 pd_cap=2048
<idle>-0 [005] select_task_rq_fair: CPU5 cpu=2 busy_time=1998 util=1004 pd_cap=2048

<idle>-0 [005] compute_energy: CPU5 p=[task0-5 2551] cpu=-1 energy=821866 pd_busy_time=1998 task_busy_time=921 max_util=446 busy_time=1998 cpu_cap=1024
<idle>-0 [005] compute_energy: CPU5 p=[task0-5 2551] cpu=1  energy=842434 pd_busy_time=1998 task_busy_time=921 max_util=446 busy_time=2048 cpu_cap=1024
                                                            ^^^^^^^^^^^^^
                                                            diff = 20,568

<idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[0]=0 cpu_util[f|e]=[440 446] 
<idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[3]=0 cpu_util[f|e]=[6 6]
<idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[4]=0 cpu_util[f|e]=[440 446] 
<idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[5]=0 cpu_util[f|e]=[440 446] 

<idle>-0 [005] select_task_rq_fair: CPU5 cpu=0 busy_time=446 util=446 pd_cap=1784
<idle>-0 [005] select_task_rq_fair: CPU5 cpu=3 busy_time=452 util=2 pd_cap=1784
<idle>-0 [005] select_task_rq_fair: CPU5 cpu=4 busy_time=898 util=446 pd_cap=1784
<idle>-0 [005] select_task_rq_fair: CPU5 cpu=5 busy_time=907 util=1 pd_cap=1784

<idle>-0 [005] compute_energy: CPU5 p=[task0-5 2551] cpu=-1 energy=242002 pd_busy_time=907 task_busy_time=921 max_util=440 busy_time=907 cpu_cap=446
<idle>-0 [005] compute_energy: CPU5 p=[task0-5 2551] cpu=5  energy=476000 pd_busy_time=907 task_busy_time=921 max_util=440 busy_time=1784 cpu_cap=446
                                                            ^^^^^^^^^^^^^
                                                            diff = 233,998

<idle>-0 [005] select_task_rq_fair: p=[task0-5 2551] target=1

> For 2, generally we don't want these tasks to steal bandwidth from these CPUs
> that we'd like to preserve for other type of work.
> 
> Of course userspace has control by selecting the right uclamp_max value. They
> can increase it to allow a spill to next pd - or keep it low to steer them more
> strongly on a specific pd.

[...]

