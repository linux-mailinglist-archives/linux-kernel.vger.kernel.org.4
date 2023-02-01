Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A893686B77
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBAQXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjBAQXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:23:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF9B2E04C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:23:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B22C2C14;
        Wed,  1 Feb 2023 08:24:15 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65D533F64C;
        Wed,  1 Feb 2023 08:23:31 -0800 (PST)
Message-ID: <2dce69f3-0a69-b9a3-cdad-2011446a2860@arm.com>
Date:   Wed, 1 Feb 2023 17:23:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] firmware: arm_sdei: Fix sleep from invalid context BUG
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     James Morse <james.morse@arm.com>, Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        WANG Xuerui <git@xen0n.name>, Qi Liu <liuqi115@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Huang Ying <ying.huang@intel.com>,
        Bibo Mao <maobibo@loongson.cn>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20221018130456.1356081-1-pierre.gondois@arm.com>
 <5f6768e9-a301-f16d-d6c0-218b29eeabeb@arm.com>
In-Reply-To: <5f6768e9-a301-f16d-d6c0-218b29eeabeb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello James,
Just a ping in case this was forgotten,

Regards,
Pierre

On 10/18/22 15:07, Pierre Gondois wrote:
> The changelog was removed:
> 
> v2:
> - Don't use a raw spin_lock, but move the CPUHP_AP_ARM_SDEI_
>     cpuhp state to the _ONLINE section.
> 
> 
> On 10/18/22 15:04, Pierre Gondois wrote:
>> On an Ampere Altra,
>> Running a preemp_rt kernel based on v5.19-rc3-rt5 on an
>> Ampere Altra triggers:
>> [   15.683141] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
>> [   15.683154] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 24, name: cpuhp/0
>> [   15.683157] preempt_count: 0, expected: 0
>> [   15.683159] RCU nest depth: 0, expected: 0
>> [   15.683163] 3 locks held by cpuhp/0/24:
>> [   15.683167]  #0: ffffda30217c70d0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x5c/0x248
>> [   15.683201]  #1: ffffda30217c7120 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x5c/0x248
>> [   15.683205]  #2: ffffda3021c711f0 (sdei_list_lock){....}-{3:3}, at: sdei_cpuhp_up+0x3c/0x130
>> [   15.683224] irq event stamp: 36
>> [   15.683226] hardirqs last  enabled at (35): [<ffffda301e85b7bc>] finish_task_switch+0xb4/0x2b0
>> [   15.683236] hardirqs last disabled at (36): [<ffffda301e812fec>] cpuhp_thread_fun+0x21c/0x248
>> [   15.683238] softirqs last  enabled at (0): [<ffffda301e80b184>] copy_process+0x63c/0x1ac0
>> [   15.683245] softirqs last disabled at (0): [<0000000000000000>] 0x0
>> [   15.683258] CPU: 0 PID: 24 Comm: cpuhp/0 Not tainted 5.19.0-rc3-rt5-[...]
>> [   15.683265] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
>> [   15.683268] Call trace:
>> [   15.683271]  dump_backtrace+0x114/0x120
>> [   15.683277]  show_stack+0x20/0x70
>> [   15.683279]  dump_stack_lvl+0x9c/0xd8
>> [   15.683288]  dump_stack+0x18/0x34
>> [   15.683289]  __might_resched+0x188/0x228
>> [   15.683292]  rt_spin_lock+0x70/0x120
>> [   15.683301]  sdei_cpuhp_up+0x3c/0x130
>> [   15.683303]  cpuhp_invoke_callback+0x250/0xf08
>> [   15.683305]  cpuhp_thread_fun+0x120/0x248
>> [   15.683308]  smpboot_thread_fn+0x280/0x320
>> [   15.683315]  kthread+0x130/0x140
>> [   15.683321]  ret_from_fork+0x10/0x20
>>
>> sdei_cpuhp_up() is called in the STARTING hotplug section,
>> which runs whith interrupts disabled. Move CPUHP_AP_ARM_SDEI_
>> state to the _ONLINE section to execute the cpuhp cb with
>> preemption enabled.
>>
>> Some SDEI calls (e.g. SDEI_1_0_FN_SDEI_PE_MASK) take actions on the
>> calling CPU. It is checked that preemption is disabled for them.
>> _ONLINE cpuhp cb are executed in the 'per CPU hotplug thread'.
>> Preemption is enabled in those threads, but their cpumask is limited
>> to 1 CPU.
>> Move 'WARN_ON_ONCE(preemptible())' statements so that SDEI cpuhp cb
>> don't trigger them. This means that no check will be done for some
>> cases, e.g. sdei_mask_local_cpu() invocations.
>>
>> Also add a check for the SDEI_1_0_FN_SDEI_PRIVATE_RESET SDEI call
>> which acts on the calling CPU.
>>
>> Suggested-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>    drivers/firmware/arm_sdei.c | 28 ++++++++++++++--------------
>>    include/linux/cpuhotplug.h  |  2 +-
>>    2 files changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
>> index 1e1a51510e83..9b03e164a37a 100644
>> --- a/drivers/firmware/arm_sdei.c
>> +++ b/drivers/firmware/arm_sdei.c
>> @@ -301,8 +301,6 @@ int sdei_mask_local_cpu(void)
>>    {
>>    	int err;
>>    
>> -	WARN_ON_ONCE(preemptible());
>> -
>>    	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_PE_MASK, 0, 0, 0, 0, 0, NULL);
>>    	if (err && err != -EIO) {
>>    		pr_warn_once("failed to mask CPU[%u]: %d\n",
>> @@ -315,6 +313,7 @@ int sdei_mask_local_cpu(void)
>>    
>>    static void _ipi_mask_cpu(void *ignored)
>>    {
>> +	WARN_ON_ONCE(preemptible());
>>    	sdei_mask_local_cpu();
>>    }
>>    
>> @@ -322,8 +321,6 @@ int sdei_unmask_local_cpu(void)
>>    {
>>    	int err;
>>    
>> -	WARN_ON_ONCE(preemptible());
>> -
>>    	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_PE_UNMASK, 0, 0, 0, 0, 0, NULL);
>>    	if (err && err != -EIO) {
>>    		pr_warn_once("failed to unmask CPU[%u]: %d\n",
>> @@ -336,6 +333,7 @@ int sdei_unmask_local_cpu(void)
>>    
>>    static void _ipi_unmask_cpu(void *ignored)
>>    {
>> +	WARN_ON_ONCE(preemptible());
>>    	sdei_unmask_local_cpu();
>>    }
>>    
>> @@ -343,6 +341,8 @@ static void _ipi_private_reset(void *ignored)
>>    {
>>    	int err;
>>    
>> +	WARN_ON_ONCE(preemptible());
>> +
>>    	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_PRIVATE_RESET, 0, 0, 0, 0, 0,
>>    			     NULL);
>>    	if (err && err != -EIO)
>> @@ -389,8 +389,6 @@ static void _local_event_enable(void *data)
>>    	int err;
>>    	struct sdei_crosscall_args *arg = data;
>>    
>> -	WARN_ON_ONCE(preemptible());
>> -
>>    	err = sdei_api_event_enable(arg->event->event_num);
>>    
>>    	sdei_cross_call_return(arg, err);
>> @@ -401,6 +399,8 @@ int sdei_event_enable(u32 event_num)
>>    	int err = -EINVAL;
>>    	struct sdei_event *event;
>>    
>> +	WARN_ON_ONCE(preemptible());
>> +
>>    	mutex_lock(&sdei_events_lock);
>>    	event = sdei_event_find(event_num);
>>    	if (!event) {
>> @@ -479,8 +479,6 @@ static void _local_event_unregister(void *data)
>>    	int err;
>>    	struct sdei_crosscall_args *arg = data;
>>    
>> -	WARN_ON_ONCE(preemptible());
>> -
>>    	err = sdei_api_event_unregister(arg->event->event_num);
>>    
>>    	sdei_cross_call_return(arg, err);
>> @@ -492,6 +490,7 @@ int sdei_event_unregister(u32 event_num)
>>    	struct sdei_event *event;
>>    
>>    	WARN_ON(in_nmi());
>> +	WARN_ON_ONCE(preemptible());
>>    
>>    	mutex_lock(&sdei_events_lock);
>>    	event = sdei_event_find(event_num);
>> @@ -561,8 +560,6 @@ static void _local_event_register(void *data)
>>    	struct sdei_registered_event *reg;
>>    	struct sdei_crosscall_args *arg = data;
>>    
>> -	WARN_ON(preemptible());
>> -
>>    	reg = per_cpu_ptr(arg->event->private_registered, smp_processor_id());
>>    	err = sdei_api_event_register(arg->event->event_num, sdei_entry_point,
>>    				      reg, 0, 0);
>> @@ -576,6 +573,7 @@ int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
>>    	struct sdei_event *event;
>>    
>>    	WARN_ON(in_nmi());
>> +	WARN_ON_ONCE(preemptible());
>>    
>>    	mutex_lock(&sdei_events_lock);
>>    	if (sdei_event_find(event_num)) {
>> @@ -717,6 +715,8 @@ static int sdei_pm_notifier(struct notifier_block *nb, unsigned long action,
>>    {
>>    	int rv;
>>    
>> +	WARN_ON_ONCE(preemptible());
>> +
>>    	switch (action) {
>>    	case CPU_PM_ENTER:
>>    		rv = sdei_mask_local_cpu();
>> @@ -765,7 +765,7 @@ static int sdei_device_freeze(struct device *dev)
>>    	int err;
>>    
>>    	/* unregister private events */
>> -	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_STARTING);
>> +	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_ONLINE);
>>    
>>    	err = sdei_unregister_shared();
>>    	if (err)
>> @@ -786,7 +786,7 @@ static int sdei_device_thaw(struct device *dev)
>>    		return err;
>>    	}
>>    
>> -	err = cpuhp_setup_state(CPUHP_AP_ARM_SDEI_STARTING, "SDEI",
>> +	err = cpuhp_setup_state(CPUHP_AP_ARM_SDEI_ONLINE, "SDEI",
>>    				&sdei_cpuhp_up, &sdei_cpuhp_down);
>>    	if (err)
>>    		pr_warn("Failed to re-register CPU hotplug notifier...\n");
>> @@ -823,7 +823,7 @@ static int sdei_reboot_notifier(struct notifier_block *nb, unsigned long action,
>>    	 * We are going to reset the interface, after this there is no point
>>    	 * doing work when we take CPUs offline.
>>    	 */
>> -	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_STARTING);
>> +	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_ONLINE);
>>    
>>    	sdei_platform_reset();
>>    
>> @@ -1003,7 +1003,7 @@ static int sdei_probe(struct platform_device *pdev)
>>    		goto remove_cpupm;
>>    	}
>>    
>> -	err = cpuhp_setup_state(CPUHP_AP_ARM_SDEI_STARTING, "SDEI",
>> +	err = cpuhp_setup_state(CPUHP_AP_ARM_SDEI_ONLINE, "SDEI",
>>    				&sdei_cpuhp_up, &sdei_cpuhp_down);
>>    	if (err) {
>>    		pr_warn("Failed to register CPU hotplug notifier...\n");
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index f61447913db9..63b89e00a4c3 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -161,7 +161,6 @@ enum cpuhp_state {
>>    	CPUHP_AP_PERF_X86_CSTATE_STARTING,
>>    	CPUHP_AP_PERF_XTENSA_STARTING,
>>    	CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
>> -	CPUHP_AP_ARM_SDEI_STARTING,
>>    	CPUHP_AP_ARM_VFP_STARTING,
>>    	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
>>    	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
>> @@ -209,6 +208,7 @@ enum cpuhp_state {
>>    	CPUHP_AP_IRQ_AFFINITY_ONLINE,
>>    	CPUHP_AP_BLK_MQ_ONLINE,
>>    	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
>> +	CPUHP_AP_ARM_SDEI_ONLINE,
>>    	CPUHP_AP_X86_INTEL_EPB_ONLINE,
>>    	CPUHP_AP_PERF_ONLINE,
>>    	CPUHP_AP_PERF_X86_ONLINE,
