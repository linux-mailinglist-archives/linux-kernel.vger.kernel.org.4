Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8C770861B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjERQga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjERQg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:36:28 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3160BB3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:36:26 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-338458a9304so147035ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684427785; x=1687019785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j50o5c5k97dKWgZU0D+9q0ltrC+ZoRnLZVwEC5xuR50=;
        b=LYML+aBjdWtIvBO467dvBcXofBaXONYKh+cVKdlV78TNRpE5lRCdVwvF/y3Sw/Zcq0
         6vjhE2IMuTzllCKEJKWBEMY9UBk78f4kqBvDd5plq43Ffcp0VYjUMRYaiOITEJEIfTZG
         e+MX4QTmHRBSmzUifbXzqrFby2VsK8irIOnPDKt0qyY1mjNKQxwOwPLZ9bXZeIl9+ojU
         JYnfgT4wDabbsTRtAFH6+TZpJ0mT3fJZPotdbnqsQIuPZMcK9LNCPkl8EuVKPsrFuOSx
         WmLPzQnZE80MOiTmt3551AlnTVPu38rm3uve5yzGpVZTY30n3BRLhsEjLo5kSNx/unFx
         dDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684427785; x=1687019785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j50o5c5k97dKWgZU0D+9q0ltrC+ZoRnLZVwEC5xuR50=;
        b=VwHO0n138y39baW6TC4Wwn/PmgOWayLXD1RlQ+ZskX1Nx2XD7mKd50nDZCm4LiKMve
         ZX9/W9hIqjfwQzxEMVqSVbPelQGEmYd/ih0tFHP40oT8ucHnU7IYf0TQofF1ICeSsXTy
         rRyvkr2AK2Pyv6KftqAkJziY8b2t/bzrVxonoemV37K5fjJL2Ehd43dup1PqV5lv2c8S
         iNNYigm/vfJLUBhY3Pwjct5B4BNp3KgKPRPEs+G6MUK/ojsCR4buRjkVnxJWKQ+ra730
         pckUol906UB+07keqBeOVaaLA9ESuakM8WEoSUUxMPVVZHO92EaG7VPnJA51AnpgKokx
         z10g==
X-Gm-Message-State: AC+VfDyNWQ8mUOw2tSA/RlFib2C0QYSZXcCxICqcAKHdz2CNbQ1lgt7k
        i3yjrNvwaMBo01P0+7ojujMg/gZObaxzKz7sQ6whjQ==
X-Google-Smtp-Source: ACHHUZ5BhW73SsNMz/nFQQPJS9KAPRDFoFkVLj/V0/RL/lNRPk2Bax6/vBRvCA2UE7So2KA+oX86uxyYrDqc66uXaEI=
X-Received: by 2002:a05:6e02:18c7:b0:338:55b9:f1a3 with SMTP id
 s7-20020a056e0218c700b0033855b9f1a3mr204078ilu.7.1684427785175; Thu, 18 May
 2023 09:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230517225707.2682235-1-irogers@google.com> <a81f6a1a-8897-dc0e-13d2-05a82c318a46@linux.intel.com>
 <CAP-5=fWcvE0xiLOGAhgUuwF0tbLfck+hA-PAj0GFcD_=+D3SyA@mail.gmail.com> <8076a1aa-c09f-38ec-e3f6-f6f3f31920e2@linux.intel.com>
In-Reply-To: <8076a1aa-c09f-38ec-e3f6-f6f3f31920e2@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 18 May 2023 09:36:13 -0700
Message-ID: <CAP-5=fWBo21tjVkeApzGL0ZbMf0ES+N9NrTDxW3XEXGDnDoqSQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf test attr: Update no event/metric expectations
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 7:40=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-05-18 10:10 a.m., Ian Rogers wrote:
> > On Thu, May 18, 2023 at 6:01=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2023-05-17 6:57 p.m., Ian Rogers wrote:
> >>> Previously hard coded events/metrics were used, update for the use of
> >>> the TopdownL1 json metric group.
> >>>
> >>> Fixes: 94b1a603fca7 ("perf stat: Add TopdownL1 metric as a default if=
 present")
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/tests/attr/base-stat            |   2 +-
> >>>  tools/perf/tests/attr/test-stat-default    |  80 ++++++++-----
> >>>  tools/perf/tests/attr/test-stat-detailed-1 |  95 +++++++++------
> >>>  tools/perf/tests/attr/test-stat-detailed-2 | 119 +++++++++++--------
> >>>  tools/perf/tests/attr/test-stat-detailed-3 | 127 ++++++++++++-------=
--
> >>>  5 files changed, 249 insertions(+), 174 deletions(-)
> >>>
> >>> diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/=
base-stat
> >>> index a21fb65bc012..fccd8ec4d1b0 100644
> >>> --- a/tools/perf/tests/attr/base-stat
> >>> +++ b/tools/perf/tests/attr/base-stat
> >>> @@ -16,7 +16,7 @@ pinned=3D0
> >>>  exclusive=3D0
> >>>  exclude_user=3D0
> >>>  exclude_kernel=3D0|1
> >>> -exclude_hv=3D0
> >>> +exclude_hv=3D0|1
> >>>  exclude_idle=3D0
> >>>  mmap=3D0
> >>>  comm=3D0
> >>> diff --git a/tools/perf/tests/attr/test-stat-default b/tools/perf/tes=
ts/attr/test-stat-default
> >>> index d8ea6a88163f..a1e2da0a9a6d 100644
> >>> --- a/tools/perf/tests/attr/test-stat-default
> >>> +++ b/tools/perf/tests/attr/test-stat-default
> >>> @@ -40,7 +40,6 @@ fd=3D6
> >>>  type=3D0
> >>>  config=3D7
> >>>  optional=3D1
> >>> -
> >>>  # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_BACKEND
> >>>  [event7:base-stat]
> >>>  fd=3D7
> >>> @@ -89,79 +88,98 @@ enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>>  [event13:base-stat]
> >>>  fd=3D13
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33024
> >>> +config=3D33280
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>>  [event14:base-stat]
> >>>  fd=3D14
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33280
> >>> +config=3D33536
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>>  [event15:base-stat]
> >>>  fd=3D15
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33536
> >>> +config=3D33024
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> >>> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >>>  [event16:base-stat]
> >>>  fd=3D16
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33792
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D4109
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> >>> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> >>>  [event17:base-stat]
> >>>  fd=3D17
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D34048
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D17039629
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >>>  [event18:base-stat]
> >>>  fd=3D18
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D34304
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D60
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> >>> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >>>  [event19:base-stat]
> >>>  fd=3D19
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D34560
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D2097421
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> >>> +[event20:base-stat]
> >>> +fd=3D20
> >>> +type=3D4
> >>> +config=3D316
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> >>> +[event21:base-stat]
> >>> +fd=3D21
> >>> +type=3D4
> >>> +config=3D412
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> >>> +[event22:base-stat]
> >>> +fd=3D22
> >>> +type=3D4
> >>> +config=3D572
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> >>
> >>
> >> Most of the newly added events are non-architectural events. The event
> >> name and the encoding could be changed later. I don't think it's a goo=
d
> >> idea to hard code them in the test. Could we read the TopdownL1 metric=
s,
> >> get a event list at runtime, and then only test those events?
> >
> > Not really, this test fix is targeting 6.4 which shouldn't be a moving
> > target. We can do something better in 6.5.
> What's the problem the patch trying to fix? Is it user visiable? Does
> the perf test fail?
>
> I want to understand why we need such temporary fix.

So the test has issues, we should fix these perhaps by making the
wrapper a shell test, as these lack the robustness issues. On my
Skylake testing had yielded "Skip" and my Tigerlake testing had
yielded "Ok" but if I altered my directory it changed to "Failed".
Arnaldo discovered the issue in recent testing and asked me to take a
look.

> >
> > Fwiw, on hybrid you get events on 2 PMUs, possibly with the PMU type
> > encoded in the high part of the config. Let's see how hybrid dealt
> > with this test:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/too=
ls/perf/tests/attr.c?h=3Dperf-tools#n188
> > Oh.
> >
>
> If we don't know how to handle the hybrid, we can skip the test cases.
> We can add a specific case later in platform specifc test cases. I don't
> see any problem here.
>
> The temporary fix may not work for all the generations, especially for
> the future generations. It's very likely that we still run 6.4 on a
> future platform with a different formula. Then it may bring problems, no?

No, because we're using json encoded metrics and events which are
built into the perf tool. When we map the cpuid for the future
generation CPU to the json we'll not find anything. This test marks
the events as optional, they aren't present on ARM and AMD, and vary
across Intel models, so the test will still pass as the optional
events weren't programmed and it doesn't matter that the optional
events weren't found. If the upstream json events/metrics change then
it won't affect the json built into the tool and assumed by the test,
so again the test won't break.

Fwiw, were sysfs events being used then this test is more brittle as
the tool and kernel releases aren't obviously aligned. We could get
the test to break by mixing the version of the test with the version
of the perf tool =C2=AF\_(=E3=83=84)_/=C2=AF.

Thanks,
Ian

> Thanks,
> Kan
>
> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Kan
> >>
> >>> +[event23:base-stat]
> >>> +fd=3D23
> >>> +type=3D4
> >>> +config=3D706
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> >>> +[event24:base-stat]
> >>> +fd=3D24
> >>> +type=3D4
> >>> +config=3D270
> >>>  optional=3D1
> >>> diff --git a/tools/perf/tests/attr/test-stat-detailed-1 b/tools/perf/=
tests/attr/test-stat-detailed-1
> >>> index b656ab93c5bf..1c52cb05c900 100644
> >>> --- a/tools/perf/tests/attr/test-stat-detailed-1
> >>> +++ b/tools/perf/tests/attr/test-stat-detailed-1
> >>> @@ -90,89 +90,108 @@ enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>>  [event13:base-stat]
> >>>  fd=3D13
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33024
> >>> +config=3D33280
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>>  [event14:base-stat]
> >>>  fd=3D14
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33280
> >>> +config=3D33536
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>>  [event15:base-stat]
> >>>  fd=3D15
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33536
> >>> +config=3D33024
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> >>> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >>>  [event16:base-stat]
> >>>  fd=3D16
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33792
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D4109
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> >>> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> >>>  [event17:base-stat]
> >>>  fd=3D17
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D34048
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D17039629
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >>>  [event18:base-stat]
> >>>  fd=3D18
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D34304
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D60
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> >>> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >>>  [event19:base-stat]
> >>>  fd=3D19
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D34560
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D2097421
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> >>> +[event20:base-stat]
> >>> +fd=3D20
> >>> +type=3D4
> >>> +config=3D316
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> >>> +[event21:base-stat]
> >>> +fd=3D21
> >>> +type=3D4
> >>> +config=3D412
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> >>> +[event22:base-stat]
> >>> +fd=3D22
> >>> +type=3D4
> >>> +config=3D572
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> >>> +[event23:base-stat]
> >>> +fd=3D23
> >>> +type=3D4
> >>> +config=3D706
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> >>> +[event24:base-stat]
> >>> +fd=3D24
> >>> +type=3D4
> >>> +config=3D270
> >>>  optional=3D1
> >>>
> >>>  # PERF_TYPE_HW_CACHE /
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event20:base-stat]
> >>> -fd=3D20
> >>> +[event25:base-stat]
> >>> +fd=3D25
> >>>  type=3D3
> >>>  config=3D0
> >>>  optional=3D1
> >>> @@ -181,8 +200,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event21:base-stat]
> >>> -fd=3D21
> >>> +[event26:base-stat]
> >>> +fd=3D26
> >>>  type=3D3
> >>>  config=3D65536
> >>>  optional=3D1
> >>> @@ -191,8 +210,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event22:base-stat]
> >>> -fd=3D22
> >>> +[event27:base-stat]
> >>> +fd=3D27
> >>>  type=3D3
> >>>  config=3D2
> >>>  optional=3D1
> >>> @@ -201,8 +220,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event23:base-stat]
> >>> -fd=3D23
> >>> +[event28:base-stat]
> >>> +fd=3D28
> >>>  type=3D3
> >>>  config=3D65538
> >>>  optional=3D1
> >>> diff --git a/tools/perf/tests/attr/test-stat-detailed-2 b/tools/perf/=
tests/attr/test-stat-detailed-2
> >>> index 97625090a1c4..7e961d24a885 100644
> >>> --- a/tools/perf/tests/attr/test-stat-detailed-2
> >>> +++ b/tools/perf/tests/attr/test-stat-detailed-2
> >>> @@ -90,89 +90,108 @@ enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>>  [event13:base-stat]
> >>>  fd=3D13
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33024
> >>> +config=3D33280
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>>  [event14:base-stat]
> >>>  fd=3D14
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33280
> >>> +config=3D33536
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>>  [event15:base-stat]
> >>>  fd=3D15
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33536
> >>> +config=3D33024
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> >>> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >>>  [event16:base-stat]
> >>>  fd=3D16
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33792
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D4109
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> >>> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> >>>  [event17:base-stat]
> >>>  fd=3D17
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D34048
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D17039629
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >>>  [event18:base-stat]
> >>>  fd=3D18
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D34304
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D60
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> >>> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >>>  [event19:base-stat]
> >>>  fd=3D19
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D34560
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D2097421
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> >>> +[event20:base-stat]
> >>> +fd=3D20
> >>> +type=3D4
> >>> +config=3D316
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> >>> +[event21:base-stat]
> >>> +fd=3D21
> >>> +type=3D4
> >>> +config=3D412
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> >>> +[event22:base-stat]
> >>> +fd=3D22
> >>> +type=3D4
> >>> +config=3D572
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> >>> +[event23:base-stat]
> >>> +fd=3D23
> >>> +type=3D4
> >>> +config=3D706
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> >>> +[event24:base-stat]
> >>> +fd=3D24
> >>> +type=3D4
> >>> +config=3D270
> >>>  optional=3D1
> >>>
> >>>  # PERF_TYPE_HW_CACHE /
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event20:base-stat]
> >>> -fd=3D20
> >>> +[event25:base-stat]
> >>> +fd=3D25
> >>>  type=3D3
> >>>  config=3D0
> >>>  optional=3D1
> >>> @@ -181,8 +200,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event21:base-stat]
> >>> -fd=3D21
> >>> +[event26:base-stat]
> >>> +fd=3D26
> >>>  type=3D3
> >>>  config=3D65536
> >>>  optional=3D1
> >>> @@ -191,8 +210,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event22:base-stat]
> >>> -fd=3D22
> >>> +[event27:base-stat]
> >>> +fd=3D27
> >>>  type=3D3
> >>>  config=3D2
> >>>  optional=3D1
> >>> @@ -201,8 +220,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event23:base-stat]
> >>> -fd=3D23
> >>> +[event28:base-stat]
> >>> +fd=3D28
> >>>  type=3D3
> >>>  config=3D65538
> >>>  optional=3D1
> >>> @@ -211,8 +230,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event24:base-stat]
> >>> -fd=3D24
> >>> +[event29:base-stat]
> >>> +fd=3D29
> >>>  type=3D3
> >>>  config=3D1
> >>>  optional=3D1
> >>> @@ -221,8 +240,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event25:base-stat]
> >>> -fd=3D25
> >>> +[event30:base-stat]
> >>> +fd=3D30
> >>>  type=3D3
> >>>  config=3D65537
> >>>  optional=3D1
> >>> @@ -231,8 +250,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event26:base-stat]
> >>> -fd=3D26
> >>> +[event31:base-stat]
> >>> +fd=3D31
> >>>  type=3D3
> >>>  config=3D3
> >>>  optional=3D1
> >>> @@ -241,8 +260,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event27:base-stat]
> >>> -fd=3D27
> >>> +[event32:base-stat]
> >>> +fd=3D32
> >>>  type=3D3
> >>>  config=3D65539
> >>>  optional=3D1
> >>> @@ -251,8 +270,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event28:base-stat]
> >>> -fd=3D28
> >>> +[event33:base-stat]
> >>> +fd=3D33
> >>>  type=3D3
> >>>  config=3D4
> >>>  optional=3D1
> >>> @@ -261,8 +280,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event29:base-stat]
> >>> -fd=3D29
> >>> +[event34:base-stat]
> >>> +fd=3D34
> >>>  type=3D3
> >>>  config=3D65540
> >>>  optional=3D1
> >>> diff --git a/tools/perf/tests/attr/test-stat-detailed-3 b/tools/perf/=
tests/attr/test-stat-detailed-3
> >>> index d555042e3fbf..e50535f45977 100644
> >>> --- a/tools/perf/tests/attr/test-stat-detailed-3
> >>> +++ b/tools/perf/tests/attr/test-stat-detailed-3
> >>> @@ -90,89 +90,108 @@ enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>>  [event13:base-stat]
> >>>  fd=3D13
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33024
> >>> +config=3D33280
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> >>> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>>  [event14:base-stat]
> >>>  fd=3D14
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33280
> >>> +config=3D33536
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> >>> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> >>>  [event15:base-stat]
> >>>  fd=3D15
> >>>  group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33536
> >>> +config=3D33024
> >>>  disabled=3D0
> >>>  enable_on_exec=3D0
> >>>  read_format=3D15
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> >>> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> >>>  [event16:base-stat]
> >>>  fd=3D16
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D33792
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D4109
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> >>> +# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> >>>  [event17:base-stat]
> >>>  fd=3D17
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D34048
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D17039629
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
> >>>  [event18:base-stat]
> >>>  fd=3D18
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D34304
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D60
> >>>  optional=3D1
> >>>
> >>> -# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> >>> +# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
> >>>  [event19:base-stat]
> >>>  fd=3D19
> >>> -group_fd=3D11
> >>>  type=3D4
> >>> -config=3D34560
> >>> -disabled=3D0
> >>> -enable_on_exec=3D0
> >>> -read_format=3D15
> >>> +config=3D2097421
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
> >>> +[event20:base-stat]
> >>> +fd=3D20
> >>> +type=3D4
> >>> +config=3D316
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
> >>> +[event21:base-stat]
> >>> +fd=3D21
> >>> +type=3D4
> >>> +config=3D412
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
> >>> +[event22:base-stat]
> >>> +fd=3D22
> >>> +type=3D4
> >>> +config=3D572
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
> >>> +[event23:base-stat]
> >>> +fd=3D23
> >>> +type=3D4
> >>> +config=3D706
> >>> +optional=3D1
> >>> +
> >>> +# PERF_TYPE_RAW / UOPS_ISSUED.ANY
> >>> +[event24:base-stat]
> >>> +fd=3D24
> >>> +type=3D4
> >>> +config=3D270
> >>>  optional=3D1
> >>>
> >>>  # PERF_TYPE_HW_CACHE /
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event20:base-stat]
> >>> -fd=3D20
> >>> +[event25:base-stat]
> >>> +fd=3D25
> >>>  type=3D3
> >>>  config=3D0
> >>>  optional=3D1
> >>> @@ -181,8 +200,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event21:base-stat]
> >>> -fd=3D21
> >>> +[event26:base-stat]
> >>> +fd=3D26
> >>>  type=3D3
> >>>  config=3D65536
> >>>  optional=3D1
> >>> @@ -191,8 +210,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event22:base-stat]
> >>> -fd=3D22
> >>> +[event27:base-stat]
> >>> +fd=3D27
> >>>  type=3D3
> >>>  config=3D2
> >>>  optional=3D1
> >>> @@ -201,8 +220,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event23:base-stat]
> >>> -fd=3D23
> >>> +[event28:base-stat]
> >>> +fd=3D28
> >>>  type=3D3
> >>>  config=3D65538
> >>>  optional=3D1
> >>> @@ -211,8 +230,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event24:base-stat]
> >>> -fd=3D24
> >>> +[event29:base-stat]
> >>> +fd=3D29
> >>>  type=3D3
> >>>  config=3D1
> >>>  optional=3D1
> >>> @@ -221,8 +240,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event25:base-stat]
> >>> -fd=3D25
> >>> +[event30:base-stat]
> >>> +fd=3D30
> >>>  type=3D3
> >>>  config=3D65537
> >>>  optional=3D1
> >>> @@ -231,8 +250,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event26:base-stat]
> >>> -fd=3D26
> >>> +[event31:base-stat]
> >>> +fd=3D31
> >>>  type=3D3
> >>>  config=3D3
> >>>  optional=3D1
> >>> @@ -241,8 +260,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event27:base-stat]
> >>> -fd=3D27
> >>> +[event32:base-stat]
> >>> +fd=3D32
> >>>  type=3D3
> >>>  config=3D65539
> >>>  optional=3D1
> >>> @@ -251,8 +270,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event28:base-stat]
> >>> -fd=3D28
> >>> +[event33:base-stat]
> >>> +fd=3D33
> >>>  type=3D3
> >>>  config=3D4
> >>>  optional=3D1
> >>> @@ -261,8 +280,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event29:base-stat]
> >>> -fd=3D29
> >>> +[event34:base-stat]
> >>> +fd=3D34
> >>>  type=3D3
> >>>  config=3D65540
> >>>  optional=3D1
> >>> @@ -271,8 +290,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> >>> -[event30:base-stat]
> >>> -fd=3D30
> >>> +[event35:base-stat]
> >>> +fd=3D35
> >>>  type=3D3
> >>>  config=3D512
> >>>  optional=3D1
> >>> @@ -281,8 +300,8 @@ optional=3D1
> >>>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
> >>>  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
> >>>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> >>> -[event31:base-stat]
> >>> -fd=3D31
> >>> +[event36:base-stat]
> >>> +fd=3D36
> >>>  type=3D3
> >>>  config=3D66048
> >>>  optional=3D1
