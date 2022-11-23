Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43416636E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKWX2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKWX2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:28:13 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8695A2936D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:28:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s5so34500wru.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7/x8yZBtM7luYLdfHDSveSGBatWD8Qx017EwFob6X6A=;
        b=jqmHHVT11Yax2mNIwdv3VI0FWHP49cAd3K6Fm/AABIJXSrDWh/4zM1gdf0iU4s69RM
         9KiFjZNAhfGYhHN5TusPR2Vrg7qLQ6ABh484CsUZp7y8KS4ad08FCr9PEDESkFGC6/cI
         WgqeYncma1RUOAuovWWBxTHDcI8lnqfnzh7xFL6kWBRqDQ/4zorLG6u28pcJm5YXbkrd
         BkxQzpCus3WiQFJCRGoTcCO89VNz4AhqqSmAlWgbb9BXh9W6VEVflFXjqUJqyicoofj7
         /E5Q9r4f8Qt4ZOuQu/tMGq8tyAJA3J6AzSp78TmUWWSfxSY4JfngbDic1JUIDPbM9cnb
         7Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/x8yZBtM7luYLdfHDSveSGBatWD8Qx017EwFob6X6A=;
        b=GUrcs/lm0xrBBRA/foyMFnjPZIKR/Ljs8738Rf7EC7MWnJTmuVvoIrgKxFRpfQbZj6
         JnvWm8M1O0CXtwrcBMz8uV8riQezxvOR5qhkl9ZZGJEtGibIRf82ou6Fe4yeaui6Koff
         KGehJbhquVjzPqTMZIVy0yorEkaT2Qs/dxyXFqBdcPWFMHlkXHDQZAp9kgbh4DC6CjLh
         qS9Lja/9lTM/ENvGZV62iYCfIPOk6xOfBX9OmIZs64Go2/cOzDU7RK0C6dT++lBNfBIi
         TYBLKd3Z6r6KeulaCsunexBiqP7k8+3VUkaCSdXtTZ9juV7eish0hanjhsq0yIysm4or
         PAGQ==
X-Gm-Message-State: ANoB5pn7cZf2Chy/kNRosmPsF3inYkZnnPETNpmRtvUb9T3oHMxPcPl1
        tjufL+V1zu0eOlN1lU8DiUh007H/ZgQqYAu4MSZ5jA==
X-Google-Smtp-Source: AA0mqf7GmzjWODm0fVMbXNQL1PeNkBq0Z5BSmWVlPf6+UnbjNuShyxZ45iuDEBw0gUVTmwU1tMsm6rN/KCE2hcAegzo=
X-Received: by 2002:adf:e2c9:0:b0:241:db86:176d with SMTP id
 d9-20020adfe2c9000000b00241db86176dmr8953472wrj.40.1669246089797; Wed, 23 Nov
 2022 15:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-13-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-13-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:27:57 -0800
Message-ID: <CAP-5=fVsKYdtWuA1nn52DA2bHwYmhmDR9Mqc=da+LKU1adqHfw@mail.gmail.com>
Subject: Re: [PATCH 12/15] perf stat: Pass through struct outstate
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
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

On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Now most of the print functions take a pointer to the struct outstate.
> We have one in the evlist__print_counters() and pass it through the
> child functions.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/iostat.c |   4 +-
>  tools/perf/util/iostat.c          |   3 +-
>  tools/perf/util/iostat.h          |   4 +-
>  tools/perf/util/stat-display.c    | 102 +++++++++++++-----------------
>  4 files changed, 50 insertions(+), 63 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
> index 404de795ec0b..7eb0a7b00b95 100644
> --- a/tools/perf/arch/x86/util/iostat.c
> +++ b/tools/perf/arch/x86/util/iostat.c
> @@ -449,7 +449,7 @@ void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
>
>  void iostat_print_counters(struct evlist *evlist,
>                            struct perf_stat_config *config, struct timespec *ts,
> -                          char *prefix, iostat_print_counter_t print_cnt_cb)
> +                          char *prefix, iostat_print_counter_t print_cnt_cb, void *arg)
>  {
>         void *perf_device = NULL;
>         struct evsel *counter = evlist__first(evlist);
> @@ -464,7 +464,7 @@ void iostat_print_counters(struct evlist *evlist,
>                         iostat_prefix(evlist, config, prefix, ts);
>                         fprintf(config->output, "\n%s", prefix);
>                 }
> -               print_cnt_cb(config, counter, prefix);
> +               print_cnt_cb(config, counter, arg);
>         }
>         fputc('\n', config->output);
>  }
> diff --git a/tools/perf/util/iostat.c b/tools/perf/util/iostat.c
> index 57dd49da28fe..b770bd473af7 100644
> --- a/tools/perf/util/iostat.c
> +++ b/tools/perf/util/iostat.c
> @@ -48,6 +48,7 @@ __weak void iostat_print_counters(struct evlist *evlist __maybe_unused,
>                                   struct perf_stat_config *config __maybe_unused,
>                                   struct timespec *ts __maybe_unused,
>                                   char *prefix __maybe_unused,
> -                                 iostat_print_counter_t print_cnt_cb __maybe_unused)
> +                                 iostat_print_counter_t print_cnt_cb __maybe_unused,
> +                                 void *arg __maybe_unused)
>  {
>  }
> diff --git a/tools/perf/util/iostat.h b/tools/perf/util/iostat.h
> index c22688f87cb2..a4e7299c5c2f 100644
> --- a/tools/perf/util/iostat.h
> +++ b/tools/perf/util/iostat.h
> @@ -28,7 +28,7 @@ enum iostat_mode_t {
>
>  extern enum iostat_mode_t iostat_mode;
>
> -typedef void (*iostat_print_counter_t)(struct perf_stat_config *, struct evsel *, const char *);
> +typedef void (*iostat_print_counter_t)(struct perf_stat_config *, struct evsel *, void *);
>
>  int iostat_prepare(struct evlist *evlist, struct perf_stat_config *config);
>  int iostat_parse(const struct option *opt, const char *str,
> @@ -42,6 +42,6 @@ void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
>                          struct perf_stat_output_ctx *out);
>  void iostat_print_counters(struct evlist *evlist,
>                            struct perf_stat_config *config, struct timespec *ts,
> -                          char *prefix, iostat_print_counter_t print_cnt_cb);
> +                          char *prefix, iostat_print_counter_t print_cnt_cb, void *arg);
>
>  #endif /* _IOSTAT_H */
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index cdf4ca7f6e3a..335627e8542d 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -796,7 +796,7 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
>
>  static void print_counter_aggrdata(struct perf_stat_config *config,
>                                    struct evsel *counter, int s,
> -                                  const char *prefix)
> +                                  struct outstate *os)
>  {
>         FILE *output = config->output;
>         u64 ena, run, val;
> @@ -806,13 +806,10 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>         struct aggr_cpu_id id = config->aggr_map->map[s];
>         double avg = aggr->counts.val;
>         bool metric_only = config->metric_only;
> -       struct outstate os = {
> -               .fh = config->output,
> -               .prefix = prefix ? prefix : "",
> -               .id = id,
> -               .nr = aggr->nr,
> -               .evsel = counter,
> -       };
> +
> +       os->id = id;
> +       os->nr = aggr->nr;
> +       os->evsel = counter;
>
>         if (counter->supported && aggr->nr == 0)
>                 return;
> @@ -824,8 +821,8 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>         run = aggr->counts.run;
>
>         if (!metric_only) {
> -               if (prefix)
> -                       fprintf(output, "%s", prefix);
> +               if (os->prefix)
> +                       fprintf(output, "%s", os->prefix);
>                 else if (config->summary && config->csv_output &&
>                          !config->no_csv_summary && !config->interval)
>                         fprintf(output, "%s%s", "summary", config->csv_sep);
> @@ -833,7 +830,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>
>         uval = val * counter->scale;
>
> -       printout(config, &os, uval, run, ena, avg, s);
> +       printout(config, os, uval, run, ena, avg, s);
>
>         if (!metric_only)
>                 fputc('\n', output);
> @@ -871,12 +868,9 @@ static void print_metric_end(struct perf_stat_config *config)
>
>  static void print_aggr(struct perf_stat_config *config,
>                        struct evlist *evlist,
> -                      const char *prefix)
> +                      struct outstate *os)
>  {
>         struct evsel *counter;
> -       struct outstate os = {
> -               .prefix = prefix,
> -       };
>         int s;
>
>         if (!config->aggr_map || !config->aggr_get_id)
> @@ -887,13 +881,13 @@ static void print_aggr(struct perf_stat_config *config,
>          * Without each counter has its own line.
>          */
>         for (s = 0; s < config->aggr_map->nr; s++) {
> -               print_metric_begin(config, evlist, &os, s);
> +               print_metric_begin(config, evlist, os, s);
>
>                 evlist__for_each_entry(evlist, counter) {
>                         if (counter->merged_stat)
>                                 continue;
>
> -                       print_counter_aggrdata(config, counter, s, prefix);
> +                       print_counter_aggrdata(config, counter, s, os);
>                 }
>                 print_metric_end(config);
>         }
> @@ -901,34 +895,31 @@ static void print_aggr(struct perf_stat_config *config,
>
>  static void print_aggr_cgroup(struct perf_stat_config *config,
>                               struct evlist *evlist,
> -                             const char *prefix)
> +                             struct outstate *os)
>  {
>         struct evsel *counter, *evsel;
> -       struct outstate os = {
> -               .prefix = prefix,
> -       };
>         int s;
>
>         if (!config->aggr_map || !config->aggr_get_id)
>                 return;
>
>         evlist__for_each_entry(evlist, evsel) {
> -               if (os.cgrp == evsel->cgrp)
> +               if (os->cgrp == evsel->cgrp)
>                         continue;
>
> -               os.cgrp = evsel->cgrp;
> +               os->cgrp = evsel->cgrp;
>
>                 for (s = 0; s < config->aggr_map->nr; s++) {
> -                       print_metric_begin(config, evlist, &os, s);
> +                       print_metric_begin(config, evlist, os, s);
>
>                         evlist__for_each_entry(evlist, counter) {
>                                 if (counter->merged_stat)
>                                         continue;
>
> -                               if (counter->cgrp != os.cgrp)
> +                               if (counter->cgrp != os->cgrp)
>                                         continue;
>
> -                               print_counter_aggrdata(config, counter, s, prefix);
> +                               print_counter_aggrdata(config, counter, s, os);
>                         }
>                         print_metric_end(config);
>                 }
> @@ -936,7 +927,7 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
>  }
>
>  static void print_counter(struct perf_stat_config *config,
> -                         struct evsel *counter, const char *prefix)
> +                         struct evsel *counter, struct outstate *os)
>  {
>         int s;
>
> @@ -948,19 +939,16 @@ static void print_counter(struct perf_stat_config *config,
>                 return;
>
>         for (s = 0; s < config->aggr_map->nr; s++) {
> -               print_counter_aggrdata(config, counter, s, prefix);
> +               print_counter_aggrdata(config, counter, s, os);
>         }
>  }
>
>  static void print_no_aggr_metric(struct perf_stat_config *config,
>                                  struct evlist *evlist,
> -                                const char *prefix)
> +                                struct outstate *os)
>  {
>         int all_idx;
>         struct perf_cpu cpu;
> -       struct outstate os = {
> -               .prefix = prefix,
> -       };
>
>         perf_cpu_map__for_each_cpu(cpu, all_idx, evlist->core.user_requested_cpus) {
>                 struct evsel *counter;
> @@ -975,10 +963,10 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>                         if (counter_idx < 0)
>                                 continue;
>
> -                       os.evsel = counter;
> -                       os.id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
> +                       os->evsel = counter;
> +                       os->id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
>                         if (first) {
> -                               print_metric_begin(config, evlist, &os, counter_idx);
> +                               print_metric_begin(config, evlist, os, counter_idx);
>                                 first = false;
>                         }
>                         val = ps->aggr[counter_idx].counts.val;
> @@ -986,7 +974,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>                         run = ps->aggr[counter_idx].counts.run;
>
>                         uval = val * counter->scale;
> -                       printout(config, &os, uval, run, ena, 1.0, counter_idx);
> +                       printout(config, os, uval, run, ena, 1.0, counter_idx);
>                 }
>                 if (!first)
>                         print_metric_end(config);
> @@ -1304,7 +1292,7 @@ static void print_footer(struct perf_stat_config *config)
>  }
>
>  static void print_percore(struct perf_stat_config *config,
> -                         struct evsel *counter, const char *prefix)
> +                         struct evsel *counter, struct outstate *os)
>  {
>         bool metric_only = config->metric_only;
>         FILE *output = config->output;
> @@ -1315,7 +1303,7 @@ static void print_percore(struct perf_stat_config *config,
>                 return;
>
>         if (config->percore_show_thread)
> -               return print_counter(config, counter, prefix);
> +               return print_counter(config, counter, os);
>
>         core_map = cpu_aggr_map__empty_new(config->aggr_map->nr);
>         if (core_map == NULL) {
> @@ -1337,7 +1325,7 @@ static void print_percore(struct perf_stat_config *config,
>                 if (found)
>                         continue;
>
> -               print_counter_aggrdata(config, counter, s, prefix);
> +               print_counter_aggrdata(config, counter, s, os);
>
>                 core_map->map[c++] = core_id;
>         }
> @@ -1348,30 +1336,28 @@ static void print_percore(struct perf_stat_config *config,
>  }
>
>  static void print_cgroup_counter(struct perf_stat_config *config, struct evlist *evlist,
> -                                const char *prefix)
> +                                struct outstate *os)
>  {
>         struct evsel *counter;
> -       struct outstate os = {
> -               .prefix = prefix,
> -       };
>
>         evlist__for_each_entry(evlist, counter) {
> -               if (os.cgrp != counter->cgrp) {
> -                       if (os.cgrp != NULL)
> +               if (os->cgrp != counter->cgrp) {
> +                       if (os->cgrp != NULL)
>                                 print_metric_end(config);
>
> -                       os.cgrp = counter->cgrp;
> -                       print_metric_begin(config, evlist, &os, /*aggr_idx=*/0);
> +                       os->cgrp = counter->cgrp;
> +                       print_metric_begin(config, evlist, os, /*aggr_idx=*/0);
>                 }
>
> -               print_counter(config, counter, prefix);
> +               print_counter(config, counter, os);
>         }
> -       if (os.cgrp)
> +       if (os->cgrp)
>                 print_metric_end(config);
>  }
>
>  void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
> -                           struct target *_target, struct timespec *ts, int argc, const char **argv)
> +                           struct target *_target, struct timespec *ts,
> +                           int argc, const char **argv)
>  {
>         bool metric_only = config->metric_only;
>         int interval = config->interval;
> @@ -1397,34 +1383,34 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>         case AGGR_SOCKET:
>         case AGGR_NODE:
>                 if (config->cgroup_list)
> -                       print_aggr_cgroup(config, evlist, os.prefix);
> +                       print_aggr_cgroup(config, evlist, &os);
>                 else
> -                       print_aggr(config, evlist, os.prefix);
> +                       print_aggr(config, evlist, &os);
>                 break;
>         case AGGR_THREAD:
>         case AGGR_GLOBAL:
>                 if (config->iostat_run) {
>                         iostat_print_counters(evlist, config, ts, buf,
> -                                             print_counter);
> +                                             (iostat_print_counter_t)print_counter, &os);
>                 } else if (config->cgroup_list) {
> -                       print_cgroup_counter(config, evlist, os.prefix);
> +                       print_cgroup_counter(config, evlist, &os);
>                 } else {
>                         print_metric_begin(config, evlist, &os, /*aggr_idx=*/0);
>                         evlist__for_each_entry(evlist, counter) {
> -                               print_counter(config, counter, os.prefix);
> +                               print_counter(config, counter, &os);
>                         }
>                         print_metric_end(config);
>                 }
>                 break;
>         case AGGR_NONE:
>                 if (metric_only)
> -                       print_no_aggr_metric(config, evlist, os.prefix);
> +                       print_no_aggr_metric(config, evlist, &os);
>                 else {
>                         evlist__for_each_entry(evlist, counter) {
>                                 if (counter->percore)
> -                                       print_percore(config, counter, os.prefix);
> +                                       print_percore(config, counter, &os);
>                                 else
> -                                       print_counter(config, counter, os.prefix);
> +                                       print_counter(config, counter, &os);
>                         }
>                 }
>                 break;
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
