Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD9C5FBE88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJKX7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJKX73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:59:29 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1EA6B174;
        Tue, 11 Oct 2022 16:59:28 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-132fb4fd495so17783123fac.12;
        Tue, 11 Oct 2022 16:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvXsCNAypnyl5gdIwCrltP9rlbgqJv9DsYJLEw2Z/nY=;
        b=nkoIJPV6oErGMWNjeJm6iNFEgf3cH4mk6mYihcJ7VJZ0FKc3HKcSI8skOAiUolY92B
         QxuoEHGVa6MGiz/T4+Qv0cJ3+Y5Mu3EzPcO3Rhb1qALfcMje3X5ryixP/xSH0/KQLNOO
         k4nRzFfsoG4jDr0kkhg+GbOpgRHjra3IjA4tLIZm54DZ2ejwX75HL+gkcCTAZMkDVkTs
         NG+jdjbumjIqeXUFqC2kyk+Lutg2Kel5zgfflRn/TlqJBRZ1rYsmfqNZefIl0/1P2uyK
         oWhfkaHe3doewLgrEvUB8hGdo+JSqDlgSGjs4qGh8JWc4Fyq2XlmaWdQwz0Erkk+Twxi
         bTrg==
X-Gm-Message-State: ACrzQf0gDvLS9UaWw57EY4UTCZVTDu7hKq6Go1LiPX+uwvaDOUuT6Z4h
        aUoIJ057o++L1hqEdYM4WkmBSasN0sauhU0HqH0=
X-Google-Smtp-Source: AMsMyM4JA50Xiy4OiblgbG7fiS1511pG0FvnqA0j1rmTDYxJ+kxWkhjJUup4ZPUxgOtjxJ1pTkFlPYf3KDLU+cqn5SY=
X-Received: by 2002:a05:6870:82ac:b0:133:34b:6f10 with SMTP id
 q44-20020a05687082ac00b00133034b6f10mr1007197oae.218.1665532768056; Tue, 11
 Oct 2022 16:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-16-namhyung@kernel.org>
 <CAP-5=fUKYN_kWx=nwHjer+FfsgA2OMfCK7CwZHTsrtGrRft-5g@mail.gmail.com>
In-Reply-To: <CAP-5=fUKYN_kWx=nwHjer+FfsgA2OMfCK7CwZHTsrtGrRft-5g@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Oct 2022 16:59:16 -0700
Message-ID: <CAM9d7chEWhNEouUn_Q8_YFCRoczW+bTC=uKwa0FQkpFd5J8uVA@mail.gmail.com>
Subject: Re: [PATCH 15/19] perf stat: Add perf_stat_process_percore()
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

On Mon, Oct 10, 2022 at 4:33 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The perf_stat_process_percore() is to aggregate counts for an event per-core
> > even if the aggr_mode is AGGR_NONE.  This is enabled when user requested it
> > on the command line.
>
> Is there an example command line for this? It would be nice to add as a test.

  perf stat -a -A -e cpu/event=cpu-cycles,percore/ sleep 1

Thanks,
Namhyung


>
> > To handle that, it keeps the per-cpu counts at first.  And then it aggregates
> > the counts that have the same core id in the aggr->counts and updates the
> > values for each cpu back.
> >
> > Later, per-core events will skip one of the CPUs unless percore-show-thread
> > option is given.  In that case, it can simply print all cpu stats with the
> > updated (per-core) values.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c |  1 +
> >  tools/perf/util/stat.c    | 71 +++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/stat.h    |  2 ++
> >  3 files changed, 74 insertions(+)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index f90e8f29cb23..c127e784a7be 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -488,6 +488,7 @@ static void process_counters(void)
> >         }
> >
> >         perf_stat_merge_counters(&stat_config, evsel_list);
> > +       perf_stat_process_percore(&stat_config, evsel_list);
> >  }
> >
> >  static void process_interval(void)
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 1bb197782a34..d788d0e85204 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -671,6 +671,77 @@ void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *ev
> >                 evsel__merge_stats(evsel, config);
> >  }
> >
> > +static void evsel__update_percore_stats(struct evsel *evsel, struct aggr_cpu_id *core_id)
> > +{
> > +       struct perf_stat_evsel *ps = evsel->stats;
> > +       struct perf_counts_values counts = { 0, };
> > +       struct aggr_cpu_id id;
> > +       struct perf_cpu cpu;
> > +       int idx;
> > +
> > +       /* collect per-core counts */
> > +       perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus) {
> > +               struct perf_stat_aggr *aggr = &ps->aggr[idx];
> > +
> > +               id = aggr_cpu_id__core(cpu, NULL);
> > +               if (!aggr_cpu_id__equal(core_id, &id))
> > +                       continue;
> > +
> > +               counts.val += aggr->counts.val;
> > +               counts.ena += aggr->counts.ena;
> > +               counts.run += aggr->counts.run;
> > +       }
> > +
> > +       /* update aggregated per-core counts for each CPU */
> > +       perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus) {
> > +               struct perf_stat_aggr *aggr = &ps->aggr[idx];
> > +
> > +               id = aggr_cpu_id__core(cpu, NULL);
> > +               if (!aggr_cpu_id__equal(core_id, &id))
> > +                       continue;
> > +
> > +               aggr->counts.val = counts.val;
> > +               aggr->counts.ena = counts.ena;
> > +               aggr->counts.run = counts.run;
> > +
> > +               aggr->used = true;
> > +       }
> > +}
> > +
> > +/* we have an aggr_map for cpu, but want to aggregate the counters per-core */
> > +static void evsel__process_percore(struct evsel *evsel)
> > +{
> > +       struct perf_stat_evsel *ps = evsel->stats;
> > +       struct aggr_cpu_id core_id;
> > +       struct perf_cpu cpu;
> > +       int idx;
> > +
> > +       if (!evsel->percore)
> > +               return;
> > +
> > +       perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus) {
> > +               struct perf_stat_aggr *aggr = &ps->aggr[idx];
> > +
> > +               if (aggr->used)
> > +                       continue;
> > +
> > +               core_id = aggr_cpu_id__core(cpu, NULL);
> > +               evsel__update_percore_stats(evsel, &core_id);
> > +       }
> > +}
> > +
> > +/* process cpu stats on per-core events */
> > +void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *evlist)
> > +{
> > +       struct evsel *evsel;
> > +
> > +       if (config->aggr_mode != AGGR_NONE)
> > +               return;
> > +
> > +       evlist__for_each_entry(evlist, evsel)
> > +               evsel__process_percore(evsel);
> > +}
> > +
> >  int perf_event__process_stat_event(struct perf_session *session,
> >                                    union perf_event *event)
> >  {
> > diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> > index 12cc60ab04e4..ac85ed46aa59 100644
> > --- a/tools/perf/util/stat.h
> > +++ b/tools/perf/util/stat.h
> > @@ -46,6 +46,7 @@ enum perf_stat_evsel_id {
> >  struct perf_stat_aggr {
> >         struct perf_counts_values       counts;
> >         int                             nr;
> > +       bool                            used;
> >         bool                            failed;
> >  };
> >
> > @@ -271,6 +272,7 @@ void evlist__reset_aggr_stats(struct evlist *evlist);
> >  int perf_stat_process_counter(struct perf_stat_config *config,
> >                               struct evsel *counter);
> >  void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist);
> > +void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *evlist);
> >
> >  struct perf_tool;
> >  union perf_event;
> > --
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >
