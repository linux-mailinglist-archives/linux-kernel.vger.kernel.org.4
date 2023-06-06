Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F95723FB0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjFFKfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbjFFKfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:35:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0356D10E2;
        Tue,  6 Jun 2023 03:34:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02A8B2F4;
        Tue,  6 Jun 2023 03:35:32 -0700 (PDT)
Received: from [10.163.44.166] (unknown [10.163.44.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF9B23F587;
        Tue,  6 Jun 2023 03:34:34 -0700 (PDT)
Message-ID: <ba396c30-6719-1dfb-77c2-9f7e1715b57c@arm.com>
Date:   Tue, 6 Jun 2023 16:04:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V11 05/10] arm64/perf: Add branch stack support in ARMV8
 PMU
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-6-anshuman.khandual@arm.com>
 <ZH3PCqYt/UzoiVx3@FVFF77S0Q05N>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZH3PCqYt/UzoiVx3@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/23 17:35, Mark Rutland wrote:
> On Wed, May 31, 2023 at 09:34:23AM +0530, Anshuman Khandual wrote:
>> This enables support for branch stack sampling event in ARMV8 PMU, checking
>> has_branch_stack() on the event inside 'struct arm_pmu' callbacks. Although
>> these branch stack helpers armv8pmu_branch_XXXXX() are just dummy functions
>> for now. While here, this also defines arm_pmu's sched_task() callback with
>> armv8pmu_sched_task(), which resets the branch record buffer on a sched_in.
> 
> This generally looks good, but I have a few comments below.
> 
> [...]
> 
>> +static inline bool armv8pmu_branch_valid(struct perf_event *event)
>> +{
>> +	WARN_ON_ONCE(!has_branch_stack(event));
>> +	return false;
>> +}
> 
> IIUC this is for validating the attr, so could we please name this
> armv8pmu_branch_attr_valid() ?

Sure, will change the name and updated call sites.

> 
> [...]
> 
>> +static int branch_records_alloc(struct arm_pmu *armpmu)
>> +{
>> +	struct pmu_hw_events *events;
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		events = per_cpu_ptr(armpmu->hw_events, cpu);
>> +		events->branches = kzalloc(sizeof(struct branch_records), GFP_KERNEL);
>> +		if (!events->branches)
>> +			return -ENOMEM;
>> +	}
>> +	return 0;
> 
> This leaks memory if any allocation fails, and the next patch replaces this
> code entirely.

Okay.

> 
> Please add this once in a working state. Either use the percpu allocation
> trick in the next patch from the start, or have this kzalloc() with a
> corresponding kfree() in an error path.

I will change branch_records_alloc() as suggested in the next patch's thread
and fold those changes here in this patch.

> 
>>  }
>>  
>>  static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
>> @@ -1145,12 +1162,24 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
>>  	};
>>  	int ret;
>>  
>> +	ret = armv8pmu_private_alloc(cpu_pmu);
>> +	if (ret)
>> +		return ret;
>> +
>>  	ret = smp_call_function_any(&cpu_pmu->supported_cpus,
>>  				    __armv8pmu_probe_pmu,
>>  				    &probe, 1);
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (arm_pmu_branch_stack_supported(cpu_pmu)) {
>> +		ret = branch_records_alloc(cpu_pmu);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		armv8pmu_private_free(cpu_pmu);
>> +	}
> 
> I see from the next patch that "private" is four ints, so please just add that
> to struct arm_pmu under an ifdef CONFIG_ARM64_BRBE. That'll simplify this, and
> if we end up needing more space in future we can consider factoring it out.

struct arm_pmu {
	........................................
        /* Implementation specific attributes */
        void            *private;
}

private pointer here creates an abstraction for given pmu implementation
to hide attribute details without making it known to core arm pmu layer.
Although adding ifdef CONFIG_ARM64_BRBE solves the problem as mentioned
above, it does break that abstraction. Currently arm_pmu layer is aware
about 'branch records' but not about BRBE in particular which the driver
adds later on. I suggest we should not break that abstraction.

Instead a global 'static struct brbe_hw_attr' in drivers/perf/arm_brbe.c
can be initialized into arm_pmu->private during armv8pmu_branch_probe(),
which will also solve the allocation-free problem. Also similar helpers
armv8pmu_task_ctx_alloc()/free() could be defined to manage task context
cache i.e arm_pmu->pmu.task_ctx_cache independently.

But now armv8pmu_task_ctx_alloc() can be called after pmu probe confirms
to have arm_pmu->has_branch_stack.

> 
>> +
>>  	return probe.present ? 0 : -ENODEV;
>>  }
> 
> It also seems odd to ceck probe.present *after* checking
> arm_pmu_branch_stack_supported().

I will reorganize as suggested below.

> 
> With the allocation removed I think this can be written more clearly as:
> 
> | static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
> | {
> |         struct armv8pmu_probe_info probe = {
> |                 .pmu = cpu_pmu,
> |                 .present = false,
> |         };   
> |         int ret; 
> | 
> |         ret = smp_call_function_any(&cpu_pmu->supported_cpus,
> |                                     __armv8pmu_probe_pmu,
> |                                     &probe, 1);
> |         if (ret)
> |                 return ret; > | 
> |         if (!probe.present)
> |                 return -ENODEV;
> | 
> |         if (arm_pmu_branch_stack_supported(cpu_pmu))
> |                 ret = branch_records_alloc(cpu_pmu);
> |              
> |         return ret; 
> | }
