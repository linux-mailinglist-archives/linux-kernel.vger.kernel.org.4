Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EDF735E13
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjFSUA7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jun 2023 16:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFSUA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:00:58 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B9211B;
        Mon, 19 Jun 2023 13:00:57 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-77faf29bdf1so3062139f.0;
        Mon, 19 Jun 2023 13:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204856; x=1689796856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAro3jK74ZfeFA/3l4ku7dA8uGjjLqikZaPjW5cbOLU=;
        b=UixJu0g88riVMvh9HxXm1IYrElyfTFzetzrmzmwMxUTnsMPXmHngZXqjJxIfvV1bC/
         J6rLCizeF/xGn+LjVJKKov4rNCp7l+pKUt1wqwUhnR/CZHbv7RywXd2V47I5QadQvZp1
         cA/03hbDTTlspwnIgQHBthM9+mEm5vK41Uj3psjCrFt9lBg5mbjeoqNw6/mG32FWdcCR
         trw68znXN+x6ovL9FmzkgcpcD/aa/b8vieYv0xRwaMeiYiK2rpyoD7sanYlJrg9z+97p
         2FvUZttDIB4jRfdyP9FSRyjIgYWRuh7NbhDhO3DjYZXTq57J24janmoIc2jG1kpATDAb
         pJRg==
X-Gm-Message-State: AC+VfDwqZUl7u0b5pgw2rLKHHD+eWQiICbUwlByn4guzRrEJZpmJU3KZ
        2ssfKs6HxkyLO0flF29MxRxXO/3nrLQszmjFhug=
X-Google-Smtp-Source: ACHHUZ649rDadfHFKvadKsAGu1EgChZHTrdUJKeQPOXVbKwuS6BAoecEYuasLpzTWUZQwi4HeupmKkTlNtT131fD6i4=
X-Received: by 2002:a5e:c814:0:b0:777:abbb:2b6a with SMTP id
 y20-20020a5ec814000000b00777abbb2b6amr10152871iol.19.1687204856062; Mon, 19
 Jun 2023 13:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230616073211.1057936-1-namhyung@kernel.org> <20230616073211.1057936-2-namhyung@kernel.org>
 <ZI3/LphHu0tP6pib@krava>
In-Reply-To: <ZI3/LphHu0tP6pib@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 19 Jun 2023 13:00:44 -0700
Message-ID: <CAM9d7cgEJ=0Y_Y42gN0RN95YXZPzWfXmeLKuNYqJeSWFMbQ5fA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf stat: Show average value on multiple runs
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 11:45 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Fri, Jun 16, 2023 at 12:32:11AM -0700, Namhyung Kim wrote:
> > When -r option is used, perf stat runs the command multiple times and
> > update stats in the evsel->stats.res_stats for global aggregation.  But
> > the value is never used and the value it prints at the end is just the
> > value from the last run.  I think we should print the average number of
> > multiple runs.
> >
> > Add evlist__copy_res_stats() to update the aggr counter (for display)
> > using the values in the evsel->stats.res_stats.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> this is the 'real' fix right? I thought this was the way it worked before

It worked like the patch 1/2 before.

>
> anyway works nicely now, would be nice to add some tests for this,
> but not sure how bad it'd be ;-)

Maybe we can parse the raw counter output from the -v option and
calculate the average then compare.

>
> Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

Thanks,
Namhyung


>
> > ---
> >  tools/perf/builtin-stat.c |  5 ++++-
> >  tools/perf/util/stat.c    | 22 ++++++++++++++++++++++
> >  tools/perf/util/stat.h    |  1 +
> >  3 files changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index e549862f90f0..42f84975a4d5 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2829,8 +2829,11 @@ int cmd_stat(int argc, const char **argv)
> >               }
> >       }
> >
> > -     if (!forever && status != -1 && (!interval || stat_config.summary))
> > +     if (!forever && status != -1 && (!interval || stat_config.summary)) {
> > +             if (stat_config.run_count > 1)
> > +                     evlist__copy_res_stats(&stat_config, evsel_list);
> >               print_counters(NULL, argc, argv);
> > +     }
> >
> >       evlist__finalize_ctlfd(evsel_list);
> >
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 0f7b8a8cdea6..967e583392c7 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -264,6 +264,28 @@ void evlist__copy_prev_raw_counts(struct evlist *evlist)
> >               evsel__copy_prev_raw_counts(evsel);
> >  }
> >
> > +static void evsel__copy_res_stats(struct evsel *evsel)
> > +{
> > +     struct perf_stat_evsel *ps = evsel->stats;
> > +
> > +     /*
> > +      * For GLOBAL aggregation mode, it updates the counts for each run
> > +      * in the evsel->stats.res_stats.  See perf_stat_process_counter().
> > +      */
> > +     *ps->aggr[0].counts.values = avg_stats(&ps->res_stats);
> > +}
> > +
> > +void evlist__copy_res_stats(struct perf_stat_config *config, struct evlist *evlist)
> > +{
> > +     struct evsel *evsel;
> > +
> > +     if (config->aggr_mode != AGGR_GLOBAL)
> > +             return;
> > +
> > +     evlist__for_each_entry(evlist, evsel)
> > +             evsel__copy_res_stats(evsel);
> > +}
> > +
> >  static size_t pkg_id_hash(long __key, void *ctx __maybe_unused)
> >  {
> >       uint64_t *key = (uint64_t *) __key;
> > diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> > index 7abff7cbb5a1..1cbc26b587ba 100644
> > --- a/tools/perf/util/stat.h
> > +++ b/tools/perf/util/stat.h
> > @@ -182,6 +182,7 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
> >
> >  int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr);
> >  void evlist__reset_aggr_stats(struct evlist *evlist);
> > +void evlist__copy_res_stats(struct perf_stat_config *config, struct evlist *evlist);
> >
> >  int perf_stat_process_counter(struct perf_stat_config *config,
> >                             struct evsel *counter);
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
