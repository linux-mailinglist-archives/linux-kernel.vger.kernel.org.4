Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628DE702C73
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbjEOMPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241594AbjEOMPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E06173C;
        Mon, 15 May 2023 05:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75E4961F72;
        Mon, 15 May 2023 12:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782B4C433D2;
        Mon, 15 May 2023 12:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684152902;
        bh=xzhZ8AA9jIUuCxAZoti4fbbeWVL4suH07c2HXuZLPbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNJcO5RZZn4HsKLeLiXzv1pJcTlIQDRYH389A8q99WFUldXDYMA5z7lYrbs5I9e3k
         +2r3MxnMy6f3AtU4/uhMm9OwTl1/CYZJvgVtGFZnhWtesU3mEpO697mYxkZeRIJOxa
         2nV3vub7sZJ3lpaGroa5Ok3gQyjLn5ekCkR5uMSE/d2mYVk0OZyYYkBtuveCqC1vcZ
         rQj5rQOZ7wSx7jA0wfkWlkmNgd4BcOTti7dpgwsqTmgnuxGMVXDWYNy+jr2gr9dXQR
         CGOD7Hg2sXaCgYT5zUaYoGQUbpCXSBQm8t3wyYrkdt/k2PaWn8v/Wh10hrwHGAG0o/
         VeOfBIGP8aW5A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0361D403B5; Mon, 15 May 2023 09:14:59 -0300 (-03)
Date:   Mon, 15 May 2023 09:14:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/44] Fix perf on Intel hybrid CPUs
Message-ID: <ZGIiQ/TtqClPVChb@kernel.org>
References: <20230502223851.2234828-1-irogers@google.com>
 <b8f03c40-d238-2ce9-5b50-bd9e1465be23@linux.intel.com>
 <ZF6GkU6Le8bxex2O@kernel.org>
 <b1fb8f09-17d7-45c2-6f8d-0756cd09fe77@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1fb8f09-17d7-45c2-6f8d-0756cd09fe77@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 14, 2023 at 08:03:38AM -0400, Liang, Kan escreveu:
> On 2023-05-12 2:33 p.m., Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 03, 2023 at 04:56:36PM -0400, Liang, Kan escreveu:
> >> On 2023-05-02 6:38 p.m., Ian Rogers wrote:
> >>> TL;DR: hybrid doesn't crash, json metrics work on hybrid on both PMUs
> >>> or individually, event parsing doesn't always scan all PMUs, more and
> >>> new tests that also run without hybrid, less code.
> >>>
> >>> The first 4 patches are aimed at Linux 6.4 to address issues raised,
> >>> in particular by Kan, on the existing perf stat behavior with json
> >>> metrics. They avoid duplicated events by removing groups. They don't
> >>> hide events and metrics to make event multiplexing obvious. They avoid
> >>> terminating perf when paranoia is higher due to certain events that
> >>> always fail. They avoid rearranging events by PMUs when the events
> >>> aren't in a group.
> >>>
> >>> The next 5 patches avoid grouping events for metrics where they could
> >>> never succeed and were previously posted as:
> >>> "perf vendor events intel: Add xxx metric constraints"
> >>> https://lore.kernel.org/all/20230419005423.343862-1-irogers@google.com/
> >>> In general the generated json is coming from:
> >>> https://github.com/intel/perfmon/pull/73
> >>>
> >>> Next are some general and test improvements.
> >>>
> >>> Next event parsing is rewritten to not scan all PMUs for the benefit
> >>> of raw and legacy cache parsing, instead these are handled by the
> >>> lexer and a new term type. This ultimately removes the need for the
> >>> event parser for hybrid to be recursive as legacy cache can be just a
> >>> term. Tests are re-enabled for events with hyphens, so AMD's
> >>> branch-brs event is now parsable.
> >>>
> >>> The cputype option is made a generic pmu filter flag and is tested
> >>> even on non-hybrid systems.
> >>>
> >>> The final patches address specific json metric issues on hybrid, in
> >>> both the json metrics and the metric code.
> >>>
> >>> The patches add slightly more code than they remove, in areas like
> >>> better json metric constraints and tests, but in the core util code,
> >>> the removal of hybrid is a net reduction:
> >>>  22 files changed, 711 insertions(+), 1016 deletions(-)
> >>>
> >>> Sample output is contained in the v1 patch set:
> >>> https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
> >>>
> >>> Tested on Tigerlake, Skylake and Alderlake CPUs.
> >>>
> >>> The v4 patch set:
> >>>  - rebase, 1 of the Linux 6.4 recommended patches are merged leaving:
> >>>    1) perf metric: Change divide by zero and !support events behavior
> >>>    2) perf stat: Introduce skippable evsels
> >>>    3) perf metric: Json flag to not group events if gathering a metric group
> >>>    4) perf parse-events: Don't reorder ungrouped events by pmu
> >>>    whose diffstat is:
> >>>     30 files changed, 326 insertions(+), 33 deletions(-)
> >>>    but without the vendor event updates (the tend to be large as they
> >>>    repeat something per architecture per metric) is just:
> >>>     10 files changed, 90 insertions(+), 32 deletions(-)
> >>
> >> I have tested the 4 patches on top of the perf-tools-next branch on both
> >> Cascade Lake and Raptor Lake. The result looks good to me.
> >>
> >> They address the permission error found in the default mode of perf stat
> >> on the Cascade Lake. Thanks Ian for the fix.
> >>
> >> Arnaldo, could you please consider to back port them for the 6.4?
> > 
> > Yes, its in perf-tools now, will go to Linus next week.
> 
> Thanks Arnaldo!
> 
> > 
> > What about the other patches? I saw some you provided your review, what
> > about the others, are you ok with them?
> > 
> 
> Yes, I'm OK with the patch set. It fixes many issues. Thanks Ian.
> (My tests mainly focus on the area in which the patch set may touch. I
> did the tests on various platforms, ADL (hybrid), Cascade Lake, SPR.)
> 
> Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks!
 
> But there are still some issues. I don't think they are introduced by
> this patch set. We may fix them later separately.

Yeah, look forward to receiving the patches :-)

- Arnaldo
 
> - Segmentation fault with perf stat --topdown on ADL (hybrid) and
> Cascade Lake.
>   It looks like a legacy issue, may not be introduced by this patch set.
>   Here is the backtrace. It looks like there is a NULL metric_group.
> 
> (gdb) backtrace
> #0  0x00007ffff73035d1 in __strstr_sse2_unaligned () from /lib64/libc.so.6
> #1  0x00000000004f9019 in metricgroup__topdown_max_level_callback
> (pm=<optimized out>, table=<optimized out>,
>     data=0x7fffffff92f4) at util/metricgroup.c:1722
> #2  0x00000000005e8a31 in pmu_metrics_table_for_each_metric
> (table=0xcb74d0 <pmu_events_map+368>,
>     fn=fn@entry=0x4f8ff0 <metricgroup__topdown_max_level_callback>,
> data=data@entry=0x7fffffff92f4)
>     at pmu-events/pmu-events.c:61123
> #3  0x00000000004fbc3b in metricgroups__topdown_max_level () at
> util/metricgroup.c:1742
> #4  0x000000000042c135 in add_default_attributes () at builtin-stat.c:1845
> #5  cmd_stat (argc=0, argv=0x7fffffffe3e0) at builtin-stat.c:2446
> #6  0x00000000004b922b in run_builtin (p=p@entry=0xd5c530
> <commands+336>, argc=argc@entry=2,
>     argv=argv@entry=0x7fffffffe3e0) at perf.c:323
> #7  0x000000000040e373 in handle_internal_command (argv=0x7fffffffe3e0,
> argc=2) at perf.c:377
> #8  run_argv (argv=<synthetic pointer>, argcp=<synthetic pointer>) at
> perf.c:421
> #9  main (argc=2, argv=0x7fffffffe3e0) at perf.c:537
> (gdb)
> 
> Also, the return type is unsigned int, but a bool is given.
> 
> unsigned int metricgroups__topdown_max_level(void)
> {
>         unsigned int max_level = 0;
>         const struct pmu_metrics_table *table = pmu_metrics_table__find();
> 
>         if (!table)
>                 return false;
> 
> 
> 
> - The perf metric and metricgroups fail on different platforms.
>   Ian and I have discussed it. We agree to address it later separately.
> 
>   102: perf all metricgroups test
>   ADL (hybrid)
>   103: perf all metrics test
>   ADL (hybrid), Cascade Lake, SPR
> 
> - perf list: The [Kernel PMU event] is missed for all the hardware cache
> events.
>   It impacts both hybrid and non-hybrid platforms.
>   It's a user-visible change introduced by the patch set.
>   I don't know if anyone cares whether it's a kernel event or a regular
> event. It doesn't bother me. So I'm OK with it.
> 
> cpu:
>   L1-dcache-loads OR cpu/L1-dcache-loads/
>   L1-dcache-load-misses OR cpu/L1-dcache-load-misses/
>   L1-dcache-stores OR cpu/L1-dcache-stores/
>   L1-icache-load-misses OR cpu/L1-icache-load-misses/
>   LLC-loads OR cpu/LLC-loads/
>   LLC-load-misses OR cpu/LLC-load-misses/
>   LLC-stores OR cpu/LLC-stores/
>   LLC-store-misses OR cpu/LLC-store-misses/
>   dTLB-loads OR cpu/dTLB-loads/
>   dTLB-load-misses OR cpu/dTLB-load-misses/
>   dTLB-stores OR cpu/dTLB-stores/
>   dTLB-store-misses OR cpu/dTLB-store-misses/
>   iTLB-load-misses OR cpu/iTLB-load-misses/
>   branch-loads OR cpu/branch-loads/
>   branch-load-misses OR cpu/branch-load-misses/
>   node-loads OR cpu/node-loads/
>   node-load-misses OR cpu/node-load-misses/
>   branch-instructions OR cpu/branch-instructions/    [Kernel PMU event]
>   branch-misses OR cpu/branch-misses/                [Kernel PMU event]
>   bus-cycles OR cpu/bus-cycles/                      [Kernel PMU event]
>   cache-misses OR cpu/cache-misses/                  [Kernel PMU event]
>   cache-references OR cpu/cache-references/          [Kernel PMU event]
>   cpu-cycles OR cpu/cpu-cycles/                      [Kernel PMU event]
>   instructions OR cpu/instructions/                  [Kernel PMU event]
> 
> 
> - The --cputype only works for the metric in the default mode.
>   I can still see the cpu_atom events with --cputype core
>   It may be something we can improve later.
> 
> # ./perf stat --cputype core sleep 2
> 
>  Performance counter stats for 'sleep 2':
> 
>               0.52 msec task-clock                       #    0.000 CPUs
> utilized
>                  1      context-switches                 #    1.939 K/sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 69      page-faults                      #  133.770 K/sec
>          2,569,423      cpu_core/cycles/                 #    4.981 G/sec
>      <not counted>      cpu_atom/cycles/
>                        (0.00%)
>          3,287,691      cpu_core/instructions/           #    6.374 G/sec
>      <not counted>      cpu_atom/instructions/
>                        (0.00%)
>            555,848      cpu_core/branches/               #    1.078 G/sec
>      <not counted>      cpu_atom/branches/
>                        (0.00%)
>              8,398      cpu_core/branch-misses/          #   16.281 M/sec
>      <not counted>      cpu_atom/branch-misses/
>                        (0.00%)
>         15,416,538      cpu_core/TOPDOWN.SLOTS/          #     36.1 %
> tma_backend_bound
>                                                   #     23.9 %  tma_retiring
>                                                   #      5.6 %
> tma_bad_speculation
>                                                   #     34.4 %
> tma_frontend_bound
>          3,687,877      cpu_core/topdown-retiring/
>            846,398      cpu_core/topdown-bad-spec/
>          5,320,217      cpu_core/topdown-fe-bound/
>          5,562,045      cpu_core/topdown-be-bound/
>             14,149      cpu_core/INT_MISC.UOP_DROPPING/  #   27.431 M/sec
> 
> 
> Thanks,
> Kan

-- 

- Arnaldo
