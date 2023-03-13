Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50F6B8077
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCMS1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCMS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:27:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B1017CD2;
        Mon, 13 Mar 2023 11:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 599C6B811D9;
        Mon, 13 Mar 2023 18:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00C0C433D2;
        Mon, 13 Mar 2023 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678731943;
        bh=qyGf7+ezeWajxKxCIptIxhJuwG8WYUdjZZdsJ3FxiQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIfXpgHR1dPoDS180z3kzOfqife7YqQdEPNKb0jLOt5mjzTECkg48jmMvhMlIK4Fy
         8NCESgAk2sZzHCPtAuLb2bt1sDB85hD8gkxKVMebPKMFxWOUSEPAmkv7oYIUCyv01E
         8KUCabveyg/gqCtlZSiSJnRIFQqH+y446uo2fPeuR3M9QIDU+BcV6K8Q24s8RXL5p0
         rTupcAqsLxFr9YBfBpAiKBH37cxd6YwaysbWWjFhTw0OF4akaVuBdqD7OHR/e68i6K
         bOw6Fz9JVa+s1ZoUeEBWben0T51+LVFVPDsgvHewuVj5Z69K9CFTRyIsH5wsl0540B
         nwfr5mnVDoipA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4E5FD4049F; Mon, 13 Mar 2023 15:25:40 -0300 (-03)
Date:   Mon, 13 Mar 2023 15:25:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v5 00/11] Better fixes for  grouping of events
Message-ID: <ZA9qpIuUPecYPiFk@kernel.org>
References: <20230312021543.3060328-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312021543.3060328-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 11, 2023 at 06:15:32PM -0800, Ian Rogers escreveu:
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
> v5. Add Adrian's Acked-by on patch 3, add a fix to the warning logic
>     for multiple event groups as reported by Adrian.


Appled locally, testing.

- Arnaldo

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
>  tools/perf/util/parse-events.c           | 275 ++++++++++++-----------
>  tools/perf/util/parse-events.h           |  14 +-
>  tools/perf/util/parse-events.y           |  28 +--
>  tools/perf/util/pfm.c                    |   1 -
>  tools/perf/util/pmu.c                    |   6 +-
>  tools/perf/util/python.c                 |   2 +-
>  tools/perf/util/stat-shadow.c            |   2 +-
>  26 files changed, 284 insertions(+), 246 deletions(-)
> 
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 

-- 

- Arnaldo
