Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A56B6E769D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjDSJpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjDSJpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:45:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CADE8B4;
        Wed, 19 Apr 2023 02:45:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58BEBD75;
        Wed, 19 Apr 2023 02:46:31 -0700 (PDT)
Received: from [10.34.100.101] (pierre123.nice.arm.com [10.34.100.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80A223F5A1;
        Wed, 19 Apr 2023 02:45:46 -0700 (PDT)
Message-ID: <a2924821-80b9-e68f-3ae4-7a2c989afc88@arm.com>
Date:   Wed, 19 Apr 2023 11:45:39 +0200
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
 <d287eff6-77bd-693c-96d3-87d8981b7f96@arm.com>
 <7b57e680-0ba3-0b8b-851e-7cc369050386@os.amperecomputing.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <7b57e680-0ba3-0b8b-851e-7cc369050386@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/23 20:24, Yang Shi wrote:
> 
> 
> On 4/11/23 1:51 AM, Pierre Gondois wrote:
>> Hello Yang,
>>
>>>>>>
>>>>>> -
>>>>>> According to the same ACPI 6.5 s8.4.6.1.2.5 "Time Window Register"
>>>>>> paragraph,
>>>>>> and assuming we are in the 'Autonomous Selection is not enabled'
>>>>>> case,
>>>>>> the OS is supposed to write (not read) the delta between successive
>>>>>> reads of the
>>>>>> counter, so using this field as is would be bending the definition I
>>>>>> think.
>>>>>>
>>>>>> -
>>>>>> It is correct that the "Time Window Register" field specifies a value
>>>>>> in ms,
>>>>>> but it seems a long time to wait for with irqs off.
>>>>>
>>>>> AFAIK, our platforms don't support "Time Window Register".
>>>>>
>>>>>>
>>>>>> -
>>>>>> Theoretically, the perf/ref counters should accumulate to allow
>>>>>> computing
>>>>>> a correct frequency. Is it possible to know how these counters are
>>>>>> accessed ?
>>>>>> Is it through PCC channels and there is some undesired delay between
>>>>>> the
>>>>>> reads of the perf/ref counters ?
>>>>>
>>>>> The counters are implemented via mmio instead of PCC channels. So the
>>>>> cpc_read() calls should go to ACPI_ADR_SPACE_SYSTEM_MEMORY IIRC.
>>>>>
>>>>>>
>>>>>> -
>>>>>> About making the delay:
>>>>>>        max(cppc_cpufreq_get_transition_delay_us(), Time Winder
>>>>>> Register)
>>>>>> I think it would be good to know why the values of the counters
>>>>>> don't accumulate correctly, ideally by getting a trace where a
>>>>>> frequency
>>>>>> above the maximum frequency is computed, and with the timestamps at
>>>>>> which
>>>>>> the counters are read.
>>>>>> If the values are coming from PCC channels / the firmware, it
>>>>>> might be
>>>>>> difficult
>>>>>> to get.
>>>>>
>>>>> I wrote a bpftrace script to trace the below data:
>>>>>         - The CPU number
>>>>>         - The frequency
>>>>>         - The start and end timestamp of the first cppc_get_perf_ctrs()
>>>>> call
>>>>>         - The duration/latency of the first cppc_get_perf_ctrs() call
>>>>>         - The start and end timestamp of the second
>>>>> cppc_get_perf_ctrs() call
>>>>>         - The duration/latency of the second cppc_get_perf_ctrs() call
>>>>>
>>>>> The typical logs look like below.
>>>>> Good
>>>>> CPU: 1
>>>>> Freq: 2801485KHz
>>>>> First:  2489382384  2489387084 4700ns
>>>>> Second: 2489390824  2489394024  3200ns
>>>>> --------------------------------------------------
>>>>> CPU:    2
>>>>> Freq:   2797956KHz
>>>>> First:  2490406524  2490411204  4680ns
>>>>> Second: 2490414764  2490417684  2920ns
>>>>>
>>>>> Bad:
>>>>> CPU:    55
>>>>> Freq:   3969372KHz
>>>>> First:  875659868  875721568  61700ns
>>>>> Second: 875725148  875727708  2560ns
>>>>> --------------------------------------------------
>>>>> CPU: 65
>>>>> Freq: 3829744KHz
>>>>> First:  3854951136  3854995896 44760ns
>>>>> Second: 3854999416  3855002696 3280ns
>>>>> --------------------------------------------------
>>>>> CPU: 21
>>>>> Freq: 4279242KHz
>>>>> First:  240834204  240910484 76280ns
>>>>> Second: 240914264  240916944  2680ns
>>>>>
>>>>>
>>>>> The first line is cpu number, the second line is frequency returned by
>>>>> cppc_cpufreq_get_rate(), the third line is the start and end
>>>>> timestamps
>>>>> and duration of the first cppc_get_perf_ctrs(), the fourth line is the
>>>>> start and end timestamps and duration of the second
>>>>> cppc_get_perf_ctrs().
>>>>>
>>>>> So per the log I think we can tell basically the longer the
>>>>> duration the
>>>>> higher the error. The 2us delay is not long enough to offset the
>>>>> impact
>>>>> from unexpected latency of reading the counters.
>>>>>
>>>>> In the worst case the frequency is 4279242KHz, comparing 2800000KHz
>>>>> the
>>>>> error is over 50%. So the delay should be 4ms ~ 5ms in order to offset
>>>>> the impact from reading the counters if I do the math correctly.
>>>>>
>>>>> Hope the trace data is helpful to diagnose the problem.
>>>>
>>>>
>>>> Thanks for the data. I was thinking the following was happening:
>>>>
>>>>    cppc_get_perf_ctrs()[0] cppc_get_perf_ctrs()[1]
>>>> /                    \ /                         \
>>>> ref[0]    delivered[0]                    ref[1] delivered[1]
>>>>     |            | |                  |
>>>>     v            v v                  v
>>>> ---------------------------------------------------------------------->
>>>> time
>>>>      <-delta[0]-> <-------------2us------------> <----delta[1]---->
>>>>
>>>> If delta[0] is really different from delta[1] like above, then the
>>>> reference and delivered counters would have accumulated during
>>>> different
>>>> intervals, resulting in a wrong frequency.
>>>
>>> Yeah, it looks like so.
>>>
>>>> If more/less than 2us elapse between the two cppc_get_perf_ctrs()
>>>> calls,
>>>> then it shouldn't have any impact. So waiting ~10ms should
>>>> theoretically
>>>> not solve the issue.
>>>
>>> I'm not sure whether the 10ms delay really resolved the issue, but it
>>> did reduce the magnitude of the error.
>>>
>>> BTW, I don't see irq is disabled when reading cpuinfo_cur_freq, so it
>>> looks like interrupts could easily result in the difference between
>>> delta[0] and delta[1]. And it seems like the difference matters.
>>
>> Ok, maybe disabling irqs would have an impact ?
> 
> Yes, I ran some tracing to try to capture what happened when we saw high
> error. And it seems like IRQs is one of the contributing factors.
> Interconnect congestion is also a contributing factor. The below trace
> data supported the conclusion.
> 
> 4081929KHz
> # tracer: function_graph
> #
> #     TIME        CPU  DURATION                  FUNCTION CALLS
> #      |          |     |   |                     |   |   | |
> 13378.411863 |     0)               |  cppc_cpufreq_get_rate
> [cppc_cpufreq]() {
> 13378.411864 |     0)               |    cpufreq_cpu_get() {
> 13378.411865 |     0)               |      _raw_read_lock_irqsave() {
> 13378.411865 |     0)   0.680 us    | preempt_count_add();
> 13378.411867 |     0)   2.020 us    | }
> 13378.411868 |     0)               | _raw_read_unlock_irqrestore() {
> 13378.411868 |     0)   0.520 us    | preempt_count_sub();
> 13378.411869 |     0)   1.340 us    | }
> 13378.411869 |     0)   5.160 us    | }
> 13378.411870 |     0)   0.440 us    | cpufreq_cpu_put();
> 13378.411871 |     0)               |    cppc_get_perf_ctrs() {
> 13378.411872 |     0)               |      cpc_read.isra.0() {
> 13378.411874 |     0)               |        irq_enter_rcu() {
> 13378.411874 |     0)   0.460 us    | preempt_count_add();
> 13378.411875 |     0)   0.660 us    | irqtime_account_irq();
> 13378.411876 |     0)   2.480 us    | }
> 13378.411877 |     0)               |        do_interrupt_handler() {
> 13378.411877 |     0)   ==========> |
> 13378.411877 |     0) + 49.260 us   | gic_handle_irq();
> 13378.411877 |     0)   <========== |
> 13378.411928 |     0) + 51.000 us   | }
> 13378.411928 |     0)               |        irq_exit_rcu() {
> 13378.411929 |     0)   0.540 us    | irqtime_account_irq();
> 13378.411929 |     0)   0.420 us    | preempt_count_sub();
> 13378.411930 |     0)   0.640 us    | ksoftirqd_running();
> 13378.411931 |     0) + 16.680 us   | do_softirq_own_stack();
> 13378.411948 |     0)   0.440 us    | idle_cpu();
> 13378.411949 |     0) + 21.200 us   |        }
> 13378.411950 |     0) + 77.480 us   |      }
> 13378.411950 |     0)   0.740 us    |      cpc_read.isra.0();
> 13378.411951 |     0)   0.440 us    |      cpc_read.isra.0();
> 13378.411952 |     0)   0.660 us    |      cpc_read.isra.0();
> 13378.411953 |     0) + 81.980 us   |    }
> 13378.411954 |     0)               |    __delay() {
> 13378.411954 |     0)   0.580 us    | arch_timer_evtstrm_available();
> 13378.411956 |     0)   2.460 us    |    }
> 13378.411956 |     0)               |    cppc_get_perf_ctrs() {
> 13378.411957 |     0)   0.540 us    | cpc_read.isra.0();
> 13378.411958 |     0)   0.520 us    | cpc_read.isra.0();
> 13378.411959 |     0)   0.420 us    | cpc_read.isra.0();
> 13378.411959 |     0)   0.440 us    |      cpc_read.isra.0();
> 
> The above trace data captured IRQ when cppc_cpufreq_get_rate() returns
> 4081929KHz.
> 
> 3052367KHz
> # tracer: function_graph
> #
> #     TIME        CPU  DURATION                  FUNCTION CALLS
> #      |          |     |   |                     |   |   | |
> 19177.226497 |     0)               |  cppc_cpufreq_get_rate
> [cppc_cpufreq]() {
> 19177.226498 |     0)               |    cpufreq_cpu_get() {
> 19177.226499 |     0)               |      _raw_read_lock_irqsave() {
> 19177.226499 |     0)   0.600 us    |        preempt_count_add();
> 19177.226500 |     0)   1.820 us    |      }
> 19177.226501 |     0)               | _raw_read_unlock_irqrestore() {
> 19177.226502 |     0)   0.480 us    |        preempt_count_sub();
> 19177.226502 |     0)   1.260 us    |      }
> 19177.226503 |     0)   4.780 us    |    }
> 19177.226503 |     0)   0.420 us    |    cpufreq_cpu_put();
> 19177.226504 |     0)               |    cppc_get_perf_ctrs() {
> 19177.226505 |     0)   0.720 us    |      cpc_read.isra.0();
> 19177.226506 |     0)   1.180 us    |      cpc_read.isra.0();
> 19177.226508 |     0)   0.400 us    |      cpc_read.isra.0();
> 19177.226508 |     0)   0.600 us    |      cpc_read.isra.0();
> 19177.226509 |     0)   5.240 us    |    }
> 19177.226510 |     0)               |    __delay() {
> 19177.226510 |     0)   0.520 us    | arch_timer_evtstrm_available();
> 19177.226512 |     0)   2.420 us    |    }
> 19177.226513 |     0)               |    cppc_get_perf_ctrs() {
> 19177.226513 |     0)   0.540 us    |      cpc_read.isra.0();
> 19177.226514 |     0)   0.540 us    |      cpc_read.isra.0();
> 19177.226515 |     0)   0.400 us    |      cpc_read.isra.0();
> 19177.226516 |     0)   0.440 us    |      cpc_read.isra.0();
> 19177.226516 |     0)   3.660 us    |    }
> 19177.226517 |     0)   0.780 us    |    cppc_cpufreq_perf_to_khz
> [cppc_cpufreq]();
> 19177.226518 |     0) + 23.320 us   |  }


In cppc_get_perf_ctrs(), the cpc registers are read in this order:
1- delivered
2- reference
3- ref_perf
4- ctr_wrap

In the following, cpc_read[first][2] represents the second call to cpc_read()
in the first cppc_get_perf_ctrs() call.

The duration between the 2 cpc_read() calls to get the 'delivered' register
should be:
= cppc_get_perf_ctrs[first]() - cpc_read[first][1]() + __delay() +
   cpc_read[second][1]()
= 5.24 - 0.72 + 2.24 + 0.54 us
= 7.3 us

It is assumed here that in both cppc_get_perf_ctrs() calls:
- the duration between the entry cppc_get_perf_ctrs() and the the first call
   to cpc_read() is identical
- the duration between each cpc_read() call is identical

Similarly for the 'reference' register:
= cppc_get_perf_ctrs[first]() - cpc_read[first][1]() - cpc_read[first][2]() +
   __delay() + cpc_read[second][1]() + cpc_read[second][2]()
= 5.24 - 0.72 - 1.18 + 2.24 + 0.54 +0.54 us
= 6.66 us

So assuming the reference counter is at 1GHz and the delivered counter is at
2.8GHz, the computed_freq is:
= ref_cnt_freq * (delta_cnt_delivered() / delta_cnt_ref())
= 1GHz * ((2.8GHz * 7.3us) / (1GHz * 6.66us))
= 2.8 * (7.3 * 6.66) GHz
= 3.07 GHz

This is approximately what was obtained in the trace above (3.05GHz).

----

You say that the cause of this is a congestion in the interconnect. I don't
see a way to check that right now.
However your trace is on the CPU0, so maybe all the other cores were shutdown
in your test. If this is the case, do you think a congestion could happen with
only one CPU ?

Just 2 other comments:
a-
It might be interesting to change the order in which cpc registers are read
just to see if it has an impact, but even if it has, I m not sure how this
could be exploitable.
Just in case, I mean doing that, but I think that b. might be better to try.

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c51d3ccb4cca..479b55006020 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1350,8 +1350,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
                 }
         }
  
-       cpc_read(cpunum, delivered_reg, &delivered);
         cpc_read(cpunum, reference_reg, &reference);
+       cpc_read(cpunum, delivered_reg, &delivered);
         cpc_read(cpunum, ref_perf_reg, &ref_perf);
  
         /*

b-
In the trace that you shared, the cpc_read() calls in the fist
cppc_get_perf_ctrs() calls seem to always take a bit more time than in the
second cppc_get_perf_ctrs() call.
Would it be possible to collect traces similar as above with 3 or 4 calls to
cppc_get_perf_ctrs() instead of 2 ? It would allow to check whether in the first
call, accessing the cpc registers takes more time than in the following calls,
due to cache misses or other reasons.
Ideally statistics on the result would be the best, or if you have a trace.dat
to share containing a trace with multiple cppc_cpufreq_get_rate() calls.

Example of code where we do 4 calls to cppc_get_perf_ctrs():

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 022e3555407c..6370f2f0bdad 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -853,6 +853,20 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
  
         udelay(2); /* 2usec delay between sampling */
  
+       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
+       if (ret)
+               return ret;
+
+       udelay(2); /* 2usec delay between sampling */
+
+       /* Do a third call. */
+       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
+       if (ret)
+               return ret;
+
+       udelay(2); /* 2usec delay between sampling */
+
+       /* Do a fourth call. */
         ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
         if (ret)
                 return ret;

> 
> The above trace data shows some cpc reading took a little bit longer
> than usual. I suspected it was caused by interconnect congestion.
> 
> 
> So it looks like IRQ is the major contributing factor of high error
> (4xxxxxx KHz), interconnect congestion is the major contributing factor
> of low error (3xxxxxx KHz).
> 
> So I did the below test:
> 1. Disable IRQ: The high errors were gone (> 3700000KHz), but low errors
> were still seen.
> 2.10us delay: The high errors were still seen.
> 3. Disable IRQ + 10us delay: all the errors were gone.
> 
> I think the test result also supports the tracing data.
> 
> 
> I also got some confusion about calling cppc_cpufreq_get_rate() with irq
> disabled. Rafael thought 10ms delay is too long because the function may
> be called with irq disabled. But a deeper look at the function shows it
> should *NOT* be called with irq disabled at all.
> 
> First, if pcc channel is used, cpc reading may take over 100ms, it is
> way larger the proposed 10ms delay.
> Second, reading from cpc channel needs to take a semaphore, so it may
> sleep. But sleep with IRQ disabled is not allowed.

Yes right, however the semaphore is not taken in between the sequence of
cpc_read() calls in cppc_get_perf_ctrs(). So maybe the change below should
be acceptable:

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c51d3ccb4cca..105a7e2ffffa 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1315,6 +1315,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
         struct cppc_pcc_data *pcc_ss_data = NULL;
         u64 delivered, reference, ref_perf, ctr_wrap_time;
         int ret = 0, regs_in_pcc = 0;
+       unsigned long flags;
  
         if (!cpc_desc) {
                 pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
@@ -1350,10 +1351,14 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
                 }
         }
  
+       local_irq_save(flags);
+
         cpc_read(cpunum, delivered_reg, &delivered);
         cpc_read(cpunum, reference_reg, &reference);
         cpc_read(cpunum, ref_perf_reg, &ref_perf);
  
+       local_irq_restore(flags);
+
         /*
          * Per spec, if ctr_wrap_time optional register is unsupported, then the
          * performance counters are assumed to never wrap during the lifetime of

> Third, if the counters are implemented by AMU, cpc_read_ffh() needs to
> send IPI so it requires IRQ enabled.

If I'm not mistaken, the CPU calling cpc_read_ffh() might have IRQs disabled,
it should not prevent it to send IPIs no ?

> 
>>
>>>
>>> And the counters are accessed through an interconnect on our platform,
>>> so the interconnect congestion may result in the difference as well.
>>>
>>>>
>>>> freq = ref_freq * (delivered[1] - delivered[0]) / (ref[1] - ref[0])
>>>>
>>>> If the counters are accessed through mmio, I don't see anything that
>>>> would
>>>> make delta[x] vary when calling cppc_get_perf_ctrs(), cf. cpc_read().
>>>> Do you know if the address represents real counters or a place in
>>>> memory
>>>> representing something else ?
>>>
>>> The address does represent real counters.
>>
>> Oh ok, is it possible to know what is there ?
> 
> AFAIK, it is memory mapped access to the core's AMU counters.
> 
>>
>>>
>>>>
>>>> Would it be possible to try setting the CPU frequency to one unique
>>>> value
>>>> and get a serie of values like:
>>>> [timestamp, ref_counter_value, deliverd_counter_value]
>>>
>>> Could you please elaborate regarding "setting the CPU frequency to one
>>> unique value"? What value is unique?
>>
>> I meant having the CPUs using only on frequency. The following should
>> work:
>> cat /sys/devices/system/cpu/cpu[X]/cpufreq/scaling_min_freq >
>> /sys/devices/system/cpu/cpu[X]/cpufreq/scaling_max_freq
>>
>>>
>>>>
>>>> This would allow to check that the counters are accumulating at a valid
>>>> pace. Also you said there were frequencies above the maximum value, but
>>>> are there also frequencies below the minimum value ?
>>>
>>> I've never seen the frequency below the minimum value.
>>
>> Maybe this is because the CPUs are running at their maximum frequency,
>> so when the computed frequency is below the actual running frequency,
>> it still doesn't go below the minimum frequency.
>> Meaning that if the CPUs were limited to their lowest frequency (with
>> the command above), maybe the get_rate() function would return values
>> in a range [[1]:[2]]:
>> - [1]: frequency below the lowest frequency
>> - [2]: frequency above the lowest frequency, but below the maximum
>>    frequency of 2.8GHz
> 
> Yes, with writing scaling_min_freq to scaling_max_freq, I can see the
> frequency was lower than min freq (1000000KHz) occasionally.
> 
>>
>> Would it be possible to do the following:
>>
>> # Shut down all the CPUs except the last one just to have less logs
>> for i in /sys/devices/system/cpu/cpu[0-9]* ; do echo 0 > $i/online ; done
>>
>> cd /sys/kernel/debug/tracing
>>
>> # Add a kprobe to cppc_cpufreq_get_rate to get the computed freq
>> echo 'r:myretprobe cppc_cpufreq_get_rate $retval:u32' >>
>> /sys/kernel/debug/tracing/kprobe_events
>> echo 1 > events/kprobes/enable
>>
>> # Setup ftrace to trace cppc_cpufreq_get_rate() calls
>> # (and maybe see if something undesired happens in the call)
>> echo function_graph > current_tracer
>> echo funcgraph-abstime > trace_options
>> echo cppc_cpufreq_get_rate > set_graph_function
>>
>> # Do the tracing
>> echo 1 > tracing_on
>> # Wait a bit for a call to cppc_cpufreq_get_rate() to happen
>> echo 0 > tracing_on
>>
>> Also adding the following in cppc_perf_from_fbctrs() should allow
>> tracking the counter values:
>> trace_printk("get_cntrs: ref0=%lx ref1=%lx del0=%lx del1=%lx",
>>      fb_ctrs_t0->reference, fb_ctrs_t1->reference,
>>      fb_ctrs_t0->delivered, fb_ctrs_t1->delivered);
> 
> Sorry I forgot to ask whether I shall run the tracing for the lower than
> min frequency case or not? Since the latency of reading cpc is quite
> small (sub microsecond), so it is quite sensitive to extra
> latency/delay. It seems like the overhead of tracing is not negligible.
> 
> I got some data with higher than max frequency.
> 
> Good:
>    159.077799 |     0)               |  /* get_cntrs: ref0=1513476688
> ref1=1513482268 del0=329890515 del1=329905431 */
>    159.607913 |     0)               |  /* get_cntrs: ref0=1137490668
> ref1=1137496188 del0=3198347141 del1=3198362993 */
> 
> Bad:
> 4965.786566 |     0)               |  /* get_cntrs: ref0=766025872
> ref1=766034192 del0=2288598970 del1=2288624170 */
> 5251.933966 |     0)               |  /* get_cntrs: ref0=2472241696
> ref1=2472250376 del0=1156772954 del1=1156799208 */
> 
> Hopefully this is helpful.

Yes, thanks a lot. Using the min or max frequency was not important IMO,
it was just to avoid having the possibility to have a CPU with a changing
frequency.
Just a comment, the first trace was really helpfull, but I think it is
possible to have a function graph and the counter values as above in
the same trace.


Thanks again for the experiments,
Regards,
Pierre
