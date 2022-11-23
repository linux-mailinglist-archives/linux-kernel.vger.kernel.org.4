Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D709636E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiKWXYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKWXYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:24:21 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A178105594
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:24:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so31662952wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rHyJJLVCU71e8pJbQp4hx6CIMzYReCcbkohFAtlBLN8=;
        b=ZOAFbccB/s5NHUoAVKESL4eJAswOwgv+6COX3zLXVb9aCWRAmNTgkl2Nq7CO04o4Ct
         LyIvbFsmIq9RMf/3WzZ+K6p9QcgSxf90Lys8W2mHulaNQ7vr4W1Xhb06267ZHPyBBCJN
         rSpfxVvuZejs1IAwqrv/+wwDrd/MgYogv153/iIPrwsFaw1Vzvj5xgzsAraO7CcRqHPL
         7Srlv2nrNGcUFbJ3VULn1eyv+niUZTkWtxand1NRlektnnlfr8fiUhLRdLCsJurFORhg
         AXh9C4F5DmCPifHFVM5YXdc2jPJf/h33u3RNIRJ/oG9o/eeiYnkWyuILJzjQViYZXEmG
         O9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHyJJLVCU71e8pJbQp4hx6CIMzYReCcbkohFAtlBLN8=;
        b=J1VLGj+kMG26UBEJnaPY2SpAu95hMGFYdEURt3FwGmkrPLQOOtO5FskI9P/0e64bec
         HcIY4K6glh+/PPYNA8Ncfd+Ie1TZKkPO/TOIJNDSK7ye+CBs+E2cIoS/M6XUhQKkhf0D
         OHqZBJ0OYXP5MN9zIOyln2gsyo5S3CPDWu3M77f9tFu9G+7o7GpAdcagw2hPQIllC6d/
         ZNFJG1v/pThHAFEBWaa06hqPAYHbTbP0AbDY379ILW4OrRATxlnxfsBYWxaZW9u/vFp7
         PhewD4T2cZb4kA9Pk9H4Bb8XL6M1YZBejD5dMH8ceQ+AmMaKTMzjfM8ODue/DYPLbMJB
         92tw==
X-Gm-Message-State: ANoB5pm23QFU5UXM9Nw1jr0oKY/0OZzz7qixvNmqJfNocbdND9dq7p5B
        eODoGZmdtX+6tYNS0jD/b6jOuSyBq63NycRg96nRNg==
X-Google-Smtp-Source: AA0mqf7N3fFZvei3XOp9CT1qTzc6nqyq57m5vR/Ec+kwAHZtF96dDFJVdFbRu3cmOvLalshA/+curiHjO6oeRjK/GV8=
X-Received: by 2002:adf:e64f:0:b0:241:e2f1:8b44 with SMTP id
 b15-20020adfe64f000000b00241e2f18b44mr6035024wrn.300.1669245858705; Wed, 23
 Nov 2022 15:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-8-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-8-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:24:06 -0800
Message-ID: <CAP-5=fVjeoWh8JveYjdWPZFUg96APZAqA9a2jabYE+_Go6-KOg@mail.gmail.com>
Subject: Re: [PATCH 07/15] perf stat: Pass const char *prefix to display routines
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
> This is a minor cleanup and preparation for the later change.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/iostat.h       |  2 +-
>  tools/perf/util/stat-display.c | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/util/iostat.h b/tools/perf/util/iostat.h
> index 23c1c46a331a..c22688f87cb2 100644
> --- a/tools/perf/util/iostat.h
> +++ b/tools/perf/util/iostat.h
> @@ -28,7 +28,7 @@ enum iostat_mode_t {
>
>  extern enum iostat_mode_t iostat_mode;
>
> -typedef void (*iostat_print_counter_t)(struct perf_stat_config *, struct evsel *, char *);
> +typedef void (*iostat_print_counter_t)(struct perf_stat_config *, struct evsel *, const char *);
>
>  int iostat_prepare(struct evlist *evlist, struct perf_stat_config *config);
>  int iostat_parse(const struct option *opt, const char *str,
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index b8432c0a0ec3..d2894a519d61 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -675,7 +675,7 @@ static bool is_mixed_hw_group(struct evsel *counter)
>
>  static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int nr,
>                      struct evsel *counter, double uval,
> -                    char *prefix, u64 run, u64 ena, double noise,
> +                    const char *prefix, u64 run, u64 ena, double noise,
>                      struct runtime_stat *st, int map_idx)
>  {
>         struct perf_stat_output_ctx out;
> @@ -804,7 +804,7 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
>
>  static void print_counter_aggrdata(struct perf_stat_config *config,
>                                    struct evsel *counter, int s,
> -                                  char *prefix)
> +                                  const char *prefix)
>  {
>         FILE *output = config->output;
>         u64 ena, run, val;
> @@ -843,7 +843,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>
>  static void print_metric_begin(struct perf_stat_config *config,
>                                struct evlist *evlist,
> -                              char *prefix, int aggr_idx,
> +                              const char *prefix, int aggr_idx,
>                                struct cgroup *cgrp)
>  {
>         struct perf_stat_aggr *aggr;
> @@ -874,7 +874,7 @@ static void print_metric_end(struct perf_stat_config *config)
>
>  static void print_aggr(struct perf_stat_config *config,
>                        struct evlist *evlist,
> -                      char *prefix)
> +                      const char *prefix)
>  {
>         struct evsel *counter;
>         int s;
> @@ -901,7 +901,7 @@ static void print_aggr(struct perf_stat_config *config,
>
>  static void print_aggr_cgroup(struct perf_stat_config *config,
>                               struct evlist *evlist,
> -                             char *prefix)
> +                             const char *prefix)
>  {
>         struct evsel *counter, *evsel;
>         struct cgroup *cgrp = NULL;
> @@ -934,7 +934,7 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
>  }
>
>  static void print_counter(struct perf_stat_config *config,
> -                         struct evsel *counter, char *prefix)
> +                         struct evsel *counter, const char *prefix)
>  {
>         int s;
>
> @@ -952,7 +952,7 @@ static void print_counter(struct perf_stat_config *config,
>
>  static void print_no_aggr_metric(struct perf_stat_config *config,
>                                  struct evlist *evlist,
> -                                char *prefix)
> +                                const char *prefix)
>  {
>         int all_idx;
>         struct perf_cpu cpu;
> @@ -1301,7 +1301,7 @@ static void print_footer(struct perf_stat_config *config)
>  }
>
>  static void print_percore(struct perf_stat_config *config,
> -                         struct evsel *counter, char *prefix)
> +                         struct evsel *counter, const char *prefix)
>  {
>         bool metric_only = config->metric_only;
>         FILE *output = config->output;
> @@ -1345,7 +1345,7 @@ static void print_percore(struct perf_stat_config *config,
>  }
>
>  static void print_cgroup_counter(struct perf_stat_config *config, struct evlist *evlist,
> -                                char *prefix)
> +                                const char *prefix)
>  {
>         struct cgroup *cgrp = NULL;
>         struct evsel *counter;
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
