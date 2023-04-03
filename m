Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E46D3E07
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjDCHY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDCHYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:24:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32D98769D;
        Mon,  3 Apr 2023 00:24:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1665BFEC;
        Mon,  3 Apr 2023 00:25:06 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.57.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAB463F6C4;
        Mon,  3 Apr 2023 00:24:18 -0700 (PDT)
Date:   Mon, 3 Apr 2023 08:24:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Newman <peternewman@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        will@kernel.org, catalin.marinas@arm.com, eranian@google.com
Subject: Re: [PATCH v4] arm64: pmuv3: dynamically map
 PERF_COUNT_HW_BRANCH_INSTRUCTIONS
Message-ID: <ZCp/HX4YQLyOp0TE@FVFF77S0Q05N>
References: <20230327122527.3913496-1-peternewman@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327122527.3913496-1-peternewman@google.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 02:25:27PM +0200, Peter Newman wrote:
> From: Stephane Eranian <eranian@google.com>
> 
> The mapping of perf_events generic hardware events to actual PMU events on
> ARM PMUv3 may not always be correct. This is in particular true for the
> PERF_COUNT_HW_BRANCH_INSTRUCTIONS event. Although the mapping points to an
> architected event, it may not always be available. This can be seen with a
> simple:
> 
> $ perf stat -e branches sleep 0
>  Performance counter stats for 'sleep 0':
> 
>    <not supported>      branches
> 
>        0.001401081 seconds time elapsed
> 
> Yet the hardware does have an event that could be used for branches.
> 
> Dynamically check for a supported hardware event which can be used for
> PERF_COUNT_HW_BRANCH_INSTRUCTIONS at mapping time.
> 
> And with that:
> 
> $ perf stat -e branches sleep 0
> 
>  Performance counter stats for 'sleep 0':
> 
>            166,739      branches
> 
>        0.000832163 seconds time elapsed
> 
> Based-on: https://lore.kernel.org/all/YvunKCJHSXKz%2FkZB@FVFF77S0Q05N
> Based-on-patch-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Peter Newman <peternewman@google.com>

Thanks for reworking the patch; the patch itself and commit message look good
to me.

I'd like to keep my S-o-b here for the code itself; could we please make the
tags:

  Co-Developed-by: Stephane Eranian <eranian@google.com>
  Signed-off-by: Stephane Eranian <eranian@google.com>
  Co-Developed-by: Mark Rutland <mark.rutland@arm.com>
  Signed-off-by: Mark Rutland <mark.rutland@arm.com>
  Co-Developed-by: Peter Newman <peternewman@google.com>
  Signed-off-by: Peter Newman <peternewman@google.com>
  Link: https://lore.kernel.org/all/YvunKCJHSXKz%2FkZB@FVFF77S0Q05N

That follow the conventions documented in:

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Thanks,
Mark.

> ---
> v3->v4:
>  - splice Mark's patch with Stephane's problem statement
> v2->v3:
>  - removed prints per Will's suggestion
>  
> [v3] https://lore.kernel.org/all/20220816130221.885920-1-peternewman@google.com/
> [v2] https://lore.kernel.org/lkml/20220324181458.3216262-1-eranian@google.com/
> 
>  arch/arm64/kernel/perf_event.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index dde06c0f97f3..ee63f8e719ea 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -45,7 +45,6 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
>  	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
>  	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
>  	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
> -	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
>  	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
>  	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
>  	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
> @@ -1048,6 +1047,28 @@ static void armv8pmu_reset(void *info)
>  	armv8pmu_pmcr_write(pmcr);
>  }
>  
> +static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
> +				      struct perf_event *event)
> +{
> +	if (event->attr.type == PERF_TYPE_HARDWARE &&
> +	    event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS) {
> +
> +		if (test_bit(ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
> +			     armpmu->pmceid_bitmap))
> +			return ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED;
> +
> +		if (test_bit(ARMV8_PMUV3_PERFCTR_BR_RETIRED,
> +			     armpmu->pmceid_bitmap))
> +			return ARMV8_PMUV3_PERFCTR_BR_RETIRED;
> +
> +		return HW_OP_UNSUPPORTED;
> +	}
> +
> +	return armpmu_map_event(event, &armv8_pmuv3_perf_map,
> +				&armv8_pmuv3_perf_cache_map,
> +				ARMV8_PMU_EVTYPE_EVENT);
> +}
> +
>  static int __armv8_pmuv3_map_event(struct perf_event *event,
>  				   const unsigned (*extra_event_map)
>  						  [PERF_COUNT_HW_MAX],
> @@ -1059,9 +1080,7 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
>  	int hw_event_id;
>  	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
>  
> -	hw_event_id = armpmu_map_event(event, &armv8_pmuv3_perf_map,
> -				       &armv8_pmuv3_perf_cache_map,
> -				       ARMV8_PMU_EVTYPE_EVENT);
> +	hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
>  
>  	/*
>  	 * CHAIN events only work when paired with an adjacent counter, and it
> -- 
> 2.40.0.348.gf938b09366-goog
> 
