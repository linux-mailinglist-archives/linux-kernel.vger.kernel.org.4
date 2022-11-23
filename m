Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAA0636E44
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiKWXVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiKWXVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:21:14 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97646116051
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:21:13 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b12so9824wrn.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4Lpbo0ikHKpltFsht0DtcDgZMUjM7tbdFF7frE7VZ4=;
        b=ClS7bcl4Ygn7/Kp0RbQZXxNryLtPAxkUI6455F67yu8/2OUUGWxL5zcLhkW/AxoRaS
         KBoo6cktP8EaRvcGH8md37ZLN5+jUj/qnZiq+69uDPEIyPP3SkQCIGeU1yoGdnqNkISd
         /nEXsHFlF1cdjIqr0Oqwt6WRwqxwE8Oh1IgjPwSLbUCNF8APu1hXT23OHZOdoSJbAlQM
         Lwu4N+q5tdoXCFpqi2rkSsY6xJ+yJS44WOqxpwOUJHRJ/SiY43GTSTMn0/jAt8vCQaWw
         j8bPbQkSpEiIAarRmHyYO7WeTCQzby71TkjsR7RyHwH6NRYkMyF5oCdZFTDuslIDeRag
         Ex0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4Lpbo0ikHKpltFsht0DtcDgZMUjM7tbdFF7frE7VZ4=;
        b=7tBTl1scigTCCYp/o2+gEXjbOK817N02Vc5nk4Ij2Ca6vDrgESyGZa9JSxcswL6b1s
         a7R1ioeW2xDxSe8NaZBvqOpY6brK4daBoYHNC5dCRO5MX/WjEtWXKnMRMwDQ0lj1GORC
         A3gKpEZYt1zxMy9B1vGEzm7vW7UHRE+284sbnDCTdT7CiZNt3jdG2M70mnWysaTHStUC
         4NRqLZ6EcRszuVdXRWbToxlfh/aaL9TzU674CZSo03VXa5rlugydjc4oNtMPD/fRmao/
         WGE2goiRTXyV6yWhwKM9O/BQ0ka5vsZDpjvoSEJ8dALWskkEQnr7e/K6EaT1Hi8XfI9k
         dcvQ==
X-Gm-Message-State: ANoB5pmpFnDFS9qmH3eaQI58iQUiRUKjA19IAJJMgA3JQkVAWvDd1XUP
        rSA03QFxsY+n4kqao8/znKGLw/IvuVxucZBrvjYdrQ==
X-Google-Smtp-Source: AA0mqf5TbUvQVK7TILljNexm3NaXD/Upw1Es+Icf9IhqfTQrEsGQbeb4ts4wYloWgJSHp0FEz63UnzefeBBTh1MWkqY=
X-Received: by 2002:adf:e64f:0:b0:241:e2f1:8b44 with SMTP id
 b15-20020adfe64f000000b00241e2f18b44mr6031283wrn.300.1669245671965; Wed, 23
 Nov 2022 15:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-3-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:20:59 -0800
Message-ID: <CAP-5=fUZZkMyb=LAkz8dG79xZWeC+RjQoKGtXDoLmrHyruTg1w@mail.gmail.com>
Subject: Re: [PATCH 02/15] perf stat: Move summary prefix printing logic in
 CSV output
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It matches to the prefix (interval timestamp), so better to have them together.
> No functional change intended.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 46e90f0bb423..d86f2f8e020d 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -713,11 +713,6 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>                 nl = config->metric_only ? new_line_metric : new_line_std;
>         }
>
> -       if (!config->no_csv_summary && config->csv_output &&
> -           config->summary && !config->interval && !config->metric_only) {
> -               fprintf(config->output, "%16s%s", "summary", config->csv_sep);
> -       }
> -
>         if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
>                 if (config->metric_only) {
>                         pm(config, &os, NULL, "", "", 0);
> @@ -828,8 +823,13 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>         ena = aggr->counts.ena;
>         run = aggr->counts.run;
>
> -       if (prefix && !metric_only)
> -               fprintf(output, "%s", prefix);
> +       if (!metric_only) {
> +               if (prefix)
> +                       fprintf(output, "%s", prefix);
> +               else if (config->summary && config->csv_output &&
> +                        !config->no_csv_summary && !config->interval)
> +                       fprintf(output, "%16s%s", "summary", config->csv_sep);
> +       }
>
>         uval = val * counter->scale;
>
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
