Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B21636E69
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiKWXbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKWXbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:31:43 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE60340923
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:31:40 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i12so79094wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/GzkdSJX9SNnKwY3qDUaOPRLL/gIxEhMol0Hco9KJpI=;
        b=pJigdusRH1JM3OUzwj2QESzt6NcfAn7uDMEsODC5XoSSnhwnwUsElhvuQ5sM8aU7nr
         2iZQNQjM/uGkSrp5Se1jUs35kDGavm4vtBgYtMeGuaW8+9lv3+qXppXdnCKNeqnTkLp2
         gXhKCgodjbjHHdyhB+dfIhSbSQKQXlpAqVMYVBVMxj22VqwryovoonYrDWoJ159RzOVu
         7LR6me/japqo6FLVcDyZ4hVvbbwLEjpYn3EoqBqhNb7XWff9r8lRBmnDfJhhm6x4TvY7
         QyEq5gb+xxiSEorfhRW0W7nQDDufKRiUOM4P6FyWjIM1tNwTvZrmjF0EtDPqP9qasPEO
         cxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GzkdSJX9SNnKwY3qDUaOPRLL/gIxEhMol0Hco9KJpI=;
        b=sb4Fa2MIDvtspVVVgbLDF6TLuGYmOsoQ4sBkzQX/0+fNkRaTIeLc3adBN03NIn/vIH
         Sj8qRNa/t+BATsj0U8rNaPN1qUFN2N321v6V2tN/NOjybwvx6Okui/lSEacMu9Vva2dA
         roctj3L9dx7GZU+qKaAA4tn5SLfdWJqf8+WHHine+OWyx6UarCvLv44fA73+cTgtrw4V
         k7EnJJXV7FRgxDxokYWMIJY8uUAe4lj1kIH+GmlNYt3gEDIL9M98T3X87b0j4KCmvD+k
         eeWB7BicBlR2ZzMzgADaNZ3pOHdSyoO9FwGns2C/G4qeSTpOm5wMIKyXLaeuThbMT36m
         qsWw==
X-Gm-Message-State: ANoB5pkfljQf/AvJtpdej+4byyiBK+sdTp2Q/6q3Gq2j0FGjwQlPvT9P
        fq7xhpAt9ta0wP4VNXebIusqVhrsXOC79Szxcn4hsA==
X-Google-Smtp-Source: AA0mqf6bcwQGpv2OmjpeQVbXNNC8KE4XFllZ+PODDpuME59hW5jYnbqMEvt1epthcqLp92qvIxYH8J/UiNmeYix8oOg=
X-Received: by 2002:adf:e64f:0:b0:241:e2f1:8b44 with SMTP id
 b15-20020adfe64f000000b00241e2f18b44mr6043654wrn.300.1669246299194; Wed, 23
 Nov 2022 15:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-16-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-16-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:31:26 -0800
Message-ID: <CAP-5=fVaUFDwcP9s8aAtxFtRWQnBqRBrZYkKxAxzog_pmicsRQ@mail.gmail.com>
Subject: Re: [PATCH 15/15] perf stat: Tidy up JSON metric-only output when no metrics
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
> It printed empty strings for each metric.  I guess it's needed for CSV
> output to match the column number.  We could just ignore the empty
> metrics in JSON but it ended up with a broken JSON object with a
> trailing comma.
>
> So I added a dummy '"metric-value" : "none"' part.  To do that, it
> needs to pass struct outstate to print_metric_end() to check if any
> metric value is printed or not.
>
> Before:
>   # perf stat -aj --metric-only --per-socket --for-each-cgroup system.slice true
>   {"socket" : "S0", "cpu-count" : 8, "cgroup" : "system.slice", "" : "", "" : "", "" : "", "" : "", "" : "", "" : "", "" : "", "" : ""}
>
> After:
>   # perf stat -aj --metric-only --per-socket --for-each-cgroup system.slice true
>   {"socket" : "S0", "cpu-count" : 8, "cgroup" : "system.slice", "metric-value" : "none"}
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 7a39a1a7261d..847acdb5dc40 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -532,6 +532,8 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
>         while (isdigit(*ends) || *ends == '.')
>                 ends++;
>         *ends = 0;
> +       if (!unit[0] || !vals[0])
> +               return;
>         fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, vals);
>         os->first = false;
>  }
> @@ -864,14 +866,19 @@ static void print_metric_begin(struct perf_stat_config *config,
>         print_cgroup(config, os->cgrp ? : evsel->cgrp);
>  }
>
> -static void print_metric_end(struct perf_stat_config *config)
> +static void print_metric_end(struct perf_stat_config *config, struct outstate *os)
>  {
> +       FILE *output = config->output;
> +
>         if (!config->metric_only)
>                 return;
>
> -       if (config->json_output)
> -               fputc('}', config->output);
> -       fputc('\n', config->output);
> +       if (config->json_output) {
> +               if (os->first)
> +                       fputs("\"metric-value\" : \"none\"", output);
> +               fputc('}', output);
> +       }
> +       fputc('\n', output);
>  }
>
>  static void print_aggr(struct perf_stat_config *config,
> @@ -897,7 +904,7 @@ static void print_aggr(struct perf_stat_config *config,
>
>                         print_counter_aggrdata(config, counter, s, os);
>                 }
> -               print_metric_end(config);
> +               print_metric_end(config, os);
>         }
>  }
>
> @@ -929,7 +936,7 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
>
>                                 print_counter_aggrdata(config, counter, s, os);
>                         }
> -                       print_metric_end(config);
> +                       print_metric_end(config, os);
>                 }
>         }
>  }
> @@ -985,7 +992,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>                         printout(config, os, uval, run, ena, 1.0, counter_idx);
>                 }
>                 if (!first)
> -                       print_metric_end(config);
> +                       print_metric_end(config, os);
>         }
>  }
>
> @@ -1348,7 +1355,7 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
>         evlist__for_each_entry(evlist, counter) {
>                 if (os->cgrp != counter->cgrp) {
>                         if (os->cgrp != NULL)
> -                               print_metric_end(config);
> +                               print_metric_end(config, os);
>
>                         os->cgrp = counter->cgrp;
>                         print_metric_begin(config, evlist, os, /*aggr_idx=*/0);
> @@ -1357,7 +1364,7 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
>                 print_counter(config, counter, os);
>         }
>         if (os->cgrp)
> -               print_metric_end(config);
> +               print_metric_end(config, os);
>  }
>
>  void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
> @@ -1405,7 +1412,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>                         evlist__for_each_entry(evlist, counter) {
>                                 print_counter(config, counter, &os);
>                         }
> -                       print_metric_end(config);
> +                       print_metric_end(config, &os);
>                 }
>                 break;
>         case AGGR_NONE:
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
