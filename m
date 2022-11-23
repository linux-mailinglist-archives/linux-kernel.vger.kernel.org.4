Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE13C636E58
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKWX1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKWX1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:27:02 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CE9110911
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:27:00 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p16so138699wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xWiJIKBcw13JhwopJeRuNAw/j29dHEKJ/eefajfmj6w=;
        b=MsRKyWyn2BV42pkoCtBVbXWdN5fHqtVa6/12TXBvnGbeUpvX9AUgmXIzG8je+BkAEy
         Sy8I9LXdyKJXMw1OOyxbeNNgi5BnbwldvMN7rapJAClrGfMnzLR25F5opiv0IlHLwUWd
         xLa6fPp7AOgbquoNirKJcGqApv4uBPkokOLl/wZC4eOfadavVJwS2qIYTOoVIwXkxmaw
         b+OX0KjwsUttLaPgwpmWc/+bS01MG4YKYCrpoqAErzAFlP768rHw+s0oCFioAEMbc29U
         CZEzNbfGFYUtcDtPAz2SwunuChQ6RbScX5eRAprrL2TYg0a/YG2y2kyETa0FSk/UDVI8
         L9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWiJIKBcw13JhwopJeRuNAw/j29dHEKJ/eefajfmj6w=;
        b=PJja2/VzPAYa/70DjQTQTy5WKW0lx1zfb1UuKK/yvYWCnHUTr068/7nVyGY/Gh20LP
         a4v7gXnaMu5WpV2vKNe8qaPrqVW0eP7i83+ZTGHZ1QPEUFnrcGauByl+3hk7llCJsQmb
         CoAF1K7cWeqLBs76K9VVAeebi1wrtNXBmgDLRCfbk9l0rwK7f1uMgIFw5PIu+08ijAry
         z8E5H6ijvNZfwG0Dpn6TtnqSYee+aqCfTOZ6UDYoKeKcKrEgv213z1CBc4d6tegv4Ckl
         rZNv3bGRopISXH9Fezk2RUIDQgjbhTsuim6G+j4+j5EiUDVOjQFxXi/uNVCKr3sx4SML
         iWVw==
X-Gm-Message-State: ANoB5pmVbfoi0e0mhgx1HNOh7c8NqH3qGOZX/MyfnA3TejdmKeOxErlw
        QQydx5sLCee+z3Blr7sqKZIhR72lVuIh5lfFxC7AQg==
X-Google-Smtp-Source: AA0mqf5veQ9e4nxvYwvI+Z+1owm8QW7DM7njux9KKLu2EMXc7njZy9EK/dvIMBsVoanPjWeT03hzfK/7ftVot8Zq7qg=
X-Received: by 2002:a7b:cb4d:0:b0:3cf:b2a6:267d with SMTP id
 v13-20020a7bcb4d000000b003cfb2a6267dmr21770400wmj.67.1669246018862; Wed, 23
 Nov 2022 15:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-11-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-11-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:26:46 -0800
Message-ID: <CAP-5=fX8mT4RwHQ+k+sr23dv_iWLBRR6fQ4V_2B5LiYuDJzxbQ@mail.gmail.com>
Subject: Re: [PATCH 10/15] perf stat: Pass struct outstate to printout()
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
> The printout() takes a lot of arguments and sets an outstate with the
> value.  Instead, we can fill the outstate first and then pass it to
> reduce the number of arguments.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 38 ++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 3ed63061d6f8..dd190f71e933 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -673,22 +673,15 @@ static bool is_mixed_hw_group(struct evsel *counter)
>         return false;
>  }
>
> -static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int nr,
> -                    struct evsel *counter, double uval,
> -                    const char *prefix, u64 run, u64 ena, double noise,
> +static void printout(struct perf_stat_config *config, struct outstate *os,
> +                    double uval, u64 run, u64 ena, double noise,
>                      struct runtime_stat *st, int map_idx)
>  {
>         struct perf_stat_output_ctx out;
> -       struct outstate os = {
> -               .fh = config->output,
> -               .prefix = prefix ? prefix : "",
> -               .id = id,
> -               .nr = nr,
> -               .evsel = counter,
> -       };
>         print_metric_t pm;
>         new_line_t nl;
>         bool ok = true;
> +       struct evsel *counter = os->evsel;
>
>         if (config->csv_output) {
>                 static const int aggr_fields[AGGR_MAX] = {
> @@ -704,7 +697,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>
>                 pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
>                 nl = config->metric_only ? new_line_metric : new_line_csv;
> -               os.nfields = 3 + aggr_fields[config->aggr_mode] + (counter->cgrp ? 1 : 0);
> +               os->nfields = 3 + aggr_fields[config->aggr_mode] + (counter->cgrp ? 1 : 0);
>         } else if (config->json_output) {
>                 pm = config->metric_only ? print_metric_only_json : print_metric_json;
>                 nl = config->metric_only ? new_line_metric : new_line_json;
> @@ -715,7 +708,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>
>         if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
>                 if (config->metric_only) {
> -                       pm(config, &os, NULL, "", "", 0);
> +                       pm(config, os, NULL, "", "", 0);
>                         return;
>                 }
>
> @@ -732,11 +725,11 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>
>         out.print_metric = pm;
>         out.new_line = nl;
> -       out.ctx = &os;
> +       out.ctx = os;
>         out.force_header = false;
>
>         if (!config->metric_only) {
> -               abs_printout(config, id, nr, counter, uval, ok);
> +               abs_printout(config, os->id, os->nr, counter, uval, ok);
>
>                 print_noise(config, counter, noise, /*before_metric=*/true);
>                 print_running(config, run, ena, /*before_metric=*/true);
> @@ -814,6 +807,13 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>         struct aggr_cpu_id id = config->aggr_map->map[s];
>         double avg = aggr->counts.val;
>         bool metric_only = config->metric_only;
> +       struct outstate os = {
> +               .fh = config->output,
> +               .prefix = prefix ? prefix : "",
> +               .id = id,
> +               .nr = aggr->nr,
> +               .evsel = counter,
> +       };
>
>         if (counter->supported && aggr->nr == 0)
>                 return;
> @@ -834,8 +834,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>
>         uval = val * counter->scale;
>
> -       printout(config, id, aggr->nr, counter, uval,
> -                prefix, run, ena, avg, &rt_stat, s);
> +       printout(config, &os, uval, run, ena, avg, &rt_stat, s);
>
>         if (!metric_only)
>                 fputc('\n', output);
> @@ -971,14 +970,14 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>                 evlist__for_each_entry(evlist, counter) {
>                         u64 ena, run, val;
>                         double uval;
> -                       struct aggr_cpu_id id;
>                         struct perf_stat_evsel *ps = counter->stats;
>                         int counter_idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
>
>                         if (counter_idx < 0)
>                                 continue;
>
> -                       id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
> +                       os.evsel = counter;
> +                       os.id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
>                         if (first) {
>                                 print_metric_begin(config, evlist, &os, counter_idx);
>                                 first = false;
> @@ -988,8 +987,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>                         run = ps->aggr[counter_idx].counts.run;
>
>                         uval = val * counter->scale;
> -                       printout(config, id, 0, counter, uval, prefix,
> -                                run, ena, 1.0, &rt_stat, counter_idx);
> +                       printout(config, &os, uval, run, ena, 1.0, &rt_stat, counter_idx);
>                 }
>                 if (!first)
>                         print_metric_end(config);
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
