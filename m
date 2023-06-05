Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AA67227B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjFENnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFENnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:43:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB60A92;
        Mon,  5 Jun 2023 06:43:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31326D75;
        Mon,  5 Jun 2023 06:44:25 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.25.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79A9C3F663;
        Mon,  5 Jun 2023 06:43:37 -0700 (PDT)
Date:   Mon, 5 Jun 2023 14:43:34 +0100
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
Subject: Re: [PATCH V11 06/10] arm64/perf: Enable branch stack events via
 FEAT_BRBE
Message-ID: <ZH3mhorKNo77hsv5@FVFF77S0Q05N>
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-7-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531040428.501523-7-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 09:34:24AM +0530, Anshuman Khandual wrote:
> This enables branch stack sampling events in ARMV8 PMU, via an architecture
> feature FEAT_BRBE aka branch record buffer extension. This defines required
> branch helper functions pmuv8pmu_branch_XXXXX() and the implementation here
> is wrapped with a new config option CONFIG_ARM64_BRBE.

[...]

> +int armv8pmu_private_alloc(struct arm_pmu *arm_pmu)
> +{
> +	struct brbe_hw_attr *brbe_attr = kzalloc(sizeof(struct brbe_hw_attr), GFP_KERNEL);
> +
> +	if (!brbe_attr)
> +		return -ENOMEM;
> +
> +	arm_pmu->private = brbe_attr;
> +	return 0;
> +}
> +
> +void armv8pmu_private_free(struct arm_pmu *arm_pmu)
> +{
> +	kfree(arm_pmu->private);
> +}

As on the previous patch, I think these should go for now.

[...]

> +static int brbe_attributes_probe(struct arm_pmu *armpmu, u32 brbe)
> +{
> +	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)armpmu->private;
> +	u64 brbidr = read_sysreg_s(SYS_BRBIDR0_EL1);
> +
> +	brbe_attr->brbe_version = brbe;
> +	brbe_attr->brbe_format = brbe_get_format(brbidr);
> +	brbe_attr->brbe_cc = brbe_get_cc_bits(brbidr);
> +	brbe_attr->brbe_nr = brbe_get_numrec(brbidr);

I think we can store the BRBIDR0_EL1 value directly in arm_pmu as a single
value, and extract the fields as required, like we do for PMMIDR.

[...]

> +static u64 branch_type_to_brbcr(int branch_type)
> +{
> +	u64 brbcr = BRBCR_EL1_DEFAULT_TS;
> +
> +	/*
> +	 * BRBE need not be paused on PMU interrupt while tracing only
> +	 * the user space, bcause it will automatically be inside the
> +	 * prohibited region. But even after PMU overflow occurs, the
> +	 * interrupt could still take much more cycles, before it can
> +	 * be taken and by that time BRBE will have been overwritten.
> +	 * Let's enable pause on PMU interrupt mechanism even for user
> +	 * only traces.
> +	 */
> +	brbcr |= BRBCR_EL1_FZP;

I think this is trying to say that we *should* use FZP when sampling the
kernel (due to IRQ latency), and *can* safely use it when sampling userspace,
so it would be good to explain it that way around.

It's a bit unfortunate, because where this matters we'll always be losing some
branches either way, but I guess we don't have much say in the matter.

[...]

> +/*
> + * A branch record with BRBINFx_EL1.LASTFAILED set, implies that all
> + * preceding consecutive branch records, that were in a transaction
> + * (i.e their BRBINFx_EL1.TX set) have been aborted.
> + *
> + * Similarly BRBFCR_EL1.LASTFAILED set, indicate that all preceding
> + * consecutive branch records up to the last record, which were in a
> + * transaction (i.e their BRBINFx_EL1.TX set) have been aborted.
> + *
> + * --------------------------------- -------------------
> + * | 00 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
> + * --------------------------------- -------------------
> + * | 01 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
> + * --------------------------------- -------------------
> + * | 02 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
> + * --------------------------------- -------------------
> + * | 03 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + * | 04 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + * | 05 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 1 |
> + * --------------------------------- -------------------
> + * | .. | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
> + * --------------------------------- -------------------
> + * | 61 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + * | 62 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + * | 63 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> + * --------------------------------- -------------------
> + *
> + * BRBFCR_EL1.LASTFAILED == 1
> + *
> + * BRBFCR_EL1.LASTFAILED fails all those consecutive, in transaction
> + * branches records near the end of the BRBE buffer.
> + *
> + * Architecture does not guarantee a non transaction (TX = 0) branch
> + * record between two different transactions. So it is possible that
> + * a subsequent lastfailed record (TX = 0, LF = 1) might erroneously
> + * mark more than required transactions as aborted.
> + */

Linux doesn't currently support TME (and IIUC no-one has built it), so can't we
delete the transaction handling for now? We can add a comment with somehing like:

/*
 * TODO: add transaction handling for TME.
 */

Assuming no-one has built TME, we might also be able to get an architectural
fix to disambiguate the boundary between two transactions, and avoid the
problem described above.

[...]

> +void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
> +{
> +	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)cpuc->percpu_pmu->private;
> +	u64 brbfcr, brbcr;
> +	int idx, loop1_idx1, loop1_idx2, loop2_idx1, loop2_idx2, count;
> +
> +	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
> +	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> +
> +	/* Ensure pause on PMU interrupt is enabled */
> +	WARN_ON_ONCE(!(brbcr & BRBCR_EL1_FZP));
> +
> +	/* Pause the buffer */
> +	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> +	isb();
> +
> +	/* Determine the indices for each loop */
> +	loop1_idx1 = BRBE_BANK0_IDX_MIN;
> +	if (brbe_attr->brbe_nr <= BRBE_BANK_MAX_ENTRIES) {
> +		loop1_idx2 = brbe_attr->brbe_nr - 1;
> +		loop2_idx1 = BRBE_BANK1_IDX_MIN;
> +		loop2_idx2 = BRBE_BANK0_IDX_MAX;
> +	} else {
> +		loop1_idx2 = BRBE_BANK0_IDX_MAX;
> +		loop2_idx1 = BRBE_BANK1_IDX_MIN;
> +		loop2_idx2 = brbe_attr->brbe_nr - 1;
> +	}
> +
> +	/* Loop through bank 0 */
> +	select_brbe_bank(BRBE_BANK_IDX_0);
> +	for (idx = 0, count = loop1_idx1; count <= loop1_idx2; idx++, count++) {
> +		if (!capture_branch_entry(cpuc, event, idx))
> +			goto skip_bank_1;
> +	}
> +
> +	/* Loop through bank 1 */
> +	select_brbe_bank(BRBE_BANK_IDX_1);
> +	for (count = loop2_idx1; count <= loop2_idx2; idx++, count++) {
> +		if (!capture_branch_entry(cpuc, event, idx))
> +			break;
> +	}
> +
> +skip_bank_1:
> +	cpuc->branches->branch_stack.nr = idx;
> +	cpuc->branches->branch_stack.hw_idx = -1ULL;
> +	process_branch_aborts(cpuc);
> +
> +	/* Unpause the buffer */
> +	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> +	isb();
> +	armv8pmu_branch_reset();
> +}

The loop indicies are rather difficult to follow, and I think those can be made
quite a lot simpler if split out, e.g.

| int __armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
| {
| 	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)cpuc->percpu_pmu->private;
| 	int nr_hw_entries = brbe_attr->brbe_nr;
| 	int idx;
| 
| 	select_brbe_bank(BRBE_BANK_IDX_0);
| 	while (idx < nr_hw_entries && idx < BRBE_BANK0_IDX_MAX) {
| 		if (!capture_branch_entry(cpuc, event, idx))
| 			return idx;
| 		idx++;
| 	}
| 
| 	select_brbe_bank(BRBE_BANK_IDX_1);
| 	while (idx < nr_hw_entries && idx < BRBE_BANK1_IDX_MAX) {
| 		if (!capture_branch_entry(cpuc, event, idx))
| 			return idx;
| 		idx++;
| 	}
| 
| 	return idx;
| }
| 
| void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
| {
| 	u64 brbfcr, brbcr;
| 	int nr;
| 
| 	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
| 	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
| 
| 	/* Ensure pause on PMU interrupt is enabled */
| 	WARN_ON_ONCE(!(brbcr & BRBCR_EL1_FZP));
| 
| 	/* Pause the buffer */
| 	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
| 	isb();
| 
| 	nr = __armv8pmu_branch_read(cpus, event);
| 
| 	cpuc->branches->branch_stack.nr = nr;
| 	cpuc->branches->branch_stack.hw_idx = -1ULL;
| 	process_branch_aborts(cpuc);
| 
| 	/* Unpause the buffer */
| 	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
| 	isb();
| 	armv8pmu_branch_reset();
| }

Looking at <linux/perf_event.h> I see:

| /*
|  * branch stack layout:
|  *  nr: number of taken branches stored in entries[]
|  *  hw_idx: The low level index of raw branch records
|  *          for the most recent branch.
|  *          -1ULL means invalid/unknown.
|  *
|  * Note that nr can vary from sample to sample
|  * branches (to, from) are stored from most recent
|  * to least recent, i.e., entries[0] contains the most
|  * recent branch.
|  * The entries[] is an abstraction of raw branch records,
|  * which may not be stored in age order in HW, e.g. Intel LBR.
|  * The hw_idx is to expose the low level index of raw
|  * branch record for the most recent branch aka entries[0].
|  * The hw_idx index is between -1 (unknown) and max depth,
|  * which can be retrieved in /sys/devices/cpu/caps/branches.
|  * For the architectures whose raw branch records are
|  * already stored in age order, the hw_idx should be 0.
|  */
| struct perf_branch_stack {
|         __u64                           nr;  
|         __u64                           hw_idx;
|         struct perf_branch_entry        entries[];
| };

... which seems to indicate we should be setting hw_idx to 0, since IIUC our
records are in age order.

[...]

> @@ -1142,14 +1146,25 @@ static void __armv8pmu_probe_pmu(void *info)
>  
>  static int branch_records_alloc(struct arm_pmu *armpmu)
>  {
> +	struct branch_records __percpu *tmp_alloc_ptr;
> +	struct branch_records *records;
>  	struct pmu_hw_events *events;
>  	int cpu;
>  
> +	tmp_alloc_ptr = alloc_percpu_gfp(struct branch_records, GFP_KERNEL);
> +	if (!tmp_alloc_ptr)
> +		return -ENOMEM;
> +
> +	/*
> +	 * FIXME: Memory allocated via tmp_alloc_ptr gets completely
> +	 * consumed here, never required to be freed up later. Hence
> +	 * losing access to on stack 'tmp_alloc_ptr' is acceptible.
> +	 * Otherwise this alloc handle has to be saved some where.
> +	 */
>  	for_each_possible_cpu(cpu) {
>  		events = per_cpu_ptr(armpmu->hw_events, cpu);
> -		events->branches = kzalloc(sizeof(struct branch_records), GFP_KERNEL);
> -		if (!events->branches)
> -			return -ENOMEM;
> +		records = per_cpu_ptr(tmp_alloc_ptr, cpu);
> +		events->branches = records;
>  	}
>  	return 0;
>  }

As on a prior patch, I think either this should be the approach from the start,
or we should have cleanup for the kzalloc, and either way this should not be a
part of this patch.

If you use the approach in this patch, please rename "tmp_alloc_pointer" for
clarity, and move the temporaries into the loop, e.g.

| static int branch_records_alloc(struct arm_pmu *armpmu)
| {
| 	struct branch_records __percpu *records;
| 	int cpu;
| 
| 	records = alloc_percpu_gfp(struct branch_records, GFP_KERNEL);
| 	if (!records)
| 		return -ENOMEM;
| 
| 	for_each_possible_cpu(cpu) {
| 		struct pmu_hw_events *events_cpu;
| 		struct branch_records *records_cpu;
| 
| 		events_cpu = per_cpu_ptr(armpmu->hw_events, cpu);
| 		records_cpu = per_cpu_ptr(records, cpu);
| 		events_cpu->branches = records_cpu;
| 	}
|	
| 	return 0;
| }

Thanks,
Mark.
