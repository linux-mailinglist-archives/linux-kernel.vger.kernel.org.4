Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8B06DD5FA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjDKIwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjDKIwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:52:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE9C51724;
        Tue, 11 Apr 2023 01:51:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F3E24B3;
        Tue, 11 Apr 2023 01:52:40 -0700 (PDT)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C31A63F73F;
        Tue, 11 Apr 2023 01:51:54 -0700 (PDT)
Message-ID: <d287eff6-77bd-693c-96d3-87d8981b7f96@arm.com>
Date:   Tue, 11 Apr 2023 10:51:44 +0200
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
 <195c95b2-f47c-f3d0-5663-97dd4c929ea4@arm.com>
 <3e239024-91d8-ea06-25a4-631496576319@os.amperecomputing.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <3e239024-91d8-ea06-25a4-631496576319@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yang,

>>>>
>>>> -
>>>> According to the same ACPI 6.5 s8.4.6.1.2.5 "Time Window Register"
>>>> paragraph,
>>>> and assuming we are in the 'Autonomous Selection is not enabled' case,
>>>> the OS is supposed to write (not read) the delta between successive
>>>> reads of the
>>>> counter, so using this field as is would be bending the definition I
>>>> think.
>>>>
>>>> -
>>>> It is correct that the "Time Window Register" field specifies a value
>>>> in ms,
>>>> but it seems a long time to wait for with irqs off.
>>>
>>> AFAIK, our platforms don't support "Time Window Register".
>>>
>>>>
>>>> -
>>>> Theoretically, the perf/ref counters should accumulate to allow
>>>> computing
>>>> a correct frequency. Is it possible to know how these counters are
>>>> accessed ?
>>>> Is it through PCC channels and there is some undesired delay between
>>>> the
>>>> reads of the perf/ref counters ?
>>>
>>> The counters are implemented via mmio instead of PCC channels. So the
>>> cpc_read() calls should go to ACPI_ADR_SPACE_SYSTEM_MEMORY IIRC.
>>>
>>>>
>>>> -
>>>> About making the delay:
>>>>       max(cppc_cpufreq_get_transition_delay_us(), Time Winder Register)
>>>> I think it would be good to know why the values of the counters
>>>> don't accumulate correctly, ideally by getting a trace where a
>>>> frequency
>>>> above the maximum frequency is computed, and with the timestamps at
>>>> which
>>>> the counters are read.
>>>> If the values are coming from PCC channels / the firmware, it might be
>>>> difficult
>>>> to get.
>>>
>>> I wrote a bpftrace script to trace the below data:
>>>        - The CPU number
>>>        - The frequency
>>>        - The start and end timestamp of the first cppc_get_perf_ctrs()
>>> call
>>>        - The duration/latency of the first cppc_get_perf_ctrs() call
>>>        - The start and end timestamp of the second
>>> cppc_get_perf_ctrs() call
>>>        - The duration/latency of the second cppc_get_perf_ctrs() call
>>>
>>> The typical logs look like below.
>>> Good
>>> CPU: 1
>>> Freq: 2801485KHz
>>> First:  2489382384  2489387084 4700ns
>>> Second: 2489390824  2489394024  3200ns
>>> --------------------------------------------------
>>> CPU:    2
>>> Freq:   2797956KHz
>>> First:  2490406524  2490411204  4680ns
>>> Second: 2490414764  2490417684  2920ns
>>>
>>> Bad:
>>> CPU:    55
>>> Freq:   3969372KHz
>>> First:  875659868  875721568  61700ns
>>> Second: 875725148  875727708  2560ns
>>> --------------------------------------------------
>>> CPU: 65
>>> Freq: 3829744KHz
>>> First:  3854951136  3854995896 44760ns
>>> Second: 3854999416  3855002696 3280ns
>>> --------------------------------------------------
>>> CPU: 21
>>> Freq: 4279242KHz
>>> First:  240834204  240910484 76280ns
>>> Second: 240914264  240916944  2680ns
>>>
>>>
>>> The first line is cpu number, the second line is frequency returned by
>>> cppc_cpufreq_get_rate(), the third line is the start and end timestamps
>>> and duration of the first cppc_get_perf_ctrs(), the fourth line is the
>>> start and end timestamps and duration of the second
>>> cppc_get_perf_ctrs().
>>>
>>> So per the log I think we can tell basically the longer the duration the
>>> higher the error. The 2us delay is not long enough to offset the impact
>>> from unexpected latency of reading the counters.
>>>
>>> In the worst case the frequency is 4279242KHz, comparing 2800000KHz the
>>> error is over 50%. So the delay should be 4ms ~ 5ms in order to offset
>>> the impact from reading the counters if I do the math correctly.
>>>
>>> Hope the trace data is helpful to diagnose the problem.
>>
>>
>> Thanks for the data. I was thinking the following was happening:
>>
>>   cppc_get_perf_ctrs()[0] cppc_get_perf_ctrs()[1]
>> /                    \ /                         \
>> ref[0]    delivered[0]                    ref[1] delivered[1]
>>    |            |                              |                  |
>>    v            v                              v                  v
>> ---------------------------------------------------------------------->
>> time
>>     <-delta[0]-> <-------------2us------------> <----delta[1]---->
>>
>> If delta[0] is really different from delta[1] like above, then the
>> reference and delivered counters would have accumulated during different
>> intervals, resulting in a wrong frequency.
> 
> Yeah, it looks like so.
> 
>> If more/less than 2us elapse between the two cppc_get_perf_ctrs() calls,
>> then it shouldn't have any impact. So waiting ~10ms should theoretically
>> not solve the issue.
> 
> I'm not sure whether the 10ms delay really resolved the issue, but it
> did reduce the magnitude of the error.
> 
> BTW, I don't see irq is disabled when reading cpuinfo_cur_freq, so it
> looks like interrupts could easily result in the difference between
> delta[0] and delta[1]. And it seems like the difference matters.

Ok, maybe disabling irqs would have an impact ?

> 
> And the counters are accessed through an interconnect on our platform,
> so the interconnect congestion may result in the difference as well.
> 
>>
>> freq = ref_freq * (delivered[1] - delivered[0]) / (ref[1] - ref[0])
>>
>> If the counters are accessed through mmio, I don't see anything that
>> would
>> make delta[x] vary when calling cppc_get_perf_ctrs(), cf. cpc_read().
>> Do you know if the address represents real counters or a place in memory
>> representing something else ?
> 
> The address does represent real counters.

Oh ok, is it possible to know what is there ?

> 
>>
>> Would it be possible to try setting the CPU frequency to one unique value
>> and get a serie of values like:
>> [timestamp, ref_counter_value, deliverd_counter_value]
> 
> Could you please elaborate regarding "setting the CPU frequency to one
> unique value"? What value is unique?

I meant having the CPUs using only on frequency. The following should work:
cat /sys/devices/system/cpu/cpu[X]/cpufreq/scaling_min_freq > /sys/devices/system/cpu/cpu[X]/cpufreq/scaling_max_freq

> 
>>
>> This would allow to check that the counters are accumulating at a valid
>> pace. Also you said there were frequencies above the maximum value, but
>> are there also frequencies below the minimum value ?
> 
> I've never seen the frequency below the minimum value.

Maybe this is because the CPUs are running at their maximum frequency,
so when the computed frequency is below the actual running frequency,
it still doesn't go below the minimum frequency.
Meaning that if the CPUs were limited to their lowest frequency (with
the command above), maybe the get_rate() function would return values
in a range [[1]:[2]]:
- [1]: frequency below the lowest frequency
- [2]: frequency above the lowest frequency, but below the maximum
   frequency of 2.8GHz

Would it be possible to do the following:

# Shut down all the CPUs except the last one just to have less logs
for i in /sys/devices/system/cpu/cpu[0-9]* ; do echo 0 > $i/online ; done

cd /sys/kernel/debug/tracing

# Add a kprobe to cppc_cpufreq_get_rate to get the computed freq
echo 'r:myretprobe cppc_cpufreq_get_rate $retval:u32' >> /sys/kernel/debug/tracing/kprobe_events
echo 1 > events/kprobes/enable

# Setup ftrace to trace cppc_cpufreq_get_rate() calls
# (and maybe see if something undesired happens in the call)
echo function_graph > current_tracer
echo funcgraph-abstime > trace_options
echo cppc_cpufreq_get_rate > set_graph_function

# Do the tracing
echo 1 > tracing_on
# Wait a bit for a call to cppc_cpufreq_get_rate() to happen
echo 0 > tracing_on

Also adding the following in cppc_perf_from_fbctrs() should allow
tracking the counter values:
trace_printk("get_cntrs: ref0=%lx ref1=%lx del0=%lx del1=%lx",
     fb_ctrs_t0->reference, fb_ctrs_t1->reference,
     fb_ctrs_t0->delivered, fb_ctrs_t1->delivered);

Regards,
Pierre
