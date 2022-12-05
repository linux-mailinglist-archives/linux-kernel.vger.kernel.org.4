Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0E76430F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiLETAn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Dec 2022 14:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiLETAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:00:31 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6455565AD;
        Mon,  5 Dec 2022 11:00:30 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id n188so8184758iof.8;
        Mon, 05 Dec 2022 11:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Y0LkIG7CseqWaGcTYHgkEOPYPWFCe4s1CmA24MHEHU=;
        b=hXJb7o1PcL3qZauq5KiDmgQ8ZnQhrsXjxjvKfmZu88Lbe1eTBrC85CbWDY529qbsX5
         98LHobaj2FW5Ap94v2o0GqD2KzKLfY1nwhZgQzu1BBw04a0x9jtA5bF3ItCo6b72MhrK
         QDij0p5zJ1KiT1gktM0xZb4bB/RGSqKyWpc1GvgR6jHYC6cRxChdxxruN8u1etIHQCvW
         bhH24E9/9DcIBAdKNdb0twFVq09AsGtJCn5DGBPcpFOUKTBjMTor/ij8f450DgbbO6f1
         zD1QHgm9XRZpz3xI1W6Tu96frTEjuhm+l2h1cf5U9Exaf75RyLB9ANa7N+LCxleiS+BX
         OD3A==
X-Gm-Message-State: ANoB5pmkYc8x+GtTkevP7ZHSOBei9IkfcXRDKxRfRA5kipEeNc32+s83
        JCHyaXNrO/na0nK8Z0l6xtwYSiGO7MHJSFTjaPw=
X-Google-Smtp-Source: AA0mqf7AS4Ulx1bvuJACj5AZwohAMg3Nxs7UCEUGxVUi2oo7FtwmiO0VPzMZeqMuhqXfixHcke3MNQgMmrPPguOWC8g=
X-Received: by 2002:a05:6638:36f0:b0:38a:3978:f014 with SMTP id
 t48-20020a05663836f000b0038a3978f014mr4116496jau.32.1670266828145; Mon, 05
 Dec 2022 11:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20221018020227.85905-1-namhyung@kernel.org> <20221018020227.85905-19-namhyung@kernel.org>
 <153310C5-413D-4079-9970-EDCEE2DF3340@linux.vnet.ibm.com>
In-Reply-To: <153310C5-413D-4079-9970-EDCEE2DF3340@linux.vnet.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 5 Dec 2022 11:00:16 -0800
Message-ID: <CAM9d7chxwxx+CuekO+6F8PcUveFTKhDL-aZdCfVwttfyyu-ecg@mail.gmail.com>
Subject: Re: [PATCH 18/20] perf stat: Display event stats using aggr counts
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Dec 5, 2022 at 2:52 AM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 18-Oct-2022, at 7:32 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Now aggr counts are ready for use.  Convert the display routines to use
> > the aggr counts and update the shadow stat with them.  It doesn't need
> > to aggregate counts or collect aliases anymore during the display.  Get
> > rid of now unused struct perf_aggr_thread_value.
> >
> > Note that there's a difference in the display order among the aggr mode.
> > For per-core/die/socket/node aggregation, it shows relevant events in
> > the same unit together, whereas global/thread/no aggregation it shows
> > the same events for different units together.  So it still uses separate
> > codes to display them due to the ordering.
> >
> > One more thing to note is that it breaks per-core event display for now.
> > The next patch will fix it to have identical output as of now.
> >
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > tools/perf/util/stat-display.c | 421 ++++-----------------------------
> > tools/perf/util/stat.c         |   5 -
> > tools/perf/util/stat.h         |   9 -
> > 3 files changed, 49 insertions(+), 386 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 4113aa86772f..bfae2784609c 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -442,31 +442,6 @@ static void print_metric_header(struct perf_stat_config *config,
> >               fprintf(os->fh, "%*s ", config->metric_only_len, unit);
> > }
> >
> > -static int first_shadow_map_idx(struct perf_stat_config *config,
> > -                             struct evsel *evsel, const struct aggr_cpu_id *id)
> > -{
> > -     struct perf_cpu_map *cpus = evsel__cpus(evsel);
> > -     struct perf_cpu cpu;
> > -     int idx;
> > -
> > -     if (config->aggr_mode == AGGR_NONE)
> > -             return perf_cpu_map__idx(cpus, id->cpu);
> > -
> > -     if (config->aggr_mode == AGGR_THREAD)
> > -             return id->thread_idx;
> > -
> > -     if (!config->aggr_get_id)
> > -             return 0;
> > -
> > -     perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> > -             struct aggr_cpu_id cpu_id = config->aggr_get_id(config, cpu);
> > -
> > -             if (aggr_cpu_id__equal(&cpu_id, id))
> > -                     return idx;
> > -     }
> > -     return 0;
> > -}
> > -
> > static void abs_printout(struct perf_stat_config *config,
> >                        struct aggr_cpu_id id, int nr, struct evsel *evsel, double avg)
> > {
> > @@ -537,7 +512,7 @@ static bool is_mixed_hw_group(struct evsel *counter)
> > static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int nr,
> >                    struct evsel *counter, double uval,
> >                    char *prefix, u64 run, u64 ena, double noise,
> > -                  struct runtime_stat *st)
> > +                  struct runtime_stat *st, int map_idx)
> > {
> >       struct perf_stat_output_ctx out;
> >       struct outstate os = {
> > @@ -648,8 +623,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
> >               print_running(config, run, ena);
> >       }
> >
> > -     perf_stat__print_shadow_stats(config, counter, uval,
> > -                             first_shadow_map_idx(config, counter, &id),
> > +     perf_stat__print_shadow_stats(config, counter, uval, map_idx,
> >                               &out, &config->metric_events, st);
> >       if (!config->csv_output && !config->metric_only && !config->json_output) {
> >               print_noise(config, counter, noise);
> > @@ -657,34 +631,6 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
> >       }
> > }
> >
> > -static void aggr_update_shadow(struct perf_stat_config *config,
> > -                            struct evlist *evlist)
> > -{
> > -     int idx, s;
> > -     struct perf_cpu cpu;
> > -     struct aggr_cpu_id s2, id;
> > -     u64 val;
> > -     struct evsel *counter;
> > -     struct perf_cpu_map *cpus;
> > -
> > -     for (s = 0; s < config->aggr_map->nr; s++) {
> > -             id = config->aggr_map->map[s];
> > -             evlist__for_each_entry(evlist, counter) {
> > -                     cpus = evsel__cpus(counter);
> > -                     val = 0;
> > -                     perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> > -                             s2 = config->aggr_get_id(config, cpu);
> > -                             if (!aggr_cpu_id__equal(&s2, &id))
> > -                                     continue;
> > -                             val += perf_counts(counter->counts, idx, 0)->val;
> > -                     }
> > -                     perf_stat__update_shadow_stats(counter, val,
> > -                                     first_shadow_map_idx(config, counter, &id),
> > -                                     &rt_stat);
> > -             }
> > -     }
> > -}
> > -
> > static void uniquify_event_name(struct evsel *counter)
> > {
> >       char *new_name;
> > @@ -721,137 +667,51 @@ static void uniquify_event_name(struct evsel *counter)
> >       counter->uniquified_name = true;
> > }
> >
> > -static void collect_all_aliases(struct perf_stat_config *config, struct evsel *counter,
> > -                         void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
> > -                                    bool first),
> > -                         void *data)
> > +static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_config *config)
> > {
> > -     struct evlist *evlist = counter->evlist;
> > -     struct evsel *alias;
> > -
> > -     alias = list_prepare_entry(counter, &(evlist->core.entries), core.node);
> > -     list_for_each_entry_continue (alias, &evlist->core.entries, core.node) {
> > -             /* Merge events with the same name, etc. but on different PMUs. */
> > -             if (!strcmp(evsel__name(alias), evsel__name(counter)) &&
> > -                     alias->scale == counter->scale &&
> > -                     alias->cgrp == counter->cgrp &&
> > -                     !strcmp(alias->unit, counter->unit) &&
> > -                     evsel__is_clock(alias) == evsel__is_clock(counter) &&
> > -                     strcmp(alias->pmu_name, counter->pmu_name)) {
> > -                     alias->merged_stat = true;
> > -                     cb(config, alias, data, false);
> > -             }
> > -     }
> > +     return evsel__is_hybrid(evsel) && !config->hybrid_merge;
> > }
> >
> > -static bool hybrid_merge(struct evsel *counter, struct perf_stat_config *config,
> > -                      bool check)
> > +static void uniquify_counter(struct perf_stat_config *config, struct evsel *counter)
> > {
> > -     if (evsel__is_hybrid(counter)) {
> > -             if (check)
> > -                     return config->hybrid_merge;
> > -             else
> > -                     return !config->hybrid_merge;
> > -     }
> > -
> > -     return false;
> > -}
> > -
> > -static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
> > -                         void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
> > -                                    bool first),
> > -                         void *data)
> > -{
> > -     if (counter->merged_stat)
> > -             return false;
> > -     cb(config, counter, data, true);
> > -     if (config->no_merge || hybrid_merge(counter, config, false))
> > +     if (config->no_merge || hybrid_uniquify(counter, config))
> >               uniquify_event_name(counter);
> > -     else if (counter->auto_merge_stats || hybrid_merge(counter, config, true))
> > -             collect_all_aliases(config, counter, cb, data);
> > -     return true;
> > -}
> > -
> > -struct aggr_data {
> > -     u64 ena, run, val;
> > -     struct aggr_cpu_id id;
> > -     int nr;
> > -     int cpu_map_idx;
> > -};
> > -
> > -static void aggr_cb(struct perf_stat_config *config,
> > -                 struct evsel *counter, void *data, bool first)
> > -{
> > -     struct aggr_data *ad = data;
> > -     int idx;
> > -     struct perf_cpu cpu;
> > -     struct perf_cpu_map *cpus;
> > -     struct aggr_cpu_id s2;
> > -
> > -     cpus = evsel__cpus(counter);
> > -     perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> > -             struct perf_counts_values *counts;
> > -
> > -             s2 = config->aggr_get_id(config, cpu);
> > -             if (!aggr_cpu_id__equal(&s2, &ad->id))
> > -                     continue;
> > -             if (first)
> > -                     ad->nr++;
> > -             counts = perf_counts(counter->counts, idx, 0);
> > -             /*
> > -              * When any result is bad, make them all to give
> > -              * consistent output in interval mode.
> > -              */
> > -             if (counts->ena == 0 || counts->run == 0 ||
> > -                 counter->counts->scaled == -1) {
> > -                     ad->ena = 0;
> > -                     ad->run = 0;
> > -                     break;
> > -             }
> > -             ad->val += counts->val;
> > -             ad->ena += counts->ena;
> > -             ad->run += counts->run;
> > -     }
> > }
> >
> > static void print_counter_aggrdata(struct perf_stat_config *config,
> >                                  struct evsel *counter, int s,
> >                                  char *prefix, bool metric_only,
> > -                                bool *first, struct perf_cpu cpu)
> > +                                bool *first)
> > {
> > -     struct aggr_data ad;
> >       FILE *output = config->output;
> >       u64 ena, run, val;
> > -     int nr;
> > -     struct aggr_cpu_id id;
> >       double uval;
> > +     struct perf_stat_evsel *ps = counter->stats;
> > +     struct perf_stat_aggr *aggr = &ps->aggr[s];
> > +     struct aggr_cpu_id id = config->aggr_map->map[s];
> > +     double avg = aggr->counts.val;
> >
> > -     ad.id = id = config->aggr_map->map[s];
> > -     ad.val = ad.ena = ad.run = 0;
> > -     ad.nr = 0;
> > -     if (!collect_data(config, counter, aggr_cb, &ad))
> > +     if (counter->supported && aggr->nr == 0)
> >               return;
>
> Hi Namhyung,
>
> Observed one issue with this change in tmp.perf/core branch of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> Patch link: https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core&id=91f85f98da7ab8c32105f42dd03884c01ec4498f
>
> If we have multiple events in a group and if all events in that group can't go in at once, the group will fail to schedule.
> The perf stat result used to have status of all events in group.
>
> Example result from powerpc:
>         # perf stat -e '{r1001e,r401e0,r4c010}' <workload>
>         Performance counter stats for 'workload’:
>
>              <not counted>      r1001e
>              <not counted>      r401e0
>            <not supported>      r4c010
>
> But after this change, it shows only the event which broke the constraint.
>
>         # ./perf stat -e '{r1001e,r401e0,r4c010}' <workload>
>         Performance counter stats for 'workload’:
>         <not supported>      r4c010
>
> The new condition added by the patch is:
>
>         if (counter->supported && aggr->nr == 0)
>                         return;
>
>
> The first two events r1001e and r401e0 are good to go in this group, hence
> counter->supported  is true where as aggr->nr is zero since this group is
> not scheduled. Since counter->supported is false for third event which
> broke the group constraint, the condition won't return and hence only prints
> this event in output.
>
> Namhyung, is there any scenario because of which this condition was added ?
> If not I would go ahead and sent a fix patch to remove this check.

I remember it's for AGGR_THREAD and merged (uncore) aliases and hybrid
events.  In system-wide per-thread mode, many of them would get 0 results
and we'd like to skip them.  And now I see that we have evsel->merged_stat
check already.

Maybe we could just add the aggr_mode check there.

Thanks,
Namhyung
