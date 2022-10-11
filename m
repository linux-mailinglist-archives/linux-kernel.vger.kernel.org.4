Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6554A5FBE74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJKXhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJKXhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:37:50 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953BF70E72;
        Tue, 11 Oct 2022 16:37:49 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-131dda37dddso17830044fac.0;
        Tue, 11 Oct 2022 16:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XDU81a2RufP86fsqPRDrPpgDQZ/jo8nOSWFnTrBOqo=;
        b=KiQwo8X/eg62z5oO7WJ0HdeyrxBt9APNiaxplAmUhYjwhqlrgotSTNm73zQ+BEdiFq
         Q3rSep9+4aUy02imt2lxf+1BzQMmgEuOLihAa9Ky0NZ5s6bXo8C7l/PFhgSz9ysF25fe
         BT8m0YG4DNr3Qj1KQmpn/OaT2KBCAiLUrxbffvKNDF9jziFYqbDyieoubUmDegA0NoAB
         8boYm9azRmZIP0WIiLtvUGR5RAZJ03e12npLsR5jNh5Vfca5UQcGPqrleCivVE1pR7fl
         IqnZHZxg2lGkC+VeqPmv0x1OQgcSvE6DuTjQIWkJ/fGFY+89RM//EzPwf5hB/PWCYz99
         kfmg==
X-Gm-Message-State: ACrzQf3pFsD5rV4EuEwxHotOhA9DAM1H4TFlhjj3x0R6C3ATla3I0jJJ
        pLVBFe8XZuM3LvBNxmlsZH6SNap9KsED0IpQXXE=
X-Google-Smtp-Source: AMsMyM5QskzNfQ4+jwx7QetaRMoHXIMazgs47CvpGck0eJnzfXnMilzKhMEP2P9JKfp2RN8Cl290dyrbCSrjiAIyWJg=
X-Received: by 2002:a05:6870:82ac:b0:133:34b:6f10 with SMTP id
 q44-20020a05687082ac00b00133034b6f10mr970609oae.218.1665531468856; Tue, 11
 Oct 2022 16:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-8-namhyung@kernel.org>
 <CAP-5=fXU-ydTrDXVp_WoyuvgvaHEVt0kVY2kDCGYTrpebw7RtA@mail.gmail.com>
In-Reply-To: <CAP-5=fXU-ydTrDXVp_WoyuvgvaHEVt0kVY2kDCGYTrpebw7RtA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Oct 2022 16:37:37 -0700
Message-ID: <CAM9d7chdfqcabk-L4Jo2STbMCof=isSPnXN6fOApLNQp2E5Kug@mail.gmail.com>
Subject: Re: [PATCH 07/19] perf stat: Add struct perf_stat_aggr to perf_stat_evsel
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
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

On Mon, Oct 10, 2022 at 4:01 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The perf_stat_aggr struct is to keep aggregated counter values and the
> > states according to the aggregation mode.  The number of entries is
> > depends on the mode and this is a preparation for the later use.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/stat.c | 34 +++++++++++++++++++++++++++-------
> >  tools/perf/util/stat.h |  9 +++++++++
> >  2 files changed, 36 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 8ec8bb4a9912..c9d5aa295b54 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -133,15 +133,33 @@ static void perf_stat_evsel_id_init(struct evsel *evsel)
> >  static void evsel__reset_stat_priv(struct evsel *evsel)
> >  {
> >         struct perf_stat_evsel *ps = evsel->stats;
> > +       struct perf_stat_aggr *aggr = ps->aggr;
> >
> >         init_stats(&ps->res_stats);
> > +
> > +       if (aggr)
> > +               memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);
> >  }
> >
> > -static int evsel__alloc_stat_priv(struct evsel *evsel)
> > +
> > +static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
> >  {
> > -       evsel->stats = zalloc(sizeof(struct perf_stat_evsel));
> > -       if (evsel->stats == NULL)
> > +       struct perf_stat_evsel *ps;
> > +
> > +       ps = zalloc(sizeof(*ps));
> > +       if (ps == NULL)
> >                 return -ENOMEM;
> > +
> > +       if (nr_aggr) {
> > +               ps->nr_aggr = nr_aggr;
> > +               ps->aggr = calloc(nr_aggr, sizeof(*ps->aggr));
> > +               if (ps->aggr == NULL) {
> > +                       free(ps);
> > +                       return -ENOMEM;
> > +               }
> > +       }
> > +
> > +       evsel->stats = ps;
> >         perf_stat_evsel_id_init(evsel);
> >         evsel__reset_stat_priv(evsel);
> >         return 0;
> > @@ -151,8 +169,10 @@ static void evsel__free_stat_priv(struct evsel *evsel)
> >  {
> >         struct perf_stat_evsel *ps = evsel->stats;
> >
> > -       if (ps)
> > +       if (ps) {
> > +               zfree(&ps->aggr);
> >                 zfree(&ps->group_data);
> > +       }
> >         zfree(&evsel->stats);
> >  }
> >
> > @@ -181,9 +201,9 @@ static void evsel__reset_prev_raw_counts(struct evsel *evsel)
> >                 perf_counts__reset(evsel->prev_raw_counts);
> >  }
> >
> > -static int evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
> > +static int evsel__alloc_stats(struct evsel *evsel, int nr_aggr, bool alloc_raw)
> >  {
> > -       if (evsel__alloc_stat_priv(evsel) < 0 ||
> > +       if (evsel__alloc_stat_priv(evsel, nr_aggr) < 0 ||
> >             evsel__alloc_counts(evsel) < 0 ||
> >             (alloc_raw && evsel__alloc_prev_raw_counts(evsel) < 0))
> >                 return -ENOMEM;
> > @@ -196,7 +216,7 @@ int evlist__alloc_stats(struct evlist *evlist, bool alloc_raw)
> >         struct evsel *evsel;
> >
> >         evlist__for_each_entry(evlist, evsel) {
> > -               if (evsel__alloc_stats(evsel, alloc_raw))
> > +               if (evsel__alloc_stats(evsel, 0, alloc_raw))
> >                         goto out_free;
> >         }
> >
> > diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> > index b0899c6e002f..ea356e5aa351 100644
> > --- a/tools/perf/util/stat.h
> > +++ b/tools/perf/util/stat.h
> > @@ -8,6 +8,7 @@
> >  #include <sys/resource.h>
> >  #include "cpumap.h"
> >  #include "rblist.h"
> > +#include "counts.h"
> >
> >  struct perf_cpu_map;
> >  struct perf_stat_config;
> > @@ -42,9 +43,17 @@ enum perf_stat_evsel_id {
> >         PERF_STAT_EVSEL_ID__MAX,
> >  };
> >
>
> The new struct variables below are all worth comments.

Sure, will add.

>
> > +struct perf_stat_aggr {
> > +       struct perf_counts_values       counts;
> > +       int                             nr;
>
> Could this value be derived from counts.values.size ?

Do you mean sizeof() or ARRAY_SIZE() for counts.values?
There's no counts.values.size..

It's a completely different thing.  It's to count how many CPUs are
aggregated to the entry (aggregate-number in JSON).

Thanks,
Namhyung


>
> > +       bool                            failed;
> > +};
> > +
> >  struct perf_stat_evsel {
> >         struct stats             res_stats;
> >         enum perf_stat_evsel_id  id;
> > +       int                      nr_aggr;
> > +       struct perf_stat_aggr   *aggr;
> >         u64                     *group_data;
> >  };
> >
> > --
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >
