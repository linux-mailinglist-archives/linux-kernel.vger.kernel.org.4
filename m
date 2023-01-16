Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B120766BCE0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjAPL2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjAPL1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:27:41 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0298716AD0;
        Mon, 16 Jan 2023 03:27:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VZiaqYu_1673868448;
Received: from 30.221.147.208(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZiaqYu_1673868448)
          by smtp.aliyun-inc.com;
          Mon, 16 Jan 2023 19:27:30 +0800
Message-ID: <7cd44f07-b0a4-a663-8dcf-0d47000b57ea@linux.alibaba.com>
Date:   Mon, 16 Jan 2023 19:27:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v7 1/9] perf pmu: Add #slots literal support for arm64
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
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
References: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1673601740-122788-2-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fWnOGD7CHYeq0Uino4eHte2WP5Pxz9t4YOtvgxrq-_muA@mail.gmail.com>
 <399e8b83-ee7b-1b24-bd6b-74d274fcda46@linux.alibaba.com>
 <CAP-5=fVMA2gkXAAZ8AyhtF4asEZi-p0uxHC-zPyOjjNaEdkS7A@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fVMA2gkXAAZ8AyhtF4asEZi-p0uxHC-zPyOjjNaEdkS7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/16 下午1:59, Ian Rogers 写道:
> On Sun, Jan 15, 2023 at 6:58 PM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>> 在 2023/1/15 上午6:15, Ian Rogers 写道:
>>> On Fri, Jan 13, 2023 at 1:22 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>>>
>>>> The slots in each architecture may be different, so add #slots literal
>>>> to obtain the slots of different architectures, and the #slots can be
>>>> applied in the metric. Currently, The #slots just support for arm64,
>>>> and other architectures will return NAN.
>>>>
>>>> On arm64, the value of slots is from the register PMMIR_EL1.SLOT, which
>>>> I can read in /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots.
>>>> PMMIR_EL1.SLOT might read as zero if the PMU version is lower than
>>>> ID_AA64DFR0_EL1_PMUVer_V3P4 or the STALL_SLOT event is not implemented.
>>>>
>>>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>>>> ---
>>>>  tools/perf/arch/arm64/util/pmu.c | 34 ++++++++++++++++++++++++++++++++--
>>>>  tools/perf/util/expr.c           |  5 +++++
>>>>  tools/perf/util/pmu.c            |  6 ++++++
>>>>  tools/perf/util/pmu.h            |  1 +
>>>>  4 files changed, 44 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
>>>> index 477e513..5f8667b 100644
>>>> --- a/tools/perf/arch/arm64/util/pmu.c
>>>> +++ b/tools/perf/arch/arm64/util/pmu.c
>>>> @@ -3,8 +3,9 @@
>>>>  #include <internal/cpumap.h>
>>>>  #include "../../../util/cpumap.h"
>>>>  #include "../../../util/pmu.h"
>>>> +#include <api/fs/fs.h>
>>>>
>>>> -const struct pmu_events_table *pmu_events_table__find(void)
>>>> +static struct perf_pmu *pmu_core__find_same(void)
>>>
>>> I'm not sure "find_same" is the best name here. I suspect it should be
>>> "find_core_pmu" which would agree with is_arm_pmu_core. Unfortunately
>>> "core" has become an overloaded term sometimes used interchangeably
>>> with CPU, hyperthread or SMT thread, it was a model name for Intel and
>>> it is used to distinguish a set of SMT threads running together from a
>>> single one. Anyway, for consistency I think perf_pmu__find_core_pmu is
>>> the most appropriate name (or pmu__find_core_pmu, I'm not sure why we
>>> get the extra perf_ prefix sometimes, in general that indicates the
>>> functionality is in libperf).
>>>
>>
>> The reason for using "pmu_core__find_same" before is to indicate that we're
>> only dealing with homogeneous cores. And in the tools/perf/util/pmu.c file,
>> most of the static functions have "pmu_" prefix, maybe we can use
>> "pmu_find_same_core_pmu"? Ian, John, what do you think?
> 
> I wouldn't necessarily worry about hybrid given #slots is currently
> ARM specific. For hybrid we'd need to know the CPU for the metric. We
> do have the list of CPUs (really hyper/SMT threads) that were
> requested for the metric:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/expr.h?h=perf/core#n9
> We use it to compute the #core_wide literal. We need the value early
> before events are created, hence the string format. You could search
> pmus looking for a PMU that isn't uncore and has matching CPUs, but
> AMD has multiple core/hardware PMUs (hence Ravi's most recent work)
> and so I suspect we'd need to extend PMU to make this work. We've
> solved a similar problem to this with the source_count metric
> function, that returns a number of aliased events. We could do
> something like:
> slots(INST_RETIRED.MACRO_FUSED)
> and then from the event get the PMU, from the PMU get the CPUs, from a
> CPU get the slots. In that case it may just be cleaner to pass the PMU
> name to the slots function, so:
> slots(cpu_core) or slots(cpu_atom)
> But the parser wouldn't understand that cpu_core or cpu_atom were PMU
> names and would try to handle them as events or metric references.
> 
> Again, I think ignoring the hybrid case is fine in this case. Using
> "same" in the function name to imply "not hybrid" I don't think works,
> so I think something like pmu__find_core_pmu is best. You could have a
> comment and also a:
> assert(!perf_pmu__is_hybrid(pmu->name));
> Ultimately I'd like to get rid of all notions of hybrid and just pair
> events with a PMU. I recently cleaned this up in builtin-list.c.
> 

Ok, you are right, I follow your suggestion and use pmu__find_core_pmu.

I think “if (pmu->cpus->nr != cpu__max_cpu().cpu)” in the original code
and “assert(!perf_pmu__is_hybrid(pmu->name))” have the same effect, so
I will not change it.

> Thanks,
> Ian
> 
>> Thanks,
>> Jing
>>
>>> Aside from that, lgtm. Thanks,
>>> Ian
>>>
>>>>  {
>>>>         struct perf_pmu *pmu = NULL;
>>>>
>>>> @@ -19,8 +20,37 @@ const struct pmu_events_table *pmu_events_table__find(void)
>>>>                 if (pmu->cpus->nr != cpu__max_cpu().cpu)
>>>>                         return NULL;
>>>>
>>>> -               return perf_pmu__find_table(pmu);
>>>> +               return pmu;
>>>>         }
>>>>
>>>>         return NULL;
>>>>  }
>>>> +
>>>> +const struct pmu_events_table *pmu_events_table__find(void)
>>>> +{
>>>> +       struct perf_pmu *pmu = pmu_core__find_same();
>>>> +
>>>> +       if (pmu)
>>>> +               return perf_pmu__find_table(pmu);
>>>> +
>>>> +       return NULL;
>>>> +}
>>>> +
>>>> +double perf_pmu__cpu_slots_per_cycle(void)
>>>> +{
>>>> +       char path[PATH_MAX];
>>>> +       unsigned long long slots = 0;
>>>> +       struct perf_pmu *pmu = pmu_core__find_same();
>>>> +
>>>> +       if (pmu) {
>>>> +               scnprintf(path, PATH_MAX,
>>>> +                       EVENT_SOURCE_DEVICE_PATH "%s/caps/slots", pmu->name);
>>>> +               /*
>>>> +                * The value of slots is not greater than 32 bits, but sysfs__read_int
>>>> +                * can't read value with 0x prefix, so use sysfs__read_ull instead.
>>>> +                */
>>>> +               sysfs__read_ull(path, &slots);
>>>> +       }
>>>> +
>>>> +       return (double)slots;
>>>> +}
>>>> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
>>>> index 00dcde3..9d3076a 100644
>>>> --- a/tools/perf/util/expr.c
>>>> +++ b/tools/perf/util/expr.c
>>>> @@ -19,6 +19,7 @@
>>>>  #include <linux/zalloc.h>
>>>>  #include <ctype.h>
>>>>  #include <math.h>
>>>> +#include "pmu.h"
>>>>
>>>>  #ifdef PARSER_DEBUG
>>>>  extern int expr_debug;
>>>> @@ -448,6 +449,10 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
>>>>                 result = topology->core_cpus_lists;
>>>>                 goto out;
>>>>         }
>>>> +       if (!strcmp("#slots", literal)) {
>>>> +               result = perf_pmu__cpu_slots_per_cycle() ?: NAN;
>>>> +               goto out;
>>>> +       }
>>>>
>>>>         pr_err("Unrecognized literal '%s'", literal);
>>>>  out:
>>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>>> index 2bdeb89..cbb4fbf 100644
>>>> --- a/tools/perf/util/pmu.c
>>>> +++ b/tools/perf/util/pmu.c
>>>> @@ -19,6 +19,7 @@
>>>>  #include <regex.h>
>>>>  #include <perf/cpumap.h>
>>>>  #include <fnmatch.h>
>>>> +#include <math.h>
>>>>  #include "debug.h"
>>>>  #include "evsel.h"
>>>>  #include "pmu.h"
>>>> @@ -1993,3 +1994,8 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
>>>>         *ucpus_ptr = unmatched_cpus;
>>>>         return 0;
>>>>  }
>>>> +
>>>> +double __weak perf_pmu__cpu_slots_per_cycle(void)
>>>> +{
>>>> +       return NAN;
>>>> +}
>>>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>>>> index 69ca000..fd414ba 100644
>>>> --- a/tools/perf/util/pmu.h
>>>> +++ b/tools/perf/util/pmu.h
>>>> @@ -259,4 +259,5 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
>>>>
>>>>  char *pmu_find_real_name(const char *name);
>>>>  char *pmu_find_alias_name(const char *name);
>>>> +double perf_pmu__cpu_slots_per_cycle(void);
>>>>  #endif /* __PMU_H */
>>>> --
>>>> 1.8.3.1
>>>>
