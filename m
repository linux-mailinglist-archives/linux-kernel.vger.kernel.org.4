Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B17A636E49
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKWXXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKWXX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:23:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F4376146
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:23:27 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id n3so15143106wrp.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ayoSWu5N40Ra4iTrCvTpa/DS7Q6MrND/wB7uYtW0GPo=;
        b=J0gMFtUusKM7z1WD/Yw/59tPQwk1zT36/ku2ipXNQA/R59mzybS3dXGd0urmn6taAL
         0/LJpF41ppRutaYM5jmDpi/71omBBeK9/MAEc7CIoFkNQYmUWqscyIN1YilCMHZc1oQ8
         lddL+zkMi7Jw3LD/wkl78FzEF4EuLrMUAzId4kxkmozS7e1aC9qbErS3vYvfhK6TMS7R
         3UyAVtk7O6VAbD1sBG9xQLZ4MHHbGHZSW8A9OJFOq606oYmfCoD4pBXxBu7QuK0VTIkw
         NAQhxGW/QmqhQrmd70DjrcKHeehlRD2VEE5vHGPJiFbyCFYhBKgFbet9/vXD6oqgXpgR
         tcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayoSWu5N40Ra4iTrCvTpa/DS7Q6MrND/wB7uYtW0GPo=;
        b=4/ki0SkAE62SlByX+1JdEa6/a/wb0YueIa4gpMOljepu5bti6sV0Z8ET1W6BpscWAM
         KuMwNVDsEZDLQVbFjTnXY9e/mUlSxzentTJalkzpou4d+reD1HXr16VH2sE1HVrsC38Y
         o0pBA7sIyN0P9EPg3QdUPc5Z5hylMjl+BRd75RyjCEPXu+urCEDNmwawWyubbuxoGHLq
         colveNqm4fUW0AHapu4wZ/C4+MPu2rVMdqjO7LVPpHV01C+BQzwKszzd30bfywEX8bRU
         lxw7fbziaFHQQhVhJnleCVClPVDjexK1knibfSD7fSzwGImFHA2sTsD6/HVrzX3Ykj5d
         uBjg==
X-Gm-Message-State: ANoB5pnXgG0BDGFCv8myiyz10rbWoiJ532sHSBDLce2aJ3tjSiUh1Ims
        jwNGa+onXH1bbqjXAh2WG8D/tvNkXYnzUOOEFxDb1Q==
X-Google-Smtp-Source: AA0mqf7k6uq7goVGKLsUrPD80T8Ge76gaD6ZFn9Ptykpw7sVnQb9QOcdAAYIVk513e6BatfwVYJUcjXb++l+fAS9lXw=
X-Received: by 2002:adf:e2c9:0:b0:241:db86:176d with SMTP id
 d9-20020adfe2c9000000b00241db86176dmr8947881wrj.40.1669245806183; Wed, 23 Nov
 2022 15:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-6-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-6-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:23:13 -0800
Message-ID: <CAP-5=fWZ27QW+XvZx0bzEMmUbyKpmmmZudB9u=SyxiLcH3CCqw@mail.gmail.com>
Subject: Re: [PATCH 05/15] perf stat: Remove prefix argument in print_metric_headers()
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
> It always passes a whitespace to the function, thus we can just add it to the
> function body.  Furthermore, it's only used in the normal output mode.
>
> Well, actually CSV used it but it doesn't need to since we don't care about the
> indentation or alignment in the CSV output.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 744b7a40f59a..deed6ccf072f 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -996,10 +996,9 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>  }
>
>  static void print_metric_headers_std(struct perf_stat_config *config,
> -                                    const char *prefix, bool no_indent)
> +                                    bool no_indent)
>  {
> -       if (prefix)
> -               fprintf(config->output, "%s", prefix);
> +       fputc(' ', config->output);
>
>         if (!no_indent) {
>                 int len = aggr_header_lens[config->aggr_mode];
> @@ -1012,11 +1011,8 @@ static void print_metric_headers_std(struct perf_stat_config *config,
>  }
>
>  static void print_metric_headers_csv(struct perf_stat_config *config,
> -                                    const char *prefix,
>                                      bool no_indent __maybe_unused)
>  {
> -       if (prefix)
> -               fprintf(config->output, "%s", prefix);
>         if (config->interval)
>                 fputs("time,", config->output);
>         if (!config->iostat_run)
> @@ -1024,7 +1020,6 @@ static void print_metric_headers_csv(struct perf_stat_config *config,
>  }
>
>  static void print_metric_headers_json(struct perf_stat_config *config,
> -                                     const char *prefix __maybe_unused,
>                                       bool no_indent __maybe_unused)
>  {
>         if (config->interval)
> @@ -1032,8 +1027,7 @@ static void print_metric_headers_json(struct perf_stat_config *config,
>  }
>
>  static void print_metric_headers(struct perf_stat_config *config,
> -                                struct evlist *evlist,
> -                                const char *prefix, bool no_indent)
> +                                struct evlist *evlist, bool no_indent)
>  {
>         struct evsel *counter;
>         struct outstate os = {
> @@ -1047,11 +1041,11 @@ static void print_metric_headers(struct perf_stat_config *config,
>         };
>
>         if (config->json_output)
> -               print_metric_headers_json(config, prefix, no_indent);
> +               print_metric_headers_json(config, no_indent);
>         else if (config->csv_output)
> -               print_metric_headers_csv(config, prefix, no_indent);
> +               print_metric_headers_csv(config, no_indent);
>         else
> -               print_metric_headers_std(config, prefix, no_indent);
> +               print_metric_headers_std(config, no_indent);
>
>         if (config->iostat_run)
>                 iostat_print_header_prefix(config);
> @@ -1132,7 +1126,7 @@ static void print_header_interval_std(struct perf_stat_config *config,
>         }
>
>         if (config->metric_only)
> -               print_metric_headers(config, evlist, " ", true);
> +               print_metric_headers(config, evlist, true);
>         else
>                 fprintf(output, " %*s %*s events\n",
>                         COUNTS_LEN, "counts", config->unit_width, "unit");
> @@ -1168,7 +1162,7 @@ static void print_header_std(struct perf_stat_config *config,
>         fprintf(output, ":\n\n");
>
>         if (config->metric_only)
> -               print_metric_headers(config, evlist, " ", false);
> +               print_metric_headers(config, evlist, false);
>  }
>
>  static void print_header_csv(struct perf_stat_config *config,
> @@ -1178,7 +1172,7 @@ static void print_header_csv(struct perf_stat_config *config,
>                              const char **argv __maybe_unused)
>  {
>         if (config->metric_only)
> -               print_metric_headers(config, evlist, " ", true);
> +               print_metric_headers(config, evlist, true);
>  }
>  static void print_header_json(struct perf_stat_config *config,
>                               struct target *_target __maybe_unused,
> @@ -1187,7 +1181,7 @@ static void print_header_json(struct perf_stat_config *config,
>                               const char **argv __maybe_unused)
>  {
>         if (config->metric_only)
> -               print_metric_headers(config, evlist, " ", true);
> +               print_metric_headers(config, evlist, true);
>  }
>
>  static void print_header(struct perf_stat_config *config,
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
