Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F9A668B19
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjAMFMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjAMFL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:11:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4104A5F491
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 21:11:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31F14FEC;
        Thu, 12 Jan 2023 21:12:38 -0800 (PST)
Received: from [10.162.41.9] (unknown [10.162.41.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F5F83F587;
        Thu, 12 Jan 2023 21:11:54 -0800 (PST)
Message-ID: <bdcc2d71-b216-ade6-203d-0a527d0503ff@arm.com>
Date:   Fri, 13 Jan 2023 10:41:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V7 5/6] arm64/perf: Add branch stack support in ARMV8 PMU
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-6-anshuman.khandual@arm.com>
 <Y8AZXQJUO6h5mlgq@FVFF77S0Q05N>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y8AZXQJUO6h5mlgq@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/23 19:59, Mark Rutland wrote:
> On Thu, Jan 05, 2023 at 08:40:38AM +0530, Anshuman Khandual wrote:
>> This enables support for branch stack sampling event in ARMV8 PMU, checking
>> has_branch_stack() on the event inside 'struct arm_pmu' callbacks. Although
>> these branch stack helpers armv8pmu_branch_XXXXX() are just dummy functions
>> for now. While here, this also defines arm_pmu's sched_task() callback with
>> armv8pmu_sched_task(), which resets the branch record buffer on a sched_in.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/perf_event.h | 10 +++++++++
>>  arch/arm64/kernel/perf_event.c      | 35 +++++++++++++++++++++++++++++
>>  2 files changed, 45 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
>> index 3eaf462f5752..a038902d6874 100644
>> --- a/arch/arm64/include/asm/perf_event.h
>> +++ b/arch/arm64/include/asm/perf_event.h
>> @@ -273,4 +273,14 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
>>  	(regs)->pstate = PSR_MODE_EL1h;	\
>>  }
>>  
>> +struct pmu_hw_events;
>> +struct arm_pmu;
>> +struct perf_event;
>> +
>> +static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event) { }
>> +static inline bool armv8pmu_branch_valid(struct perf_event *event) { return false; }
>> +static inline void armv8pmu_branch_enable(struct perf_event *event) { }
>> +static inline void armv8pmu_branch_disable(struct perf_event *event) { }
>> +static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
>> +static inline void armv8pmu_branch_reset(void) { }
> 
> As far as I can tell, these are not supposed to be called when
> !has_branch_stack(), so it would be good if these had a WARN() or similar to
> spot buggy usage.

This is actually true except the last two helper functions, which get called in the
generic PMU context i.e while probing or resetting the PMU. While probing it is not
yet known whether the PMU supports branch stack or not, but while resetting the PMU
arm_pmu_branch_stack_supported() is checked to ensure there is a buffer to be reset
via a special instruction. Will change the first four functions to add warnings in
case the event is not a branch stack one.

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index cf2e88c7b707..ab1d180e17a6 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -285,10 +285,27 @@ void armv8pmu_branch_disable(struct perf_event *event);
 void armv8pmu_branch_probe(struct arm_pmu *arm_pmu);
 void armv8pmu_branch_reset(void);
 #else
-static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event) { }
-static inline bool armv8pmu_branch_valid(struct perf_event *event) { return false; }
-static inline void armv8pmu_branch_enable(struct perf_event *event) { }
-static inline void armv8pmu_branch_disable(struct perf_event *event) { }
+static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
+{
+       WARN_ON_ONCE(!has_branch_stack(event));
+}
+
+static inline bool armv8pmu_branch_valid(struct perf_event *event)
+{
+       WARN_ON_ONCE(!has_branch_stack(event));
+       return false;
+}
+
+static inline void armv8pmu_branch_enable(struct perf_event *event)
+{
+       WARN_ON_ONCE(!has_branch_stack(event));
+}
+
+static inline void armv8pmu_branch_disable(struct perf_event *event)
+{
+       WARN_ON_ONCE(!has_branch_stack(event));
+}
+
 static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
 static inline void armv8pmu_branch_reset(void) { }
 #endif



> 
>>  #endif
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index a5193f2146a6..8805b4516088 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -789,10 +789,22 @@ static void armv8pmu_enable_event(struct perf_event *event)
>>  	 * Enable counter
>>  	 */
>>  	armv8pmu_enable_event_counter(event);
>> +
>> +	/*
>> +	 * Enable BRBE
>> +	 */
>> +	if (has_branch_stack(event))
>> +		armv8pmu_branch_enable(event);
>>  }
> 
> This looks fine, but tbh I think we should delete the existing comments above
> each function call as they're blindingly obvious and just waste space.
> 
>>  static void armv8pmu_disable_event(struct perf_event *event)
>>  {
>> +	/*
>> +	 * Disable BRBE
>> +	 */
>> +	if (has_branch_stack(event))
>> +		armv8pmu_branch_disable(event);
>> +
> 
> Likewise here.

Dropped all the comments in armv8pmu_enable_event() and in armv8pmu_disable_event()
and removed the redundant interleaving lines as well.

> 
>>  	/*
>>  	 * Disable counter
>>  	 */
>> @@ -878,6 +890,13 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>>  		if (!armpmu_event_set_period(event))
>>  			continue;
>>  
>> +		if (has_branch_stack(event)) {
>> +			WARN_ON(!cpuc->branches);
>> +			armv8pmu_branch_read(cpuc, event);
>> +			data.br_stack = &cpuc->branches->branch_stack;
>> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
>> +		}
> 
> How do we ensure the data we're getting isn't changed under our feet? Is BRBE
> disabled at this point?

Right, BRBE is paused after a PMU IRQ. We also ensure the buffer is disabled for
all exception levels, i.e removing BRBCR_EL1_E0BRE/E1BRE from the configuration,
before initiating the actual read, which eventually populates the data.br_stack.

> 
> Is this going to have branches after taking the exception, or does BRBE stop
> automatically at that point? If so we presumably need to take special care as
> to when we read this relative to enabling/disabling and/or manipulating the
> overflow bits.

The default BRBE configuration includes setting BRBCR_EL1.FZP, enabling BRBE to
be paused automatically, right after a PMU IRQ. Regardless, before reading the
buffer, BRBE is paused (BRBFCR_EL1.PAUSED) and disabled for all privilege levels
~(BRBCR_EL1.E0BRE/E1BRE) which ensures that no new branch record is getting into
the buffer, while it is being read for perf right buffer.

> 
>> +
>>  		/*
>>  		 * Perf event overflow will queue the processing of the event as
>>  		 * an irq_work which will be taken care of in the handling of
>> @@ -976,6 +995,14 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
>>  	return event->hw.idx;
>>  }
>>  
>> +static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
>> +{
>> +	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
>> +
>> +	if (sched_in && arm_pmu_branch_stack_supported(armpmu))
>> +		armv8pmu_branch_reset();
>> +}
> 
> When scheduling out, shouldn't we save what we have so far?
> 
> It seems odd that we just throw that away rather than placing it into a FIFO.

IIRC we had discussed this earlier, save and restore mechanism will be added
later, not during this enablement patch series. For now resetting the buffer
ensures that branch records from one session does not get into another. Note
that these branches cannot be pushed into perf ring buffer either, as there
was no corresponding PMU interrupt to be associated with.
