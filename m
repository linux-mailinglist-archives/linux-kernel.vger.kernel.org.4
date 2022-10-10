Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F118D5FA87F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJJXNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJJXNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:13:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FA3DEC6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:13:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f11so19046113wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YWGCaWiZYaaJ8cehx8ngSOsiWa1royEkv9lHhXb/5t8=;
        b=ZbwK+zdEt+9pt7fbuGenNszIe2JSamFU8CxvNae6DP6tq5xaCShgHXo6uMb+vtvhxy
         XAvsPqoXfEwu5DYteHWDW/GVJzsbLgSFZiPfrakOBaZrzcyThk/wmKL5j968v6fUvoFP
         bQfA4zDzjTjbRdxHjaVTBB7LxTgwoGJZtAT+OPce6ljfjj+EXzO286/JEfzBx3lRzXp/
         lqyHQN3SpJrUg83o8rfjcyl2K5CQuNTjVln8wsBXKKdHRtlB6Oe26/6e6CHdagZgo3ug
         N1ZQ/zYjmtktLM7IXhuEFAtCCgfCdkWNcPWjH6/wzQEM1pxiXkRI50/bFessmVvn4y14
         frWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWGCaWiZYaaJ8cehx8ngSOsiWa1royEkv9lHhXb/5t8=;
        b=zn/GeWI3XnVyPcZRdOYFs1iLpHJ86FG1yRBkhvKw304QYvUPSjFvUikSxBjEvU9R/G
         yAgHE+KdSWpET6Ylt0bTll80h2rHu+7W1sO2Fc3/+6b93OlKq1RhYl3TnRWG8wYthIXu
         1DQm1JUUchdY3xiNmKa36W2AjLtK/VNvZ2GkgoT/nX6ufDFpen6wEI7WqKQJ4CLsip9e
         RrypLJonbXLIBSV6CNr4r7MS+6yIbruVU1Q+8oueq9Y/nNffgnY/soNAQEwsJdIowCxP
         zMGd1FYDd0P2VtrZhACbVMuM3yq5N5Z3Cdri9eZPJGgSLoKFrvroMqfxxySxg1IwTGKH
         h+tQ==
X-Gm-Message-State: ACrzQf3FId3drvJy7Umf6ham09wjnW2qmGKEjw88pg73ERLxO0HfR13c
        VHiAzRs7azZDOodJoIjLffIYBddTBowZChXdk9yzKg==
X-Google-Smtp-Source: AMsMyM5cl8JJwvINqG1U/eUKF8BayyEh3iNQ67ByiS09RHCLFUtw03iUklYTq3MgU8io5I/wWoV9eXY/FGwZrLHCZuQ=
X-Received: by 2002:a5d:68d0:0:b0:22c:dfba:3bd6 with SMTP id
 p16-20020a5d68d0000000b0022cdfba3bd6mr12735284wrw.300.1665443480489; Mon, 10
 Oct 2022 16:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-10-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-10-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:11:07 -0700
Message-ID: <CAP-5=fVW31CH6vhw4zECP-DZbxq8c2V=+C68e5c20LD-xxYbBA@mail.gmail.com>
Subject: Re: [PATCH 09/19] perf stat: Aggregate events using evsel->stats->aggr
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
> Add a logic to aggregate counter values to the new evsel->stats->aggr.
> This is not used yet so shadow stats are not updated.  But later patch
> will convert the existing code to use it.
>
> With that, we don't need to handle AGGR_GLOBAL specially anymore.  It
> can use the same logic with counts, prev_counts and aggr_counts.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c                     |  3 --
>  tools/perf/util/evsel.c                       |  9 +---
>  .../scripting-engines/trace-event-python.c    |  6 ---
>  tools/perf/util/stat.c                        | 46 ++++++++++++++++---
>  4 files changed, 41 insertions(+), 23 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index eaddafbd7ff2..139e35ed68d3 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -963,9 +963,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>                 init_stats(&walltime_nsecs_stats);
>                 update_stats(&walltime_nsecs_stats, t1 - t0);
>
> -               if (stat_config.aggr_mode == AGGR_GLOBAL)
> -                       evlist__save_aggr_prev_raw_counts(evsel_list);
> -
>                 evlist__copy_prev_raw_counts(evsel_list);
>                 evlist__reset_prev_raw_counts(evsel_list);
>                 perf_stat__reset_shadow_per_stat(&rt_stat);
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a6ea91c72659..a1fcb3166149 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1526,13 +1526,8 @@ void evsel__compute_deltas(struct evsel *evsel, int cpu_map_idx, int thread,
>         if (!evsel->prev_raw_counts)
>                 return;
>
> -       if (cpu_map_idx == -1) {
> -               tmp = evsel->prev_raw_counts->aggr;
> -               evsel->prev_raw_counts->aggr = *count;
> -       } else {
> -               tmp = *perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
> -               *perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread) = *count;
> -       }
> +       tmp = *perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
> +       *perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread) = *count;
>
>         count->val = count->val - tmp.val;
>         count->ena = count->ena - tmp.ena;
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 1f2040f36d4e..7bc8559dce6a 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -1653,12 +1653,6 @@ static void python_process_stat(struct perf_stat_config *config,
>         struct perf_cpu_map *cpus = counter->core.cpus;
>         int cpu, thread;
>
> -       if (config->aggr_mode == AGGR_GLOBAL) {
> -               process_stat(counter, (struct perf_cpu){ .cpu = -1 }, -1, tstamp,
> -                            &counter->counts->aggr);
> -               return;
> -       }
> -
>         for (thread = 0; thread < threads->nr; thread++) {
>                 for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
>                         process_stat(counter, perf_cpu_map__cpu(cpus, cpu),
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 374149628507..99874254809d 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -387,6 +387,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>                        struct perf_counts_values *count)
>  {
>         struct perf_counts_values *aggr = &evsel->counts->aggr;
> +       struct perf_stat_evsel *ps = evsel->stats;
>         static struct perf_counts_values zero;
>         bool skip = false;
>
> @@ -398,6 +399,44 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>         if (skip)
>                 count = &zero;
>
> +       if (!evsel->snapshot)
> +               evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
> +       perf_counts_values__scale(count, config->scale, NULL);
> +
> +       if (ps->aggr) {
> +               struct perf_cpu cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx);
> +               struct aggr_cpu_id aggr_id = config->aggr_get_id(config, cpu);
> +               struct perf_stat_aggr *ps_aggr;
> +               int i;
> +
> +               for (i = 0; i < ps->nr_aggr; i++) {

Would it be cleaner to have a helper function here that returns i or
ps_aggr for the first CPU being aggregated into? That would avoid the
continue/break.

> +                       if (!aggr_cpu_id__equal(&aggr_id, &config->aggr_map->map[i]))
> +                               continue;
> +
> +                       ps_aggr = &ps->aggr[i];
> +                       ps_aggr->nr++;
> +
> +                       /*
> +                        * When any result is bad, make them all to give
> +                        * consistent output in interval mode.
> +                        */
> +                       if (count->ena == 0 || count->run == 0 ||
> +                           evsel->counts->scaled == -1) {
> +                               ps_aggr->counts.val = 0;
> +                               ps_aggr->counts.ena = 0;
> +                               ps_aggr->counts.run = 0;
> +                               ps_aggr->failed = true;
> +                       }
> +
> +                       if (!ps_aggr->failed) {
> +                               ps_aggr->counts.val += count->val;
> +                               ps_aggr->counts.ena += count->ena;
> +                               ps_aggr->counts.run += count->run;
> +                       }
> +                       break;
> +               }
> +       }
> +
>         switch (config->aggr_mode) {
>         case AGGR_THREAD:
>         case AGGR_CORE:
> @@ -405,9 +444,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>         case AGGR_SOCKET:
>         case AGGR_NODE:
>         case AGGR_NONE:
> -               if (!evsel->snapshot)
> -                       evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
> -               perf_counts_values__scale(count, config->scale, NULL);
>                 if ((config->aggr_mode == AGGR_NONE) && (!evsel->percore)) {
>                         perf_stat__update_shadow_stats(evsel, count->val,
>                                                        cpu_map_idx, &rt_stat);
> @@ -469,10 +505,6 @@ int perf_stat_process_counter(struct perf_stat_config *config,
>         if (config->aggr_mode != AGGR_GLOBAL)
>                 return 0;
>
> -       if (!counter->snapshot)
> -               evsel__compute_deltas(counter, -1, -1, aggr);
> -       perf_counts_values__scale(aggr, config->scale, &counter->counts->scaled);
> -

It isn't clear to me how this relates to the patch.

Thanks,
Ian

>         update_stats(&ps->res_stats, *count);
>
>         if (verbose > 0) {
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
