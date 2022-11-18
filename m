Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC13F62FC1D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241877AbiKRSBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiKRSBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:01:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B438F2CC96;
        Fri, 18 Nov 2022 10:01:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6C9423A;
        Fri, 18 Nov 2022 10:01:17 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.34.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 993613F663;
        Fri, 18 Nov 2022 10:01:09 -0800 (PST)
Date:   Fri, 18 Nov 2022 18:01:06 +0000
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
Message-ID: <Y3fIYjGtoXPSX9JQ@FVFF77S0Q05N.cambridge.arm.com>
References: <20221107062514.2851047-1-anshuman.khandual@arm.com>
 <20221107062514.2851047-5-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107062514.2851047-5-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 11:55:11AM +0530, Anshuman Khandual wrote:
> This adds arm pmu infrastrure to probe BRBE implementation's attributes via
> driver exported callbacks later. The actual BRBE feature detection will be
> added by the driver itself.
> 
> CPU specific BRBE entries, cycle count, format support gets detected during
> PMU init. This information gets saved in per-cpu struct pmu_hw_events which
> later helps in operating BRBE during a perf event context.

Do we expect this to vary between CPUs handled by the same struct arm_pmu ?

> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/perf/arm_pmu_platform.c | 34 +++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
> index 933b96e243b8..acdc445081aa 100644
> --- a/drivers/perf/arm_pmu_platform.c
> +++ b/drivers/perf/arm_pmu_platform.c
> @@ -172,6 +172,36 @@ static int armpmu_request_irqs(struct arm_pmu *armpmu)
>  	return err;
>  }
>  
> +static void arm_brbe_probe_cpu(void *info)
> +{
> +	struct pmu_hw_events *hw_events;
> +	struct arm_pmu *armpmu = info;
> +
> +	/*
> +	 * Return from here, if BRBE driver has not been
> +	 * implemented for this PMU. This helps prevent
> +	 * kernel crash later when brbe_probe() will be
> +	 * called on the PMU.
> +	 */
> +	if (!armpmu->brbe_probe)
> +		return;

Since this is a field on struct arm_pmu, why doesn't armpmu_request_brbe()
check this before calling smp_call_function_single(), to avoid the redundant
IPI?

> +
> +	hw_events = per_cpu_ptr(armpmu->hw_events, smp_processor_id());
> +	armpmu->brbe_probe(hw_events);
> +}
> +
> +static int armpmu_request_brbe(struct arm_pmu *armpmu)
> +{
> +	int cpu, err = 0;
> +
> +	for_each_cpu(cpu, &armpmu->supported_cpus) {
> +		err = smp_call_function_single(cpu, arm_brbe_probe_cpu, armpmu, 1);

Why does this need to be called on each CPU in the supported_cpus mask?

I don't see anything here to handle late hotplug, so this looks suspicious.
Either we're missing something, or it's redundant at boot time.

Thanks,
Mark.

> +		if (err)
> +			return err;
> +	}
> +	return err;
> +}
> +
>  static void armpmu_free_irqs(struct arm_pmu *armpmu)
>  {
>  	int cpu;
> @@ -229,6 +259,10 @@ int arm_pmu_device_probe(struct platform_device *pdev,
>  	if (ret)
>  		goto out_free_irqs;
>  
> +	ret = armpmu_request_brbe(pmu);
> +	if (ret)
> +		goto out_free_irqs;
> +
>  	ret = armpmu_register(pmu);
>  	if (ret) {
>  		dev_err(dev, "failed to register PMU devices!\n");
> -- 
> 2.25.1
> 
