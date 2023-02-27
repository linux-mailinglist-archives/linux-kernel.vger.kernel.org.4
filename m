Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D4A6A4AED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjB0Tdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjB0Tdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:33:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB971CF7C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:33:33 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so7977733wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3ZlYrpnvriuEQlF8acpCfz9AsquLRyarIwKRteJEOc=;
        b=PhdPrbw2NpLyUL3zt0V036IziurH/5vDJKbohghqcsViBw8SN8leNq+AwZbf06W6zG
         ERyTQNPRfGPL+taOvgUsswSY4rToiNChsDUcDbTl8Nx+eYQZrImKkFAqLgUZYbOjsNW+
         35+V5ubLZZVUAQOHLZNAHLwJSn1KMRuZ1LGhU6GuMWntGTc7aWVHKYoQRAs0mQ50cddt
         QkALjJvA1aH4IMgqDkGyQX6K+ApZ/iOYqkFsuvBf9gT/ZRd5vYhARI7PqN6mF+sUIx+4
         8nzXKx6x7VRF7BQrX0dpa8Fty3iofOZLd1ksVjA/G/ERnscDWBfQr8xZpk9BaXfL+SRr
         IVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3ZlYrpnvriuEQlF8acpCfz9AsquLRyarIwKRteJEOc=;
        b=kfvatniQo/LRgKu5m0m7uyz+sa5sxkUPlh6NdZaUW3iiUOB94hm5HCFN8JWzHrLdBR
         LL+NElkr/vJt7NoB8GqpOymiKcf6RPcuRGrV+4wsaEl0VtqoBZsW0t/yuoyGv9bm78LL
         ySPGNM5j1Zi0y72IJShO4WigZQbeZ/2cDegfCJSjBGxi47TBKFphqXWBNGME2wOmcyPe
         hQEob+ePCPkgejX4+Eyi/KEvJMwlRs6OtTeZxfC/16yb54aTO7JPISmoZ0oTUrqzWqEH
         SEwOqd7yphPPhnLxGW/c8PRcisIw8Il6VliuW3tciE3tSNsvJF21/jFHyyKFxlcjIQXC
         to1Q==
X-Gm-Message-State: AO0yUKW3XGBeGdtkyBQXESDGy4/QWF4o87nua6g6SGwrZSCr4MPqPkms
        ihWQQHWplSWFcPbqdk201/mhVPIBcSINS2ZULtbI3Q==
X-Google-Smtp-Source: AK7set82nzzRHHFQh9oO7TYTtR6k9Kj8o5QqXM5ef/eRWVNSy8UtCJrayFW9HBOXGo2DTWoNYAODg8LDWAsVUpMc4sk=
X-Received: by 2002:a05:600c:4fc3:b0:3df:97ed:ddeb with SMTP id
 o3-20020a05600c4fc300b003df97edddebmr75801wmq.8.1677526411353; Mon, 27 Feb
 2023 11:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com> <20230219092848.639226-40-irogers@google.com>
 <09f0e75a-a11d-7db1-6308-f1b00462908c@linux.intel.com>
In-Reply-To: <09f0e75a-a11d-7db1-6308-f1b00462908c@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Feb 2023 11:33:18 -0800
Message-ID: <CAP-5=fW8cM0cWaCs8Vu9Nom1i2TF024-yyHtdUQx8QE3HFTq0w@mail.gmail.com>
Subject: Re: [PATCH v1 39/51] perf stat: Add TopdownL1 metric as a default if present
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:12=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-02-19 4:28 a.m., Ian Rogers wrote:
> > When there are no events and on Intel, the topdown events will be
> > added by default if present. To display the metrics associated with
> > these request special handling in stat-shadow.c. To more easily update
> > these metrics use the json metric version via the TopdownL1
> > group. This makes the handling less platform specific.
> >
> > Modify the metricgroup__has_metric code to also cover metric groups.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/util/evlist.c  |  6 +++---
> >  tools/perf/arch/x86/util/topdown.c | 30 ------------------------------
> >  tools/perf/arch/x86/util/topdown.h |  1 -
> >  tools/perf/builtin-stat.c          | 14 ++++++++++++++
> >  tools/perf/util/metricgroup.c      |  6 ++----
> >  5 files changed, 19 insertions(+), 38 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/ut=
il/evlist.c
> > index cb59ce9b9638..8a7ae4162563 100644
> > --- a/tools/perf/arch/x86/util/evlist.c
> > +++ b/tools/perf/arch/x86/util/evlist.c
> > @@ -59,10 +59,10 @@ int arch_evlist__add_default_attrs(struct evlist *e=
vlist,
> >                                  struct perf_event_attr *attrs,
> >                                  size_t nr_attrs)
> >  {
> > -     if (nr_attrs)
> > -             return ___evlist__add_default_attrs(evlist, attrs, nr_att=
rs);
> > +     if (!nr_attrs)
> > +             return 0;
> >
> > -     return topdown_parse_events(evlist);
> > +     return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
> >  }
> >
> >  struct evsel *arch_evlist__leader(struct list_head *list)
> > diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/u=
til/topdown.c
> > index 54810f9acd6f..eb3a7d9652ab 100644
> > --- a/tools/perf/arch/x86/util/topdown.c
> > +++ b/tools/perf/arch/x86/util/topdown.c
> > @@ -9,11 +9,6 @@
> >  #include "topdown.h"
> >  #include "evsel.h"
> >
> > -#define TOPDOWN_L1_EVENTS       "{slots,topdown-retiring,topdown-bad-s=
pec,topdown-fe-bound,topdown-be-bound}"
> > -#define TOPDOWN_L1_EVENTS_CORE  "{slots,cpu_core/topdown-retiring/,cpu=
_core/topdown-bad-spec/,cpu_core/topdown-fe-bound/,cpu_core/topdown-be-boun=
d/}"
> > -#define TOPDOWN_L2_EVENTS       "{slots,topdown-retiring,topdown-bad-s=
pec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredi=
ct,topdown-fetch-lat,topdown-mem-bound}"
> > -#define TOPDOWN_L2_EVENTS_CORE  "{slots,cpu_core/topdown-retiring/,cpu=
_core/topdown-bad-spec/,cpu_core/topdown-fe-bound/,cpu_core/topdown-be-boun=
d/,cpu_core/topdown-heavy-ops/,cpu_core/topdown-br-mispredict/,cpu_core/top=
down-fetch-lat/,cpu_core/topdown-mem-bound/}"
> > -
> >  /* Check whether there is a PMU which supports the perf metrics. */
> >  bool topdown_sys_has_perf_metrics(void)
> >  {
> > @@ -99,28 +94,3 @@ const char *arch_get_topdown_pmu_name(struct evlist =
*evlist, bool warn)
> >
> >       return pmu_name;
> >  }
> > -
> > -int topdown_parse_events(struct evlist *evlist)
> > -{
> > -     const char *topdown_events;
> > -     const char *pmu_name;
> > -
> > -     if (!topdown_sys_has_perf_metrics())
> > -             return 0;
> > -
> > -     pmu_name =3D arch_get_topdown_pmu_name(evlist, false);
> > -
> > -     if (pmu_have_event(pmu_name, "topdown-heavy-ops")) {
> > -             if (!strcmp(pmu_name, "cpu_core"))
> > -                     topdown_events =3D TOPDOWN_L2_EVENTS_CORE;
> > -             else
> > -                     topdown_events =3D TOPDOWN_L2_EVENTS;
> > -     } else {
> > -             if (!strcmp(pmu_name, "cpu_core"))
> > -                     topdown_events =3D TOPDOWN_L1_EVENTS_CORE;
> > -             else
> > -                     topdown_events =3D TOPDOWN_L1_EVENTS;
> > -     }
> > -
> > -     return parse_event(evlist, topdown_events);
> > -}
> > diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/u=
til/topdown.h
> > index 7eb81f042838..46bf9273e572 100644
> > --- a/tools/perf/arch/x86/util/topdown.h
> > +++ b/tools/perf/arch/x86/util/topdown.h
> > @@ -3,6 +3,5 @@
> >  #define _TOPDOWN_H 1
> >
> >  bool topdown_sys_has_perf_metrics(void);
> > -int topdown_parse_events(struct evlist *evlist);
> >
> >  #endif
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 5e13171a7bba..796e98e453f6 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -1996,6 +1996,7 @@ static int add_default_attributes(void)
> >               stat_config.topdown_level =3D TOPDOWN_MAX_LEVEL;
> >
> >       if (!evsel_list->core.nr_entries) {
> > +             /* No events so add defaults. */
> >               if (target__has_cpu(&target))
> >                       default_attrs0[0].config =3D PERF_COUNT_SW_CPU_CL=
OCK;
> >
> > @@ -2011,6 +2012,19 @@ static int add_default_attributes(void)
> >               }
> >               if (evlist__add_default_attrs(evsel_list, default_attrs1)=
 < 0)
> >                       return -1;
> > +             /*
> > +              * Add TopdownL1 metrics if they exist. To minimize
> > +              * multiplexing, don't request threshold computation.
> > +              */
> > +             if (metricgroup__has_metric("TopdownL1") &&
> > +                 metricgroup__parse_groups(evsel_list, "TopdownL1",
> > +                                         /*metric_no_group=3D*/false,
> > +                                         /*metric_no_merge=3D*/false,
> > +                                         /*metric_no_threshold=3D*/tru=
e,
> > +                                         stat_config.user_requested_cp=
u_list,
> > +                                         stat_config.system_wide,
> > +                                         &stat_config.metric_events) <=
 0)
>
> Does the metricgroup__* function check the existances of the events on
> the machine? If not, it may not be reliable to only check the event list.
>
> The existing code supports both L1 and L2 Topdown for SPR. But this
> patch seems remove the L2 Topdown support for SPR.
>
> The TopdownL1/L2 metric is added only for the big core with perf stat
> default. It's because that the perf_metrics is a dedicated register,
> which should not impact other events (using GP counters.) But this patch
> seems don't check the CPU type. It may brings extra multiplexing for the
> perf stat default on an ATOM platform.
>
> Thanks,
> Kan

Hi Kan,

The TopdownL2 metrics are present for SPR. The code changes to default
for L1 as with json topdown the maximum topdown level (the default
previously) is L6, and nobody really wants to see that. The --topdown
option is no longer limited to Icelake+ processors, any with the
TopdownL1 metricgroup will work as --topdown has just become a
shortcut to that.

There may be additional multiplexing, but also, in the old code events
from different groups could be used to calculate a bogus metric. There
are also additional events as the previous metrics don't agree with
those in the TMA spreadsheet. If there is multiplexing from this
change on SPR, the TMA json metrics do try to avoid this, I think the
right path through this is to fix the json metrics.

Thanks,
Ian

> > +                     return -1;
> >               /* Platform specific attrs */
> >               if (evlist__add_default_attrs(evsel_list, default_null_at=
trs) < 0)
> >                       return -1;
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgrou=
p.c
> > index afb6f2fdc24e..64a35f2787dc 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -1647,10 +1647,8 @@ static int metricgroup__has_metric_callback(cons=
t struct pmu_metric *pm,
> >  {
> >       const char *metric =3D vdata;
> >
> > -     if (!pm->metric_expr)
> > -             return 0;
> > -
> > -     if (match_metric(pm->metric_name, metric))
> > +     if (match_metric(pm->metric_name, metric) ||
> > +         match_metric(pm->metric_group, metric))
> >               return 1;
> >
> >       return 0;
