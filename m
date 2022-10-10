Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF8F5FA8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJJXjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJJXjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:39:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5E71731
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:39:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so9372809wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t7Nbch5IwodOmf2QEJC+2Q5MLS7RnvdjlCcS2e8CJaA=;
        b=rme9b9HuLtyuazhyWGX9BLUWvrLLfId+MExcfTIcxYMnMQLDRey+l6Jh9y4GihOmM/
         58lpxMkm23MauCd+CcPw0qF6DlAeYRR2q3Lj+d0GNK2AMascY5HooOlLqxIJytZQ6CWE
         UhViUqXmOZVtORQ3Uzaj1ZUF7CiT6LGwLi5cXyeF/Ms+L49mtxR0mP0y8n2Dgj23JgE4
         8lOmtQ/VSo1Gjx7TkqdKcZqzwLjGffTDC9wizbnnakTXJAHMrBwofrOOZ2ZFCMcFmsOu
         PQBtr7ASBg8Hocb8VTmy29qCyWZmxrUfOWQ1p0xXmntPp9Qw6UQ9UId4i7TTE/8H1X1p
         9plA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7Nbch5IwodOmf2QEJC+2Q5MLS7RnvdjlCcS2e8CJaA=;
        b=r0iKa3Ez2OEBG5K74dKQU38UyuoNndKcYgRDYL6xFZZHM0N3117FjAFdKpg6oT2jUO
         75krnxbs0aIRHL2TXwBFQkUpUNOD3DYln3sg2fLM53B4TzDvaCLCo+2rNGHAQyR5YI64
         W5x+7b+bK6/LVzH0ogmmeeBJIaK3eSjAiTcIUrJVClFMwSu8A8fo6LTSDNsJsQWTjRlu
         FXtxIme+YHzC8bCAc89IF44eIFgbB2QqIScxWvsq/4lqFC3Lt9plTJblQi+S5S5bNLDq
         0DJN2XmonZC5qIlKsXjzR+iHe+Vefztjx3+E05vhgbfAZuHDQEZU4eeAZIHlIMpMPTL2
         mqdg==
X-Gm-Message-State: ACrzQf0N7M2I6hkfkEIaGuQ6CvhUOIJR6f4UePawwMsrvJ2VMnuPzCNu
        iM1MFdDMgYmh9lHjABJOzqvBVDs10saYO695zsXCcg==
X-Google-Smtp-Source: AMsMyM5ZBEV8MOCREobhFlyleBQK7jbkXXpn3zEliXWv3785fIF7xmuDVGaq4OsQa5vdcsHXQle9Gi4AjP+O7F1sayQ=
X-Received: by 2002:a7b:c048:0:b0:3b4:fb26:f0f3 with SMTP id
 u8-20020a7bc048000000b003b4fb26f0f3mr22263515wmc.115.1665445140234; Mon, 10
 Oct 2022 16:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-18-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-18-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:38:48 -0700
Message-ID: <CAP-5=fWgpoAkTPHxy+wjsbtd23A_bMWibT6Eg8af+WBWeQskZQ@mail.gmail.com>
Subject: Re: [PATCH 17/19] perf stat: Display event stats using aggr counts
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Now aggr counts are ready for use.  Convert the display routines to use
> the aggr counts and update the shadow stat with them.  It doesn't need
> to aggregate counts or collect aliases anymore during the display.  Get
> rid of now unused struct perf_aggr_thread_value.
>
> Note that there's a difference in the display order among the aggr mode.
> For per-core/die/socket/node aggregation, it shows relevant events in
> the same unit together, whereas global/thread/no aggregation it shows
> the same events for different units together.  So it still uses separate
> codes to display them due to the ordering.
>
> One more thing to note is that it breaks per-core event display for now.
> The next patch will fix it to have identical output as of now.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 428 +++++----------------------------
>  tools/perf/util/stat.c         |   5 -
>  tools/perf/util/stat.h         |   9 -
>  3 files changed, 55 insertions(+), 387 deletions(-)

Nice!

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 1d8e585df4ad..0c0e22c175a1 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -442,31 +442,6 @@ static void print_metric_header(struct perf_stat_config *config,
>                 fprintf(os->fh, "%*s ", config->metric_only_len, unit);
>  }
>
> -static int first_shadow_map_idx(struct perf_stat_config *config,
> -                               struct evsel *evsel, const struct aggr_cpu_id *id)
> -{
> -       struct perf_cpu_map *cpus = evsel__cpus(evsel);
> -       struct perf_cpu cpu;
> -       int idx;
> -
> -       if (config->aggr_mode == AGGR_NONE)
> -               return perf_cpu_map__idx(cpus, id->cpu);
> -
> -       if (config->aggr_mode == AGGR_THREAD)
> -               return id->thread_idx;
> -
> -       if (!config->aggr_get_id)
> -               return 0;
> -
> -       perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -               struct aggr_cpu_id cpu_id = config->aggr_get_id(config, cpu);
> -
> -               if (aggr_cpu_id__equal(&cpu_id, id))
> -                       return idx;
> -       }
> -       return 0;
> -}
> -
>  static void abs_printout(struct perf_stat_config *config,
>                          struct aggr_cpu_id id, int nr, struct evsel *evsel, double avg)
>  {
> @@ -537,7 +512,7 @@ static bool is_mixed_hw_group(struct evsel *counter)
>  static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int nr,
>                      struct evsel *counter, double uval,
>                      char *prefix, u64 run, u64 ena, double noise,
> -                    struct runtime_stat *st)
> +                    struct runtime_stat *st, int map_idx)
>  {
>         struct perf_stat_output_ctx out;
>         struct outstate os = {
> @@ -648,8 +623,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>                 print_running(config, run, ena);
>         }
>
> -       perf_stat__print_shadow_stats(config, counter, uval,
> -                               first_shadow_map_idx(config, counter, &id),
> +       perf_stat__print_shadow_stats(config, counter, uval, map_idx,
>                                 &out, &config->metric_events, st);
>         if (!config->csv_output && !config->metric_only && !config->json_output) {
>                 print_noise(config, counter, noise);
> @@ -657,34 +631,6 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>         }
>  }
>
> -static void aggr_update_shadow(struct perf_stat_config *config,
> -                              struct evlist *evlist)
> -{
> -       int idx, s;
> -       struct perf_cpu cpu;
> -       struct aggr_cpu_id s2, id;
> -       u64 val;
> -       struct evsel *counter;
> -       struct perf_cpu_map *cpus;
> -
> -       for (s = 0; s < config->aggr_map->nr; s++) {
> -               id = config->aggr_map->map[s];
> -               evlist__for_each_entry(evlist, counter) {
> -                       cpus = evsel__cpus(counter);
> -                       val = 0;
> -                       perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -                               s2 = config->aggr_get_id(config, cpu);
> -                               if (!aggr_cpu_id__equal(&s2, &id))
> -                                       continue;
> -                               val += perf_counts(counter->counts, idx, 0)->val;
> -                       }
> -                       perf_stat__update_shadow_stats(counter, val,
> -                                       first_shadow_map_idx(config, counter, &id),
> -                                       &rt_stat);
> -               }
> -       }
> -}
> -
>  static void uniquify_event_name(struct evsel *counter)
>  {
>         char *new_name;
> @@ -721,137 +667,51 @@ static void uniquify_event_name(struct evsel *counter)
>         counter->uniquified_name = true;
>  }
>
> -static void collect_all_aliases(struct perf_stat_config *config, struct evsel *counter,
> -                           void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
> -                                      bool first),
> -                           void *data)
> -{
> -       struct evlist *evlist = counter->evlist;
> -       struct evsel *alias;
> -
> -       alias = list_prepare_entry(counter, &(evlist->core.entries), core.node);
> -       list_for_each_entry_continue (alias, &evlist->core.entries, core.node) {
> -               /* Merge events with the same name, etc. but on different PMUs. */
> -               if (!strcmp(evsel__name(alias), evsel__name(counter)) &&
> -                       alias->scale == counter->scale &&
> -                       alias->cgrp == counter->cgrp &&
> -                       !strcmp(alias->unit, counter->unit) &&
> -                       evsel__is_clock(alias) == evsel__is_clock(counter) &&
> -                       strcmp(alias->pmu_name, counter->pmu_name)) {
> -                       alias->merged_stat = true;
> -                       cb(config, alias, data, false);
> -               }
> -       }
> -}
> -
> -static bool hybrid_merge(struct evsel *counter, struct perf_stat_config *config,
> -                        bool check)
> +static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_config *config)
>  {
> -       if (evsel__is_hybrid(counter)) {
> -               if (check)
> -                       return config->hybrid_merge;
> -               else
> -                       return !config->hybrid_merge;
> -       }
> -
> -       return false;
> +       return evsel__is_hybrid(evsel) && !config->hybrid_merge;
>  }
>
> -static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
> -                           void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
> -                                      bool first),
> -                           void *data)
> +static void uniquify_counter(struct perf_stat_config *config, struct evsel *counter)
>  {
> -       if (counter->merged_stat)
> -               return false;
> -       cb(config, counter, data, true);
> -       if (config->no_merge || hybrid_merge(counter, config, false))
> +       if (config->no_merge || hybrid_uniquify(counter, config))
>                 uniquify_event_name(counter);
> -       else if (counter->auto_merge_stats || hybrid_merge(counter, config, true))
> -               collect_all_aliases(config, counter, cb, data);
> -       return true;
> -}
> -
> -struct aggr_data {
> -       u64 ena, run, val;
> -       struct aggr_cpu_id id;
> -       int nr;
> -       int cpu_map_idx;
> -};
> -
> -static void aggr_cb(struct perf_stat_config *config,
> -                   struct evsel *counter, void *data, bool first)
> -{
> -       struct aggr_data *ad = data;
> -       int idx;
> -       struct perf_cpu cpu;
> -       struct perf_cpu_map *cpus;
> -       struct aggr_cpu_id s2;
> -
> -       cpus = evsel__cpus(counter);
> -       perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -               struct perf_counts_values *counts;
> -
> -               s2 = config->aggr_get_id(config, cpu);
> -               if (!aggr_cpu_id__equal(&s2, &ad->id))
> -                       continue;
> -               if (first)
> -                       ad->nr++;
> -               counts = perf_counts(counter->counts, idx, 0);
> -               /*
> -                * When any result is bad, make them all to give
> -                * consistent output in interval mode.
> -                */
> -               if (counts->ena == 0 || counts->run == 0 ||
> -                   counter->counts->scaled == -1) {
> -                       ad->ena = 0;
> -                       ad->run = 0;
> -                       break;
> -               }
> -               ad->val += counts->val;
> -               ad->ena += counts->ena;
> -               ad->run += counts->run;
> -       }
>  }
>
>  static void print_counter_aggrdata(struct perf_stat_config *config,
>                                    struct evsel *counter, int s,
>                                    char *prefix, bool metric_only,
> -                                  bool *first, struct perf_cpu cpu)
> +                                  bool *first)
>  {
> -       struct aggr_data ad;
>         FILE *output = config->output;
>         u64 ena, run, val;
> -       int nr;
> -       struct aggr_cpu_id id;
>         double uval;
> +       struct perf_stat_evsel *ps = counter->stats;
> +       struct perf_stat_aggr *aggr = &ps->aggr[s];
> +       struct aggr_cpu_id id = config->aggr_map->map[s];
> +       double avg = aggr->counts.val;
>
> -       ad.id = id = config->aggr_map->map[s];
> -       ad.val = ad.ena = ad.run = 0;
> -       ad.nr = 0;
> -       if (!collect_data(config, counter, aggr_cb, &ad))
> +       if (aggr->nr == 0)
>                 return;
>
> -       if (perf_pmu__has_hybrid() && ad.ena == 0)
> -               return;
> +       uniquify_counter(config, counter);
> +
> +       val = aggr->counts.val;
> +       ena = aggr->counts.ena;
> +       run = aggr->counts.run;
>
> -       nr = ad.nr;
> -       ena = ad.ena;
> -       run = ad.run;
> -       val = ad.val;
>         if (*first && metric_only) {
>                 *first = false;
> -               aggr_printout(config, counter, id, nr);
> +               aggr_printout(config, counter, id, aggr->nr);
>         }
>         if (prefix && !metric_only)
>                 fprintf(output, "%s", prefix);
>
>         uval = val * counter->scale;
> -       if (cpu.cpu != -1)
> -               id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
>
> -       printout(config, id, nr, counter, uval,
> -                prefix, run, ena, 1.0, &rt_stat);
> +       printout(config, id, aggr->nr, counter, uval,
> +                prefix, run, ena, avg, &rt_stat, s);
> +
>         if (!metric_only)
>                 fputc('\n', output);
>  }
> @@ -869,8 +729,6 @@ static void print_aggr(struct perf_stat_config *config,
>         if (!config->aggr_map || !config->aggr_get_id)
>                 return;
>
> -       aggr_update_shadow(config, evlist);
> -
>         /*
>          * With metric_only everything is on a single line.
>          * Without each counter has its own line.
> @@ -881,188 +739,39 @@ static void print_aggr(struct perf_stat_config *config,
>
>                 first = true;
>                 evlist__for_each_entry(evlist, counter) {
> +                       if (counter->merged_stat)
> +                               continue;
> +
>                         print_counter_aggrdata(config, counter, s,
> -                                       prefix, metric_only,
> -                                       &first, (struct perf_cpu){ .cpu = -1 });
> +                                              prefix, metric_only,
> +                                              &first);
>                 }
>                 if (metric_only)
>                         fputc('\n', output);
>         }
>  }
>
> -static int cmp_val(const void *a, const void *b)
> -{
> -       return ((struct perf_aggr_thread_value *)b)->val -
> -               ((struct perf_aggr_thread_value *)a)->val;
> -}
> -
> -static struct perf_aggr_thread_value *sort_aggr_thread(
> -                                       struct evsel *counter,
> -                                       int *ret,
> -                                       struct target *_target)
> -{
> -       int nthreads = perf_thread_map__nr(counter->core.threads);
> -       int i = 0;
> -       double uval;
> -       struct perf_aggr_thread_value *buf;
> -
> -       buf = calloc(nthreads, sizeof(struct perf_aggr_thread_value));
> -       if (!buf)
> -               return NULL;
> -
> -       for (int thread = 0; thread < nthreads; thread++) {
> -               int idx;
> -               u64 ena = 0, run = 0, val = 0;
> -
> -               perf_cpu_map__for_each_idx(idx, evsel__cpus(counter)) {
> -                       struct perf_counts_values *counts =
> -                               perf_counts(counter->counts, idx, thread);
> -
> -                       val += counts->val;
> -                       ena += counts->ena;
> -                       run += counts->run;
> -               }
> -
> -               uval = val * counter->scale;
> -
> -               /*
> -                * Skip value 0 when enabling --per-thread globally,
> -                * otherwise too many 0 output.
> -                */
> -               if (uval == 0.0 && target__has_per_thread(_target))
> -                       continue;
> -
> -               buf[i].counter = counter;
> -               buf[i].id = aggr_cpu_id__empty();
> -               buf[i].id.thread_idx = thread;
> -               buf[i].uval = uval;
> -               buf[i].val = val;
> -               buf[i].run = run;
> -               buf[i].ena = ena;
> -               i++;
> -       }
> -
> -       qsort(buf, i, sizeof(struct perf_aggr_thread_value), cmp_val);
> -
> -       if (ret)
> -               *ret = i;
> -
> -       return buf;
> -}
> -
> -static void print_aggr_thread(struct perf_stat_config *config,
> -                             struct target *_target,
> -                             struct evsel *counter, char *prefix)
> -{
> -       FILE *output = config->output;
> -       int thread, sorted_threads;
> -       struct aggr_cpu_id id;
> -       struct perf_aggr_thread_value *buf;
> -
> -       buf = sort_aggr_thread(counter, &sorted_threads, _target);
> -       if (!buf) {
> -               perror("cannot sort aggr thread");
> -               return;
> -       }
> -
> -       for (thread = 0; thread < sorted_threads; thread++) {
> -               if (prefix)
> -                       fprintf(output, "%s", prefix);
> -
> -               id = buf[thread].id;
> -               printout(config, id, 0, buf[thread].counter, buf[thread].uval,
> -                        prefix, buf[thread].run, buf[thread].ena, 1.0,
> -                        &rt_stat);
> -               fputc('\n', output);
> -       }
> -
> -       free(buf);
> -}
> -
> -struct caggr_data {
> -       double avg, avg_enabled, avg_running;
> -};
> -
> -static void counter_aggr_cb(struct perf_stat_config *config __maybe_unused,
> -                           struct evsel *counter, void *data,
> -                           bool first __maybe_unused)
> -{
> -       struct caggr_data *cd = data;
> -       struct perf_counts_values *aggr = &counter->counts->aggr;
> -
> -       cd->avg += aggr->val;
> -       cd->avg_enabled += aggr->ena;
> -       cd->avg_running += aggr->run;
> -}
> -
> -/*
> - * Print out the results of a single counter:
> - * aggregated counts in system-wide mode
> - */
> -static void print_counter_aggr(struct perf_stat_config *config,
> -                              struct evsel *counter, char *prefix)
> -{
> -       bool metric_only = config->metric_only;
> -       FILE *output = config->output;
> -       double uval;
> -       struct caggr_data cd = { .avg = 0.0 };
> -
> -       if (!collect_data(config, counter, counter_aggr_cb, &cd))
> -               return;
> -
> -       if (prefix && !metric_only)
> -               fprintf(output, "%s", prefix);
> -
> -       uval = cd.avg * counter->scale;
> -       printout(config, aggr_cpu_id__empty(), 0, counter, uval, prefix, cd.avg_running,
> -                cd.avg_enabled, cd.avg, &rt_stat);
> -       if (!metric_only)
> -               fprintf(output, "\n");
> -}
> -
> -static void counter_cb(struct perf_stat_config *config __maybe_unused,
> -                      struct evsel *counter, void *data,
> -                      bool first __maybe_unused)
> -{
> -       struct aggr_data *ad = data;
> -
> -       ad->val += perf_counts(counter->counts, ad->cpu_map_idx, 0)->val;
> -       ad->ena += perf_counts(counter->counts, ad->cpu_map_idx, 0)->ena;
> -       ad->run += perf_counts(counter->counts, ad->cpu_map_idx, 0)->run;
> -}
> -
> -/*
> - * Print out the results of a single counter:
> - * does not use aggregated count in system-wide
> - */
>  static void print_counter(struct perf_stat_config *config,
>                           struct evsel *counter, char *prefix)
>  {
> +       bool metric_only = config->metric_only;
>         FILE *output = config->output;
> -       u64 ena, run, val;
> -       double uval;
> -       int idx;
> -       struct perf_cpu cpu;
> -       struct aggr_cpu_id id;
> -
> -       perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
> -               struct aggr_data ad = { .cpu_map_idx = idx };
> -
> -               if (!collect_data(config, counter, counter_cb, &ad))
> -                       return;
> -               val = ad.val;
> -               ena = ad.ena;
> -               run = ad.run;
> +       bool first = false;
> +       int s;
>
> -               if (prefix)
> -                       fprintf(output, "%s", prefix);
> +       /* AGGR_THREAD doesn't have config->aggr_get_id */
> +       if (!config->aggr_map)
> +               return;
>
> -               uval = val * counter->scale;
> -               id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
> -               printout(config, id, 0, counter, uval, prefix,
> -                        run, ena, 1.0, &rt_stat);
> +       if (counter->merged_stat)
> +               return;
>
> -               fputc('\n', output);
> +       for (s = 0; s < config->aggr_map->nr; s++) {
> +               print_counter_aggrdata(config, counter, s,
> +                                      prefix, metric_only,
> +                                      &first);
> +               if (metric_only)
> +                       fputc('\n', output);
>         }
>  }
>
> @@ -1081,6 +790,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>                         u64 ena, run, val;
>                         double uval;
>                         struct aggr_cpu_id id;
> +                       struct perf_stat_evsel *ps = counter->stats;
>                         int counter_idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
>
>                         if (counter_idx < 0)
> @@ -1093,13 +803,13 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>                                 aggr_printout(config, counter, id, 0);
>                                 first = false;
>                         }
> -                       val = perf_counts(counter->counts, counter_idx, 0)->val;
> -                       ena = perf_counts(counter->counts, counter_idx, 0)->ena;
> -                       run = perf_counts(counter->counts, counter_idx, 0)->run;
> +                       val = ps->aggr[counter_idx].counts.val;
> +                       ena = ps->aggr[counter_idx].counts.ena;
> +                       run = ps->aggr[counter_idx].counts.run;
>
>                         uval = val * counter->scale;
>                         printout(config, id, 0, counter, uval, prefix,
> -                                run, ena, 1.0, &rt_stat);
> +                                run, ena, 1.0, &rt_stat, counter_idx);
>                 }
>                 if (!first)
>                         fputc('\n', config->output);
> @@ -1135,8 +845,8 @@ static void print_metric_headers(struct perf_stat_config *config,
>         };
>         bool first = true;
>
> -               if (config->json_output && !config->interval)
> -                       fprintf(config->output, "{");
> +       if (config->json_output && !config->interval)
> +               fprintf(config->output, "{");
>
>         if (prefix && !config->json_output)
>                 fprintf(config->output, "%s", prefix);
> @@ -1379,31 +1089,6 @@ static void print_footer(struct perf_stat_config *config)
>                         "the same PMU. Try reorganizing the group.\n");
>  }
>
> -static void print_percore_thread(struct perf_stat_config *config,
> -                                struct evsel *counter, char *prefix)
> -{
> -       int s;
> -       struct aggr_cpu_id s2, id;
> -       struct perf_cpu_map *cpus;
> -       bool first = true;
> -       int idx;
> -       struct perf_cpu cpu;
> -
> -       cpus = evsel__cpus(counter);
> -       perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> -               s2 = config->aggr_get_id(config, cpu);
> -               for (s = 0; s < config->aggr_map->nr; s++) {
> -                       id = config->aggr_map->map[s];
> -                       if (aggr_cpu_id__equal(&s2, &id))
> -                               break;
> -               }
> -
> -               print_counter_aggrdata(config, counter, s,
> -                                      prefix, false,
> -                                      &first, cpu);
> -       }
> -}
> -
>  static void print_percore(struct perf_stat_config *config,
>                           struct evsel *counter, char *prefix)
>  {
> @@ -1416,15 +1101,14 @@ static void print_percore(struct perf_stat_config *config,
>                 return;
>
>         if (config->percore_show_thread)
> -               return print_percore_thread(config, counter, prefix);
> +               return print_counter(config, counter, prefix);
>
>         for (s = 0; s < config->aggr_map->nr; s++) {
>                 if (prefix && metric_only)
>                         fprintf(output, "%s", prefix);
>
>                 print_counter_aggrdata(config, counter, s,
> -                               prefix, metric_only,
> -                               &first, (struct perf_cpu){ .cpu = -1 });
> +                                      prefix, metric_only, &first);
>         }
>
>         if (metric_only)
> @@ -1469,16 +1153,14 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>                 print_aggr(config, evlist, prefix);
>                 break;
>         case AGGR_THREAD:
> -               evlist__for_each_entry(evlist, counter) {
> -                       print_aggr_thread(config, _target, counter, prefix);
> -               }
> -               break;
>         case AGGR_GLOBAL:
> -               if (config->iostat_run)
> +               if (config->iostat_run) {
>                         iostat_print_counters(evlist, config, ts, prefix = buf,
> -                                             print_counter_aggr);
> -               else
> -                       print_aggr(config, evlist, prefix);
> +                                             print_counter);
> +                       break;
> +               }
> +               evlist__for_each_entry(evlist, counter)
> +                       print_counter(config, counter, prefix);
>                 break;
>         case AGGR_NONE:
>                 if (metric_only)
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index f2a3761dacff..1652586a4925 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -545,11 +545,6 @@ int perf_stat_process_counter(struct perf_stat_config *config,
>                         evsel__name(counter), count[0], count[1], count[2]);
>         }
>
> -       /*
> -        * Save the full runtime - to allow normalization during printout:
> -        */
> -       perf_stat__update_shadow_stats(counter, *count, 0, &rt_stat);
> -
>         return 0;
>  }
>
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index e51214918c7f..b02d8a4ffabf 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -213,15 +213,6 @@ static inline void update_rusage_stats(struct rusage_stats *ru_stats, struct rus
>  struct evsel;
>  struct evlist;
>
> -struct perf_aggr_thread_value {
> -       struct evsel *counter;
> -       struct aggr_cpu_id id;
> -       double uval;
> -       u64 val;
> -       u64 run;
> -       u64 ena;
> -};
> -
>  bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_id id);
>
>  #define perf_stat_evsel__is(evsel, id) \
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
