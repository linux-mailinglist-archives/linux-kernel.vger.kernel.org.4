Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC93C6F08C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbjD0PwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243994AbjD0PwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:52:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 430D7CD;
        Thu, 27 Apr 2023 08:52:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 976E72F4;
        Thu, 27 Apr 2023 08:52:55 -0700 (PDT)
Received: from [10.57.56.155] (unknown [10.57.56.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C42833F64C;
        Thu, 27 Apr 2023 08:52:08 -0700 (PDT)
Message-ID: <dac76dd5-d5f0-61dd-fafe-f939f1ebc413@arm.com>
Date:   Thu, 27 Apr 2023 16:52:06 +0100
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
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230427151228.GA152865@leoy-huanghe>
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



On 27/04/2023 16:12, Leo Yan wrote:
> Hi James,
> 
> On Mon, Apr 24, 2023 at 02:47:44PM +0100, James Clark wrote:
>> Currently the cs_etm_set_option() function both validates and applies
>> the config options. Because it's only called when they are added
>> automatically, there are some paths where the user can apply the option
>> on the command line and skip the validation. By moving it to the end it
>> covers both cases.
>>
>> Also, options don't need to be re-applied anyway, Perf handles parsing
>> and applying the config terms automatically.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/arch/arm/util/cs-etm.c | 152 +++++++++++++-----------------
>>  1 file changed, 68 insertions(+), 84 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
>> index f9b9ebf7fffc..af0a2400c655 100644
>> --- a/tools/perf/arch/arm/util/cs-etm.c
>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>> @@ -69,21 +69,29 @@ static const char * const metadata_ete_ro[] = {
>>  static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
>>  static bool cs_etm_is_ete(struct auxtrace_record *itr, int cpu);
>>  
>> -static int cs_etm_set_context_id(struct auxtrace_record *itr,
>> -				 struct evsel *evsel, int cpu)
>> +static int cs_etm_validate_context_id(struct auxtrace_record *itr,
>> +				      struct evsel *evsel, int cpu)
>>  {
>> -	struct cs_etm_recording *ptr;
>> -	struct perf_pmu *cs_etm_pmu;
>> +	struct cs_etm_recording *ptr =
>> +		container_of(itr, struct cs_etm_recording, itr);
>> +	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
>>  	char path[PATH_MAX];
>> -	int err = -EINVAL;
>> +	int err;
>>  	u32 val;
>> -	u64 contextid;
>> +	u64 contextid =
>> +		evsel->core.attr.config &
>> +		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
>> +		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2"));
> 
> Seems to me, this would break backward compability.
> 
> The old kernel (before 5.11) doesn't provide 'contextid1' and
> 'contextid2', so we always check the entry 'contextid' rather than
> 'contextid1' and 'contextid2'.
> 
> With this change, if a kernel doesn't contain 'contextid1' and
> 'contextid2' formats, will perf tool never trace for contexid?
> 

No because I changed to to be purely validation, so the format flags
would still be applied. But yes I think you are right there is a small
issue.

Now validation of 'contextid' isn't done on pre 5.11 kernels. But that
only checks for ETMv3 anyway. Validation of 'contextid1' and
'contextid2' isn't a problem, because if the kernel doesn't support them
they can't be applied on the command line anyway.

I can fix it by checking for 'contextid' and ETMv3 first and then doing
'contextid1' and 'contextid2' after.

> Thanks,
> Leo
> 
