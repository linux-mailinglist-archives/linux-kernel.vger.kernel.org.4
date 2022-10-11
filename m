Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B781F5FBE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJKXq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJKXqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:46:53 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562C212D19;
        Tue, 11 Oct 2022 16:46:52 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id x188so8596088oig.5;
        Tue, 11 Oct 2022 16:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+jSu74pLdnkgUkNCu7qrxgZoYTo1apPFR5+KLAbnZk=;
        b=HVQ5WDvqdiQyS2aMkVpaSY3mbRIv2RrzjepSAIAZeeohpIqe0Zm6YNbMt+ZGw4SoJ4
         Dfd2lksiQkGJ05kWS5uJwfjrNz+FbzKG6dr+2NaSFIgtg1DGsy5+WrFPKcGPAHuHDLMN
         djt9xPIsOBVy/LSGLqFzpYZn4at4FRzPzol3Zt7GHPECeZd9P6Cph66PosZsR9M83O/b
         ee9TJmAm1AcLruqktfNI+bQ8eSDwFuWTGVZrw0Nov3XJpnqIboK1sRomr/sZ8szi4Wp4
         YPP+LGQiLw28Yk1mVSgOzYH9pVU7lSY9A+K/qwCr3HQqtd4ZbmQjnC4SNnL0Arr96c6Z
         j50w==
X-Gm-Message-State: ACrzQf0sPQ27lnci3kGeqb6Xm5fc01Z7JQDzaThxd6GtMslQfwvP7N9R
        w3Bs26/QvXkxg03WR4hTHSITmlM2XrMKllbVVuc=
X-Google-Smtp-Source: AMsMyM4d8olfnxRs5NwcLLsdLeIO7N1lz2GrZss4C+XJMY7hProhWWJYgEArJv1OcPL3Zfzoh1aSkWRUScwGU1CstLQ=
X-Received: by 2002:a05:6808:1a09:b0:350:107b:f89a with SMTP id
 bk9-20020a0568081a0900b00350107bf89amr823549oib.218.1665532011577; Tue, 11
 Oct 2022 16:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-11-namhyung@kernel.org>
 <CAP-5=fWOsyXHC_wTjGr0MRoaohhWyQZA8jmn5W+RivNhp6tcaQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWOsyXHC_wTjGr0MRoaohhWyQZA8jmn5W+RivNhp6tcaQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Oct 2022 16:46:40 -0700
Message-ID: <CAM9d7chWqTv=3gGZGcExzyqEBX-Zng39su2Ho=nykxj42X1TMw@mail.gmail.com>
Subject: Re: [PATCH 10/19] perf stat: Aggregate per-thread stats using evsel->stats->aggr
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

On Mon, Oct 10, 2022 at 4:17 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Per-thread aggregation doesn't use the CPU numbers but the logic should
> > be the same.  Initialize cpu_aggr_map separately for AGGR_THREAD and use
> > thread map idx to aggregate counter values.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c | 31 +++++++++++++++++++++++++++++++
> >  tools/perf/util/stat.c    | 19 +++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 139e35ed68d3..c76240cfc635 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -1468,6 +1468,21 @@ static int perf_stat_init_aggr_mode(void)
> >                 stat_config.aggr_get_id = aggr_mode__get_id(stat_config.aggr_mode);
> >         }
> >
> > +       if (stat_config.aggr_mode == AGGR_THREAD) {
> > +               nr = perf_thread_map__nr(evsel_list->core.threads);
> > +               stat_config.aggr_map = cpu_aggr_map__empty_new(nr);
> > +               if (stat_config.aggr_map == NULL)
> > +                       return -ENOMEM;
> > +
> > +               for (int s = 0; s < nr; s++) {
> > +                       struct aggr_cpu_id id = aggr_cpu_id__empty();
> > +
> > +                       id.thread_idx = s;
> > +                       stat_config.aggr_map->map[s] = id;
> > +               }
> > +               return 0;
> > +       }
> > +
> >         /*
> >          * The evsel_list->cpus is the base we operate on,
> >          * taking the highest cpu number to be the size of
> > @@ -1677,6 +1692,22 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
> >         aggr_cpu_id_get_t get_id = aggr_mode__get_aggr_file(stat_config.aggr_mode);
> >         bool needs_sort = stat_config.aggr_mode != AGGR_NONE;
> >
> > +       if (stat_config.aggr_mode == AGGR_THREAD) {
> > +               int nr = perf_thread_map__nr(evsel_list->core.threads);
> > +
> > +               stat_config.aggr_map = cpu_aggr_map__empty_new(nr);
> > +               if (stat_config.aggr_map == NULL)
> > +                       return -ENOMEM;
> > +
> > +               for (int s = 0; s < nr; s++) {
> > +                       struct aggr_cpu_id id = aggr_cpu_id__empty();
> > +
> > +                       id.thread_idx = s;
> > +                       stat_config.aggr_map->map[s] = id;
> > +               }
> > +               return 0;
> > +       }
> > +
> >         if (!get_id)
> >                 return 0;
> >
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 99874254809d..013dbe1c5d28 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -403,6 +403,24 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
> >                 evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
> >         perf_counts_values__scale(count, config->scale, NULL);
> >
> > +       if (config->aggr_mode == AGGR_THREAD) {
> > +               struct perf_counts_values *aggr_counts = &ps->aggr[thread].counts;
> > +
> > +               /*
> > +                * Skip value 0 when enabling --per-thread globally,
> > +                * otherwise too many 0 output.
> > +                */
> > +               if (count->val == 0 && config->system_wide)
> > +                       return 0;
> > +
> > +               ps->aggr[thread].nr++;
> > +
> > +               aggr_counts->val += count->val;
> > +               aggr_counts->ena += count->ena;
> > +               aggr_counts->run += count->run;
> > +               goto update;
>
> nit: perhaps there is a more intention revealing name than update here.

thread_map_idx ? ;-)  I think we need to rename it separately.

>
> Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Namhyung


>
> > +       }
> > +
> >         if (ps->aggr) {
> >                 struct perf_cpu cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx);
> >                 struct aggr_cpu_id aggr_id = config->aggr_get_id(config, cpu);
> > @@ -437,6 +455,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
> >                 }
> >         }
> >
> > +update:
> >         switch (config->aggr_mode) {
> >         case AGGR_THREAD:
> >         case AGGR_CORE:
> > --
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >
