Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3AC72E942
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbjFMRSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbjFMRR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:17:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1CB2172A;
        Tue, 13 Jun 2023 10:17:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 823872F4;
        Tue, 13 Jun 2023 10:18:40 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.39.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B390D3F663;
        Tue, 13 Jun 2023 10:17:53 -0700 (PDT)
Date:   Tue, 13 Jun 2023 18:17:51 +0100
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
Subject: Re: [PATCH V11 08/10] arm64/perf: Add struct brbe_regset helper
 functions
Message-ID: <ZIikv0bW1xGeLf6B@FVFF77S0Q05N.cambridge.arm.com>
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-9-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531040428.501523-9-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 09:34:26AM +0530, Anshuman Khandual wrote:
> The primary abstraction level for fetching branch records from BRBE HW has
> been changed as 'struct brbe_regset', which contains storage for all three
> BRBE registers i.e BRBSRC, BRBTGT, BRBINF. Whether branch record processing
> happens in the task sched out path, or in the PMU IRQ handling path, these
> registers need to be extracted from the HW. Afterwards both live and stored
> sets need to be stitched together to create final branch records set. This
> adds required helper functions for such operations.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/perf/arm_brbe.c | 163 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
> 
> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index 484842d8cf3e..759db681d673 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c
> @@ -44,6 +44,169 @@ static void select_brbe_bank(int bank)
>  	isb();
>  }
>  
> +/*
> + * This scans over BRBE register banks and captures individual branch reocrds
> + * [BRBSRC, BRBTGT, BRBINF] into a pre-allocated 'struct brbe_regset' buffer,
> + * until an invalid one gets encountered. The caller for this function needs
> + * to ensure BRBE is an appropriate state before the records can be captured.
> + */
> +static int capture_brbe_regset(struct brbe_hw_attr *brbe_attr, struct brbe_regset *buf)
> +{
> +	int loop1_idx1, loop1_idx2, loop2_idx1, loop2_idx2;
> +	int idx, count;
> +
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
> +	select_brbe_bank(BRBE_BANK_IDX_0);
> +	for (idx = 0, count = loop1_idx1; count <= loop1_idx2; idx++, count++) {
> +		buf[idx].brbinf = get_brbinf_reg(idx);
> +		/*
> +		 * There are no valid entries anymore on the buffer.
> +		 * Abort the branch record processing to save some
> +		 * cycles and also reduce the capture/process load
> +		 * for the user space as well.
> +		 */
> +		if (brbe_invalid(buf[idx].brbinf))
> +			return idx;
> +
> +		buf[idx].brbsrc = get_brbsrc_reg(idx);
> +		buf[idx].brbtgt = get_brbtgt_reg(idx);
> +	}
> +
> +	select_brbe_bank(BRBE_BANK_IDX_1);
> +	for (count = loop2_idx1; count <= loop2_idx2; idx++, count++) {
> +		buf[idx].brbinf = get_brbinf_reg(idx);
> +		/*
> +		 * There are no valid entries anymore on the buffer.
> +		 * Abort the branch record processing to save some
> +		 * cycles and also reduce the capture/process load
> +		 * for the user space as well.
> +		 */
> +		if (brbe_invalid(buf[idx].brbinf))
> +			return idx;
> +
> +		buf[idx].brbsrc = get_brbsrc_reg(idx);
> +		buf[idx].brbtgt = get_brbtgt_reg(idx);
> +	}
> +	return idx;
> +}

As with __armv8pmu_branch_read(), the loop conditions are a bit hard to follow,
and I believe that can be rewritten along the lines of the suggestion there.

Looking at this, we now have a couple of places that will try to read the
registers for an individual record, so it probably makes sense to facotr that
into a helper, e.g.

| static bool __read_brbe_regset(struct brbe_regset *entry, int idx)
| {
| 	u64 brbinf = get_brbinf_reg(idx);
| 
| 	if (brbe_invalid(brbinf))
| 		return false;
| 	
| 	entry->brbinf = brbinf;
| 	entry->brbsrc = get_brbsrc_reg(idx);
| 	entry->brbtgt = get_brbtgt_reg(idx);
| 
| 	return true;
| }

... which can be used here, e.g.

| /*
|  * Capture all records before the first invalid record, and return the number
|  * of records captured.
|  */
| static int capture_brbe_regset(struct brbe_hw_attr *brbe_attr, struct brbe_regset *buf)
| {
| 
| 	int nr_entries = brbe_attr->brbe_nr;
| 	int idx = 0;
| 	
| 	select_brbe_bank(BRBE_BANK_IDX_0);
| 	while (idx < nr_entries && IDX < BRBE_BANK0_IDX_MAX) {
| 		if (__read_brbe_regset(&buf[idx], idx))
| 			return idx;
| 	}
| 
| 	select_brbe_bank(BRBE_BANK_IDX_1);
| 	while (idx < nr_entries && IDX < BRBE_BANK1_IDX_MAX) {
| 		if (__read_brbe_regset(&buf[idx], idx))
| 			return idx;
| 	}
| 
| 	return idx;
| }

... and could be used to implement capture_branch_entry() in the patch before
this.

> +static inline void copy_brbe_regset(struct brbe_regset *src, int src_idx,
> +				    struct brbe_regset *dst, int dst_idx)
> +{
> +	dst[dst_idx].brbinf = src[src_idx].brbinf;
> +	dst[dst_idx].brbsrc = src[src_idx].brbsrc;
> +	dst[dst_idx].brbtgt = src[src_idx].brbtgt;
> +}

C can do struct assignment, so this is the same as:

| static inline void copy_brbe_regset(struct brbe_regset *src, int src_idx,
| 				    struct brbe_regset *dst, int dst_idx)
| {
| 	dst[dst_idx] = src[src_idx];
| }

... and given that, it would be simpler and clearer to have that directly in
the caller, so I don't think we need this helper function.

> +/*
> + * This function concatenates branch records from stored and live buffer
> + * up to maximum nr_max records and the stored buffer holds the resultant
> + * buffer. The concatenated buffer contains all the branch records from
> + * the live buffer but might contain some from stored buffer considering
> + * the maximum combined length does not exceed 'nr_max'.
> + *
> + *	Stored records	Live records
> + *	------------------------------------------------^
> + *	|	S0	|	L0	|	Newest	|
> + *	---------------------------------		|
> + *	|	S1	|	L1	|		|
> + *	---------------------------------		|
> + *	|	S2	|	L2	|		|
> + *	---------------------------------		|
> + *	|	S3	|	L3	|		|
> + *	---------------------------------		|
> + *	|	S4	|	L4	|		nr_max
> + *	---------------------------------		|
> + *	|		|	L5	|		|
> + *	---------------------------------		|
> + *	|		|	L6	|		|
> + *	---------------------------------		|
> + *	|		|	L7	|		|
> + *	---------------------------------		|
> + *	|		|		|		|
> + *	---------------------------------		|
> + *	|		|		|	Oldest	|
> + *	------------------------------------------------V
> + *
> + *
> + * S0 is the newest in the stored records, where as L7 is the oldest in
> + * the live reocords. Unless the live buffer is detetcted as being full
> + * thus potentially dropping off some older records, L7 and S0 records
> + * are contiguous in time for a user task context. The stitched buffer
> + * here represents maximum possible branch records, contiguous in time.
> + *
> + *	Stored records  Live records
> + *	------------------------------------------------^
> + *	|	L0	|	L0	|	Newest	|
> + *	---------------------------------		|
> + *	|	L0	|	L1	|		|
> + *	---------------------------------		|
> + *	|	L2	|	L2	|		|
> + *	---------------------------------		|
> + *	|	L3	|	L3	|		|
> + *	---------------------------------		|
> + *	|	L4	|	L4	|	      nr_max
> + *	---------------------------------		|
> + *	|	L5	|	L5	|		|
> + *	---------------------------------		|
> + *	|	L6	|	L6	|		|
> + *	---------------------------------		|
> + *	|	L7	|	L7	|		|
> + *	---------------------------------		|
> + *	|	S0	|		|		|
> + *	---------------------------------		|
> + *	|	S1	|		|    Oldest	|
> + *	------------------------------------------------V
> + *	|	S2	| <----|
> + *	-----------------      |
> + *	|	S3	| <----| Dropped off after nr_max
> + *	-----------------      |
> + *	|	S4	| <----|
> + *	-----------------
> + */
> +static int stitch_stored_live_entries(struct brbe_regset *stored,
> +				      struct brbe_regset *live,
> +				      int nr_stored, int nr_live,
> +				      int nr_max)
> +{
> +	int nr_total, nr_excess, nr_last, i;
> +
> +	nr_total = nr_stored + nr_live;
> +	nr_excess = nr_total - nr_max;
> +
> +	/* Stored branch records in stitched buffer */
> +	if (nr_live == nr_max)
> +		nr_stored = 0;
> +	else if (nr_excess > 0)
> +		nr_stored -= nr_excess;
> +
> +	/* Stitched buffer branch records length */
> +	if (nr_total > nr_max)
> +		nr_last = nr_max;
> +	else
> +		nr_last = nr_total;
> +
> +	/* Move stored branch records */
> +	for (i = 0; i < nr_stored; i++)
> +		copy_brbe_regset(stored, i, stored, nr_last - nr_stored - 1 + i);
> +
> +	/* Copy live branch records */
> +	for (i = 0; i < nr_live; i++)
> +		copy_brbe_regset(live, i, stored, i);
> +
> +	return nr_last;
> +}

I think this can be written more simply as something like:

static int stitch_stored_live_entries(struct brbe_regset *stored,
				      struct brbe_regset *live,
				      int nr_stored, int nr_live,
				      int nr_max)
{	
	int nr_move = max(nr_stored, nr_max - nr_live);

	/* Move the tail of the buffer to make room for the new entries */
	memmove(&stored[nr_live], &stored[0], nr_move * sizeof(*stored));

	/* Copy the new entries into the head of the buffer */
	memcpy(stored[0], &live[0], nr_live * sizeof(*stored));

	/* Return the number of entries in the stitched buffer */
	return min(nr_live + nr_stored, nr_max);
}

... or if we could save this oldest-first, we could make it a circular buffer
and avoid moving older entries.

Thanks,
Mark.
