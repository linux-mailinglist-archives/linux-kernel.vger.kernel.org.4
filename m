Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C604704120
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbjEOWuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245676AbjEOWuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:50:00 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03975DC71
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:49:58 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f38824a025so1616941cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684190997; x=1686782997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZTjiVuHFBirYHtxN1fAOg4WJAZDMLdPxECi8NRB08Q=;
        b=Outk4cMYMHv3vtEwIMZexxy0ppM3vG2PD1EqLwFtt09FbiV4ZI3UQG5m/5T0oT5o2q
         y/Fr3sGN6gbjYz3rUYSj80ZucRDr5YhXDUvYLJyZSljl6b2mHIG6EzJABOiSnv+Z3Scd
         7gY0Ndi98X1maAPd5aGqVjwj/1831FXMBvGkR2RgCYCVJpB+feX7IoLV7fUmlchI8Bnh
         vuzuGJnVVUTUkV1B9UdNgMjxxowykdX3n44WJ99uWpcJBfZUSrWFtqULn7RBGxn/Zu8r
         YCeXRNK05C6WhzfvCNY1VOVctMtoBlZYcdsGw37vPGZ5D8jA7zbL9v3ntRRYdnjnAgDh
         9twQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684190997; x=1686782997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZTjiVuHFBirYHtxN1fAOg4WJAZDMLdPxECi8NRB08Q=;
        b=KDGaRNmWN4Z4TWOpQoex77pFU+XEXSYY97xGua2nubQHoQsHwVMlsxH74bsvWMbKM9
         nBdxyUST2/bYWi16br/2BqJxT7ydfRnLfHlYMLQlrgXKX1KVRpa0xy3Scqt6LbnWOnJv
         v5sAvoWR4Fej0rZStD36WJwgX+Qd75tAKqqNJMq/wTwylN8sBXDjECQ7xm4avaS8SxoZ
         mS2ttVsk5bjaAd1HB9irYDwKAuFN9Pou5epr17KIEvgppZyS0EBM0CrAH77ylT6rlA0T
         Kua59qhZ8UdxNx1C2GVSqwJSiVbY35FUQ62OvImYVBm6OfnOkCAI8Qct2RLAOeGBicps
         xF+Q==
X-Gm-Message-State: AC+VfDy/X7J6sWrDHOKfL0Ms9WSRvT23qJyq7mWi1t/0CyECQHYau5Jp
        OFdHSG7Rw/b7qgwYOLIKVcbpDYjLR6ywPLq/WHHK8A==
X-Google-Smtp-Source: ACHHUZ5fiXDFyEGKIZokJk+SQ58w2mPLHArX08+dHQ+hInnXnFu9iPlhNSRYjy3/HEbTLYnAiPY/OqM4NUkWA/MHnWw=
X-Received: by 2002:ac8:7dcb:0:b0:3f5:2006:50f1 with SMTP id
 c11-20020ac87dcb000000b003f5200650f1mr76767qte.12.1684190996650; Mon, 15 May
 2023 15:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com> <b8f03c40-d238-2ce9-5b50-bd9e1465be23@linux.intel.com>
 <ZF6GkU6Le8bxex2O@kernel.org> <b1fb8f09-17d7-45c2-6f8d-0756cd09fe77@linux.intel.com>
In-Reply-To: <b1fb8f09-17d7-45c2-6f8d-0756cd09fe77@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 15 May 2023 15:49:45 -0700
Message-ID: <CAP-5=fUc7mcEurwCBxZ_Dx=1pARynyra5Psi3J_OVk9JCXYMcA@mail.gmail.com>
Subject: Re: [PATCH v4 00/44] Fix perf on Intel hybrid CPUs
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 5:03=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-05-12 2:33 p.m., Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 03, 2023 at 04:56:36PM -0400, Liang, Kan escreveu:
> >>
> >>
> >> On 2023-05-02 6:38 p.m., Ian Rogers wrote:
> >>> TL;DR: hybrid doesn't crash, json metrics work on hybrid on both PMUs
> >>> or individually, event parsing doesn't always scan all PMUs, more and
> >>> new tests that also run without hybrid, less code.
> >>>
> >>> The first 4 patches are aimed at Linux 6.4 to address issues raised,
> >>> in particular by Kan, on the existing perf stat behavior with json
> >>> metrics. They avoid duplicated events by removing groups. They don't
> >>> hide events and metrics to make event multiplexing obvious. They avoi=
d
> >>> terminating perf when paranoia is higher due to certain events that
> >>> always fail. They avoid rearranging events by PMUs when the events
> >>> aren't in a group.
> >>>
> >>> The next 5 patches avoid grouping events for metrics where they could
> >>> never succeed and were previously posted as:
> >>> "perf vendor events intel: Add xxx metric constraints"
> >>> https://lore.kernel.org/all/20230419005423.343862-1-irogers@google.co=
m/
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
> >>> https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@lin=
ux.intel.com/
> >>>
> >>> Tested on Tigerlake, Skylake and Alderlake CPUs.
> >>>
> >>> The v4 patch set:
> >>>  - rebase, 1 of the Linux 6.4 recommended patches are merged leaving:
> >>>    1) perf metric: Change divide by zero and !support events behavior
> >>>    2) perf stat: Introduce skippable evsels
> >>>    3) perf metric: Json flag to not group events if gathering a metri=
c group
> >>>    4) perf parse-events: Don't reorder ungrouped events by pmu
> >>>    whose diffstat is:
> >>>     30 files changed, 326 insertions(+), 33 deletions(-)
> >>>    but without the vendor event updates (the tend to be large as they
> >>>    repeat something per architecture per metric) is just:
> >>>     10 files changed, 90 insertions(+), 32 deletions(-)
> >>
> >> I have tested the 4 patches on top of the perf-tools-next branch on bo=
th
> >> Cascade Lake and Raptor Lake. The result looks good to me.
> >>
> >> They address the permission error found in the default mode of perf st=
at
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
>
> But there are still some issues. I don't think they are introduced by
> this patch set. We may fix them later separately.
>
> - Segmentation fault with perf stat --topdown on ADL (hybrid) and
> Cascade Lake.
>   It looks like a legacy issue, may not be introduced by this patch set.
>   Here is the backtrace. It looks like there is a NULL metric_group.
>
> (gdb) backtrace
> #0  0x00007ffff73035d1 in __strstr_sse2_unaligned () from /lib64/libc.so.=
6
> #1  0x00000000004f9019 in metricgroup__topdown_max_level_callback
> (pm=3D<optimized out>, table=3D<optimized out>,
>     data=3D0x7fffffff92f4) at util/metricgroup.c:1722
> #2  0x00000000005e8a31 in pmu_metrics_table_for_each_metric
> (table=3D0xcb74d0 <pmu_events_map+368>,
>     fn=3Dfn@entry=3D0x4f8ff0 <metricgroup__topdown_max_level_callback>,
> data=3Ddata@entry=3D0x7fffffff92f4)
>     at pmu-events/pmu-events.c:61123
> #3  0x00000000004fbc3b in metricgroups__topdown_max_level () at
> util/metricgroup.c:1742
> #4  0x000000000042c135 in add_default_attributes () at builtin-stat.c:184=
5
> #5  cmd_stat (argc=3D0, argv=3D0x7fffffffe3e0) at builtin-stat.c:2446
> #6  0x00000000004b922b in run_builtin (p=3Dp@entry=3D0xd5c530
> <commands+336>, argc=3Dargc@entry=3D2,
>     argv=3Dargv@entry=3D0x7fffffffe3e0) at perf.c:323
> #7  0x000000000040e373 in handle_internal_command (argv=3D0x7fffffffe3e0,
> argc=3D2) at perf.c:377
> #8  run_argv (argv=3D<synthetic pointer>, argcp=3D<synthetic pointer>) at
> perf.c:421
> #9  main (argc=3D2, argv=3D0x7fffffffe3e0) at perf.c:537
> (gdb)

Thanks, there's a 1-liner for the segv:
https://lore.kernel.org/lkml/20230515224530.671331-1-irogers@google.com/
Arnaldo, can we make sure this goes toward the next 6.4 release candidate?

Thanks,
Ian

> Also, the return type is unsigned int, but a bool is given.
>
> unsigned int metricgroups__topdown_max_level(void)
> {
>         unsigned int max_level =3D 0;
>         const struct pmu_metrics_table *table =3D pmu_metrics_table__find=
();
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
>                                                   #     23.9 %  tma_retir=
ing
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
