Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0036D693F89
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjBMIYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjBMIYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:24:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB9493598
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:24:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E16C04B3;
        Mon, 13 Feb 2023 00:24:43 -0800 (PST)
Received: from [10.162.41.6] (unknown [10.162.41.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 585053F881;
        Mon, 13 Feb 2023 00:23:59 -0800 (PST)
Message-ID: <f952612b-db37-c21e-4dde-12202768cb44@arm.com>
Date:   Mon, 13 Feb 2023 13:53:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V7 5/6] arm64/perf: Add branch stack support in ARMV8 PMU
To:     Mark Rutland <Mark.Rutland@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-6-anshuman.khandual@arm.com>
 <Y8AZXQJUO6h5mlgq@FVFF77S0Q05N>
 <bdcc2d71-b216-ade6-203d-0a527d0503ff@arm.com>
 <Y+P5oGRfdaCYRkbL@FVFF77S0Q05N.cambridge.arm.com>
Content-Language: en-US
In-Reply-To: <Y+P5oGRfdaCYRkbL@FVFF77S0Q05N.cambridge.arm.com>
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



On 2/9/23 01:06, Mark Rutland wrote:
> On Fri, Jan 13, 2023 at 10:41:51AM +0530, Anshuman Khandual wrote:
>>
>>
>> On 1/12/23 19:59, Mark Rutland wrote:
>>> On Thu, Jan 05, 2023 at 08:40:38AM +0530, Anshuman Khandual wrote:
>>>> @@ -878,6 +890,13 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>>>>  		if (!armpmu_event_set_period(event))
>>>>  			continue;
>>>>  
>>>> +		if (has_branch_stack(event)) {
>>>> +			WARN_ON(!cpuc->branches);
>>>> +			armv8pmu_branch_read(cpuc, event);
>>>> +			data.br_stack = &cpuc->branches->branch_stack;
>>>> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
>>>> +		}
>>>
>>> How do we ensure the data we're getting isn't changed under our feet? Is BRBE
>>> disabled at this point?
>>
>> Right, BRBE is paused after a PMU IRQ. We also ensure the buffer is disabled for
>> all exception levels, i.e removing BRBCR_EL1_E0BRE/E1BRE from the configuration,
>> before initiating the actual read, which eventually populates the data.br_stack.
> 
> Ok; just to confirm, what exactly is the condition that enforces that BRBE is
> disabled? Is that *while* there's an overflow asserted, or does something else
> get set at the instant the overflow occurs?

- BRBE can be disabled completely via BRBCR_EL1_E0BRE/E1BRE irrespective of PMU interrupt
- But with PMU interrupt, it just pauses if BRBCR_EL1_FZP is enabled

> 
> What exactly is necessary for it to start again?

- Unpause via clearing BRBFCR_EL1_PAUSED
- Enable for applicable privilege levels via setting BRBCR_EL1_E0BRE/E1BRE

> 
>>> Is this going to have branches after taking the exception, or does BRBE stop
>>> automatically at that point? If so we presumably need to take special care as
>>> to when we read this relative to enabling/disabling and/or manipulating the
>>> overflow bits.
>>
>> The default BRBE configuration includes setting BRBCR_EL1.FZP, enabling BRBE to
>> be paused automatically, right after a PMU IRQ. Regardless, before reading the
>> buffer, BRBE is paused (BRBFCR_EL1.PAUSED) and disabled for all privilege levels
>> ~(BRBCR_EL1.E0BRE/E1BRE) which ensures that no new branch record is getting into
>> the buffer, while it is being read for perf right buffer.
> 
> Ok; I think we could do with some comments as to this.

Sure, will add a comment, something like this.

diff --git a/arch/arm64/kernel/brbe.c b/arch/arm64/kernel/brbe.c
index 17562d3fb33d..0d6e54e92ee2 100644
--- a/arch/arm64/kernel/brbe.c
+++ b/arch/arm64/kernel/brbe.c
@@ -480,6 +480,13 @@ static bool capture_branch_entry(struct pmu_hw_events *cpuc,
        return true;
 }
 
+/*
+ * This gets called in PMU IRQ handler context. BRBE is configured (BRBCR_EL1.FZP)
+ * to be paused, right after a PMU IRQ. Regardless, before reading branch records,
+ * BRBE explicitly paused (BRBFCR_EL1.PAUSED) and also disabled for all applicable
+ * privilege levels (BRBCR_EL1.E0/E1BRBE) ensuring that no branch record could get
+ * in the BRBE buffer while it is being read.
+ */
 void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
 {
        struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)cpuc->percpu_pmu->private;


> 
>>
>>>
>>>> +
>>>>  		/*
>>>>  		 * Perf event overflow will queue the processing of the event as
>>>>  		 * an irq_work which will be taken care of in the handling of
>>>> @@ -976,6 +995,14 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
>>>>  	return event->hw.idx;
>>>>  }
>>>>  
>>>> +static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
>>>> +{
>>>> +	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
>>>> +
>>>> +	if (sched_in && arm_pmu_branch_stack_supported(armpmu))
>>>> +		armv8pmu_branch_reset();
>>>> +}
>>>
>>> When scheduling out, shouldn't we save what we have so far?
>>>
>>> It seems odd that we just throw that away rather than placing it into a FIFO.
>>
>> IIRC we had discussed this earlier, save and restore mechanism will be added
>> later, not during this enablement patch series. 
> 
> Sorry, but why?
> 
> I don't understand why it's acceptable to non-deterministically throw away data
> for now. At the least that's going to confuse users, especially as the
> observable behaviour may change if and when that's added later.

Each set of branch records captured in BRBE is part of broader statistical
sample which goes into the perf ring buffer. So in absolute terms throwing
away some branch records should not be a problem for the end result. Would
the relative instances of possible task switches be more than all those PMU
interrupts that can be generated between those switches ? I am not sure if
that will create much loss of samples for the overall perf session.

For implementation, we could follow x86 intel_pmu_lbr_sched_task(), which
saves and restores branch records via perf_event_pmu_context->task_ctx_data
with some more changes to CPU specific structure. But restoration involves
writing back the saved branch records into the HW (via BRB INJ instructions
in BRBE case) recreating the buffer state before task switch out happened.
This save/restore mechanism will increase switch out and switch in latency
for tasks being traced for branch stack samples.

Just wondering are those potential lost branch samples worth the increase
in task switch latency ? Should this save/restore be auto enabled for all
tasks ? Should this be done part of the base enablement series itself ?

> 
> I assume that there's some reason that it's painful to do that? Could you
> please elaborate on that?
> 
>> For now resetting the buffer ensures that branch records from one session
>> does not get into another. 
> 
> I agree that it's necessary to do that, but as above I don't believe it's
> sufficient.
> 
>> Note that these branches cannot be pushed into perf ring buffer either, as
>> there was no corresponding PMU interrupt to be associated with.
> 
> I'm not suggesting we put it in the perf ring buffer; I'm suggesting that we
> snapshot it into *some* kernel-internal storage, then later reconcile that.

Only feasible reconciliation would be restore them into the BRBE HW buffer
ensuring their continuity after the task starts back again on the CPU, and
continue capturing records for perf ring buffer during future PMU interrupts.

Saved branch records cannot be pushed into the perf ring buffer, along side
the newer ones, because continuity of branch branch records leading upto the
PMU interrupt will be broken. It might also happen that all restored branch
records might just get overridden by newer branch records, before the next
PMU interrupt, wasting the entire restoration process.

> 
> Maybe that's far more painful than I expect?

I could try and implement save/restore mechanism for BRBE as explained above.
