Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521C87384AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFUNQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjFUNQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:16:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A0C719AB;
        Wed, 21 Jun 2023 06:16:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2982C1042;
        Wed, 21 Jun 2023 06:17:03 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.27.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DE963F64C;
        Wed, 21 Jun 2023 06:16:16 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:16:14 +0100
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
Subject: Re: [PATCH V12 09/10] arm64/perf: Implement branch records save on
 task sched out
Message-ID: <ZJL4HpHCu8-yz1cr@FVFF77S0Q05N>
References: <20230615133239.442736-1-anshuman.khandual@arm.com>
 <20230615133239.442736-10-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615133239.442736-10-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 07:02:38PM +0530, Anshuman Khandual wrote:
> This modifies current armv8pmu_sched_task(), to implement a branch records
> save mechanism via armv8pmu_branch_save() when a task scheds out of a cpu.
> BRBE is paused and disabled for all exception levels before branch records
> get captured, which then get concatenated with all existing stored records
> present in the task context maintaining the contiguity. Although the final
> length of the concatenated buffer does not exceed implemented BRBE length.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/perf_event.h |  2 ++
>  drivers/perf/arm_brbe.c             | 30 +++++++++++++++++++++++++++++
>  drivers/perf/arm_pmuv3.c            | 14 ++++++++++++--
>  3 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
> index b0c12a5882df..36e7dfb466a6 100644
> --- a/arch/arm64/include/asm/perf_event.h
> +++ b/arch/arm64/include/asm/perf_event.h
> @@ -40,6 +40,7 @@ void armv8pmu_branch_probe(struct arm_pmu *arm_pmu);
>  void armv8pmu_branch_reset(void);
>  int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu);
>  void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu);
> +void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx);
>  #else
>  static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
>  {
> @@ -66,6 +67,7 @@ static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
>  static inline void armv8pmu_branch_reset(void) { }
>  static inline int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu) { return 0; }
>  static inline void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu) { }
> +static inline void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx) { }
>  #endif
>  #endif
>  #endif
> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index f6693699fade..3bb17ced2b1d 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c
> @@ -171,6 +171,36 @@ static int stitch_stored_live_entries(struct brbe_regset *stored,
>  	return min(nr_live + nr_stored, nr_max);
>  }
>  
> +static int brbe_branch_save(int nr_hw_entries, struct brbe_regset *live)
> +{
> +	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> +	int nr_live;
> +
> +	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> +	isb();
> +
> +	nr_live = capture_brbe_regset(nr_hw_entries, live);
> +
> +	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> +	isb();
> +
> +	return nr_live;
> +}
> +
> +void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx)
> +{
> +	struct arm64_perf_task_context *task_ctx = ctx;
> +	struct brbe_regset live[BRBE_MAX_ENTRIES];
> +	int nr_live, nr_store, nr_hw_entries;
> +
> +	nr_hw_entries = brbe_get_numrec(arm_pmu->reg_brbidr);
> +	nr_live = brbe_branch_save(nr_hw_entries, live);
> +	nr_store = task_ctx->nr_brbe_records;
> +	nr_store = stitch_stored_live_entries(task_ctx->store, live, nr_store,
> +					      nr_live, nr_hw_entries);
> +	task_ctx->nr_brbe_records = nr_store;
> +}
> +
>  /*
>   * Generic perf branch filters supported on BRBE
>   *
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 3c079051a63a..53f404618891 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -907,9 +907,19 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
>  static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
>  {
>  	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
> +	void *task_ctx = pmu_ctx ? pmu_ctx->task_ctx_data : NULL;
>  
> -	if (sched_in && armpmu->has_branch_stack)
> -		armv8pmu_branch_reset();
> +	if (armpmu->has_branch_stack) {
> +		/* Save branch records in task_ctx on sched out */
> +		if (task_ctx && !sched_in) {
> +			armv8pmu_branch_save(armpmu, task_ctx);
> +			return;
> +		}
> +
> +		/* Reset branch records on sched in */
> +		if (sched_in)
> +			armv8pmu_branch_reset();
> +	}
>  }
>  
>  /*
> -- 
> 2.25.1
> 
