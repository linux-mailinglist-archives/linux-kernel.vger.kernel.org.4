Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01849735DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjFSTxT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jun 2023 15:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFSTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:53:18 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F829106;
        Mon, 19 Jun 2023 12:53:17 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-77e2c42de06so114917139f.1;
        Mon, 19 Jun 2023 12:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204396; x=1689796396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwjjWJbckqLC0DUD1BfaDzlGec384tGs2YHcTWXeqAY=;
        b=a+3y5UrEg4kOcMwjRSFqa6FboqI2Fh7cr+cdN8D8HaiJOe3Swkx/7AbpZRgVRH3Weg
         7nWPkEfLAttXO6w4k/Y5nRZaBiocEwkdRvOe5jIHKRvPl5zpyRhm6qIRZq02uwiBivKH
         sufKTexFYeyriJ4PloB8/PZUsnF2wUX+tpVOxaKxr+5kmuw1nVo0/ed6ZJp0ThlCrVcE
         vay+EnDc5pWwlczdZU0qLiY5PL+pKZSbXjXM5gHuPzydQZnssF034nyXi/T/RM04w4xR
         IVgP2g5zaifxNF+S+HQSI8+VsxfWNUJCxzS9PR/vgRVohnOPUmCvAGhkjygN1qnfsYSa
         ribw==
X-Gm-Message-State: AC+VfDwcCCzl+Jt8+OEsKottxgdSLs1XlaXm5zpHdQOszkxNCazm9oFx
        jAAX2VMqD2DJm00zggBowuR7ShvL9hh5KtEoNQ1r09L4
X-Google-Smtp-Source: ACHHUZ4KqIEyABYJ4zsHUN+gCyx8U6Uht+5LhdBc4KUk8jGigaIqL7PjmSlXyE7pc2jstCLyNJaN4sGJWDC+BdKlsUg=
X-Received: by 2002:a6b:5905:0:b0:77e:2883:13f3 with SMTP id
 n5-20020a6b5905000000b0077e288313f3mr8687490iob.14.1687204396546; Mon, 19 Jun
 2023 12:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230616073211.1057936-1-namhyung@kernel.org> <ZI3/Nmch0ufFJ7Dp@krava>
In-Reply-To: <ZI3/Nmch0ufFJ7Dp@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 19 Jun 2023 12:53:05 -0700
Message-ID: <CAM9d7cjJnHkg9nrCQyOZjt0DtsXv1p6U8haE9RYparnq8xZoMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf stat: Reset aggr stats for each run
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

Hi Jiri,

On Sat, Jun 17, 2023 at 11:45 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Fri, Jun 16, 2023 at 12:32:10AM -0700, Namhyung Kim wrote:
> > When it runs multiple times with -r option, it missed to reset the
> > aggregation counters and the values were added up.  The aggregation
> > count has the values to be printed in the end.  It should reset the
> > counters at the beginning of each run.  But the current code does that
> > only when -I/--interval-print option is given.
> >
> > Fixes: 91f85f98da7a ("perf stat: Display event stats using aggr counts")
> > Reported-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index c87c6897edc9..e549862f90f0 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -725,6 +725,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >                       all_counters_use_bpf = false;
> >       }
> >
> > +     evlist__reset_aggr_stats(evsel_list);
> > +
>
> would it be better to call this below before read_counters call,
> together with the other counts setup calls?
>
> jirka

To me, the counter setup for the interval mode and summary is
kinda an exceptional case.

Thanks,
Namhyung
