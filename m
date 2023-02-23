Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446516A0B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjBWNsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjBWNsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:48:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCBB512BEB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:47:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8137FEC;
        Thu, 23 Feb 2023 05:48:20 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA2273F881;
        Thu, 23 Feb 2023 05:47:36 -0800 (PST)
Date:   Thu, 23 Feb 2023 13:47:34 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH V7 5/6] arm64/perf: Add branch stack support in ARMV8 PMU
Message-ID: <Y/dudjSnIFtHzNRI@FVFF77S0Q05N.cambridge.arm.com>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-6-anshuman.khandual@arm.com>
 <Y8AZXQJUO6h5mlgq@FVFF77S0Q05N>
 <bdcc2d71-b216-ade6-203d-0a527d0503ff@arm.com>
 <Y+P5oGRfdaCYRkbL@FVFF77S0Q05N.cambridge.arm.com>
 <f952612b-db37-c21e-4dde-12202768cb44@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f952612b-db37-c21e-4dde-12202768cb44@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 01:53:56PM +0530, Anshuman Khandual wrote:
> 
> 
> On 2/9/23 01:06, Mark Rutland wrote:
> > On Fri, Jan 13, 2023 at 10:41:51AM +0530, Anshuman Khandual wrote:
> >>
> >>
> >> On 1/12/23 19:59, Mark Rutland wrote:
> >>> On Thu, Jan 05, 2023 at 08:40:38AM +0530, Anshuman Khandual wrote:
> >>>> @@ -878,6 +890,13 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
> >>>>  		if (!armpmu_event_set_period(event))
> >>>>  			continue;
> >>>>  
> >>>> +		if (has_branch_stack(event)) {
> >>>> +			WARN_ON(!cpuc->branches);
> >>>> +			armv8pmu_branch_read(cpuc, event);
> >>>> +			data.br_stack = &cpuc->branches->branch_stack;
> >>>> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
> >>>> +		}
> >>>
> >>> How do we ensure the data we're getting isn't changed under our feet? Is BRBE
> >>> disabled at this point?
> >>
> >> Right, BRBE is paused after a PMU IRQ. We also ensure the buffer is disabled for
> >> all exception levels, i.e removing BRBCR_EL1_E0BRE/E1BRE from the configuration,
> >> before initiating the actual read, which eventually populates the data.br_stack.
> > 
> > Ok; just to confirm, what exactly is the condition that enforces that BRBE is
> > disabled? Is that *while* there's an overflow asserted, or does something else
> > get set at the instant the overflow occurs?
> 
> - BRBE can be disabled completely via BRBCR_EL1_E0BRE/E1BRE irrespective of PMU interrupt
> - But with PMU interrupt, it just pauses if BRBCR_EL1_FZP is enabled

IIUC the distinction between "disabled completely" and "just pauses" doesn't
really matter to us, and a pause is sufficient for use to be able to read and
manipulate the records.

I also note that we always set BRBCR_EL1.FZP.

Am I missing something?

Thanks,
Mark.
