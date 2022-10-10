Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA5C5FA89A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJJXWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJJXWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:22:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B54A7CB64
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:21:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso7187378wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FYCVY1jSWriLX0/dt1Sm4C0QAeI0aHsl2mcuPeWXDXE=;
        b=Ss5+xcfNOCPRXY5jRGOy5YgOINzc3BSSNcmwW9Lj7kbYWFGrqfmA/ZsO5dCr4cFeeA
         2Zye4jgMpfu0Bee+OUxh/vuSz+nDl4RV7YvH9+CaPq82bG6Igv5thXFuWf58lJJ0tCiD
         3/RWg/rLtSEZ8YhNdxJW/ggFLxCDl4LckvyD79nFzL+ii+hy1sorqTVHaYmOaLl48FYq
         q3qNWBt/N2GIp25LalZLNTWPEZCmpVqhAPe96W4+hGBDv0p4bIxIDNkW3mQ94KI8M3ZF
         lKyBKXQDVWo6IxKoDfyuuI7UbzG0jRzuEWSzFhHE52sTwb5JQ6iFM2ziXLQ3+WoAJuNb
         CGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYCVY1jSWriLX0/dt1Sm4C0QAeI0aHsl2mcuPeWXDXE=;
        b=O0g+j7PRzBqYq50/4qmSRXLXCqqYS+eqD0fCXp3YQfCRtkAZGHgCDifivkKWn+H12D
         RB8F5Jm3IJFkO1pHMlDximBQS4mI/FnaLIq4J5VaH+AF+u8TkTkbUAJJB//uuY5iARl2
         rtz4Mr7LGQQ6duxv2isnF28tzjM+fCfT5dvZ1ydvNXIuDgqlXYVFpuizr28SkLIbIX/x
         H0Dnn0eez7Ha0xOw330x01ZMZQcg9n/ppqnttIy+SeGRRhIxTuf6HYU33hPa9SHNVm6G
         3uengR/TnOnRVPKAG2AtQFpIEexqtziCQmmR3hIAQ4jElGvV4CIB9xxcutt19AeC2XAZ
         V+Ag==
X-Gm-Message-State: ACrzQf3O4w39rdsbcCOaCfDWdZaOeHfGc3hLGBkN1n3HipuFloSimF/+
        hvExC0GX750ivgLEjjpln7l+CrI679yeFng73SgfEg==
X-Google-Smtp-Source: AMsMyM7lU4DMUSzHo8u2zvOo9/J/BYOC7xLpBbHhbZqlF8UIzOhWc/O/o1rGaYIM0t8QWPxlrmNKmJ6g/e3d1KVc0fQ=
X-Received: by 2002:a05:600c:4e94:b0:3b4:b416:46c3 with SMTP id
 f20-20020a05600c4e9400b003b4b41646c3mr14620205wmq.149.1665444118102; Mon, 10
 Oct 2022 16:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-14-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-14-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:21:46 -0700
Message-ID: <CAP-5=fWbDKFJJc7044rs-EDFf6PR156cFAtjrRduVOK9M3zYwA@mail.gmail.com>
Subject: Re: [PATCH 13/19] perf stat: Split process_counters()
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
> It'd do more processing with aggregation.  Let's split the function so that it
> can be shared with by process_stat_round_event() too.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 38036f40e993..49a7e290d778 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -465,15 +465,19 @@ static int read_bpf_map_counters(void)
>         return 0;
>  }
>
> -static void read_counters(struct timespec *rs)
> +static int read_counters(struct timespec *rs)
>  {
> -       struct evsel *counter;
> -
>         if (!stat_config.stop_read_counter) {
>                 if (read_bpf_map_counters() ||
>                     read_affinity_counters(rs))
> -                       return;
> +                       return -1;
>         }
> +       return 0;
> +}
> +
> +static void process_counters(void)
> +{
> +       struct evsel *counter;
>
>         evlist__for_each_entry(evsel_list, counter) {
>                 if (counter->err)
> @@ -494,7 +498,8 @@ static void process_interval(void)
>         perf_stat__reset_shadow_per_stat(&rt_stat);
>         evlist__reset_aggr_stats(evsel_list);
>
> -       read_counters(&rs);
> +       if (read_counters(&rs) == 0)
> +               process_counters();
>
>         if (STAT_RECORD) {
>                 if (WRITE_STAT_ROUND_EVENT(rs.tv_sec * NSEC_PER_SEC + rs.tv_nsec, INTERVAL))
> @@ -980,7 +985,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>          * avoid arbitrary skew, we must read all counters before closing any
>          * group leaders.
>          */
> -       read_counters(&(struct timespec) { .tv_nsec = t1-t0 });
> +       if (read_counters(&(struct timespec) { .tv_nsec = t1-t0 }) == 0)
> +               process_counters();
>
>         /*
>          * We need to keep evsel_list alive, because it's processed
> @@ -2098,13 +2104,11 @@ static int process_stat_round_event(struct perf_session *session,
>                                     union perf_event *event)
>  {
>         struct perf_record_stat_round *stat_round = &event->stat_round;
> -       struct evsel *counter;
>         struct timespec tsh, *ts = NULL;
>         const char **argv = session->header.env.cmdline_argv;
>         int argc = session->header.env.nr_cmdline;
>
> -       evlist__for_each_entry(evsel_list, counter)
> -               perf_stat_process_counter(&stat_config, counter);
> +       process_counters();
>
>         if (stat_round->type == PERF_STAT_ROUND_TYPE__FINAL)
>                 update_stats(&walltime_nsecs_stats, stat_round->time);
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
