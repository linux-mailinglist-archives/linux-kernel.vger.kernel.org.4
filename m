Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A540170B7A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjEVIbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjEVIbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:31:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAEC919D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:30:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A672B2F4;
        Mon, 22 May 2023 01:30:58 -0700 (PDT)
Received: from [10.57.22.146] (unknown [10.57.22.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED8E33F59C;
        Mon, 22 May 2023 01:30:11 -0700 (PDT)
Message-ID: <48db3f08-a066-c078-bfc9-bf20f66e067a@arm.com>
Date:   Mon, 22 May 2023 09:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <9e935645-9baf-af9f-73bd-3eaeaec044a8@arm.com>
 <20230211175052.b7a4hddhkjk4j6qf@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230211175052.b7a4hddhkjk4j6qf@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

I have a question regarding the 'soft cpu affinity'.

On 2/11/23 17:50, Qais Yousef wrote:
> On 02/09/23 19:02, Dietmar Eggemann wrote:
>> On 07/02/2023 10:45, Vincent Guittot wrote:
>>> On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:
>>>>
>>>> When uclamp_max is being used, the util of the task could be higher than
>>>> the spare capacity of the CPU, but due to uclamp_max value we force fit
>>>> it there.
>>>>
>>>> The way the condition for checking for max_spare_cap in
>>>> find_energy_efficient_cpu() was constructed; it ignored any CPU that has
>>>> its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
>>>> max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
>>>> hence ending up never performing compute_energy() for this cluster and
>>>> missing an opportunity for a better energy efficient placement to honour
>>>> uclamp_max setting.
>>>>
>>>>          max_spare_cap = 0;
>>>>          cpu_cap = capacity_of(cpu) - task_util(p);  // 0 if task_util(p) is high
>>>>
>>>>          ...
>>>>
>>>>          util_fits_cpu(...);             // will return true if uclamp_max forces it to fit
>>
>> s/true/1/ ?
>>
>>>>
>>>>          ...
>>>>
>>>>          // this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
>>>>          if (cpu_cap > max_spare_cap) {
>>>>                  max_spare_cap = cpu_cap;
>>>>                  max_spare_cap_cpu = cpu;
>>>>          }
>>>>
>>>> prev_spare_cap suffers from a similar problem.
>>>>
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
>>    for_each_cpu(cpu, pd_cpus)
>>      busy_time += effective_cpu_util(..., ENERGY_UTIL, ...)
>>      ^^^^^^^^^
>>
>> with:
>>
>>    sum_util = min(busy_time + task_busy_time, pd_cap)
>>                   ^^^^^^^^^
>>
>>    freq = (1.25 * max_util / max) * max_freq
>>
>>    energy = (perf_state(freq)->cost / max) * sum_util
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
> 
>>
>> So EAS keeps packing on the cheaper PD/clamped OPP.
> 
> Which is the desired behavior for uclamp_max?
> 
> The only issue I see is that we want to distribute within a pd. Which is
> something I was going to work on and send after later - but can lump it in this
> series if it helps.
> 
>>
>> E.g. Juno-r0 [446 1024 1024 446 446 446] with 6 8ms/16ms uclamp_max=440
>> tasks all running on little PD, cpumask=0x39. The big PD is idle but
>> never beats prev_cpu in terms of energy consumption for the wakee.
> 
> IIUC I'm not seeing this being a problem. The goal of capping with uclamp_max
> is two folds:
> 
> 	1. Prevent tasks from consuming energy.
> 	2. Keep them away from expensive CPUs.
> 
> 2 is actually very important for 2 reasons:
> 
> 	a. Because of max aggregation - any uncapped tasks that wakes up will
> 	   cause a frequency spike on this 'expensive' cpu. We don't have
> 	   a mechanism to downmigrate it - which is another thing I'm working
> 	   on.
> 	b. It is desired to keep these bigger cpu idle ready for more important
> 	   work.
> 
> For 2, generally we don't want these tasks to steal bandwidth from these CPUs
> that we'd like to preserve for other type of work.

I'm a bit afraid about such 'strong force'. That means the task would
not go via EAS if we set uclamp_max e.g. 90, while the little capacity
is 125. Or am I missing something?

This might effectively use more energy for those tasks which can run on
any CPU and EAS would figure a good energy placement. I'm worried
about this, since we have L3+littles in one DVFS domain and the L3
would be only bigger in future.

IMO to keep the big cpus more in idle, we should give them big energy
wake up cost. That's my 3rd feature to the EM presented in OSPM2023.

> 
> Of course userspace has control by selecting the right uclamp_max value. They
> can increase it to allow a spill to next pd - or keep it low to steer them more
> strongly on a specific pd.

This would we be interesting to see in practice. I think we need such
experiment, for such changes.

Regards,
Lukasz
