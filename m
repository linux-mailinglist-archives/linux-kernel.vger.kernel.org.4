Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F0628839
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbiKNSVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiKNSU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:20:58 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC546303D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:20:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o4so19715724wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1XipPx7HJpL1+jctec2qyggfKC2GCddSF+AfxJOo69s=;
        b=VEg6wNwDP3oW6fuxz9ug8JX3xb83qFjA0uDUpNJxZLXFOzUMHzI7X2l6qqTPHes+Z6
         6BsCiRBg/LA/0J6WCbYEoBcy2JedfAj5q64amjnQlpKWEVuKm6tTwbezhlH5vl84ACns
         UcmHYaaU8OnQQ+gZ3M7yDA6cbx0x9pM1SjsAUK/5xqsglu0ucC1uUCzD1w5zmKh/fvZg
         AoCfaHVH+alqQoReRiZ2nUT2OYQ22UId7mhWtP7NfTVw3bOEgYuhDciR0McsTgGlLRci
         v1yDgR7eTheaGMzy7YW1weOsVI3kyEGo2yQ+1+3t47feyvi6eKn09sU/f5lRRdAdYUtF
         f2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XipPx7HJpL1+jctec2qyggfKC2GCddSF+AfxJOo69s=;
        b=PAPTaNPAVVZhi/GhD15UXaA7SJ9DL0+PL1hIJZ9Nc03plMR2iq3+fyXKhU2oeLmu7M
         Yadu1+ilSVN6xI0bUzhLK1hbb9Uro2Sdto13GSUJwFWNvXb5lai06S1SqLaPhGe0nQp7
         qSkAL9YpzNIWaPRODsoMB1Br2vTUnuFy9m0sPhXTR/uGUbXYrpYcjpAdeKZUu8ji6S6P
         mjgmi5I3XTknMaSqqNSA1ZjfUgWdg+4wCwTt3HSe01iA5oyaJBL8hGDp/xwMi9gfRAl6
         ZIw3TuvNAMLKWErcwkbQcqJmeeI/SEYP9EehiyF1+ltY6gg0sx50apl0js0whDi09hNU
         YxNg==
X-Gm-Message-State: ANoB5pn8uMPvME88g8mheaBldiuL9VKEqRakUb35ypKxnGCI9iJ6AYEp
        PfRw1dIzoOY9+uteex17ylTSXWd4aO+34CPr8tMGkA==
X-Google-Smtp-Source: AA0mqf5DyQVRRmDuTWNxDf+5n0OCUxVOyaBhO4vRgH/W0oZuxPFVlq4j7ebz6Vu5HZn5ivqOm6tcIHVx73bJT0cBvv4=
X-Received: by 2002:a05:6000:1241:b0:236:d8f8:b87d with SMTP id
 j1-20020a056000124100b00236d8f8b87dmr8165981wrx.343.1668450050179; Mon, 14
 Nov 2022 10:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20221112032244.1077370-1-namhyung@kernel.org> <20221112032244.1077370-11-namhyung@kernel.org>
In-Reply-To: <20221112032244.1077370-11-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Nov 2022 10:20:38 -0800
Message-ID: <CAP-5=fXhk7XLrAbBWR7X-O5Snnb-ST+MNzSZChWBLN_1b6f25A@mail.gmail.com>
Subject: Re: [PATCH 10/11] perf stat: Fix summary output in CSV with --metric-only
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
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

On Fri, Nov 11, 2022 at 7:23 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It should not print "summary" for each event when --metric-only is set.
>
> Before:
>   $ sudo perf stat -a --per-socket --summary -x, --metric-only true
>    time,socket,cpusGhz,insn per cycle,branch-misses of all branches,
>        0.000709079,S0,8,0.893,2.40,0.45,
>   S0,8,         summary,         summary,         summary,         summary,         summary,0.893,         summary,2.40,         summary,         summary,0.45,
>
> After:
>   $ sudo perf stat -a --per-socket --summary -x, --metric-only true
>    time,socket,cpusGHz,insn per cycle,branch-misses of all branches,
>        0.000882297,S0,8,0.598,1.64,0.64,
>            summary,S0,8,0.598,1.64,0.64,
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index ce81798b5864..96bb7a42fd41 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -549,7 +549,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>         }
>
>         if (!config->no_csv_summary && config->csv_output &&
> -           config->summary && !config->interval) {
> +           config->summary && !config->interval && !config->metric_only) {
>                 fprintf(config->output, "%16s%s", "summary", config->csv_sep);
>         }
>
> @@ -732,8 +732,13 @@ static void print_aggr(struct perf_stat_config *config,
>          * Without each counter has its own line.
>          */
>         for (s = 0; s < config->aggr_map->nr; s++) {
> -               if (prefix && metric_only)
> -                       fprintf(output, "%s", prefix);
> +               if (metric_only) {
> +                       if (prefix)
> +                               fprintf(output, "%s", prefix);
> +                       else if (config->summary && !config->no_csv_summary &&
> +                                config->csv_output && !config->interval)
> +                               fprintf(output, "%16s%s", "summary", config->csv_sep);
> +               }
>
>                 first = true;
>                 evlist__for_each_entry(evlist, counter) {
> --
> 2.38.1.493.g58b659f92b-goog
>
