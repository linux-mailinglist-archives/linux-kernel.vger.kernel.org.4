Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988825F0622
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiI3IB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiI3IBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:01:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5388F10EDBE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:01:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 668A415A1;
        Fri, 30 Sep 2022 01:01:29 -0700 (PDT)
Received: from [10.57.65.195] (unknown [10.57.65.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB9253F792;
        Fri, 30 Sep 2022 01:01:20 -0700 (PDT)
Message-ID: <a0275123-2c80-9f18-5716-7fe38b9f110c@arm.com>
Date:   Fri, 30 Sep 2022 10:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/1] arm_pmu: acpi: Pre-allocate pmu structures
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220912155105.1443303-1-pierre.gondois@arm.com>
 <20220912155105.1443303-2-pierre.gondois@arm.com>
 <YzRsibv4Iqw2Kk0T@FVFF77S0Q05N>
 <c262795e-c84c-3f8f-db1c-e46268525750@arm.com>
 <YzXAFz7+pOZdPoWq@FVFF77S0Q05N>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <YzXAFz7+pOZdPoWq@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/22 17:56, Mark Rutland wrote:
> On Thu, Sep 29, 2022 at 04:08:19PM +0200, Pierre Gondois wrote:
>> Hello Mark,
>>
>> On 9/28/22 17:47, Mark Rutland wrote:
>>> Hi Pierre,
>>>
>>> Thanks for this, and sorry for the delayed reply.
>>>
>>> On Mon, Sep 12, 2022 at 05:51:04PM +0200, Pierre Gondois wrote:
>>>> On an Ampere Altra,
>>>> Running a preemp_rt kernel based on v5.19-rc3-rt4 on an Ampere Altra
>>>> triggers:
>>>> [   12.642389] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
>>>> [   12.642402] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 24, name: cpuhp/0
>>>> [   12.642406] preempt_count: 0, expected: 0
>>>> [   12.642409] RCU nest depth: 0, expected: 0
>>>> [   12.642411] 3 locks held by cpuhp/0/24:
>>>> [   12.642414] #0: ffffd8a22c8870d0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun (linux/kernel/cpu.c:754)
>>>> [   12.642429] #1: ffffd8a22c887120 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun (linux/kernel/cpu.c:754)
>>>> [   12.642436] #2: ffff083e7f0d97b8 ((&c->lock)){+.+.}-{3:3}, at: ___slab_alloc (linux/mm/slub.c:2954)
>>>> [   12.642458] irq event stamp: 42
>>>> [   12.642460] hardirqs last enabled at (41): finish_task_switch (linux/./arch/arm64/include/asm/irqflags.h:35)
>>>> [   12.642471] hardirqs last disabled at (42): cpuhp_thread_fun (linux/kernel/cpu.c:776 (discriminator 1))
>>>> [   12.642476] softirqs last enabled at (0): copy_process (linux/./include/linux/lockdep.h:191)
>>>> [   12.642484] softirqs last disabled at (0): 0x0
>>>> [   12.642495] CPU: 0 PID: 24 Comm: cpuhp/0 Tainted: G        W         5.19.0-rc3-rt4-custom-piegon01-rt_0 #142
>>>> [   12.642500] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
>>>> [   12.642506] Call trace:
>>>> [   12.642508] dump_backtrace (linux/arch/arm64/kernel/stacktrace.c:200)
>>>> [   12.642514] show_stack (linux/arch/arm64/kernel/stacktrace.c:207)
>>>> [   12.642517] dump_stack_lvl (linux/lib/dump_stack.c:107)
>>>> [   12.642523] dump_stack (linux/lib/dump_stack.c:114)
>>>> [   12.642527] __might_resched (linux/kernel/sched/core.c:9929)
>>>> [   12.642531] rt_spin_lock (linux/kernel/locking/rtmutex.c:1732 (discriminator 4))
>>>> [   12.642536] ___slab_alloc (linux/mm/slub.c:2954)
>>>> [   12.642539] __slab_alloc.isra.0 (linux/mm/slub.c:3116)
>>>> [   12.642543] kmem_cache_alloc_trace (linux/mm/slub.c:3207)
>>>> [   12.642549] __armpmu_alloc (linux/./include/linux/slab.h:600)
>>>> [   12.642558] armpmu_alloc_atomic (linux/drivers/perf/arm_pmu.c:927)
>>>> [   12.642562] arm_pmu_acpi_cpu_starting (linux/drivers/perf/arm_pmu_acpi.c:204)
>>>> [   12.642568] cpuhp_invoke_callback (linux/kernel/cpu.c:192)
>>>> [   12.642571] cpuhp_thread_fun (linux/kernel/cpu.c:777 (discriminator 3))
>>>> [   12.642573] smpboot_thread_fn (linux/kernel/smpboot.c:164 (discriminator 3))
>>>> [   12.642580] kthread (linux/kernel/kthread.c:376)
>>>> [   12.642584] ret_from_fork (linux/arch/arm64/kernel/entry.S:868)
>>>>
>>>> arm_pmu_acpi_cpu_starting() is called in the STARTING hotplug section,
>>>> which runs with interrupts disabled. To avoid allocating memory and
>>>> sleeping in this function, the pmu structures must be pre-allocated.
>>>>
>>>> On ACPI systems, the count of PMUs is unknown until CPUs are
>>>> hotplugged, cf:
>>>> commit 0dc1a1851af1 ("arm_pmu: add armpmu_alloc_atomic()")
>>>>
>>>> At most #PMU_IRQs pmu structures will be used and thus need to be
>>>> pre-allocated.
>>>> In arm_pmu_acpi_cpu_starting() subcalls, after checking the cpuid,
>>>> decide to use or re-use a pre-allocated pmu structure. Thus the
>>>> pre-allocated pmu struct can be seen as a pool.
>>>> When probing, search and free unused pmu structures.
>>>
>>> I think in retrospect I was trying to be too clever with
>>> arm_pmu_acpi_cpu_starting() handling boot-time CPUs and late hotplug, and we
>>> can make this simpler by handling the boot-time probing synchronously within
>>> arm_pmu_acpi_probe(), removing a bunch of state.
>>>
>>> I had a go at that, and in testing (in a QEMU TCG VM) atop arm64/for-next/core,
>>> that seems to work (even with a faked-up heterogenous config). I've pushed that
>>> to my `arm_pmu/acpi/rework` branch at:
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm_pmu/acpi/rework
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm_pmu/acpi/rework
>>>
>>> ... does that work for you?
>>
>> Thanks for the branch and for looking at this. I think there is an issue for late hotplug
>> CPUs. Indeed the pmu structure allocation is done for the online CPUs at the
>> time of probing. This let rooms for the case where none of the CPUs of a PMU is booted
>> at startup.
> 
> The big problem here is that while we can detect those PMUs late, we only
> register them with the core perf code in arm_pmu_acpi_probe(), so even if we
> detect PMUs after that, those PMUs won't become usable.
> 
> I don't think we can support the case where none of the CPUs associated with a
> PMU are booted at startup unless we make more substantial changes to the way we
> register the PMUs with perf (and that would be going firther than what we
> support with DT).
> 
> We can support bringing those CPUs online, just not registering them with perf.
> 
>> I tried the patch on a Juno-r2 with the 'maxcpus=1 apci=force' parameters. When late
>> hotplugging CPU1 (which has a different pmu than CPU0), no pmu structure is found and
>> the cpuhp state machine fails (since arm_pmu_acpi_cpu_starting() failed).
> 
> Ah, sorry, I missed that returning an error here would completely halt bringing
> the CPU online. We arm_pmu_acpi_cpu_starting() to return 0 rather than -ENOENT
> when it doesn't find a matching PMU, which would permit the CPU to come online.
> 
> I've made that change (and pushed that out to the branch), and it seems to work
> for me, testing in a UEFI+ACPI VM on a ThunderX2, with the arm_pmu_acpi code
> hacked to use the cpu index (rather than the MIDR) as the identifier for the
> type of CPU.
> 
> With that change, booting a 64-vCPU VM with 'maxcpus=8', I see each of the
> boot-time CPUs had its PMU registered:
> 
> | # ls /sys/bus/event_source/devices/
> | armv8_pmuv3_0  armv8_pmuv3_3  armv8_pmuv3_6  software
> | armv8_pmuv3_1  armv8_pmuv3_4  armv8_pmuv3_7  tracepoint
> | armv8_pmuv3_2  armv8_pmuv3_5  breakpoint
> 
> ... and if I try to online a non-matching CPU the CPU will come up, but I get a
> notification that we couldn't associate with a PMU:
> 
> | # echo 1 > /sys/devices/system/cpu/cpu8/online
> | Detected PIPT I-cache on CPU8
> | GICv3: CPU8: found redistributor 8 region 0:0x00000000081a0000
> | GICv3: CPU8: using allocated LPI pending table @0x0000000040290000
> | Unable to associate CPU8 with a PMU
> | CPU8: Booted secondary processor 0x0000000008 [0x431f0af1]
> 
> If I do the same thing but without the MIDR hack, it also seems to work:
> 
> | # ls /sys/bus/event_source/devices/
> | armv8_pmuv3_0  breakpoint     software       tracepoint
> | # cat /sys/bus/event_source/devices/armv8_pmuv3_0/cpus
> | 0-7
> | # echo 1 > /sys/devices/system/cpu/cpu10/online
> | Detected PIPT I-cache on CPU10
> | GICv3: CPU10: found redistributor a region 0:0x00000000081e0000
> | GICv3: CPU10: using allocated LPI pending table @0x00000000402b0000
> | CPU10: Booted secondary processor 0x000000000a [0x431f0af1]
> | # ls /sys/bus/event_source/devices/
> | armv8_pmuv3_0  breakpoint     software       tracepoint
> | # cat /sys/bus/event_source/devices/armv8_pmuv3_0/cpus
> | 0-7,10
> 
> ... so I think that should be ok?

Ok yes, thanks for the explanation. I tried it aswel and everything
was as expected.Just some typos:

patch 1:
factor out PMU<->CPU assocition
-> association
A subsequeqnt patch will rework the ACPI probing of PMUs, and we'll need
-> subsequent

patch 2:
A subsequeqnt patch will rework the ACPI probing of PMUs, and we'll need
-> subsequent

patch 3:
The current ACPI PMU probing logic tries to aassociate PMUs with CPUs
works. The arm_pmu_acpi_cpu_starting() callback only tries to assocaite
though we will now warn when we cannot assocaite a CPU with a PMU.
-> associate (for the 3 lines)

Regards,
Pierre

> 
> Thanks,
> Mark.
