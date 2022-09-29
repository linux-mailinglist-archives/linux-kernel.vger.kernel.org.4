Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915185EEB72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiI2CKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiI2CKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:10:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7636F26C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:10:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bq9so22393334wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=McUeWFisyAXbBS30rhPTGT3jxKSTPpwZNRyUiaoZ2LI=;
        b=ZXGnFZs0GTWDZ862QYP3gB56TlI850v1RCQN67K/ynRyepyzgeqDbjhHAkHvuxe/c7
         KhnO4/uMyS8IaxA1gFgexr7MuFB/7ZKp5KF5lTZFHkBsygvksxHys2znR7e4CY271kHw
         7BAmoRGXD+6Z4nlVFFDYuSBeXm/GOQV4AXpCBpZhiYPTsv7bWVzg+qQJmEcHd2QT2OUs
         rLbcRz7KEjVXLc9TI5o1wh621LM/4ivGP/WCj4vdKHd+m87exbt6g0gDtd35ShUE3E00
         phsv+JhLe1pXbIGmu/lzaCgsLlq/mF5JP/APBY1ah6+jZwEPhbuwJLJc28az//jONhTi
         vxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=McUeWFisyAXbBS30rhPTGT3jxKSTPpwZNRyUiaoZ2LI=;
        b=bbU/2gIZzgmIm/AlH/RCKDOjJ2+1Mb0fEe86Z0udcTcLc0/DAdJrf5780J+WLgTZML
         PONb6GPiOK6Q4PmNTABN7NoinvCAEWhVxY4xAE/eqUyVqmx7LoBlM5y3YM8vyKnApDWV
         QAFXy1yVWSShPIXDyUodxK2OeiOvs2yvqH25C0w0NjI1XIj71CcdGiJ9HWMBsU4ZHnai
         1PRJiof/n75GTjP1oLMNR0goDHLwVcG45spsjI+oZ1m5E1TvHeMpn1DBFxZib7xqMnV+
         aiagJvGKjoU2xHIo/o7IfRtRLyZt0f9IzcSk+dQGvQ9UEe+FV+PPfCWDwgBkRQEcY4P9
         t9qw==
X-Gm-Message-State: ACrzQf1BZphzpRhqWKg0m3VXl7MB4GcsBu8EovyzScI37qvqCxNRzsl9
        qP2vutq0kjn+G6l1YstU7P1xNM8yzW2IMl0+4W3TuA==
X-Google-Smtp-Source: AMsMyM7DY+AI9Df4qRaQp6fexXsn9392JixJ2OEBqQ+GNQ43rnKmAnLKG1k7Y1en2GJr1UKHx6bvdWdQhooN9W7QGYQ=
X-Received: by 2002:adf:bc13:0:b0:228:6d28:d2cb with SMTP id
 s19-20020adfbc13000000b002286d28d2cbmr439652wrg.375.1664417432478; Wed, 28
 Sep 2022 19:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220926200757.1161448-1-namhyung@kernel.org> <20220926200757.1161448-5-namhyung@kernel.org>
In-Reply-To: <20220926200757.1161448-5-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 28 Sep 2022 19:10:19 -0700
Message-ID: <CAP-5=fVY2QP6f=8CvZqERCZzH+sB6A-_wK-edukrz4eeGUz5zg@mail.gmail.com>
Subject: Re: [PATCH 4/6] perf stat: Use thread map index for shadow stat
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
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

On Mon, Sep 26, 2022 at 1:08 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> When AGGR_THREAD is active, it aggregates the values for each thread.
> Previously it used cpu map index which is invalid for AGGR_THREAD so
> it had to use separate runtime stats with index 0.
>
> But it can just use the rt_stat with thread_map_index.  Rename the
> first_shadow_map_idx() and make it return the thread index.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 20 +++++++++-----------
>  tools/perf/util/stat.c         |  8 ++------
>  2 files changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 234491f43c36..570e2c04d47d 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -442,7 +442,7 @@ static void print_metric_header(struct perf_stat_config *config,
>                 fprintf(os->fh, "%*s ", config->metric_only_len, unit);
>  }
>
> -static int first_shadow_cpu_map_idx(struct perf_stat_config *config,
> +static int first_shadow_map_idx(struct perf_stat_config *config,
>                                 struct evsel *evsel, const struct aggr_cpu_id *id)
>  {
>         struct perf_cpu_map *cpus = evsel__cpus(evsel);
> @@ -452,6 +452,9 @@ static int first_shadow_cpu_map_idx(struct perf_stat_config *config,
>         if (config->aggr_mode == AGGR_NONE)
>                 return perf_cpu_map__idx(cpus, id->cpu);
>
> +       if (config->aggr_mode == AGGR_THREAD)
> +               return id->thread;

The function's name implies returning an index but that isn't clear
here. Can we change the aggr_cpu_id's thread to be called thread_idx?

Thanks,
Ian

> +
>         if (!config->aggr_get_id)
>                 return 0;
>
> @@ -646,7 +649,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>         }
>
>         perf_stat__print_shadow_stats(config, counter, uval,
> -                               first_shadow_cpu_map_idx(config, counter, &id),
> +                               first_shadow_map_idx(config, counter, &id),
>                                 &out, &config->metric_events, st);
>         if (!config->csv_output && !config->metric_only && !config->json_output) {
>                 print_noise(config, counter, noise);
> @@ -676,7 +679,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
>                                 val += perf_counts(counter->counts, idx, 0)->val;
>                         }
>                         perf_stat__update_shadow_stats(counter, val,
> -                                       first_shadow_cpu_map_idx(config, counter, &id),
> +                                       first_shadow_map_idx(config, counter, &id),
>                                         &rt_stat);
>                 }
>         }
> @@ -979,14 +982,9 @@ static void print_aggr_thread(struct perf_stat_config *config,
>                         fprintf(output, "%s", prefix);
>
>                 id = buf[thread].id;
> -               if (config->stats)
> -                       printout(config, id, 0, buf[thread].counter, buf[thread].uval,
> -                                prefix, buf[thread].run, buf[thread].ena, 1.0,
> -                                &config->stats[id.thread]);
> -               else
> -                       printout(config, id, 0, buf[thread].counter, buf[thread].uval,
> -                                prefix, buf[thread].run, buf[thread].ena, 1.0,
> -                                &rt_stat);
> +               printout(config, id, 0, buf[thread].counter, buf[thread].uval,
> +                        prefix, buf[thread].run, buf[thread].ena, 1.0,
> +                        &rt_stat);
>                 fputc('\n', output);
>         }
>
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index e1d3152ce664..21137c9d5259 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -389,12 +389,8 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>                 }
>
>                 if (config->aggr_mode == AGGR_THREAD) {
> -                       if (config->stats)
> -                               perf_stat__update_shadow_stats(evsel,
> -                                       count->val, 0, &config->stats[thread]);
> -                       else
> -                               perf_stat__update_shadow_stats(evsel,
> -                                       count->val, 0, &rt_stat);
> +                       perf_stat__update_shadow_stats(evsel, count->val,
> +                                                      thread, &rt_stat);
>                 }
>                 break;
>         case AGGR_GLOBAL:
> --
> 2.37.3.998.g577e59143f-goog
>
