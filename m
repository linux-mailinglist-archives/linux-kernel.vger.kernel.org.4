Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52946673AE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjALNyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjALNyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:54:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75B0F50061
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:54:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4964613D5;
        Thu, 12 Jan 2023 05:54:56 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.43.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D08C3F67D;
        Thu, 12 Jan 2023 05:54:13 -0800 (PST)
Date:   Thu, 12 Jan 2023 13:54:10 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH V7 3/6] arm64/perf: Add branch stack support in struct
 arm_pmu
Message-ID: <Y8ARAjUaE44y+Cw3@FVFF77S0Q05N>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-4-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105031039.207972-4-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 08:40:36AM +0530, Anshuman Khandual wrote:
> This updates 'struct arm_pmu' for branch stack sampling support later. This
> adds a new 'features' element in the structure to track supported features,
> and another 'private' element to encapsulate implementation attributes on a
> given 'struct arm_pmu'. These updates here will help in tracking any branch
> stack sampling support, which is being added later. This also adds a helper
> arm_pmu_branch_stack_supported().
> 
> This also enables perf branch stack sampling event on all 'struct arm pmu',
> supporting the feature but after removing the current gate that blocks such
> events unconditionally in armpmu_event_init(). Instead a quick probe can be
> initiated via arm_pmu_branch_stack_supported() to ascertain the support.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/perf/arm_pmu.c       | 3 +--
>  include/linux/perf/arm_pmu.h | 9 +++++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 14a3ed3bdb0b..a85b2d67022e 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -510,8 +510,7 @@ static int armpmu_event_init(struct perf_event *event)
>  		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
>  		return -ENOENT;
>  
> -	/* does not support taken branch sampling */
> -	if (has_branch_stack(event))
> +	if (has_branch_stack(event) && !arm_pmu_branch_stack_supported(armpmu))
>  		return -EOPNOTSUPP;
>  
>  	return __hw_perf_event_init(event);
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 2a9d07cee927..64e1b2594025 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -80,11 +80,14 @@ enum armpmu_attr_groups {
>  	ARMPMU_NR_ATTR_GROUPS
>  };
>  
> +#define ARM_PMU_BRANCH_STACK	BIT(0)
> +
>  struct arm_pmu {
>  	struct pmu	pmu;
>  	cpumask_t	supported_cpus;
>  	char		*name;
>  	int		pmuver;
> +	int		features;
>  	irqreturn_t	(*handle_irq)(struct arm_pmu *pmu);
>  	void		(*enable)(struct perf_event *event);
>  	void		(*disable)(struct perf_event *event);

Hmm, we already have the secure_access field separately. How about we fold that
in and go with:

	unsigned int	secure_access    : 1,
			has_branch_stack : 1;

... that way we have one way to manage flags, we don't need to allocate the
bits, and the bulk of the existing code for secure_access can stay as-is.

> @@ -119,8 +122,14 @@ struct arm_pmu {
>  
>  	/* Only to be used by ACPI probing code */
>  	unsigned long acpi_cpuid;
> +	void		*private;

Does this need to be on the end of struct arm_pmu, or can it be placed earlier?

The line spacing makes it look like the ACPI comment applies to 'private',
which isn't the case.

>  };
>  
> +static inline bool arm_pmu_branch_stack_supported(struct arm_pmu *armpmu)
> +{
> +	return armpmu->features & ARM_PMU_BRANCH_STACK;
> +}

With the above, this would become:

static inline bool arm_pmu_branch_stack_supported(struct arm_pmu *armpmu)
{
	return armpmu->has_branch_stack;
}

Thanks,
Mark.

> +
>  #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
>  
>  u64 armpmu_event_update(struct perf_event *event);
> -- 
> 2.25.1
> 
