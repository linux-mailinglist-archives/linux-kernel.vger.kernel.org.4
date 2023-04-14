Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C8B6E258C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDNOW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDNOWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:22:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87981709
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681482170; x=1713018170;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ti0rTmfDkYPhg39eIph+WMRiRDY2DhR53PBDAW/VO/M=;
  b=ILTwYcf41clS9ek2wTVFh/b9NDF9Wi3C69LEjijzrg+B6VNnd/YIYHdH
   G/FjTTyaOLgbu/kQtrQ6hf028FKXRcravNJz1ZRhbpfkyd9RUIQkzKUSs
   OcnnOuVo7/OeIFmhkQMMJa4dVgvgVuqxXrYGUzPeXvSpd1aOQ2DDa1vEQ
   /u3GKxUbifVq7Q0Jimb0Aazk6ztwJ1MxA4keSEa29SOkM6nDg8tq8BntU
   2cKsw1bqMd1D0QAv9w+4RjcKqZMc0DaxOClo5CsgtxtloP2xQMmWIb0PJ
   ceZn92NrvG/dRzftHZKwhNRMwONUJzIfnbSGVIMDmNf/iJ9vDBckY/d0Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="324102197"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="324102197"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 07:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="936027772"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="936027772"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 14 Apr 2023 07:22:50 -0700
Received: from [10.212.165.245] (kliang2-mobl1.ccr.corp.intel.com [10.212.165.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 96E3E5805EE;
        Fri, 14 Apr 2023 07:22:49 -0700 (PDT)
Message-ID: <49b6f5fb-665b-2857-788b-e5082bb7374b@linux.intel.com>
Date:   Fri, 14 Apr 2023 10:22:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3] perf/x86/intel/ds: Flush the PEBS buffer in PEBS
 enable
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com
References: <20230410181309.827175-1-kan.liang@linux.intel.com>
 <20230414102908.GC83892@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230414102908.GC83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-14 6:29 a.m., Peter Zijlstra wrote:
> On Mon, Apr 10, 2023 at 11:13:09AM -0700, kan.liang@linux.intel.com wrote:
> 
>>  arch/x86/events/intel/ds.c | 39 ++++++++++++++++++++++++++------------
>>  1 file changed, 27 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 3a77f4336df7..4639d4c1e98d 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1257,20 +1257,18 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
>>  	if (x86_pmu.intel_cap.pebs_baseline && add) {
>>  		u64 pebs_data_cfg;
>>  
>> -		/* Clear pebs_data_cfg and pebs_record_size for first PEBS. */
>> -		if (cpuc->n_pebs == 1) {
>> +		/* Clear pebs_data_cfg for first PEBS. */
>> +		if (cpuc->n_pebs == 1)
>>  			cpuc->pebs_data_cfg = 0;
>> -			cpuc->pebs_record_size = sizeof(struct pebs_basic);
>> -		}
>>  
>>  		pebs_data_cfg = pebs_update_adaptive_cfg(event);
>>  
>> -		/* Update pebs_record_size if new event requires more data. */
>> -		if (pebs_data_cfg & ~cpuc->pebs_data_cfg) {
>> +		/*
>> +		 * Only update the pebs_data_cfg here. The pebs_record_size
>> +		 * will be updated later when the new pebs_data_cfg takes effect.
>> +		 */
>> +		if (pebs_data_cfg & ~cpuc->pebs_data_cfg)
>>  			cpuc->pebs_data_cfg |= pebs_data_cfg;
>> -			adaptive_pebs_record_size_update();
>> -			update = true;
>> -		}
>>  	}
>>  
>>  	if (update)
> 		pebs_update_threshold(cpuc);
> 
> Now, pebs_update_threshold() will actually use
> ->pebs_record_size, but afaict the above now has a path through (for
> example for the first event) where update is true but ->pebs_record_size
> is unset/stale.
> 
> I think it all works out, but it is quite a mess and hard to follow.

With this patch, the pebs_update_threshold() will be delayed to
intel_pmu_pebs_enable() for the adaptive PEBS.

I think we may reuse the pebs_data_cfg method for the previous fixed
PEBS as well and delay the DS update to intel_pmu_pebs_enable() as well.
So everything will be consistent.

I will do more tests and probably send a clean up patch later separately.


> 
>> @@ -1331,6 +1329,13 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
>>  	wrmsrl(base + idx, value);
>>  }
>>  
>> +static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc)
>> +{
>> +	if (cpuc->n_pebs == cpuc->n_large_pebs &&
>> +	    cpuc->n_pebs != cpuc->n_pebs_via_pt)
>> +		intel_pmu_drain_pebs_buffer();
>> +}
> 
> Its been a minute since I looked at this code; but why only for large
> pebs? Surely flushing is quick when the DS is actually empty and that
> stops us having to worry if there's races where there might be a single
> entry in.

The AUTO_RELOAD is a separate feature. It should be always enabled when
a fixed period is set. That's not the case for the large PEBS, which
only supports partial sample type.

There should be some overhead for the AUTO_RELOAD + single PEBS case. We
have to update the event count.

> 
>>  void intel_pmu_pebs_enable(struct perf_event *event)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> @@ -1350,6 +1355,18 @@ void intel_pmu_pebs_enable(struct perf_event *event)
>>  	if (x86_pmu.intel_cap.pebs_baseline) {
>>  		hwc->config |= ICL_EVENTSEL_ADAPTIVE;
>>  		if (cpuc->pebs_data_cfg != cpuc->active_pebs_data_cfg) {
>> +			/*
>> +			 * A system-wide PEBS event with the large PEBS
>> +			 * config may still be enabled when switching the
>> +			 * context. Some PEBS records for the system-wide
>> +			 * PEBS may be generated while the old event has
>> +			 * been scheduled out but the new one hasn't been
>> +			 * scheduled in. It's not enough to only flush the
>> +			 * buffer when a PEBS event is disable.
>> +			 */
> 
> Perhaps just:
> 
> 			/*
> 			 * drain_pebs() assumes uniform record size;
> 			 * hence we need to drain when changing said
> 			 * size.
> 			 */
> 

Sure, I will update in V4.

Thanks,
Kan

> 
>> +			intel_pmu_drain_large_pebs(cpuc);
>> +			adaptive_pebs_record_size_update();
>> +			pebs_update_threshold(cpuc);
>>  			wrmsrl(MSR_PEBS_DATA_CFG, cpuc->pebs_data_cfg);
>>  			cpuc->active_pebs_data_cfg = cpuc->pebs_data_cfg;
>>  		}
