Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8B76E865E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjDTAYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDTAYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:24:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F0C30ED
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:24:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f048b144eeso170835e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681950256; x=1684542256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqGcf8Q8AMmC7oOcsPB/iJiWlLsvY6WzwmZ51rksy8A=;
        b=QN1b3fE0Iss/LbTs2l+/Zu4FCmuh0kDTzyOIr4TkUQlNZUsqQP+COAtAW93V84w0ar
         9Vu1PjWaRC83Lhirl16Q5Cr5nDi9hsXP5ib5ZCUhgqi1S6YLrdZlMou7w/q7xzaYelbR
         TFbfkkwPMEX9qmZkakWs2om8w1zksfqObbkUh3754JQydTA74gMouvP/DEhTLYrSZJlb
         GwXiDg245SwKT22c1jT1DU/Dn3lVSIxD5ntHN3Dp7fn4948eLNnGpZSd8DIp00u84qY8
         lGIfFdw4LbqhwMosPIV1IVAqxGBrKfgRMPsF4nY55wKGbeAF5abiAloTNY+wBHn3pOEw
         rgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681950256; x=1684542256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqGcf8Q8AMmC7oOcsPB/iJiWlLsvY6WzwmZ51rksy8A=;
        b=OiQrpcv7C8cX3MzvIJbeP7mZ+UE7UKJdSMnAa0Mb6o9tYjKL6jNaeoEmNarkegexMb
         5MS5gihfCAWEE1/cCMPLWl/9aRpxmqFLv71d6PtM72RsgjNUUUIUywhKa60W3Z2J3s2y
         ptEhPbeT0yPCAiQ2Gps9lQ7e8I9n9I9pdjFtCTjC40/rg7pjNt4psVYTN4b9pnhT5DgY
         INfBA6Ih+lJmrTPWXK1W/KC+myYvj6GmB9VIJwr9KQNchZdY6mp1fr2IUUjvDLyzEd+8
         An16MdmEI10SBZ+PnD3KdDNVunUU/6PNVpTppdlrf9UA73arTU4VJoPq/e52G1MWG+jm
         gLmg==
X-Gm-Message-State: AAQBX9foBYGkBR3KRIdsZI5sCATBRNM6v/6X8JqCakZ/Q5yrxByLXFfR
        PgNIjuiTe8GsXKTDmmExaTT+FqAJ2ntcnwwGnC5f8g==
X-Google-Smtp-Source: AKy350ZwOHHTeD9xIJKaBWxqZN/9O6koNSG9/oXCE0dHxnvPPQs7erM1DB7WB+o8m7vjFFExGnloZKYUeNtSqTI0UZY=
X-Received: by 2002:a05:600c:3c95:b0:3f1:74cf:8563 with SMTP id
 bg21-20020a05600c3c9500b003f174cf8563mr40742wmb.5.1681950255601; Wed, 19 Apr
 2023 17:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230414051922.3625666-1-irogers@google.com> <5031f492-9734-be75-3283-5961771d87c8@linux.intel.com>
 <CAP-5=fW2aAijt8tqydszQHQFmsfeQO2S0hb7Z27RtXxG4Zmm-w@mail.gmail.com>
 <ce92dd1b-23f6-ea52-a47d-fccc24fa20ea@linux.intel.com> <CAP-5=fWRy4NEqhB6-b98+m7SV5=oyBOMVuOHwmvKZCJuXcsQEg@mail.gmail.com>
 <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com> <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com> <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com> <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
 <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com> <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
 <201a2ad6-3fb4-4b2a-d8a4-34d924e680c3@linux.intel.com> <CAP-5=fVWN5=URg0Og7KW7f7L4LSw6D8ghOKjP7La=0c+MkXFCg@mail.gmail.com>
 <2b8768bf-de24-946f-62da-6ed171a5c324@linux.intel.com>
In-Reply-To: <2b8768bf-de24-946f-62da-6ed171a5c324@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Apr 2023 17:23:54 -0700
Message-ID: <CAP-5=fU9WeBga_tQKi6QKX1-t=C1w5CoPc8Rn9myR=1CxeQuMg@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Yasin, Ahmad" <ahmad.yasin@intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>,
        Edward <edward.baker@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 11:57=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
> On 2023-04-19 12:51 p.m., Ian Rogers wrote:
> >>>>> With that change I don't have a case that requires skippable evsels=
,
> >>>>> and so we can take that series with patch 6 over the v1 of that ser=
ies
> >>>>> with this change.
> >>>>>
> >>>>
> >>>> I'm afraid this is not the only problem the commit 94b1a603fca7 ("pe=
rf
> >>>> stat: Add TopdownL1 metric as a default if present") in the
> >>>> perf-tools-next branch introduced.
> >>>>
> >>>> The topdown L2 in the perf stat default on SPR and big core of the A=
DL
> >>>> is still missed. I don't see a possible fix for this on the current
> >>>> perf-tools-next branch.
> >>>
> >>> I thought in its current state the json metrics for TopdownL2 on SPR
> >>> have multiplexing. Given L1 is used to drill down to L2, it seems odd
> >>> to start on L2, but given L1 is used to compute the thresholds for L2=
,
> >>> this should be to have both L1 and L2 on these platforms. However,
> >>> that doesn't work as you don't want multiplexing.
> >>>
> >>> This all seems backward to avoid potential multiplexing on branch mis=
s
> >>> rate and IPC, just always having TopdownL1 seems cleanest with the
> >>> skippable evsels working around the permissions issue - as put forwar=
d
> >>> in this patch. Possibly adding L2 metrics on ADL/SPR, but only once
> >>> the multiplexing issue is resolved.
> >>>
> >>
> >> No, not just that issue. Based to what I tested these days, perf stat
> >> default has issues/regressions on most of the Intel platforms with the
> >> current perf-tools-next and perf/core branch of acme's repo.
> >>
> >> For the pre-ICL platforms:
> >> - The permission issue. (This patch tried to address.)
> >> - Unclean perf stat default. (This patch failed to address.)
> >>   Unnecessary multiplexing for cycles.
> >>   Display partial of the TopdownL1
> >>
> >> https://lore.kernel.org/lkml/d1fe801a-22d0-1f9b-b127-227b21635bd5@linu=
x.intel.com/
> >>
> >> For SPR platforms
> >> - Topdown L2 metrics is missed, while it works with the current 6.3-rc=
7.
> >>
> >> For ADL/RPL platforms
> >> - Segmentation fault which I just found this morning.
> >> # ./perf stat true
> >> Segmentation fault (core dumped)
> >
> > This may also stem from the reference count checking work that Arnaldo
> > is currently merging. It is hard to test hybrid because it uses
> > non-generic code paths.
>
> There are two places which causes the Segmentation fault.
> One place is the TopdownL1.
>
> After I disable the TopdownL1 and add !counter->name as below, there are
> no errors for the ./perf stat true.
>
> (The below is just for test purpose.)
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7a641a67486d..8e12ed1141e0 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1892,7 +1892,7 @@ static int add_default_attributes(void)
>                  * Add TopdownL1 metrics if they exist. To minimize
>                  * multiplexing, don't request threshold computation.
>                  */
> -               if (metricgroup__has_metric("TopdownL1")) {
> +               if (0 && metricgroup__has_metric("TopdownL1")) {

So hybrid has something different that causes this. Can you provide
the information to solve?

>                         struct evlist *metric_evlist =3D evlist__new();
>                         struct evsel *metric_evsel;
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 6b46bbb3d322..072fa56744b4 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -747,7 +747,7 @@ static void uniquify_event_name(struct evsel *counter=
)
>         int ret =3D 0;
>
>         if (counter->uniquified_name || counter->use_config_name ||
> -           !counter->pmu_name || !strncmp(counter->name, counter->pmu_na=
me,
> +           !counter->pmu_name || !counter->name ||
> !strncmp(counter->name, counter->pmu_name,
>                                            strlen(counter->pmu_name)))
>                 return;

Is this a pre-existing hybrid bug? It is a real shame hybrid shows so
few common code paths. In general evsel__name should be preferred over
directly accessing name.

> >
> >> After the test on a hybrid machine, I incline to revert the commit
> >> 94b1a603fca7 ("perf stat: Add TopdownL1 metric as a default if present=
")
> >> and related patches for now.
> >>
> >> To clarify, I do not object a generic solution for the Topdown on
> >> different ARCHs. But the current generic solution aka TopdownL1 has al=
l
> >> kinds of problems on most of Intel platforms. We should fix them first
> >> before applying to the mainline.
> >
> > No, 6.3 has many issues as do the default events/metrics:
>
> To be honest, I don't think they are real critical issues. For the first
> one, I think there was already a temporary fix. For the others, they are
> there for years.

This isn't true. The aggregation bug was raised to me by Intel and
stems from aggregation refactoring in per-thread mode done by
Namhyung.

> However, the solution you proposed in the huge patch set
> (https://lore.kernel.org/lkml/20230219092848.639226-37-irogers@google.com=
/)
> brings many critical issues on different Intel platforms, crashes,
> Missing features, etc.
> Also, I was just told that many of our existing tools which on top of
> the perf tool will also be broken, because all the annotations of the
> kernel top-down metrics event disappeared.
>
> So we really should revert the patches. I don't think patches 39 to 51
> are well-tested and reviewed.

The only issue I'm aware of is that hard coded use of the inaccurate
hard coded metrics now needs to switch to json metrics. This seems a
worthwhile update anyway, and not one that would justify breaking perf
stat metrics.

Thanks,
Ian

> Thanks,
> Kan
>
> >  - in 6.3 aggregation is wrong for metrics, specifically double
> > counting happens as the summary gets applied to the saved value under
> > certain conditions like repeat runs. This is solved in perf-tools-next
> > by removing the duplicated aggregation and using a single set of
> > counters. The "shadow" code is both simpler and more correct than in
> > 6.3, reverting it would be a massive regression - tbh, if it wasn't
> > for the size of the patches I think we should cherry-pick what is in
> > perf-tools-next back to 6.3 due to the size of the errors.
> >  - the default events for IPC and branch miss rate lack groups and so
> > are inaccurate when multiplexing happens - but multiplexing inaccuracy
> > has historically not been an issue for the default events/metrics.
> >  - the previous default topdown metrics were inaccurate compared to
> > the TMA metrics spreadsheet, specifically they lacked events to
> > correct for errors and the thresholds differed. This is why TopdownL2
> > is a challenge because the json metrics do things properly causing the
> > event groups not to be trivially shared.
> >  - the topdown event solution is not generic, it is not only Intel
> > specific but Intel model specific. Solving the problem via the json is
> > the most consistent way to do this and is what I suggest we move to
> > in:
> > https://lore.kernel.org/lkml/20230419005423.343862-6-irogers@google.com=
/
> > but you can keep pushing that perf should do something special for
> > Intel and for every Intel model. It also pushes a need into the metric
> > code to do hybrid specific things so we can ignore atom TopdownL1. In
> > this vein, hybrid is a giant mess that the code base needs cleaning up
> > from; take the recent patch to just disable generic event parsing
> > tests for MTL:
> > https://lore.kernel.org/lkml/20230411094330.653965-1-tinghao.zhang@inte=
l.com/
> > We need to stop doing this, and have generic code, not least because
> > of complaints like:
> > https://www.kernel.org/doc/html/latest/gpu/i915.html#issues-hit-with-fi=
rst-prototype-based-on-core-perf
> > and because of the crash you are reporting on ADL/RPL.
> >
> > What has motivated you here is a concern over multiplexing on branch
> > miss rate and IPC on pre-Icelake architectures that I find hard to
> > understand and is trivially remedied in time honored fashions, ie
> > profile the metrics you care about separately. A far more egregious
> > multiplexing problem is that on Icelake+ architectures we multiplex
> > fixed and generic counters unnecessarily when the same fixed counter
> > is needed or there are insufficient generic counters. This is
> > egregious as there is no user workaround and the kernel fix, to
> > iterate all hardware events the same way we do for all software
> > events, is both obvious and trivial. We've lived with this
> > multiplexing problem since Icelake and I think we can live with a
> > possible multiplexing problem, on legacy architectures, with what is
> > in perf-tools-next. The permissions problem tackled here means we
> > should merge this.
> >
> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Kan
