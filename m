Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9A7304CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjFNQVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjFNQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:21:10 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AB2109
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:21:05 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f9a81da5d7so292881cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686759665; x=1689351665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkmqlnmRHqtzGkC/8tvvBpNucNEA9zQVsbDjCeH5iuw=;
        b=jzZ/zpt3pECq9E7i00JJEsG+LGjRhlQFG1dSt+vJ43AkNszqF+PY7gQkHoxyoJvRos
         IxqO/aFqZjc+BA2eQgykei3rRZL9HEAFyTK37v6utHpy5y09tLsNJMd8dTQiGi4Zcue0
         ki3Uqnm3QmuWdjhdcvSDgXylrf5JTfbV1qjxX0JTa+QoMrIEiMpSSifXoqql0Epee796
         yIPf4qJpFInLRshqRJVyd5vo5dMLVXMlFXWBwROsSUmWta6wPIj7TTN2WgdkD9eDi7rg
         rnuqJaQ0bbOX5t+LobtPVwmkX24pcWoOpNhRB3ssUnPNHsqjog376n1tUFDng5x2ESz2
         Iw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686759665; x=1689351665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkmqlnmRHqtzGkC/8tvvBpNucNEA9zQVsbDjCeH5iuw=;
        b=lIqTsXTAXNCOC3sNGZCQt/8tPeSK+OaAfyflZ6aAdoiaqSFxirk7lavWg6/s+O9SOM
         NoACwxuIA+UKbgFnv0C6vTL2sgVo0mvuudN7yg+YMr9Kw+XUfSGuuJElZRa2fNa1mwKE
         WHcGbG6eBeZUU5dOP5NZ8X86gDEW8tFipf13ugqFOVx8h08q7OUgbH+ePPhkdJkibwz6
         uAFSRwBzcffJznUfDBDkbg2UpbSk/XxC+93kE8yBWtwoNf/ycy7FsU/6RrfsmxUNzpyx
         closHp+K7qAJImKzjgLb21Vt63unmlkFqqYRQXonNpmdEn5ef6vX2emkAIyGConN4GYa
         ahTQ==
X-Gm-Message-State: AC+VfDxdkrwZfrEQAbcAKfK1i2IU6kUYK5KTlvDmr5zWmX4dpI3o2Dn7
        qdn0rJRQ9CRwy6b0R0jwoOJg+WewQ8f59idyYgU6Yw==
X-Google-Smtp-Source: ACHHUZ4SmCMhqcJhD2ZajX75wil9Dv9DOF8UVR3FW4WWbS9poQ0fXJiKuAfCAtN0SmhNs7bn6nlLoqY89okCJfZZfrY=
X-Received: by 2002:a05:622a:155:b0:3de:1aaa:42f5 with SMTP id
 v21-20020a05622a015500b003de1aaa42f5mr225313qtw.15.1686759664669; Wed, 14 Jun
 2023 09:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221018020227.85905-1-namhyung@kernel.org> <20221018020227.85905-19-namhyung@kernel.org>
 <ZInDSgrOzYSX124p@krava>
In-Reply-To: <ZInDSgrOzYSX124p@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 09:20:53 -0700
Message-ID: <CAP-5=fX2ULvR7KFCwZN4wn1LSQmtJqQk7bK=T=BHdvnHuL=DdA@mail.gmail.com>
Subject: Re: [PATCH 18/20] perf stat: Display event stats using aggr counts
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 6:40=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Oct 17, 2022 at 07:02:25PM -0700, Namhyung Kim wrote:
> > Now aggr counts are ready for use.  Convert the display routines to use
> > the aggr counts and update the shadow stat with them.  It doesn't need
> > to aggregate counts or collect aliases anymore during the display.  Get
> > rid of now unused struct perf_aggr_thread_value.
> >
> > Note that there's a difference in the display order among the aggr mode=
.
> > For per-core/die/socket/node aggregation, it shows relevant events in
> > the same unit together, whereas global/thread/no aggregation it shows
> > the same events for different units together.  So it still uses separat=
e
> > codes to display them due to the ordering.
> >
> > One more thing to note is that it breaks per-core event display for now=
.
> > The next patch will fix it to have identical output as of now.
> >
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> hi,
> this one seems to break 'perf stat -r X' not sure why so far..
>
> final counts seems to be accumulated instead of displaying average, like:
>
>
> with this patch:
>
>          Performance counter stats for './test_progs -n 103/1' (2 runs):
>
>                206,815,929      cycles:u                                 =
                            ( +-  0.05% )
>             16,052,747,533      cycles:k                                 =
                            ( +-  0.10% )
>             16,259,643,167      cycles                                   =
                            ( +-  0.10% )
>
>                    1.98093 +- 0.00586 seconds time elapsed  ( +-  0.30% )
>
>
> without this patch:
>
>          Performance counter stats for './test_progs -n 103/1' (2 runs):
>
>                103,300,812      cycles:u                                 =
                            ( +-  0.37% )
>              8,016,856,866      cycles:k                                 =
                            ( +-  0.32% )
>              8,120,200,572      cycles                                   =
                            ( +-  0.32% )
>
>                    1.97272 +- 0.00270 seconds time elapsed  ( +-  0.14% )
>
>
> any idea? ;-)

Is this still broken in perf-tools-next? The patch is quite old and
there's been work in this area. I'm assuming yes, but thought it was
worth checking.

Thanks,
Ian

> thanks,
> jirka
>
>
>
>
> > ---
> >  tools/perf/util/stat-display.c | 421 ++++-----------------------------
> >  tools/perf/util/stat.c         |   5 -
> >  tools/perf/util/stat.h         |   9 -
> >  3 files changed, 49 insertions(+), 386 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index 4113aa86772f..bfae2784609c 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -442,31 +442,6 @@ static void print_metric_header(struct perf_stat_c=
onfig *config,
> >               fprintf(os->fh, "%*s ", config->metric_only_len, unit);
> >  }
> >
> > -static int first_shadow_map_idx(struct perf_stat_config *config,
> > -                             struct evsel *evsel, const struct aggr_cp=
u_id *id)
> > -{
> > -     struct perf_cpu_map *cpus =3D evsel__cpus(evsel);
> > -     struct perf_cpu cpu;
> > -     int idx;
> > -
> > -     if (config->aggr_mode =3D=3D AGGR_NONE)
> > -             return perf_cpu_map__idx(cpus, id->cpu);
> > -
> > -     if (config->aggr_mode =3D=3D AGGR_THREAD)
> > -             return id->thread_idx;
> > -
> > -     if (!config->aggr_get_id)
> > -             return 0;
> > -
> > -     perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> > -             struct aggr_cpu_id cpu_id =3D config->aggr_get_id(config,=
 cpu);
> > -
> > -             if (aggr_cpu_id__equal(&cpu_id, id))
> > -                     return idx;
> > -     }
> > -     return 0;
> > -}
> > -
> >  static void abs_printout(struct perf_stat_config *config,
> >                        struct aggr_cpu_id id, int nr, struct evsel *evs=
el, double avg)
> >  {
> > @@ -537,7 +512,7 @@ static bool is_mixed_hw_group(struct evsel *counter=
)
> >  static void printout(struct perf_stat_config *config, struct aggr_cpu_=
id id, int nr,
> >                    struct evsel *counter, double uval,
> >                    char *prefix, u64 run, u64 ena, double noise,
> > -                  struct runtime_stat *st)
> > +                  struct runtime_stat *st, int map_idx)
> >  {
> >       struct perf_stat_output_ctx out;
> >       struct outstate os =3D {
> > @@ -648,8 +623,7 @@ static void printout(struct perf_stat_config *confi=
g, struct aggr_cpu_id id, int
> >               print_running(config, run, ena);
> >       }
> >
> > -     perf_stat__print_shadow_stats(config, counter, uval,
> > -                             first_shadow_map_idx(config, counter, &id=
),
> > +     perf_stat__print_shadow_stats(config, counter, uval, map_idx,
> >                               &out, &config->metric_events, st);
> >       if (!config->csv_output && !config->metric_only && !config->json_=
output) {
> >               print_noise(config, counter, noise);
> > @@ -657,34 +631,6 @@ static void printout(struct perf_stat_config *conf=
ig, struct aggr_cpu_id id, int
> >       }
> >  }
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
> > -     for (s =3D 0; s < config->aggr_map->nr; s++) {
> > -             id =3D config->aggr_map->map[s];
> > -             evlist__for_each_entry(evlist, counter) {
> > -                     cpus =3D evsel__cpus(counter);
> > -                     val =3D 0;
> > -                     perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> > -                             s2 =3D config->aggr_get_id(config, cpu);
> > -                             if (!aggr_cpu_id__equal(&s2, &id))
> > -                                     continue;
> > -                             val +=3D perf_counts(counter->counts, idx=
, 0)->val;
> > -                     }
> > -                     perf_stat__update_shadow_stats(counter, val,
> > -                                     first_shadow_map_idx(config, coun=
ter, &id),
> > -                                     &rt_stat);
> > -             }
> > -     }
> > -}
> > -
> >  static void uniquify_event_name(struct evsel *counter)
> >  {
> >       char *new_name;
> > @@ -721,137 +667,51 @@ static void uniquify_event_name(struct evsel *co=
unter)
> >       counter->uniquified_name =3D true;
> >  }
> >
> > -static void collect_all_aliases(struct perf_stat_config *config, struc=
t evsel *counter,
> > -                         void (*cb)(struct perf_stat_config *config, s=
truct evsel *counter, void *data,
> > -                                    bool first),
> > -                         void *data)
> > +static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_conf=
ig *config)
> >  {
> > -     struct evlist *evlist =3D counter->evlist;
> > -     struct evsel *alias;
> > -
> > -     alias =3D list_prepare_entry(counter, &(evlist->core.entries), co=
re.node);
> > -     list_for_each_entry_continue (alias, &evlist->core.entries, core.=
node) {
> > -             /* Merge events with the same name, etc. but on different=
 PMUs. */
> > -             if (!strcmp(evsel__name(alias), evsel__name(counter)) &&
> > -                     alias->scale =3D=3D counter->scale &&
> > -                     alias->cgrp =3D=3D counter->cgrp &&
> > -                     !strcmp(alias->unit, counter->unit) &&
> > -                     evsel__is_clock(alias) =3D=3D evsel__is_clock(cou=
nter) &&
> > -                     strcmp(alias->pmu_name, counter->pmu_name)) {
> > -                     alias->merged_stat =3D true;
> > -                     cb(config, alias, data, false);
> > -             }
> > -     }
> > +     return evsel__is_hybrid(evsel) && !config->hybrid_merge;
> >  }
> >
> > -static bool hybrid_merge(struct evsel *counter, struct perf_stat_confi=
g *config,
> > -                      bool check)
> > +static void uniquify_counter(struct perf_stat_config *config, struct e=
vsel *counter)
> >  {
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
> > -static bool collect_data(struct perf_stat_config *config, struct evsel=
 *counter,
> > -                         void (*cb)(struct perf_stat_config *config, s=
truct evsel *counter, void *data,
> > -                                    bool first),
> > -                         void *data)
> > -{
> > -     if (counter->merged_stat)
> > -             return false;
> > -     cb(config, counter, data, true);
> > -     if (config->no_merge || hybrid_merge(counter, config, false))
> > +     if (config->no_merge || hybrid_uniquify(counter, config))
> >               uniquify_event_name(counter);
> > -     else if (counter->auto_merge_stats || hybrid_merge(counter, confi=
g, true))
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
> > -     struct aggr_data *ad =3D data;
> > -     int idx;
> > -     struct perf_cpu cpu;
> > -     struct perf_cpu_map *cpus;
> > -     struct aggr_cpu_id s2;
> > -
> > -     cpus =3D evsel__cpus(counter);
> > -     perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> > -             struct perf_counts_values *counts;
> > -
> > -             s2 =3D config->aggr_get_id(config, cpu);
> > -             if (!aggr_cpu_id__equal(&s2, &ad->id))
> > -                     continue;
> > -             if (first)
> > -                     ad->nr++;
> > -             counts =3D perf_counts(counter->counts, idx, 0);
> > -             /*
> > -              * When any result is bad, make them all to give
> > -              * consistent output in interval mode.
> > -              */
> > -             if (counts->ena =3D=3D 0 || counts->run =3D=3D 0 ||
> > -                 counter->counts->scaled =3D=3D -1) {
> > -                     ad->ena =3D 0;
> > -                     ad->run =3D 0;
> > -                     break;
> > -             }
> > -             ad->val +=3D counts->val;
> > -             ad->ena +=3D counts->ena;
> > -             ad->run +=3D counts->run;
> > -     }
> >  }
> >
> >  static void print_counter_aggrdata(struct perf_stat_config *config,
> >                                  struct evsel *counter, int s,
> >                                  char *prefix, bool metric_only,
> > -                                bool *first, struct perf_cpu cpu)
> > +                                bool *first)
> >  {
> > -     struct aggr_data ad;
> >       FILE *output =3D config->output;
> >       u64 ena, run, val;
> > -     int nr;
> > -     struct aggr_cpu_id id;
> >       double uval;
> > +     struct perf_stat_evsel *ps =3D counter->stats;
> > +     struct perf_stat_aggr *aggr =3D &ps->aggr[s];
> > +     struct aggr_cpu_id id =3D config->aggr_map->map[s];
> > +     double avg =3D aggr->counts.val;
> >
> > -     ad.id =3D id =3D config->aggr_map->map[s];
> > -     ad.val =3D ad.ena =3D ad.run =3D 0;
> > -     ad.nr =3D 0;
> > -     if (!collect_data(config, counter, aggr_cb, &ad))
> > +     if (counter->supported && aggr->nr =3D=3D 0)
> >               return;
> >
> > -     if (perf_pmu__has_hybrid() && ad.ena =3D=3D 0)
> > -             return;
> > +     uniquify_counter(config, counter);
> > +
> > +     val =3D aggr->counts.val;
> > +     ena =3D aggr->counts.ena;
> > +     run =3D aggr->counts.run;
> >
> > -     nr =3D ad.nr;
> > -     ena =3D ad.ena;
> > -     run =3D ad.run;
> > -     val =3D ad.val;
> >       if (*first && metric_only) {
> >               *first =3D false;
> > -             aggr_printout(config, counter, id, nr);
> > +             aggr_printout(config, counter, id, aggr->nr);
> >       }
> >       if (prefix && !metric_only)
> >               fprintf(output, "%s", prefix);
> >
> >       uval =3D val * counter->scale;
> > -     if (cpu.cpu !=3D -1)
> > -             id =3D aggr_cpu_id__cpu(cpu, /*data=3D*/NULL);
> >
> > -     printout(config, id, nr, counter, uval,
> > -              prefix, run, ena, 1.0, &rt_stat);
> > +     printout(config, id, aggr->nr, counter, uval,
> > +              prefix, run, ena, avg, &rt_stat, s);
> > +
> >       if (!metric_only)
> >               fputc('\n', output);
> >  }
> > @@ -869,8 +729,6 @@ static void print_aggr(struct perf_stat_config *con=
fig,
> >       if (!config->aggr_map || !config->aggr_get_id)
> >               return;
> >
> > -     aggr_update_shadow(config, evlist);
> > -
> >       /*
> >        * With metric_only everything is on a single line.
> >        * Without each counter has its own line.
> > @@ -881,188 +739,36 @@ static void print_aggr(struct perf_stat_config *=
config,
> >
> >               first =3D true;
> >               evlist__for_each_entry(evlist, counter) {
> > +                     if (counter->merged_stat)
> > +                             continue;
> > +
> >                       print_counter_aggrdata(config, counter, s,
> > -                                     prefix, metric_only,
> > -                                     &first, (struct perf_cpu){ .cpu =
=3D -1 });
> > +                                            prefix, metric_only,
> > +                                            &first);
> >               }
> >               if (metric_only)
> >                       fputc('\n', output);
> >       }
> >  }
> >
> > -static int cmp_val(const void *a, const void *b)
> > -{
> > -     return ((struct perf_aggr_thread_value *)b)->val -
> > -             ((struct perf_aggr_thread_value *)a)->val;
> > -}
> > -
> > -static struct perf_aggr_thread_value *sort_aggr_thread(
> > -                                     struct evsel *counter,
> > -                                     int *ret,
> > -                                     struct target *_target)
> > -{
> > -     int nthreads =3D perf_thread_map__nr(counter->core.threads);
> > -     int i =3D 0;
> > -     double uval;
> > -     struct perf_aggr_thread_value *buf;
> > -
> > -     buf =3D calloc(nthreads, sizeof(struct perf_aggr_thread_value));
> > -     if (!buf)
> > -             return NULL;
> > -
> > -     for (int thread =3D 0; thread < nthreads; thread++) {
> > -             int idx;
> > -             u64 ena =3D 0, run =3D 0, val =3D 0;
> > -
> > -             perf_cpu_map__for_each_idx(idx, evsel__cpus(counter)) {
> > -                     struct perf_counts_values *counts =3D
> > -                             perf_counts(counter->counts, idx, thread)=
;
> > -
> > -                     val +=3D counts->val;
> > -                     ena +=3D counts->ena;
> > -                     run +=3D counts->run;
> > -             }
> > -
> > -             uval =3D val * counter->scale;
> > -
> > -             /*
> > -              * Skip value 0 when enabling --per-thread globally,
> > -              * otherwise too many 0 output.
> > -              */
> > -             if (uval =3D=3D 0.0 && target__has_per_thread(_target))
> > -                     continue;
> > -
> > -             buf[i].counter =3D counter;
> > -             buf[i].id =3D aggr_cpu_id__empty();
> > -             buf[i].id.thread_idx =3D thread;
> > -             buf[i].uval =3D uval;
> > -             buf[i].val =3D val;
> > -             buf[i].run =3D run;
> > -             buf[i].ena =3D ena;
> > -             i++;
> > -     }
> > -
> > -     qsort(buf, i, sizeof(struct perf_aggr_thread_value), cmp_val);
> > -
> > -     if (ret)
> > -             *ret =3D i;
> > -
> > -     return buf;
> > -}
> > -
> > -static void print_aggr_thread(struct perf_stat_config *config,
> > -                           struct target *_target,
> > -                           struct evsel *counter, char *prefix)
> > -{
> > -     FILE *output =3D config->output;
> > -     int thread, sorted_threads;
> > -     struct aggr_cpu_id id;
> > -     struct perf_aggr_thread_value *buf;
> > -
> > -     buf =3D sort_aggr_thread(counter, &sorted_threads, _target);
> > -     if (!buf) {
> > -             perror("cannot sort aggr thread");
> > -             return;
> > -     }
> > -
> > -     for (thread =3D 0; thread < sorted_threads; thread++) {
> > -             if (prefix)
> > -                     fprintf(output, "%s", prefix);
> > -
> > -             id =3D buf[thread].id;
> > -             printout(config, id, 0, buf[thread].counter, buf[thread].=
uval,
> > -                      prefix, buf[thread].run, buf[thread].ena, 1.0,
> > -                      &rt_stat);
> > -             fputc('\n', output);
> > -     }
> > -
> > -     free(buf);
> > -}
> > -
> > -struct caggr_data {
> > -     double avg, avg_enabled, avg_running;
> > -};
> > -
> > -static void counter_aggr_cb(struct perf_stat_config *config __maybe_un=
used,
> > -                         struct evsel *counter, void *data,
> > -                         bool first __maybe_unused)
> > -{
> > -     struct caggr_data *cd =3D data;
> > -     struct perf_counts_values *aggr =3D &counter->counts->aggr;
> > -
> > -     cd->avg +=3D aggr->val;
> > -     cd->avg_enabled +=3D aggr->ena;
> > -     cd->avg_running +=3D aggr->run;
> > -}
> > -
> > -/*
> > - * Print out the results of a single counter:
> > - * aggregated counts in system-wide mode
> > - */
> > -static void print_counter_aggr(struct perf_stat_config *config,
> > -                            struct evsel *counter, char *prefix)
> > -{
> > -     bool metric_only =3D config->metric_only;
> > -     FILE *output =3D config->output;
> > -     double uval;
> > -     struct caggr_data cd =3D { .avg =3D 0.0 };
> > -
> > -     if (!collect_data(config, counter, counter_aggr_cb, &cd))
> > -             return;
> > -
> > -     if (prefix && !metric_only)
> > -             fprintf(output, "%s", prefix);
> > -
> > -     uval =3D cd.avg * counter->scale;
> > -     printout(config, aggr_cpu_id__empty(), 0, counter, uval, prefix, =
cd.avg_running,
> > -              cd.avg_enabled, cd.avg, &rt_stat);
> > -     if (!metric_only)
> > -             fprintf(output, "\n");
> > -}
> > -
> > -static void counter_cb(struct perf_stat_config *config __maybe_unused,
> > -                    struct evsel *counter, void *data,
> > -                    bool first __maybe_unused)
> > -{
> > -     struct aggr_data *ad =3D data;
> > -
> > -     ad->val +=3D perf_counts(counter->counts, ad->cpu_map_idx, 0)->va=
l;
> > -     ad->ena +=3D perf_counts(counter->counts, ad->cpu_map_idx, 0)->en=
a;
> > -     ad->run +=3D perf_counts(counter->counts, ad->cpu_map_idx, 0)->ru=
n;
> > -}
> > -
> > -/*
> > - * Print out the results of a single counter:
> > - * does not use aggregated count in system-wide
> > - */
> >  static void print_counter(struct perf_stat_config *config,
> >                         struct evsel *counter, char *prefix)
> >  {
> > -     FILE *output =3D config->output;
> > -     u64 ena, run, val;
> > -     double uval;
> > -     int idx;
> > -     struct perf_cpu cpu;
> > -     struct aggr_cpu_id id;
> > -
> > -     perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
> > -             struct aggr_data ad =3D { .cpu_map_idx =3D idx };
> > -
> > -             if (!collect_data(config, counter, counter_cb, &ad))
> > -                     return;
> > -             val =3D ad.val;
> > -             ena =3D ad.ena;
> > -             run =3D ad.run;
> > +     bool metric_only =3D config->metric_only;
> > +     bool first =3D false;
> > +     int s;
> >
> > -             if (prefix)
> > -                     fprintf(output, "%s", prefix);
> > +     /* AGGR_THREAD doesn't have config->aggr_get_id */
> > +     if (!config->aggr_map)
> > +             return;
> >
> > -             uval =3D val * counter->scale;
> > -             id =3D aggr_cpu_id__cpu(cpu, /*data=3D*/NULL);
> > -             printout(config, id, 0, counter, uval, prefix,
> > -                      run, ena, 1.0, &rt_stat);
> > +     if (counter->merged_stat)
> > +             return;
> >
> > -             fputc('\n', output);
> > +     for (s =3D 0; s < config->aggr_map->nr; s++) {
> > +             print_counter_aggrdata(config, counter, s,
> > +                                    prefix, metric_only,
> > +                                    &first);
> >       }
> >  }
> >
> > @@ -1081,6 +787,7 @@ static void print_no_aggr_metric(struct perf_stat_=
config *config,
> >                       u64 ena, run, val;
> >                       double uval;
> >                       struct aggr_cpu_id id;
> > +                     struct perf_stat_evsel *ps =3D counter->stats;
> >                       int counter_idx =3D perf_cpu_map__idx(evsel__cpus=
(counter), cpu);
> >
> >                       if (counter_idx < 0)
> > @@ -1093,13 +800,13 @@ static void print_no_aggr_metric(struct perf_sta=
t_config *config,
> >                               aggr_printout(config, counter, id, 0);
> >                               first =3D false;
> >                       }
> > -                     val =3D perf_counts(counter->counts, counter_idx,=
 0)->val;
> > -                     ena =3D perf_counts(counter->counts, counter_idx,=
 0)->ena;
> > -                     run =3D perf_counts(counter->counts, counter_idx,=
 0)->run;
> > +                     val =3D ps->aggr[counter_idx].counts.val;
> > +                     ena =3D ps->aggr[counter_idx].counts.ena;
> > +                     run =3D ps->aggr[counter_idx].counts.run;
> >
> >                       uval =3D val * counter->scale;
> >                       printout(config, id, 0, counter, uval, prefix,
> > -                              run, ena, 1.0, &rt_stat);
> > +                              run, ena, 1.0, &rt_stat, counter_idx);
> >               }
> >               if (!first)
> >                       fputc('\n', config->output);
> > @@ -1135,8 +842,8 @@ static void print_metric_headers(struct perf_stat_=
config *config,
> >       };
> >       bool first =3D true;
> >
> > -             if (config->json_output && !config->interval)
> > -                     fprintf(config->output, "{");
> > +     if (config->json_output && !config->interval)
> > +             fprintf(config->output, "{");
> >
> >       if (prefix && !config->json_output)
> >               fprintf(config->output, "%s", prefix);
> > @@ -1379,31 +1086,6 @@ static void print_footer(struct perf_stat_config=
 *config)
> >                       "the same PMU. Try reorganizing the group.\n");
> >  }
> >
> > -static void print_percore_thread(struct perf_stat_config *config,
> > -                              struct evsel *counter, char *prefix)
> > -{
> > -     int s;
> > -     struct aggr_cpu_id s2, id;
> > -     struct perf_cpu_map *cpus;
> > -     bool first =3D true;
> > -     int idx;
> > -     struct perf_cpu cpu;
> > -
> > -     cpus =3D evsel__cpus(counter);
> > -     perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> > -             s2 =3D config->aggr_get_id(config, cpu);
> > -             for (s =3D 0; s < config->aggr_map->nr; s++) {
> > -                     id =3D config->aggr_map->map[s];
> > -                     if (aggr_cpu_id__equal(&s2, &id))
> > -                             break;
> > -             }
> > -
> > -             print_counter_aggrdata(config, counter, s,
> > -                                    prefix, false,
> > -                                    &first, cpu);
> > -     }
> > -}
> > -
> >  static void print_percore(struct perf_stat_config *config,
> >                         struct evsel *counter, char *prefix)
> >  {
> > @@ -1416,15 +1098,14 @@ static void print_percore(struct perf_stat_conf=
ig *config,
> >               return;
> >
> >       if (config->percore_show_thread)
> > -             return print_percore_thread(config, counter, prefix);
> > +             return print_counter(config, counter, prefix);
> >
> >       for (s =3D 0; s < config->aggr_map->nr; s++) {
> >               if (prefix && metric_only)
> >                       fprintf(output, "%s", prefix);
> >
> >               print_counter_aggrdata(config, counter, s,
> > -                             prefix, metric_only,
> > -                             &first, (struct perf_cpu){ .cpu =3D -1 })=
;
> > +                                    prefix, metric_only, &first);
> >       }
> >
> >       if (metric_only)
> > @@ -1469,17 +1150,13 @@ void evlist__print_counters(struct evlist *evli=
st, struct perf_stat_config *conf
> >               print_aggr(config, evlist, prefix);
> >               break;
> >       case AGGR_THREAD:
> > -             evlist__for_each_entry(evlist, counter) {
> > -                     print_aggr_thread(config, _target, counter, prefi=
x);
> > -             }
> > -             break;
> >       case AGGR_GLOBAL:
> >               if (config->iostat_run)
> >                       iostat_print_counters(evlist, config, ts, prefix =
=3D buf,
> > -                                           print_counter_aggr);
> > +                                           print_counter);
> >               else {
> >                       evlist__for_each_entry(evlist, counter) {
> > -                             print_counter_aggr(config, counter, prefi=
x);
> > +                             print_counter(config, counter, prefix);
> >                       }
> >                       if (metric_only)
> >                               fputc('\n', config->output);
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index c0955a0427ab..0316557adce9 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -565,11 +565,6 @@ int perf_stat_process_counter(struct perf_stat_con=
fig *config,
> >                       evsel__name(counter), count[0], count[1], count[2=
]);
> >       }
> >
> > -     /*
> > -      * Save the full runtime - to allow normalization during printout=
:
> > -      */
> > -     perf_stat__update_shadow_stats(counter, *count, 0, &rt_stat);
> > -
> >       return 0;
> >  }
> >
> > diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> > index 3d413ba8c68a..382a1ab92ce1 100644
> > --- a/tools/perf/util/stat.h
> > +++ b/tools/perf/util/stat.h
> > @@ -224,15 +224,6 @@ static inline void update_rusage_stats(struct rusa=
ge_stats *ru_stats, struct rus
> >  struct evsel;
> >  struct evlist;
> >
> > -struct perf_aggr_thread_value {
> > -     struct evsel *counter;
> > -     struct aggr_cpu_id id;
> > -     double uval;
> > -     u64 val;
> > -     u64 run;
> > -     u64 ena;
> > -};
> > -
> >  bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_i=
d id);
> >
> >  #define perf_stat_evsel__is(evsel, id) \
> > --
> > 2.38.0.413.g74048e4d9e-goog
> >
