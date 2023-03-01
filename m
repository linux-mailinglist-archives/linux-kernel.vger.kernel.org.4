Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B2E6A743F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCAT33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCAT30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:29:26 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB58E72B4;
        Wed,  1 Mar 2023 11:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677698958; x=1709234958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/bqzJymSbCpnD+DCMHFdYYtceLwcfW75HuliFseCroI=;
  b=Ui7l1egS6rwQKGxNEv6A6iJiif40jw6TyWVLc7/vqe0vp91gbQvmn0BY
   ajCX3PkrRf8HbHH/Vs7CrllKNTERDVHti+f1ciWRe+GLQhEyjCel3VmR5
   X24LvYOc/Rd3swqgRVrSv37KDwtYDJmo2cjXur64Dg2rUJ6pHg3EPUvYy
   SXVwAOTdd8GchI/dSRr4ECT663aNYayXH1Rtb9gFWec+AXFWkTTSj4i5/
   ujIoVMtQwY83B1Uj+j+1YAzq6DYZ099NRifjKVpvGgEQoMBOEHYRGlhNd
   ZLpUJ91/l6ZREA+NIdAY8pW+sjaBReEf4T3SJfe4WdnIYis0zQNSlC+d7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="314923126"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="314923126"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 11:29:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="784475878"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="784475878"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 01 Mar 2023 11:29:17 -0800
Received: from [10.209.27.115] (kliang2-mobl1.ccr.corp.intel.com [10.209.27.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 85584580D28;
        Wed,  1 Mar 2023 11:29:14 -0800 (PST)
Message-ID: <3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com>
Date:   Wed, 1 Mar 2023 14:29:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 1/2] perf/x86/rapl: Fix energy-cores event
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        Stephane Eranian <eranian@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        ananth.narayan@amd.com,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20230301181449.14647-1-wyes.karny@amd.com>
 <20230301181449.14647-2-wyes.karny@amd.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230301181449.14647-2-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-01 1:14 p.m., Wyes Karny wrote:
> For quite some time, energy-cores event is broken, because RAPL PMU
> assumes all the events on this PMU are uncore and sets rapl_cpu_mask
> with the first available CPU on the die. Therefore, for energy-cores
> event if we read MSR form pmu->cpu, it's wrong. But the following two
> changes helped to hide this issue.
> 
> - commit 704e2f5b700d ("perf stat: Use affinity for enabling/disabling
>   events")
> - commit e64cd6f73ff5 ("perf/x86: Use PMUEF_READ_CPU_PKG in uncore
>   events")
> 
> These two changes together acted as a workaround for energy-cores event.
> First change affined perf events to respective CPUs whereas the second
> change helped to pick the local CPU to read the MSR. In this way, MSRs
> were read from the correct CPU. This works unless it's the first
> reading.  For the first reading the second patch doesn't apply and we
> get wrong readings. Stephane reported this issue when a patch to enable
> AMD energy-cores RAPL event was posted [1].
> 
> The right way to fix the issue is to get rid of RAPL being considered an
> uncore event. That is a larger change. To enable current RAPL usage,
> work around the issue by conditionally remove the
> `PERF_EV_CAP_READ_ACTIVE_PKG` flag for energy-cores event. Also, use the
> event's CPU instead for PMU's CPU to read the MSR.

The current RAPL PMU aka 'power' should be die/socket scope.
The energy-cores event is also defined as a die/socket scope.

 *  pp0 counter: consumption of all physical cores (power plane 0)
 * 	  event: rapl_energy_cores
 *    perf code: 0x1

I don't think we want to change the scope of the energy-cores event.
Otherwise Intel's energy-cores event probably be broken.

It looks like you are looking for a new per-core RAPL event. I think
it's better to create a new core scope RAPL PMU.

Thanks,
Kan

> 
> [1]: https://lore.kernel.org/lkml/CABPqkBQ_bSTC-OEe_LrgUrpj2VsseX1ThvO-yLcEtF8vb4+AAw@mail.gmail.com/#t
> 
> Fixes: e64cd6f73ff5 ("perf/x86: Use PMUEF_READ_CPU_PKG in uncore events")
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  arch/x86/events/rapl.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 52e6e7ed4f78..e6a0c077daf5 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -343,14 +343,15 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  	if (event->cpu < 0)
>  		return -EINVAL;
>  
> -	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
> -
>  	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
>  		return -EINVAL;
>  
>  	cfg = array_index_nospec((long)cfg, NR_RAPL_DOMAINS + 1);
>  	bit = cfg - 1;
>  
> +	if (bit != PERF_RAPL_PP0)
> +		event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
> +
>  	/* check event supported */
>  	if (!(rapl_cntr_mask & (1 << bit)))
>  		return -EINVAL;
> @@ -363,7 +364,15 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  	pmu = cpu_to_rapl_pmu(event->cpu);
>  	if (!pmu)
>  		return -EINVAL;
> -	event->cpu = pmu->cpu;
> +
> +	/*
> +	 * FIXME: RAPL PMU considers events are uncore and MSRs can be read from
> +	 * the first available CPU of the die. But this is not true for energy-cores
> +	 * event. Therefore as a workaround don't consider pmu->cpu here for PERF_RAPL_PP0.
> +	 */
> +	if (event->event_caps & PERF_EV_CAP_READ_ACTIVE_PKG)
> +		event->cpu = pmu->cpu;
> +
>  	event->pmu_private = pmu;
>  	event->hw.event_base = rapl_msrs[bit].msr;
>  	event->hw.config = cfg;
