Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A412B68F829
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjBHTgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjBHTgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:36:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 725B44672E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:36:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 956A44B3;
        Wed,  8 Feb 2023 11:36:46 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62E4E3F703;
        Wed,  8 Feb 2023 11:36:03 -0800 (PST)
Date:   Wed, 8 Feb 2023 19:36:00 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH V7 5/6] arm64/perf: Add branch stack support in ARMV8 PMU
Message-ID: <Y+P5oGRfdaCYRkbL@FVFF77S0Q05N.cambridge.arm.com>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-6-anshuman.khandual@arm.com>
 <Y8AZXQJUO6h5mlgq@FVFF77S0Q05N>
 <bdcc2d71-b216-ade6-203d-0a527d0503ff@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdcc2d71-b216-ade6-203d-0a527d0503ff@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 10:41:51AM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/12/23 19:59, Mark Rutland wrote:
> > On Thu, Jan 05, 2023 at 08:40:38AM +0530, Anshuman Khandual wrote:
> >> @@ -878,6 +890,13 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
> >>  		if (!armpmu_event_set_period(event))
> >>  			continue;
> >>  
> >> +		if (has_branch_stack(event)) {
> >> +			WARN_ON(!cpuc->branches);
> >> +			armv8pmu_branch_read(cpuc, event);
> >> +			data.br_stack = &cpuc->branches->branch_stack;
> >> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
> >> +		}
> > 
> > How do we ensure the data we're getting isn't changed under our feet? Is BRBE
> > disabled at this point?
> 
> Right, BRBE is paused after a PMU IRQ. We also ensure the buffer is disabled for
> all exception levels, i.e removing BRBCR_EL1_E0BRE/E1BRE from the configuration,
> before initiating the actual read, which eventually populates the data.br_stack.

Ok; just to confirm, what exactly is the condition that enforces that BRBE is
disabled? Is that *while* there's an overflow asserted, or does something else
get set at the instant the overflow occurs?

What exactly is necessary for it to start again?

> > Is this going to have branches after taking the exception, or does BRBE stop
> > automatically at that point? If so we presumably need to take special care as
> > to when we read this relative to enabling/disabling and/or manipulating the
> > overflow bits.
> 
> The default BRBE configuration includes setting BRBCR_EL1.FZP, enabling BRBE to
> be paused automatically, right after a PMU IRQ. Regardless, before reading the
> buffer, BRBE is paused (BRBFCR_EL1.PAUSED) and disabled for all privilege levels
> ~(BRBCR_EL1.E0BRE/E1BRE) which ensures that no new branch record is getting into
> the buffer, while it is being read for perf right buffer.

Ok; I think we could do with some comments as to this.

> 
> > 
> >> +
> >>  		/*
> >>  		 * Perf event overflow will queue the processing of the event as
> >>  		 * an irq_work which will be taken care of in the handling of
> >> @@ -976,6 +995,14 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
> >>  	return event->hw.idx;
> >>  }
> >>  
> >> +static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
> >> +{
> >> +	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
> >> +
> >> +	if (sched_in && arm_pmu_branch_stack_supported(armpmu))
> >> +		armv8pmu_branch_reset();
> >> +}
> > 
> > When scheduling out, shouldn't we save what we have so far?
> > 
> > It seems odd that we just throw that away rather than placing it into a FIFO.
> 
> IIRC we had discussed this earlier, save and restore mechanism will be added
> later, not during this enablement patch series. 

Sorry, but why?

I don't understand why it's acceptable to non-deterministically throw away data
for now. At the least that's going to confuse users, especially as the
observable behaviour may change if and when that's added later.

I assume that there's some reason that it's painful to do that? Could you
please elaborate on that?

> For now resetting the buffer ensures that branch records from one session
> does not get into another. 

I agree that it's necessary to do that, but as above I don't believe it's
sufficient.

> Note that these branches cannot be pushed into perf ring buffer either, as
> there was no corresponding PMU interrupt to be associated with.

I'm not suggesting we put it in the perf ring buffer; I'm suggesting that we
snapshot it into *some* kernel-internal storage, then later reconcile that.

Maybe that's far more painful than I expect?

Thanks,
Mark.
