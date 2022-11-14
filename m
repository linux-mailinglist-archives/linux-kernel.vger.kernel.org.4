Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D19262882C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiKNSTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiKNSSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:18:45 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECCEFAF7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:18:44 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso11323424wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HVsZ7GvEsebyi2G4cAyW7BniWNFoesfCFO8x3KzC1zQ=;
        b=qJeRNH87aJ9JmjFPx/1JAMC4pp6z4sMpOxj499Z+f29KO6WWaVJpLLopzQDkOUBoZP
         YYoyNwTx4CG3mcgFAxOKoyjPN3uC12gQHSpgKjKEJwZ7wYseCRQfCIhzALShni+NkETm
         yETlG3W72nGoKY0ibAcDujVgH//nNG1TfwYk3UfldiNJDcf1rbz65if6AnXRrAXO6P0D
         vMIL+NE/46p6MGvNG8LNJOSpb5oUfjhWTiqHg/6w0bYJic/NaQxXefqMS2ipedX5dNfU
         uEZ35cZz8rq26BHzfAQ04KIyQSK41RvEtyNQPJv0Pq1Wn43CEdapMIl1i8eQQwhV8CV1
         2mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVsZ7GvEsebyi2G4cAyW7BniWNFoesfCFO8x3KzC1zQ=;
        b=Jz2mijbyp7Vq4USVXmDGkGAeYxlxGA5D2DXyu1K9u+PYDL+Q4lpaHYKM4FhqPJUzto
         eejg+I0beODByKzD2HQJGEmGNvIDYPhdbX88huiBPrkxjo0Ba7rY02dr+ySe/I8TrsrR
         N2kIOamoxvs5a9VR9EsFoysz32gm37jl7ssGShSpYSaMshyqq8PLd7TlK/Fol1JBTfIu
         k1eSvRuvwjCRodTF+twf84x1LkzaWhe0VKWSVQhsFPe9WcxAISzUpln6R6UZQYWDJuxo
         O+GVfPw28cxToG+Fx//O1Kn52NxT6a73rekH59Kdx9ssPCm1x2hMSFCUW1zvyU6zlySp
         GYDg==
X-Gm-Message-State: ANoB5pk1mp6Z3YfPoBM28hKZrO9SwB3AugZhWKOqdwFdXxwCyVtxIsG4
        V2Puofh4y9qCjvi78y3R/ApF5utBHNREFsjNEpYg8Q==
X-Google-Smtp-Source: AA0mqf5oksAO4SHnx5wzRLV6BSaMeEvYK4gsPf/ey60xBdtNlrAhG4pdnApLhL7LHZmpLHKAaWwvAM13Hw5gODYjJ9U=
X-Received: by 2002:a05:600c:6006:b0:3cf:45ff:aca with SMTP id
 az6-20020a05600c600600b003cf45ff0acamr8832089wmb.53.1668449922995; Mon, 14
 Nov 2022 10:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20221112032244.1077370-1-namhyung@kernel.org> <20221112032244.1077370-4-namhyung@kernel.org>
In-Reply-To: <20221112032244.1077370-4-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Nov 2022 10:18:30 -0800
Message-ID: <CAP-5=fWzC8mZVQ0ok+bMYynXYEs2ZThbp+_ezhwLtSboFNM3TA@mail.gmail.com>
Subject: Re: [PATCH 03/11] perf stat: Fix --metric-only --json output
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

On Fri, Nov 11, 2022 at 7:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Currently it prints all metric headers for JSON output.  But actually it
> skips some metrics with valid_only_metric().  So the output looks like:
>
>   $ perf stat --metric-only --json true
>   {"unit" : "CPUs utilized", "unit" : "/sec", "unit" : "/sec", "unit" : "/sec", "unit" : "GHz", "unit" : "insn per cycle", "unit" : "/sec", "unit" : "branch-misses of all branches"}
>   {"metric-value" : "3.861"}{"metric-value" : "0.79"}{"metric-value" : "3.04"}
>
> As you can see there are 8 units in the header but only 3 metric-values
> are there.  It should skip the unused headers as well.  Also each unit
> should be printed as a separate object like metric values.
>
> With this patch:
>
>   $ perf stat --metric-only --json true
>   {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
>   {"metric-value" : "4.166"}{"metric-value" : "0.73"}{"metric-value" : "2.96"}
>
> Fixes: df936cadfb58 ("perf stat: Add JSON output option")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index c7b3a1e10263..96ad0c71adc2 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -430,12 +430,12 @@ static void print_metric_header(struct perf_stat_config *config,
>             os->evsel->priv != os->evsel->evlist->selected->priv)
>                 return;
>
> -       if (!valid_only_metric(unit) && !config->json_output)
> +       if (!valid_only_metric(unit))
>                 return;
>         unit = fixunit(tbuf, os->evsel, unit);
>
>         if (config->json_output)
> -               fprintf(os->fh, "\"unit\" : \"%s\"", unit);
> +               fprintf(os->fh, "{\"unit\" : \"%s\"}", unit);
>         else if (config->csv_output)
>                 fprintf(os->fh, "%s%s", unit, config->csv_sep);
>         else
> @@ -847,10 +847,6 @@ static void print_metric_headers(struct perf_stat_config *config,
>                 .new_line = new_line_metric,
>                 .force_header = true,
>         };
> -       bool first = true;
> -
> -       if (config->json_output && !config->interval)
> -               fprintf(config->output, "{");
>
>         if (prefix && !config->json_output)
>                 fprintf(config->output, "%s", prefix);
> @@ -871,18 +867,12 @@ static void print_metric_headers(struct perf_stat_config *config,
>         evlist__for_each_entry(evlist, counter) {
>                 os.evsel = counter;
>
> -               if (!first && config->json_output)
> -                       fprintf(config->output, ", ");
> -               first = false;
> -
>                 perf_stat__print_shadow_stats(config, counter, 0,
>                                               0,
>                                               &out,
>                                               &config->metric_events,
>                                               &rt_stat);
>         }
> -       if (config->json_output)
> -               fprintf(config->output, "}");
>         fputc('\n', config->output);
>  }
>
> @@ -954,14 +944,8 @@ static void print_interval(struct perf_stat_config *config,
>                 }
>         }
>
> -       if ((num_print_interval == 0 || config->interval_clear)
> -                        && metric_only && !config->json_output)
> +       if ((num_print_interval == 0 || config->interval_clear) && metric_only)
>                 print_metric_headers(config, evlist, " ", true);
> -       if ((num_print_interval == 0 || config->interval_clear)
> -                        && metric_only && config->json_output) {
> -               fprintf(output, "{");
> -               print_metric_headers(config, evlist, " ", true);
> -       }
>         if (++num_print_interval == 25)
>                 num_print_interval = 0;
>  }
> --
> 2.38.1.493.g58b659f92b-goog
>
