Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469FE63B9CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbiK2G1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiK2G1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:27:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 012B4532C0;
        Mon, 28 Nov 2022 22:27:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5613AD6E;
        Mon, 28 Nov 2022 22:27:07 -0800 (PST)
Received: from [10.162.41.67] (unknown [10.162.41.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C7343F67D;
        Mon, 28 Nov 2022 22:26:56 -0800 (PST)
Message-ID: <5e7fdfd1-4b1f-e6ff-0ef2-1be00aad8cf3@arm.com>
Date:   Tue, 29 Nov 2022 11:56:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V5 5/7] arm64/perf: Drive BRBE from perf event states
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20221107062514.2851047-1-anshuman.khandual@arm.com>
 <20221107062514.2851047-6-anshuman.khandual@arm.com>
 <Y3fLtK95qctxcKgR@FVFF77S0Q05N.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y3fLtK95qctxcKgR@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/22 23:45, Mark Rutland wrote:
> On Mon, Nov 07, 2022 at 11:55:12AM +0530, Anshuman Khandual wrote:
>> Branch stack sampling rides along the normal perf event and all the branch
>> records get captured during the PMU interrupt. This just changes perf event
>> handling on the arm64 platform to accommodate required BRBE operations that
>> will enable branch stack sampling support.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/kernel/perf_event.c |  7 ++++++
>>  drivers/perf/arm_pmu.c         | 40 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index c97377e28288..97db333d1208 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -874,6 +874,13 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>>  		if (!armpmu_event_set_period(event))
>>  			continue;
>>  
>> +		if (has_branch_stack(event)) {
>> +			cpu_pmu->brbe_read(cpuc, event);
>> +			data.br_stack = &cpuc->branches->brbe_stack;
>> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
>> +			cpu_pmu->brbe_reset(cpuc);
>> +		}
>> +
>>  		/*
>>  		 * Perf event overflow will queue the processing of the event as
>>  		 * an irq_work which will be taken care of in the handling of
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index 5048a500441e..1a8dca4e513e 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -271,12 +271,22 @@ armpmu_stop(struct perf_event *event, int flags)
>>  {
>>  	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
>>  	struct hw_perf_event *hwc = &event->hw;
>> +	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
>>  
>>  	/*
>>  	 * ARM pmu always has to update the counter, so ignore
>>  	 * PERF_EF_UPDATE, see comments in armpmu_start().
>>  	 */
>>  	if (!(hwc->state & PERF_HES_STOPPED)) {
>> +		if (has_branch_stack(event)) {
>> +			WARN_ON_ONCE(!hw_events->brbe_users);
>> +			hw_events->brbe_users--;
>> +			if (!hw_events->brbe_users) {
>> +				hw_events->brbe_context = NULL;
>> +				armpmu->brbe_disable(hw_events);
>> +			}
>> +		}
> 
> Can't we do the actual enable/disable we start/stop the PMU as a whole?
> 
> If we just counted the numberoof users here we could do the actual
> enable/disable in armpmu_{enable,disable}() or armv8pmu_{start,stop}(), like we
> do when checking hw_events->used_mask.

Right, it can be moved inside armv8pmu_{enable, disable}

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 7b0643fe2f13..e64832bc83ba 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -789,6 +789,19 @@ static void armv8pmu_enable_event(struct perf_event *event)
         * Enable counter
         */
        armv8pmu_enable_event_counter(event);
+
+       if (has_branch_stack(event)) {
+               struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+               struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
+
+               if (event->ctx->task && hw_events->brbe_context != event->ctx) {
+                       arm64_pmu_brbe_reset(hw_events);
+                       hw_events->brbe_context = event->ctx;
+               }
+               hw_events->brbe_users++;
+               arm64_pmu_brbe_enable(event);
+       }
 }
 
 static void armv8pmu_disable_event(struct perf_event *event)
@@ -802,6 +815,14 @@ static void armv8pmu_disable_event(struct perf_event *event)
         * Disable interrupt for this counter
         */
        armv8pmu_disable_event_irq(event);
+
+       if (has_branch_stack(event)) {
+               struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+               struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
+
+               if (!hw_events->brbe_users)
+                       arm64_pmu_brbe_disable(event);
+       }
 }
 

> 
> [...]
> 
>> @@ -349,6 +368,10 @@ armpmu_add(struct perf_event *event, int flags)
>>  	hw_events->events[idx] = event;
>>  
>>  	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
>> +
>> +	if (has_branch_stack(event))
>> +		armpmu->brbe_filter(hw_events, event);
> 
> What exactly do we need to do here? Since the BRBE is shared, I'm suprised that
> there's any pwer-event configuration beyond "yes" or "no". 

Entire arm64_pmu_brbe_filter() can be moved inside arm64_pmu_brbe_enable().

> 
>> +
>>  	if (flags & PERF_EF_START)
>>  		armpmu_start(event, PERF_EF_RELOAD);
>>  
>> @@ -443,6 +466,7 @@ __hw_perf_event_init(struct perf_event *event)
>>  {
>>  	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
>>  	struct hw_perf_event *hwc = &event->hw;
>> +	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
>>  	int mapping;
>>  
>>  	hwc->flags = 0;
>> @@ -492,6 +516,9 @@ __hw_perf_event_init(struct perf_event *event)
>>  		local64_set(&hwc->period_left, hwc->sample_period);
>>  	}
>>  
>> +	if (has_branch_stack(event))
>> +		armpmu->brbe_filter(hw_events, event);
> 
> I do not understand why we would use hw_events here; at this point the event
> has only been created, and not even added yet; it doesn't have a counter index.
> isn't even being installed into HW.
> 
> What am I missing?

perf event's requested branch sampling attributes need to be transferred into the
BRBE HW config, when the event gets scheduled on a given CPU. But this transfer
happens in two stages.

event -----> pmu_hw_events ----> BRBE HW

1. event->attr.branch_sample_type --> pmu_hw_events.[brbcr,brbfcr] (event add)
2. pmu_hw_events.[brbcr,brbfcr]   --> BRBXXX_EL1 registers	   (event enable)

But I guess both these stages can be done in event_enable() and the intermediary
pmu_hw_events.[brbcr,brbfcr] elements can also be dropped.

> 
>> +
>>  	return validate_group(event);
>>  }
>>  
>> @@ -520,6 +547,18 @@ static int armpmu_event_init(struct perf_event *event)
>>  	return __hw_perf_event_init(event);
>>  }
>>  
>> +static void armpmu_sched_task(struct perf_event_context *ctx, bool sched_in)
>> +{
>> +	struct arm_pmu *armpmu = to_arm_pmu(ctx->pmu);
>> +	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
>> +
>> +	if (!hw_events->brbe_users)
>> +		return;
>> +
>> +	if (sched_in)
>> +		armpmu->brbe_reset(hw_events);
> 
> I see that LBR does a save/restore, whereas IIUC here we discard without even
> reading the old values. Is that the intent? Shouldn't we snapshot them into the
> task context?

Yes, currently that is the intent. We cannot let the branch records from one task
slip across into another task corrupting the capture on the later. Only Intel LBR
implements such task context save/restore via hw_events, only when LBR call stack
feature is supported otherwise, all other sched_task() implementation just flush
or invalidate captured branches before changing the context.

We could implement such BRBE context store/restore mechanism via given BRBXXXINJ
registers/instructions. But this would make our context switch bit expensive and
also might not provide substantial benefit as well. Although this can be explored
later after the initial enablement.
