Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448E45FBE86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJKXzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJKXzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:55:53 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC965465F;
        Tue, 11 Oct 2022 16:55:52 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-12c8312131fso17811507fac.4;
        Tue, 11 Oct 2022 16:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtaFq/t4wsGcMgPCtvKC+Y3cNXmanIRQPDWIEyGdlFk=;
        b=hBAxsiLJL1tEQ5xNmzw082+1VktgTq/DRr/0fX7+bc1vJ86zZaXPtLeEC0nDsEwwUU
         BoSAqt37jADQsNEEsNuZrg7jYnB12ehRazJLxTl4poP2yJ89Wmi/sCe5WnecasiiAkfB
         gbpxSrv0cixs5hLot5vX4feI/u2Mzx+4Zj4BDZ15oJ1rZOa5ChR8Rl0tXm3vpO0UFROY
         GA5wm1/BcFoHBWuZl8VctJ050/BT36KlDIqc7HLKumLZqENsjXX5g7Xndpx57n2/l+Wy
         mOBLBfMiREOOQZWbPcai7JyVGJcqy5G2baPrC7wW665MjPzQUP5WQwumXLeedxZdzgLM
         IINw==
X-Gm-Message-State: ACrzQf1SIfPA1o3HkG8rll6jQ/naisXSpTEhFDIpUQaHoh8IO6nnaHy5
        mqUedc8YbSYfA2Od2lcXa476+5dzpC7OdqU66G0=
X-Google-Smtp-Source: AMsMyM6LjMvzf500I/HmTiZPZUxc9jBY0cREpUNfp45Dtw2UezL7dTZLwVeceaQSjdOvTUWp2CVk22p1u2FoxobxHKA=
X-Received: by 2002:a05:6870:4184:b0:136:5e73:b40e with SMTP id
 y4-20020a056870418400b001365e73b40emr904855oac.209.1665532551787; Tue, 11 Oct
 2022 16:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-15-namhyung@kernel.org>
 <CAP-5=fWxD6KJiHCDOK6UdgfQadnjCc6eMPmPY68T3TKYAz402Q@mail.gmail.com>
In-Reply-To: <CAP-5=fWxD6KJiHCDOK6UdgfQadnjCc6eMPmPY68T3TKYAz402Q@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Oct 2022 16:55:40 -0700
Message-ID: <CAM9d7chV5XZ9un7g_T+Z90uP5Nz7r-J17xD1kx4LCFkNmK8bgw@mail.gmail.com>
Subject: Re: [PATCH 14/19] perf stat: Add perf_stat_merge_counters()
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 4:31 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The perf_stat_merge_counters() is to aggregate the same events in different
> > PMUs like in case of uncore or hybrid.  The same logic is in the stat-display
> > routines but I think it should be handled when it processes the event counters.
>
> I think I'm confused as to what a merged counter is. Does it relate to
> the evsel leader? How are aliases and merging related?

I'm also not sure if the 'aliases' is a good name but I just followed
the existing name
in collect_data().  It's about uncore and hybrid events afaik, not about groups.

For uncore case, it wants to merge the same event in other uncore together
e.g. uncore_imc_0/cas_count_read/ , uncore_imc_1/cas_count_read/ , ...
to uncore_imc/cas_count_read/ or simply imc/cas_count_read/ .

For hybrid case, it'd merge cpu_core/cycles/ and cpu_atom/cycles/ to
cycles when --hybrid-merge is given.

Thanks,
Namhyung

>
> >
> > As it works on the aggr_counters, it doesn't change the output yet.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c |  2 +
> >  tools/perf/util/stat.c    | 96 +++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/stat.h    |  2 +
> >  3 files changed, 100 insertions(+)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 49a7e290d778..f90e8f29cb23 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -486,6 +486,8 @@ static void process_counters(void)
> >                         pr_warning("failed to process counter %s\n", counter->name);
> >                 counter->err = 0;
> >         }
> > +
> > +       perf_stat_merge_counters(&stat_config, evsel_list);
> >  }
> >
> >  static void process_interval(void)
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 4edfc1c5dc07..1bb197782a34 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -575,6 +575,102 @@ int perf_stat_process_counter(struct perf_stat_config *config,
> >         return 0;
> >  }
> >
> > +static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
> > +{
> > +       struct perf_stat_evsel *ps_a = evsel->stats;
> > +       struct perf_stat_evsel *ps_b = alias->stats;
> > +       int i;
> > +
> > +       if (ps_a->aggr == NULL && ps_b->aggr == NULL)
> > +               return 0;
> > +
> > +       if (ps_a->nr_aggr != ps_b->nr_aggr) {
> > +               pr_err("Unmatched aggregation mode between aliases\n");
> > +               return -1;
> > +       }
> > +
> > +       for (i = 0; i < ps_a->nr_aggr; i++) {
> > +               struct perf_counts_values *aggr_counts_a = &ps_a->aggr[i].counts;
> > +               struct perf_counts_values *aggr_counts_b = &ps_b->aggr[i].counts;
> > +
> > +               /* NB: don't increase aggr.nr for aliases */
> > +
> > +               aggr_counts_a->val += aggr_counts_b->val;
> > +               aggr_counts_a->ena += aggr_counts_b->ena;
> > +               aggr_counts_a->run += aggr_counts_b->run;
> > +       }
> > +
> > +       return 0;
> > +}
> > +/* events should have the same name, scale, unit, cgroup but on different PMUs */
> > +static bool evsel__is_alias(struct evsel *evsel_a, struct evsel *evsel_b)
> > +{
> > +       if (strcmp(evsel__name(evsel_a), evsel__name(evsel_b)))
> > +               return false;
> > +
> > +       if (evsel_a->scale != evsel_b->scale)
> > +               return false;
> > +
> > +       if (evsel_a->cgrp != evsel_b->cgrp)
> > +               return false;
> > +
> > +       if (strcmp(evsel_a->unit, evsel_b->unit))
> > +               return false;
> > +
> > +       if (evsel__is_clock(evsel_a) != evsel__is_clock(evsel_b))
> > +               return false;
> > +
> > +       return !!strcmp(evsel_a->pmu_name, evsel_b->pmu_name);
> > +}
> > +
> > +static void evsel__merge_aliases(struct evsel *evsel)
> > +{
> > +       struct evlist *evlist = evsel->evlist;
> > +       struct evsel *alias;
> > +
> > +       alias = list_prepare_entry(evsel, &(evlist->core.entries), core.node);
> > +       list_for_each_entry_continue(alias, &evlist->core.entries, core.node) {
> > +               /* Merge the same events on different PMUs. */
> > +               if (evsel__is_alias(evsel, alias)) {
> > +                       evsel__merge_aggr_counters(evsel, alias);
> > +                       alias->merged_stat = true;
> > +               }
> > +       }
> > +}
> > +
> > +static bool evsel__should_merge_hybrid(struct evsel *evsel, struct perf_stat_config *config)
> > +{
> > +       struct perf_pmu *pmu;
> > +
> > +       if (!config->hybrid_merge)
> > +               return false;
> > +
> > +       pmu = evsel__find_pmu(evsel);
> > +       return pmu && pmu->is_hybrid;
> > +}
> > +
> > +static void evsel__merge_stats(struct evsel *evsel, struct perf_stat_config *config)
> > +{
> > +       /* this evsel is already merged */
> > +       if (evsel->merged_stat)
> > +               return;
> > +
> > +       if (evsel->auto_merge_stats || evsel__should_merge_hybrid(evsel, config))
> > +               evsel__merge_aliases(evsel);
> > +}
> > +
> > +/* merge the same uncore and hybrid events if requested */
> > +void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist)
> > +{
> > +       struct evsel *evsel;
> > +
> > +       if (config->no_merge)
> > +               return;
> > +
> > +       evlist__for_each_entry(evlist, evsel)
> > +               evsel__merge_stats(evsel, config);
> > +}
> > +
> >  int perf_event__process_stat_event(struct perf_session *session,
> >                                    union perf_event *event)
> >  {
> > diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> > index 3a876ad2870b..12cc60ab04e4 100644
> > --- a/tools/perf/util/stat.h
> > +++ b/tools/perf/util/stat.h
> > @@ -270,6 +270,8 @@ void evlist__reset_aggr_stats(struct evlist *evlist);
> >
> >  int perf_stat_process_counter(struct perf_stat_config *config,
> >                               struct evsel *counter);
> > +void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist);
> > +
> >  struct perf_tool;
> >  union perf_event;
> >  struct perf_session;
> > --
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >
