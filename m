Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC369E035
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjBUMVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjBUMVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:21:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A0B021942
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:21:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D79C3106F;
        Tue, 21 Feb 2023 04:21:39 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D78D3F703;
        Tue, 21 Feb 2023 04:20:54 -0800 (PST)
Message-ID: <a7f9fea0-debf-3774-7367-2e842895669c@arm.com>
Date:   Tue, 21 Feb 2023 13:20:48 +0100
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
 <2d92b035-4bf7-5199-b852-540ff3edee98@arm.com>
 <20230214180950.fkcpoirtjgpp3kys@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230214180950.fkcpoirtjgpp3kys@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 19:09, Qais Yousef wrote:
> On 02/14/23 13:47, Dietmar Eggemann wrote:
>> On 11/02/2023 18:50, Qais Yousef wrote:
>>> On 02/09/23 19:02, Dietmar Eggemann wrote:
>>>> On 07/02/2023 10:45, Vincent Guittot wrote:
>>>>> On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:

[...]

>>
>> The energy value for the perf_state is correct but the decision based 
>> on `energy diff` in which PD to put the task might not be.
>>
>> In case CPUx already has some tasks, its `pd_busy_time` contribution 
>> is still capped by its capacity_orig.
>>
>> eenv_pd_busy_time() -> cpu_util_next()
>>                          return min(util, capacity_orig_of(cpu))
>>
>> In this case we can't use `energy diff` anymore to make the decision 
>> where to put the task.
>>
>> The base_energy of CPUx's PD is already so high that the 
>> `energy diff = cur_energy - base_energy` is small enough so that CPUx 
>> is selected as target again.
> 
> I'm sorry bear with me as I'm still struggling to fully understand the case.
> 
> You're thinking that if all the CPUs in the pd are _already_ fully busy before
> adding this newly woken up task there, then we'll end up with the wrong
> energy_diff? IOW, when the pd is fully loaded, then the cost of adding extra
> load will always look cheap is what you're saying?

Sort of. The key to this is:

  compute_energy()

    if (dst_cpu >= 0)
     busy_time = min(pd_capacity, pd_busy_time + task_busy_time);
                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                  pd + task contribution

If `pd + task contribution` > `pd_capacity` then we're saturated and the
energy diff is bogus. This includes the case in which `pd contribution`
> `pd_capacity`.

>>>> So EAS keeps packing on the cheaper PD/clamped OPP.
>>
>> Sometimes yes, but there are occurrences in which a big CPU ends up
>> with the majority of the tasks. It depends on the start condition.
> 
> It should depend on the energy cost, yes. Which does depend on the current
> state of the system.

I analyzed one of the last traces I got with my example:

During the initial wakeup the system is in CPU OU. So feec() returns
`target = -1` and `sis()->sic()` (a) does the initial placement for all
the 6 tasks.

CPU  (a)     (b) (c) (d)    (e)
      ^       ^   ^   ^      ^
 0   t1-------->| |
 1   t0 t3    |t5 |t1 |t4|   |   |   |   | ...
 2   t2--------------------->|
 3
 4   t4------------>| |
 5   t5---->| |

(b) feec() for t5:

    eenv_pd_busy_time()

      pd_busy_time = 1998 = 994 (CPU1) + 1004 (CPU2)

    compute_energy()

      busy_time = min(pd_capacity, pd_busy_time + task_busy_time)

                = min(2048, 1998 + 921)

                = 2048

    We go into saturation here and EAS assumes it can place t5 for the
    cost of 2048 - 1998 = 50 util where in reality t5 has a util of
    ~921. And that's why t5 ends up on CPU1 too.

(c) & (d) similar to (b)

(e) From here on no wakeups anymore. Only tick preemption on CPU1 every
    4ms (250Hz) between the 5 tasks and t2 finishing on CPU2 eventually.

>>> Which is the desired behavior for uclamp_max?
>>
>> Not sure. Essentially, EAS can't do its job properly if there is no idle 
> 
> This "not sure" statement is making me worried. Are you not sure about how
> uclamp_max should work in force fitting big tasks into small cores? Or just
> about handling some of the corner cases? I understood the former, not the
> latter.

I'm not sure if we can call the issue that EAS doesn't work in
saturation anymore a corner case. In case uclamp_max has an effect, it
can quite easily create these saturation scenarios in which EAS is still
enabled but it can't do its job anymore.
Making sure that we probe each PD is not getting rid of this more
fundamental issue.

>> time left. As soon as uclamp_max restricts the system (like in my
>> example) task placement decisions via EAS (min energy diff based) can be
>> wrong. 
> 
> I'm assuming 'no idle time' refers to the pd being fully loaded already
> _before_ placing the newly woken up task. If you refer to it not having idle
> time _after_ placing it - then I'm confused as one of the goals of uclamp_max
> is to act as a task placement hint and if it can't do that in this simple

We can't consider an individual task here. After placing `t0` might be
before placing `t1` for which we might then run into this saturation.

> scenarios, it won't be much useful? I can appreciate it failing at some corner
> cases. But for example if a little core is idle and a 1024 task wakes up with
> uclamp_max that makes the little a candidate; then yeah it'll not leave any
> idle time on that cpu - but placing it there (if it the energy efficient cpu)
> is the desired effect, no?

Not having idle time means EAS can't do its job properly and uclamp_max
can create these scenarios.

>>> The only issue I see is that we want to distribute within a pd. Which is
>>> something I was going to work on and send after later - but can lump it in this
>>> series if it helps.
>>
>> I assume you refer to
>>
>>     } else if ((fits > max_fits) ||
>>         ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
>>
>> here?
> 
> Yes. If there are multiple cpus with the same max_spare_cap maybe we can
> distribute among them rather than always pick the first one.

This can mitigate the issue but not solve it.

[...]

>>> 	b. It is desired to keep these bigger cpu idle ready for more important
>>> 	   work.
>>
>> But this is not happening all the time. Using the same workload
>> (6 8ms/16ms uclamp_max=440) on Juno-r0 [446 1024 1024 446 446 446]
>> sometimes ends up with all 6 tasks on big CPU1.
> 
> This seems similar to a case I see on pinebook pro but with uclamp_min.
> 
> $ grep '' /sys/devices/system/cpu/cpu*/cpu_capacity
> /sys/devices/system/cpu/cpu0/cpu_capacity:381
> /sys/devices/system/cpu/cpu1/cpu_capacity:381
> /sys/devices/system/cpu/cpu2/cpu_capacity:381
> /sys/devices/system/cpu/cpu3/cpu_capacity:381
> /sys/devices/system/cpu/cpu4/cpu_capacity:1024
> /sys/devices/system/cpu/cpu5/cpu_capacity:1024
> 
> ts, dst_cpu, p_util, uclamp_min, uclamp_max, energy
> 253049258065, 4, 0, 381, 1024, 10562
> 253049269732, 3, 0, 381, 1024, 18814

So the energy after placing p on CPU4 (big) is lower than placing it on
CPU3 (LITTLE). But to see the energy-diff we would need to see the base
energy (dst_cpu = -1) as well.

Why is p_util = 0 here?

> 253065609673, 4, 0, 381, 1024, 10562
> 253065621340, 3, 0, 381, 1024, 17874

[..]

> 
> With uclamp_max energy looks different, but p_util is different too which has
> impact on compute_energy() calculations

p_util is p->se.avg.util_avg here?

> ts, dst_cpu, p_util, uclamp_min, uclamp_max, energy
> 760154735422179, 4, 407, 0, 381, 237058
> 760154735426845, 0, 407, 0, 381, 192382
> 
> I'm not sure if there's an error in compute_energy to be honest - but as you
> said depends on the conditions of the system the most energy efficient cpu
> could be different.
> 
> Without this patch we don't even call compute_energy() for the little core; but
> now it is a viable candidate.

Understood. But this doesn't fix the `EAS not working under saturation
problem`.

>> A corresponding EAS task placement looks like this one:
>>
>> <idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[1]=0 cpu_util[f|e]=[446 994]  
>> <idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[2]=0 cpu_util[f|e]=[445 1004]
>>
>> <idle>-0 [005] select_task_rq_fair: CPU5 cpu=1 busy_time=994 util=994 pd_cap=2048
>> <idle>-0 [005] select_task_rq_fair: CPU5 cpu=2 busy_time=1998 util=1004 pd_cap=2048
>>
>> <idle>-0 [005] compute_energy: CPU5 p=[task0-5 2551] cpu=-1 energy=821866 pd_busy_time=1998 task_busy_time=921 max_util=446 busy_time=1998 cpu_cap=1024
>> <idle>-0 [005] compute_energy: CPU5 p=[task0-5 2551] cpu=1  energy=842434 pd_busy_time=1998 task_busy_time=921 max_util=446 busy_time=2048 cpu_cap=1024
>>                                                             ^^^^^^^^^^^^^
>>                                                             diff = 20,568
> 
> This is not necessarily a problem, unless the energy calculations are wrong of
> course.

The problem is that placing p=[task0-5 2551] 'costs' only the
energy-equivalence of 2048-1998 = 50 util instead of 921.
> 
> Setting uclamp_max near the top capacity of the littles will hopefully make it
> run there more often - but we know that the top frequencies of the little are
> not necessarily efficient ones too.
> 
> Does lowering uclamp_max more towards the 'knee' of the little help keeping the
> tasks there?
> 
> Note what this patch does is make sure that the little is a 'candidate'. Energy
> efficiency is the ultimate choice of which candidate cpu/pd to pick.
> 
> Being more strict about uclamp_max choice might be necessary if there's
> a stronger desire by userspace to keep the tasks on specific cluster.
> 
> If there're errors in calculating energy, I'd appreciate your help on how to
> resolve them.

I don't think there is an error in the energy calculation.
But EAS doesn't work properly in these saturation cases which uclamp_max
can create. And considering each PD won't solve this. I'm afraid we do
need a solution for this saturation issue.
