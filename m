Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ED86A8DC3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCCAOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCCAOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:14:41 -0500
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E854B1557C;
        Thu,  2 Mar 2023 16:14:39 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id n18so555898ybm.10;
        Thu, 02 Mar 2023 16:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677802479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxhFjB6wT+04i7IE8g/2HrlJL+KNuAl/HmVAg/N+Zjo=;
        b=QkQikpZ4+M5M7n318EjsJ21KF4I+4RNa6TEBu8D/4HE954pPCZRelSIcgknM4tpJXN
         GKAjP+auNNrOYysJKCUQaT1QIHPT3IAxIAhycOZ/UmNnhiBUnB95027y+G9yrOS5j7sK
         DVOJc1BGPPu69dTXFUqlP3g6uIXQSboil5U2RH1UUzkxPDAxfQhjt7SZsu56+hvyG67D
         zyb83djYH+l4Wr16BO3MHJ7C87oecHdthit4ntjt0LELevJz8SYy48eu898A2H275y8T
         vDqrjcrIdi95S5sYhnSAnNBdqiI2KnAF6bwrxTymqf7Ina1OXGd6GKmjYZQp7cNGhwTH
         e6Ag==
X-Gm-Message-State: AO0yUKUKoUDFKM2qiF7dvooqPpCI6/0b7xeTHCCxsGeFvCjSqgYLJNer
        VOmJbQuMzHOV6VBJVl6D3sc8kMb+RnyaOpzlZAM=
X-Google-Smtp-Source: AK7set+gjN0xgGVH4o9V12M7LXq65HeBhX1oX3zwml6XHrMQ5XpaBtjpGNT1YYF6PzjmE0pE+V1M3zVF1MIijH4kJ0c=
X-Received: by 2002:a5b:a01:0:b0:a06:5ef5:3a82 with SMTP id
 k1-20020a5b0a01000000b00a065ef53a82mr5420773ybq.5.1677802479008; Thu, 02 Mar
 2023 16:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com> <20230302212531.1043318-6-irogers@google.com>
In-Reply-To: <20230302212531.1043318-6-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 2 Mar 2023 16:14:27 -0800
Message-ID: <CAM9d7cgwM8Jf1iTgoy6=3kMc1EKG5J=Zqg9q2W4Aq+kdLkyjQQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] perf evsel: Allow const evsel for certain accesses
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Thu, Mar 2, 2023 at 1:26 PM Ian Rogers <irogers@google.com> wrote:
>
> List sorting, added later to evlist, passes const elements requiring
> helper functions to also be const. Make the argument to
> evsel__find_pmu, evsel__is_aux_event and evsel__leader const.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c  | 2 +-
>  tools/perf/util/evsel.h  | 6 +++---
>  tools/perf/util/pmu.c    | 6 +++---
>  tools/perf/util/python.c | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 51e8ce6edddc..2dc2c24252bb 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3139,7 +3139,7 @@ bool evsel__is_hybrid(const struct evsel *evsel)
>         return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
>  }
>
> -struct evsel *evsel__leader(struct evsel *evsel)
> +struct evsel *evsel__leader(const struct evsel *evsel)

It seems like it should return const struct evsel *, right?

>  {
>         return container_of(evsel->core.leader, struct evsel, core);
>  }
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 814a49ebb7e3..676c499323e9 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -212,8 +212,8 @@ int evsel__object_config(size_t object_size,
>                          int (*init)(struct evsel *evsel),
>                          void (*fini)(struct evsel *evsel));
>
> -struct perf_pmu *evsel__find_pmu(struct evsel *evsel);
> -bool evsel__is_aux_event(struct evsel *evsel);
> +struct perf_pmu *evsel__find_pmu(const struct evsel *evsel);
> +bool evsel__is_aux_event(const struct evsel *evsel);
>
>  struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx);
>
> @@ -505,7 +505,7 @@ int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
>
>  void evsel__zero_per_pkg(struct evsel *evsel);
>  bool evsel__is_hybrid(const struct evsel *evsel);
> -struct evsel *evsel__leader(struct evsel *evsel);
> +struct evsel *evsel__leader(const struct evsel *evsel);
>  bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>  bool evsel__is_leader(struct evsel *evsel);
>  void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 43b6182d96b7..45d9b8e28e16 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -988,7 +988,7 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu)
>         return NULL;
>  }
>
> -struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
> +struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
>  {
>         struct perf_pmu *pmu = NULL;
>
> @@ -1000,11 +1000,11 @@ struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
>                         break;
>         }
>
> -       evsel->pmu = pmu;
> +       ((struct evsel *)evsel)->pmu = pmu;

Maybe we can move it out of the function and make callers set it.

Thanks,
Namhyung


>         return pmu;
>  }
>
> -bool evsel__is_aux_event(struct evsel *evsel)
> +bool evsel__is_aux_event(const struct evsel *evsel)
>  {
>         struct perf_pmu *pmu = evsel__find_pmu(evsel);
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 42e8b813d010..ab48ffbb6448 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -83,7 +83,7 @@ const char *perf_env__arch(struct perf_env *env __maybe_unused)
>   * far, for the perf python binding known usecases, revisit if this become
>   * necessary.
>   */
> -struct perf_pmu *evsel__find_pmu(struct evsel *evsel __maybe_unused)
> +struct perf_pmu *evsel__find_pmu(const struct evsel *evsel __maybe_unused)
>  {
>         return NULL;
>  }
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>
