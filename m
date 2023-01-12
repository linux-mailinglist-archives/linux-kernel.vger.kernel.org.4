Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDEE667739
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbjALOkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbjALOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:40:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 628CD5D6AA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:29:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DC0913D5;
        Thu, 12 Jan 2023 06:30:35 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.43.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DAEE3F67D;
        Thu, 12 Jan 2023 06:29:52 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:29:49 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH V7 5/6] arm64/perf: Add branch stack support in ARMV8 PMU
Message-ID: <Y8AZXQJUO6h5mlgq@FVFF77S0Q05N>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-6-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105031039.207972-6-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 08:40:38AM +0530, Anshuman Khandual wrote:
> This enables support for branch stack sampling event in ARMV8 PMU, checking
> has_branch_stack() on the event inside 'struct arm_pmu' callbacks. Although
> these branch stack helpers armv8pmu_branch_XXXXX() are just dummy functions
> for now. While here, this also defines arm_pmu's sched_task() callback with
> armv8pmu_sched_task(), which resets the branch record buffer on a sched_in.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/perf_event.h | 10 +++++++++
>  arch/arm64/kernel/perf_event.c      | 35 +++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
> index 3eaf462f5752..a038902d6874 100644
> --- a/arch/arm64/include/asm/perf_event.h
> +++ b/arch/arm64/include/asm/perf_event.h
> @@ -273,4 +273,14 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
>  	(regs)->pstate = PSR_MODE_EL1h;	\
>  }
>  
> +struct pmu_hw_events;
> +struct arm_pmu;
> +struct perf_event;
> +
> +static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event) { }
> +static inline bool armv8pmu_branch_valid(struct perf_event *event) { return false; }
> +static inline void armv8pmu_branch_enable(struct perf_event *event) { }
> +static inline void armv8pmu_branch_disable(struct perf_event *event) { }
> +static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
> +static inline void armv8pmu_branch_reset(void) { }

As far as I can tell, these are not supposed to be called when
!has_branch_stack(), so it would be good if these had a WARN() or similar to
spot buggy usage.

>  #endif
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index a5193f2146a6..8805b4516088 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -789,10 +789,22 @@ static void armv8pmu_enable_event(struct perf_event *event)
>  	 * Enable counter
>  	 */
>  	armv8pmu_enable_event_counter(event);
> +
> +	/*
> +	 * Enable BRBE
> +	 */
> +	if (has_branch_stack(event))
> +		armv8pmu_branch_enable(event);
>  }

This looks fine, but tbh I think we should delete the existing comments above
each function call as they're blindingly obvious and just waste space.

>  static void armv8pmu_disable_event(struct perf_event *event)
>  {
> +	/*
> +	 * Disable BRBE
> +	 */
> +	if (has_branch_stack(event))
> +		armv8pmu_branch_disable(event);
> +

Likewise here.

>  	/*
>  	 * Disable counter
>  	 */
> @@ -878,6 +890,13 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>  		if (!armpmu_event_set_period(event))
>  			continue;
>  
> +		if (has_branch_stack(event)) {
> +			WARN_ON(!cpuc->branches);
> +			armv8pmu_branch_read(cpuc, event);
> +			data.br_stack = &cpuc->branches->branch_stack;
> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
> +		}

How do we ensure the data we're getting isn't changed under our feet? Is BRBE
disabled at this point?

Is this going to have branches after taking the exception, or does BRBE stop
automatically at that point? If so we presumably need to take special care as
to when we read this relative to enabling/disabling and/or manipulating the
overflow bits.

> +
>  		/*
>  		 * Perf event overflow will queue the processing of the event as
>  		 * an irq_work which will be taken care of in the handling of
> @@ -976,6 +995,14 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
>  	return event->hw.idx;
>  }
>  
> +static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
> +{
> +	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
> +
> +	if (sched_in && arm_pmu_branch_stack_supported(armpmu))
> +		armv8pmu_branch_reset();
> +}

When scheduling out, shouldn't we save what we have so far?

It seems odd that we just throw that away rather than placing it into a FIFO.

Thanks,
Mark.
