Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F405FA898
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJJXUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJJXUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:20:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C560B7CAB1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:20:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b4so19072439wrs.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SReBSNXJSjBEiybMLn7KKcPydzCWliKitOyiQi1E3t8=;
        b=TaOZBGXXHBlERL+P74iMR5xvGa+Z1HS9F4iTK5i88CIU1KRy+Nw8MI96jSr3XAEsRA
         4a0yvPC4fEAz/rdgalcV7N1SlPYRAQoHZJvub7ZkoksNL4Dnma6G3PsmitjtKiIzeqBF
         OAhEub1m/L50y/3AcuZyNWLlcpcn8CYabGkM7f4wBDtPSWj1PmfEvSPjkP48lUQN8GCo
         MlaJSvjuJSO0Ve797EiAuLclFiBSGo14yXnVCzCPp4qZCW2u6XwQ332NsoZUQC0cm5CB
         4AJ9b/5oPjyDl0dUgiLT94MDQDzM42o3yrLw4Wkd18krMS6nQlIPXDyCV0hBC6dH0UsG
         nFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SReBSNXJSjBEiybMLn7KKcPydzCWliKitOyiQi1E3t8=;
        b=2ijGGJA8CSg7pRz4xvG18166qvj47CJ8Ejm2uvWcJwUw4ieuTBsI+Qn4TX0jPZnEPe
         4c1PGPa9eIEAfNSleunM6x6lJ6iSA22I2J7BCfd5bmaAdi/O0nFYKT6st8Dfk5wB4Kst
         nS0FlxsKzMRhpj4/4SSwbvOabIMZ0vtY8JG5IZRp17jltOX8V2C076Gaf7JzjlLrpezi
         C/QkpA96txm4QcgT4Rl2tKeEtEEJ+Bb2UKJqumnpHxpKqRNtBRNLBbxOwJC5t20WIB55
         PZDttMCKQryfjyTyFd77VfbUDaCkIvrAYXX3ormERM6+KOofnfw2vu19CpB528xOkGbD
         HdsA==
X-Gm-Message-State: ACrzQf1YLk7JXSicscnb6Te+jiDA3Jbfc5BFfOfZkgokADAAO4PteU16
        YP7ZyjzArHT+SOcQjxAEVXrB9Rzx8tC2YEM7p1bnaw==
X-Google-Smtp-Source: AMsMyM4yNlLQdv+wlqagN8xpjPtB1Z7bWjw2NPY3HWVZZaSRbCM+zFlX9KFi2mL5buGRCQdtp71WexIAl2tp0brjWRs=
X-Received: by 2002:a5d:68d0:0:b0:22c:dfba:3bd6 with SMTP id
 p16-20020a5d68d0000000b0022cdfba3bd6mr12752265wrw.300.1665444045207; Mon, 10
 Oct 2022 16:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-13-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-13-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:20:32 -0700
Message-ID: <CAP-5=fVeJAfgWU62vY6LK6Buj2BFrpwwYw_mxt3F-VEUEf7NiQ@mail.gmail.com>
Subject: Re: [PATCH 12/19] perf stat: Reset aggr counts for each interval
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
> The evsel->stats->aggr->count should be reset for interval processing
> since we want to use the values directly for display.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c |  3 +++
>  tools/perf/util/stat.c    | 13 +++++++++++++
>  tools/perf/util/stat.h    |  1 +
>  3 files changed, 17 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 983f38cd4caa..38036f40e993 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -492,6 +492,8 @@ static void process_interval(void)
>         diff_timespec(&rs, &ts, &ref_time);
>
>         perf_stat__reset_shadow_per_stat(&rt_stat);
> +       evlist__reset_aggr_stats(evsel_list);
> +
>         read_counters(&rs);
>
>         if (STAT_RECORD) {
> @@ -965,6 +967,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>
>                 evlist__copy_prev_raw_counts(evsel_list);
>                 evlist__reset_prev_raw_counts(evsel_list);
> +               evlist__reset_aggr_stats(evsel_list);
>                 perf_stat__reset_shadow_per_stat(&rt_stat);
>         } else {
>                 update_stats(&walltime_nsecs_stats, t1 - t0);
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 279aa4ea342d..4edfc1c5dc07 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -276,6 +276,19 @@ void evlist__reset_stats(struct evlist *evlist)
>         }
>  }
>
> +void evlist__reset_aggr_stats(struct evlist *evlist)
> +{
> +       struct evsel *evsel;
> +
> +       evlist__for_each_entry(evlist, evsel) {
> +               struct perf_stat_evsel *ps = evsel->stats;
> +               struct perf_stat_aggr *aggr = ps->aggr;
> +
> +               if (aggr)
> +                       memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);

Perhaps this would be cleaner with helper functions on perf_stat_evsel
and perf_stat_aggr?

Thanks,
Ian

> +       }
> +}
> +
>  void evlist__reset_prev_raw_counts(struct evlist *evlist)
>  {
>         struct evsel *evsel;
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 936c0709ce0d..3a876ad2870b 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -266,6 +266,7 @@ void evlist__copy_prev_raw_counts(struct evlist *evlist);
>  void evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
>
>  int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr);
> +void evlist__reset_aggr_stats(struct evlist *evlist);
>
>  int perf_stat_process_counter(struct perf_stat_config *config,
>                               struct evsel *counter);
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
