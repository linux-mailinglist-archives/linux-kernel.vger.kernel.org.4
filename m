Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133C05FA7D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJJWqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJJWq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:46:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09E21FCD1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:46:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso9341417wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HIMCbajzveX/UO+hMXpItMPlpA1st1BwJ3aW/fV1JmE=;
        b=lB/ABL4TnWEIjaty2U5G+YO/UEqYRcQPtZO6UMJC0Ihz8IkuiWSzajTP1wYtdKPkZl
         /KPNKRxE6gcbg9vHr5zhL8cEdIXnFWs2lFaOmTPMGsRjGQB8R3JhK3VAmcK1ndCZNAp1
         fyXxGoz3jrojTKcJxdR2AsareHQ3IrTJA8XTFObHVEoKQ12oWx5Kn+2pwmCzqQ4t2DTj
         1pvEaLrfd2QgYVGi4dU2dXE8SFjmPgTkEhhwRyq90nSgV8eRTTYhIyFToOM+FQFvrkKv
         BGj3EA3zrWbdZqlCL2fIGJqEiKrWP66kZfeks5FEImzOBETWmuNOSNRaNFP2+mia6TCv
         tl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIMCbajzveX/UO+hMXpItMPlpA1st1BwJ3aW/fV1JmE=;
        b=Wkdx1nupUaq9OLCgWEJJXRo2hk31UWMCY+lmqrW2stbHMfiiTE8AfL3capuC1hX28b
         h43ilZbCt9kT+A1DgIaYaK1wJSYdQzUbIgBMV1q34RkCe34bUTB70ve/+Eum6roPAkwG
         tM2CXP5J5+1rBgplCWElwwi5qUeYh6/0XFUehjZ1IN7+m0l56qWw8JFItS+MWYG8XYYo
         UO4Wvy0NzTWoBdlEhJ7U4rg7a9d+wMl1Id4EwDMLEOBT1XRrz/38A/EAWvntkwPR+ovr
         cBhXZA3boABr2DWAh5bfnUhmAR4ruIiMGU8Bac78PdsZUo4qaaUfeh0uByDew9UnSkCs
         UbrQ==
X-Gm-Message-State: ACrzQf02GNrpTW/fHngPwEPOMiwdhrWyXrwPq2s0Ou/CyScbxa3opwOQ
        KnkWvPSrEUTXCzJ9MgxbePdpPf86XQZ8RVx3Nnwp0Q==
X-Google-Smtp-Source: AMsMyM5QaCm/RKUFtyUMVPM2RWiJMRiagqcFPxkrMJKu8FyVbOQx9O6uCrNc6cn+0w629/yjOPX2B5EARE00HfL9K9E=
X-Received: by 2002:a05:600c:4e94:b0:3b4:b416:46c3 with SMTP id
 f20-20020a05600c4e9400b003b4b41646c3mr14550524wmq.149.1665441983731; Mon, 10
 Oct 2022 15:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-5-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-5-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 15:46:10 -0700
Message-ID: <CAP-5=fUTJUWYXEBxUKSTRqWLw3Ckuy+0nq0fpUQNgt3_BVEFdA@mail.gmail.com>
Subject: Re: [PATCH 04/19] perf stat: Add aggr id for global mode
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
> To make the code simpler, I'd like to use the same aggregation code for
> the global mode.  We can simply add an id function to return cpu 0 and
> use print_aggr().
>
> No functional change intended.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c      | 39 ++++++++++++++++++++++++++++++++--
>  tools/perf/util/cpumap.c       | 10 +++++++++
>  tools/perf/util/cpumap.h       |  6 +++++-
>  tools/perf/util/stat-display.c |  9 ++------
>  4 files changed, 54 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 265b05157972..144bb3a657f2 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1330,6 +1330,15 @@ static struct aggr_cpu_id perf_stat__get_node(struct perf_stat_config *config __
>         return aggr_cpu_id__node(cpu, /*data=*/NULL);
>  }
>
> +static struct aggr_cpu_id perf_stat__get_global(struct perf_stat_config *config __maybe_unused,
> +                                               struct perf_cpu cpu __maybe_unused)
> +{
> +       struct aggr_cpu_id id = aggr_cpu_id__empty();
> +
> +       id.cpu = (struct perf_cpu){ .cpu = 0 };
> +       return id;
> +}
> +

See below, I think this should just return aggr_cpu_id__global or just
call that directly.

>  static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
>                                               aggr_get_id_t get_id, struct perf_cpu cpu)
>  {
> @@ -1366,6 +1375,12 @@ static struct aggr_cpu_id perf_stat__get_node_cached(struct perf_stat_config *co
>         return perf_stat__get_aggr(config, perf_stat__get_node, cpu);
>  }
>
> +static struct aggr_cpu_id perf_stat__get_global_cached(struct perf_stat_config *config,
> +                                                      struct perf_cpu cpu)
> +{
> +       return perf_stat__get_aggr(config, perf_stat__get_global, cpu);
> +}
> +
>  static bool term_percore_set(void)
>  {
>         struct evsel *counter;
> @@ -1395,6 +1410,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
>
>                 return NULL;
>         case AGGR_GLOBAL:
> +               return aggr_cpu_id__global;
>         case AGGR_THREAD:
>         case AGGR_UNSET:
>         case AGGR_MAX:
> @@ -1420,6 +1436,7 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
>                 }
>                 return NULL;
>         case AGGR_GLOBAL:
> +               return perf_stat__get_global_cached;
>         case AGGR_THREAD:
>         case AGGR_UNSET:
>         case AGGR_MAX:
> @@ -1535,6 +1552,16 @@ static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(struct perf_cpu cpu, vo
>         return id;
>  }
>
> +static struct aggr_cpu_id perf_env__get_global_aggr_by_cpu(struct perf_cpu cpu __maybe_unused,
> +                                                          void *data __maybe_unused)
> +{
> +       struct aggr_cpu_id id = aggr_cpu_id__empty();
> +
> +       /* it always aggregates to the cpu 0 */
> +       id.cpu = (struct perf_cpu){ .cpu = 0 };
> +       return id;
> +}
> +
>  static struct aggr_cpu_id perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
>                                                      struct perf_cpu cpu)
>  {
> @@ -1558,6 +1585,12 @@ static struct aggr_cpu_id perf_stat__get_node_file(struct perf_stat_config *conf
>         return perf_env__get_node_aggr_by_cpu(cpu, &perf_stat.session->header.env);
>  }
>
> +static struct aggr_cpu_id perf_stat__get_global_file(struct perf_stat_config *config __maybe_unused,
> +                                                    struct perf_cpu cpu)
> +{
> +       return perf_env__get_global_aggr_by_cpu(cpu, &perf_stat.session->header.env);
> +}
> +
>  static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
>  {
>         switch (aggr_mode) {
> @@ -1569,8 +1602,9 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
>                 return perf_env__get_core_aggr_by_cpu;
>         case AGGR_NODE:
>                 return perf_env__get_node_aggr_by_cpu;
> -       case AGGR_NONE:
>         case AGGR_GLOBAL:
> +               return perf_env__get_global_aggr_by_cpu;
> +       case AGGR_NONE:
>         case AGGR_THREAD:
>         case AGGR_UNSET:
>         case AGGR_MAX:
> @@ -1590,8 +1624,9 @@ static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
>                 return perf_stat__get_core_file;
>         case AGGR_NODE:
>                 return perf_stat__get_node_file;
> -       case AGGR_NONE:
>         case AGGR_GLOBAL:
> +               return perf_stat__get_global_file;
> +       case AGGR_NONE:
>         case AGGR_THREAD:
>         case AGGR_UNSET:
>         case AGGR_MAX:
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 8486ca3bec75..60209fe87456 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -354,6 +354,16 @@ struct aggr_cpu_id aggr_cpu_id__node(struct perf_cpu cpu, void *data __maybe_unu
>         return id;
>  }
>
> +struct aggr_cpu_id aggr_cpu_id__global(struct perf_cpu cpu, void *data __maybe_unused)

Is this a duplicate of aggr_cpu_id perf_stat__get_global? Could we
replace all uses of the former with this one?

Thanks,
Ian

> +{
> +       struct aggr_cpu_id id = aggr_cpu_id__empty();
> +
> +       /* it always aggregates to the cpu 0 */
> +       cpu.cpu = 0;
> +       id.cpu = cpu;
> +       return id;
> +}
> +
>  /* setup simple routines to easily access node numbers given a cpu number */
>  static int get_max_num(char *path, int *max)
>  {
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index 4a6d029576ee..b2ff648bc417 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -133,5 +133,9 @@ struct aggr_cpu_id aggr_cpu_id__cpu(struct perf_cpu cpu, void *data);
>   * cpu. The function signature is compatible with aggr_cpu_id_get_t.
>   */
>  struct aggr_cpu_id aggr_cpu_id__node(struct perf_cpu cpu, void *data);
> -
> +/**
> + * aggr_cpu_id__global - Create an aggr_cpu_id for global aggregation.
> + * The function signature is compatible with aggr_cpu_id_get_t.
> + */
> +struct aggr_cpu_id aggr_cpu_id__global(struct perf_cpu cpu, void *data);
>  #endif /* __PERF_CPUMAP_H */
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 4113aa86772f..1d8e585df4ad 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1477,13 +1477,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>                 if (config->iostat_run)
>                         iostat_print_counters(evlist, config, ts, prefix = buf,
>                                               print_counter_aggr);
> -               else {
> -                       evlist__for_each_entry(evlist, counter) {
> -                               print_counter_aggr(config, counter, prefix);
> -                       }
> -                       if (metric_only)
> -                               fputc('\n', config->output);
> -               }
> +               else
> +                       print_aggr(config, evlist, prefix);
>                 break;
>         case AGGR_NONE:
>                 if (metric_only)
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
