Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA09A5EDFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiI1PGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiI1PGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:06:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8449358539;
        Wed, 28 Sep 2022 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664377577; x=1695913577;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=j38pTaECqTrdhtUjE4df4qFKAnc8TI12hP/8mH2VCb0=;
  b=W+5pnHRum6cbUIMJe3WSTe/tRn2Dj1C2ismqfAjcS2VAGMGL5C59JwWo
   i0UqUmn295hS+0G+mQRtsFzqN33yx4q1Kyw0ge12xW0O/Z+8Iq0ADZGR8
   SsuwcQnlXLn22ynvTGCFfo0C33RdHgg3hCoD+jqP3IaxS8CfveBmxb52R
   Rbh3eBEa0dJfP8ChZ0qtCzAokGrvL2vfd0rPqNAEigG3hQt2WAAjGEWig
   tDqRueJoDpsh2YyDb375aDwiS3jqu6/n/LJA3gH/Od0DCAKTj8A3Sadgw
   JVmj7m2QU8rzx3R4qKVSxoItOqgJohDXBF7Fa4DIGrcfFlzMaDzKY2yvt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="300343318"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="300343318"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:05:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="867003861"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="867003861"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2022 08:05:47 -0700
Received: from [10.252.215.103] (kliang2-mobl1.ccr.corp.intel.com [10.252.215.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id F0404580B55;
        Wed, 28 Sep 2022 08:05:44 -0700 (PDT)
Message-ID: <3119fb80-d8aa-167a-5a6a-27a90abd3f04@linux.intel.com>
Date:   Wed, 28 Sep 2022 11:05:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20220928072204.1613330-1-irogers@google.com>
 <6312dee3-aa37-b244-df0e-a5cd75ddee71@linux.intel.com>
 <CAP-5=fUUohS8LYJOQo7gxViKzp0EJ5Enz797tpWE3dhyq11ODg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v1 00/22] Improvements to Intel perf metrics
In-Reply-To: <CAP-5=fUUohS8LYJOQo7gxViKzp0EJ5Enz797tpWE3dhyq11ODg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-09-28 10:04 a.m., Ian Rogers wrote:
> On Wed, Sep 28, 2022 at 5:56 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2022-09-28 3:21 a.m., Ian Rogers wrote:
>>> For consistency with:
>>> https://github.com/intel/perfmon-metrics
>>> rename of topdown TMA metrics from Frontend_Bound to tma_frontend_bound.
>>>
>>
>> If so, all the scripts with the old name must be broken on the existing
>> platforms. Can we keep both old name and new name for the existing
>> platforms?
>>
>> For the event naming, if we want to rename an event. We still keep the
>> old name and mark it as deprecated in the existing platforms to maintain
>> compatibility.
>>
>> Can we do the similar thing for metrics?
>> For the existing platforms, just add all the metrics from the
>> perfmon-metrics and don't change the existing metrics unless they have
>> errors.
>>
>> Thanks,
>> Kan
> 
> Thanks Kan,
> 
> Do we have examples of scripts that will be impacted by this? My
> thoughts are that such scripts are likely using TopdownL1 as a metric
> group, the metrics within that group vary and names may change over
> time. For example, on hybrid there is Backend_Bound_Aux. Given the
> existing state, such compatibility is only required for level 1
> metrics on CNL CPX CLX KBLR/CFL/CML SKX SKL/KBL BDX BDW HSX HSW IVT
> IVB JKT/SNB-EP SNB. Injecting either a metric group or an aliasing
> metric is messy and when can we stop carrying the patch? There hasn't
> been discussion of doing this in the context of:
> https://github.com/intel/perfmon-metrics
> I'd suggest that this is a good time for script writers to change how
> they use particular metrics and derive the information instead from
> groups like TopdownL1. 

So the rename only impacts the Topdown metrics, right?
We still keep the old group name, TopdownL1.

If so, I agree. It only makes sense when collect in a Top-down group,
not specific metrics.

Thanks,
Kan

> This will also make them robust to changes in
> the TMA metrics CSV files, another win.
> 
> Thanks,
> Ian
> 
> 
>>> Remove _SMT suffix metrics are dropped as the #SMT_On and #EBS_Mode
>>> are correctly expanded in the single main metric. Fix perf expr to
>>> allow a double if to be correctly processed.
>>>
>>> Add all 6 levels of TMA metrics. Child metrics are placed in a group
>>> named after their parent allowing children of a metric to be
>>> easily measured using the metric name with a _group suffix.
>>>
>>> Don't drop TMA metrics if they contain topdown events.
>>>
>>> The ## and ##? operators are correctly expanded.
>>>
>>> The locate-with column is added to the long description describing a
>>> sampling event.
>>>
>>> Metrics are written in terms of other metrics to reduce the expression
>>> size and increase readability.
>>>
>>> Following this the pmu-events/arch/x86 directories match those created
>>> by the script at:
>>> https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py
>>> with updates at:
>>> https://github.com/captain5050/event-converter-for-linux-perf
>>>
>>> Ian Rogers (22):
>>>   perf expr: Allow a double if expression
>>>   perf expr: Remove jevents case workaround
>>>   perf metrics: Don't scale counts going into metrics
>>>   perf vendor events: Update Intel skylakex
>>>   perf vendor events: Update Intel alderlake
>>>   perf vendor events: Update Intel broadwell
>>>   perf vendor events: Update Intel broadwellx
>>>   perf vendor events: Update Intel cascadelakex
>>>   perf vendor events: Update elkhartlake cpuids
>>>   perf vendor events: Update Intel haswell
>>>   perf vendor events: Update Intel haswellx
>>>   perf vendor events: Update Intel icelake
>>>   perf vendor events: Update Intel icelakex
>>>   perf vendor events: Update Intel ivybridge
>>>   perf vendor events: Update Intel ivytown
>>>   perf vendor events: Update Intel jaketown
>>>   perf vendor events: Update Intel sandybridge
>>>   perf vendor events: Update Intel sapphirerapids
>>>   perf vendor events: Update silvermont cpuids
>>>   perf vendor events: Update Intel skylake
>>>   perf vendor events: Update Intel tigerlake
>>>   perf vendor events: Update Intel broadwellde
>>>
>>>  .../arch/x86/alderlake/adl-metrics.json       | 1215 ++++++++++++++++-
>>>  .../pmu-events/arch/x86/alderlake/cache.json  |  129 +-
>>>  .../arch/x86/alderlake/frontend.json          |   12 +
>>>  .../pmu-events/arch/x86/alderlake/memory.json |   22 +
>>>  .../pmu-events/arch/x86/alderlake/other.json  |   22 +
>>>  .../arch/x86/alderlake/pipeline.json          |   14 +-
>>>  .../arch/x86/broadwell/bdw-metrics.json       |  603 ++++++--
>>>  .../arch/x86/broadwellde/bdwde-metrics.json   |  639 +++++++--
>>>  .../arch/x86/broadwellx/bdx-metrics.json      |  644 +++++++--
>>>  .../arch/x86/broadwellx/uncore-cache.json     |   10 +-
>>>  .../x86/broadwellx/uncore-interconnect.json   |   18 +-
>>>  .../arch/x86/broadwellx/uncore-memory.json    |   18 +-
>>>  .../arch/x86/cascadelakex/clx-metrics.json    |  893 ++++++++----
>>>  .../arch/x86/cascadelakex/uncore-memory.json  |   18 +-
>>>  .../arch/x86/cascadelakex/uncore-other.json   |   10 +-
>>>  .../pmu-events/arch/x86/haswell/cache.json    |    4 +-
>>>  .../pmu-events/arch/x86/haswell/frontend.json |   12 +-
>>>  .../arch/x86/haswell/hsw-metrics.json         |  502 +++++--
>>>  .../pmu-events/arch/x86/haswellx/cache.json   |    2 +-
>>>  .../arch/x86/haswellx/frontend.json           |   12 +-
>>>  .../arch/x86/haswellx/hsx-metrics.json        |  707 +++++++---
>>>  .../x86/haswellx/uncore-interconnect.json     |   18 +-
>>>  .../arch/x86/haswellx/uncore-memory.json      |   18 +-
>>>  .../pmu-events/arch/x86/icelake/cache.json    |    6 +-
>>>  .../arch/x86/icelake/icl-metrics.json         |  725 +++++++++-
>>>  .../pmu-events/arch/x86/icelake/pipeline.json |    2 +-
>>>  .../pmu-events/arch/x86/icelakex/cache.json   |    6 +-
>>>  .../arch/x86/icelakex/icx-metrics.json        |  794 ++++++++++-
>>>  .../arch/x86/icelakex/pipeline.json           |    2 +-
>>>  .../arch/x86/icelakex/uncore-other.json       |    2 +-
>>>  .../arch/x86/ivybridge/ivb-metrics.json       |  525 +++++--
>>>  .../pmu-events/arch/x86/ivytown/cache.json    |    4 +-
>>>  .../arch/x86/ivytown/floating-point.json      |    2 +-
>>>  .../pmu-events/arch/x86/ivytown/frontend.json |   18 +-
>>>  .../arch/x86/ivytown/ivt-metrics.json         |  558 ++++++--
>>>  .../arch/x86/ivytown/uncore-cache.json        |   58 +-
>>>  .../arch/x86/ivytown/uncore-interconnect.json |   84 +-
>>>  .../arch/x86/ivytown/uncore-memory.json       |    2 +-
>>>  .../arch/x86/ivytown/uncore-other.json        |    6 +-
>>>  .../arch/x86/ivytown/uncore-power.json        |    8 +-
>>>  .../arch/x86/jaketown/jkt-metrics.json        |  291 ++--
>>>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   18 +-
>>>  .../arch/x86/sandybridge/snb-metrics.json     |  279 +++-
>>>  .../arch/x86/sapphirerapids/cache.json        |    4 +-
>>>  .../arch/x86/sapphirerapids/frontend.json     |   11 +
>>>  .../arch/x86/sapphirerapids/pipeline.json     |    4 +-
>>>  .../arch/x86/sapphirerapids/spr-metrics.json  |  858 +++++++++++-
>>>  .../arch/x86/skylake/skl-metrics.json         |  774 ++++++++---
>>>  .../arch/x86/skylakex/skx-metrics.json        |  859 +++++++++---
>>>  .../arch/x86/skylakex/uncore-memory.json      |   18 +-
>>>  .../arch/x86/skylakex/uncore-other.json       |   19 +-
>>>  .../arch/x86/tigerlake/tgl-metrics.json       |  727 +++++++++-
>>>  tools/perf/tests/expr.c                       |    4 +
>>>  tools/perf/util/expr.c                        |   11 +-
>>>  tools/perf/util/expr.y                        |    2 +-
>>>  tools/perf/util/stat-shadow.c                 |    9 +-
>>>  56 files changed, 10103 insertions(+), 2129 deletions(-)
>>>
