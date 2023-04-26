Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165E76EF650
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241109AbjDZOXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240704AbjDZOXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:23:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214B9188
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682519018; x=1714055018;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hGcMfMjodPIIpa+/XGYcFbV1tdkSiDTS3gBJDbSLmcA=;
  b=nDyiknVukdKnKm/mNu/1T0WP6LnN/fU+2Yf8oDAms0tRR2w9FxXEALXz
   YUJ3jV0PXLGVjwIUhIsujRlVuDwNyqsXel1o1uO+VURNpTlhvnosx2/gk
   Ojwzycg5idZdd96tmgf2PNs0h9QWT8JbblA6qEsTWIkLAB1uRf/RRCGRG
   Oi0wrbgv6NEGqZxfqZ2tk96AQ1mT6J3Ba/8epvZ/tN8KZQ0yNLUuvDG2p
   CtJueLcACcl7eKw6jbADRV47bU1j2cGGF9v1xq1Q61IcUdTvZ7LfqpZrR
   qt32P+rQh8eYwkVHnnb/uSPGs/gRs8pAMZQhAsB3rSkOP3a4i8pe5qtO5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="336034216"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="336034216"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 07:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="693966640"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="693966640"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2023 07:23:37 -0700
Received: from [10.212.235.211] (kliang2-mobl1.ccr.corp.intel.com [10.212.235.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C814F580C9A;
        Wed, 26 Apr 2023 07:23:36 -0700 (PDT)
Message-ID: <d296056a-8286-ee66-c03a-6e930afcfb9f@linux.intel.com>
Date:   Wed, 26 Apr 2023 10:23:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 1/2] perf/x86/intel/ds: Flush the PEBS buffer in PEBS
 enable
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com
References: <20230421184529.3320912-1-kan.liang@linux.intel.com>
 <20230426131812.GA1377058@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230426131812.GA1377058@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-26 9:18 a.m., Peter Zijlstra wrote:
> On Fri, Apr 21, 2023 at 11:45:28AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Several similar kernel warnings can be triggered,
>>
>>   [56605.607840] CPU0 PEBS record size 0, expected 32, config 0
>>   cpuc->record_size=208
>>
>> when the below commands are running in parallel for a while on SPR.
>>
>>   while true; do perf record --no-buildid -a --intr-regs=AX -e
>>   cpu/event=0xd0,umask=0x81/pp -c 10003 -o /dev/null ./triad; done &
>>
>>   while true; do perf record -o /tmp/out -W -d -e
>>   '{ld_blocks.store_forward:period=1000000,
>>   MEM_TRANS_RETIRED.LOAD_LATENCY:u:precise=2:ldlat=4}'
>>   -c 1037 ./triad; done
>>   *The triad program is just the generation of loads/stores.
>>
>> The warnings are triggered when an unexpected PEBS record (with a
>> different config and size) is found.
>>
>> A system-wide PEBS event with the large PEBS config may be enabled
>> during a context switch. Some PEBS records for the system-wide PEBS may
>> be generated while the old task is sched out but the new one hasn't been
>> sched in yet. When the new task is sched in, the cpuc->pebs_record_size
>> may be updated for the per-task PEBS events. So the existing system-wide
>> PEBS records have a different size from the later PEBS records.
>>
>> The PEBS buffer should be flushed right before the hardware is
>> reprogrammed. The new size and threshold should be updated after the old
>> buffer has been flushed.
>>
>> Reported-by: Stephane Eranian <eranian@google.com>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
> 
> So I find it much easier to read the whole thing when collapsed.
> Something like the below; that ok with you?

Yes, the changes look good to me.

Thanks,
Kan
> 
> ---
>  arch/x86/events/intel/ds.c        | 56 ++++++++++++++++++++++-----------------
>  arch/x86/include/asm/perf_event.h |  3 +++
>  2 files changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index a2e566e53076..df88576d6b2a 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1229,12 +1229,14 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
>  		  struct perf_event *event, bool add)
>  {
>  	struct pmu *pmu = event->pmu;
> +
>  	/*
>  	 * Make sure we get updated with the first PEBS
>  	 * event. It will trigger also during removal, but
>  	 * that does not hurt:
>  	 */
> -	bool update = cpuc->n_pebs == 1;
> +	if (cpuc->n_pebs == 1)
> +		cpuc->pebs_data_cfg = PEBS_UPDATE_DS_SW;
>  
>  	if (needed_cb != pebs_needs_sched_cb(cpuc)) {
>  		if (!needed_cb)
> @@ -1242,7 +1244,7 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
>  		else
>  			perf_sched_cb_dec(pmu);
>  
> -		update = true;
> +		cpuc->pebs_data_cfg |= PEBS_UPDATE_DS_SW;
>  	}
>  
>  	/*
> @@ -1252,24 +1254,13 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
>  	if (x86_pmu.intel_cap.pebs_baseline && add) {
>  		u64 pebs_data_cfg;
>  
> -		/* Clear pebs_data_cfg and pebs_record_size for first PEBS. */
> -		if (cpuc->n_pebs == 1) {
> -			cpuc->pebs_data_cfg = 0;
> -			cpuc->pebs_record_size = sizeof(struct pebs_basic);
> -		}
> -
>  		pebs_data_cfg = pebs_update_adaptive_cfg(event);
> -
> -		/* Update pebs_record_size if new event requires more data. */
> -		if (pebs_data_cfg & ~cpuc->pebs_data_cfg) {
> -			cpuc->pebs_data_cfg |= pebs_data_cfg;
> -			adaptive_pebs_record_size_update();
> -			update = true;
> -		}
> +		/*
> +		 * Be sure to update the thresholds when we change the record.
> +		 */
> +		if (pebs_data_cfg & ~cpuc->pebs_data_cfg)
> +			cpuc->pebs_data_cfg |= pebs_data_cfg | PEBS_UPDATE_DS_SW;
>  	}
> -
> -	if (update)
> -		pebs_update_threshold(cpuc);
>  }
>  
>  void intel_pmu_pebs_add(struct perf_event *event)
> @@ -1326,9 +1317,17 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
>  	wrmsrl(base + idx, value);
>  }
>  
> +static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc)
> +{
> +	if (cpuc->n_pebs == cpuc->n_large_pebs &&
> +	    cpuc->n_pebs != cpuc->n_pebs_via_pt)
> +		intel_pmu_drain_pebs_buffer();
> +}
> +
>  void intel_pmu_pebs_enable(struct perf_event *event)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	u64 pebs_data_cfg = cpuc->pebs_data_cfg & ~PEBS_UPDATE_DS_SW;
>  	struct hw_perf_event *hwc = &event->hw;
>  	struct debug_store *ds = cpuc->ds;
>  	unsigned int idx = hwc->idx;
> @@ -1344,11 +1343,22 @@ void intel_pmu_pebs_enable(struct perf_event *event)
>  
>  	if (x86_pmu.intel_cap.pebs_baseline) {
>  		hwc->config |= ICL_EVENTSEL_ADAPTIVE;
> -		if (cpuc->pebs_data_cfg != cpuc->active_pebs_data_cfg) {
> -			wrmsrl(MSR_PEBS_DATA_CFG, cpuc->pebs_data_cfg);
> -			cpuc->active_pebs_data_cfg = cpuc->pebs_data_cfg;
> +		if (pebs_data_cfg != cpuc->active_pebs_data_cfg) {
> +			/*
> +			 * drain_pebs() assumes uniform record size;
> +			 * hence we need to drain when changing said
> +			 * size.
> +			 */
> +			intel_pmu_drain_large_pebs(cpuc);
> +			adaptive_pebs_record_size_update();
> +			wrmsrl(MSR_PEBS_DATA_CFG, pebs_data_cfg);
> +			cpuc->active_pebs_data_cfg = pebs_data_cfg;
>  		}
>  	}
> +	if (cpuc->pebs_data_cfg & PEBS_UPDATE_DS_SW) {
> +		cpuc->pebs_data_cfg = pebs_data_cfg;
> +		pebs_update_threshold(cpuc);
> +	}
>  
>  	if (idx >= INTEL_PMC_IDX_FIXED) {
>  		if (x86_pmu.intel_cap.pebs_format < 5)
> @@ -1391,9 +1401,7 @@ void intel_pmu_pebs_disable(struct perf_event *event)
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct hw_perf_event *hwc = &event->hw;
>  
> -	if (cpuc->n_pebs == cpuc->n_large_pebs &&
> -	    cpuc->n_pebs != cpuc->n_pebs_via_pt)
> -		intel_pmu_drain_pebs_buffer();
> +	intel_pmu_drain_large_pebs(cpuc);
>  
>  	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
>  
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 8fc15ed5e60b..abf09882f58b 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -121,6 +121,9 @@
>  #define PEBS_DATACFG_LBRS	BIT_ULL(3)
>  #define PEBS_DATACFG_LBR_SHIFT	24
>  
> +/* Steal the highest bit of pebs_data_cfg for SW usage */
> +#define PEBS_UPDATE_DS_SW	BIT_ULL(63)
> +
>  /*
>   * Intel "Architectural Performance Monitoring" CPUID
>   * detection/enumeration details:
