Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DE772428D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbjFFMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbjFFMnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:43:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A3010CA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686055366; x=1717591366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RabRPngF65Hvc5q/AigHrtwtaHJC3QLiqVAt7XBWC/o=;
  b=UAPp/LrV+tPRVqCGt4MrL8cqcA8VOscutaw+q5jpdClN/zt1TpHFz5h7
   VpxFv+QqJaFHTyDHgwtn2n5FrPhEB1tchteKy8nRRB1WYgnS1qhRsE+Ir
   +cnvPOUgHXMZJMFRNDLRdNPKpfWJSO9A/U9hPj2D8B5X7c861qlf+JCU3
   GB05LjvD2x5qxymirw3dhmZ82Fq3O1TU1+rsXyaXPA7ULdMB3IWkh+/WH
   4x9JcVuZk1WNwZqXDHD1YLhQGCY7WTP4gjfPqEdnDnr9tIYnf9cJB7D45
   HrcdQVU+dBp0CWF+jMXIjS6kUuySzI8nuBeKLjUAokEHVtovu0aDhK1Ea
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336283922"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="336283922"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 05:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="659511460"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="659511460"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 06 Jun 2023 05:42:45 -0700
Received: from [10.212.191.33] (kliang2-mobl1.ccr.corp.intel.com [10.212.191.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C0305580377;
        Tue,  6 Jun 2023 05:42:43 -0700 (PDT)
Message-ID: <2b2e7308-edeb-2977-596a-f638d19174d6@linux.intel.com>
Date:   Tue, 6 Jun 2023 08:42:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230522113040.2329924-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2023-05-22 7:30 a.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The Grand Ridge and Sierra Forest are successors to Snow Ridge. They
> both have Crestmont core. From the core PMU's perspective, they are
> similar to the e-core of MTL. The only difference is the LBR event
> logging feature, which will be implemented in the following patches.
> 
> Create a non-hybrid PMU setup for Grand Ridge and Sierra Forest.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 


Gentle ping.

Do you have any comments for the patch set?

The patch set based on the perf/core branch which doesn't
include the latest fix, 90befef5a9e8 ("perf/x86: Fix missing sample size
update on AMD BRS").
https://lore.kernel.org/lkml/2f09023a-cccb-35df-da0a-d245ee5238be@linux.intel.com/

Should I rebase it on the perf/urgent and send the V3?


Thanks,
Kan


> No changes since V1.
> 
>  arch/x86/events/intel/core.c | 52 +++++++++++++++++++++++++++++++++++-
>  arch/x86/events/intel/ds.c   |  9 +++++--
>  arch/x86/events/perf_event.h |  2 ++
>  3 files changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index a3fb996a86a1..ba2a971e6b8a 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2119,6 +2119,17 @@ static struct extra_reg intel_grt_extra_regs[] __read_mostly = {
>  	EVENT_EXTRA_END
>  };
>  
> +EVENT_ATTR_STR(topdown-retiring,       td_retiring_cmt,        "event=0x72,umask=0x0");
> +EVENT_ATTR_STR(topdown-bad-spec,       td_bad_spec_cmt,        "event=0x73,umask=0x0");
> +
> +static struct attribute *cmt_events_attrs[] = {
> +	EVENT_PTR(td_fe_bound_tnt),
> +	EVENT_PTR(td_retiring_cmt),
> +	EVENT_PTR(td_bad_spec_cmt),
> +	EVENT_PTR(td_be_bound_tnt),
> +	NULL
> +};
> +
>  static struct extra_reg intel_cmt_extra_regs[] __read_mostly = {
>  	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
>  	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x800ff3ffffffffffull, RSP_0),
> @@ -4830,6 +4841,8 @@ PMU_FORMAT_ATTR(ldlat, "config1:0-15");
>  
>  PMU_FORMAT_ATTR(frontend, "config1:0-23");
>  
> +PMU_FORMAT_ATTR(snoop_rsp, "config1:0-63");
> +
>  static struct attribute *intel_arch3_formats_attr[] = {
>  	&format_attr_event.attr,
>  	&format_attr_umask.attr,
> @@ -4860,6 +4873,13 @@ static struct attribute *slm_format_attr[] = {
>  	NULL
>  };
>  
> +static struct attribute *cmt_format_attr[] = {
> +	&format_attr_offcore_rsp.attr,
> +	&format_attr_ldlat.attr,
> +	&format_attr_snoop_rsp.attr,
> +	NULL
> +};
> +
>  static struct attribute *skl_format_attr[] = {
>  	&format_attr_frontend.attr,
>  	NULL,
> @@ -5630,7 +5650,6 @@ static struct attribute *adl_hybrid_extra_attr[] = {
>  	NULL
>  };
>  
> -PMU_FORMAT_ATTR_SHOW(snoop_rsp, "config1:0-63");
>  FORMAT_ATTR_HYBRID(snoop_rsp,	hybrid_small);
>  
>  static struct attribute *mtl_hybrid_extra_attr_rtm[] = {
> @@ -6178,6 +6197,37 @@ __init int intel_pmu_init(void)
>  		name = "gracemont";
>  		break;
>  
> +	case INTEL_FAM6_GRANDRIDGE:
> +	case INTEL_FAM6_SIERRAFOREST_X:
> +		x86_pmu.mid_ack = true;
> +		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
> +		       sizeof(hw_cache_event_ids));
> +		memcpy(hw_cache_extra_regs, tnt_hw_cache_extra_regs,
> +		       sizeof(hw_cache_extra_regs));
> +		hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
> +
> +		x86_pmu.event_constraints = intel_slm_event_constraints;
> +		x86_pmu.pebs_constraints = intel_grt_pebs_event_constraints;
> +		x86_pmu.extra_regs = intel_cmt_extra_regs;
> +
> +		x86_pmu.pebs_aliases = NULL;
> +		x86_pmu.pebs_prec_dist = true;
> +		x86_pmu.lbr_pt_coexist = true;
> +		x86_pmu.pebs_block = true;
> +		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
> +		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
> +
> +		intel_pmu_pebs_data_source_cmt();
> +		x86_pmu.pebs_latency_data = mtl_latency_data_small;
> +		x86_pmu.get_event_constraints = cmt_get_event_constraints;
> +		x86_pmu.limit_period = spr_limit_period;
> +		td_attr = cmt_events_attrs;
> +		mem_attr = grt_mem_attrs;
> +		extra_attr = cmt_format_attr;
> +		pr_cont("Crestmont events, ");
> +		name = "crestmont";
> +		break;
> +
>  	case INTEL_FAM6_WESTMERE:
>  	case INTEL_FAM6_WESTMERE_EP:
>  	case INTEL_FAM6_WESTMERE_EX:
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index a2e566e53076..608e220e46aa 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -144,7 +144,7 @@ void __init intel_pmu_pebs_data_source_adl(void)
>  	__intel_pmu_pebs_data_source_grt(data_source);
>  }
>  
> -static void __init intel_pmu_pebs_data_source_cmt(u64 *data_source)
> +static void __init __intel_pmu_pebs_data_source_cmt(u64 *data_source)
>  {
>  	data_source[0x07] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOPX, FWD);
>  	data_source[0x08] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOP, HITM);
> @@ -164,7 +164,12 @@ void __init intel_pmu_pebs_data_source_mtl(void)
>  
>  	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX].pebs_data_source;
>  	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
> -	intel_pmu_pebs_data_source_cmt(data_source);
> +	__intel_pmu_pebs_data_source_cmt(data_source);
> +}
> +
> +void __init intel_pmu_pebs_data_source_cmt(void)
> +{
> +	__intel_pmu_pebs_data_source_cmt(pebs_data_source);
>  }
>  
>  static u64 precise_store_data(u64 status)
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index d6de4487348c..c8ba2be7585d 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1606,6 +1606,8 @@ void intel_pmu_pebs_data_source_grt(void);
>  
>  void intel_pmu_pebs_data_source_mtl(void);
>  
> +void intel_pmu_pebs_data_source_cmt(void);
> +
>  int intel_pmu_setup_lbr_filter(struct perf_event *event);
>  
>  void intel_pt_interrupt(void);
