Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C626A52F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 07:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjB1G1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 01:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjB1G1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:27:45 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6916ACE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 22:27:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r18so8562516wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 22:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677565661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBS3gHi7fmIAW37f8YenO0m+kqJMsBVssq4mkPrHjRU=;
        b=NJ0VAEd6nD2l8Nbc7L1pUkZsY3vGmIqW13ijmAjDCiO9i/Seto5Zmg22rAYYMvliSL
         oV+QLH0kXxUrbAqZd6K5eTkD6ber9tciCX8t9h4O0cmptg0dhSKilazgmPHc0Mlf71r3
         zbjvQ3RzD+dRnonDRNeCyZOGJpdRCNtCMkxSltRVptPrA2aHn68D8g9mj+vDuExllLeJ
         2YyIN4EkJU6H6b5vmIwWzJhA6g6XlAaU3l2A9ZpxHVoCVAg8Ito1HUERnmkNvuHQvt4I
         h8pbydBDkiXrFMolBLB/lz7e8nDvmb8QgGneYKgyqXba1Ez15GB1cB0me4oGhcFmzd4V
         Xx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677565661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBS3gHi7fmIAW37f8YenO0m+kqJMsBVssq4mkPrHjRU=;
        b=OczHW/+39iFo4awoOqXs6PwDov8kOCSXihr8FjGY7Vsl5v5vFOf+HVEAmOPn/8ONNM
         JC/nF+YB4w+FTj3GegzVhRCWjUSFB5gI7M0MiMc8havFqKB91ofrWIvNk9frIgLs4h2L
         3MBVQRezJxbfR4WFMe2E3UCGyTwfjH/1cj38kWxjOW7yrO9Qgb6b6kQgBecbLdYMh2YG
         PhMJLDd49B3gyMQA0QStJdvkKaGMfQBV/0tnWLQrC2nr3Kk3jnV4Yv3NzVmChAlrMgrx
         MQ4BL11XjyX5ndVMX4brfebWRM6hlxOxZeHUBLcYx/UUIjmR/mu9LyOEJkkQgWT8+WvF
         T35Q==
X-Gm-Message-State: AO0yUKWK4EbQl4jkIY7jxI38+UrSc619f1UaHxAkjLU1ykAkOsqm+mtb
        hfAfGtVq1dSFmhrF8zUrF5tTRC2unExtUfagYU5oAA==
X-Google-Smtp-Source: AK7set+81i6RuKBlyYEUY2aCtjiZJrfENNcsbZK/O9it2KIIrYWaiVoxV0B/sC4tmPlSSLN/XP/5iuy3e2qKQT5Yc2o=
X-Received: by 2002:a5d:6943:0:b0:2c7:1e2c:873c with SMTP id
 r3-20020a5d6943000000b002c71e2c873cmr329656wrw.9.1677565661100; Mon, 27 Feb
 2023 22:27:41 -0800 (PST)
MIME-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com> <20230219092848.639226-40-irogers@google.com>
 <09f0e75a-a11d-7db1-6308-f1b00462908c@linux.intel.com> <CAP-5=fW8cM0cWaCs8Vu9Nom1i2TF024-yyHtdUQx8QE3HFTq0w@mail.gmail.com>
 <231233ec-a098-fab6-6444-3da46bdad039@linux.intel.com>
In-Reply-To: <231233ec-a098-fab6-6444-3da46bdad039@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Feb 2023 22:27:29 -0800
Message-ID: <CAP-5=fXNO232hSWFbAZ1rZP1xMjjxf-bLYb7TdoE=NBDwwOPFQ@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 12:13=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-02-27 2:33 p.m., Ian Rogers wrote:
> > On Mon, Feb 27, 2023 at 11:12=E2=80=AFAM Liang, Kan <kan.liang@linux.in=
tel.com> wrote:
> >>
> >>
> >>
> >> On 2023-02-19 4:28 a.m., Ian Rogers wrote:
> >>> When there are no events and on Intel, the topdown events will be
> >>> added by default if present. To display the metrics associated with
> >>> these request special handling in stat-shadow.c. To more easily updat=
e
> >>> these metrics use the json metric version via the TopdownL1
> >>> group. This makes the handling less platform specific.
> >>>
> >>> Modify the metricgroup__has_metric code to also cover metric groups.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/arch/x86/util/evlist.c  |  6 +++---
> >>>  tools/perf/arch/x86/util/topdown.c | 30 ----------------------------=
--
> >>>  tools/perf/arch/x86/util/topdown.h |  1 -
> >>>  tools/perf/builtin-stat.c          | 14 ++++++++++++++
> >>>  tools/perf/util/metricgroup.c      |  6 ++----
> >>>  5 files changed, 19 insertions(+), 38 deletions(-)
> >>>
> >>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/=
util/evlist.c
> >>> index cb59ce9b9638..8a7ae4162563 100644
> >>> --- a/tools/perf/arch/x86/util/evlist.c
> >>> +++ b/tools/perf/arch/x86/util/evlist.c
> >>> @@ -59,10 +59,10 @@ int arch_evlist__add_default_attrs(struct evlist =
*evlist,
> >>>                                  struct perf_event_attr *attrs,
> >>>                                  size_t nr_attrs)
> >>>  {
> >>> -     if (nr_attrs)
> >>> -             return ___evlist__add_default_attrs(evlist, attrs, nr_a=
ttrs);
> >>> +     if (!nr_attrs)
> >>> +             return 0;
> >>>
> >>> -     return topdown_parse_events(evlist);
> >>> +     return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
> >>>  }
> >>>
> >>>  struct evsel *arch_evlist__leader(struct list_head *list)
> >>> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86=
/util/topdown.c
> >>> index 54810f9acd6f..eb3a7d9652ab 100644
> >>> --- a/tools/perf/arch/x86/util/topdown.c
> >>> +++ b/tools/perf/arch/x86/util/topdown.c
> >>> @@ -9,11 +9,6 @@
> >>>  #include "topdown.h"
> >>>  #include "evsel.h"
> >>>
> >>> -#define TOPDOWN_L1_EVENTS       "{slots,topdown-retiring,topdown-bad=
-spec,topdown-fe-bound,topdown-be-bound}"
> >>> -#define TOPDOWN_L1_EVENTS_CORE  "{slots,cpu_core/topdown-retiring/,c=
pu_core/topdown-bad-spec/,cpu_core/topdown-fe-bound/,cpu_core/topdown-be-bo=
und/}"
> >>> -#define TOPDOWN_L2_EVENTS       "{slots,topdown-retiring,topdown-bad=
-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispre=
dict,topdown-fetch-lat,topdown-mem-bound}"
> >>> -#define TOPDOWN_L2_EVENTS_CORE  "{slots,cpu_core/topdown-retiring/,c=
pu_core/topdown-bad-spec/,cpu_core/topdown-fe-bound/,cpu_core/topdown-be-bo=
und/,cpu_core/topdown-heavy-ops/,cpu_core/topdown-br-mispredict/,cpu_core/t=
opdown-fetch-lat/,cpu_core/topdown-mem-bound/}"
> >>> -
> >>>  /* Check whether there is a PMU which supports the perf metrics. */
> >>>  bool topdown_sys_has_perf_metrics(void)
> >>>  {
> >>> @@ -99,28 +94,3 @@ const char *arch_get_topdown_pmu_name(struct evlis=
t *evlist, bool warn)
> >>>
> >>>       return pmu_name;
> >>>  }
> >>> -
> >>> -int topdown_parse_events(struct evlist *evlist)
> >>> -{
> >>> -     const char *topdown_events;
> >>> -     const char *pmu_name;
> >>> -
> >>> -     if (!topdown_sys_has_perf_metrics())
> >>> -             return 0;
> >>> -
> >>> -     pmu_name =3D arch_get_topdown_pmu_name(evlist, false);
> >>> -
> >>> -     if (pmu_have_event(pmu_name, "topdown-heavy-ops")) {
> >>> -             if (!strcmp(pmu_name, "cpu_core"))
> >>> -                     topdown_events =3D TOPDOWN_L2_EVENTS_CORE;
> >>> -             else
> >>> -                     topdown_events =3D TOPDOWN_L2_EVENTS;
> >>> -     } else {
> >>> -             if (!strcmp(pmu_name, "cpu_core"))
> >>> -                     topdown_events =3D TOPDOWN_L1_EVENTS_CORE;
> >>> -             else
> >>> -                     topdown_events =3D TOPDOWN_L1_EVENTS;
> >>> -     }
> >>> -
> >>> -     return parse_event(evlist, topdown_events);
> >>> -}
> >>> diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86=
/util/topdown.h
> >>> index 7eb81f042838..46bf9273e572 100644
> >>> --- a/tools/perf/arch/x86/util/topdown.h
> >>> +++ b/tools/perf/arch/x86/util/topdown.h
> >>> @@ -3,6 +3,5 @@
> >>>  #define _TOPDOWN_H 1
> >>>
> >>>  bool topdown_sys_has_perf_metrics(void);
> >>> -int topdown_parse_events(struct evlist *evlist);
> >>>
> >>>  #endif
> >>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >>> index 5e13171a7bba..796e98e453f6 100644
> >>> --- a/tools/perf/builtin-stat.c
> >>> +++ b/tools/perf/builtin-stat.c
> >>> @@ -1996,6 +1996,7 @@ static int add_default_attributes(void)
> >>>               stat_config.topdown_level =3D TOPDOWN_MAX_LEVEL;
> >>>
> >>>       if (!evsel_list->core.nr_entries) {
> >>> +             /* No events so add defaults. */
> >>>               if (target__has_cpu(&target))
> >>>                       default_attrs0[0].config =3D PERF_COUNT_SW_CPU_=
CLOCK;
> >>>
> >>> @@ -2011,6 +2012,19 @@ static int add_default_attributes(void)
> >>>               }
> >>>               if (evlist__add_default_attrs(evsel_list, default_attrs=
1) < 0)
> >>>                       return -1;
> >>> +             /*
> >>> +              * Add TopdownL1 metrics if they exist. To minimize
> >>> +              * multiplexing, don't request threshold computation.
> >>> +              */
> >>> +             if (metricgroup__has_metric("TopdownL1") &&
> >>> +                 metricgroup__parse_groups(evsel_list, "TopdownL1",
> >>> +                                         /*metric_no_group=3D*/false=
,
> >>> +                                         /*metric_no_merge=3D*/false=
,
> >>> +                                         /*metric_no_threshold=3D*/t=
rue,
> >>> +                                         stat_config.user_requested_=
cpu_list,
> >>> +                                         stat_config.system_wide,
> >>> +                                         &stat_config.metric_events)=
 < 0)
> >>
> >> Does the metricgroup__* function check the existances of the events on
> >> the machine? If not, it may not be reliable to only check the event li=
st.
> >>
> >> The existing code supports both L1 and L2 Topdown for SPR. But this
> >> patch seems remove the L2 Topdown support for SPR.
> >>
> >> The TopdownL1/L2 metric is added only for the big core with perf stat
> >> default. It's because that the perf_metrics is a dedicated register,
> >> which should not impact other events (using GP counters.) But this pat=
ch
> >> seems don't check the CPU type. It may brings extra multiplexing for t=
he
> >> perf stat default on an ATOM platform.
> >>
> >> Thanks,
> >> Kan
> >
> > Hi Kan,
> >
> > The TopdownL2 metrics are present for SPR. The code changes to default
> > for L1 as with json topdown the maximum topdown level (the default
> > previously) is L6, and nobody really wants to see that. The --topdown
> > option is no longer limited to Icelake+ processors, any with the
> > TopdownL1 metricgroup will work as --topdown has just become a
> > shortcut to that.
>
> This patch seems also changes the perf stat default. The current perf
> stat default shows both L1 and L2 for SPR. If that's the case, it should
> be a user visible changes. What's output of "perf stat sleep 1" with
> this patch on SPR?

I'll need to find an SPR. The change from L2 to L1 as mentioned above
is that the behavior was to print max topdown level, and with json
metrics that is level 6. We could make the behavior level 2 if L2
topdown events are present. I didn't do this as it would mean SPR
didn't align with everything else.

> >
> > There may be additional multiplexing, but also, in the old code events
> > from different groups could be used to calculate a bogus metric. There
> > are also additional events as the previous metrics don't agree with
> > those in the TMA spreadsheet. If there is multiplexing from this
> > change on SPR, the TMA json metrics do try to avoid this, I think the
> > right path through this is to fix the json metrics.
>
> For the perf stat default, there should be no multiplexing.
>
> Also, it looks like the patch and the following several patches remove
> the existence check of an event (pmu_have_event()). It may not be a good
> idea. Those events/features usually be enumerated, which means that they
> may not be available in some cases. For example, we don't have the perf
> metrics support on KVM. I don't think the current JSON metrics checks
> the CPUID enumeration. If so, the patch may brings problem in a VM.

This seems like a general problem with json metrics. In the case that
no metric is calculated the metric isn't printed, but you may see the
events as not counted. We could special case this as the current code
does or perhaps we can have some kind of "default event" flag and if
such events fail to open just drop them from the output. There are
likely other strategies.

Thanks,
Ian

> Thanks,
> Kan
>
> >
> > Thanks,
> > Ian
> >
> >>> +                     return -1;
> >>>               /* Platform specific attrs */
> >>>               if (evlist__add_default_attrs(evsel_list, default_null_=
attrs) < 0)
> >>>                       return -1;
> >>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgr=
oup.c
> >>> index afb6f2fdc24e..64a35f2787dc 100644
> >>> --- a/tools/perf/util/metricgroup.c
> >>> +++ b/tools/perf/util/metricgroup.c
> >>> @@ -1647,10 +1647,8 @@ static int metricgroup__has_metric_callback(co=
nst struct pmu_metric *pm,
> >>>  {
> >>>       const char *metric =3D vdata;
> >>>
> >>> -     if (!pm->metric_expr)
> >>> -             return 0;
> >>> -
> >>> -     if (match_metric(pm->metric_name, metric))
> >>> +     if (match_metric(pm->metric_name, metric) ||
> >>> +         match_metric(pm->metric_group, metric))
> >>>               return 1;
> >>>
> >>>       return 0;
