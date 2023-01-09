Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71647661C7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 03:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjAICxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 21:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjAICxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 21:53:12 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E63DD2D8;
        Sun,  8 Jan 2023 18:53:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VZ5k-JK_1673232783;
Received: from 30.221.146.193(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZ5k-JK_1673232783)
          by smtp.aliyun-inc.com;
          Mon, 09 Jan 2023 10:53:05 +0800
Message-ID: <c2e5f9d7-c6d8-c70a-8eff-a8e1c5fcf0af@linux.alibaba.com>
Date:   Mon, 9 Jan 2023 10:53:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH v6 1/7] perf vendor events arm64: Add common topdown L1
 metrics
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1673017529-1429208-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1673017529-1429208-2-git-send-email-renyu.zj@linux.alibaba.com>
 <7f60c97a-18df-4f93-0e95-2a9a6dccbda7@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <7f60c97a-18df-4f93-0e95-2a9a6dccbda7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/6 下午11:59, John Garry 写道:
> On 06/01/2023 15:05, Jing Zhang wrote:
>> The metrics of topdown L1 are from ARM sbsa7.0 platform design doc[0],
>> D37-38, which are standard. So put them in the common file sbsa.json of
>> arm64, so that other cores besides n2/v2 can also be reused.
>>
>> Slots may be different in each architecture, so added "#slots" literal
>> to get different constant for each architecture.
>>
>> The value of slots comes from the register PMMIR_EL1, which I can read
>> in /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots. PMMIR_EL1.SLOT
>> might read as zero if the STALL_SLOT event is not implemented or the PMU
>> version is lower than ID_AA64DFR0_EL1_PMUVer_V3P4.
>>
>> [0] https://urldefense.com/v3/__https://documentation-service.arm.com/static/60250c7395978b529036da86?token=__;!!ACWV5N9M2RV99hQ!J5JW3y6GhaJUqLfbEAzWIy4GJOhUkHQN4D5hEv3Outpzd54fN1Nt4LNKGnuRtMAepS_Nit-KLSUW98tVfFR0TmMVGQ$
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> Acked-by: Ian Rogers <irogers@google.com>
> 
> hmmm... you have made significant changes in this version (compared to previous), so I would not have picked up this tag. That's just my opinion.
> 

Thanks for pointing it out.

> As for the patchset org, I'd move the JSON change here into patch #2, and make this patch purely about add "slots" literal support for arm64.
> 

Ok, I will move the changes of sbsa.json and jevent.py to patch#2.

>> ---
>>   tools/perf/arch/arm64/util/pmu.c           | 22 ++++++++++++++++++++++
>>   tools/perf/pmu-events/arch/arm64/sbsa.json | 30 ++++++++++++++++++++++++++++++
>>   tools/perf/pmu-events/jevents.py           |  2 ++
>>   tools/perf/util/expr.c                     |  5 +++++
>>   tools/perf/util/pmu.c                      |  5 +++++
>>   tools/perf/util/pmu.h                      |  1 +
>>   6 files changed, 65 insertions(+)
>>   create mode 100644 tools/perf/pmu-events/arch/arm64/sbsa.json
>>
>> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
>> index 477e513..227dadb 100644
>> --- a/tools/perf/arch/arm64/util/pmu.c
>> +++ b/tools/perf/arch/arm64/util/pmu.c
>> @@ -3,6 +3,7 @@
>>   #include <internal/cpumap.h>
>>   #include "../../../util/cpumap.h"
>>   #include "../../../util/pmu.h"
>> +#include <api/fs/fs.h>
>>     const struct pmu_events_table *pmu_events_table__find(void)
>>   {
>> @@ -24,3 +25,24 @@ const struct pmu_events_table *pmu_events_table__find(void)
>>         return NULL;
>>   }
>> +
>> +int perf_pmu__get_slots(void)
>> +{
>> +    char path[PATH_MAX];
>> +    unsigned long long slots = 0;
>> +    struct perf_pmu *pmu = NULL;
>> +
>> +    while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>> +        if (is_pmu_core(pmu->name))
>> +            break;
>> +    }
> 
> There is a lot in common with arm64's pmu_events_table__find() - can you factor it out? I also prefer how we check for homogeneous CPUs in pmu_events_table__find() (which you should do, also).
> 

I'll factor out the pmu_core__find function in tools/perf/arch/arm64/util/pmu.c:

static const struct perf_pmu *pmu_core__find(void)
{
	struct perf_pmu *pmu = NULL;

	while ((pmu = perf_pmu__scan(pmu))) {
		if (!is_pmu_core(pmu->name))
			continue;

		/*
		 * The cpumap should cover all CPUs. Otherwise, some CPUs may
		 * not support some events or have different event IDs.
		 */
		if (pmu->cpus->nr != cpu__max_cpu().cpu)
			return NULL;
		return pmu;
	}

	return NULL;
}

>> +    if (pmu) {
>> +        scnprintf(path, PATH_MAX,
>> +            EVENT_SOURCE_DEVICE_PATH "%s/caps/slots", pmu->name);
>> +        /* The value of slots is not greater than INT_MAX, but sysfs__read_int
>> +         * can't read value with 0x prefix, so use sysfs__read_ull instead.
>> +         */
>> +        sysfs__read_ull(path, &slots);
>> +    }
>> +    return (int)slots;
>> +}
>> diff --git a/tools/perf/pmu-events/arch/arm64/sbsa.json b/tools/perf/pmu-events/arch/arm64/sbsa.json
>> new file mode 100644
>> index 0000000..f678c37e
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/sbsa.json
>> @@ -0,0 +1,30 @@
>> +[
>> +    {
>> +        "MetricExpr": "stall_slot_frontend / (#slots * cpu_cycles)",
>> +        "BriefDescription": "Frontend bound L1 topdown metric",
>> +        "MetricGroup": "TopdownL1",
>> +        "MetricName": "frontend_bound",
>> +        "ScaleUnit": "100%"
>> +    },
>> +    {
>> +        "MetricExpr": "(1 - op_retired / op_spec) * (1 - stall_slot / (#slots * cpu_cycles))",
>> +        "BriefDescription": "Bad speculation L1 topdown metric",
>> +        "MetricGroup": "TopdownL1",
>> +        "MetricName": "bad_speculation",
>> +        "ScaleUnit": "100%"
>> +    },
>> +    {
>> +        "MetricExpr": "(op_retired / op_spec) * (1 - stall_slot / (#slots * cpu_cycles))",
>> +        "BriefDescription": "Retiring L1 topdown metric",
>> +        "MetricGroup": "TopdownL1",
>> +        "MetricName": "retiring",
>> +        "ScaleUnit": "100%"
>> +    },
>> +    {
>> +        "MetricExpr": "stall_slot_backend / (#slots * cpu_cycles)",
>> +        "BriefDescription": "Backend Bound L1 topdown metric",
>> +        "MetricGroup": "TopdownL1",
>> +        "MetricName": "backend_bound",
>> +        "ScaleUnit": "100%"
>> +    }
>> +]
>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>> index 4c398e0..0416b74 100755
>> --- a/tools/perf/pmu-events/jevents.py
>> +++ b/tools/perf/pmu-events/jevents.py
>> @@ -358,6 +358,8 @@ def preprocess_arch_std_files(archpath: str) -> None:
>>         for event in read_json_events(item.path, topic=''):
>>           if event.name:
>>             _arch_std_events[event.name.lower()] = event
>> +        if event.metric_name:
>> +          _arch_std_events[event.metric_name.lower()] = event
>>       def print_events_table_prefix(tblname: str) -> None:
>> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
>> index 00dcde3..3d67707 100644
>> --- a/tools/perf/util/expr.c
>> +++ b/tools/perf/util/expr.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/zalloc.h>
>>   #include <ctype.h>
>>   #include <math.h>
>> +#include "pmu.h"
>>     #ifdef PARSER_DEBUG
>>   extern int expr_debug;
>> @@ -448,6 +449,10 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
>>           result = topology->core_cpus_lists;
>>           goto out;
>>       }
>> +    if (!strcmp("#slots", literal)) {
>> +        result = perf_pmu__get_slots();
>> +        goto out;
>> +    }
>>         pr_err("Unrecognized literal '%s'", literal);
>>   out:
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 2bdeb89..d4cace2 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -1993,3 +1993,8 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
>>       *ucpus_ptr = unmatched_cpus;
>>       return 0;
>>   }
>> +
>> +int __weak perf_pmu__get_slots(void)
>> +{
>> +    return 0;
> 
> should this be NAN?
> 

Will do.

>> +}
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index 69ca000..a2f7df8 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -259,4 +259,5 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
>>     char *pmu_find_real_name(const char *name);
>>   char *pmu_find_alias_name(const char *name);
>> +int perf_pmu__get_slots(void);
> 
> I think that this name is a bit too vague. Maybe perf_pmu__cpu_cycles_per_slot() could be better.
> 

Does cpu_cycles_per_slot mean "cpu cycles per slot"? In the documemt, Slots mean operation width.
If slots are 5, the largest value by which the STALL_SLOT PMU event may increment in one cycle is 5.
So, maybe perf_pmu__cpu_slots_per_cycle() could be more accurate？
