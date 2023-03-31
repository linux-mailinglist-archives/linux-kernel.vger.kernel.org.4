Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1806D1D22
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjCaJzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjCaJyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:54:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE3B0C648;
        Fri, 31 Mar 2023 02:53:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7B692F4;
        Fri, 31 Mar 2023 02:54:28 -0700 (PDT)
Received: from [10.57.20.151] (unknown [10.57.20.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DB743F6C4;
        Fri, 31 Mar 2023 02:53:42 -0700 (PDT)
Message-ID: <b9e94d15-ee49-aa8c-e0fb-1243a91825cd@arm.com>
Date:   Fri, 31 Mar 2023 11:53:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Yang Shi <yang@os.amperecomputing.com>
Cc:     rafael@kernel.org, scott@os.amperecomputing.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, lukasz.luba@arm.com,
        ionela.voinescu@arm.com
References: <20230328193846.8757-1-yang@os.amperecomputing.com>
 <20230330035612.ekh2lpqzohggg6uf@vireshk-i7>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230330035612.ekh2lpqzohggg6uf@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 3/30/23 05:56, Viresh Kumar wrote:
> + few folks.
> 
> On 28-03-23, 12:38, Yang Shi wrote:
>> When testing CPPC cpufreq on our platform, we noticed the error may be quite
>> high and the high error may happen quite often.  For example, on a platform
>> with a maximum frequency of 2.8GHz when the CPUs were fully loaded (100% load),
>> we saw cpuinfo_cur_freq may show 4GHz, it means the error is > 40%.  And the
>> high error (> 1%) happened 256 times out of 2127 samples (sampled every 3
>> seconds) in an approximate 2hrs test.
>>
>> We tried to enlarge the delay, and tested with 100us, 1ms and 10ms.  The
>> below is the results.
>>
>> 100us:
>> The highest error is 4GHz, 22 times out of 3623 samples
>>
>> 1ms:
>> The highest error is 3.3GHz, 3 times out of 2814 samples
>>
>> 10ms:
>> No high error anymore
>>
>> Increase the measurement delay in cppc_cpufreq_get_rate to 10ms to avoid
>> high measurement errors.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 022e3555407c..c2bf65448d3d 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -851,7 +851,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>   	if (ret)
>>   		return ret;
>>   
>> -	udelay(2); /* 2usec delay between sampling */
>> +	mdelay(10); /* 10msec delay between sampling */
>>   
>>   	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>   	if (ret)
>> -- 
>> 2.39.2
> 

Just 2 considerations:
-
When using the schedutil governor, frequencies should be updated with
a period of cppc_cpufreq_get_transition_delay_us().
This period should be 1ms if CPPC doesn't rely on PCC channels, otherwise
the value depends on the PCC channel (cf. cppc_get_transition_latency()).

If the evaluation duration for the perf/ref counters is higher than this
period, I think this would mean that multiple frequency update would happen
while trying to evaluate the current frequency of a CPU.

-
There is a TimeWindowRegister field in CPPC (cf. enum cppc_regs::TIME_WINDOW
and ACPI 6.5 s8.4.6.1.2.5 "Time Window Register") that should approximately
match what this patch aims to solve.
"""
When Autonomous Selection is enabled, values written to the Time Window Register are ignored. Reads of the Time
Window register indicate minimum length of time (in ms) between successive reads of the platform’s performance
counters.
"""
The only issue being that we should be in the case where Autonomous Selection
is disabled, where the description of the register is different.

Regards,
Pierre
