Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC70E5FA8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJJXdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJJXc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:32:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B045A8A4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:32:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u10so19095219wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJf017cW87RsYFysQXCimx09o+FDle7H3MPrqyGlnFQ=;
        b=YCUNDrHYgKtfT4WDQH+oyyFJvF2gnNbgcX+0DDjXuvGrDUyAwvjAuM06n6oaQ3762t
         nRvFb7ZOTOSmR7nHlumlDgQ+TEuzHFBevSeK/InN3N3v3n+vzHEVNoYWT/UrZmrc/Xk6
         SQlV0VIocXAok/IB/FgoBf8dIsaDmvYv18SNnIF4NR/4jihu4Vef0+HwxJh7MAtAlZbb
         IdX7+xsIB7+utaXYeQ8e9+WxlhWZfi3G5fkvn5lt7PerUeQRQCY+qF+yPlX+pAdSo89i
         iAuIhVAye0VTHuFqsHpVvobSJE7/qppWuzu23ufr01Wxk0+KtdfmCMrtjjjISMGIn29y
         q9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJf017cW87RsYFysQXCimx09o+FDle7H3MPrqyGlnFQ=;
        b=i/oxvSB8CNyr3J1VtuXPUkgi1oDkg9uC6GGiip049dFHOjrFu/yYqHndv9f9JiHAHi
         cwgj9y8n2zLbMVinr+6A/DAdwxrGoFeGFIGBFD6s/hp1Z5p/TpQxtlZINDtkbyFFLEbv
         rhzxo1irM643/hLg/Y4Ig5xbFhVVlRp2RbJ/7h9gms1IS99kRZcxEYhAAaHHIO3K8q6q
         3q4UU9WbE0YtcUa2zdvvC6V3/sECmBdADYY0xSad/moZK2ckNvtbeOAbezMI4n4k3B3Y
         yu1XGW/SAVrk6vw/07WuCDcq3kRiAGaurYaNs6IgvEL4ZQ6tB4qZ/PaE4A6rTP8mJ0Rl
         V6yw==
X-Gm-Message-State: ACrzQf2/LVsLuTvNJKzcaKq18c2YgN1hOcg4SkPSQ6tWvOHmrCMGt/g2
        5pFWXIngQnoR84e5r6hx2KfeNUByWo85+r66Q3Syqw==
X-Google-Smtp-Source: AMsMyM6EM4Zphvz7zyI8JJCwWgLfdGacZGT91CKkVTMwjijDoZNh78igWosHlfWAgDx9aEn+SL/FdQiZLry9NF/laWc=
X-Received: by 2002:adf:fd50:0:b0:22e:5503:9c4c with SMTP id
 h16-20020adffd50000000b0022e55039c4cmr13100208wrs.375.1665444775439; Mon, 10
 Oct 2022 16:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-16-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-16-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:32:43 -0700
Message-ID: <CAP-5=fUKYN_kWx=nwHjer+FfsgA2OMfCK7CwZHTsrtGrRft-5g@mail.gmail.com>
Subject: Re: [PATCH 15/19] perf stat: Add perf_stat_process_percore()
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The perf_stat_process_percore() is to aggregate counts for an event per-core
> even if the aggr_mode is AGGR_NONE.  This is enabled when user requested it
> on the command line.

Is there an example command line for this? It would be nice to add as a test.

Thanks,
Ian

> To handle that, it keeps the per-cpu counts at first.  And then it aggregates
> the counts that have the same core id in the aggr->counts and updates the
> values for each cpu back.
>
> Later, per-core events will skip one of the CPUs unless percore-show-thread
> option is given.  In that case, it can simply print all cpu stats with the
> updated (per-core) values.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c |  1 +
>  tools/perf/util/stat.c    | 71 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/stat.h    |  2 ++
>  3 files changed, 74 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index f90e8f29cb23..c127e784a7be 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -488,6 +488,7 @@ static void process_counters(void)
>         }
>
>         perf_stat_merge_counters(&stat_config, evsel_list);
> +       perf_stat_process_percore(&stat_config, evsel_list);
>  }
>
>  static void process_interval(void)
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 1bb197782a34..d788d0e85204 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -671,6 +671,77 @@ void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *ev
>                 evsel__merge_stats(evsel, config);
>  }
>
> +static void evsel__update_percore_stats(struct evsel *evsel, struct aggr_cpu_id *core_id)
> +{
> +       struct perf_stat_evsel *ps = evsel->stats;
> +       struct perf_counts_values counts = { 0, };
> +       struct aggr_cpu_id id;
> +       struct perf_cpu cpu;
> +       int idx;
> +
> +       /* collect per-core counts */
> +       perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus) {
> +               struct perf_stat_aggr *aggr = &ps->aggr[idx];
> +
> +               id = aggr_cpu_id__core(cpu, NULL);
> +               if (!aggr_cpu_id__equal(core_id, &id))
> +                       continue;
> +
> +               counts.val += aggr->counts.val;
> +               counts.ena += aggr->counts.ena;
> +               counts.run += aggr->counts.run;
> +       }
> +
> +       /* update aggregated per-core counts for each CPU */
> +       perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus) {
> +               struct perf_stat_aggr *aggr = &ps->aggr[idx];
> +
> +               id = aggr_cpu_id__core(cpu, NULL);
> +               if (!aggr_cpu_id__equal(core_id, &id))
> +                       continue;
> +
> +               aggr->counts.val = counts.val;
> +               aggr->counts.ena = counts.ena;
> +               aggr->counts.run = counts.run;
> +
> +               aggr->used = true;
> +       }
> +}
> +
> +/* we have an aggr_map for cpu, but want to aggregate the counters per-core */
> +static void evsel__process_percore(struct evsel *evsel)
> +{
> +       struct perf_stat_evsel *ps = evsel->stats;
> +       struct aggr_cpu_id core_id;
> +       struct perf_cpu cpu;
> +       int idx;
> +
> +       if (!evsel->percore)
> +               return;
> +
> +       perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus) {
> +               struct perf_stat_aggr *aggr = &ps->aggr[idx];
> +
> +               if (aggr->used)
> +                       continue;
> +
> +               core_id = aggr_cpu_id__core(cpu, NULL);
> +               evsel__update_percore_stats(evsel, &core_id);
> +       }
> +}
> +
> +/* process cpu stats on per-core events */
> +void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *evlist)
> +{
> +       struct evsel *evsel;
> +
> +       if (config->aggr_mode != AGGR_NONE)
> +               return;
> +
> +       evlist__for_each_entry(evlist, evsel)
> +               evsel__process_percore(evsel);
> +}
> +
>  int perf_event__process_stat_event(struct perf_session *session,
>                                    union perf_event *event)
>  {
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 12cc60ab04e4..ac85ed46aa59 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -46,6 +46,7 @@ enum perf_stat_evsel_id {
>  struct perf_stat_aggr {
>         struct perf_counts_values       counts;
>         int                             nr;
> +       bool                            used;
>         bool                            failed;
>  };
>
> @@ -271,6 +272,7 @@ void evlist__reset_aggr_stats(struct evlist *evlist);
>  int perf_stat_process_counter(struct perf_stat_config *config,
>                               struct evsel *counter);
>  void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist);
> +void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *evlist);
>
>  struct perf_tool;
>  union perf_event;
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
