Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02C7628346
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiKNOzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbiKNOzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:55:13 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F274E2669;
        Mon, 14 Nov 2022 06:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668437712; x=1699973712;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=toX6ocU5PQ3vfx9QDyvsMnRqotkFEClxLgi9aKAZwNQ=;
  b=hExl5P3zUYWiN8FRbJhImknesl8MdDyRPONhvP2CmLaldiIANuPUiNMM
   Xp9yCsRc26JueOynTmi2LjMzMeE+WlIwwNqGRsbMddyboxKlTngraZmGF
   o2Z9vTY9CEkgD5aA6mFZ4JFSFD347xCXOFW7y7B12gFNHnsDIR3Ipxkod
   HFJmr+FbDxC+P2bvLZdql+DYRQuEVM/mtOjnVEF8xO+9RALIupmHQ7LVL
   rzLZc20tpoxD9acBv5BuoUp7U+Ib3pYcyz2c0mJC7a5oc/LRV7TeHQuUd
   cQtFz4ElZxVRCOH4jPrc/poxYS8wzk/9rEc0Vh4f8O60hgCmmlWvZTbgE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="310692977"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="310692977"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 06:53:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="616334347"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="616334347"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2022 06:53:47 -0800
Received: from [10.252.208.163] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 05142580A5F;
        Mon, 14 Nov 2022 06:53:44 -0800 (PST)
Message-ID: <488758d4-2bfb-d5dd-473a-c2e9184ad470@linux.intel.com>
Date:   Mon, 14 Nov 2022 09:53:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 4/9] perf list: Generalize limiting to a PMU name
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20221114075127.2650315-1-irogers@google.com>
 <20221114075127.2650315-5-irogers@google.com>
 <78669391-0dec-1182-178d-aa4bbda54ea9@linux.intel.com>
 <CAP-5=fVfAbhhSpGCpCZCt5J3dY7U5HfMrG2z+6yUDSy3Vr7_iQ@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVfAbhhSpGCpCZCt5J3dY7U5HfMrG2z+6yUDSy3Vr7_iQ@mail.gmail.com>
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



On 2022-11-14 9:02 a.m., Ian Rogers wrote:
> On Mon, Nov 14, 2022 at 5:58 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2022-11-14 2:51 a.m., Ian Rogers wrote:
>>> Deprecate the --cputype option and add a --unit option where '--unit
>>> cpu_atom' behaves like '--cputype atom'. The --unit option can be used
>>> with arbitrary PMUs, for example:
>>>
>>> ```
>>> $ perf list --unit msr pmu
>>>
>>> List of pre-defined events (to be used in -e or -M):
>>>
>>>   msr/aperf/                                         [Kernel PMU event]
>>>   msr/cpu_thermal_margin/                            [Kernel PMU event]
>>>   msr/mperf/                                         [Kernel PMU event]
>>>   msr/pperf/                                         [Kernel PMU event]
>>>   msr/smi/                                           [Kernel PMU event]
>>>   msr/tsc/                                           [Kernel PMU event]
>>> ```
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/Documentation/perf-list.txt |  6 +++---
>>>  tools/perf/builtin-list.c              | 18 ++++++++++++------
>>>  tools/perf/util/metricgroup.c          |  3 ++-
>>>  tools/perf/util/pmu.c                  |  4 +---
>>>  4 files changed, 18 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
>>> index 57384a97c04f..44a819af573d 100644
>>> --- a/tools/perf/Documentation/perf-list.txt
>>> +++ b/tools/perf/Documentation/perf-list.txt
>>> @@ -39,9 +39,9 @@ any extra expressions computed by perf stat.
>>>  --deprecated::
>>>  Print deprecated events. By default the deprecated events are hidden.
>>>
>>> ---cputype::
>>> -Print events applying cpu with this type for hybrid platform
>>> -(e.g. --cputype core or --cputype atom)
>>
>> The "--cputype" is removed from the documentation, but the code is still
>> available. It sounds weird.
>>
>> Can we still keep the "--cputype" in the documentation? Just say that
>> it's a deprecated option, please use the --unit cpu_atom instead. I
>> think even better if we can throw a warning and point to --unit when the
>> "--cputype" is used.
> 
> I think we want to remove --cputype widely in the code and replace
> what it does with specifying a PMU name. Advertising a flag but then
> warning seems strange and is a behavioral change from what is
> currently done. For raw-dump we don't document it in the man page and
> hide the flag, this is the pattern being followed here.

I see. So the --cputype is still supported, but only be hidden in the
default. Sure, we can follow the pattern.

> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>> +--unit::
>>> +Print PMU events and metrics limited to the specific PMU name.
>>> +(e.g. --unit cpu, --unit msr, --unit cpu_core, --unit cpu_atom)
>>>
>>>  [[EVENT_MODIFIERS]]
>>>  EVENT MODIFIERS
>>> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
>>> index 58e1ec1654ef..cc84ced6da26 100644
>>> --- a/tools/perf/builtin-list.c
>>> +++ b/tools/perf/builtin-list.c
>>> @@ -21,7 +21,6 @@
>>>
>>>  static bool desc_flag = true;
>>>  static bool details_flag;
>>> -static const char *hybrid_type;
>>>
>>>  int cmd_list(int argc, const char **argv)
>>>  {
>>> @@ -30,6 +29,8 @@ int cmd_list(int argc, const char **argv)
>>>       bool long_desc_flag = false;
>>>       bool deprecated = false;
>>>       char *pmu_name = NULL;
>>> +     const char *hybrid_name = NULL;
>>> +     const char *unit_name = NULL;
>>>       struct option list_options[] = {
>>>               OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
>>>               OPT_BOOLEAN('d', "desc", &desc_flag,
>>> @@ -40,9 +41,10 @@ int cmd_list(int argc, const char **argv)
>>>                           "Print information on the perf event names and expressions used internally by events."),
>>>               OPT_BOOLEAN(0, "deprecated", &deprecated,
>>>                           "Print deprecated events."),
>>> -             OPT_STRING(0, "cputype", &hybrid_type, "hybrid cpu type",
>>> -                        "Print events applying cpu with this type for hybrid platform "
>>> -                        "(e.g. core or atom)"),
>>> +             OPT_STRING(0, "cputype", &hybrid_name, "hybrid cpu type",
>>> +                        "Limit PMU or metric printing to the given hybrid PMU (e.g. core or atom)."),
>>> +             OPT_STRING(0, "unit", &unit_name, "PMU name",
>>> +                        "Limit PMU or metric printing to the specified PMU."),
>>>               OPT_INCR(0, "debug", &verbose,
>>>                            "Enable debugging output"),
>>>               OPT_END()
>>> @@ -53,6 +55,8 @@ int cmd_list(int argc, const char **argv)
>>>       };
>>>
>>>       set_option_flag(list_options, 0, "raw-dump", PARSE_OPT_HIDDEN);
>>> +     /* Hide hybrid flag for the more generic 'unit' flag. */
>>> +     set_option_flag(list_options, 0, "cputype", PARSE_OPT_HIDDEN);
>>>
>>>       argc = parse_options(argc, argv, list_options, list_usage,
>>>                            PARSE_OPT_STOP_AT_NON_OPTION);
>>> @@ -62,8 +66,10 @@ int cmd_list(int argc, const char **argv)
>>>       if (!raw_dump && pager_in_use())
>>>               printf("\nList of pre-defined events (to be used in -e or -M):\n\n");
>>>
>>> -     if (hybrid_type) {
>>> -             pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_type);
>>> +     if (unit_name)
>>> +             pmu_name = strdup(unit_name);
>>> +     else if (hybrid_name) {
>>> +             pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_name);
>>>               if (!pmu_name)
>>>                       pr_warning("WARNING: hybrid cputype is not supported!\n");
>>>       }

Can the tool implicitly convert the --cputype to --unit at the very
beginning? (Just need to append a prefix "cpu_".). Here we only need to
handle the unit_name.
The same logic may be applied for other tools if someone implements the
--unit for the stat or record later.

BTW: we may want to check the existence of a PMU here, just like what we
did for the hybrid. If a user perf list a nonexistence PMU, we can warn
here.

Thanks,
Kan

>>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>>> index 4c98ac29ee13..1943fed9b6d9 100644
>>> --- a/tools/perf/util/metricgroup.c
>>> +++ b/tools/perf/util/metricgroup.c
>>> @@ -556,11 +556,12 @@ static int metricgroup__print_callback(const struct pmu_event *pe,
>>>                                      void *vdata)
>>>  {
>>>       struct metricgroup_print_data *data = vdata;
>>> +     const char *pmu = pe->pmu ?: "cpu";
>>>
>>>       if (!pe->metric_expr)
>>>               return 0;
>>>
>>> -     if (data->pmu_name && perf_pmu__is_hybrid(pe->pmu) && strcmp(data->pmu_name, pe->pmu))
>>> +     if (data->pmu_name && strcmp(data->pmu_name, pmu))
>>>               return 0;
>>>
>>>       return metricgroup__print_pmu_event(pe, data->metricgroups, data->filter,
>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>> index a8f9f47c6ed9..9c771f136b81 100644
>>> --- a/tools/perf/util/pmu.c
>>> +++ b/tools/perf/util/pmu.c
>>> @@ -1694,10 +1694,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
>>>       pmu = NULL;
>>>       j = 0;
>>>       while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>>> -             if (pmu_name && perf_pmu__is_hybrid(pmu->name) &&
>>> -                 strcmp(pmu_name, pmu->name)) {
>>> +             if (pmu_name && pmu->name && strcmp(pmu_name, pmu->name))
>>>                       continue;
>>> -             }
>>>
>>>               list_for_each_entry(alias, &pmu->aliases, list) {
>>>                       char *name = alias->desc ? alias->name :
