Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D431F5FABD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 07:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJKFLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 01:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKFLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 01:11:02 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6757434D;
        Mon, 10 Oct 2022 22:10:58 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so9330520ooi.5;
        Mon, 10 Oct 2022 22:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1h7gSGZg4DTZEH7LcjVqRebaNFrvvbESRqvvQ7pkDY=;
        b=ANIph0n6/oh4yDj632ZGcWbw5bo2MArESCQrpm+u25Z50UKNxLuouFv16yk6G+HZl6
         dnwboFry9riXYHDX93Xoa5mOgKraoAZrfyGX3sIggxNhnd3+W2DGzBRzrLcUH6k/Wx+l
         FZn5+knoaT9LoCBDt2FTsAG3FZs2DRFcurtpHHl6C9S+RynKAAnjRXFZFJKE5HXor4zZ
         KGQZgE0wHRE7subroS1cY1t5TNgxwqvD5PEseHpERsrhLulbGzCZAnIVCBxtEMvfBX9t
         hm0Tve03yzv0HSgsJvOsdT44lTNooQsfBYe9LdTdZ9QI/H1x0NACFBIh4N2qekb38nNO
         CTXg==
X-Gm-Message-State: ACrzQf3CUGHz2MipLrvAnixRhRxq/j2wf+uAtZGDY6me6OF4EmdrhJrQ
        c1pUlwBW7UsBSmNaGIVz7AdBBitA2xbtBvQ0Jh0=
X-Google-Smtp-Source: AMsMyM6dLZqDVY7iR+LUP10viasrCeNvYJBybhYdFE9fGEM9Z+O0dcsauCPV7osWxik7PZqFDUt7nT0deHUV69APEE0=
X-Received: by 2002:a9d:3e9:0:b0:661:a8a2:7b96 with SMTP id
 f96-20020a9d03e9000000b00661a8a27b96mr1957803otf.190.1665465057711; Mon, 10
 Oct 2022 22:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-3-namhyung@kernel.org>
 <CAP-5=fU+Rg+AsgqAFs1bbLHnVOMi2_0cUHdxnohfmAw6ezrz+A@mail.gmail.com>
In-Reply-To: <CAP-5=fU+Rg+AsgqAFs1bbLHnVOMi2_0cUHdxnohfmAw6ezrz+A@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 10 Oct 2022 22:10:48 -0700
Message-ID: <CAM9d7ci9iz8ciQTw4YnabOgaY-izF+yGCeBawx-1fn2syVZ-Mw@mail.gmail.com>
Subject: Re: [PATCH 02/19] perf tools: Use pmu info in evsel__is_hybrid()
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
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

Hi Ian,

On Mon, Oct 10, 2022 at 3:31 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > If evsel has pmu, it can use pmu->is_hybrid directly.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/evsel.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 196f8e4859d7..a6ea91c72659 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3132,6 +3132,9 @@ void evsel__zero_per_pkg(struct evsel *evsel)
> >
> >  bool evsel__is_hybrid(struct evsel *evsel)
> >  {
> > +       if (evsel->pmu)
> > +               return evsel->pmu->is_hybrid;
> > +
> >         return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
>
> Wow, there's so much duplicated state. Why do evsels have a pmu_name
> and a pmu? Why not just pmu->name? I feel always having a pmu would be
> cleanest here.

Thanks a lot Ian for your detailed review!

The evsel->pmu was added recently for checking missing features.
And I just made it to have the pmu info when parsing events.

I guess it has pmu_name because it didn't want to add pmu.c dependency
to the python module.  But this change only adds pmu.h dependency.


> That said what does evsel__is_hybrid even mean? Does it
> mean this event is on a PMU normally called cpu and called cpu_core
> and cpu_atom on hybrid systems? And of course there are no comments to
> explain what this little mystery could be.

I believe so.


> Anyway, that's not a fault
> of this change, and probably later changes will go someway toward
> cleaning this up. It was a shame the code wasn't cleaner in the first
> place.
>
> Acked-by: Ian Rogers

Thanks,
Namhyung
