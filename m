Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C47697FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjBOPzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBOPzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:55:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B8D77DB2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:55:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27A271042;
        Wed, 15 Feb 2023 07:56:18 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CDA53F881;
        Wed, 15 Feb 2023 07:55:33 -0800 (PST)
Message-ID: <2af0ec8d-891c-f690-bfd6-b0e02597f391@arm.com>
Date:   Wed, 15 Feb 2023 16:55:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v2] firmware: arm_sdei: Fix sleep from invalid context BUG
To:     James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
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
 <5813b8c5-ae3e-87fd-fccc-94c9cd08816d@arm.com>
Content-Language: en-US
In-Reply-To: <5813b8c5-ae3e-87fd-fccc-94c9cd08816d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello James,

On 2/10/23 18:42, James Morse wrote:
> Hi Pierre,
> 
> Sorry its taken so long for me to catch up with this ...

No worries.

> 
> On 18/10/2022 14:04, Pierre Gondois wrote:
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
> 
>> sdei_cpuhp_up() is called in the STARTING hotplug section,
>> which runs whith interrupts disabled. Move CPUHP_AP_ARM_SDEI_
>> state to the _ONLINE section to execute the cpuhp cb with
>> preemption enabled.
> 
> The background to this is SDEI got its own cpuhp slot because 'perf NMI' support
> was one of the use-cases, but this got superseded by pNMI. Without an interaction with
> perf, the slot doesn't need to be that early.
> 
> 
>> Some SDEI calls (e.g. SDEI_1_0_FN_SDEI_PE_MASK) take actions on the
>> calling CPU. It is checked that preemption is disabled for them.
>> _ONLINE cpuhp cb are executed in the 'per CPU hotplug thread'.
>> Preemption is enabled in those threads, but their cpumask is limited
>> to 1 CPU.
> 
>> Move 'WARN_ON_ONCE(preemptible())' statements so that SDEI cpuhp cb
>> don't trigger them. This means that no check will be done for some
>> cases, e.g. sdei_mask_local_cpu() invocations.
> 
> (these things are documentation anyway)
> 
> 
>> Also add a check for the SDEI_1_0_FN_SDEI_PRIVATE_RESET SDEI call
>> which acts on the calling CPU.
> 
>> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
>> index 1e1a51510e83..9b03e164a37a 100644
>> --- a/drivers/firmware/arm_sdei.c
>> +++ b/drivers/firmware/arm_sdei.c
> 
>> @@ -401,6 +399,8 @@ int sdei_event_enable(u32 event_num)
>>   	int err = -EINVAL;
>>   	struct sdei_event *event;
>>   
>> +	WARN_ON_ONCE(preemptible());
>> +
>>   	mutex_lock(&sdei_events_lock);
>>   	event = sdei_event_find(event_num);
>>   	if (!event) {
> 
> This doesn't look right. How can this code take a mutex if its in a non-preemptable context?
> 
>> @@ -492,6 +490,7 @@ int sdei_event_unregister(u32 event_num)
>>   	struct sdei_event *event;
>>   
>>   	WARN_ON(in_nmi());
>> +	WARN_ON_ONCE(preemptible());
>>   
>>   	mutex_lock(&sdei_events_lock);
>>   	event = sdei_event_find(event_num);
> 
> Same again.
> 
>> @@ -576,6 +573,7 @@ int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
>>   	struct sdei_event *event;
>>   
>>   	WARN_ON(in_nmi());
>> +	WARN_ON_ONCE(preemptible());
>>   
>>   	mutex_lock(&sdei_events_lock);
>>   	if (sdei_event_find(event_num)) {
> 
> Same again.
> 
> I think you've copied these here because they called _local_event_unregister(), but they
> did that via on_each_cpu(), which is what made _local_event_unregister() non-preemtable.

Yes right, these 3 warnings don't really make sense. They will be removed.

> 
> You can just remove these three, the original warnings were mostly documentation, and to
> catch myself out. (before RT moved the goal posts).
> 
> With that:
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> (could you trim the [timestamps] out of the commit log?)

Yes sure.

> 
> 
>> @@ -765,7 +765,7 @@ static int sdei_device_freeze(struct device *dev)
>>   	int err;
>>   
>>   	/* unregister private events */
>> -	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_STARTING);
>> +	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_ONLINE);
> 
> Is there any mileage in making this CPUHP_AP_ONLINE_DYN ?
> Perf really was the only reason that this needed to happen in any particular order.

Ok I will do that.

Thanks for the review,
Regards,
Pierre

> 
> 
> Thanks,
> 
> James
