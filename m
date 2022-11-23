Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC1636E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiKWX1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKWX1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:27:33 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB69B25CD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:27:29 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id cl5so31735587wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y171LyMbl+d9pE/U0kir1w+2LkUocq5c8sm+WisaSFY=;
        b=APEuAHpfHj2oq8DyLnA/AtQIhzZCtT1HbTkSrTnxfmGeF1eSUJmvMheVJoOeo+6FTx
         +jXABgZbpe/J8PBn+ozuRgmHb1tTKx+7GMEkKGys8ahEoEtRzTcrs9GyeCWAS6eHIDOS
         BcgGfoagWxA7Bv/A6T7pZgDLzvsLe7xiNGAlGZ5/P7Dep57avfZ7vemINlf3/IWGxZN5
         9l9y/VcbPkGS/BdJwbHqcuuF7FShwTopQ9BLJ2hAfKv4VBWRghWVRWI2zYpPDlnCYbwr
         cjYuW2aO/z2YNipgA/OJh9O+AsAmCUY5xecINj3+XalGJVSmsBF79B1nMNJDruG6kgcu
         /PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y171LyMbl+d9pE/U0kir1w+2LkUocq5c8sm+WisaSFY=;
        b=z/VEyXvBri6z9mjI28MMg9WXVq/2IovHT5WqBJfWTYhQAQuv/AW2p61xm7IktehsZg
         IIaGcQHD1Xevb/Lx2MHMCx+yoVjP7iMvqKCjJ4wec4M0m+r3wFrOp073vf9se++DVDcQ
         2fi+KWH276mFi5v3O9TqtMY6cnciTIOubQCR063KoOK0MDJcXZOvy7DQGqPcVLJdkfv4
         2H6kP2fDHlgP1A6pMCvPwvMKhQUXQxDcuMAkSktHIyaka8G3KfCvMrj2U3m2g8ltz9lT
         M7LPSPuDevSQWT/Dxcq3Smf05YpVvuRV9gsPgtJGASh3+h8qfQxUqKCoSldpJ9a/DsZq
         9k2A==
X-Gm-Message-State: ANoB5pmgvQo7dV14YAyymVVRub2qKPXJww2xlj8ZZA8GNsKzLIQTBSiI
        SLEhxGgceb5SSgu5onKrPEPmqUQuHvOs2r23vut/FQ==
X-Google-Smtp-Source: AA0mqf67WpQ1nBhDfxrztKImARiZctH65ZK7e3IW+GpvFklQZOjB7F9gOCFJy0/z9Uu2TMKcUPb/cUbuCLiuLLiyue8=
X-Received: by 2002:adf:d0cf:0:b0:241:f9c9:fdbd with SMTP id
 z15-20020adfd0cf000000b00241f9c9fdbdmr883154wrh.343.1669246048194; Wed, 23
 Nov 2022 15:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-12-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-12-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:27:15 -0800
Message-ID: <CAP-5=fUmKwWUXypzGP9dpSWL+mKrRdMU-DXJo9C86RQXk3gKSg@mail.gmail.com>
Subject: Re: [PATCH 11/15] perf stat: Do not pass runtime_stat to printout()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
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

On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It always passes a pointer to rt_stat as it's the only one.  Let's not
> pass it and directly refer it in the printout().
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index dd190f71e933..cdf4ca7f6e3a 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -674,8 +674,7 @@ static bool is_mixed_hw_group(struct evsel *counter)
>  }
>
>  static void printout(struct perf_stat_config *config, struct outstate *os,
> -                    double uval, u64 run, u64 ena, double noise,
> -                    struct runtime_stat *st, int map_idx)
> +                    double uval, u64 run, u64 ena, double noise, int map_idx)
>  {
>         struct perf_stat_output_ctx out;
>         print_metric_t pm;
> @@ -737,7 +736,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
>
>         if (ok) {
>                 perf_stat__print_shadow_stats(config, counter, uval, map_idx,
> -                                             &out, &config->metric_events, st);
> +                                             &out, &config->metric_events, &rt_stat);
>         } else {
>                 pm(config, &os, /*color=*/NULL, /*format=*/NULL, /*unit=*/"", /*val=*/0);
>         }
> @@ -834,7 +833,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>
>         uval = val * counter->scale;
>
> -       printout(config, &os, uval, run, ena, avg, &rt_stat, s);
> +       printout(config, &os, uval, run, ena, avg, s);
>
>         if (!metric_only)
>                 fputc('\n', output);
> @@ -987,7 +986,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>                         run = ps->aggr[counter_idx].counts.run;
>
>                         uval = val * counter->scale;
> -                       printout(config, &os, uval, run, ena, 1.0, &rt_stat, counter_idx);
> +                       printout(config, &os, uval, run, ena, 1.0, counter_idx);
>                 }
>                 if (!first)
>                         print_metric_end(config);
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
