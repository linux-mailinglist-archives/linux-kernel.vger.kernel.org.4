Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2255F718B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiJFXOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFXOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:14:12 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39753CAE42;
        Thu,  6 Oct 2022 16:14:11 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id m81so3768726oia.1;
        Thu, 06 Oct 2022 16:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrdJHykdGg+uqQr1xuCcI9qmw82BLzLpbFbGIT9A8cI=;
        b=5Glx1Hdib6Aq/yscYXhzfDSyJFd1vdxEPJFcAmtirkW2fm7FPl4SYfC/kUU+5j1s7Q
         yCG69FUEuyGTNllYTf5pkCEjHjIhIYyCUMt6azMAsubc7GFJ99VAcAcm27bE3EUWRTWt
         WNAfs+1tJGmYwtxKIzRNw6Suucc8cbjAV6Hhf0EefFOw/y1a1posC34evacYjRboftkE
         j5xwpw62w4/j67MEuUpBa2ZYqIFphtR1l5hk183IxA3r4kTPqoAhlYILOK77dWDrUCmf
         hhb2I6pHKbuwdIxMM1NLBM8UkEjhfvBmWTBG9FI+zzPysIGIwfNsHy9wi096bwzBbqzE
         DljQ==
X-Gm-Message-State: ACrzQf1pwQtx3gK6utS67m/4e/QfrPiU88jrk0SgLdT2kteGVRoTTaer
        eKNqI2+ZhI+YZEkfGPvp1jzXNXf1cLuVSZJJzSgr34Sx
X-Google-Smtp-Source: AMsMyM6W9NSmoDIWNChWEwjgs4Vd/lGovSYAB0MEA4jEokHZ0/cDoMzP0ivAFT6ieKDmcEev3rnptaA+oOFADJEtiWg=
X-Received: by 2002:a05:6808:1a09:b0:350:107b:f89a with SMTP id
 bk9-20020a0568081a0900b00350107bf89amr1037565oib.218.1665098050325; Thu, 06
 Oct 2022 16:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221003204647.1481128-1-namhyung@kernel.org> <20221003204647.1481128-2-namhyung@kernel.org>
 <CAP-5=fU6yqFKS+dYZ9VcoPftEGh3+oebLsZSOgEaG-XdNFZ7pQ@mail.gmail.com>
In-Reply-To: <CAP-5=fU6yqFKS+dYZ9VcoPftEGh3+oebLsZSOgEaG-XdNFZ7pQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 6 Oct 2022 16:13:59 -0700
Message-ID: <CAM9d7cgc-Jt6DG_i4d-7_03F_D_0w_+-SpeFJiPKYSL+Z6q2Aw@mail.gmail.com>
Subject: Re: [PATCH 1/5] libperf: Populate system-wide evsel maps
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Thu, Oct 6, 2022 at 11:44 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Oct 3, 2022 at 1:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Setting proper cpu and thread maps for system wide evsels regardless of
> > user requested cpu in __perf_evlist__propagate_maps().  Those evsels
> > need to be active on all cpus always.  Do it in the libperf so that we
> > can guarantee it has proper maps.
> >
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/lib/perf/evlist.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 6b1bafe267a4..187129652ab6 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -40,11 +40,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> >          * We already have cpus for evsel (via PMU sysfs) so
> >          * keep it, if there's no target cpu list defined.
> >          */
>
> This comment is for the 'else if' case and so is a little out of place
> before the system wide test.

Right, I'll add a comment for system-wide evsels too.

>
> > -       if (!evsel->own_cpus ||
> > -           (!evsel->system_wide && evlist->has_user_cpus) ||
> > -           (!evsel->system_wide &&
> > -            !evsel->requires_cpu &&
> > -            perf_cpu_map__empty(evlist->user_requested_cpus))) {
> > +       if (evsel->system_wide) {
> > +               perf_cpu_map__put(evsel->cpus);
> > +               evsel->cpus = perf_cpu_map__new(NULL);
>
> Looking at perf_cpu_map__new, will this mean that in system wide mode
> every event/evsel will now read /sys/devices/system/cpu/online here?
> We may want to cache the cpumap to avoid this.

Yeah, it's redundant.  I thought it's ok since the system-wide evsels
are not common.  We can consider caching when it becomes a problem.

Thanks,
Namhyung


>
> > +       } else if (!evsel->own_cpus || evlist->has_user_cpus ||
> > +                  (!evsel->requires_cpu && perf_cpu_map__empty(evlist->user_requested_cpus))) {
> >                 perf_cpu_map__put(evsel->cpus);
> >                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> >         } else if (evsel->cpus != evsel->own_cpus) {
> > @@ -52,7 +52,10 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> >                 evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
> >         }
> >
> > -       if (!evsel->system_wide) {
> > +       if (evsel->system_wide) {
> > +               perf_thread_map__put(evsel->threads);
> > +               evsel->threads = perf_thread_map__new_dummy();
> > +       } else {
> >                 perf_thread_map__put(evsel->threads);
> >                 evsel->threads = perf_thread_map__get(evlist->threads);
> >         }
> > --
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >
