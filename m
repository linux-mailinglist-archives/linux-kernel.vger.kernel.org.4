Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D296E98FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjDTQB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDTQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:01:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B492E94;
        Thu, 20 Apr 2023 09:01:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CB171480;
        Thu, 20 Apr 2023 09:02:06 -0700 (PDT)
Received: from [10.57.22.141] (unknown [10.57.22.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA4B43F6C4;
        Thu, 20 Apr 2023 09:01:20 -0700 (PDT)
Message-ID: <cc32f950-ea78-87cb-e708-6d42d1e58cc8@arm.com>
Date:   Thu, 20 Apr 2023 18:01:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
To:     Yang Shi <yang@os.amperecomputing.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>
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
 <a2924821-80b9-e68f-3ae4-7a2c989afc88@arm.com>
 <1ce09fd7-0c1d-fc46-ce12-01b25fbd4afd@os.amperecomputing.com>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <1ce09fd7-0c1d-fc46-ce12-01b25fbd4afd@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> You say that the cause of this is a congestion in the interconnect. I
>> don't
>> see a way to check that right now.
>> However your trace is on the CPU0, so maybe all the other cores were
>> shutdown
>> in your test. If this is the case, do you think a congestion could
>> happen with
>> only one CPU ?
> 
> No, other CPUs were not shut down in my test. I just ran "yes" on all
> cores except CPU 0, then ran the reading freq script. Since all other
> cores are busy, so the script should be always running on CPU 0.
> 
> Since the counters, memory and other devices are on the interconnect, so
> the congestion may be caused by plenty of factors IIUC.

+Ionela

Ionela pointed me to the following patch-set, which seems realated:
https://lore.kernel.org/all/20230418113459.12860-5-sumitg@nvidia.com/

One thing that we didn't check I believe is and that Ionela pointed out
is that we don't know whether we are accessing the present CPU or a remote
CPU'AMUs. In the latter case there would be IPIs and possible delays in
waking up/accessing the remote CPU).

> 
>>
>> Just 2 other comments:
>> a-
>> It might be interesting to change the order in which cpc registers are
>> read
>> just to see if it has an impact, but even if it has, I m not sure how
>> this
>> could be exploitable.
>> Just in case, I mean doing that, but I think that b. might be better
>> to try.
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index c51d3ccb4cca..479b55006020 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1350,8 +1350,8 @@ int cppc_get_perf_ctrs(int cpunum, struct
>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>                  }
>>          }
>>
>> -       cpc_read(cpunum, delivered_reg, &delivered);
>>          cpc_read(cpunum, reference_reg, &reference);
>> +       cpc_read(cpunum, delivered_reg, &delivered);
>>          cpc_read(cpunum, ref_perf_reg, &ref_perf);
>>
>>          /*
>>
>> b-
>> In the trace that you shared, the cpc_read() calls in the fist
>> cppc_get_perf_ctrs() calls seem to always take a bit more time than in
>> the
>> second cppc_get_perf_ctrs() call.
>> Would it be possible to collect traces similar as above with 3 or 4
>> calls to
>> cppc_get_perf_ctrs() instead of 2 ? It would allow to check whether in
>> the first
>> call, accessing the cpc registers takes more time than in the
>> following calls,
>> due to cache misses or other reasons.
> 
> Cache miss? The counters should be not cached and reading the counters
> should not hit cache IIUC.

Yes you are correct, what I said is copmletely wrong.

> 
>> Ideally statistics on the result would be the best, or if you have a
>> trace.dat
>> to share containing a trace with multiple cppc_cpufreq_get_rate() calls.
> 
> Tried option b, I managed to get histogram:
> 
> @hist_first_ns[cat]:
> [4K, 8K)          112321
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [8K, 16K)            212
> |                                                    |
> [16K, 32K)            25
> |                                                    |
> [32K, 64K)            59
> |                                                    |
> [64K, 128K)            6
> |                                                    |
> [128K, 256K)           9
> |                                                    |
> 
> @hist_second_ns[cat]:
> [2K, 4K)          112590
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [4K, 8K)               4
> |                                                    |
> [8K, 16K)              0
> |                                                    |
> [16K, 32K)            15
> |                                                    |
> [32K, 64K)            18
> |                                                    |
> [64K, 128K)            1
> |                                                    |
> [128K, 256K)           4
> |                                                    |
> 
> The "first" means the first cppc_get_perf_ctrs() call. But the bpftrace
> script can't tell the second, the third and the fourth, so all them are
> shown as "second". Anyway it seems fine. We can tell the first read took
> longer than the later ones for the most time.
> 
> And a typical func_graph trace shows:
> 
> # tracer: function_graph
> #
> #     TIME        CPU  DURATION                  FUNCTION CALLS
> #      |          |     |   |                     |   |   | |
>    4447.171333 |     0)               |  cppc_cpufreq_get_rate
> [cppc_cpufreq]() {
>    4447.171334 |     0)               |    cpufreq_cpu_get() {
>    4447.171334 |     0)   1.060 us    | _raw_read_lock_irqsave();
>    4447.171336 |     0)   0.560 us    | _raw_read_unlock_irqrestore();
>    4447.171337 |     0)   3.480 us    | }
>    4447.171338 |     0)   0.400 us    | cpufreq_cpu_put();
>    4447.171338 |     0)               |    cppc_get_perf_ctrs() {
>    4447.171339 |     0)   0.720 us    | cpc_read.isra.0();
>    4447.171341 |     0)   0.700 us    | cpc_read.isra.0();
>    4447.171342 |     0)   0.380 us    | cpc_read.isra.0();
>    4447.171342 |     0)   0.600 us    | cpc_read.isra.0();
>    4447.171343 |     0)   4.900 us    | }
>    4447.171344 |     0)               |    __delay() {
>    4447.171344 |     0)   0.540 us    | arch_timer_evtstrm_available();
>    4447.171346 |     0)   2.420 us    | }
>    4447.171347 |     0)               |    cppc_get_perf_ctrs() {
>    4447.171347 |     0)   0.540 us    | cpc_read.isra.0();
>    4447.171348 |     0)   0.520 us    | cpc_read.isra.0();
>    4447.171349 |     0)   0.400 us    | cpc_read.isra.0();
>    4447.171350 |     0)   0.440 us    | cpc_read.isra.0();
>    4447.171350 |     0)   3.660 us    | }
>    4447.171351 |     0)               |    __delay() {
>    4447.171351 |     0)   0.400 us    | arch_timer_evtstrm_available();
>    4447.171353 |     0)   2.400 us    | }
>    4447.171353 |     0)               |    cppc_get_perf_ctrs() {
>    4447.171354 |     0)   0.540 us    | cpc_read.isra.0();
>    4447.171355 |     0)   0.540 us    | cpc_read.isra.0();
>    4447.171356 |     0)   0.380 us    | cpc_read.isra.0();
>    4447.171356 |     0)   0.420 us    | cpc_read.isra.0();
>    4447.171357 |     0)   3.640 us    | }
>    4447.171357 |     0)               |    __delay() {
>    4447.171358 |     0)   0.380 us    | arch_timer_evtstrm_available();
>    4447.171360 |     0)   2.380 us    |    }
>    4447.171360 |     0)               |    cppc_get_perf_ctrs() {
>    4447.171361 |     0)   0.520 us    |      cpc_read.isra.0();
>    4447.171361 |     0)   0.520 us    |      cpc_read.isra.0();
>    4447.171362 |     0)   0.400 us    |      cpc_read.isra.0();
>    4447.171363 |     0)   0.440 us    |      cpc_read.isra.0();
>    4447.171364 |     0)   3.640 us    |    }
>    4447.171364 |     0)   0.520 us    |    cppc_cpufreq_perf_to_khz
> [cppc_cpufreq]();
>    4447.171365 |     0) + 34.240 us   |  }
> 
> It also shows the first reading typically took longer than the later
> ones. The second, the third and the fourth actually took almost same time.
> 
> I also tried to read perf_fb_ctrs_t0 twice (so total 3 reads, 2 for t0,
> 1 for t1, 2us delay between each read), but I didn't see noticeable
> improvement. 4 reads (2 for t0, 2 for t1) does show some noticeable
> improvement.
> 

Thanks for the new data.

>>
>> Example of code where we do 4 calls to cppc_get_perf_ctrs():
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 022e3555407c..6370f2f0bdad 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -853,6 +853,20 @@ static unsigned int
>> cppc_cpufreq_get_rate(unsigned int cpu)
>>
>>          udelay(2); /* 2usec delay between sampling */
>>
>> +       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>> +       if (ret)
>> +               return ret;
>> +
>> +       udelay(2); /* 2usec delay between sampling */
>> +
>> +       /* Do a third call. */
>> +       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>> +       if (ret)
>> +               return ret;
>> +
>> +       udelay(2); /* 2usec delay between sampling */
>> +
>> +       /* Do a fourth call. */
>>          ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>          if (ret)
>>                  return ret;
>>
>>>
>>> The above trace data shows some cpc reading took a little bit longer
>>> than usual. I suspected it was caused by interconnect congestion.
>>>
>>>
>>> So it looks like IRQ is the major contributing factor of high error
>>> (4xxxxxx KHz), interconnect congestion is the major contributing factor
>>> of low error (3xxxxxx KHz).
>>>
>>> So I did the below test:
>>> 1. Disable IRQ: The high errors were gone (> 3700000KHz), but low errors
>>> were still seen.
>>> 2.10us delay: The high errors were still seen.
>>> 3. Disable IRQ + 10us delay: all the errors were gone.
>>>
>>> I think the test result also supports the tracing data.
>>>
>>>
>>> I also got some confusion about calling cppc_cpufreq_get_rate() with irq
>>> disabled. Rafael thought 10ms delay is too long because the function may
>>> be called with irq disabled. But a deeper look at the function shows it
>>> should *NOT* be called with irq disabled at all.
>>>
>>> First, if pcc channel is used, cpc reading may take over 100ms, it is
>>> way larger the proposed 10ms delay.
>>> Second, reading from cpc channel needs to take a semaphore, so it may
>>> sleep. But sleep with IRQ disabled is not allowed.
>>
>> Yes right, however the semaphore is not taken in between the sequence of
>> cpc_read() calls in cppc_get_perf_ctrs(). So maybe the change below
>> should
>> be acceptable:
> 
> Yeah, we should be able to find a smaller irq disable section.
> 
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index c51d3ccb4cca..105a7e2ffffa 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1315,6 +1315,7 @@ int cppc_get_perf_ctrs(int cpunum, struct
>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>          struct cppc_pcc_data *pcc_ss_data = NULL;
>>          u64 delivered, reference, ref_perf, ctr_wrap_time;
>>          int ret = 0, regs_in_pcc = 0;
>> +       unsigned long flags;
>>
>>          if (!cpc_desc) {
>>                  pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>> @@ -1350,10 +1351,14 @@ int cppc_get_perf_ctrs(int cpunum, struct
>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>                  }
>>          }
>>
>> +       local_irq_save(flags);
>> +
>>          cpc_read(cpunum, delivered_reg, &delivered);
>>          cpc_read(cpunum, reference_reg, &reference);
>>          cpc_read(cpunum, ref_perf_reg, &ref_perf);
>>
>> +       local_irq_restore(flags);
>> +
> 
> cpc_read_ffh() would return -EPERM if irq is disabled.
> 
> So, the irq disabling must happen for mmio only in cpc_read(), for example:

I thought the issue was that irqs could happen in between cpc_read() functions,
the patch below would not cover it. If the frequency is more accurate
with this patch, I think I don't understand something.

(asking for more information)
Just to check, the core/perf counters are AMUs and the other CPPC registers
are mmio right ? Is it possible to know the CPPC registers that are
implemented on your platform ?
Also is it possible which platform you are using ?

> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c51d3ccb4cca..f3c92d844074 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -982,6 +982,7 @@ static int cpc_read(int cpu, struct
> cpc_register_resource *reg_res, u64 *val)
>           void __iomem *vaddr = NULL;
>           int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>           struct cpc_reg *reg = &reg_res->cpc_entry.reg;
> +       unsigned long flags;
> 
>           if (reg_res->type == ACPI_TYPE_INTEGER) {
>                   *val = reg_res->cpc_entry.int_value;
> @@ -1015,6 +1016,7 @@ static int cpc_read(int cpu, struct
> cpc_register_resource *reg_res, u64 *val)
>                   return
> acpi_os_read_memory((acpi_physical_address)reg->address,
>                                   val, reg->bit_width);
> 
> +       local_irq_save(flags);
>           switch (reg->bit_width) {
>           case 8:
>                   *val = readb_relaxed(vaddr);
> @@ -1029,10 +1031,12 @@ static int cpc_read(int cpu, struct
> cpc_register_resource *reg_res, u64 *val)
>                   *val = readq_relaxed(vaddr);
>                   break;
>           default:
> +               local_irq_restore(flags);
>                   pr_debug("Error: Cannot read %u bit width from PCC for
> ss: %d\n",
>                            reg->bit_width, pcc_ss_id);
>                   return -EFAULT;
>           }
> +       local_irq_restore(flags);
> 
>           return 0;
>    }
> 
>>          /*
>>           * Per spec, if ctr_wrap_time optional register is
>> unsupported, then the
>>           * performance counters are assumed to never wrap during the
>> lifetime of
>>
>>> Third, if the counters are implemented by AMU, cpc_read_ffh() needs to
>>> send IPI so it requires IRQ enabled.
>>
>> If I'm not mistaken, the CPU calling cpc_read_ffh() might have IRQs
>> disabled,
>> it should not prevent it to send IPIs no ?
> 
> It can't work with irq disabled. The comment in counters_read_on_cpu()
> says "Abort call on counterless CPU or when interrupts are disabled -
> can lead to deadlock in smp sync call."
> 
> 
> And it just returns -EPERM and raise a warning if irq is disabled.

Ok right,

Regards,
Piere
