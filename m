Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625856DE0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjDKQ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDKQ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:27:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 868243C0D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:27:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A555AD75;
        Tue, 11 Apr 2023 09:27:55 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DC993F73F;
        Tue, 11 Apr 2023 09:27:10 -0700 (PDT)
Message-ID: <2f56057b-08ef-c3a6-8300-33f36d2c3916@arm.com>
Date:   Tue, 11 Apr 2023 17:27:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] perf/arm-dmc620: Reverse locking order in
 dmc620_pmu_get_irq()
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tuanphan@os.amperecomputing.com, suzuki.poulose@arm.com
References: <20230405172842.2663770-1-longman@redhat.com>
 <20230411123823.GA22686@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230411123823.GA22686@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 1:38 pm, Will Deacon wrote:
> Hi Waiman,
> 
> [+Tuan Phan, Robin and Suzuki]
> 
> On Wed, Apr 05, 2023 at 01:28:42PM -0400, Waiman Long wrote:
>> The following circular locking dependency was reported when running
>> cpus online/offline test on an arm64 system.
>>
>> [   84.195923] Chain exists of:
>>                   dmc620_pmu_irqs_lock --> cpu_hotplug_lock --> cpuhp_state-down
>>
>> [   84.207305]  Possible unsafe locking scenario:
>>
>> [   84.213212]        CPU0                    CPU1
>> [   84.217729]        ----                    ----
>> [   84.222247]   lock(cpuhp_state-down);
>> [   84.225899]                                lock(cpu_hotplug_lock);
>> [   84.232068]                                lock(cpuhp_state-down);
>> [   84.238237]   lock(dmc620_pmu_irqs_lock);
>> [   84.242236]
>>                  *** DEADLOCK ***
>>
>> The problematic locking order seems to be
>>
>> 	lock(dmc620_pmu_irqs_lock) --> lock(cpu_hotplug_lock)
>>
>> This locking order happens when dmc620_pmu_get_irq() is called from
>> dmc620_pmu_device_probe(). Fix this possible deadlock scenario by
>> reversing the locking order.
>>
>> Also export __cpuhp_state_add_instance_cpuslocked() so that it can be
>> accessed by kernel modules.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   drivers/perf/arm_dmc620_pmu.c | 4 +++-
>>   kernel/cpu.c                  | 1 +
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
>> index 54aa4658fb36..78d3bfbe96a6 100644
>> --- a/drivers/perf/arm_dmc620_pmu.c
>> +++ b/drivers/perf/arm_dmc620_pmu.c
>> @@ -425,7 +425,7 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
>>   	if (ret)
>>   		goto out_free_irq;
>>   
>> -	ret = cpuhp_state_add_instance_nocalls(cpuhp_state_num, &irq->node);
>> +	ret = cpuhp_state_add_instance_nocalls_cpuslocked(cpuhp_state_num, &irq->node);
>>   	if (ret)
>>   		goto out_free_irq;
>>   
>> @@ -445,9 +445,11 @@ static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num)
>>   {
>>   	struct dmc620_pmu_irq *irq;
>>   
>> +	cpus_read_lock();
>>   	mutex_lock(&dmc620_pmu_irqs_lock);
>>   	irq = __dmc620_pmu_get_irq(irq_num);
>>   	mutex_unlock(&dmc620_pmu_irqs_lock);
>> +	cpus_read_unlock();
>>   
>>   	if (IS_ERR(irq))
>>   		return PTR_ERR(irq);
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 6c0a92ca6bb5..05daaef362e6 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -2036,6 +2036,7 @@ int __cpuhp_state_add_instance_cpuslocked(enum cpuhp_state state,
>>   	mutex_unlock(&cpuhp_state_mutex);
>>   	return ret;
>>   }
>> +EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance_cpuslocked);
> 
> Thanks for the fix, but I think it would be much cleaner if we could handle
> this internally to the driver without having to export additional symbols
> from the hotplug machinery.

Ack, I suspect using distinct locks for the global dmc620_pmu_irqs list 
and the per-IRQ-context PMU lists might be the simplest and cleanest 
way? I don't recall any good reason why I wrote it like it is, and TBH 
it does look a bit fishy with fresh eyes 3 years later.

> Looking at the driver, it looks like it would make more sense to register
> each PMU instance with the cpuhp state machine and avoid having to traverse
> a mutable list, rather than add irq instances.

At least part of it is that this IRQ-sharing machinery was originally[1] 
designed in the shape of driver-agnostic helper functions, because 
munging system PMU interrupts together is a thing people are unlikely to 
stop doing in general. I still expect to need to factor it out some day...

> That said, I really don't grok this comment:
> 
> 	/* We're only reading, but this isn't the place to be involving RCU */
> 
> Given that perf_pmu_migrate_context() calls synchronize_rcu()...

I think that may have been the point - we can't reasonably use RCU to 
protect the list iteration itself here *because* that would then mean 
synchronize_rcu() being called within the read-side critical section. 
The rest was that hotplug was *supposed* to be a context where just 
taking the same lock that serialises against dmc620_pmu_get_irq() 
touching the same list is safe, simple and obvious, even if it's 
stronger than we strictly need.

Cheers,
Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/d73dd8c3579fbf713d6215317404549aede8ad2d.1586363449.git.robin.murphy@arm.com/
