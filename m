Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870F25F9C78
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiJJKMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiJJKMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:12:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77B1167145;
        Mon, 10 Oct 2022 03:12:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BCD61480;
        Mon, 10 Oct 2022 03:12:15 -0700 (PDT)
Received: from [10.57.5.39] (unknown [10.57.5.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DE2D3F792;
        Mon, 10 Oct 2022 03:12:07 -0700 (PDT)
Message-ID: <9611971c-d8dd-7877-6f50-c5afbf38b171@arm.com>
Date:   Mon, 10 Oct 2022 11:12:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] cpufreq: Update CPU capacity reduction in
 store_scaling_max_freq()
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, Dietmar.Eggemann@arm.com,
        peterz@infradead.org
References: <20220930094821.31665-1-lukasz.luba@arm.com>
 <20220930094821.31665-2-lukasz.luba@arm.com>
 <20221010053902.5rofnpzvyynumw3e@vireshk-i7>
 <3f9a4123-171b-5fa7-f506-341355f71483@arm.com>
 <CAKfTPtBPqcTm5_-M_Ka3y46yQ2322TmH8KS-QyDbAiKk5B6hEQ@mail.gmail.com>
 <8a7968c2-dbf7-5316-ef36-6d45143e0605@arm.com>
 <CAKfTPtB3Lk5bc9k634O+Yi8wwP=MVeKS5NPbpaqwhX1F4t5EbA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAKfTPtB3Lk5bc9k634O+Yi8wwP=MVeKS5NPbpaqwhX1F4t5EbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/22 10:32, Vincent Guittot wrote:
> On Mon, 10 Oct 2022 at 11:30, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 10/10/22 10:15, Vincent Guittot wrote:
>>> On Mon, 10 Oct 2022 at 11:02, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 10/10/22 06:39, Viresh Kumar wrote:
>>>>> Would be good to always CC Scheduler maintainers for such a patch.
>>>>
>>>> Agree, I'll do that.
>>>>
>>>>>
>>>>> On 30-09-22, 10:48, Lukasz Luba wrote:
>>>>>> When the new max frequency value is stored, the task scheduler must
>>>>>> know about it. The scheduler uses the CPUs capacity information in the
>>>>>> task placement. Use the existing mechanism which provides information
>>>>>> about reduced CPU capacity to the scheduler due to thermal capping.
>>>>>>
>>>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>>> ---
>>>>>>     drivers/cpufreq/cpufreq.c | 18 +++++++++++++++++-
>>>>>>     1 file changed, 17 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>>>> index 1f8b93f42c76..205d9ea9c023 100644
>>>>>> --- a/drivers/cpufreq/cpufreq.c
>>>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>>>> @@ -27,6 +27,7 @@
>>>>>>     #include <linux/slab.h>
>>>>>>     #include <linux/suspend.h>
>>>>>>     #include <linux/syscore_ops.h>
>>>>>> +#include <linux/thermal.h>
>>>>>>     #include <linux/tick.h>
>>>>>>     #include <linux/units.h>
>>>>>>     #include <trace/events/power.h>
>>>>>> @@ -718,6 +719,8 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>>>>>>     static ssize_t store_scaling_max_freq
>>>>>>     (struct cpufreq_policy *policy, const char *buf, size_t count)
>>>>>>     {
>>>>>> +    unsigned int frequency;
>>>>>> +    struct cpumask *cpus;
>>>>>>        unsigned long val;
>>>>>>        int ret;
>>>>>>
>>>>>> @@ -726,7 +729,20 @@ static ssize_t store_scaling_max_freq
>>>>>>                return -EINVAL;
>>>>>>
>>>>>>        ret = freq_qos_update_request(policy->max_freq_req, val);
>>>>>> -    return ret >= 0 ? count : ret;
>>>>>> +    if (ret >= 0) {
>>>>>> +            /*
>>>>>> +             * Make sure that the task scheduler sees these CPUs
>>>>>> +             * capacity reduction. Use the thermal pressure mechanism
>>>>>> +             * to propagate this information to the scheduler.
>>>>>> +             */
>>>>>> +            cpus = policy->related_cpus;
>>>>>
>>>>> No need of this, just use related_cpus directly.
>>>>>
>>>>>> +            frequency = __resolve_freq(policy, val, CPUFREQ_RELATION_HE);
>>>>>> +            arch_update_thermal_pressure(cpus, frequency);
>>>>>
>>>>> I wonder if using the thermal-pressure API here is the right thing to
>>>>> do. It is a change coming from User, which may or may not be
>>>>> thermal-related.
>>>>
>>>> Yes, I thought the same. Thermal-pressure name might be not the
>>>> best for covering this use case. I have been thinking about this
>>>> thermal pressure mechanism for a while, since there are other
>>>> use cases like PowerCap DTPM which also reduces CPU capacity
>>>> because of power policy from user-space. We don't notify
>>>> the scheduler about it. There might be also an issue with virtual
>>>> guest OS and how that kernel 'sees' the capacity of CPUs.
>>>> We might try to use this 'thermal-pressure' in the guest kernel
>>>> to notify about available CPU capacity (just a proposal, not
>>>> even an RFC, since we are missing requirements, but issues where
>>>> discussed on LPC 2022 on ChromeOS+Android_guest)
>>>
>>> The User space setting scaling_max_freq is a long scale event and it
>>> should be considered as a new running environnement instead of a
>>> transient event. I would suggest updating the EM is and capacity orig
>>> of the system in this case. Similarly, we rebuild sched_domain with a
>>> cpu hotplug. scaling_max_freq interface should not be used to do any
>>> kind of dynamic scaling.
>>
>> I tend to agree, but the EM capacity would be only used in part of EAS
>> code. The whole fair.c view to the capacity_of() (RT + DL + irq +
>> thermal_pressure) would be still wrong in other parts, e.g.
>> select_idle_sibling() and load balance.
>>
>> When we get this powerhint we might be already in overutilied state
>> so EAS is disabled. IMO other mechanisms in the task scheduler
>> should be also aware of that capacity reduction.
> 
> That's why I also mentioned the capacity_orig

Well, I think this is a bit more complex. Thermal framework governor
reduces the perf IDs from top in the freq asc table and keeps that
in the statistics in sysfs. It also updates the thermal pressure signal.
When we rebuild the capacity of CPUs and make the capacity_orig smaller,
the capacity_of would still have the thermal framework reduced capacity
in there. We would end up with too small CPU capacity due to this
subtraction in capacity_of.

Ideally, I would see a mechanism which is aware of this performance
reduction reason:
1. thermal capping
2. power capping (from DTPM)
3. max freq reduction by user space

That common place would figure and maintain the context for the
requested capacity reduction.

BTW, those Android user space max freq requests are not that long,
mostly due to camera capturing (you can see a few in this file,
e.g. [1]).


[1] 
https://android.googlesource.com/device/google/gs101/+/refs/heads/android12-qpr1-d-release/powerhint.json#441
