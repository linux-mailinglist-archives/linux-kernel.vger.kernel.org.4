Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4204723FE7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbjFFKnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237297AbjFFKmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:42:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E15EA1BEA;
        Tue,  6 Jun 2023 03:41:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E68562F4;
        Tue,  6 Jun 2023 03:42:09 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95E553F587;
        Tue,  6 Jun 2023 03:41:22 -0700 (PDT)
Date:   Tue, 6 Jun 2023 11:41:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
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
Subject: Re: [PATCH V11 05/10] arm64/perf: Add branch stack support in ARMV8
 PMU
Message-ID: <ZH8NTSYMS4n2/edR@FVFF77S0Q05N.cambridge.arm.com>
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-6-anshuman.khandual@arm.com>
 <ZH3PCqYt/UzoiVx3@FVFF77S0Q05N>
 <ba396c30-6719-1dfb-77c2-9f7e1715b57c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba396c30-6719-1dfb-77c2-9f7e1715b57c@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:04:25PM +0530, Anshuman Khandual wrote:
> On 6/5/23 17:35, Mark Rutland wrote:
> > On Wed, May 31, 2023 at 09:34:23AM +0530, Anshuman Khandual wrote:
> >>  static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
> >> @@ -1145,12 +1162,24 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
> >>  	};
> >>  	int ret;
> >>  
> >> +	ret = armv8pmu_private_alloc(cpu_pmu);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >>  	ret = smp_call_function_any(&cpu_pmu->supported_cpus,
> >>  				    __armv8pmu_probe_pmu,
> >>  				    &probe, 1);
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> +	if (arm_pmu_branch_stack_supported(cpu_pmu)) {
> >> +		ret = branch_records_alloc(cpu_pmu);
> >> +		if (ret)
> >> +			return ret;
> >> +	} else {
> >> +		armv8pmu_private_free(cpu_pmu);
> >> +	}
> > 
> > I see from the next patch that "private" is four ints, so please just add that
> > to struct arm_pmu under an ifdef CONFIG_ARM64_BRBE. That'll simplify this, and
> > if we end up needing more space in future we can consider factoring it out.
> 
> struct arm_pmu {
> 	........................................
>         /* Implementation specific attributes */
>         void            *private;
> }
> 
> private pointer here creates an abstraction for given pmu implementation
> to hide attribute details without making it known to core arm pmu layer.
> Although adding ifdef CONFIG_ARM64_BRBE solves the problem as mentioned
> above, it does break that abstraction. Currently arm_pmu layer is aware
> about 'branch records' but not about BRBE in particular which the driver
> adds later on. I suggest we should not break that abstraction.

I understand the rationale, but I think it's simpler for now to break that
abstraction. We can always refactor it later.

> Instead a global 'static struct brbe_hw_attr' in drivers/perf/arm_brbe.c
> can be initialized into arm_pmu->private during armv8pmu_branch_probe(),
> which will also solve the allocation-free problem. 

IIUC that's not going to work for big.LITTLE systems where the BRBE support
varies, as we need this data per arm_pmu.

> Also similar helpers armv8pmu_task_ctx_alloc()/free() could be defined to
> manage task context cache i.e arm_pmu->pmu.task_ctx_cache independently.
> 
> But now armv8pmu_task_ctx_alloc() can be called after pmu probe confirms
> to have arm_pmu->has_branch_stack.

I think those are different, and should be kept.

Thanks,
Mark.
