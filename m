Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D411B636E56
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKWXZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiKWXZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:25:27 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8656110902
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:25:26 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z4so16474wrr.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=chKYKremI8l82yLQBleCjCfCnE6ikjwksdBvNeUY2BY=;
        b=F2H0b8sbV3VuxorK3eUw56iopjhu2K4/r/sIVLjgacR+sPFVdX4Va4sie9GQFuKMBy
         UWagscDfZGav1T6v9KGGJZ5XYna09Or3U4adG7YIbnW/+8bQyoXeSnAvrFt6r2A4Znvn
         sUSvfFPjiW2xANP7aUBCn+k95uKy3FEMnzfVJYhU1oH+hWpRYGf+El4UhLj7EmgJNoIM
         lFHQWqjwVpTGoRuQKofShYE7P85nbYHFIC3g6Xsiy9lH828GrOLshouScZLw9QbO+4dS
         2quHGRqIQJbbIL+GkSxCfVrGRzh5G17O+4PG2DVukvA7F31Pq3KEeeRv8DACZkRrKejJ
         hMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chKYKremI8l82yLQBleCjCfCnE6ikjwksdBvNeUY2BY=;
        b=1WDTAwN7xNj/fIdvySJK/za9kjYTZkVLKaT4ltXy6RDXOWbjhmIucc89kVb4VZfyYW
         wkLjQ2dEzysShpGH6btghFiOIMnfu0cU+Y9Z/8Vn0E2I52YMO0+x2Rtzv6UzUSVQL3Gt
         kAothHmkZxuZzUPMBxOOyVIDi7COFHPpsEm1C9rZQbdjZkvLD1/LMqNdPXXJLsSwJR7I
         KD1lC8GpdutkGYZH/ZOF2gag8yjmW6U5atwsFxlrjgBhCrLKOB5xl9IezWPeoa9sBcCl
         82PLshxTd1UHVIA+oc9X3SspCNFwSwVpbkp3TXaMXp5MtA1dEh+tqGE0BHFCQkM9vnaQ
         ylvQ==
X-Gm-Message-State: ANoB5pm7h6G4eZQ/DHBsvp2UcjtEiCxuv5KYXrXv6O43Ut98OpNBRdRX
        Vf+rsIvabF9RUTb1CX+f2kGo1YeyhFBY2vYqnOdH9w==
X-Google-Smtp-Source: AA0mqf6Z28mDgI/9Rdc1hv42MikVHtNHpL7i0pTnq4MkKZ72ZL8P7DnAmFcx4BoffQVhh5vyF1UeNfgmg1JY8fWEUNo=
X-Received: by 2002:adf:f6cc:0:b0:228:dd1d:8a42 with SMTP id
 y12-20020adff6cc000000b00228dd1d8a42mr7212105wrp.375.1669245924985; Wed, 23
 Nov 2022 15:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-10-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-10-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:25:12 -0800
Message-ID: <CAP-5=fUA-tFcpkWy2w29ou09GdoEU8e8ZFSgab12-QGPfH5g3w@mail.gmail.com>
Subject: Re: [PATCH 09/15] perf stat: Pass struct outstate to print_metric_begin()
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
> It passes prefix and cgroup pointers but the outstate already has them.
> Let's pass the outstate pointer instead.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 50 +++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 70aebf359e16..3ed63061d6f8 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -843,8 +843,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>
>  static void print_metric_begin(struct perf_stat_config *config,
>                                struct evlist *evlist,
> -                              const char *prefix, int aggr_idx,
> -                              struct cgroup *cgrp)
> +                              struct outstate *os, int aggr_idx)
>  {
>         struct perf_stat_aggr *aggr;
>         struct aggr_cpu_id id;
> @@ -853,15 +852,15 @@ static void print_metric_begin(struct perf_stat_config *config,
>         if (!config->metric_only)
>                 return;
>
> -       if (prefix)
> -               fprintf(config->output, "%s", prefix);
> +       if (os->prefix)
> +               fprintf(config->output, "%s", os->prefix);
>
>         evsel = evlist__first(evlist);
>         id = config->aggr_map->map[aggr_idx];
>         aggr = &evsel->stats->aggr[aggr_idx];
>         aggr_printout(config, evsel, id, aggr->nr);
>
> -       print_cgroup(config, cgrp);
> +       print_cgroup(config, os->cgrp);
>  }
>
>  static void print_metric_end(struct perf_stat_config *config)
> @@ -877,6 +876,9 @@ static void print_aggr(struct perf_stat_config *config,
>                        const char *prefix)
>  {
>         struct evsel *counter;
> +       struct outstate os = {
> +               .prefix = prefix,
> +       };
>         int s;
>
>         if (!config->aggr_map || !config->aggr_get_id)
> @@ -887,7 +889,7 @@ static void print_aggr(struct perf_stat_config *config,
>          * Without each counter has its own line.
>          */
>         for (s = 0; s < config->aggr_map->nr; s++) {
> -               print_metric_begin(config, evlist, prefix, s, /*cgrp=*/NULL);
> +               print_metric_begin(config, evlist, &os, s);
>
>                 evlist__for_each_entry(evlist, counter) {
>                         if (counter->merged_stat)
> @@ -904,26 +906,28 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
>                               const char *prefix)
>  {
>         struct evsel *counter, *evsel;
> -       struct cgroup *cgrp = NULL;
> +       struct outstate os = {
> +               .prefix = prefix,
> +       };
>         int s;
>
>         if (!config->aggr_map || !config->aggr_get_id)
>                 return;
>
>         evlist__for_each_entry(evlist, evsel) {
> -               if (cgrp == evsel->cgrp)
> +               if (os.cgrp == evsel->cgrp)
>                         continue;
>
> -               cgrp = evsel->cgrp;
> +               os.cgrp = evsel->cgrp;
>
>                 for (s = 0; s < config->aggr_map->nr; s++) {
> -                       print_metric_begin(config, evlist, prefix, s, cgrp);
> +                       print_metric_begin(config, evlist, &os, s);
>
>                         evlist__for_each_entry(evlist, counter) {
>                                 if (counter->merged_stat)
>                                         continue;
>
> -                               if (counter->cgrp != cgrp)
> +                               if (counter->cgrp != os.cgrp)
>                                         continue;
>
>                                 print_counter_aggrdata(config, counter, s, prefix);
> @@ -956,6 +960,9 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>  {
>         int all_idx;
>         struct perf_cpu cpu;
> +       struct outstate os = {
> +               .prefix = prefix,
> +       };
>
>         perf_cpu_map__for_each_cpu(cpu, all_idx, evlist->core.user_requested_cpus) {
>                 struct evsel *counter;
> @@ -973,8 +980,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>
>                         id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
>                         if (first) {
> -                               print_metric_begin(config, evlist, prefix,
> -                                                  counter_idx, /*cgrp=*/NULL);
> +                               print_metric_begin(config, evlist, &os, counter_idx);
>                                 first = false;
>                         }
>                         val = ps->aggr[counter_idx].counts.val;
> @@ -1347,22 +1353,23 @@ static void print_percore(struct perf_stat_config *config,
>  static void print_cgroup_counter(struct perf_stat_config *config, struct evlist *evlist,
>                                  const char *prefix)
>  {
> -       struct cgroup *cgrp = NULL;
>         struct evsel *counter;
> +       struct outstate os = {
> +               .prefix = prefix,
> +       };
>
>         evlist__for_each_entry(evlist, counter) {
> -               if (cgrp != counter->cgrp) {
> -                       if (cgrp != NULL)
> +               if (os.cgrp != counter->cgrp) {
> +                       if (os.cgrp != NULL)
>                                 print_metric_end(config);
>
> -                       cgrp = counter->cgrp;
> -                       print_metric_begin(config, evlist, prefix,
> -                                          /*aggr_idx=*/0, cgrp);
> +                       os.cgrp = counter->cgrp;
> +                       print_metric_begin(config, evlist, &os, /*aggr_idx=*/0);
>                 }
>
>                 print_counter(config, counter, prefix);
>         }
> -       if (cgrp)
> +       if (os.cgrp)
>                 print_metric_end(config);
>  }
>
> @@ -1405,8 +1412,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>                 } else if (config->cgroup_list) {
>                         print_cgroup_counter(config, evlist, os.prefix);
>                 } else {
> -                       print_metric_begin(config, evlist, os.prefix,
> -                                          /*aggr_idx=*/0, /*cgrp=*/NULL);
> +                       print_metric_begin(config, evlist, &os, /*aggr_idx=*/0);
>                         evlist__for_each_entry(evlist, counter) {
>                                 print_counter(config, counter, os.prefix);
>                         }
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
