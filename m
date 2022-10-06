Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E954D5F71A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiJFXWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJFXWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:22:09 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B005DCD5DE;
        Thu,  6 Oct 2022 16:22:08 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-132e9bc5ff4so3901050fac.7;
        Thu, 06 Oct 2022 16:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmsVmNuvH5llXHCRrOMCMsMCaj3Vx0koPaw1zFQJKGg=;
        b=dFJ3gs0fRPIoZ5zoOFDaPveUe/IPr/t1OQy7LGZhKwlM3/PzkIwWvYyw7LrRdiyqjw
         sIu7nSL1ri1eSbkoxaEZK0WCKgPZamj4/fe7YNKFU2ndKu9Pyz1Bvs/GERBRpLyYJ728
         N6pAEZ5kB+9IekdP6xr9viIiA51xc/zvb4SZZCPz/R6AqPHpbI83M6GiZTd+DuER6BET
         ZwNj+v8g23aCOQJmVpDgUM+zkkmltCD81A/8p40twf8JhAXk4B7II1D7hz/nQpaDM1CY
         d6+MCcKv0uW2sP8RS1q8YZoLunr56rZypDMKWNFLDyUT+2m0bGSgd39D0Gr96SW3xxfL
         5/Hg==
X-Gm-Message-State: ACrzQf0XODKV/CokkF/qUZJP06Coo017QKZG1/Ds4wtwigYXPDPa62z0
        tpY8WWunuMMVwMOHWO92EbMilIfl0eS5WxAvX2s=
X-Google-Smtp-Source: AMsMyM56OlhXuQFe9+f8r7Wln7s2fdsIdnceFep7gSXsFNaiNfg9hHxz50jzN1NIlXQl5NZx0Siy2Sl36Yg2IEvYoMI=
X-Received: by 2002:a05:6870:82ac:b0:133:34b:6f10 with SMTP id
 q44-20020a05687082ac00b00133034b6f10mr1172379oae.218.1665098527991; Thu, 06
 Oct 2022 16:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221003204647.1481128-1-namhyung@kernel.org> <20221003204647.1481128-3-namhyung@kernel.org>
 <CAP-5=fUw9j=PJrJ1khM2L9bpYbFYK3=0MKeeJqT2Y5mGasCvJA@mail.gmail.com>
In-Reply-To: <CAP-5=fUw9j=PJrJ1khM2L9bpYbFYK3=0MKeeJqT2Y5mGasCvJA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 6 Oct 2022 16:21:56 -0700
Message-ID: <CAM9d7chCu0Ji7hdNcxq1tX+H1zaxgs5NkZUjU_5b5-s+J0FFJQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
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

On Thu, Oct 6, 2022 at 11:52 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Oct 3, 2022 at 1:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The current code propagate evsel's cpu map settings to evlist when it's
> > added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
> > be updated in perf_evlist__set_maps() later.  No need to do it before
> > evlist's cpus are set actually.
> >
> > In fact it discards this intermediate all_cpus maps at the beginning
> > of perf_evlist__set_maps().  Let's not do this.  It's only needed when
> > an evsel is added after the evlist cpu/thread maps are set.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/lib/perf/evlist.c                  | 11 ++++-------
> >  tools/lib/perf/include/internal/evlist.h |  1 +
> >  2 files changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 187129652ab6..8ce92070086c 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -67,9 +67,7 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
> >  {
> >         struct perf_evsel *evsel;
> >
> > -       /* Recomputing all_cpus, so start with a blank slate. */
> > -       perf_cpu_map__put(evlist->all_cpus);
> > -       evlist->all_cpus = NULL;
> > +       evlist->needs_map_propagation = true;
>
> Might be nice to also clear this in  perf_evlist__init.

It's zero-initialized so I skipped it.  I couldn't find places
where it resets the existing evlist.

But now I think we should not call perf_evlist__set_maps()
in evlist__init() from perf tools.

>
> >
> >         perf_evlist__for_each_evsel(evlist, evsel)
> >                 __perf_evlist__propagate_maps(evlist, evsel);
> > @@ -81,7 +79,9 @@ void perf_evlist__add(struct perf_evlist *evlist,
> >         evsel->idx = evlist->nr_entries;
> >         list_add_tail(&evsel->node, &evlist->entries);
> >         evlist->nr_entries += 1;
> > -       __perf_evlist__propagate_maps(evlist, evsel);
> > +
> > +       if (evlist->needs_map_propagation)
> > +               __perf_evlist__propagate_maps(evlist, evsel);
>
> I think a comment here would be useful. Something like:
> Adding events won't set the CPU maps in the evlist until
> set_maps/propogate_maps is called. Catch the case that an evsel is
> added after this and propagate the map.

Looks good, will add!

Thanks,
Namhyung


> >  }
> >
> >  void perf_evlist__remove(struct perf_evlist *evlist,
> > @@ -177,9 +177,6 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
> >                 evlist->threads = perf_thread_map__get(threads);
> >         }
> >
> > -       if (!evlist->all_cpus && cpus)
> > -               evlist->all_cpus = perf_cpu_map__get(cpus);
> > -
> >         perf_evlist__propagate_maps(evlist);
> >  }
> >
> > diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> > index 6f89aec3e608..850f07070036 100644
> > --- a/tools/lib/perf/include/internal/evlist.h
> > +++ b/tools/lib/perf/include/internal/evlist.h
> > @@ -19,6 +19,7 @@ struct perf_evlist {
> >         int                      nr_entries;
> >         int                      nr_groups;
> >         bool                     has_user_cpus;
> > +       bool                     needs_map_propagation;
> >         /**
> >          * The cpus passed from the command line or all online CPUs by
> >          * default.
> > --
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >
