Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500266AB9E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCFJcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCFJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:32:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12444EF3;
        Mon,  6 Mar 2023 01:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678095124; x=1709631124;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=lmSgmdWU9oHGWDkeiNuXcEGyqTp7WSxWSz0ilP8fNEw=;
  b=bMOjyqdEpu32Z3kuJDL1UgcF7yiAXvhkG1w5TV82mkaZI8ttqT7kvJer
   gGK6vaVvFvjxxDI30rLTUZgUnfiJRKVXtqSzdi9qW52dt3/NjhDPJHfFk
   3sXiKsVqojrySyJ2bRYWfoOvlHRVqDiN+eirD2mrC+4X8plHL+Baw4ig6
   Z3bUJEprOxfT2k/qsuSR2D86DadjFZadsVGPHhiIn4sdveQTODDCYZRoA
   GKRQPGtqXCAUsybYTpAcMTIKuZaVdqP8cNTO/RSKVnsvVXsq7TyUt7BXt
   v+kwiPfl3YUe6TC6gLbDBWpX7TgF9pEtazMPoO81iElCjYedQxmwBEyH5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="337828641"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="337828641"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 01:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="1005327540"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="1005327540"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.82])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 01:31:57 -0800
Message-ID: <9788f0f1-087f-7f0b-048a-0146afe1f632@intel.com>
Date:   Mon, 6 Mar 2023 11:31:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2 03/10] perf record: Early auxtrace initialization
 before event parsing
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
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
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <4473367b-38e1-7c15-3937-a077d68410b7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/03/23 10:32, Adrian Hunter wrote:
> On 3/03/23 18:40, Liang, Kan wrote:
>>
>>
>> On 2023-03-02 4:25 p.m., Ian Rogers wrote:
>>> This allows event parsing to use the evsel__is_aux_event function,
>>> which is important when determining event grouping.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/arch/x86/util/auxtrace.c | 17 +++++++++++++----
>>>  tools/perf/builtin-record.c         |  6 ++++++
>>>  tools/perf/util/auxtrace.h          |  2 ++
>>>  3 files changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
>>> index 3da506e13f49..de1e4842ea2e 100644
>>> --- a/tools/perf/arch/x86/util/auxtrace.c
>>> +++ b/tools/perf/arch/x86/util/auxtrace.c
>>> @@ -15,6 +15,19 @@
>>>  #include "../../../util/intel-bts.h"
>>>  #include "../../../util/evlist.h"
>>>  
>>> +void auxtrace__early_init(void)
>>> +{
>>> +	struct perf_pmu *intel_pt_pmu;
>>> +	struct perf_pmu *intel_bts_pmu;
>>> +
>>> +	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
>>> +	if (intel_pt_pmu)
>>> +		intel_pt_pmu->auxtrace = true;
>>> +	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
>>> +	if (intel_bts_pmu)
>>> +		intel_bts_pmu->auxtrace = true;
>>> +}
>>> +
>>>  static
>>>  struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
>>>  						    int *err)
>>> @@ -26,11 +39,7 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
>>>  	bool found_bts = false;
>>>  
>>>  	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
>>> -	if (intel_pt_pmu)
>>> -		intel_pt_pmu->auxtrace = true;
>>>  	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
>>> -	if (intel_bts_pmu)
>>> -		intel_bts_pmu->auxtrace = true;
>>>  
>>>  	evlist__for_each_entry(evlist, evsel) {
>>>  		if (intel_pt_pmu && evsel->core.attr.type == intel_pt_pmu->type)
>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>> index 8374117e66f6..a0870c076dc0 100644
>>> --- a/tools/perf/builtin-record.c
>>> +++ b/tools/perf/builtin-record.c
>>> @@ -3940,6 +3940,10 @@ static int record__init_thread_masks(struct record *rec)
>>>  	return ret;
>>>  }
>>>  
>>> +__weak void auxtrace__early_init(void)
>>> +{
>>> +}
>>> +
>>>  int cmd_record(int argc, const char **argv)
>>>  {
>>>  	int err;
>>> @@ -3985,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
>>>  	if (err)
>>>  		return err;
>>>  
>>> +	auxtrace__early_init();
>>
>> So the auxtrace__early_init() will be unconditionally invoked even there
>> is no PT or BTS events, right?
>>
>> Maybe we should move the auxtrace__early_init() to evsel__is_aux_event()
>> and cache the value. The initialization will only be invoked when it's
>> required.
> 
> Although perf_pmu__find() will be called unconditionally via
> record__auxtrace_init() anyway.

However auxtrace__early_init() is before parsing 'verbose' so
debug prints don't work anymore.

How about this instead:

diff --git a/tools/perf/arch/x86/util/auxtrace.c
b/tools/perf/arch/x86/util/auxtrace.c
index 3da506e13f49d..330d03216b0e6 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -26,11 +26,7 @@ struct auxtrace_record
*auxtrace_record__init_intel(struct evlist *evlist,
 	bool found_bts = false;

 	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
-	if (intel_pt_pmu)
-		intel_pt_pmu->auxtrace = true;
 	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
-	if (intel_bts_pmu)
-		intel_bts_pmu->auxtrace = true;

 	evlist__for_each_entry(evlist, evsel) {
 		if (intel_pt_pmu && evsel->core.attr.type == intel_pt_pmu->type)
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 358340b342431..f73b80dcd8bdc 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -27,10 +27,14 @@ static bool cached_list;
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu
*pmu __maybe_unused)
 {
 #ifdef HAVE_AUXTRACE_SUPPORT
-	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME))
+	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
+		pmu->auxtrace = true;
 		return intel_pt_pmu_default_config(pmu);
-	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME))
+	}
+	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
+		pmu->auxtrace = true;
 		pmu->selectable = true;
+	}
 #endif
 	return NULL;
 }



> 
>> Something as below (not tested.)
>>
>> +void auxtrace__init(void)
>> +{
>> +	struct perf_pmu *intel_pt_pmu;
>> +	struct perf_pmu *intel_bts_pmu;
>> +	static bool cached;
>> +
>> +	if (cached)
>> +		return;
>> +	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
>> +	if (intel_pt_pmu)
>> +		intel_pt_pmu->auxtrace = true;
>> +	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
>> +	if (intel_bts_pmu)
>> +		intel_bts_pmu->auxtrace = true;
>> +}
>>
>> bool evsel__is_aux_event(struct evsel *evsel)
>> {
>> 	struct perf_pmu *pmu = evsel__find_pmu(evsel);
>> +	auxtrace__init();
>> 	return pmu && pmu->auxtrace;
>> }
>>
>>
>>
>> Thanks,
>> Kan
>>
>>> +
>>>  	argc = parse_options(argc, argv, record_options, record_usage,
>>>  			    PARSE_OPT_STOP_AT_NON_OPTION);
>>>  	if (quiet)
>>> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
>>> index 29eb82dff574..49a86aa6ac94 100644
>>> --- a/tools/perf/util/auxtrace.h
>>> +++ b/tools/perf/util/auxtrace.h
>>> @@ -457,6 +457,8 @@ struct addr_filters {
>>>  
>>>  struct auxtrace_cache;
>>>  
>>> +void auxtrace__early_init(void);
>>> +
>>>  #ifdef HAVE_AUXTRACE_SUPPORT
>>>  
>>>  u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm);
> 

