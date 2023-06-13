Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF9172EC78
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbjFMUHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbjFMUHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:07:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E611BD2;
        Tue, 13 Jun 2023 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686686824; x=1718222824;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a804CwrYAf0HAv53XDNgBbhDn4VLOdfyX2TznE5mT1A=;
  b=WdouPiOWx5ZsiN2tiUx5NH8tr4+yKz83UEPcFx90JTYBt9krYltYNJdC
   enV6/a1vL2lfwkStB6BkR3ZvfNh8Di/Mht16itEVgrNeCU0aqXa//6MBs
   tXhBQj3wFblDQoKSAvvH+XXoV4Ez/SBUCiaQRNmx5Ilv6hUSl95fmOPMY
   0CQ1+UkTPCDfGEW7czlY8+j0Ucxry9MX2HzD4HJzxOZZ2Mvk0jG3Kasi9
   jFUEOb2UJ35B8eo9xWsUgON8AtZ6Do/j7YG991+OuJjx+EHYBT98f1l+E
   O213C0LxywAAhOyrtKNAAx/e4IRbyU18nExL/nEKGT13qAF+nL7NzIbUp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="424323365"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="424323365"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 13:07:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="885962361"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="885962361"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 13 Jun 2023 13:07:02 -0700
Received: from [10.251.24.95] (kliang2-mobl1.ccr.corp.intel.com [10.251.24.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E5DF2580BF8;
        Tue, 13 Jun 2023 13:07:00 -0700 (PDT)
Message-ID: <7487eff9-5769-1701-ea1b-45dd5ab67c85@linux.intel.com>
Date:   Tue, 13 Jun 2023 16:06:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/8] perf evsel: Fix the annotation for hardware events on
 hybrid
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
 <20230607162700.3234712-3-kan.liang@linux.intel.com>
 <CAP-5=fVz1zgwdJVs1V7putUdp9wf-QKWH1Ky-heLoHWgnJu6dg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVz1zgwdJVs1V7putUdp9wf-QKWH1Ky-heLoHWgnJu6dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-13 3:35 p.m., Ian Rogers wrote:
> On Wed, Jun 7, 2023 at 9:27 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The annotation for hardware events is wrong on hybrid. For example,
>>
>>  # ./perf stat -a sleep 1
>>
>>  Performance counter stats for 'system wide':
>>
>>          32,148.85 msec cpu-clock                        #   32.000 CPUs utilized
>>                374      context-switches                 #   11.633 /sec
>>                 33      cpu-migrations                   #    1.026 /sec
>>                295      page-faults                      #    9.176 /sec
>>         18,979,960      cpu_core/cycles/                 #  590.378 K/sec
>>        261,230,783      cpu_atom/cycles/                 #    8.126 M/sec                       (54.21%)
>>         17,019,732      cpu_core/instructions/           #  529.404 K/sec
>>         38,020,470      cpu_atom/instructions/           #    1.183 M/sec                       (63.36%)
>>          3,296,743      cpu_core/branches/               #  102.546 K/sec
>>          6,692,338      cpu_atom/branches/               #  208.167 K/sec                       (63.40%)
>>             96,421      cpu_core/branch-misses/          #    2.999 K/sec
>>          1,016,336      cpu_atom/branch-misses/          #   31.613 K/sec                       (63.38%)
>>
>> The hardware events have extended type on hybrid, but the evsel__match()
>> doesn't take it into account.
>>
>> Add a mask to filter the extended type on hybrid when checking the config.
>>
>> With the patch,
>>
>>  # ./perf stat -a sleep 1
>>
>>  Performance counter stats for 'system wide':
>>
>>          32,139.90 msec cpu-clock                        #   32.003 CPUs utilized
>>                343      context-switches                 #   10.672 /sec
>>                 32      cpu-migrations                   #    0.996 /sec
>>                 73      page-faults                      #    2.271 /sec
>>         13,712,841      cpu_core/cycles/                 #    0.000 GHz
>>        258,301,691      cpu_atom/cycles/                 #    0.008 GHz                         (54.20%)
>>         12,428,163      cpu_core/instructions/           #    0.91  insn per cycle
>>         37,786,557      cpu_atom/instructions/           #    2.76  insn per cycle              (63.35%)
>>          2,418,826      cpu_core/branches/               #   75.259 K/sec
>>          6,965,962      cpu_atom/branches/               #  216.739 K/sec                       (63.38%)
>>             72,150      cpu_core/branch-misses/          #    2.98% of all branches
>>          1,032,746      cpu_atom/branch-misses/          #   42.70% of all branches             (63.35%)
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/util/evsel.h       | 12 ++++++-----
>>  tools/perf/util/stat-shadow.c | 39 +++++++++++++++++++----------------
>>  2 files changed, 28 insertions(+), 23 deletions(-)
>>
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index b365b449c6ea..36a32e4ca168 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -350,9 +350,11 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
>>
>>  struct tep_format_field *evsel__field(struct evsel *evsel, const char *name);
>>
>> -#define evsel__match(evsel, t, c)              \
>> +#define EVSEL_EVENT_MASK                       (~0ULL)
>> +
>> +#define evsel__match(evsel, t, c, m)                   \
>>         (evsel->core.attr.type == PERF_TYPE_##t &&      \
>> -        evsel->core.attr.config == PERF_COUNT_##c)
>> +        (evsel->core.attr.config & m) == PERF_COUNT_##c)
> 
> The EVSEL_EVENT_MASK here isn't very intention revealing, perhaps we
> can remove it and do something like:
> 
> static inline bool __evsel__match(const struct evsel *evsel, u32 type,
> u64 config)
> {
>   if ((type == PERF_TYPE_HARDWARE || type ==PERF_TYPE_HW_CACHE)  &&
> perf_pmus__supports_extended_type())
>      return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == config;
> 
>   return evsel->core.attr.config == config;
> }
> #define evsel__match(evsel, t, c) __evsel__match(evsel, PERF_TYPE_##t,
> PERF_COUNT_##c)

Yes, the above code looks better. I will apply it in V2.

Thanks,
Kan
> 
> Thanks,
> Ian
> 
>>
>>  static inline bool evsel__match2(struct evsel *e1, struct evsel *e2)
>>  {
>> @@ -438,13 +440,13 @@ bool evsel__is_function_event(struct evsel *evsel);
>>
>>  static inline bool evsel__is_bpf_output(struct evsel *evsel)
>>  {
>> -       return evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT);
>> +       return evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT, EVSEL_EVENT_MASK);
>>  }
>>
>>  static inline bool evsel__is_clock(const struct evsel *evsel)
>>  {
>> -       return evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK) ||
>> -              evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
>> +       return evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK, EVSEL_EVENT_MASK) ||
>> +              evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK, EVSEL_EVENT_MASK);
>>  }
>>
>>  bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize);
>> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
>> index 1566a206ba42..074f38b57e2d 100644
>> --- a/tools/perf/util/stat-shadow.c
>> +++ b/tools/perf/util/stat-shadow.c
>> @@ -6,6 +6,7 @@
>>  #include "color.h"
>>  #include "debug.h"
>>  #include "pmu.h"
>> +#include "pmus.h"
>>  #include "rblist.h"
>>  #include "evlist.h"
>>  #include "expr.h"
>> @@ -78,6 +79,8 @@ void perf_stat__reset_shadow_stats(void)
>>
>>  static enum stat_type evsel__stat_type(const struct evsel *evsel)
>>  {
>> +       u64 mask = perf_pmus__supports_extended_type() ? PERF_HW_EVENT_MASK : EVSEL_EVENT_MASK;
>> +
>>         /* Fake perf_hw_cache_op_id values for use with evsel__match. */
>>         u64 PERF_COUNT_hw_cache_l1d_miss = PERF_COUNT_HW_CACHE_L1D |
>>                 ((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
>> @@ -97,41 +100,41 @@ static enum stat_type evsel__stat_type(const struct evsel *evsel)
>>
>>         if (evsel__is_clock(evsel))
>>                 return STAT_NSECS;
>> -       else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES))
>> +       else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES, mask))
>>                 return STAT_CYCLES;
>> -       else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS))
>> +       else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS, mask))
>>                 return STAT_INSTRUCTIONS;
>> -       else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
>> +       else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND, mask))
>>                 return STAT_STALLED_CYCLES_FRONT;
>> -       else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND))
>> +       else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND, mask))
>>                 return STAT_STALLED_CYCLES_BACK;
>> -       else if (evsel__match(evsel, HARDWARE, HW_BRANCH_INSTRUCTIONS))
>> +       else if (evsel__match(evsel, HARDWARE, HW_BRANCH_INSTRUCTIONS, mask))
>>                 return STAT_BRANCHES;
>> -       else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES))
>> +       else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES, mask))
>>                 return STAT_BRANCH_MISS;
>> -       else if (evsel__match(evsel, HARDWARE, HW_CACHE_REFERENCES))
>> +       else if (evsel__match(evsel, HARDWARE, HW_CACHE_REFERENCES, mask))
>>                 return STAT_CACHE_REFS;
>> -       else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES))
>> +       else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES, mask))
>>                 return STAT_CACHE_MISSES;
>> -       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1D))
>> +       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1D, mask))
>>                 return STAT_L1_DCACHE;
>> -       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1I))
>> +       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1I, mask))
>>                 return STAT_L1_ICACHE;
>> -       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_LL))
>> +       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_LL, mask))
>>                 return STAT_LL_CACHE;
>> -       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_DTLB))
>> +       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_DTLB, mask))
>>                 return STAT_DTLB_CACHE;
>> -       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_ITLB))
>> +       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_ITLB, mask))
>>                 return STAT_ITLB_CACHE;
>> -       else if (evsel__match(evsel, HW_CACHE, hw_cache_l1d_miss))
>> +       else if (evsel__match(evsel, HW_CACHE, hw_cache_l1d_miss, mask))
>>                 return STAT_L1D_MISS;
>> -       else if (evsel__match(evsel, HW_CACHE, hw_cache_l1i_miss))
>> +       else if (evsel__match(evsel, HW_CACHE, hw_cache_l1i_miss, mask))
>>                 return STAT_L1I_MISS;
>> -       else if (evsel__match(evsel, HW_CACHE, hw_cache_ll_miss))
>> +       else if (evsel__match(evsel, HW_CACHE, hw_cache_ll_miss, mask))
>>                 return STAT_LL_MISS;
>> -       else if (evsel__match(evsel, HW_CACHE, hw_cache_dtlb_miss))
>> +       else if (evsel__match(evsel, HW_CACHE, hw_cache_dtlb_miss, mask))
>>                 return STAT_DTLB_MISS;
>> -       else if (evsel__match(evsel, HW_CACHE, hw_cache_itlb_miss))
>> +       else if (evsel__match(evsel, HW_CACHE, hw_cache_itlb_miss, mask))
>>                 return STAT_ITLB_MISS;
>>         return STAT_NONE;
>>  }
>> --
>> 2.35.1
>>
