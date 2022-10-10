Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970755FA893
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJJXTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJJXTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:19:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7485AC6B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:19:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bv10so15492731wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bLzAfrfTJTzUosgM4VQ05b2+43V10wlb8Vnq/6Won0I=;
        b=IysRAVgk70Cj4gmEUfM/fkR2P9dplN6meaLPokqFziTZ3AoihwI4KnH0Du0fdueI+P
         I1ha/p1GbhqNIKNh+0TajJrCo0ZZ6dO29Q6e6ee+GHS5OrBDpOOvWXyleI/NDuKKmyc2
         FHFL/kCK6AQ0ptdXkuSb7e5I95+s05bSLO16Jzf3s6SO+EuECn/edIlTKotcvd1xnyNl
         nUNiglpLWNPKWmVjqR4Xmv1y0MISljpmWX3Q0n+YzizfrrUpa04IZTQn3Xh2Ao598lB9
         mVAw4tTGrc3K/BhM6G5nDASHR2y1XNnhfYCITUNtPSCYQXj1IiTP+wSDCa0NriymIahg
         M+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLzAfrfTJTzUosgM4VQ05b2+43V10wlb8Vnq/6Won0I=;
        b=k6wcRyoPwkzkFdTy72ALiUVJlrjvYJk078x/Gn0E7nTisvvCsexMUGeolwbbiCAWkE
         I6KaVIAJcGWrEuhLPaYi4E5+lyL2+eEFrh4DY8cqZjOuB2hXN1zRIowLEoV/WH5iKcLB
         CKXmPS2tt3goonlHiI5QhkFH8pGdKMXGSRadCre6waZh5VLkGSEbUlMJUiecR06cetDC
         K5m532m/sKuULPSYcikaFZJ4AXHsg3rBskLS1Ux9RJ1VdwMNG2hsjmmQKq3qBzXmaR9M
         xZ96xuMi541c9xfk96MSIBmAwVwb5NWjeAOjf/Qyv7eWHE1Htqh1WWVSnMDapQcQZQkS
         y9Hw==
X-Gm-Message-State: ACrzQf2q/OuAyphbAD9alYY51udY75CKSN4cYn6v9a3WgoGiQCQurGad
        Al2LHxBP3e6PDJ6STUWkWjXo4aBuKSLwJHunX8o/Ng==
X-Google-Smtp-Source: AMsMyM4vPWzMXWTTvjoy5ds/Fw5u6V37lhnNAJukPJRkRtam2ugelBIBMKrZ8em2xGJx0KA7bOSxOOJmJW6uUqR7Vbs=
X-Received: by 2002:a5d:6d86:0:b0:22e:404f:1101 with SMTP id
 l6-20020a5d6d86000000b0022e404f1101mr12509441wrs.343.1665443938832; Mon, 10
 Oct 2022 16:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-12-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-12-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:18:47 -0700
Message-ID: <CAP-5=fUKm5Drb22Zo2mTtPwCHHewe4Kf1ieLcUpFvwCDAsy_1Q@mail.gmail.com>
Subject: Re: [PATCH 11/19] perf stat: Allocate aggr counts for recorded data
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
> In the process_stat_config_event() it sets the aggr_mode that means the
> earlier evlist__alloc_stats() cannot allocate the aggr counts due to the
> missing aggr_mode.
>
> Do it after setting the aggr_map using evlist__alloc_aggr_stats().
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c |  8 ++++++++
>  tools/perf/util/stat.c    | 39 +++++++++++++++++++++++++++++++--------
>  tools/perf/util/stat.h    |  2 ++
>  3 files changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index c76240cfc635..983f38cd4caa 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2139,6 +2139,14 @@ int process_stat_config_event(struct perf_session *session,
>         else
>                 perf_stat_init_aggr_mode_file(st);
>
> +       if (stat_config.aggr_map) {
> +               int nr_aggr = stat_config.aggr_map->nr;
> +
> +               if (evlist__alloc_aggr_stats(session->evlist, nr_aggr) < 0) {
> +                       pr_err("cannot allocate aggr counts\n");
> +                       return -1;
> +               }
> +       }
>         return 0;
>  }
>
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 013dbe1c5d28..279aa4ea342d 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -141,6 +141,31 @@ static void evsel__reset_stat_priv(struct evsel *evsel)
>                 memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);
>  }
>
> +static int evsel__alloc_aggr_stats(struct evsel *evsel, int nr_aggr)
> +{
> +       struct perf_stat_evsel *ps = evsel->stats;
> +
> +       if (ps == NULL)
> +               return 0;
> +
> +       ps->nr_aggr = nr_aggr;
> +       ps->aggr = calloc(nr_aggr, sizeof(*ps->aggr));
> +       if (ps->aggr == NULL)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr)
> +{
> +       struct evsel *evsel;
> +
> +       evlist__for_each_entry(evlist, evsel) {
> +               if (evsel__alloc_aggr_stats(evsel, nr_aggr) < 0)
> +                       return -1;
> +       }
> +       return 0;
> +}
>
>  static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
>  {
> @@ -150,16 +175,14 @@ static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
>         if (ps == NULL)
>                 return -ENOMEM;
>
> -       if (nr_aggr) {
> -               ps->nr_aggr = nr_aggr;
> -               ps->aggr = calloc(nr_aggr, sizeof(*ps->aggr));
> -               if (ps->aggr == NULL) {
> -                       free(ps);
> -                       return -ENOMEM;
> -               }
> +       evsel->stats = ps;
> +
> +       if (nr_aggr && evsel__alloc_aggr_stats(evsel, nr_aggr) < 0) {
> +               evsel->stats = NULL;
> +               free(ps);
> +               return -ENOMEM;
>         }
>
> -       evsel->stats = ps;
>         perf_stat_evsel_id_init(evsel);
>         evsel__reset_stat_priv(evsel);
>         return 0;
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 74bd51a3cb36..936c0709ce0d 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -265,6 +265,8 @@ void evlist__reset_prev_raw_counts(struct evlist *evlist);
>  void evlist__copy_prev_raw_counts(struct evlist *evlist);
>  void evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
>
> +int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr);
> +
>  int perf_stat_process_counter(struct perf_stat_config *config,
>                               struct evsel *counter);
>  struct perf_tool;
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
