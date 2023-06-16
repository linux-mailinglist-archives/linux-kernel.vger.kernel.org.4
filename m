Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC77B7326EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241638AbjFPF4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjFPF4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:56:42 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E8A2D54
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:56:39 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f9b7de94e7so150591cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686894999; x=1689486999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp1BrTvcHFgdTzZavZy78KYMVk3iajwl9J3OAnDeJ9M=;
        b=4H1byzVG/LuPpOKVrg5S9SZuGTzVeVahvdMW0EGKmJERT/0qyuNvb7cFX8amHmobt6
         hIBMjr/hB86H/Q+JoiyeP04Smwsjp43GWZGaljRTUi+s3nSU0TKI23b+RD8zfknS6Gzx
         /8kdx6Z/2vGou/sxp66xsUEluKXAfXKJ/Fsh5OUq06urwH9Y7ildewpZG5UUhleO5yRP
         jdmqZE3ETgwJJNFvt+mCj6Vh6lqPqRtHIM79Wsemn+LKI/bI+VJa+rG+iGlrUS6g4WT8
         y4D/J03ebBH/iU9FurKxbMbeTM2z2InR2T5+B52SLhu9aZmeN84APk4CtXEdXdCXiHa9
         ztKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686894999; x=1689486999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fp1BrTvcHFgdTzZavZy78KYMVk3iajwl9J3OAnDeJ9M=;
        b=dXKoWn6IJJHvnyImd1H/AQSuxkhna54HFz2rsVXQwa+w9fpAK099jNfFLmC4ZF9SOv
         ISC/hJRw5u+cKYpftvBt5V2YZdkdWDGZDtl5N0AI0OnxXMRBOkxNhS9vWBvj5+FoJBdW
         6sR+V8+hhWAjhnMt+PCCc6cVoF6C5A9DOAvXvxzX4iByu3OykhbQULCUyZrKy4nwEsEt
         FLt0PX0PKMY8pqJxUNeKiHho/5rrgey5PLsWmsHp7jsFQga3XxK1amHoAsununWXFq14
         napvDnaIqWXyLYxbhkaZX5tBlbsc8LO9h8ZdchhFZeC/nG1uJ77gblTpMPTAWPY3aqlg
         RxxA==
X-Gm-Message-State: AC+VfDwlAILPrrS04P/VnAggw6kMJQveTsl09qzgmSZpUR0CUSjbFwl5
        NxBLfDDDH0PlxybU1/Or63CWg4zI7+CIw/50LPGqEQ==
X-Google-Smtp-Source: ACHHUZ7qJdhsvh/AA3hD8XuVXfmE7c5zjaBfgboo0BlNwoZXInf2jpphmEE4Rv/DGXFtugdaFUnOn9zqSAgzpmlbsvY=
X-Received: by 2002:a05:622a:1804:b0:3f9:a986:f3a4 with SMTP id
 t4-20020a05622a180400b003f9a986f3a4mr370923qtc.25.1686894998717; Thu, 15 Jun
 2023 22:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230616031420.3751973-1-kan.liang@linux.intel.com> <20230616031420.3751973-3-kan.liang@linux.intel.com>
In-Reply-To: <20230616031420.3751973-3-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 15 Jun 2023 22:56:27 -0700
Message-ID: <CAP-5=fXZ-31AX5Bx+-HSdQT0XAH6_zba0T+FYoPpD64=64b+iw@mail.gmail.com>
Subject: Re: [PATCH V4 2/5] perf stat: New metricgroup output for the default mode
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
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

On Thu, Jun 15, 2023 at 8:15=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> In the default mode, the current output of the metricgroup include both
> events and metrics, which is not necessary and just makes the output
> hard to read. Since different ARCHs (even different generations in the
> same ARCH) may use different events. The output also vary on different
> platforms.
>
> For a metricgroup, only outputting the value of each metric is good
> enough.
>
> Add a new field default_metricgroup in evsel to indicate an event of
> the default metricgroup. For those events, printout() should print
> the metricgroup name rather than each event.
>
> Add perf_stat__skip_metric_event() to skip the evsel in the Default
> metricgroup, if it's not running or not the metric event.
>
> Add print_metricgroup_header_t to pass the functions which print the
> display name of each metricgroup in the Default metricgroup. Support
> all three output methods.
>
> Factor out perf_stat__print_shadow_stats_metricgroup() to print out
> each metrics.
>
> On SPR
> Before:
>
>  ./perf_old stat sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>               0.54 msec task-clock:u                     #    0.001 CPUs =
utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                 68      page-faults:u                    #  125.445 K/sec
>            540,970      cycles:u                         #    0.998 GHz
>            556,325      instructions:u                   #    1.03  insn =
per cycle
>            123,602      branches:u                       #  228.018 M/sec
>              6,889      branch-misses:u                  #    5.57% of al=
l branches
>          3,245,820      TOPDOWN.SLOTS:u                  #     18.4 %  tm=
a_backend_bound
>                                                   #     17.2 %  tma_retir=
ing
>                                                   #     23.1 %  tma_bad_s=
peculation
>                                                   #     41.4 %  tma_front=
end_bound
>            564,859      topdown-retiring:u
>          1,370,999      topdown-fe-bound:u
>            603,271      topdown-be-bound:u
>            744,874      topdown-bad-spec:u
>             12,661      INT_MISC.UOP_DROPPING:u          #   23.357 M/sec
>
>        1.001798215 seconds time elapsed
>
>        0.000193000 seconds user
>        0.001700000 seconds sys
>
> After:
>
> $ ./perf stat sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>               0.51 msec task-clock:u                     #    0.001 CPUs =
utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                 68      page-faults:u                    #  132.683 K/sec
>            545,228      cycles:u                         #    1.064 GHz
>            555,509      instructions:u                   #    1.02  insn =
per cycle
>            123,574      branches:u                       #  241.120 M/sec
>              6,957      branch-misses:u                  #    5.63% of al=
l branches
>                         TopdownL1                 #     17.5 %  tma_backe=
nd_bound
>                                                   #     22.6 %  tma_bad_s=
peculation
>                                                   #     42.7 %  tma_front=
end_bound
>                                                   #     17.1 %  tma_retir=
ing
>                         TopdownL2                 #     21.8 %  tma_branc=
h_mispredicts
>                                                   #     11.5 %  tma_core_=
bound
>                                                   #     13.4 %  tma_fetch=
_bandwidth
>                                                   #     29.3 %  tma_fetch=
_latency
>                                                   #      2.7 %  tma_heavy=
_operations
>                                                   #     14.5 %  tma_light=
_operations
>                                                   #      0.8 %  tma_machi=
ne_clears
>                                                   #      6.1 %  tma_memor=
y_bound
>
>        1.001712086 seconds time elapsed
>
>        0.000151000 seconds user
>        0.001618000 seconds sys
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Just an observation: I think a lot of the "default" terminology is
confusing as default means more like automatically selected when no
event or metric are given. Reading default as meaning default makes
the comments on perf_stat__print_shadow_stats_metricgroup somewhat
counter intuitive.

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c      |   1 +
>  tools/perf/util/evsel.h        |   1 +
>  tools/perf/util/stat-display.c | 108 ++++++++++++++++++++++++---
>  tools/perf/util/stat-shadow.c  | 131 ++++++++++++++++++++++++++++++---
>  tools/perf/util/stat.h         |  15 ++++
>  5 files changed, 234 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 55601b4b5c34..3f4e76f76f94 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2172,6 +2172,7 @@ static int add_default_attributes(void)
>
>                         evlist__for_each_entry(metric_evlist, metric_evse=
l) {
>                                 metric_evsel->skippable =3D true;
> +                               metric_evsel->default_metricgroup =3D tru=
e;
>                         }
>                         evlist__splice_list_tail(evsel_list, &metric_evli=
st->core.entries);
>                         evlist__delete(metric_evlist);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index cc6fb3049b99..9f06d6cd5379 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -131,6 +131,7 @@ struct evsel {
>         bool                    reset_group;
>         bool                    errored;
>         bool                    needs_auxtrace_mmap;
> +       bool                    default_metricgroup; /* A member of the D=
efault metricgroup */
>         struct hashmap          *per_pkg_mask;
>         int                     err;
>         struct {
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index a2bbdc25d979..7329b3340f88 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -25,6 +25,7 @@
>  #define CNTR_NOT_SUPPORTED     "<not supported>"
>  #define CNTR_NOT_COUNTED       "<not counted>"
>
> +#define MGROUP_LEN   50
>  #define METRIC_LEN   38
>  #define EVNAME_LEN   32
>  #define COUNTS_LEN   18
> @@ -364,16 +365,27 @@ static void new_line_std(struct perf_stat_config *c=
onfig __maybe_unused,
>         os->newline =3D true;
>  }
>
> -static void do_new_line_std(struct perf_stat_config *config,
> -                           struct outstate *os)
> +static inline void __new_line_std_csv(struct perf_stat_config *config,
> +                                     struct outstate *os)
>  {
>         fputc('\n', os->fh);
>         if (os->prefix)
>                 fputs(os->prefix, os->fh);
>         aggr_printout(config, os->evsel, os->id, os->aggr_nr);
> +}
> +
> +static inline void __new_line_std(struct outstate *os)
> +{
> +       fprintf(os->fh, "                                                =
 ");
> +}
> +
> +static void do_new_line_std(struct perf_stat_config *config,
> +                           struct outstate *os)
> +{
> +       __new_line_std_csv(config, os);
>         if (config->aggr_mode =3D=3D AGGR_NONE)
>                 fprintf(os->fh, "        ");
> -       fprintf(os->fh, "                                                =
 ");
> +       __new_line_std(os);
>  }
>
>  static void print_metric_std(struct perf_stat_config *config,
> @@ -408,10 +420,7 @@ static void new_line_csv(struct perf_stat_config *co=
nfig, void *ctx)
>         struct outstate *os =3D ctx;
>         int i;
>
> -       fputc('\n', os->fh);
> -       if (os->prefix)
> -               fprintf(os->fh, "%s", os->prefix);
> -       aggr_printout(config, os->evsel, os->id, os->aggr_nr);
> +       __new_line_std_csv(config, os);
>         for (i =3D 0; i < os->nfields; i++)
>                 fputs(config->csv_sep, os->fh);
>  }
> @@ -462,6 +471,54 @@ static void new_line_json(struct perf_stat_config *c=
onfig, void *ctx)
>         aggr_printout(config, os->evsel, os->id, os->aggr_nr);
>  }
>
> +static void print_metricgroup_header_json(struct perf_stat_config *confi=
g,
> +                                         void *ctx,
> +                                         const char *metricgroup_name)
> +{
> +       if (!metricgroup_name)
> +               return;
> +
> +       fprintf(config->output, "\"metricgroup\" : \"%s\"}", metricgroup_=
name);
> +       new_line_json(config, ctx);
> +}
> +
> +static void print_metricgroup_header_csv(struct perf_stat_config *config=
,
> +                                        void *ctx,
> +                                        const char *metricgroup_name)
> +{
> +       struct outstate *os =3D ctx;
> +       int i;
> +
> +       if (!metricgroup_name) {
> +               /* Leave space for running and enabling */
> +               for (i =3D 0; i < os->nfields - 2; i++)
> +                       fputs(config->csv_sep, os->fh);
> +               return;
> +       }
> +
> +       for (i =3D 0; i < os->nfields; i++)
> +               fputs(config->csv_sep, os->fh);
> +       fprintf(config->output, "%s", metricgroup_name);
> +       new_line_csv(config, ctx);
> +}
> +
> +static void print_metricgroup_header_std(struct perf_stat_config *config=
,
> +                                        void *ctx,
> +                                        const char *metricgroup_name)
> +{
> +       struct outstate *os =3D ctx;
> +       int n;
> +
> +       if (!metricgroup_name) {
> +               __new_line_std(os);
> +               return;
> +       }
> +
> +       n =3D fprintf(config->output, " %*s", EVNAME_LEN, metricgroup_nam=
e);
> +
> +       fprintf(config->output, "%*s", MGROUP_LEN - n - 1, "");
> +}
> +
>  /* Filter out some columns that don't work well in metrics only mode */
>
>  static bool valid_only_metric(const char *unit)
> @@ -713,19 +770,23 @@ static void printout(struct perf_stat_config *confi=
g, struct outstate *os,
>         struct perf_stat_output_ctx out;
>         print_metric_t pm;
>         new_line_t nl;
> +       print_metricgroup_header_t pmh;
>         bool ok =3D true;
>         struct evsel *counter =3D os->evsel;
>
>         if (config->csv_output) {
>                 pm =3D config->metric_only ? print_metric_only_csv : prin=
t_metric_csv;
>                 nl =3D config->metric_only ? new_line_metric : new_line_c=
sv;
> +               pmh =3D print_metricgroup_header_csv;
>                 os->nfields =3D 4 + (counter->cgrp ? 1 : 0);
>         } else if (config->json_output) {
>                 pm =3D config->metric_only ? print_metric_only_json : pri=
nt_metric_json;
>                 nl =3D config->metric_only ? new_line_metric : new_line_j=
son;
> +               pmh =3D print_metricgroup_header_json;
>         } else {
>                 pm =3D config->metric_only ? print_metric_only : print_me=
tric_std;
>                 nl =3D config->metric_only ? new_line_metric : new_line_s=
td;
> +               pmh =3D print_metricgroup_header_std;
>         }
>
>         if (run =3D=3D 0 || ena =3D=3D 0 || counter->counts->scaled =3D=
=3D -1) {
> @@ -747,10 +808,11 @@ static void printout(struct perf_stat_config *confi=
g, struct outstate *os,
>
>         out.print_metric =3D pm;
>         out.new_line =3D nl;
> +       out.print_metricgroup_header =3D pmh;
>         out.ctx =3D os;
>         out.force_header =3D false;
>
> -       if (!config->metric_only) {
> +       if (!config->metric_only && !counter->default_metricgroup) {
>                 abs_printout(config, os->id, os->aggr_nr, counter, uval, =
ok);
>
>                 print_noise(config, counter, noise, /*before_metric=3D*/t=
rue);
> @@ -758,8 +820,31 @@ static void printout(struct perf_stat_config *config=
, struct outstate *os,
>         }
>
>         if (ok) {
> -               perf_stat__print_shadow_stats(config, counter, uval, aggr=
_idx,
> -                                             &out, &config->metric_event=
s);
> +               if (!config->metric_only && counter->default_metricgroup)=
 {
> +                       void *from =3D NULL;
> +
> +                       aggr_printout(config, os->evsel, os->id, os->aggr=
_nr);
> +                       /* Print out all the metricgroup with the same me=
tric event. */
> +                       do {
> +                               int num =3D 0;
> +
> +                               /* Print out the new line for the next ne=
w metricgroup. */
> +                               if (from) {
> +                                       if (config->json_output)
> +                                               new_line_json(config, (vo=
id *)os);
> +                                       else
> +                                               __new_line_std_csv(config=
, os);
> +                               }
> +
> +                               print_noise(config, counter, noise, /*bef=
ore_metric=3D*/true);
> +                               print_running(config, run, ena, /*before_=
metric=3D*/true);
> +                               from =3D perf_stat__print_shadow_stats_me=
tricgroup(config, counter, aggr_idx,
> +                                                                        =
        &num, from, &out,
> +                                                                        =
        &config->metric_events);
> +                       } while (from !=3D NULL);
> +               } else
> +                       perf_stat__print_shadow_stats(config, counter, uv=
al, aggr_idx,
> +                                                     &out, &config->metr=
ic_events);
>         } else {
>                 pm(config, os, /*color=3D*/NULL, /*format=3D*/NULL, /*uni=
t=3D*/"", /*val=3D*/0);
>         }
> @@ -889,6 +974,9 @@ static void print_counter_aggrdata(struct perf_stat_c=
onfig *config,
>         ena =3D aggr->counts.ena;
>         run =3D aggr->counts.run;
>
> +       if (perf_stat__skip_metric_event(counter, &config->metric_events,=
 ena, run))
> +               return;
> +
>         if (val =3D=3D 0 && should_skip_zero_counter(config, counter, &id=
))
>                 return;
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 1566a206ba42..1c5c3eeba4cf 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -539,6 +539,106 @@ double test_generic_metric(struct metric_expr *mexp=
, int aggr_idx)
>         return ratio;
>  }
>
> +static void perf_stat__print_metricgroup_header(struct perf_stat_config =
*config,
> +                                               struct evsel *evsel,
> +                                               void *ctxp,
> +                                               const char *name,
> +                                               struct perf_stat_output_c=
tx *out)
> +{
> +       bool need_full_name =3D perf_pmus__num_core_pmus() > 1;
> +       static const char *last_name;
> +       static const char *last_pmu;
> +       char full_name[64];
> +
> +       /*
> +        * A metricgroup may have several metric events,
> +        * e.g.,TopdownL1 on e-core of ADL.
> +        * The name has been output by the first metric
> +        * event. Only align with other metics from
> +        * different metric events.
> +        */
> +       if (last_name && !strcmp(last_name, name)) {
> +               if (!need_full_name || !strcmp(last_pmu, evsel->pmu_name)=
) {
> +                       out->print_metricgroup_header(config, ctxp, NULL)=
;
> +                       return;
> +               }
> +       }
> +
> +       if (need_full_name)
> +               scnprintf(full_name, sizeof(full_name), "%s (%s)", name, =
evsel->pmu_name);
> +       else
> +               scnprintf(full_name, sizeof(full_name), "%s", name);
> +
> +       out->print_metricgroup_header(config, ctxp, full_name);
> +
> +       last_name =3D name;
> +       last_pmu =3D evsel->pmu_name;
> +}
> +
> +/**
> + * perf_stat__print_shadow_stats_metricgroup - Print out metrics associa=
ted with the evsel
> + *                                            For the non-default, all m=
etrics associated
> + *                                            with the evsel are printed=
.
> + *                                            For the default mode, only=
 the metrics from
> + *                                            the same metricgroup and t=
he name of the
> + *                                            metricgroup are printed. T=
o print the metrics
> + *                                            from the next metricgroup =
(if available),
> + *                                            invoke the function with c=
orrespoinding
> + *                                            metric_expr.
> + */
> +void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config =
*config,
> +                                               struct evsel *evsel,
> +                                               int aggr_idx,
> +                                               int *num,
> +                                               void *from,
> +                                               struct perf_stat_output_c=
tx *out,
> +                                               struct rblist *metric_eve=
nts)
> +{
> +       struct metric_event *me;
> +       struct metric_expr *mexp =3D from;
> +       void *ctxp =3D out->ctx;
> +       bool header_printed =3D false;
> +       const char *name =3D NULL;
> +
> +       me =3D metricgroup__lookup(metric_events, evsel, false);
> +       if (me =3D=3D NULL)
> +               return NULL;
> +
> +       if (!mexp)
> +               mexp =3D list_first_entry(&me->head, typeof(*mexp), nd);
> +
> +       list_for_each_entry_from(mexp, &me->head, nd) {
> +               /* Print the display name of the Default metricgroup */
> +               if (!config->metric_only && me->is_default) {
> +                       if (!name)
> +                               name =3D mexp->default_metricgroup_name;
> +                       /*
> +                        * Two or more metricgroup may share the same met=
ric
> +                        * event, e.g., TopdownL1 and TopdownL2 on SPR.
> +                        * Return and print the prefix, e.g., noise, runn=
ing
> +                        * for the next metricgroup.
> +                        */
> +                       if (strcmp(name, mexp->default_metricgroup_name))
> +                               return (void *)mexp;
> +                       /* Only print the name of the metricgroup once */
> +                       if (!header_printed) {
> +                               header_printed =3D true;
> +                               perf_stat__print_metricgroup_header(confi=
g, evsel, ctxp,
> +                                                                   name,=
 out);
> +                       }
> +               }
> +
> +               if ((*num)++ > 0)
> +                       out->new_line(config, ctxp);
> +               generic_metric(config, mexp->metric_expr, mexp->metric_th=
reshold,
> +                              mexp->metric_events, mexp->metric_refs, ev=
sel->name,
> +                              mexp->metric_name, mexp->metric_unit, mexp=
->runtime,
> +                              aggr_idx, out);
> +       }
> +
> +       return NULL;
> +}
> +
>  void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>                                    struct evsel *evsel,
>                                    double avg, int aggr_idx,
> @@ -565,7 +665,6 @@ void perf_stat__print_shadow_stats(struct perf_stat_c=
onfig *config,
>         };
>         print_metric_t print_metric =3D out->print_metric;
>         void *ctxp =3D out->ctx;
> -       struct metric_event *me;
>         int num =3D 1;
>
>         if (config->iostat_run) {
> @@ -592,18 +691,26 @@ void perf_stat__print_shadow_stats(struct perf_stat=
_config *config,
>                 }
>         }
>
> -       if ((me =3D metricgroup__lookup(metric_events, evsel, false)) !=
=3D NULL) {
> -               struct metric_expr *mexp;
> +       perf_stat__print_shadow_stats_metricgroup(config, evsel, aggr_idx=
,
> +                                                 &num, NULL, out, metric=
_events);
>
> -               list_for_each_entry (mexp, &me->head, nd) {
> -                       if (num++ > 0)
> -                               out->new_line(config, ctxp);
> -                       generic_metric(config, mexp->metric_expr, mexp->m=
etric_threshold,
> -                                      mexp->metric_events, mexp->metric_=
refs, evsel->name,
> -                                      mexp->metric_name, mexp->metric_un=
it, mexp->runtime,
> -                                      aggr_idx, out);
> -               }
> -       }
>         if (num =3D=3D 0)
>                 print_metric(config, ctxp, NULL, NULL, NULL, 0);
>  }
> +
> +/**
> + * perf_stat__skip_metric_event - Skip the evsel in the Default metricgr=
oup,
> + *                               if it's not running or not the metric e=
vent.
> + */
> +bool perf_stat__skip_metric_event(struct evsel *evsel,
> +                                 struct rblist *metric_events,
> +                                 u64 ena, u64 run)
> +{
> +       if (!evsel->default_metricgroup)
> +               return false;
> +
> +       if (!ena || !run)
> +               return true;
> +
> +       return !metricgroup__lookup(metric_events, evsel, false);
> +}
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 7abff7cbb5a1..934f79778cea 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -158,11 +158,16 @@ typedef void (*print_metric_t)(struct perf_stat_con=
fig *config,
>                                const char *fmt, double val);
>  typedef void (*new_line_t)(struct perf_stat_config *config, void *ctx);
>
> +/* Used to print the display name of the Default metricgroup for now. */
> +typedef void (*print_metricgroup_header_t)(struct perf_stat_config *conf=
ig,
> +                                          void *ctx, const char *metricg=
roup_name);
> +
>  void perf_stat__reset_shadow_stats(void);
>  struct perf_stat_output_ctx {
>         void *ctx;
>         print_metric_t print_metric;
>         new_line_t new_line;
> +       print_metricgroup_header_t print_metricgroup_header;
>         bool force_header;
>  };
>
> @@ -171,6 +176,16 @@ void perf_stat__print_shadow_stats(struct perf_stat_=
config *config,
>                                    double avg, int aggr_idx,
>                                    struct perf_stat_output_ctx *out,
>                                    struct rblist *metric_events);
> +bool perf_stat__skip_metric_event(struct evsel *evsel,
> +                                 struct rblist *metric_events,
> +                                 u64 ena, u64 run);
> +void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config =
*config,
> +                                               struct evsel *evsel,
> +                                               int aggr_idx,
> +                                               int *num,
> +                                               void *from,
> +                                               struct perf_stat_output_c=
tx *out,
> +                                               struct rblist *metric_eve=
nts);
>
>  int evlist__alloc_stats(struct perf_stat_config *config,
>                         struct evlist *evlist, bool alloc_raw);
> --
> 2.35.1
>
