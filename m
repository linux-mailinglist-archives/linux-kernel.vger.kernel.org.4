Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1985FA7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJJXBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJJXA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:00:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58184DF17
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:00:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bv10so15450234wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uc1i7IELlbjVIeYLpOxEQXmYQfmKu+VimW9xvJ8PkdQ=;
        b=nV61sBa9X59/jFPBpK2JdcnVOqLKHa9ooCneygvrWDVEjXCVeUq5+jhPtYEGFN8gBu
         jSnNNAOUWg9KDBxM32/9yUTgenXybl0PksdzH1hY7mOEb6aswL3kjQyp+dMcdeGRbmuz
         FDa9o2gfPL+pgoH2GdAq36JYxLtscepDuyfkHWXm0fe0bhTs8HqihVsuGnsA5wj0rr4E
         c9ZV9QIE1RYBtlK4aNsVkRX/QP8WGhuRrSoB9Pk9HRD9RWqaDa7socnI0PC1bAlZV1Nw
         VJ7SqzS8TB4WvI3I+mCU5grwPBDcFviOc20o5MVdMBXtP4BKEQ75mbOXwgObh9YJHSLI
         IW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uc1i7IELlbjVIeYLpOxEQXmYQfmKu+VimW9xvJ8PkdQ=;
        b=yPOSCBmKX4+z6H8E6fvmmoEPGdHLQRK5jPfJv5BX0/gkpEhFbxc0MgXljbDFBS5VOT
         iMlWO0MfbzkkTp6iBEPEm2CKY0y7OYPrOulVbyKw3sDsIhRx0Myve+6mgv8HR7s+Vktv
         xXyTGrGSxsGju+aRknE81syy7CkrqnRVFE+1vPGnR77V91Gv3N3MsnuMc+72P/d6Kp/e
         8+3TSwgoYDD8sAHDSMmQYccIfAkZV2dsHKYZlxIgsxd9WvNAJAwqeC2n/hFgdi0fVcvF
         x1mFKqGNA8fB2iCy/J1ZwLvy3pJudY2QqM++H27WS8SYpL2fCkZKVcR9PTdzwkJEYOO/
         b9BA==
X-Gm-Message-State: ACrzQf2MdFDm3O+7I8T3nZiTJ+lAB7rlSM7u3j9P64kiSSI8Kc/8a0UA
        KdofuAkB1HNtUtscYk9nH8Wl7rqFJW8i+qIhWUlsGA==
X-Google-Smtp-Source: AMsMyM4HCbBPlQZFdwDD8eFgg/OjlElS48JDVhJ0V6tAGRnILjEH+UYGgax0/LXkUhBKm1ZBjA5B4b1qKN6u+H1qJj4=
X-Received: by 2002:a5d:68d0:0:b0:22c:dfba:3bd6 with SMTP id
 p16-20020a5d68d0000000b0022cdfba3bd6mr12713716wrw.300.1665442855185; Mon, 10
 Oct 2022 16:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-8-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-8-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:00:42 -0700
Message-ID: <CAP-5=fXU-ydTrDXVp_WoyuvgvaHEVt0kVY2kDCGYTrpebw7RtA@mail.gmail.com>
Subject: Re: [PATCH 07/19] perf stat: Add struct perf_stat_aggr to perf_stat_evsel
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
> The perf_stat_aggr struct is to keep aggregated counter values and the
> states according to the aggregation mode.  The number of entries is
> depends on the mode and this is a preparation for the later use.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat.c | 34 +++++++++++++++++++++++++++-------
>  tools/perf/util/stat.h |  9 +++++++++
>  2 files changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 8ec8bb4a9912..c9d5aa295b54 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -133,15 +133,33 @@ static void perf_stat_evsel_id_init(struct evsel *evsel)
>  static void evsel__reset_stat_priv(struct evsel *evsel)
>  {
>         struct perf_stat_evsel *ps = evsel->stats;
> +       struct perf_stat_aggr *aggr = ps->aggr;
>
>         init_stats(&ps->res_stats);
> +
> +       if (aggr)
> +               memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);
>  }
>
> -static int evsel__alloc_stat_priv(struct evsel *evsel)
> +
> +static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
>  {
> -       evsel->stats = zalloc(sizeof(struct perf_stat_evsel));
> -       if (evsel->stats == NULL)
> +       struct perf_stat_evsel *ps;
> +
> +       ps = zalloc(sizeof(*ps));
> +       if (ps == NULL)
>                 return -ENOMEM;
> +
> +       if (nr_aggr) {
> +               ps->nr_aggr = nr_aggr;
> +               ps->aggr = calloc(nr_aggr, sizeof(*ps->aggr));
> +               if (ps->aggr == NULL) {
> +                       free(ps);
> +                       return -ENOMEM;
> +               }
> +       }
> +
> +       evsel->stats = ps;
>         perf_stat_evsel_id_init(evsel);
>         evsel__reset_stat_priv(evsel);
>         return 0;
> @@ -151,8 +169,10 @@ static void evsel__free_stat_priv(struct evsel *evsel)
>  {
>         struct perf_stat_evsel *ps = evsel->stats;
>
> -       if (ps)
> +       if (ps) {
> +               zfree(&ps->aggr);
>                 zfree(&ps->group_data);
> +       }
>         zfree(&evsel->stats);
>  }
>
> @@ -181,9 +201,9 @@ static void evsel__reset_prev_raw_counts(struct evsel *evsel)
>                 perf_counts__reset(evsel->prev_raw_counts);
>  }
>
> -static int evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
> +static int evsel__alloc_stats(struct evsel *evsel, int nr_aggr, bool alloc_raw)
>  {
> -       if (evsel__alloc_stat_priv(evsel) < 0 ||
> +       if (evsel__alloc_stat_priv(evsel, nr_aggr) < 0 ||
>             evsel__alloc_counts(evsel) < 0 ||
>             (alloc_raw && evsel__alloc_prev_raw_counts(evsel) < 0))
>                 return -ENOMEM;
> @@ -196,7 +216,7 @@ int evlist__alloc_stats(struct evlist *evlist, bool alloc_raw)
>         struct evsel *evsel;
>
>         evlist__for_each_entry(evlist, evsel) {
> -               if (evsel__alloc_stats(evsel, alloc_raw))
> +               if (evsel__alloc_stats(evsel, 0, alloc_raw))
>                         goto out_free;
>         }
>
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index b0899c6e002f..ea356e5aa351 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -8,6 +8,7 @@
>  #include <sys/resource.h>
>  #include "cpumap.h"
>  #include "rblist.h"
> +#include "counts.h"
>
>  struct perf_cpu_map;
>  struct perf_stat_config;
> @@ -42,9 +43,17 @@ enum perf_stat_evsel_id {
>         PERF_STAT_EVSEL_ID__MAX,
>  };
>

The new struct variables below are all worth comments.

> +struct perf_stat_aggr {
> +       struct perf_counts_values       counts;
> +       int                             nr;

Could this value be derived from counts.values.size ?

> +       bool                            failed;
> +};
> +
>  struct perf_stat_evsel {
>         struct stats             res_stats;
>         enum perf_stat_evsel_id  id;
> +       int                      nr_aggr;
> +       struct perf_stat_aggr   *aggr;
>         u64                     *group_data;
>  };
>
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
