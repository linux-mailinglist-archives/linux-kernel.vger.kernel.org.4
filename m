Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC015EECDA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 06:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiI2Ezm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 00:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI2Ezg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 00:55:36 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2300B24BD1;
        Wed, 28 Sep 2022 21:55:35 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so254482otu.7;
        Wed, 28 Sep 2022 21:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XdauQRO5GX4CqGC4TQcrFEXL4gGAbOqG1RaD+qZHf0E=;
        b=fN/J5lE1+hk5XP+/ieD1GHVI8vaYbQmjhflbNQr2rJhJBrA0/OaL1knecaogSZ4YVf
         VtfL9J+ffDFqEHcmWoxNAGEdUzBUYeTXmIypBp4B/WpGAAsLZXfqgpP2yLyKAtrXAHrA
         249vV1C1vmKQvvGE6LjnxPjl5P8qjP+1cnHZLXi6DOyn9+m4WFDsbIgZxp1pfGvT1C1m
         AFXXDCbsLRQouuBzVEpdsr1ziTZM7hPHR3f9/U2TouSC87OgGSz+dvNuqpyLAtg3Cikc
         IP8mi7PDnTZzVnSrRrIPkjNf24BYAecL0jQqymZHJMsva3/WujIRbCByslNc+vdslF//
         nJ9A==
X-Gm-Message-State: ACrzQf2ULLv4brVjX1mPUbNQbcHILSpI6LmXL+dSLu31N9lTH9Sm9a1f
        QNq+nXItVpLuK/H5usGfs6nqEQgc1saQEe/vgMZqI6KA
X-Google-Smtp-Source: AMsMyM4aghJf9Evfil/A7SRRZy/OF9IZUpCbTc9r2nXxdyu1jEO4/KrOjeS0b3o0BmSPU0J4JM5gjXUeanHZH3CJOh0=
X-Received: by 2002:a05:6830:1351:b0:65b:e0a8:d0e8 with SMTP id
 r17-20020a056830135100b0065be0a8d0e8mr592380otq.190.1664427334403; Wed, 28
 Sep 2022 21:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220926200757.1161448-1-namhyung@kernel.org> <20220926200757.1161448-5-namhyung@kernel.org>
 <CAP-5=fVY2QP6f=8CvZqERCZzH+sB6A-_wK-edukrz4eeGUz5zg@mail.gmail.com>
In-Reply-To: <CAP-5=fVY2QP6f=8CvZqERCZzH+sB6A-_wK-edukrz4eeGUz5zg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 28 Sep 2022 21:55:23 -0700
Message-ID: <CAM9d7cjorFczG4_v7+dxZ=W-ZngVAiVNzuCLpmLkeO-_rGNmGg@mail.gmail.com>
Subject: Re: [PATCH 4/6] perf stat: Use thread map index for shadow stat
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Wed, Sep 28, 2022 at 7:10 PM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Sep 26, 2022 at 1:08 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > When AGGR_THREAD is active, it aggregates the values for each thread.
> > Previously it used cpu map index which is invalid for AGGR_THREAD so
> > it had to use separate runtime stats with index 0.
> >
> > But it can just use the rt_stat with thread_map_index.  Rename the
> > first_shadow_map_idx() and make it return the thread index.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/stat-display.c | 20 +++++++++-----------
> >  tools/perf/util/stat.c         |  8 ++------
> >  2 files changed, 11 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 234491f43c36..570e2c04d47d 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -442,7 +442,7 @@ static void print_metric_header(struct perf_stat_config *config,
> >                 fprintf(os->fh, "%*s ", config->metric_only_len, unit);
> >  }
> >
> > -static int first_shadow_cpu_map_idx(struct perf_stat_config *config,
> > +static int first_shadow_map_idx(struct perf_stat_config *config,
> >                                 struct evsel *evsel, const struct aggr_cpu_id *id)
> >  {
> >         struct perf_cpu_map *cpus = evsel__cpus(evsel);
> > @@ -452,6 +452,9 @@ static int first_shadow_cpu_map_idx(struct perf_stat_config *config,
> >         if (config->aggr_mode == AGGR_NONE)
> >                 return perf_cpu_map__idx(cpus, id->cpu);
> >
> > +       if (config->aggr_mode == AGGR_THREAD)
> > +               return id->thread;
>
> The function's name implies returning an index but that isn't clear
> here. Can we change the aggr_cpu_id's thread to be called thread_idx?

Right, I'll do that in a separate commit.

Thanks,
Namhyung
