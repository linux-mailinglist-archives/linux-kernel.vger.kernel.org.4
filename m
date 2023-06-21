Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1938D7384D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjFUNV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjFUNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:21:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 779FE199B;
        Wed, 21 Jun 2023 06:21:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2291A1FB;
        Wed, 21 Jun 2023 06:21:46 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.27.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 198D63F64C;
        Wed, 21 Jun 2023 06:20:59 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:20:57 +0100
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
Subject: Re: [PATCH V12 10/10] arm64/perf: Implement branch records save on
 PMU IRQ
Message-ID: <ZJL5OR4F_2-41Csw@FVFF77S0Q05N>
References: <20230615133239.442736-1-anshuman.khandual@arm.com>
 <20230615133239.442736-11-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615133239.442736-11-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 07:02:39PM +0530, Anshuman Khandual wrote:
> This modifies armv8pmu_branch_read() to concatenate live entries along with
> task context stored entries and then process the resultant buffer to create
> perf branch entry array for perf_sample_data. It follows the same principle
> like task sched out.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

The resulting logic looks fine here, but it would be nicer if we had the
resulting structure from the outset rather than having to rewrite it (i.e. if
when we introduced this we captured all the recores then processed them), as
that would keep the diff minimal and make it much clearer as to what wwas
happening here.

Either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/perf/arm_brbe.c | 69 +++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index 3bb17ced2b1d..d28067c896e2 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c
> @@ -653,41 +653,44 @@ void armv8pmu_branch_reset(void)
>  	isb();
>  }
>  
> -static bool capture_branch_entry(struct pmu_hw_events *cpuc,
> -				 struct perf_event *event, int idx)
> +static void brbe_regset_branch_entries(struct pmu_hw_events *cpuc, struct perf_event *event,
> +				       struct brbe_regset *regset, int idx)
>  {
>  	struct perf_branch_entry *entry = &cpuc->branches->branch_entries[idx];
> -	u64 brbinf = get_brbinf_reg(idx);
> -
> -	/*
> -	 * There are no valid entries anymore on the buffer.
> -	 * Abort the branch record processing to save some
> -	 * cycles and also reduce the capture/process load
> -	 * for the user space as well.
> -	 */
> -	if (brbe_invalid(brbinf))
> -		return false;
> +	u64 brbinf = regset[idx].brbinf;
>  
>  	perf_clear_branch_entry_bitfields(entry);
>  	if (brbe_record_is_complete(brbinf)) {
> -		entry->from = get_brbsrc_reg(idx);
> -		entry->to = get_brbtgt_reg(idx);
> +		entry->from = regset[idx].brbsrc;
> +		entry->to = regset[idx].brbtgt;
>  	} else if (brbe_record_is_source_only(brbinf)) {
> -		entry->from = get_brbsrc_reg(idx);
> +		entry->from = regset[idx].brbsrc;
>  		entry->to = 0;
>  	} else if (brbe_record_is_target_only(brbinf)) {
>  		entry->from = 0;
> -		entry->to = get_brbtgt_reg(idx);
> +		entry->to = regset[idx].brbtgt;
>  	}
>  	capture_brbe_flags(entry, event, brbinf);
> -	return true;
> +}
> +
> +static void process_branch_entries(struct pmu_hw_events *cpuc, struct perf_event *event,
> +				   struct brbe_regset *regset, int nr_regset)
> +{
> +	int idx;
> +
> +	for (idx = 0; idx < nr_regset; idx++)
> +		brbe_regset_branch_entries(cpuc, event, regset, idx);
> +
> +	cpuc->branches->branch_stack.nr = nr_regset;
> +	cpuc->branches->branch_stack.hw_idx = -1ULL;
>  }
>  
>  void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
>  {
> -	int nr_hw_entries = brbe_get_numrec(cpuc->percpu_pmu->reg_brbidr);
> +	struct arm64_perf_task_context *task_ctx = event->pmu_ctx->task_ctx_data;
> +	struct brbe_regset live[BRBE_MAX_ENTRIES];
> +	int nr_live, nr_store, nr_hw_entries;
>  	u64 brbfcr, brbcr;
> -	int idx = 0;
>  
>  	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>  	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> @@ -699,25 +702,17 @@ void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
>  	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>  	isb();
>  
> -	/* Loop through bank 0 */
> -	select_brbe_bank(BRBE_BANK_IDX_0);
> -	while (idx < nr_hw_entries && idx < BRBE_BANK0_IDX_MAX) {
> -		if (!capture_branch_entry(cpuc, event, idx))
> -			goto skip_bank_1;
> -		idx++;
> -	}
> -
> -	/* Loop through bank 1 */
> -	select_brbe_bank(BRBE_BANK_IDX_1);
> -	while (idx < nr_hw_entries && idx < BRBE_BANK1_IDX_MAX) {
> -		if (!capture_branch_entry(cpuc, event, idx))
> -			break;
> -		idx++;
> +	nr_hw_entries = brbe_get_numrec(cpuc->percpu_pmu->reg_brbidr);
> +	nr_live = capture_brbe_regset(nr_hw_entries, live);
> +	if (event->ctx->task) {
> +		nr_store = task_ctx->nr_brbe_records;
> +		nr_store = stitch_stored_live_entries(task_ctx->store, live, nr_store,
> +						      nr_live, nr_hw_entries);
> +		process_branch_entries(cpuc, event, task_ctx->store, nr_store);
> +		task_ctx->nr_brbe_records = 0;
> +	} else {
> +		process_branch_entries(cpuc, event, live, nr_live);
>  	}
> -
> -skip_bank_1:
> -	cpuc->branches->branch_stack.nr = idx;
> -	cpuc->branches->branch_stack.hw_idx = -1ULL;
>  	process_branch_aborts(cpuc);
>  
>  	/* Unpause the buffer */
> -- 
> 2.25.1
> 
