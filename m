Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795285FBE83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJKXtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJKXs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:48:59 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CB389AD7;
        Tue, 11 Oct 2022 16:48:58 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id g130so17527020oia.13;
        Tue, 11 Oct 2022 16:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51+WzLwOLRUCuh6wRX4RH6dibS7amRk8kyHvdjXTteQ=;
        b=gr41T1KikGoV+OQzL6w19bCamlTD/+AWbRGFrZ1KPM38M9FGncik4r51+lZs3/VLJj
         4uKjN5OHswWKugE4+8f4dinAl22qxaFPvOCG1nu+zadnlhKL10E80c6sKHZKdy+JG5is
         UIePsJ3H679LJU6HpIcCQlYmCUANcFtzC1auQ3QIm52i9QtBEDM4ykr52mxjbfgrEm3i
         Bjl2VcPS9VsoOH7gAzbNByWbZcaWIHda53MlMSnO16M4N6FXaiaPmngMRRLHn3WwgFny
         rk+2eX6eIN5rrJZvMZeijBb5C45lUipbl8FAt1Xf/qxTKkPfoTSRm2UNXfLE8kWpmaHK
         8cCw==
X-Gm-Message-State: ACrzQf1vIl5IgU75ADuvNHPqhYIIzfS1+F7xtdvABN2RvJn6VUiUGbOo
        fdMS8daYR8c8iSBNnRxHFXjyHcZnxfddb21/eTWNmYd1
X-Google-Smtp-Source: AMsMyM7jxZ5pBNYCthaao2bTM5m48yNnrJbKAHaJSdW56kxZX5+xhQWHHtI4+HvcTKkQwhaRPxU5y6C62QybbBMKoeA=
X-Received: by 2002:a05:6808:181e:b0:350:e92a:9ab1 with SMTP id
 bh30-20020a056808181e00b00350e92a9ab1mr749522oib.209.1665532138216; Tue, 11
 Oct 2022 16:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-13-namhyung@kernel.org>
 <CAP-5=fVeJAfgWU62vY6LK6Buj2BFrpwwYw_mxt3F-VEUEf7NiQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVeJAfgWU62vY6LK6Buj2BFrpwwYw_mxt3F-VEUEf7NiQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Oct 2022 16:48:47 -0700
Message-ID: <CAM9d7ciBYF5zXTHzdubeE1nVw8SewLO=UBwmsxKhjhExujLgQw@mail.gmail.com>
Subject: Re: [PATCH 12/19] perf stat: Reset aggr counts for each interval
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 4:20 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The evsel->stats->aggr->count should be reset for interval processing
> > since we want to use the values directly for display.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c |  3 +++
> >  tools/perf/util/stat.c    | 13 +++++++++++++
> >  tools/perf/util/stat.h    |  1 +
> >  3 files changed, 17 insertions(+)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 983f38cd4caa..38036f40e993 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -492,6 +492,8 @@ static void process_interval(void)
> >         diff_timespec(&rs, &ts, &ref_time);
> >
> >         perf_stat__reset_shadow_per_stat(&rt_stat);
> > +       evlist__reset_aggr_stats(evsel_list);
> > +
> >         read_counters(&rs);
> >
> >         if (STAT_RECORD) {
> > @@ -965,6 +967,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >
> >                 evlist__copy_prev_raw_counts(evsel_list);
> >                 evlist__reset_prev_raw_counts(evsel_list);
> > +               evlist__reset_aggr_stats(evsel_list);
> >                 perf_stat__reset_shadow_per_stat(&rt_stat);
> >         } else {
> >                 update_stats(&walltime_nsecs_stats, t1 - t0);
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 279aa4ea342d..4edfc1c5dc07 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -276,6 +276,19 @@ void evlist__reset_stats(struct evlist *evlist)
> >         }
> >  }
> >
> > +void evlist__reset_aggr_stats(struct evlist *evlist)
> > +{
> > +       struct evsel *evsel;
> > +
> > +       evlist__for_each_entry(evlist, evsel) {
> > +               struct perf_stat_evsel *ps = evsel->stats;
> > +               struct perf_stat_aggr *aggr = ps->aggr;
> > +
> > +               if (aggr)
> > +                       memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);
>
> Perhaps this would be cleaner with helper functions on perf_stat_evsel
> and perf_stat_aggr?

Sounds good.  Will add.

Thanks,
Namhyung
