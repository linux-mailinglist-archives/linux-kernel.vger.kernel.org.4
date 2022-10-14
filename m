Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2275FE921
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJNG4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiJNG4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:56:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BAB18BE0A;
        Thu, 13 Oct 2022 23:56:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id iv17so2524224wmb.4;
        Thu, 13 Oct 2022 23:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HflhXWzlYkKjXTpNTgAvezmfuY9pxXz8yiwpNBCy+f0=;
        b=E7kyPvBGnrRHw6Xouwvm660Oao0nfX39QdF9AXjQKIq5ZVIYZ0upVw1HAyKriOhtkV
         CYCl/bsbIBE5XD9Aykq+8f4SRqZbwSfkn7xgOdnXSs0y4CJOB7XmmT0d9qCQMpCn194Q
         aMOpmgVINjSZ4xsywyrT/9Gk+vuI2NpALDw6dC3g6PnSBo6dVt+NHOeCm1FKcwK57ZS2
         sZNQlBzPKtuwHsV143DjwQM+PIN984O1gRLpqeFFVYxS+KNwt2Mx6OD08FOPWKMS4j3a
         gNQoMjSsb9zrOBz2qisZ8OPcgwB2jBquwe0qhZoiqCIBEUYtU97RLE27MT1fTsXMB9+T
         BYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HflhXWzlYkKjXTpNTgAvezmfuY9pxXz8yiwpNBCy+f0=;
        b=cu3TLkcp4K3pTRjWxF3IMtWyh3hFtysdPHGFfGiAq8T2i6DojXYbimo2Ue/U+ECkTf
         CR6djDoeW6Pe6ZBbD92/hiZ59TXyxsepo1bwC7zzvriMF1utzSc+h3GjOft2yRd1JrnY
         7/qkIAU3dx7ccE0S5JQ3Rw7Wjnt7Y40J5fJzJ9X73S4WZ2wgKd6GMENBjU3eFEQXcOS9
         ko/jsaMy53vjkW9kjaCg7BYP6/zjAx64sdW3bullfCvgcfoLYPYx+kLj2XgQXFnSxcsB
         tZXhLyNHQ2GK9gb5j/kVu7HjQcoWtzlbQUwuRPcHab7ONlOaFV8TTHBYMCHFu1pgKepa
         yeSg==
X-Gm-Message-State: ACrzQf3icNmFIs6SS3/jknnJRBSOZ0gcTFMejDYH5M3zgJCKpLpqhoFu
        DoKMl8sAZIG9eJI1jIIEg8c=
X-Google-Smtp-Source: AMsMyM5o9HiutMmIp5nLB9OKGUXTFl9EA1JoSxbo3y8CqJn+OzFi56X1Oaaa1b/SFGbsh9N7a/DvdA==
X-Received: by 2002:a05:600c:4ec6:b0:3c6:c469:d295 with SMTP id g6-20020a05600c4ec600b003c6c469d295mr9129129wmq.117.1665730570424;
        Thu, 13 Oct 2022 23:56:10 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c311000b003c6237e867esm1409033wmo.0.2022.10.13.23.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:56:09 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 14 Oct 2022 08:56:07 +0200
To:     Namhyung Kim <namhyung@kernel.org>,
        Michael Petlan <mpetlan@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCHSET 00/19] perf stat: Cleanup counter aggregation (v2)
Message-ID: <Y0kIB7hxlnlEYipZ@krava>
References: <20221014061550.463644-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014061550.463644-1-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 11:15:31PM -0700, Namhyung Kim wrote:
> Hello,
> 
> Current perf stat code is somewhat hard to follow since it handles
> many combinations of PMUs/events for given display and aggregation
> options.  This is my attempt to clean it up a little. ;-)
> 
> changes in v2)
>  * fix a segfault in perf stat report for per-process record  (Jiri)
>  * fix metric only display  (Jiri)
>  * add evsel__reset_aggr_stat  (ian)
>  * add more comments  (Ian)
>  * add Acked-by from Ian
> 
> My first concern is that aggregation and display routines are intermixed
> and processed differently depends on the aggregation mode.  I'd like to
> separate them apart and make the logic clearer.
> 
> To do that, I added struct perf_stat_aggr to save the aggregated counter
> values and other info.  It'll be allocated and processed according to
> the aggr_mode and display logic will use it.
> 
> I've tested the following combination.
> 
>   $ cat test-matrix.sh
>   #!/bin/sh
> 
>   set -e
> 
>   yes > /dev/null &
>   TARGET=$!
> 
>   ./perf stat true
>   ./perf stat -a true
>   ./perf stat -C0 true
>   ./perf stat -p $TARGET true
>   ./perf stat -t $TARGET true
> 
>   ./perf stat -a -A true
>   ./perf stat -a --per-node true
>   ./perf stat -a --per-socket true
>   ./perf stat -a --per-die true
>   ./perf stat -a --per-core true
>   ./perf stat -a --per-thread true
> 
>   ./perf stat -a -I 500 sleep 1
>   ./perf stat -a -I 500 --summary sleep 1
>   ./perf stat -a -I 500 --per-socket sleep 1
>   ./perf stat -a -I 500 --summary --per-socket sleep 1
> 
>   ./perf stat -a --metric-only true
>   ./perf stat -a --metric-only --per-socket true
>   ./perf stat -a --metric-only -I 500 sleep 1
>   ./perf stat -a --metric-only -I 500 --per-socket sleep 1
> 
>   ./perf stat record true && ./perf stat report
>   ./perf stat record -p $TARGET true && ./perf stat report
>   ./perf stat record -a true && ./perf stat report
>   ./perf stat record -a --per-core true && ./perf stat report
>   ./perf stat record -a --per-core --metric-only true && ./perf stat report
>   ./perf stat record -a -I 500 sleep 1 && ./perf stat report
>   ./perf stat record -a -I 500 --per-core sleep 1 && ./perf stat report
>   ./perf stat record -a -I 500 --per-core --metric-only sleep 1 && ./perf stat report
> 
>   ./perf stat -a -A -e cpu/event=cpu-cycles,percore/ true
>   ./perf stat -a -A -e cpu/event=cpu-cycles,percore/ --percore-show-thread true
> 
>   kill $TARGET
> 
> The code is available at 'perf/stat-aggr-v2' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Michael,
ay chance you could run your test suite on top of this change?

thanks,
jirka

> 
> Thanks,
> Namhyung
> 
> Namhyung Kim (19):
>   perf tools: Save evsel->pmu in parse_events()
>   perf tools: Use pmu info in evsel__is_hybrid()
>   perf stat: Use evsel__is_hybrid() more
>   perf stat: Add aggr id for global mode
>   perf stat: Add cpu aggr id for no aggregation mode
>   perf stat: Add 'needs_sort' argument to cpu_aggr_map__new()
>   perf stat: Add struct perf_stat_aggr to perf_stat_evsel
>   perf stat: Allocate evsel->stats->aggr properly
>   perf stat: Aggregate events using evsel->stats->aggr
>   perf stat: Aggregate per-thread stats using evsel->stats->aggr
>   perf stat: Allocate aggr counts for recorded data
>   perf stat: Reset aggr counts for each interval
>   perf stat: Split process_counters()
>   perf stat: Add perf_stat_merge_counters()
>   perf stat: Add perf_stat_process_percore()
>   perf stat: Add perf_stat_process_shadow_stats()
>   perf stat: Display event stats using aggr counts
>   perf stat: Display percore events properly
>   perf stat: Remove unused perf_counts.aggr field
> 
>  tools/perf/builtin-script.c                   |   4 +-
>  tools/perf/builtin-stat.c                     | 186 +++++--
>  tools/perf/tests/parse-metric.c               |   2 +-
>  tools/perf/tests/pmu-events.c                 |   2 +-
>  tools/perf/util/counts.c                      |   1 -
>  tools/perf/util/counts.h                      |   1 -
>  tools/perf/util/cpumap.c                      |  16 +-
>  tools/perf/util/cpumap.h                      |   8 +-
>  tools/perf/util/evsel.c                       |  13 +-
>  tools/perf/util/parse-events.c                |   1 +
>  tools/perf/util/pmu.c                         |   4 +
>  .../scripting-engines/trace-event-python.c    |   6 -
>  tools/perf/util/stat-display.c                | 462 +++---------------
>  tools/perf/util/stat.c                        | 385 ++++++++++++---
>  tools/perf/util/stat.h                        |  40 +-
>  15 files changed, 602 insertions(+), 529 deletions(-)
> 
> 
> base-commit: d79310700590b8b40d8c867012d6c899ea6fd505
> -- 
> 2.38.0.413.g74048e4d9e-goog
> 
