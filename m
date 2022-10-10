Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A70B5F9B96
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiJJJCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiJJJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:02:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64FE81127;
        Mon, 10 Oct 2022 02:02:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B1041480;
        Mon, 10 Oct 2022 02:02:36 -0700 (PDT)
Received: from [10.57.5.39] (unknown [10.57.5.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFA6D3F792;
        Mon, 10 Oct 2022 02:02:28 -0700 (PDT)
Message-ID: <3f9a4123-171b-5fa7-f506-341355f71483@arm.com>
Date:   Mon, 10 Oct 2022 10:02:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] cpufreq: Update CPU capacity reduction in
 store_scaling_max_freq()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, Dietmar.Eggemann@arm.com,
        peterz@infradead.org, Vincent Guittot <vincent.guittot@linaro.org>
References: <20220930094821.31665-1-lukasz.luba@arm.com>
 <20220930094821.31665-2-lukasz.luba@arm.com>
 <20221010053902.5rofnpzvyynumw3e@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20221010053902.5rofnpzvyynumw3e@vireshk-i7>
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



On 10/10/22 06:39, Viresh Kumar wrote:
> Would be good to always CC Scheduler maintainers for such a patch.

Agree, I'll do that.

> 
> On 30-09-22, 10:48, Lukasz Luba wrote:
>> When the new max frequency value is stored, the task scheduler must
>> know about it. The scheduler uses the CPUs capacity information in the
>> task placement. Use the existing mechanism which provides information
>> about reduced CPU capacity to the scheduler due to thermal capping.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 1f8b93f42c76..205d9ea9c023 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/suspend.h>
>>   #include <linux/syscore_ops.h>
>> +#include <linux/thermal.h>
>>   #include <linux/tick.h>
>>   #include <linux/units.h>
>>   #include <trace/events/power.h>
>> @@ -718,6 +719,8 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>>   static ssize_t store_scaling_max_freq
>>   (struct cpufreq_policy *policy, const char *buf, size_t count)
>>   {
>> +	unsigned int frequency;
>> +	struct cpumask *cpus;
>>   	unsigned long val;
>>   	int ret;
>>   
>> @@ -726,7 +729,20 @@ static ssize_t store_scaling_max_freq
>>   		return -EINVAL;
>>   
>>   	ret = freq_qos_update_request(policy->max_freq_req, val);
>> -	return ret >= 0 ? count : ret;
>> +	if (ret >= 0) {
>> +		/*
>> +		 * Make sure that the task scheduler sees these CPUs
>> +		 * capacity reduction. Use the thermal pressure mechanism
>> +		 * to propagate this information to the scheduler.
>> +		 */
>> +		cpus = policy->related_cpus;
> 
> No need of this, just use related_cpus directly.
> 
>> +		frequency = __resolve_freq(policy, val, CPUFREQ_RELATION_HE);
>> +		arch_update_thermal_pressure(cpus, frequency);
> 
> I wonder if using the thermal-pressure API here is the right thing to
> do. It is a change coming from User, which may or may not be
> thermal-related.

Yes, I thought the same. Thermal-pressure name might be not the
best for covering this use case. I have been thinking about this
thermal pressure mechanism for a while, since there are other
use cases like PowerCap DTPM which also reduces CPU capacity
because of power policy from user-space. We don't notify
the scheduler about it. There might be also an issue with virtual
guest OS and how that kernel 'sees' the capacity of CPUs.
We might try to use this 'thermal-pressure' in the guest kernel
to notify about available CPU capacity (just a proposal, not
even an RFC, since we are missing requirements, but issues where
discussed on LPC 2022 on ChromeOS+Android_guest)

Android middleware has 'powerhits' (IIRC since ~4-5 versions now)
but our capacity in task scheduler is not aware of those reductions.

IMO thermal-pressure mechanism is good, but the naming convention
just might be a bit more 'generic' to cover those two users.

Some proposals of better naming:
1. Performance capping
2. Capacity capping
3. Performance reduction

What do you think about changing the name of this and cover
those two users: PowerCap DTPM and this user-space cpufreq?
