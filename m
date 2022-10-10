Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D115FA8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJJXkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJJXkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:40:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC27B357E1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:40:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so4153388wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rhgFbwlC8Tdzaih2ebTeg6nVkfVm0hlsdAvgaKf8hwU=;
        b=gntljk/9L6S1ODUtZClt0oJQLKBRfAOsLTkMYvtf9NgbpqQgU9WVwJpX9xsbKncLzC
         F30ThGRGMiyDPpf/vnp9ycWiif6v/x+QKpRmIbkvITdn+6FkOukWj8ef5Ge5UsZOynst
         ygjJDpX8AojpYZP2A6YYQSMS5we/muuRhrXuKL9jj1rjgzhJvJ1R5QsGTQKelZIZgRnb
         XTuPuyOGT2oXrFS0qk+WuWowfnTlL1JnyOiN/XJ+J0cGFk2OT283J+TjFbgyxDgnUE33
         2V7pp43uayIXFyISU57xh8xDlSD3jeJfM8/jlqNluxJ1xZTMfbGoY+Nz80TH5T+UbErl
         m/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhgFbwlC8Tdzaih2ebTeg6nVkfVm0hlsdAvgaKf8hwU=;
        b=lLYdTn7WlXEwjupdOjeSSPSVw0Dnh24Btyrin/EowGFAJ/49w4vV4JoR5PrLmvHeXX
         HEByF+UD/9hzX+Muvn6oesWd2VInxLz/XRnQUZVumLBJW0D6/jVCLXGyIVJ9HxiyMWO/
         Lx+P9IRJHic/FwpZjtRYPHDZulQF+mEeKgxIIx1TmrTRkkAYlUNFNIwHSC2rfEbb/Dgo
         XgtBJCl7xpbDZgu8tD1P8NVjM8Qb2gLhNdxMsTB6pCCKhCS/1azHunl2I6jU3xfdLmJq
         coQUkf8wYvOrsXlQAfbd5b295Fhe9TIXNoWL195euUwsmDmIlHEwHiOPH/YYgZFhkDQ8
         BGCA==
X-Gm-Message-State: ACrzQf0+0ez0H/nBR3rNzF/Un5z2CXlXd8KMhQUvm1Wcgo7iwv7Wy/GO
        YHJTxZbRlYhTRY0cvAmF3jBnaJAbCvCaR30KJn1exw==
X-Google-Smtp-Source: AMsMyM4VMuNwt2gTJgOf1glyKCgedbim9Z8a75c2uvkSdNp0mxCJxSFg98zgizi9kxYSfQ9nRg5E0hNUYNzYBmvQxA0=
X-Received: by 2002:a05:600c:3789:b0:3c6:beed:fecf with SMTP id
 o9-20020a05600c378900b003c6beedfecfmr3237593wmr.174.1665445200265; Mon, 10
 Oct 2022 16:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-19-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-19-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:39:48 -0700
Message-ID: <CAP-5=fUi7O8Eu_00Z4KwiPiF3X7t6FpPB2AnKv0pqY7hA4_68A@mail.gmail.com>
Subject: Re: [PATCH 18/19] perf stat: Display percore events properly
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
> The recent change in the perf stat broke the percore event display.
> Note that the aggr counts are already processed so that the every
> sibling thread in the same core will get the per-core counter values.

Could we add a test given this has broken once?

> Check percore evsels and skip the sibling threads in the display.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c      | 16 ----------------
>  tools/perf/util/stat-display.c | 27 +++++++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index d92815f4eae0..b3a39d4c86a7 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1403,18 +1403,6 @@ static struct aggr_cpu_id perf_stat__get_cpu_cached(struct perf_stat_config *con
>         return perf_stat__get_aggr(config, perf_stat__get_cpu, cpu);
>  }
>
> -static bool term_percore_set(void)
> -{
> -       struct evsel *counter;
> -
> -       evlist__for_each_entry(evsel_list, counter) {
> -               if (counter->percore)
> -                       return true;
> -       }
> -
> -       return false;
> -}
> -
>  static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
>  {
>         switch (aggr_mode) {
> @@ -1427,8 +1415,6 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
>         case AGGR_NODE:
>                 return aggr_cpu_id__node;
>         case AGGR_NONE:
> -               if (term_percore_set())
> -                       return aggr_cpu_id__core;
>                 return aggr_cpu_id__cpu;;
>         case AGGR_GLOBAL:
>                 return aggr_cpu_id__global;
> @@ -1452,8 +1438,6 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
>         case AGGR_NODE:
>                 return perf_stat__get_node_cached;
>         case AGGR_NONE:
> -               if (term_percore_set())
> -                       return perf_stat__get_core_cached;
>                 return perf_stat__get_cpu_cached;
>         case AGGR_GLOBAL:
>                 return perf_stat__get_global_cached;
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 0c0e22c175a1..e0c0df99d40d 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1094,7 +1094,8 @@ static void print_percore(struct perf_stat_config *config,
>  {
>         bool metric_only = config->metric_only;
>         FILE *output = config->output;
> -       int s;
> +       struct cpu_aggr_map *core_map;
> +       int s, c, i;
>         bool first = true;
>
>         if (!config->aggr_map || !config->aggr_get_id)
> @@ -1103,13 +1104,35 @@ static void print_percore(struct perf_stat_config *config,
>         if (config->percore_show_thread)
>                 return print_counter(config, counter, prefix);
>
> -       for (s = 0; s < config->aggr_map->nr; s++) {
> +       core_map = cpu_aggr_map__empty_new(config->aggr_map->nr);
> +       if (core_map == NULL) {
> +               fprintf(output, "Cannot allocate per-core aggr map for display\n");
> +               return;
> +       }
> +
> +       for (s = 0, c = 0; s < config->aggr_map->nr; s++) {
> +               struct perf_cpu curr_cpu = config->aggr_map->map[s].cpu;
> +               struct aggr_cpu_id core_id = aggr_cpu_id__core(curr_cpu, NULL);
> +               bool found = false;
> +
> +               for (i = 0; i < c; i++) {
> +                       if (aggr_cpu_id__equal(&core_map->map[i], &core_id)) {
> +                               found = true;
> +                               break;
> +                       }
> +               }
> +               if (found)
> +                       continue;
> +
>                 if (prefix && metric_only)
>                         fprintf(output, "%s", prefix);
>
>                 print_counter_aggrdata(config, counter, s,
>                                        prefix, metric_only, &first);
> +
> +               core_map->map[c++] = core_id;
>         }
> +       free(core_map);
>
>         if (metric_only)
>                 fputc('\n', output);
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
