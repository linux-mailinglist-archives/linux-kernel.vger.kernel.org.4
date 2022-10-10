Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128845FA8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJJXbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJJXbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:31:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D6B5A8A1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:31:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay36so7644190wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/v6g9Kdleld/yeVPU6X4g4uNgysmsgRCmKP9+LCGWtM=;
        b=KysGkKqxoou7Gs0SDD/ty7UdXRnom0BsWjYgpCJTP/vZaodGC3Y4PUtYUOMfHZThyH
         UGh1WPIbn6IpYaBZ0ETH+2u1xaA4BjfIU/Js0jvIYeNF3RIpgtOGp1SmiW4Bn2kCebC8
         spzVKBVxUsaTK23Ul34sM++ohOws+nxpu6FCE2VHqqbMplH3vRjtP0zwUAIOic6Hd2+e
         5gtSUudOf3V1Mc3xuC5RPJ8W/43MnGYvNmyvMpas738vA+xCBR56sCRTK04XH902QVgF
         rH50uv+W2a63YSPKvfIgKz3FjcCpbFebgNBeVWpDWxypBVu9IbU3QbFHBJEsdBm9Lw63
         KQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/v6g9Kdleld/yeVPU6X4g4uNgysmsgRCmKP9+LCGWtM=;
        b=arcQ/Zbs0THfeLNZ+AkJd97BllNMkSGlTNPjhLgBa7bqupq2CLf0RIgNsRs4lhOl+x
         h5BdR4VXba4aa8/Dqo8dOX8ljK+O5E3kVBGphcKLzPNw6lqxB2rsmGw3OPaiYSwvRKda
         cy8+xeP/Qp3X0hHtw4YesJnowBqWKPLr3NYdccbhoLXShjxPO+WWLazaFmTCuIObRyai
         +eNaqsckAQN0x9LwqDi0Vh6dxkZNQuCgK4q40Pe79SlS8zyztCMRqWYcywwW8cUV4wkr
         +cFKP4eETLij5wa5yP7iLe96zIQceI3qj4MP8aPPIUo+nDeZU88iLsKro4iIYKCcEvUS
         tEWg==
X-Gm-Message-State: ACrzQf0EW/TJ+zD4XnoGd5+BQnfeBrrovAYEdDqKJi4ZGfu8prdxCPLT
        i37DvHq8Cwlwgi56BL6nyt7ldMSt4XAj2T6c3HRQ6A==
X-Google-Smtp-Source: AMsMyM62f7RRRby9buK7I0POCSwoAyIv6zm2cJcUTxMAJ85tNU3YLz8SgQWzLg3ykvLENbzZBhN0AgR8O/B2xXMy8ho=
X-Received: by 2002:a05:600c:88a:b0:3c5:c9e3:15cc with SMTP id
 l10-20020a05600c088a00b003c5c9e315ccmr7075775wmp.67.1665444677484; Mon, 10
 Oct 2022 16:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-15-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-15-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:31:05 -0700
Message-ID: <CAP-5=fWxD6KJiHCDOK6UdgfQadnjCc6eMPmPY68T3TKYAz402Q@mail.gmail.com>
Subject: Re: [PATCH 14/19] perf stat: Add perf_stat_merge_counters()
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
> The perf_stat_merge_counters() is to aggregate the same events in different
> PMUs like in case of uncore or hybrid.  The same logic is in the stat-display
> routines but I think it should be handled when it processes the event counters.

I think I'm confused as to what a merged counter is. Does it relate to
the evsel leader? How are aliases and merging related?

Thanks,
Ian

>
> As it works on the aggr_counters, it doesn't change the output yet.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c |  2 +
>  tools/perf/util/stat.c    | 96 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/stat.h    |  2 +
>  3 files changed, 100 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 49a7e290d778..f90e8f29cb23 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -486,6 +486,8 @@ static void process_counters(void)
>                         pr_warning("failed to process counter %s\n", counter->name);
>                 counter->err = 0;
>         }
> +
> +       perf_stat_merge_counters(&stat_config, evsel_list);
>  }
>
>  static void process_interval(void)
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 4edfc1c5dc07..1bb197782a34 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -575,6 +575,102 @@ int perf_stat_process_counter(struct perf_stat_config *config,
>         return 0;
>  }
>
> +static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
> +{
> +       struct perf_stat_evsel *ps_a = evsel->stats;
> +       struct perf_stat_evsel *ps_b = alias->stats;
> +       int i;
> +
> +       if (ps_a->aggr == NULL && ps_b->aggr == NULL)
> +               return 0;
> +
> +       if (ps_a->nr_aggr != ps_b->nr_aggr) {
> +               pr_err("Unmatched aggregation mode between aliases\n");
> +               return -1;
> +       }
> +
> +       for (i = 0; i < ps_a->nr_aggr; i++) {
> +               struct perf_counts_values *aggr_counts_a = &ps_a->aggr[i].counts;
> +               struct perf_counts_values *aggr_counts_b = &ps_b->aggr[i].counts;
> +
> +               /* NB: don't increase aggr.nr for aliases */
> +
> +               aggr_counts_a->val += aggr_counts_b->val;
> +               aggr_counts_a->ena += aggr_counts_b->ena;
> +               aggr_counts_a->run += aggr_counts_b->run;
> +       }
> +
> +       return 0;
> +}
> +/* events should have the same name, scale, unit, cgroup but on different PMUs */
> +static bool evsel__is_alias(struct evsel *evsel_a, struct evsel *evsel_b)
> +{
> +       if (strcmp(evsel__name(evsel_a), evsel__name(evsel_b)))
> +               return false;
> +
> +       if (evsel_a->scale != evsel_b->scale)
> +               return false;
> +
> +       if (evsel_a->cgrp != evsel_b->cgrp)
> +               return false;
> +
> +       if (strcmp(evsel_a->unit, evsel_b->unit))
> +               return false;
> +
> +       if (evsel__is_clock(evsel_a) != evsel__is_clock(evsel_b))
> +               return false;
> +
> +       return !!strcmp(evsel_a->pmu_name, evsel_b->pmu_name);
> +}
> +
> +static void evsel__merge_aliases(struct evsel *evsel)
> +{
> +       struct evlist *evlist = evsel->evlist;
> +       struct evsel *alias;
> +
> +       alias = list_prepare_entry(evsel, &(evlist->core.entries), core.node);
> +       list_for_each_entry_continue(alias, &evlist->core.entries, core.node) {
> +               /* Merge the same events on different PMUs. */
> +               if (evsel__is_alias(evsel, alias)) {
> +                       evsel__merge_aggr_counters(evsel, alias);
> +                       alias->merged_stat = true;
> +               }
> +       }
> +}
> +
> +static bool evsel__should_merge_hybrid(struct evsel *evsel, struct perf_stat_config *config)
> +{
> +       struct perf_pmu *pmu;
> +
> +       if (!config->hybrid_merge)
> +               return false;
> +
> +       pmu = evsel__find_pmu(evsel);
> +       return pmu && pmu->is_hybrid;
> +}
> +
> +static void evsel__merge_stats(struct evsel *evsel, struct perf_stat_config *config)
> +{
> +       /* this evsel is already merged */
> +       if (evsel->merged_stat)
> +               return;
> +
> +       if (evsel->auto_merge_stats || evsel__should_merge_hybrid(evsel, config))
> +               evsel__merge_aliases(evsel);
> +}
> +
> +/* merge the same uncore and hybrid events if requested */
> +void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist)
> +{
> +       struct evsel *evsel;
> +
> +       if (config->no_merge)
> +               return;
> +
> +       evlist__for_each_entry(evlist, evsel)
> +               evsel__merge_stats(evsel, config);
> +}
> +
>  int perf_event__process_stat_event(struct perf_session *session,
>                                    union perf_event *event)
>  {
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 3a876ad2870b..12cc60ab04e4 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -270,6 +270,8 @@ void evlist__reset_aggr_stats(struct evlist *evlist);
>
>  int perf_stat_process_counter(struct perf_stat_config *config,
>                               struct evsel *counter);
> +void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist);
> +
>  struct perf_tool;
>  union perf_event;
>  struct perf_session;
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
