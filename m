Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A445FBE7B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJKXoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJKXow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:44:52 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7747C2B8;
        Tue, 11 Oct 2022 16:44:47 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1364357a691so11284257fac.7;
        Tue, 11 Oct 2022 16:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLYdrWZ1vjKGoHnr5RHW9YrSJRlNUAHcXQaONzdh4Gc=;
        b=SbVvGTEmRwrrSrEml7DuSBGNHnGF/THCtvLfG4tFW2Wrp8HXTmwMJmK7aiCqa70JNV
         dtsvRKVxvnS6zTHmjt9CYO7fhUSsSdrJxtBhU26zMw1/KvRQpgMBNPaUgfcjW4HFbyYV
         XzzCqojEo8DhdlYkW38ROgaHsoBWHnjSehunief4+tVxF3VlsbUa+DKFqM/FTqkKsFaE
         uUNo8e8F/94jT+5y6k9SJfQACQTidEut6fErMzT2CGsLTWUXAxLdHcp1BqfK4vnljmcc
         uKHSHk+ocLZgTdA+o8hWtpW9eefb5sWXNIMIEXNEDPsAUP3474nmFCmWhu4HamA5Z+MX
         eyxw==
X-Gm-Message-State: ACrzQf0S3FMZ8SVMZrDljlzer7oPwRl0EDV7bLuyj8MQPOB2r5lS2Cbq
        AIXbj6Cv+RlG2VzP/eIg+qRUVIVBIemkzj2qmdc=
X-Google-Smtp-Source: AMsMyM40R82K03b4y20lMtuhHHFECtihZ9+oVBOYurphPBL2+Q9QZinoAPEb7uqSsFKZiYP9/bGAqiFied41owEm/+g=
X-Received: by 2002:a05:6870:82ac:b0:133:34b:6f10 with SMTP id
 q44-20020a05687082ac00b00133034b6f10mr982274oae.218.1665531886750; Tue, 11
 Oct 2022 16:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-10-namhyung@kernel.org>
 <CAP-5=fVW31CH6vhw4zECP-DZbxq8c2V=+C68e5c20LD-xxYbBA@mail.gmail.com>
In-Reply-To: <CAP-5=fVW31CH6vhw4zECP-DZbxq8c2V=+C68e5c20LD-xxYbBA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Oct 2022 16:44:35 -0700
Message-ID: <CAM9d7ciMT6XdeAfnQ-kad4gKtHjiSVr66OjhP6y8rfbxKvpAfA@mail.gmail.com>
Subject: Re: [PATCH 09/19] perf stat: Aggregate events using evsel->stats->aggr
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

On Mon, Oct 10, 2022 at 4:11 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Add a logic to aggregate counter values to the new evsel->stats->aggr.
> > This is not used yet so shadow stats are not updated.  But later patch
> > will convert the existing code to use it.
> >
> > With that, we don't need to handle AGGR_GLOBAL specially anymore.  It
> > can use the same logic with counts, prev_counts and aggr_counts.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c                     |  3 --
> >  tools/perf/util/evsel.c                       |  9 +---
> >  .../scripting-engines/trace-event-python.c    |  6 ---
> >  tools/perf/util/stat.c                        | 46 ++++++++++++++++---
> >  4 files changed, 41 insertions(+), 23 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index eaddafbd7ff2..139e35ed68d3 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -963,9 +963,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >                 init_stats(&walltime_nsecs_stats);
> >                 update_stats(&walltime_nsecs_stats, t1 - t0);
> >
> > -               if (stat_config.aggr_mode == AGGR_GLOBAL)
> > -                       evlist__save_aggr_prev_raw_counts(evsel_list);
> > -
> >                 evlist__copy_prev_raw_counts(evsel_list);
> >                 evlist__reset_prev_raw_counts(evsel_list);
> >                 perf_stat__reset_shadow_per_stat(&rt_stat);
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index a6ea91c72659..a1fcb3166149 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1526,13 +1526,8 @@ void evsel__compute_deltas(struct evsel *evsel, int cpu_map_idx, int thread,
> >         if (!evsel->prev_raw_counts)
> >                 return;
> >
> > -       if (cpu_map_idx == -1) {
> > -               tmp = evsel->prev_raw_counts->aggr;
> > -               evsel->prev_raw_counts->aggr = *count;
> > -       } else {
> > -               tmp = *perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
> > -               *perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread) = *count;
> > -       }
> > +       tmp = *perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
> > +       *perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread) = *count;
> >
> >         count->val = count->val - tmp.val;
> >         count->ena = count->ena - tmp.ena;
> > diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> > index 1f2040f36d4e..7bc8559dce6a 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-python.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> > @@ -1653,12 +1653,6 @@ static void python_process_stat(struct perf_stat_config *config,
> >         struct perf_cpu_map *cpus = counter->core.cpus;
> >         int cpu, thread;
> >
> > -       if (config->aggr_mode == AGGR_GLOBAL) {
> > -               process_stat(counter, (struct perf_cpu){ .cpu = -1 }, -1, tstamp,
> > -                            &counter->counts->aggr);
> > -               return;
> > -       }
> > -
> >         for (thread = 0; thread < threads->nr; thread++) {
> >                 for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
> >                         process_stat(counter, perf_cpu_map__cpu(cpus, cpu),
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 374149628507..99874254809d 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -387,6 +387,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
> >                        struct perf_counts_values *count)
> >  {
> >         struct perf_counts_values *aggr = &evsel->counts->aggr;
> > +       struct perf_stat_evsel *ps = evsel->stats;
> >         static struct perf_counts_values zero;
> >         bool skip = false;
> >
> > @@ -398,6 +399,44 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
> >         if (skip)
> >                 count = &zero;
> >
> > +       if (!evsel->snapshot)
> > +               evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
> > +       perf_counts_values__scale(count, config->scale, NULL);
> > +
> > +       if (ps->aggr) {
> > +               struct perf_cpu cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx);
> > +               struct aggr_cpu_id aggr_id = config->aggr_get_id(config, cpu);
> > +               struct perf_stat_aggr *ps_aggr;
> > +               int i;
> > +
> > +               for (i = 0; i < ps->nr_aggr; i++) {
>
> Would it be cleaner to have a helper function here that returns i or
> ps_aggr for the first CPU being aggregated into? That would avoid the
> continue/break.

Right, we need cpu -> aggr_idx mapping.

>
> > +                       if (!aggr_cpu_id__equal(&aggr_id, &config->aggr_map->map[i]))
> > +                               continue;
> > +
> > +                       ps_aggr = &ps->aggr[i];
> > +                       ps_aggr->nr++;
> > +
> > +                       /*
> > +                        * When any result is bad, make them all to give
> > +                        * consistent output in interval mode.
> > +                        */
> > +                       if (count->ena == 0 || count->run == 0 ||
> > +                           evsel->counts->scaled == -1) {
> > +                               ps_aggr->counts.val = 0;
> > +                               ps_aggr->counts.ena = 0;
> > +                               ps_aggr->counts.run = 0;
> > +                               ps_aggr->failed = true;
> > +                       }
> > +
> > +                       if (!ps_aggr->failed) {
> > +                               ps_aggr->counts.val += count->val;
> > +                               ps_aggr->counts.ena += count->ena;
> > +                               ps_aggr->counts.run += count->run;
> > +                       }
> > +                       break;
> > +               }
> > +       }
> > +
> >         switch (config->aggr_mode) {
> >         case AGGR_THREAD:
> >         case AGGR_CORE:
> > @@ -405,9 +444,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
> >         case AGGR_SOCKET:
> >         case AGGR_NODE:
> >         case AGGR_NONE:
> > -               if (!evsel->snapshot)
> > -                       evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
> > -               perf_counts_values__scale(count, config->scale, NULL);
> >                 if ((config->aggr_mode == AGGR_NONE) && (!evsel->percore)) {
> >                         perf_stat__update_shadow_stats(evsel, count->val,
> >                                                        cpu_map_idx, &rt_stat);
> > @@ -469,10 +505,6 @@ int perf_stat_process_counter(struct perf_stat_config *config,
> >         if (config->aggr_mode != AGGR_GLOBAL)
> >                 return 0;
> >
> > -       if (!counter->snapshot)
> > -               evsel__compute_deltas(counter, -1, -1, aggr);
> > -       perf_counts_values__scale(aggr, config->scale, &counter->counts->scaled);
> > -
>
> It isn't clear to me how this relates to the patch.

It's moved to process_counter_values() to be handled like other
aggr_mode.

Thanks,
Namhyung


>
> >         update_stats(&ps->res_stats, *count);
> >
> >         if (verbose > 0) {
> > --
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >
