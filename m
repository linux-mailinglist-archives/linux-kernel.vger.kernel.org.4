Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3225C722054
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjFEH6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjFEH6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:58:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A644E9;
        Mon,  5 Jun 2023 00:58:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A670D75;
        Mon,  5 Jun 2023 00:59:07 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.24.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACF123F793;
        Mon,  5 Jun 2023 00:58:19 -0700 (PDT)
Date:   Mon, 5 Jun 2023 08:58:16 +0100
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
Subject: Re: [PATCH V11 03/10] arm64/perf: Add branch stack support in struct
 arm_pmu
Message-ID: <ZH2VmOUuZobZMcc/@FVFF77S0Q05N>
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-4-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531040428.501523-4-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 09:34:21AM +0530, Anshuman Khandual wrote:
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
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/perf/arm_pmu.c       |  3 +--
>  include/linux/perf/arm_pmu.h | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index aada47e3b126..d4a4f2bd89a5 100644
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
> index f7fbd162ca4c..0da745eaf426 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -102,7 +102,9 @@ struct arm_pmu {
>  	int		(*map_event)(struct perf_event *event);
>  	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
>  	int		num_events;
> -	bool		secure_access; /* 32-bit ARM only */
> +	unsigned int	secure_access	: 1, /* 32-bit ARM only */
> +			has_branch_stack: 1, /* 64-bit ARM only */
> +			reserved	: 30;
>  #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
>  	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
>  #define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE	0x4000
> @@ -118,8 +120,16 @@ struct arm_pmu {
>  
>  	/* Only to be used by ACPI probing code */
>  	unsigned long acpi_cpuid;
> +
> +	/* Implementation specific attributes */
> +	void		*private;
>  };
>  
> +static inline bool arm_pmu_branch_stack_supported(struct arm_pmu *armpmu)
> +{
> +	return armpmu->has_branch_stack;
> +}

Since this is a trivial test, and we already access the 'secure_access' field
directly, I'd prefer we removed this helper and directly accessesed
arm_pmu::has_branch_stack, e.g. with the logic in armpmu_event_init() being:

	if (has_branch_stack(event) && !armpmu->has_branch_stack)
		return -EOPNOTSUPP;

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
