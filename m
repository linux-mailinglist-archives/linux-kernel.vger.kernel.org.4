Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7141A646DC4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiLHLBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiLHLA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:00:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A532A11445;
        Thu,  8 Dec 2022 02:56:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AC2D23A;
        Thu,  8 Dec 2022 02:56:16 -0800 (PST)
Received: from [10.57.9.192] (unknown [10.57.9.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE9763F73B;
        Thu,  8 Dec 2022 02:56:06 -0800 (PST)
Message-ID: <4a648e81-e529-e09c-ed8b-10b703f1c305@arm.com>
Date:   Thu, 8 Dec 2022 10:56:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] cpufreq: schedutil: Optimize operations with
 single max CPU capacity
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, saravanak@google.com,
        wusamuel@google.com, isaacmanjarres@google.com,
        kernel-team@android.com, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, viresh.kumar@linaro.org
References: <20221207101705.9460-1-lukasz.luba@arm.com>
 <20221207101705.9460-3-lukasz.luba@arm.com>
 <CAKfTPtB8f0RH4qToLrWS+HSZhm8pyUe42DijiXZqo+mQQPWetQ@mail.gmail.com>
 <7428f6dd-9403-180b-d4b4-7ef1aee3dcb1@arm.com>
 <CAKfTPtDoZ2paL7DW+JsML8aKeVzwu4oSnojij1osqJzNhO4ceA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAKfTPtDoZ2paL7DW+JsML8aKeVzwu4oSnojij1osqJzNhO4ceA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/22 10:31, Vincent Guittot wrote:
> On Thu, 8 Dec 2022 at 11:06, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 12/8/22 08:37, Vincent Guittot wrote:
>>> On Wed, 7 Dec 2022 at 11:17, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>> The max CPU capacity is the same for all CPUs sharing frequency domain
>>>> and thus 'policy' object. There is a way to avoid heavy operations
>>>> in a loop for each CPU by leveraging this knowledge. Thus, simplify
>>>> the looping code in the sugov_next_freq_shared() and drop heavy
>>>> multiplications. Instead, use simple max() to get the highest utilization
>>>> from these CPUs. This is useful for platforms with many (4 or 6) little
>>>> CPUs.
>>>>
>>>> The max CPU capacity must be fetched every time we are called, due to
>>>> difficulties during the policy setup, where we are not able to get the
>>>> normalized CPU capacity at the right time.
>>>>
>>>> The stored value in sugov_policy::max is also than used in
>>>> sugov_iowait_apply() to calculate the right boost. Thus, that field is
>>>> useful to have in that sugov_policy struct.
>>>>
>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>> ---
>>>>    kernel/sched/cpufreq_schedutil.c | 22 +++++++++++-----------
>>>>    1 file changed, 11 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>>>> index c19d6de67b7a..f9881f3d9488 100644
>>>> --- a/kernel/sched/cpufreq_schedutil.c
>>>> +++ b/kernel/sched/cpufreq_schedutil.c
>>>> @@ -158,10 +158,8 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>>>>
>>>>    static void sugov_get_util(struct sugov_cpu *sg_cpu)
>>>>    {
>>>> -       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>>>>           struct rq *rq = cpu_rq(sg_cpu->cpu);
>>>>
>>>> -       sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
>>>>           sg_cpu->bw_dl = cpu_bw_dl(rq);
>>>>           sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
>>>>                                             FREQUENCY_UTIL, NULL);
>>>> @@ -317,6 +315,8 @@ static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
>>>>    static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>>>>                                                 u64 time, unsigned int flags)
>>>>    {
>>>> +       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>>>> +
>>>>           sugov_iowait_boost(sg_cpu, time, flags);
>>>>           sg_cpu->last_update = time;
>>>>
>>>> @@ -325,6 +325,9 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>>>>           if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
>>>>                   return false;
>>>>
>>>> +       /* Fetch the latest CPU capcity to avoid stale data */
>>>> +       sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
>>>> +
>>>>           sugov_get_util(sg_cpu);
>>>>           sugov_iowait_apply(sg_cpu, time);
>>>>
>>>> @@ -414,25 +417,22 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>>>>    {
>>>>           struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>>>>           struct cpufreq_policy *policy = sg_policy->policy;
>>>> -       unsigned long util = 0, max = 1;
>>>> +       unsigned long util = 0;
>>>>           unsigned int j;
>>>>
>>>> +       /* Fetch the latest CPU capcity to avoid stale data */
>>>> +       sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
>>>> +
>>>>           for_each_cpu(j, policy->cpus) {
>>>>                   struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
>>>> -               unsigned long j_util, j_max;
>>>>
>>>>                   sugov_get_util(j_sg_cpu);
>>>>                   sugov_iowait_apply(j_sg_cpu, time);
>>>> -               j_util = j_sg_cpu->util;
>>>> -               j_max = j_sg_cpu->max;
>>>>
>>>> -               if (j_util * max > j_max * util) {
>>>> -                       util = j_util;
>>>> -                       max = j_max;
>>>> -               }
>>>
>>> With the code removed above, max is only used in 2 places:
>>> - sugov_iowait_apply
>>> - map_util_freq
>>>
>>> I wonder if it would be better to just call arch_scale_cpu_capacity()
>>> in these 2 places instead of saving a copy in sg_policy and then
>>> reading it twice.
>>
>> The sugov_iowait_apply() is called in that loop, so probably I will
>> add a new argument to that call and just feed it with the capacity value
>> from one CPU, which was read before the loop. So, similarly what is in
>> this patch. Otherwise, all of those per-cpu capacity vars would be
>> accessed inside the sugov_iowait_apply() with sg_cpu->cpu.
> 
> Yes make sense
> 
>>
>>>
>>> arch_scaleu_cpu_capacity is already a per_cpu variable so accessing it
>>> should be pretty cheap.
>>
>> Yes and no, as you said this is per-cpu variable and would access them
>> from one CPU, which is running that loop. They will have different pages
>> and addresses so cache lines on that CPU. to avoiding trashing a cache
>> lines on this running CPU let's read that capacity once, before the
>> loop. Let's use the new arg to pass that value via one of the
>> registers. In such, only one cache line would have to fetch that data
>> into.
>>
>> So I thought this simple sg_policy->max would do the trick w/o a lot
>> of hassle.
> 
> For the shared mode, everything is located in sugov_next_freq_shared
> so you don't need to save the max value with your proposal above to
> change sugov_iowait_apply interface.
> 
> This should be doable as well for single mode
> 
>>>
>>> Thought ?
>>>
>>
>> I can change that and drop the sg_policy->max and call differently
>> those capacity values. I will have to unfortunately drop Viresh's ACKs,
>> since this will be a way different code.
>>
>> Thanks Vincent for the suggestion. Do you want me to go further with
>> such approach and send a v3?
> 
> Don't know what Rafael and Viresh think but it seems that we don't
> need to save the return of arch_scale_cpu_capacity in ->max field but
> directly use it

Yes I agree, we don't need to, but I will have to modify a few function
calls and args.

So IMO we have agreed. I won't call the call arch_scale_cpu_capacity()
in these 2 places, but I will make it with the local var and data
fetched as little as possible.
