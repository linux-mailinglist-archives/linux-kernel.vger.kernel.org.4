Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EA96DAA33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjDGIcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbjDGIci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:32:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 751C4AF0F;
        Fri,  7 Apr 2023 01:32:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EA341424;
        Fri,  7 Apr 2023 01:32:20 -0700 (PDT)
Received: from [10.34.100.129] (pierre123.nice.arm.com [10.34.100.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0A113F73F;
        Fri,  7 Apr 2023 01:31:34 -0700 (PDT)
Message-ID: <195c95b2-f47c-f3d0-5663-97dd4c929ea4@arm.com>
Date:   Fri, 7 Apr 2023 10:31:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
Content-Language: en-US
To:     Yang Shi <yang@os.amperecomputing.com>
Cc:     viresh.kumar@linaro.org, scott@os.amperecomputing.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230328193846.8757-1-yang@os.amperecomputing.com>
 <CAJZ5v0gQ7vak9DaEmLKe6un60Gcpj7VtmxdjPwuXTi=P=KJjbA@mail.gmail.com>
 <d08222bf-fa05-3e3b-18dd-d24ced6c1536@os.amperecomputing.com>
 <4bda6b02-cc50-fa47-c9b6-acda4cf201a8@arm.com>
 <cd79df5b-68c4-4825-6c29-e560989a1130@os.amperecomputing.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <cd79df5b-68c4-4825-6c29-e560989a1130@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yang,

On 4/6/23 23:52, Yang Shi wrote:
> 
> 
> On 4/5/23 10:57 AM, Pierre Gondois wrote:
>>
>>
>> On 4/4/23 21:07, Yang Shi wrote:
>>>
>>>
>>> On 3/29/23 11:43 AM, Rafael J. Wysocki wrote:
>>>> On Tue, Mar 28, 2023 at 9:39 PM Yang Shi
>>>> <yang@os.amperecomputing.com> wrote:
>>>>> When testing CPPC cpufreq on our platform, we noticed the error may
>>>>> be quite
>>>>> high and the high error may happen quite often.  For example, on a
>>>>> platform
>>>>> with a maximum frequency of 2.8GHz when the CPUs were fully loaded
>>>>> (100% load),
>>>>> we saw cpuinfo_cur_freq may show 4GHz, it means the error is >
>>>>> 40%.  And the
>>>>> high error (> 1%) happened 256 times out of 2127 samples (sampled
>>>>> every 3
>>>>> seconds) in an approximate 2hrs test.
>>>> The description above is a bit cryptic IMV.  For example, it is not
>>>> particularly clear what "high error" means.
>>>>
>>>>> We tried to enlarge the delay, and tested with 100us, 1ms and
>>>>> 10ms.  The
>>>>> below is the results.
>>>>>
>>>>> 100us:
>>>>> The highest error is 4GHz, 22 times out of 3623 samples
>>>>>
>>>>> 1ms:
>>>>> The highest error is 3.3GHz, 3 times out of 2814 samples
>>>>>
>>>>> 10ms:
>>>>> No high error anymore
>>>>>
>>>>> Increase the measurement delay in cppc_cpufreq_get_rate to 10ms to
>>>>> avoid
>>>>> high measurement errors.
>>>>>
>>>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>>>> ---
>>>>>     drivers/cpufreq/cppc_cpufreq.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>>>> b/drivers/cpufreq/cppc_cpufreq.c
>>>>> index 022e3555407c..c2bf65448d3d 100644
>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>> @@ -851,7 +851,7 @@ static unsigned int
>>>>> cppc_cpufreq_get_rate(unsigned int cpu)
>>>>>            if (ret)
>>>>>                    return ret;
>>>>>
>>>>> -       udelay(2); /* 2usec delay between sampling */
>>>>> +       mdelay(10); /* 10msec delay between sampling */
>>>> This function can be called with interrupts off, so it cannot spin
>>>> for 10 ms.
>>>
>>> Per Pierre's comment, the delay may still be ms. Is it still too long? A
>>> quick look at the code shows cpufreq_quick_get() is the only caller with
>>> irq off IIRC. So can we have another callback for it, for example,
>>> get_quick() which does spin for shorter time (for example, keep 2us
>>> delay). Then have ->get() callback use longer delay?
>>
>> -
>> According to the same ACPI 6.5 s8.4.6.1.2.5 "Time Window Register"
>> paragraph,
>> and assuming we are in the 'Autonomous Selection is not enabled' case,
>> the OS is supposed to write (not read) the delta between successive
>> reads of the
>> counter, so using this field as is would be bending the definition I
>> think.
>>
>> -
>> It is correct that the "Time Window Register" field specifies a value
>> in ms,
>> but it seems a long time to wait for with irqs off.
> 
> AFAIK, our platforms don't support "Time Window Register".
> 
>>
>> -
>> Theoretically, the perf/ref counters should accumulate to allow computing
>> a correct frequency. Is it possible to know how these counters are
>> accessed ?
>> Is it through PCC channels and there is some undesired delay between the
>> reads of the perf/ref counters ?
> 
> The counters are implemented via mmio instead of PCC channels. So the
> cpc_read() calls should go to ACPI_ADR_SPACE_SYSTEM_MEMORY IIRC.
> 
>>
>> -
>> About making the delay:
>>      max(cppc_cpufreq_get_transition_delay_us(), Time Winder Register)
>> I think it would be good to know why the values of the counters
>> don't accumulate correctly, ideally by getting a trace where a frequency
>> above the maximum frequency is computed, and with the timestamps at which
>> the counters are read.
>> If the values are coming from PCC channels / the firmware, it might be
>> difficult
>> to get.
> 
> I wrote a bpftrace script to trace the below data:
>       - The CPU number
>       - The frequency
>       - The start and end timestamp of the first cppc_get_perf_ctrs() call
>       - The duration/latency of the first cppc_get_perf_ctrs() call
>       - The start and end timestamp of the second cppc_get_perf_ctrs() call
>       - The duration/latency of the second cppc_get_perf_ctrs() call
> 
> The typical logs look like below.
> Good
> CPU: 1
> Freq: 2801485KHz
> First:  2489382384  2489387084 4700ns
> Second: 2489390824  2489394024  3200ns
> --------------------------------------------------
> CPU:    2
> Freq:   2797956KHz
> First:  2490406524  2490411204  4680ns
> Second: 2490414764  2490417684  2920ns
> 
> Bad:
> CPU:    55
> Freq:   3969372KHz
> First:  875659868  875721568  61700ns
> Second: 875725148  875727708  2560ns
> --------------------------------------------------
> CPU: 65
> Freq: 3829744KHz
> First:  3854951136  3854995896 44760ns
> Second: 3854999416  3855002696 3280ns
> --------------------------------------------------
> CPU: 21
> Freq: 4279242KHz
> First:  240834204  240910484 76280ns
> Second: 240914264  240916944  2680ns
> 
> 
> The first line is cpu number, the second line is frequency returned by
> cppc_cpufreq_get_rate(), the third line is the start and end timestamps
> and duration of the first cppc_get_perf_ctrs(), the fourth line is the
> start and end timestamps and duration of the second cppc_get_perf_ctrs().
> 
> So per the log I think we can tell basically the longer the duration the
> higher the error. The 2us delay is not long enough to offset the impact
> from unexpected latency of reading the counters.
> 
> In the worst case the frequency is 4279242KHz, comparing 2800000KHz the
> error is over 50%. So the delay should be 4ms ~ 5ms in order to offset
> the impact from reading the counters if I do the math correctly.
> 
> Hope the trace data is helpful to diagnose the problem.


Thanks for the data. I was thinking the following was happening:

  cppc_get_perf_ctrs()[0]                    cppc_get_perf_ctrs()[1]
/                    \                    /                         \
ref[0]    delivered[0]                    ref[1]          delivered[1]
   |            |                              |                  |
   v            v                              v                  v
----------------------------------------------------------------------> time
    <-delta[0]-> <-------------2us------------> <----delta[1]---->

If delta[0] is really different from delta[1] like above, then the
reference and delivered counters would have accumulated during different
intervals, resulting in a wrong frequency.
If more/less than 2us elapse between the two cppc_get_perf_ctrs() calls,
then it shouldn't have any impact. So waiting ~10ms should theoretically
not solve the issue.

freq = ref_freq * (delivered[1] - delivered[0]) / (ref[1] - ref[0])

If the counters are accessed through mmio, I don't see anything that would
make delta[x] vary when calling cppc_get_perf_ctrs(), cf. cpc_read().
Do you know if the address represents real counters or a place in memory
representing something else ?

Would it be possible to try setting the CPU frequency to one unique value
and get a serie of values like:
[timestamp, ref_counter_value, deliverd_counter_value]

This would allow to check that the counters are accumulating at a valid
pace. Also you said there were frequencies above the maximum value, but
are there also frequencies below the minimum value ?

Regards,
Pierre
