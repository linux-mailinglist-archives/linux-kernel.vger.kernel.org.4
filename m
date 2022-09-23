Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137765E8034
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiIWQzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiIWQzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:55:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCBEF685F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:55:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so866601wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5ZhohO0uO7yhIsnSHmpKo2RQXCqV/trHIAjiv5+jV/8=;
        b=jEq2IrzBatVlOHWJSmBXkgRY986qWGs2+Xrkn3rGxEaUl7X+UwL5M7NdkCtyanXbL/
         lJR9Q1PlmscZhadny7A5mU75+M1E+cthnKaTi7k5fdKRt954ej7v8qBISl72QVzssjAo
         HE5AKSO8ZS6UMdAISe3Vg9rscvHQE5dPSxo0ibw824BuOHigz4ifj0rx4V5qWUW3EH4F
         StJ0vQPSf37QF+81GWRJ+lrI441tCxrvGP7B/43Ndx/CCuEldpGjExaZrIPj/vqNOsc9
         HusTPoCalqosZz4Ihq2V90FSuLZ6clmbQHWu8Ce0wDGqOE7mUwHWa+xOcseNUQt0gaVK
         5NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5ZhohO0uO7yhIsnSHmpKo2RQXCqV/trHIAjiv5+jV/8=;
        b=UMLoQ/5I0ZGTI5MrcorrD+xrPkwwW2KgUxz/WqBwlD70SXoff+Bd6MGXzUCg0nRYmT
         lc0RGiN01e2R3xYBbaROOpVwd8cbdT/xpj05oI0hrGqs2qa09218sk2MnOO294qwde2u
         +x+pRn0Llf1yepFWbd+bC9rvkFsI7sYUBy9MWFgNWCi1JlEElfoOArOWtw23JkOgQn0c
         qYSsRmFe4VPMvNpTJdil33ImAZQpPW5g16r8VL+Gn+UxPGaaXJWuiyFGS8isJdb3Fsqa
         NLaYlhbGhJLVD7sTZwPBO88fiFjqp9FQpgTL7rhASw6t8Kq7xT5jvf7NpwahzFkwVjJ2
         Alrw==
X-Gm-Message-State: ACrzQf2bHCQWb591WcGslwv3Fhc0Z7bCbcrioHw0ivZ3Qf78/G0Gn20v
        wh2NNVg09vb4/Xu6nM1yOYdCjqhJl/ZwgRQmAE506A==
X-Google-Smtp-Source: AMsMyM66XPOCs/iLVcgSrcMInXFVlj015Arp38WZx0TGp2+986cigtkhJh3lQY5LIncC4Av9h5FJuLpR19pd3a4KPbg=
X-Received: by 2002:adf:e4ca:0:b0:228:d8b7:48a7 with SMTP id
 v10-20020adfe4ca000000b00228d8b748a7mr5692589wrm.300.1663952128554; Fri, 23
 Sep 2022 09:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220923030013.3726410-1-zhengjun.xing@linux.intel.com> <20220923030013.3726410-2-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220923030013.3726410-2-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Sep 2022 09:55:16 -0700
Message-ID: <CAP-5=fX1VY0EqmfBJ_kVJDPy3__GDVxCOOBD5r0=ifAvJjHBPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf parse-events: Remove "not supported" hybrid
 cache events
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com, Yi Ammy <ammy.yi@intel.com>
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

On Thu, Sep 22, 2022 at 7:58 PM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> By default, we create two hybrid cache events, one is for cpu_core, and
> another is for cpu_atom. But Some hybrid hardware cache events are only
> available on one CPU PMU. For example, the 'L1-dcache-load-misses' is only
> available on cpu_core, while the 'L1-icache-loads' is only available on
> cpu_atom. We need to remove "not supported" hybrid cache events. By
> extending is_event_supported() to global API and using it to check if the
> hybrid cache events are supported before being created, we can remove the
> "not supported" hybrid cache events.
>
> Before:
>
>  # ./perf stat -e L1-dcache-load-misses,L1-icache-loads -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>             52,570      cpu_core/L1-dcache-load-misses/
>    <not supported>      cpu_atom/L1-dcache-load-misses/
>    <not supported>      cpu_core/L1-icache-loads/
>          1,471,817      cpu_atom/L1-icache-loads/
>
>        1.004915229 seconds time elapsed
>
> After:
>
>  # ./perf stat -e L1-dcache-load-misses,L1-icache-loads -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>             54,510      cpu_core/L1-dcache-load-misses/
>          1,441,286      cpu_atom/L1-icache-loads/
>
>        1.005114281 seconds time elapsed
>
> Fixes: 30def61f64ba ("perf parse-events: Create two hybrid cache events")
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Reported-by: Yi Ammy <ammy.yi@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Change log:
>   v2:
>     * Adds a comment for removing "not supported" hybrid cache events.
>     * Remove goto and add a strdup check
>     * "is_event_supported" move to parse-events.c per Ian's suggestion.
>     * Adds Reported-by from Yi Ammy <ammy.yi@intel.com>
>
>  tools/perf/util/parse-events-hybrid.c | 21 ++++++++++++---
>  tools/perf/util/parse-events.c        | 39 +++++++++++++++++++++++++++
>  tools/perf/util/parse-events.h        |  1 +
>  tools/perf/util/print-events.c        | 39 ---------------------------
>  4 files changed, 57 insertions(+), 43 deletions(-)
>
> diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
> index 284f8eabd3b9..7c9f9150bad5 100644
> --- a/tools/perf/util/parse-events-hybrid.c
> +++ b/tools/perf/util/parse-events-hybrid.c
> @@ -33,7 +33,8 @@ static void config_hybrid_attr(struct perf_event_attr *attr,
>          * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
>          */
>         attr->type = type;
> -       attr->config = attr->config | ((__u64)pmu_type << PERF_PMU_TYPE_SHIFT);
> +       attr->config = (attr->config & PERF_HW_EVENT_MASK) |
> +                       ((__u64)pmu_type << PERF_PMU_TYPE_SHIFT);
>  }
>
>  static int create_event_hybrid(__u32 config_type, int *idx,
> @@ -48,13 +49,25 @@ static int create_event_hybrid(__u32 config_type, int *idx,
>         __u64 config = attr->config;
>
>         config_hybrid_attr(attr, config_type, pmu->type);
> +
> +       /*
> +        * Some hybrid hardware cache events are only available on one CPU
> +        * PMU. For example, the 'L1-dcache-load-misses' is only available
> +        * on cpu_core, while the 'L1-icache-loads' is only available on
> +        * cpu_atom. We need to remove "not supported" hybrid cache events.
> +        */
> +       if (attr->type == PERF_TYPE_HW_CACHE
> +           && !is_event_supported(attr->type, attr->config))
> +               return 0;
> +
>         evsel = parse_events__add_event_hybrid(list, idx, attr, name, metric_id,
>                                                pmu, config_terms);
> -       if (evsel)
> +       if (evsel) {
>                 evsel->pmu_name = strdup(pmu->name);
> -       else
> +               if (!evsel->pmu_name)
> +                       return -ENOMEM;
> +       } else
>                 return -ENOMEM;
> -
>         attr->type = type;
>         attr->config = config;
>         return 0;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index f05e15acd33f..f3b2c2a87456 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -28,6 +28,7 @@
>  #include "util/parse-events-hybrid.h"
>  #include "util/pmu-hybrid.h"
>  #include "tracepoint.h"
> +#include "thread_map.h"
>
>  #define MAX_NAME_LEN 100
>
> @@ -157,6 +158,44 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
>  #define PERF_EVENT_TYPE(config)                __PERF_EVENT_FIELD(config, TYPE)
>  #define PERF_EVENT_ID(config)          __PERF_EVENT_FIELD(config, EVENT)
>
> +bool is_event_supported(u8 type, u64 config)
> +{
> +       bool ret = true;
> +       int open_return;
> +       struct evsel *evsel;
> +       struct perf_event_attr attr = {
> +               .type = type,
> +               .config = config,
> +               .disabled = 1,
> +       };
> +       struct perf_thread_map *tmap = thread_map__new_by_tid(0);
> +
> +       if (tmap == NULL)
> +               return false;
> +
> +       evsel = evsel__new(&attr);
> +       if (evsel) {
> +               open_return = evsel__open(evsel, NULL, tmap);
> +               ret = open_return >= 0;
> +
> +               if (open_return == -EACCES) {
> +                       /*
> +                        * This happens if the paranoid value
> +                        * /proc/sys/kernel/perf_event_paranoid is set to 2
> +                        * Re-run with exclude_kernel set; we don't do that
> +                        * by default as some ARM machines do not support it.
> +                        *
> +                        */
> +                       evsel->core.attr.exclude_kernel = 1;
> +                       ret = evsel__open(evsel, NULL, tmap) >= 0;
> +               }
> +               evsel__delete(evsel);
> +       }
> +
> +       perf_thread_map__put(tmap);
> +       return ret;
> +}
> +
>  const char *event_type(int type)
>  {
>         switch (type) {
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 7e6a601d9cd0..07df7bb7b042 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -19,6 +19,7 @@ struct option;
>  struct perf_pmu;
>
>  bool have_tracepoints(struct list_head *evlist);
> +bool is_event_supported(u8 type, u64 config);
>
>  const char *event_type(int type);
>
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> index 04050d4f6db8..c4d5d87fae2f 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -22,7 +22,6 @@
>  #include "probe-file.h"
>  #include "string2.h"
>  #include "strlist.h"
> -#include "thread_map.h"
>  #include "tracepoint.h"
>  #include "pfm.h"
>  #include "pmu-hybrid.h"
> @@ -239,44 +238,6 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
>         strlist__delete(sdtlist);
>  }
>
> -static bool is_event_supported(u8 type, u64 config)
> -{
> -       bool ret = true;
> -       int open_return;
> -       struct evsel *evsel;
> -       struct perf_event_attr attr = {
> -               .type = type,
> -               .config = config,
> -               .disabled = 1,
> -       };
> -       struct perf_thread_map *tmap = thread_map__new_by_tid(0);
> -
> -       if (tmap == NULL)
> -               return false;
> -
> -       evsel = evsel__new(&attr);
> -       if (evsel) {
> -               open_return = evsel__open(evsel, NULL, tmap);
> -               ret = open_return >= 0;
> -
> -               if (open_return == -EACCES) {
> -                       /*
> -                        * This happens if the paranoid value
> -                        * /proc/sys/kernel/perf_event_paranoid is set to 2
> -                        * Re-run with exclude_kernel set; we don't do that
> -                        * by default as some ARM machines do not support it.
> -                        *
> -                        */
> -                       evsel->core.attr.exclude_kernel = 1;
> -                       ret = evsel__open(evsel, NULL, tmap) >= 0;
> -               }
> -               evsel__delete(evsel);
> -       }
> -
> -       perf_thread_map__put(tmap);
> -       return ret;
> -}
> -
>  int print_hwcache_events(const char *event_glob, bool name_only)
>  {
>         unsigned int type, op, i, evt_i = 0, evt_num = 0, npmus = 0;
> --
> 2.25.1
>
