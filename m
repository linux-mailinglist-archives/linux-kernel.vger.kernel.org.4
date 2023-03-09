Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE46B28DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCIP3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCIP3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:29:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A1B8B330;
        Thu,  9 Mar 2023 07:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678375758; x=1709911758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UwZg0IQKRPgjN7Aw0YALaFZ5q4J2jP64sVuOU2UZIVg=;
  b=Z24lQG+kHkiB0q7OV7hNjq4Y2ZjMOnp62UX+RoDwjnw6JvQ60+n3riHi
   qlykCSiLj7nMDIhDeiI4Nk8D5fqwCwvJ2vWSwLvDJTMz1FB9XnREfhL84
   XGqMZQ+uwqfBZWhRCfzBVesKmaFr1Fa67agnCnORI3ndVD4JKDL16H2hU
   oy0j5aASsataaaohczjDkKW7RAoUWdrkJbCFJFWhoayvdxvZ63rf0Fjzz
   DKHWtNP9rwkqHGgA0SAZxWn0FOzauzzX9By6y7qhKCSjFJ4aKfS4ebYb3
   dAQdwXG8X5Mua4wnMaCshD3azr8xkcbhCo4Nw5kYnORO3TZqgMDvKQdss
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333942929"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="333942929"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 07:29:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="851545489"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="851545489"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 09 Mar 2023 07:29:16 -0800
Received: from [10.209.59.135] (kliang2-mobl1.ccr.corp.intel.com [10.209.59.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 49206580BBE;
        Thu,  9 Mar 2023 07:29:14 -0800 (PST)
Message-ID: <306106d7-b411-eece-aa32-45683a69a289@linux.intel.com>
Date:   Thu, 9 Mar 2023 10:29:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 00/11] Better fixes for grouping of events
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
References: <20230308225912.1960990-1-irogers@google.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230308225912.1960990-1-irogers@google.com>
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



On 2023-03-08 5:59 p.m., Ian Rogers wrote:
> The rules for grouping events have grown more complex. Topdown events
> must be grouped, but flags like --metric-no-group and flags on metrics
> don't respect this. Uncore events may be expanded using wild cards for
> PMU names, but then the events need reordering so the group members
> are adjacent. Rather than fixing metrics, this change fixes the main
> event parsing code to first sort and then regroup evsels.
> 
> As this is shared functionality changes to it should cause
> concern. The change is done with the intent of simplifying and making
> more robust the grouping logic, examples are given. If additional
> changes are necessary, they are most likely necessary to the
> evsel__group_pmu_name logic as the code avoids breaking groups that
> are on the same "group" PMU. The group_pmu_name is a variant of the
> pmu_name tweaked in the case of software and aux events, that use
> groups in a slightly different manner to conventional events.
> 
> The code was manually tested as well as passing perf test on a Intel
> tigerlake CPU with intel-pt.
> 
> v4. Move the Intel pmu->auxtrace initialization to the existing
>     perf_pmu__get_default_config as suggested by Adrian Hunter.
> v3. Rename pmu_name to group_pmu_name and add patch to warn when
>     events are regrouped as requested by Namhyung.
> v2. Fix up the commit message on 4/10 (thanks Arnaldo). Drop
>     unnecessary v1 5/10 (thanks Kan). evlist->core.nr_groups wasn't
>     being correctly maintained after the sort/regrouping and so the
>     new patch 10/10 removes that variable and computes it from the
>     evlist when necessary, generally just tests.
> 
> Ian Rogers (11):
>   libperf evlist: Avoid a use of evsel idx
>   perf stat: Don't remove all grouped events when CPU maps disagree
>   perf pmu: Earlier PMU auxtrace initialization
>   perf stat: Modify the group test
>   perf evsel: Allow const evsel for certain accesses
>   perf evsel: Add function to compute group PMU name
>   perf parse-events: Pass ownership of the group name
>   perf parse-events: Sort and group parsed events
>   perf evsel: Remove use_uncore_alias
>   perf evlist: Remove nr_groups
>   perf parse-events: Warn when events are regrouped
> 

Thanks Ian. The patch series looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>  tools/lib/perf/evlist.c                  |  31 ++-
>  tools/lib/perf/include/internal/evlist.h |   1 -
>  tools/lib/perf/include/perf/evlist.h     |   1 +
>  tools/perf/arch/x86/util/auxtrace.c      |   4 -
>  tools/perf/arch/x86/util/evlist.c        |  39 ++--
>  tools/perf/arch/x86/util/pmu.c           |   8 +-
>  tools/perf/builtin-record.c              |   2 +-
>  tools/perf/builtin-report.c              |   2 +-
>  tools/perf/builtin-stat.c                |  24 +-
>  tools/perf/tests/bpf.c                   |   1 -
>  tools/perf/tests/parse-events.c          |  24 +-
>  tools/perf/tests/pfm.c                   |  12 +-
>  tools/perf/tests/pmu-events.c            |   2 +-
>  tools/perf/util/evlist.c                 |   2 +-
>  tools/perf/util/evlist.h                 |   8 +-
>  tools/perf/util/evsel.c                  |  27 ++-
>  tools/perf/util/evsel.h                  |   8 +-
>  tools/perf/util/header.c                 |   3 +-
>  tools/perf/util/metricgroup.c            |   3 +-
>  tools/perf/util/parse-events.c           | 268 +++++++++++------------
>  tools/perf/util/parse-events.h           |  14 +-
>  tools/perf/util/parse-events.y           |  28 +--
>  tools/perf/util/pfm.c                    |   1 -
>  tools/perf/util/pmu.c                    |   6 +-
>  tools/perf/util/python.c                 |   2 +-
>  tools/perf/util/stat-shadow.c            |   2 +-
>  26 files changed, 277 insertions(+), 246 deletions(-)
> 
