Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AFE5FAF28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJKJQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJKJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:15:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4085B36429;
        Tue, 11 Oct 2022 02:15:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0B3B1042;
        Tue, 11 Oct 2022 02:16:03 -0700 (PDT)
Received: from [10.163.35.30] (unknown [10.163.35.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A80AE3F766;
        Tue, 11 Oct 2022 02:15:54 -0700 (PDT)
Message-ID: <0d1e6e0f-6ab5-b5cf-8b17-65ca22087691@arm.com>
Date:   Tue, 11 Oct 2022 14:46:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 4/7] driver/perf/arm_pmu_platform: Add support for BRBE
 attributes detection
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
References: <20220929075857.158358-1-anshuman.khandual@arm.com>
 <20220929075857.158358-5-anshuman.khandual@arm.com>
 <02ce379c-c718-b72d-fc74-cd8c904265fb@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <02ce379c-c718-b72d-fc74-cd8c904265fb@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/22 19:07, James Clark wrote:
> 
> On 29/09/2022 08:58, Anshuman Khandual wrote:
>> This adds arm pmu infrastrure to probe BRBE implementation's attributes via
>> driver exported callbacks later. The actual BRBE feature detection will be
>> added by the driver itself.
>>
>> CPU specific BRBE entries, cycle count, format support gets detected during
>> PMU init. This information gets saved in per-cpu struct pmu_hw_events which
>> later helps in operating BRBE during a perf event context.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/perf/arm_pmu_platform.c | 34 +++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
>> index 933b96e243b8..acdc445081aa 100644
>> --- a/drivers/perf/arm_pmu_platform.c
>> +++ b/drivers/perf/arm_pmu_platform.c
>> @@ -172,6 +172,36 @@ static int armpmu_request_irqs(struct arm_pmu *armpmu)
>>  	return err;
>>  }
>>  
>> +static void arm_brbe_probe_cpu(void *info)
>> +{
>> +	struct pmu_hw_events *hw_events;
>> +	struct arm_pmu *armpmu = info;
>> +
>> +	/*
>> +	 * Return from here, if BRBE driver has not been
>> +	 * implemented for this PMU. This helps prevent
>> +	 * kernel crash later when brbe_probe() will be
>> +	 * called on the PMU.
>> +	 */
>> +	if (!armpmu->brbe_probe)
>> +		return;
>> +
>> +	hw_events = per_cpu_ptr(armpmu->hw_events, smp_processor_id());
>> +	armpmu->brbe_probe(hw_events);
>> +}
>> +
>> +static int armpmu_request_brbe(struct arm_pmu *armpmu)
>> +{
>> +	int cpu, err = 0;
>> +
>> +	for_each_cpu(cpu, &armpmu->supported_cpus) {
>> +		err = smp_call_function_single(cpu, arm_brbe_probe_cpu, armpmu, 1);
> Hi Anshuman,
> 
> I have LOCKDEP on and the patchset applied to perf/core (82aad7ff7) on
> git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git and I get
> this:
> 
>    armv8-pmu pmu: hw perfevents: no interrupt-affinity property, guessing.
>    brbe: implementation found on cpu 0
> 
>    =============================
>    [ BUG: Invalid wait context ]
>    6.0.0-rc7 #38 Not tainted
>    -----------------------------
>    kworker/u8:0/9 is trying to lock:
>    ffff000800855898 (&port_lock_key){....}-{3:3}, at:
> pl011_console_write+0x148/0x240
>    other info that might help us debug this:
>    context-{2:2}
>    5 locks held by kworker/u8:0/9:
>     #0: ffff00080032a138 ((wq_completion)eval_map_wq){+.+.}-{0:0}, at:
> process_one_work+0x200/0x6b0
>     #1: ffff80000807bde0
> ((work_completion)(&eval_map_work)){+.+.}-{0:0}, at:
> process_one_work+0x200/0x6b0
>     #2: ffff80000aa3db70 (trace_event_sem){+.+.}-{4:4}, at:
> trace_event_eval_update+0x28/0x420
>     #3: ffff80000a9afe58 (console_lock){+.+.}-{0:0}, at:
> vprintk_emit+0x130/0x380
>     #4: ffff80000a9aff78 (console_owner){-...}-{0:0}, at:
> console_emit_next_record.constprop.0+0x128/0x338
>    stack backtrace:
>    CPU: 0 PID: 9 Comm: kworker/u8:0 Not tainted 6.0.0-rc7 #38
>    Hardware name: Foundation-v8A (DT)
>    Workqueue: eval_map_wq eval_map_work_func
>    Call trace:
>     dump_backtrace+0x114/0x120
>     show_stack+0x20/0x58
>     dump_stack_lvl+0x9c/0xd8
>     dump_stack+0x18/0x34
>     __lock_acquire+0x17cc/0x1920
>     lock_acquire+0x138/0x3b8
>     _raw_spin_lock+0x58/0x70
>     pl011_console_write+0x148/0x240
>     console_emit_next_record.constprop.0+0x194/0x338
>     console_unlock+0x18c/0x208
>     vprintk_emit+0x24c/0x380
>     vprintk_default+0x40/0x50
>     vprintk+0xd4/0xf0
>     _printk+0x68/0x90
>     arm64_pmu_brbe_probe+0x10c/0x128
>     armv8pmu_brbe_probe+0x18/0x28
>     arm_brbe_probe_cpu+0x44/0x58
>     __flush_smp_call_function_queue+0x1d0/0x440
>     generic_smp_call_function_single_interrupt+0x20/0x78
>     ipi_handler+0x98/0x368
>     handle_percpu_devid_irq+0xc0/0x3a8
>     generic_handle_domain_irq+0x34/0x50
>     gic_handle_irq+0x58/0x138
>     call_on_irq_stack+0x2c/0x58
>     do_interrupt_handler+0x88/0x90
>     el1_interrupt+0x40/0x78
>     el1h_64_irq_handler+0x18/0x28
>     el1h_64_irq+0x64/0x68
>     trace_event_eval_update+0x114/0x420
>     eval_map_work_func+0x30/0x40
>     process_one_work+0x298/0x6b0
>     worker_thread+0x54/0x408
>     kthread+0x118/0x128
>     ret_from_fork+0x10/0x20
>    brbe: implementation found on cpu 1
>    brbe: implementation found on cpu 2
>    brbe: implementation found on cpu 3


The LOCKDEP warnings are because of pr_warn/pr_info in arm64_pmu_brbe_probe()
which gets called from smp_call_function_single() context. I will drop these
prints, instead probably capture them in struct pmu_hw_events and display in
the caller itself.
