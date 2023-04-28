Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59436F1811
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjD1MeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346055AbjD1Mdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:33:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B05249D9;
        Fri, 28 Apr 2023 05:33:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38C29C14;
        Fri, 28 Apr 2023 05:34:18 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0FC53F5A1;
        Fri, 28 Apr 2023 05:33:31 -0700 (PDT)
Message-ID: <15217b55-8a80-fbe9-7b7f-997939f42d0d@arm.com>
Date:   Fri, 28 Apr 2023 13:33:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/7] perf: cs-etm: Validate options after applying
 themperf_pmu__format_bits
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com, denik@google.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230424134748.228137-1-james.clark@arm.com>
 <20230424134748.228137-5-james.clark@arm.com>
 <20230427151228.GA152865@leoy-huanghe>
 <dac76dd5-d5f0-61dd-fafe-f939f1ebc413@arm.com>
 <20230427221047.GA174797@leoy-huanghe>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230427221047.GA174797@leoy-huanghe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/04/2023 23:10, Leo Yan wrote:
> On Thu, Apr 27, 2023 at 04:52:06PM +0100, James Clark wrote:
> 
> [...]
> 
>>>> -static int cs_etm_set_context_id(struct auxtrace_record *itr,
>>>> -				 struct evsel *evsel, int cpu)
>>>> +static int cs_etm_validate_context_id(struct auxtrace_record *itr,
>>>> +				      struct evsel *evsel, int cpu)
>>>>  {
>>>> -	struct cs_etm_recording *ptr;
>>>> -	struct perf_pmu *cs_etm_pmu;
>>>> +	struct cs_etm_recording *ptr =
>>>> +		container_of(itr, struct cs_etm_recording, itr);
>>>> +	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
>>>>  	char path[PATH_MAX];
>>>> -	int err = -EINVAL;
>>>> +	int err;
>>>>  	u32 val;
>>>> -	u64 contextid;
>>>> +	u64 contextid =
>>>> +		evsel->core.attr.config &
>>>> +		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
>>>> +		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2"));
>>>
>>> Seems to me, this would break backward compability.
>>>
>>> The old kernel (before 5.11) doesn't provide 'contextid1' and
>>> 'contextid2', so we always check the entry 'contextid' rather than
>>> 'contextid1' and 'contextid2'.
>>>
>>> With this change, if a kernel doesn't contain 'contextid1' and
>>> 'contextid2' formats, will perf tool never trace for contexid?
>>>
>>
>> No because I changed to to be purely validation, so the format flags
>> would still be applied. But yes I think you are right there is a small
>> issue.
>>
>> Now validation of 'contextid' isn't done on pre 5.11 kernels. But that
>> only checks for ETMv3 anyway.
> 
> IIUC, 'contextid' is not only used for ETMv3.  Just quotes the comments
> from drivers/hwtracing/coresight/coresight-etm-perf.c:
> 

I meant that the validation only looks for the presence of ETMv3 and
shows a warning in that scenario, so that was the only thing not working
any more. Not that it's only used for ETMv3.

>   73 /*
>   74  * contextid always traces the "PID".  The PID is in CONTEXTIDR_EL1
>   75  * when the kernel is running at EL1; when the kernel is at EL2,
>   76  * the PID is in CONTEXTIDR_EL2.
>   77  */
> 
> ETMv4 uses 'contextid' as well, since the user space needs to know which
> exception level's PID should be traced, e.g. when CPU runs in EL2
> 'contextid' is set as ETM_OPT_CTXTID2, the perf tool will set 'contextid2'
> to tell driver to trace CONTEXTIDR_EL2.
> 

That's still working because it reads the config term in the setup
function rather than setting any one bit manually:

  if (!perf_cpu_map__empty(cpus)) {
    evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
                               "timestamp", 1);
    evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
                               "contextid", 1);
  }

> We can only verify 'contextid', and set 'contextid1' or 'contextid2' based
> on CPU running exception level, finally driver knows how to trace PID.
> 
> Thanks,
> Leo
> 

I'm not 100% sure what you mean by this. But previously the validation
was looking at both contextid1 and contextid2 options and checking if
either were supported if either were set.

I have the following change in mind, it fixes the backwards
compatibility issue. And the validation should be exactly the same as it
was before. Except for one bug that I found when both bits are requested
which I've also fixed here:

From f1b9f56df29dfb4f2a7be25f009c79c86335587a Mon Sep 17 00:00:00 2001
From: James Clark <james.clark@arm.com>
Date: Fri, 28 Apr 2023 10:29:52 +0100
Subject: [PATCH] perf cs-etm: Fix contextid validation

Pre 5.11 kernels don't support 'contextid1' and 'contextid2' so
validation would be skipped. By adding an additional check for
'contextid', old kernels will still have validation done even though
contextid would either be contextid1 or contextid2.

Additionally now that it's possible to override options, an existing bug
in the validation is revealed. 'val' is overwritten by the contextid1
validation, and re-used for contextid2 validation causing it to always
fail. '!val || val != 0x4' is the same as 'val != 0x4' because 0 is also
!= 4, so that expression can be simplified and the temp variable not
overwritten.

Fixes: 35c51f83dd1e ("perf cs-etm: Validate options after applying them")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 77cb03e6ff87..9ca040bfb1aa 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -78,9 +78,9 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr,
 	char path[PATH_MAX];
 	int err;
 	u32 val;
-	u64 contextid =
-		evsel->core.attr.config &
-		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
+	u64 contextid = evsel->core.attr.config &
+		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid") |
+		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
 		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2"));
 
 	if (!contextid)
@@ -114,8 +114,7 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr,
 		 *  0b00100 Maximum of 32-bit Context ID size.
 		 *  All other values are reserved.
 		 */
-		val = BMVAL(val, 5, 9);
-		if (!val || val != 0x4) {
+		if (BMVAL(val, 5, 9) != 0x4) {
 			pr_err("%s: CONTEXTIDR_EL1 isn't supported, disable with %s/contextid1=0/\n",
 			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
 			return -EINVAL;
-- 
2.34.1
