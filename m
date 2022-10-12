Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90745FC942
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJLQ2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiJLQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:27:56 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1818F87E3;
        Wed, 12 Oct 2022 09:27:52 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id m81so19665424oia.1;
        Wed, 12 Oct 2022 09:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPvQ2ckwdWjATNmKyZjjKYE9ucjYa3sJIA9zZiUleEg=;
        b=pWUID1xbLz3B4NNl7L7VFdouuCgM/xMYI3WDIZ0a5w4luHsB9/cSRnU82ukEAA0DMi
         l/JR99YLVApRqstn3OizOIxRImpDyeEPGfkZQWAbQ5KxVyjJfE+h5hh/dgmkTWJc5otu
         hvCiHV4RNsm6kNzGdDkKVY8tHsmUk39UTffoT/h3r3DefN9xGJfpT4ddo+Xep5U4NWej
         iGQLeDlbJr0sdowp7oxO1XWYmTxze/JaMEh30OyaN5b4HlbSBIhdqL2stb7vllP2pOXf
         zZG2YUvWdVC2b3QnuaukJkIGezJjpHfAqgDiA9WOxfDAQ5EgGMiGsVPL8RuR4Urrihf+
         IyPQ==
X-Gm-Message-State: ACrzQf2wsGQ9WerKc9x8gpOz2r6Tvi946rwKt9UGs1fPEQy/F/l49p1w
        bAkz3BqAIv7cU6VSVRZ+SirBu8vxalX+y2Io/3E=
X-Google-Smtp-Source: AMsMyM7pEIycrhkTjwr6rZ+sybz7kQP2Be7v7Z65rufYwsmxD0x5Cwn0PLe7KghKgt5ZIRAQ02Tdn0xOfdYiOYWdcPc=
X-Received: by 2002:a05:6808:181e:b0:350:e92a:9ab1 with SMTP id
 bh30-20020a056808181e00b00350e92a9ab1mr2416429oib.209.1665592070740; Wed, 12
 Oct 2022 09:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-6-namhyung@kernel.org>
 <Y0aZmHecB7Ahiuuh@krava>
In-Reply-To: <Y0aZmHecB7Ahiuuh@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 12 Oct 2022 09:27:39 -0700
Message-ID: <CAM9d7chx2Ec7NhBf=nSA2eJ-Wyn2+TWKjVx4BViR0KZf1H4LWw@mail.gmail.com>
Subject: Re: [PATCH 05/19] perf stat: Add cpu aggr id for no aggregation mode
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
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

On Wed, Oct 12, 2022 at 3:40 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Sun, Oct 09, 2022 at 10:35:46PM -0700, Namhyung Kim wrote:
> > Likewise, add an aggr_id for cpu for none aggregation mode.  This is not
> > used actually yet but later code will use to unify the aggregation code.
> >
> > No functional change intended.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c | 48 +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 43 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 144bb3a657f2..b00ef20aef5b 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -1339,6 +1339,12 @@ static struct aggr_cpu_id perf_stat__get_global(struct perf_stat_config *config
> >       return id;
> >  }
> >
> > +static struct aggr_cpu_id perf_stat__get_cpu(struct perf_stat_config *config __maybe_unused,
> > +                                          struct perf_cpu cpu)
> > +{
> > +     return aggr_cpu_id__cpu(cpu, /*data=*/NULL);
> > +}
> > +
> >  static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
> >                                             aggr_get_id_t get_id, struct perf_cpu cpu)
> >  {
> > @@ -1381,6 +1387,12 @@ static struct aggr_cpu_id perf_stat__get_global_cached(struct perf_stat_config *
> >       return perf_stat__get_aggr(config, perf_stat__get_global, cpu);
> >  }
> >
> > +static struct aggr_cpu_id perf_stat__get_cpu_cached(struct perf_stat_config *config,
> > +                                                 struct perf_cpu cpu)
> > +{
> > +     return perf_stat__get_aggr(config, perf_stat__get_cpu, cpu);
> > +}
> > +
> >  static bool term_percore_set(void)
> >  {
> >       struct evsel *counter;
> > @@ -1407,8 +1419,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
> >       case AGGR_NONE:
> >               if (term_percore_set())
> >                       return aggr_cpu_id__core;
> > -
> > -             return NULL;
> > +             return aggr_cpu_id__cpu;;
>
> nit, double ;; ;-)

Good eye :)  I'll remove it.

Thanks,
Namhyung
