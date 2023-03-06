Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556136AC2C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCFOOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCFONp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:13:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CB932E6E;
        Mon,  6 Mar 2023 06:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678111899; x=1709647899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6rNsW7Qj0oSOBhMO4RNwYTgDdY+PHO8xRFZGKx1OsTE=;
  b=NAzHW6yBEj+Ho2WV4Rz8f4gbWcbg3VyiU7aDZojecKFhaEkw24MvEX/J
   w2rl0e8olHdi5N9yXXxqNpQWczrYrhPcODxb+VJZGPvEonHTvHH1i1jby
   BY3qeOcoYydY15X/uYwzhRkElI+PAbA7q12oKX2CCTU/efcRCL6Mi0Ga6
   ERhmJC8dnpto+CFIPvv0Wea9RuIEnnVz8Ho0/J/hldR0zuIIF21l3RhU4
   +dnEssymnnMyKRuF9CkH7TWQ+Rr+Nxw9fAFI8Ma57MtLcZd2ro3SIkVHs
   e6KINwlD8joBlZzlZGq2j3OItYMFZg0LCaeE9kIDA9WDHjLWG43WfnIy1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="315956867"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="315956867"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 06:10:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745068146"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745068146"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2023 06:10:18 -0800
Received: from [10.251.28.138] (kliang2-mobl1.ccr.corp.intel.com [10.251.28.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1865C58097C;
        Mon,  6 Mar 2023 06:10:15 -0800 (PST)
Message-ID: <4c411516-6c6b-8fc4-c520-909b28c21d75@linux.intel.com>
Date:   Mon, 6 Mar 2023 09:10:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 03/10] perf record: Early auxtrace initialization
 before event parsing
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20230302212531.1043318-1-irogers@google.com>
 <20230302212531.1043318-4-irogers@google.com>
 <2aed81ff-2d28-3af5-0657-16ee69705c03@linux.intel.com>
 <4473367b-38e1-7c15-3937-a077d68410b7@intel.com>
 <9788f0f1-087f-7f0b-048a-0146afe1f632@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <9788f0f1-087f-7f0b-048a-0146afe1f632@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-06 4:31 a.m., Adrian Hunter wrote:
> On 5/03/23 10:32, Adrian Hunter wrote:
>> On 3/03/23 18:40, Liang, Kan wrote:
>>>
>>>
>>> On 2023-03-02 4:25 p.m., Ian Rogers wrote:
>>>> This allows event parsing to use the evsel__is_aux_event function,
>>>> which is important when determining event grouping.
>>>>
>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>> ---
>>>>  tools/perf/arch/x86/util/auxtrace.c | 17 +++++++++++++----
>>>>  tools/perf/builtin-record.c         |  6 ++++++
>>>>  tools/perf/util/auxtrace.h          |  2 ++
>>>>  3 files changed, 21 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
>>>> index 3da506e13f49..de1e4842ea2e 100644
>>>> --- a/tools/perf/arch/x86/util/auxtrace.c
>>>> +++ b/tools/perf/arch/x86/util/auxtrace.c
>>>> @@ -15,6 +15,19 @@
>>>>  #include "../../../util/intel-bts.h"
>>>>  #include "../../../util/evlist.h"
>>>>  
>>>> +void auxtrace__early_init(void)
>>>> +{
>>>> +	struct perf_pmu *intel_pt_pmu;
>>>> +	struct perf_pmu *intel_bts_pmu;
>>>> +
>>>> +	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
>>>> +	if (intel_pt_pmu)
>>>> +		intel_pt_pmu->auxtrace = true;
>>>> +	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
>>>> +	if (intel_bts_pmu)
>>>> +		intel_bts_pmu->auxtrace = true;
>>>> +}
>>>> +
>>>>  static
>>>>  struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
>>>>  						    int *err)
>>>> @@ -26,11 +39,7 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
>>>>  	bool found_bts = false;
>>>>  
>>>>  	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
>>>> -	if (intel_pt_pmu)
>>>> -		intel_pt_pmu->auxtrace = true;
>>>>  	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
>>>> -	if (intel_bts_pmu)
>>>> -		intel_bts_pmu->auxtrace = true;
>>>>  
>>>>  	evlist__for_each_entry(evlist, evsel) {
>>>>  		if (intel_pt_pmu && evsel->core.attr.type == intel_pt_pmu->type)
>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>>> index 8374117e66f6..a0870c076dc0 100644
>>>> --- a/tools/perf/builtin-record.c
>>>> +++ b/tools/perf/builtin-record.c
>>>> @@ -3940,6 +3940,10 @@ static int record__init_thread_masks(struct record *rec)
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +__weak void auxtrace__early_init(void)
>>>> +{
>>>> +}
>>>> +
>>>>  int cmd_record(int argc, const char **argv)
>>>>  {
>>>>  	int err;
>>>> @@ -3985,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
>>>>  	if (err)
>>>>  		return err;
>>>>  
>>>> +	auxtrace__early_init();
>>>
>>> So the auxtrace__early_init() will be unconditionally invoked even there
>>> is no PT or BTS events, right?
>>>
>>> Maybe we should move the auxtrace__early_init() to evsel__is_aux_event()
>>> and cache the value. The initialization will only be invoked when it's
>>> required.
>>
>> Although perf_pmu__find() will be called unconditionally via
>> record__auxtrace_init() anyway.
> 
> However auxtrace__early_init() is before parsing 'verbose' so
> debug prints don't work anymore.
> 
> How about this instead:

Yes, I think it should be a better place to initialize them.

Thanks,
Kan
> 
> diff --git a/tools/perf/arch/x86/util/auxtrace.c
> b/tools/perf/arch/x86/util/auxtrace.c
> index 3da506e13f49d..330d03216b0e6 100644
> --- a/tools/perf/arch/x86/util/auxtrace.c
> +++ b/tools/perf/arch/x86/util/auxtrace.c
> @@ -26,11 +26,7 @@ struct auxtrace_record
> *auxtrace_record__init_intel(struct evlist *evlist,
>  	bool found_bts = false;
> 
>  	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
> -	if (intel_pt_pmu)
> -		intel_pt_pmu->auxtrace = true;
>  	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
> -	if (intel_bts_pmu)
> -		intel_bts_pmu->auxtrace = true;
> 
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (intel_pt_pmu && evsel->core.attr.type == intel_pt_pmu->type)
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 358340b342431..f73b80dcd8bdc 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -27,10 +27,14 @@ static bool cached_list;
>  struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu
> *pmu __maybe_unused)
>  {
>  #ifdef HAVE_AUXTRACE_SUPPORT
> -	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME))
> +	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
> +		pmu->auxtrace = true;
>  		return intel_pt_pmu_default_config(pmu);
> -	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME))
> +	}
> +	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
> +		pmu->auxtrace = true;
>  		pmu->selectable = true;
> +	}
>  #endif
>  	return NULL;
>  }
> 
> 
> 
>>
>>> Something as below (not tested.)
>>>
>>> +void auxtrace__init(void)
>>> +{
>>> +	struct perf_pmu *intel_pt_pmu;
>>> +	struct perf_pmu *intel_bts_pmu;
>>> +	static bool cached;
>>> +
>>> +	if (cached)
>>> +		return;
>>> +	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
>>> +	if (intel_pt_pmu)
>>> +		intel_pt_pmu->auxtrace = true;
>>> +	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
>>> +	if (intel_bts_pmu)
>>> +		intel_bts_pmu->auxtrace = true;
>>> +}
>>>
>>> bool evsel__is_aux_event(struct evsel *evsel)
>>> {
>>> 	struct perf_pmu *pmu = evsel__find_pmu(evsel);
>>> +	auxtrace__init();
>>> 	return pmu && pmu->auxtrace;
>>> }
>>>
>>>
>>>
>>> Thanks,
>>> Kan
>>>
>>>> +
>>>>  	argc = parse_options(argc, argv, record_options, record_usage,
>>>>  			    PARSE_OPT_STOP_AT_NON_OPTION);
>>>>  	if (quiet)
>>>> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
>>>> index 29eb82dff574..49a86aa6ac94 100644
>>>> --- a/tools/perf/util/auxtrace.h
>>>> +++ b/tools/perf/util/auxtrace.h
>>>> @@ -457,6 +457,8 @@ struct addr_filters {
>>>>  
>>>>  struct auxtrace_cache;
>>>>  
>>>> +void auxtrace__early_init(void);
>>>> +
>>>>  #ifdef HAVE_AUXTRACE_SUPPORT
>>>>  
>>>>  u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm);
>>
> 
