Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB56320DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiKULkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiKULkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:40:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81D2AB7F5;
        Mon, 21 Nov 2022 03:39:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEC231FB;
        Mon, 21 Nov 2022 03:39:56 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.25.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D8613F587;
        Mon, 21 Nov 2022 03:39:48 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:39:42 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V5 4/7] driver/perf/arm_pmu_platform: Add support for
 BRBE attributes detection
Message-ID: <Y3tjfg/aPIixPTbs@FVFF77S0Q05N.cambridge.arm.com>
References: <20221107062514.2851047-1-anshuman.khandual@arm.com>
 <20221107062514.2851047-5-anshuman.khandual@arm.com>
 <Y3fIYjGtoXPSX9JQ@FVFF77S0Q05N.cambridge.arm.com>
 <fa55fccc-455c-828a-b5fb-de5cb269e35b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa55fccc-455c-828a-b5fb-de5cb269e35b@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:06:31PM +0530, Anshuman Khandual wrote:
> 
> 
> On 11/18/22 23:31, Mark Rutland wrote:
> > On Mon, Nov 07, 2022 at 11:55:11AM +0530, Anshuman Khandual wrote:
> >> This adds arm pmu infrastrure to probe BRBE implementation's attributes via
> >> driver exported callbacks later. The actual BRBE feature detection will be
> >> added by the driver itself.
> >>
> >> CPU specific BRBE entries, cycle count, format support gets detected during
> >> PMU init. This information gets saved in per-cpu struct pmu_hw_events which
> >> later helps in operating BRBE during a perf event context.
> > 
> > Do we expect this to vary between CPUs handled by the same struct arm_pmu ?
> 
> BRBE registers are per CPU, and the spec does not assert about BRBE properties
> being the same across the system, served via same the struct arm_pmu.

The same is true of the PMU, and struct arm_pmu does not cover the whole
system, it covers each *micro-architecture* within the system.

I think BRBE should be treated the same, i.e. uniform *within* a struct
arm_pmu.

> Hence it would be inaccurate to make that assumption, which might have just
> avoided all these IPI based probes during boot.

FWIW, I would be happy to IPI all CPUs during boot to verify uniformity of CPUs
within an arm_pmu; I just don't think that BRBE should be treated differently
from the rest of the PMU features.

[...]

> >> +	hw_events = per_cpu_ptr(armpmu->hw_events, smp_processor_id());
> >> +	armpmu->brbe_probe(hw_events);
> >> +}
> >> +
> >> +static int armpmu_request_brbe(struct arm_pmu *armpmu)
> >> +{
> >> +	int cpu, err = 0;
> >> +
> >> +	for_each_cpu(cpu, &armpmu->supported_cpus) {
> >> +		err = smp_call_function_single(cpu, arm_brbe_probe_cpu, armpmu, 1);
> > 
> > Why does this need to be called on each CPU in the supported_cpus mask?
> 
> Is not supported_cpus derived after partitioning the IRQ in pmu_parse_percpu_irq().
> The idea is to fill up BRBE buffer attributes, on all such supported cpus which could
> trigger PMU interrupt. Is the concern, that not all cpus in supported_cpus mask might
> not be online during boot, hence IPIs could not be served, hence BRBE attributed for
> them could not be fetched ?

As above, I think this is solvable if we mandate that BRBE must be uniform
*within* an arm_pmu's supported CPUs; then we only need one CPU in the
supported_cpus mask to be present at boot time, as with the rest of the PMU
code.

We could *verify* that when onlining a CPU.

> > I don't see anything here to handle late hotplug, so this looks suspicious.
> 
> Right, I should add cpu hotplug handling, otherwise risk loosing BRBE support on cpus
> which might have been offline during boot i.e when above IPI based probe happened ?
> 
> > Either we're missing something, or it's redundant at boot time.
> 
> Should we add cpu hotplug online-offline handlers like some other PMU drivers ? Let
> me know if there are some other concerns.
> 
> cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, DRVNAME,
> 			arm_brbe_cpu_startup,
> 		        arm_brbe_cpu_teardown)

We *could* add that, but that's going to require ordering against the existing
hooks for probing arm_pmu.

Why can't this hang off the exising hooks for arm_pmu? We're treating this as
part of the PMU anyway, so I don't understand why we should probe it
separately.

Thanks,
Mark.
