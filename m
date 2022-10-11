Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5134B5FBE2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiJKXIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJKXIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:08:51 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC346208;
        Tue, 11 Oct 2022 16:08:50 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so17667166fac.11;
        Tue, 11 Oct 2022 16:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lM4dukkH64jx35JJ8WYxXDnPM9ws2xWZW9AOHZRMC0Q=;
        b=gM0gYIJyzq9MlMpaFQjOkv/yE387EKN2gvZD9Ybm1kjmglvvxZ3Gn7TJGj0NZw6P2a
         N4yjKMc35BUuisqPDRba+hHWt9QF9Ptg1o5zEhlO6N4XA97I/k+r0WeP5IH7Q1KcL3ju
         fBV8sURcU0PYRCoXEQRCCJ1GC7fXL+k1s/ilxnEKfRs7wFuxEtUnr+vyKetKbDxEMzFB
         k86j04Lssjr0pxiXi3cr6Lah1WRVCraS4UgT+R/OioSFMrWXtZn5hVz8aEVIpl0VC1Kd
         Cu85T37tcGtr4uPOz/3cVpMRIN7ErLqD/2IWn0cVtHyQdiFz7ld9HZy6TYyKxry8Kt0a
         8n2g==
X-Gm-Message-State: ACrzQf1W/z/tOy1OeveEQVXK174mQZESZptl1ZeauFVdN/0smMXSrUFc
        uZTLwTdnHlRt93cTGsNQpuhsZybzfmV6EnUVi+A=
X-Google-Smtp-Source: AMsMyM6UkTgk5rDcJ8qPqNPBdg9SSYthBQLH1MGKLcJRhTGvEQh3Dm3H/DXGNbYq1At3XKXJG6XC/16HASDHZirm4WY=
X-Received: by 2002:a05:6870:82ac:b0:133:34b:6f10 with SMTP id
 q44-20020a05687082ac00b00133034b6f10mr914459oae.218.1665529729724; Tue, 11
 Oct 2022 16:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-5-namhyung@kernel.org>
 <CAP-5=fUTJUWYXEBxUKSTRqWLw3Ckuy+0nq0fpUQNgt3_BVEFdA@mail.gmail.com>
In-Reply-To: <CAP-5=fUTJUWYXEBxUKSTRqWLw3Ckuy+0nq0fpUQNgt3_BVEFdA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Oct 2022 16:08:38 -0700
Message-ID: <CAM9d7cjsuyBj7n2NbiryOs7s66GBU6g7aWPAH9roOb4ziZdW_Q@mail.gmail.com>
Subject: Re: [PATCH 04/19] perf stat: Add aggr id for global mode
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

On Mon, Oct 10, 2022 at 3:46 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > To make the code simpler, I'd like to use the same aggregation code for
> > the global mode.  We can simply add an id function to return cpu 0 and
> > use print_aggr().
> >
> > No functional change intended.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c      | 39 ++++++++++++++++++++++++++++++++--
> >  tools/perf/util/cpumap.c       | 10 +++++++++
> >  tools/perf/util/cpumap.h       |  6 +++++-
> >  tools/perf/util/stat-display.c |  9 ++------
> >  4 files changed, 54 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 265b05157972..144bb3a657f2 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -1330,6 +1330,15 @@ static struct aggr_cpu_id perf_stat__get_node(struct perf_stat_config *config __
> >         return aggr_cpu_id__node(cpu, /*data=*/NULL);
> >  }
> >
> > +static struct aggr_cpu_id perf_stat__get_global(struct perf_stat_config *config __maybe_unused,
> > +                                               struct perf_cpu cpu __maybe_unused)
> > +{
> > +       struct aggr_cpu_id id = aggr_cpu_id__empty();
> > +
> > +       id.cpu = (struct perf_cpu){ .cpu = 0 };
> > +       return id;
> > +}
> > +
>
> See below, I think this should just return aggr_cpu_id__global or just
> call that directly.

Ok, will do.

>
> >  static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
> >                                               aggr_get_id_t get_id, struct perf_cpu cpu)
> >  {
> > @@ -1366,6 +1375,12 @@ static struct aggr_cpu_id perf_stat__get_node_cached(struct perf_stat_config *co
> >         return perf_stat__get_aggr(config, perf_stat__get_node, cpu);
> >  }
> >
> > +static struct aggr_cpu_id perf_stat__get_global_cached(struct perf_stat_config *config,
> > +                                                      struct perf_cpu cpu)
> > +{
> > +       return perf_stat__get_aggr(config, perf_stat__get_global, cpu);
> > +}
> > +
> >  static bool term_percore_set(void)
> >  {
> >         struct evsel *counter;
> > @@ -1395,6 +1410,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
> >
> >                 return NULL;
> >         case AGGR_GLOBAL:
> > +               return aggr_cpu_id__global;
> >         case AGGR_THREAD:
> >         case AGGR_UNSET:
> >         case AGGR_MAX:
> > @@ -1420,6 +1436,7 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
> >                 }
> >                 return NULL;
> >         case AGGR_GLOBAL:
> > +               return perf_stat__get_global_cached;
> >         case AGGR_THREAD:
> >         case AGGR_UNSET:
> >         case AGGR_MAX:
> > @@ -1535,6 +1552,16 @@ static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(struct perf_cpu cpu, vo
> >         return id;
> >  }
> >
> > +static struct aggr_cpu_id perf_env__get_global_aggr_by_cpu(struct perf_cpu cpu __maybe_unused,
> > +                                                          void *data __maybe_unused)
> > +{
> > +       struct aggr_cpu_id id = aggr_cpu_id__empty();
> > +
> > +       /* it always aggregates to the cpu 0 */
> > +       id.cpu = (struct perf_cpu){ .cpu = 0 };
> > +       return id;
> > +}
> > +
> >  static struct aggr_cpu_id perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
> >                                                      struct perf_cpu cpu)
> >  {
> > @@ -1558,6 +1585,12 @@ static struct aggr_cpu_id perf_stat__get_node_file(struct perf_stat_config *conf
> >         return perf_env__get_node_aggr_by_cpu(cpu, &perf_stat.session->header.env);
> >  }
> >
> > +static struct aggr_cpu_id perf_stat__get_global_file(struct perf_stat_config *config __maybe_unused,
> > +                                                    struct perf_cpu cpu)
> > +{
> > +       return perf_env__get_global_aggr_by_cpu(cpu, &perf_stat.session->header.env);
> > +}
> > +
> >  static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
> >  {
> >         switch (aggr_mode) {
> > @@ -1569,8 +1602,9 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
> >                 return perf_env__get_core_aggr_by_cpu;
> >         case AGGR_NODE:
> >                 return perf_env__get_node_aggr_by_cpu;
> > -       case AGGR_NONE:
> >         case AGGR_GLOBAL:
> > +               return perf_env__get_global_aggr_by_cpu;
> > +       case AGGR_NONE:
> >         case AGGR_THREAD:
> >         case AGGR_UNSET:
> >         case AGGR_MAX:
> > @@ -1590,8 +1624,9 @@ static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
> >                 return perf_stat__get_core_file;
> >         case AGGR_NODE:
> >                 return perf_stat__get_node_file;
> > -       case AGGR_NONE:
> >         case AGGR_GLOBAL:
> > +               return perf_stat__get_global_file;
> > +       case AGGR_NONE:
> >         case AGGR_THREAD:
> >         case AGGR_UNSET:
> >         case AGGR_MAX:
> > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > index 8486ca3bec75..60209fe87456 100644
> > --- a/tools/perf/util/cpumap.c
> > +++ b/tools/perf/util/cpumap.c
> > @@ -354,6 +354,16 @@ struct aggr_cpu_id aggr_cpu_id__node(struct perf_cpu cpu, void *data __maybe_unu
> >         return id;
> >  }
> >
> > +struct aggr_cpu_id aggr_cpu_id__global(struct perf_cpu cpu, void *data __maybe_unused)
>
> Is this a duplicate of aggr_cpu_id perf_stat__get_global? Could we
> replace all uses of the former with this one?

They are very similar but used for different purposes.
I'll think about how to simplify this code more.

Thanks,
Namhyung
