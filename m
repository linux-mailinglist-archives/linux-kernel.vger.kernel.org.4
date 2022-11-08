Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89C62204A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiKHXYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiKHXXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:23:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F24D39B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:23:21 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v1so23276324wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 15:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AYY27CHCBp8aK7/t2oC4sqeVRM8MWfwLNJDQiNepGd0=;
        b=FlSm+XMleqvvRQunx5UXOGP84aWOdZ8IuY3HzZdNr6efOzgmUuAgM1W6gl42lDTL/t
         1UYRuXiqhGR7UW+LKv8B1xRlUXO68/l9zwooMrXPris7Q+9RQMN5//EDchFpH2Ojwest
         aOXgK0wSVaZY1bk+zNfKfJRiv05ujyzyWSHBhvES14fDrn1EXexkkgtl4KuX0OMQh8bd
         Ffvqf3CDH3R+/HK4O45wRlBVoU0L7ui26iTv5a0NTzEVYgBLdHsym41NE0CNAe2qM6BA
         vZ+G4s1H423nZoMjTDk23RKrWfdaxTeCx2MLWAdElZ4xzOYBVoZPwOkC+S9Xh0ov6LcC
         DNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYY27CHCBp8aK7/t2oC4sqeVRM8MWfwLNJDQiNepGd0=;
        b=mXODX0wx2HRVg2u96E0fEHefzMdDKQpjR9UkpOUrp2gWj7WBjP/f2uvbZufzKcO9oE
         t7jgUr0nk5i65YfkR81siP/P09f3GNwInpQc4epH2L9fV01GVi1p6W8ZdDLCBr737zFB
         4vlA4bOMdurb6uIfgmhWocKyNZc6CXELEL3BkvADRquv7h3bF30WXNnNxQKHzo4loMbG
         jmKZqQtAK8oGNRyI0osI9X/xfcTsN5mt+GpV6IDD6tKLmYOcdSqB7Gd1mczDYXAaoqob
         HyWExYlKZd1EySDm/rKTpcWA1s56rHJ4zLBAeH/0VeMEdDYDqI6jylBeg2Vm89CXdDTl
         dK/w==
X-Gm-Message-State: ACrzQf35ifEZJE4u/3J755DZd6CNEqEDx2WeP3ZnJITul9uA34ARQW5r
        5ASwiF2g0sauywU9i+ZqmL56GZ/KBq2Sa+hhPR3GIQ==
X-Google-Smtp-Source: AMsMyM5h7J0P/PUzGAOqi3WOJZ+P94yBxjYzQo/QJvzJmKG8jVSwbooLinTm0fu+SLtBUtINwBjEYvG/E2GKMz6iBOg=
X-Received: by 2002:a5d:47a6:0:b0:236:7854:246d with SMTP id
 6-20020a5d47a6000000b002367854246dmr36330718wrb.300.1667949799496; Tue, 08
 Nov 2022 15:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-9-namhyung@kernel.org>
In-Reply-To: <20221107213314.3239159-9-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 15:23:07 -0800
Message-ID: <CAP-5=fXWdaGr3cNsUMWqrb_be38z01Eq5UhyPU6eUSLJNQHyQg@mail.gmail.com>
Subject: Re: [PATCH 8/9] perf stat: Fix condition in print_interval()
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 1:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The num_print_interval and config->interval_clear should be checked
> together like other places like later in the function.  Otherwise,
> the --interval-clear option could print the headers for the CSV or
> JSON output unnecessarily.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index aab2576bd40f..a10af26c26ab 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -902,8 +902,8 @@ static void print_interval(struct perf_stat_config *config,
>                 sprintf(prefix, "{\"interval\" : %lu.%09lu}", (unsigned long)
>                                  ts->tv_sec, ts->tv_nsec);
>
> -       if ((num_print_interval == 0 && !config->csv_output && !config->json_output)
> -                        || config->interval_clear) {
> +       if ((num_print_interval == 0 || config->interval_clear) &&
> +                       !config->csv_output && !config->json_output) {
>                 switch (config->aggr_mode) {
>                 case AGGR_NODE:
>                         fprintf(output, "#           time node   cpus");
> --
> 2.38.1.431.g37b22c650d-goog
>
