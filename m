Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4532D6E7FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjDSQvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjDSQvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:51:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C6246A4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:51:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso145015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681923096; x=1684515096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJSZP86FK0Nt7tFJOItNPrVbf3EVlMWmurDSVxNHOYw=;
        b=6IL0o+lwkMj1w9jGPdx7VhCT4pCYJ8HEVFdZv7PQNJJnNFMHgS28rB8+nV0rup4NG1
         TMHWWaxS++zaRRFlYMHdqQc4jN/NQtMx4j4HvOPw8UDGkwFh4mNPlxaceSoMhTWBsv0n
         GSZqWuIi5BpX6mfPkEGWEyCiZnrem/xH0UtPuPvwxLtlp/aoXBJvndzPQZQw40/2PAsw
         TH5KkPhD+UKP9cAyNO6IXM6lV6Y/1UR684dNKdY2G6FKzTt7PRFclKiIQ5/EVv2fTOVJ
         LTS6vritTzhn94MXZV6uuZRigxzGBB2QUIZbtQpLpmz+XH6gmE1jQYjVqa8M8eYayT+R
         5QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681923096; x=1684515096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJSZP86FK0Nt7tFJOItNPrVbf3EVlMWmurDSVxNHOYw=;
        b=BLUwTsorGh85e1OtStq62UdKeyDaBCXFnHb0tCpCdkFvaJ9BtIBzjnpMj2HnvqKYX4
         IPPdhyoFiI6sKQcscKKKg1VvvzDIXiqxudSqOh/r1+WBtazOnw8UKlzw2BkAlhYPOTUX
         6VHlWZoSO9iAj/ViiTSwOUTOFU4+P9A4yWGYP705BOmTT6L0DPXeswmKGK+2EuVbTTsS
         Y0ujkyILz+KPpFbciD31KmerxlzSUWhuYZBjRVfFV+BLsdZ8jp8eWh1k9yUiicX/AlG5
         +V92Ff5x/VltRq6pwDKt4z9KiO3da1HXxMvr8n2iQzbYW3GytshGhw7EUJpmD73+enNd
         Y2Cg==
X-Gm-Message-State: AAQBX9eWhIzxRHPsiVb79xW2CFOIze/eSnNnZPAhG5u2xpjzv+YtOgAC
        R3VX/hf/ocCmFthkcTl0ra0Uk8VoxcFRDtCck+qlLw==
X-Google-Smtp-Source: AKy350brRgS8lK/njJdeySlW+94WayyxM1Y5Sam3yhskJlRp4Ec6iUfmJIU4AGooP2a4s+zDu0Obp3ofSmtaPEw+7CI=
X-Received: by 2002:a05:600c:1e18:b0:3f1:6fe9:4a95 with SMTP id
 ay24-20020a05600c1e1800b003f16fe94a95mr245784wmb.4.1681923095892; Wed, 19 Apr
 2023 09:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230414051922.3625666-1-irogers@google.com> <56ac61a0-ccf0-210e-e429-11062a07b8bf@linux.intel.com>
 <CAP-5=fXz1vw48A2tWgcNDSZsnvnOO7_jA+py3p_Khi_igz0hJw@mail.gmail.com>
 <5031f492-9734-be75-3283-5961771d87c8@linux.intel.com> <CAP-5=fW2aAijt8tqydszQHQFmsfeQO2S0hb7Z27RtXxG4Zmm-w@mail.gmail.com>
 <ce92dd1b-23f6-ea52-a47d-fccc24fa20ea@linux.intel.com> <CAP-5=fWRy4NEqhB6-b98+m7SV5=oyBOMVuOHwmvKZCJuXcsQEg@mail.gmail.com>
 <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com> <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com> <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com> <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
 <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com> <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
 <201a2ad6-3fb4-4b2a-d8a4-34d924e680c3@linux.intel.com>
In-Reply-To: <201a2ad6-3fb4-4b2a-d8a4-34d924e680c3@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Apr 2023 09:51:20 -0700
Message-ID: <CAP-5=fVWN5=URg0Og7KW7f7L4LSw6D8ghOKjP7La=0c+MkXFCg@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Yasin, Ahmad" <ahmad.yasin@intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>,
        Edward <edward.baker@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
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

On Wed, Apr 19, 2023 at 7:16=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-04-19 9:19 a.m., Ian Rogers wrote:
> > On Wed, Apr 19, 2023 at 5:31=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2023-04-18 9:00 p.m., Ian Rogers wrote:
> >>> On Tue, Apr 18, 2023 at 5:12=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> >>>>
> >>>> On Tue, Apr 18, 2023 at 2:51=E2=80=AFPM Liang, Kan <kan.liang@linux.=
intel.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2023-04-18 4:08 p.m., Ian Rogers wrote:
> >>>>>> On Tue, Apr 18, 2023 at 11:19=E2=80=AFAM Liang, Kan <kan.liang@lin=
ux.intel.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 2023-04-18 11:43 a.m., Ian Rogers wrote:
> >>>>>>>> On Tue, Apr 18, 2023 at 6:03=E2=80=AFAM Liang, Kan <kan.liang@li=
nux.intel.com> wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On 2023-04-17 2:13 p.m., Ian Rogers wrote:
> >>>>>>>>>> The json TopdownL1 is enabled if present unconditionally for p=
erf stat
> >>>>>>>>>> default. Enabling it on Skylake has multiplexing as TopdownL1 =
on
> >>>>>>>>>> Skylake has multiplexing unrelated to this change - at least o=
n the
> >>>>>>>>>> machine I was testing on. We can remove the metric group Topdo=
wnL1 on
> >>>>>>>>>> Skylake so that we don't enable it by default, there is still =
the
> >>>>>>>>>> group TmaL1. To me, disabling TopdownL1 seems less desirable t=
han
> >>>>>>>>>> running with multiplexing - previously to get into topdown ana=
lysis
> >>>>>>>>>> there has to be knowledge that "perf stat -M TopdownL1" is the=
 way to
> >>>>>>>>>> do this.
> >>>>>>>>>
> >>>>>>>>> To be honest, I don't think it's a good idea to remove the Topd=
ownL1. We
> >>>>>>>>> cannot remove it just because the new way cannot handle it. The=
 perf
> >>>>>>>>> stat default works well until 6.3-rc7. It's a regression issue =
of the
> >>>>>>>>> current perf-tools-next.
> >>>>>>>>
> >>>>>>>> I'm not so clear it is a regression to consistently add TopdownL=
1 for
> >>>>>>>> all architectures supporting it.
> >>>>>>>
> >>>>>>>
> >>>>>>> Breaking the perf stat default is a regression.
> >>>>>>
> >>>>>> Breaking is overstating the use of multiplexing. The impact is les=
s
> >>>>>> accuracy in the IPC and branch misses default metrics,
> >>>>>
> >>>>> Inaccuracy is a breakage for the default.
> >>>>
> >>>> Can you present a case where this matters? The events are already no=
t
> >>>> grouped and so inaccurate for metrics.
> >>>
> >>> Removing CPUs without perf metrics from the TopdownL1 metric group is
> >>> implemented here:
> >>> https://lore.kernel.org/lkml/20230419005423.343862-6-irogers@google.c=
om/
> >>> Note, this applies to pre-Icelake and atom CPUs as these also lack
> >>> perf metric (aka topdown) events.
> >>>
> >>
> >> That may give the end user the impression that the pre-Icelake doesn't
> >> support the Topdown Level1 events, which is not true.
> >>
> >> I think perf should either keep it for all Intel platforms which
> >> supports tma_L1_group, or remove the TopdownL1 name entirely for Intel
> >> platform (let the end user use the tma_L1_group and the name exposed b=
y
> >> the kernel as before.).
> >
> > How does this work on hybrid systems? We will enable TopdownL1 because
> > of the presence of perf metric (aka topdown) events but this will also
> > enable TopdownL1 on the atom core.
>
>
> This is the output from a hybrid system with current 6.3-rc7.
>
> As you can see that the Topdown L1 and L2 are displayed for the big
> core. No Topdown events are displayed for the atom core.
>
> (BTW: The 99.15% is not multiplexing. I think it's because the perf stat
> may starts from the big core and it takes a little bit time to run
> something on the small core.)
>
>
> $perf stat ./hybrid_triad_loop.sh
>
>  Performance counter stats for './hybrid_triad_loop.sh':
>
>             211.80 msec task-clock                       #    0.996 CPUs
> utilized
>                  5      context-switches                 #   23.608 /sec
>                  3      cpu-migrations                   #   14.165 /sec
>                652      page-faults                      #    3.078 K/sec
>        411,470,713      cpu_core/cycles/                 #    1.943 G/sec
>        607,566,483      cpu_atom/cycles/                 #    2.869
> G/sec                       (99.15%)
>      1,613,379,362      cpu_core/instructions/           #    7.618 G/sec
>      1,616,816,312      cpu_atom/instructions/           #    7.634
> G/sec                       (99.15%)
>        202,876,952      cpu_core/branches/               #  957.884 M/sec
>        202,367,829      cpu_atom/branches/               #  955.480
> M/sec                       (99.15%)
>             56,740      cpu_core/branch-misses/          #  267.898 K/sec
>             19,033      cpu_atom/branch-misses/          #   89.864
> K/sec                       (99.15%)
>      2,468,765,562      cpu_core/slots/                  #   11.656 G/sec
>      1,411,184,398      cpu_core/topdown-retiring/       #     57.4%
> Retiring
>          4,671,159      cpu_core/topdown-bad-spec/       #      0.2% Bad
> Speculation
>         92,222,378      cpu_core/topdown-fe-bound/       #      3.7%
> Frontend Bound
>        952,516,107      cpu_core/topdown-be-bound/       #     38.7%
> Backend Bound
>          2,696,347      cpu_core/topdown-heavy-ops/      #      0.1%
> Heavy Operations          #     57.2% Light Operations
>          4,460,659      cpu_core/topdown-br-mispredict/  #      0.2%
> Branch Mispredict         #      0.0% Machine Clears
>         19,538,486      cpu_core/topdown-fetch-lat/      #      0.8%
> Fetch Latency             #      3.0% Fetch Bandwidth
>         24,170,592      cpu_core/topdown-mem-bound/      #      1.0%
> Memory Bound              #     37.7% Core Bound
>
>        0.212598999 seconds time elapsed
>
>        0.212525000 seconds user
>        0.000000000 seconds sys
>
>
> >
> >>
> >>> With that change I don't have a case that requires skippable evsels,
> >>> and so we can take that series with patch 6 over the v1 of that serie=
s
> >>> with this change.
> >>>
> >>
> >> I'm afraid this is not the only problem the commit 94b1a603fca7 ("perf
> >> stat: Add TopdownL1 metric as a default if present") in the
> >> perf-tools-next branch introduced.
> >>
> >> The topdown L2 in the perf stat default on SPR and big core of the ADL
> >> is still missed. I don't see a possible fix for this on the current
> >> perf-tools-next branch.
> >
> > I thought in its current state the json metrics for TopdownL2 on SPR
> > have multiplexing. Given L1 is used to drill down to L2, it seems odd
> > to start on L2, but given L1 is used to compute the thresholds for L2,
> > this should be to have both L1 and L2 on these platforms. However,
> > that doesn't work as you don't want multiplexing.
> >
> > This all seems backward to avoid potential multiplexing on branch miss
> > rate and IPC, just always having TopdownL1 seems cleanest with the
> > skippable evsels working around the permissions issue - as put forward
> > in this patch. Possibly adding L2 metrics on ADL/SPR, but only once
> > the multiplexing issue is resolved.
> >
>
> No, not just that issue. Based to what I tested these days, perf stat
> default has issues/regressions on most of the Intel platforms with the
> current perf-tools-next and perf/core branch of acme's repo.
>
> For the pre-ICL platforms:
> - The permission issue. (This patch tried to address.)
> - Unclean perf stat default. (This patch failed to address.)
>   Unnecessary multiplexing for cycles.
>   Display partial of the TopdownL1
>
> https://lore.kernel.org/lkml/d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.i=
ntel.com/
>
> For SPR platforms
> - Topdown L2 metrics is missed, while it works with the current 6.3-rc7.
>
> For ADL/RPL platforms
> - Segmentation fault which I just found this morning.
> # ./perf stat true
> Segmentation fault (core dumped)

This may also stem from the reference count checking work that Arnaldo
is currently merging. It is hard to test hybrid because it uses
non-generic code paths.

> After the test on a hybrid machine, I incline to revert the commit
> 94b1a603fca7 ("perf stat: Add TopdownL1 metric as a default if present")
> and related patches for now.
>
> To clarify, I do not object a generic solution for the Topdown on
> different ARCHs. But the current generic solution aka TopdownL1 has all
> kinds of problems on most of Intel platforms. We should fix them first
> before applying to the mainline.

No, 6.3 has many issues as do the default events/metrics:
 - in 6.3 aggregation is wrong for metrics, specifically double
counting happens as the summary gets applied to the saved value under
certain conditions like repeat runs. This is solved in perf-tools-next
by removing the duplicated aggregation and using a single set of
counters. The "shadow" code is both simpler and more correct than in
6.3, reverting it would be a massive regression - tbh, if it wasn't
for the size of the patches I think we should cherry-pick what is in
perf-tools-next back to 6.3 due to the size of the errors.
 - the default events for IPC and branch miss rate lack groups and so
are inaccurate when multiplexing happens - but multiplexing inaccuracy
has historically not been an issue for the default events/metrics.
 - the previous default topdown metrics were inaccurate compared to
the TMA metrics spreadsheet, specifically they lacked events to
correct for errors and the thresholds differed. This is why TopdownL2
is a challenge because the json metrics do things properly causing the
event groups not to be trivially shared.
 - the topdown event solution is not generic, it is not only Intel
specific but Intel model specific. Solving the problem via the json is
the most consistent way to do this and is what I suggest we move to
in:
https://lore.kernel.org/lkml/20230419005423.343862-6-irogers@google.com/
but you can keep pushing that perf should do something special for
Intel and for every Intel model. It also pushes a need into the metric
code to do hybrid specific things so we can ignore atom TopdownL1. In
this vein, hybrid is a giant mess that the code base needs cleaning up
from; take the recent patch to just disable generic event parsing
tests for MTL:
https://lore.kernel.org/lkml/20230411094330.653965-1-tinghao.zhang@intel.co=
m/
We need to stop doing this, and have generic code, not least because
of complaints like:
https://www.kernel.org/doc/html/latest/gpu/i915.html#issues-hit-with-first-=
prototype-based-on-core-perf
and because of the crash you are reporting on ADL/RPL.

What has motivated you here is a concern over multiplexing on branch
miss rate and IPC on pre-Icelake architectures that I find hard to
understand and is trivially remedied in time honored fashions, ie
profile the metrics you care about separately. A far more egregious
multiplexing problem is that on Icelake+ architectures we multiplex
fixed and generic counters unnecessarily when the same fixed counter
is needed or there are insufficient generic counters. This is
egregious as there is no user workaround and the kernel fix, to
iterate all hardware events the same way we do for all software
events, is both obvious and trivial. We've lived with this
multiplexing problem since Icelake and I think we can live with a
possible multiplexing problem, on legacy architectures, with what is
in perf-tools-next. The permissions problem tackled here means we
should merge this.

Thanks,
Ian

> Thanks,
> Kan
