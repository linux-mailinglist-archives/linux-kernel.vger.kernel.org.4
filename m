Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294575FA88E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJJXRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJJXRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:17:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C77175A8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:17:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id t4so7613381wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aaDd0ODXQ6mBIvOHNDB+WJAKo8Eo3Nj0ghA1H4l0UjQ=;
        b=nOm/zP9qX7nlptEFA/jDIJ5HVDwR5VwoN96KofngwXxRDTqNB85IL9jCwuROKV6iZx
         ADs0TcpoeUHBbsetvlD4mIIHDBHUiYJZP7l9HSgwcq0HdS48CAzw++YoIFUdrCvF5dLf
         LyhnKMwE+HyiMkmyipuy8JhTdYHFA0LojS9ayWqqmWHfJSnvmHRKuqnOBrL5o/CsUY5l
         k8Ah465az6E6ZNArW2fIaQDZqvew6JdsMx41aTFq1cQm3y2/cHHq8WNOu50b8CDhyj8B
         N2l4hQbrCihLvxfeICuN+6+D8tN2nuIZCHUfdlaKp2SNXSaHpsvMCFky4ADI4D7e4z5r
         MsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaDd0ODXQ6mBIvOHNDB+WJAKo8Eo3Nj0ghA1H4l0UjQ=;
        b=g5jXDzbjAOsCHxQ1sd7CiMIFVjKmk9lMk1GjvJhy6gtf/t+27vfeBwYqOUHm2WvVsg
         snG/xp3SFTk72eJO8/7lzmFFlKhD4CzVnoA9ov3yZTyl84Spy5TjxqztFBAeOcuAPyXh
         ls9wNSfe8SOGYPHKrsAoClDsYfb9pn9BqCqX6jNPI9NYRdUIHJS5TjHEGAHLZhMpgUUF
         yHlSS3WbJmCIYvNAVayxv/q7IyNcIZG912Uz3vEVNp5P4ZprKO088k42q7jrUfgH3pQn
         C8CK3y+ECwU1nfrw625aiyNuzSKTPX062CutE3FdPutktYwJYQdq4ZI8P8FM+PHpO9eC
         p4Vg==
X-Gm-Message-State: ACrzQf0gZcsh88VOqEcud1AN2EwroP9LriN4tMoNKVHpmjW4u5b/+wZA
        YO61q8HjmmmbKCHpKra7KIXL5FfoMCYSigopEICOVw==
X-Google-Smtp-Source: AMsMyM5y5E1JaUuUcczNXBzhys3kFZcIfqZyKc02F0dcjkz3TJo4n7foKSQbxRDuuCgcs7BwYaIuzPJY+nOSPRs3GIY=
X-Received: by 2002:a05:600c:19ce:b0:3b4:c709:4307 with SMTP id
 u14-20020a05600c19ce00b003b4c7094307mr21174171wmq.182.1665443856936; Mon, 10
 Oct 2022 16:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-11-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-11-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:17:24 -0700
Message-ID: <CAP-5=fWOsyXHC_wTjGr0MRoaohhWyQZA8jmn5W+RivNhp6tcaQ@mail.gmail.com>
Subject: Re: [PATCH 10/19] perf stat: Aggregate per-thread stats using evsel->stats->aggr
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
> Per-thread aggregation doesn't use the CPU numbers but the logic should
> be the same.  Initialize cpu_aggr_map separately for AGGR_THREAD and use
> thread map idx to aggregate counter values.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 31 +++++++++++++++++++++++++++++++
>  tools/perf/util/stat.c    | 19 +++++++++++++++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 139e35ed68d3..c76240cfc635 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1468,6 +1468,21 @@ static int perf_stat_init_aggr_mode(void)
>                 stat_config.aggr_get_id = aggr_mode__get_id(stat_config.aggr_mode);
>         }
>
> +       if (stat_config.aggr_mode == AGGR_THREAD) {
> +               nr = perf_thread_map__nr(evsel_list->core.threads);
> +               stat_config.aggr_map = cpu_aggr_map__empty_new(nr);
> +               if (stat_config.aggr_map == NULL)
> +                       return -ENOMEM;
> +
> +               for (int s = 0; s < nr; s++) {
> +                       struct aggr_cpu_id id = aggr_cpu_id__empty();
> +
> +                       id.thread_idx = s;
> +                       stat_config.aggr_map->map[s] = id;
> +               }
> +               return 0;
> +       }
> +
>         /*
>          * The evsel_list->cpus is the base we operate on,
>          * taking the highest cpu number to be the size of
> @@ -1677,6 +1692,22 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
>         aggr_cpu_id_get_t get_id = aggr_mode__get_aggr_file(stat_config.aggr_mode);
>         bool needs_sort = stat_config.aggr_mode != AGGR_NONE;
>
> +       if (stat_config.aggr_mode == AGGR_THREAD) {
> +               int nr = perf_thread_map__nr(evsel_list->core.threads);
> +
> +               stat_config.aggr_map = cpu_aggr_map__empty_new(nr);
> +               if (stat_config.aggr_map == NULL)
> +                       return -ENOMEM;
> +
> +               for (int s = 0; s < nr; s++) {
> +                       struct aggr_cpu_id id = aggr_cpu_id__empty();
> +
> +                       id.thread_idx = s;
> +                       stat_config.aggr_map->map[s] = id;
> +               }
> +               return 0;
> +       }
> +
>         if (!get_id)
>                 return 0;
>
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 99874254809d..013dbe1c5d28 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -403,6 +403,24 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>                 evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
>         perf_counts_values__scale(count, config->scale, NULL);
>
> +       if (config->aggr_mode == AGGR_THREAD) {
> +               struct perf_counts_values *aggr_counts = &ps->aggr[thread].counts;
> +
> +               /*
> +                * Skip value 0 when enabling --per-thread globally,
> +                * otherwise too many 0 output.
> +                */
> +               if (count->val == 0 && config->system_wide)
> +                       return 0;
> +
> +               ps->aggr[thread].nr++;
> +
> +               aggr_counts->val += count->val;
> +               aggr_counts->ena += count->ena;
> +               aggr_counts->run += count->run;
> +               goto update;

nit: perhaps there is a more intention revealing name than update here.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> +       }
> +
>         if (ps->aggr) {
>                 struct perf_cpu cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx);
>                 struct aggr_cpu_id aggr_id = config->aggr_get_id(config, cpu);
> @@ -437,6 +455,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>                 }
>         }
>
> +update:
>         switch (config->aggr_mode) {
>         case AGGR_THREAD:
>         case AGGR_CORE:
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
