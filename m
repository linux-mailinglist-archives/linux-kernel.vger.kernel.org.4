Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12E26F8453
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjEENpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjEENpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:45:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF192155B;
        Fri,  5 May 2023 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683294330; x=1714830330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=42L7GjxIEkjGhQBPMXtOX9n6NWb+WpD3cexgOPsFemY=;
  b=PgSGohCXbl7AsajOS53p5dD9jDPz6doQcfhZBZmR6qOaLh8Xm/qRiTT5
   c7OviHbMlxYAISdkTvV2m2YYWLxsLZtj+SI1FB/iey8iPzfHVUxL87M7m
   fQEy/wNBxzSRSDzWyA7VUbQ2LQM8t7Plzbv/R+TZXavkGYc8aDTxR+S64
   gXVTkVra8+pZBfzqDgqno2TDwZ5NxN9O9fvgNd0d6Ej1rZAWC/ak+yRzf
   msgOl3dwFis7PsM0kBC7GL+JH7GYz2nmR8jPSkHmcD0z/ofMm8QrV02HF
   HzU13Ta2VSqhwM7tL7KooeY4ilGdDh4sWVjVZqN8IkXLclFKd7swufzrn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="338398986"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="338398986"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 06:45:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="691690630"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="691690630"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.216.212])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 06:45:28 -0700
Message-ID: <61381938-d5f7-60fd-ae2a-1fa17c3f2112@intel.com>
Date:   Fri, 5 May 2023 16:45:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH] perf parse-events: Do not break up AUX event group
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20230505064452.9660-1-adrian.hunter@intel.com>
 <CAP-5=fUwwvVVa=+bHEPC+bzxQFXVoXQmd+ercYtTDRSa5jDfWw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fUwwvVVa=+bHEPC+bzxQFXVoXQmd+ercYtTDRSa5jDfWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/05/23 16:02, Ian Rogers wrote:
> On Thu, May 4, 2023 at 11:45 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Assume AUX event group is correct and not do break it up.
>>
>> Example:
>>
>>  Before:
>>
>>     $ perf record --no-bpf-event -c 10 -e '{intel_pt//,tlb_flush.stlb_any/aux-sample-size=8192/pp}:u' -- sleep 0.1
> 
> Could we add this, or similar, to the intel_pt tests?

Sure

> 
>>     WARNING: events were regrouped to match PMUs
>>     Cannot add AUX area sampling to a group leader
>>
>>  After:
>>
>>     $ perf record --no-bpf-event -c 10 -e '{intel_pt//,tlb_flush.stlb_any/aux-sample-size=8192/pp}:u' -- sleep 0.1
>>     [ perf record: Woken up 1 times to write data ]
>>     [ perf record: Captured and wrote 0.078 MB perf.data ]
>>     $ perf script -F-dso,+addr | grep -C5 tlb_flush.stlb_any | head -11
>>     sleep 20444 [003]  7939.510243:  1  branches:uH:  7f5350cc82a2 dl_main+0x9a2 => 7f5350cb38f0 _dl_add_to_namespace_list+0x0
>>     sleep 20444 [003]  7939.510243:  1  branches:uH:  7f5350cb3908 _dl_add_to_namespace_list+0x18 => 7f5350cbb080 rtld_mutex_dummy+0x0
>>     sleep 20444 [003]  7939.510243:  1  branches:uH:  7f5350cc8350 dl_main+0xa50 => 0 [unknown]
>>     sleep 20444 [003]  7939.510244:  1  branches:uH:  7f5350cc83ca dl_main+0xaca => 7f5350caeb60 _dl_process_pt_gnu_property+0x0
>>     sleep 20444 [003]  7939.510245:  1  branches:uH:  7f5350caeb60 _dl_process_pt_gnu_property+0x0 => 0 [unknown]
>>     sleep 20444  7939.510245:       10 tlb_flush.stlb_any/aux-sample-size=8192/pp: 0 7f5350caeb60 _dl_process_pt_gnu_property+0x0
>>     sleep 20444 [003]  7939.510254:  1  branches:uH:  7f5350cc87fe dl_main+0xefe => 7f5350ccd240 strcmp+0x0
>>     sleep 20444 [003]  7939.510254:  1  branches:uH:  7f5350cc8862 dl_main+0xf62 => 0 [unknown]
>>     sleep 20444 [003]  7939.510255:  1  branches:uH:  7f5350cc9cdc dl_main+0x23dc => 0 [unknown]
>>     sleep 20444 [003]  7939.510257:  1  branches:uH:  7f5350cc89f6 dl_main+0x10f6 => 7f5350cb9530 _dl_setup_hash+0x0
>>     sleep 20444 [003]  7939.510257:  1  branches:uH:  7f5350cc8a2d dl_main+0x112d => 7f5350cb3990 _dl_new_object+0x0
>>
>> Fixes: 347c2f0a0988 ("perf parse-events: Sort and group parsed events")
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> These changes are related:
> https://lore.kernel.org/lkml/20230502223851.2234828-5-irogers@google.com/
> https://lore.kernel.org/lkml/20230502223851.2234828-20-irogers@google.com/

Ok but 347c2f0a0988 is queued for 6.4, so these fixes need to go to 6.4 as well

> 
>> ---
>>  tools/perf/util/evsel.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 356c07f03be6..a34f61a5271d 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -828,7 +828,11 @@ bool evsel__name_is(struct evsel *evsel, const char *name)
>>
>>  const char *evsel__group_pmu_name(const struct evsel *evsel)
>>  {
>> -       const struct evsel *leader;
>> +       const struct evsel *leader = evsel__leader(evsel);
>> +
>> +       /* Never break AUX event groups */
>> +       if (evsel__is_aux_event(leader))
>> +               return leader->pmu_name;
>>
>>         /* If the pmu_name is set use it. pmu_name isn't set for CPU and software events. */
> 
> I think this comment isn't true, hence this patch. I think we should
> just move the check into the return, so:
> return evsel->pmu_name ?: "cpu";

Ok I will send a V2

> 
> Sorry for the breakage!

No problem!

> 
> Thanks,
> Ian
> 
>>         if (evsel->pmu_name)
>> @@ -837,15 +841,9 @@ const char *evsel__group_pmu_name(const struct evsel *evsel)
>>          * Software events may be in a group with other uncore PMU events. Use
>>          * the pmu_name of the group leader to avoid breaking the software event
>>          * out of the group.
>> -        *
>> -        * Aux event leaders, like intel_pt, expect a group with events from
>> -        * other PMUs, so substitute the AUX event's PMU in this case.
>>          */
>> -       leader  = evsel__leader(evsel);
>> -       if ((evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) &&
>> -           leader->pmu_name) {
>> +       if (evsel->core.attr.type == PERF_TYPE_SOFTWARE && leader->pmu_name)
>>                 return leader->pmu_name;
>> -       }
>>
>>         return "cpu";
>>  }
>> --
>> 2.34.1
>>

