Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5825FBE75
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJKXjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJKXjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:39:02 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2141A71988;
        Tue, 11 Oct 2022 16:39:01 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id k11-20020a4ab28b000000b0047659ccfc28so11119133ooo.8;
        Tue, 11 Oct 2022 16:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ef/adcN1FAIIhtYOqtInxZJyzb4UmSAf1o9Igz8IBzQ=;
        b=xWgi16CHNG3a72ilNXbcFOECeAbXyLvnMjUPSuW4NRFvWeeHNkzJOJ6HTAr4BkLwow
         NgN8VGToRp9kEc6o8bynqGpzweN/Z/lfkljo4eK/qqAqi9ZpheSuu8xXFEvWNN/8A9A5
         cZvaxfK7G2U+/bxGQlgzeOUj2WOmE+lmU8BM3cgfGRxkWtuBLPhijUpQ8SJfzOTtKlLh
         rqPrjSxKSwkJ3vkm4RapaIJz7nZsIjZs3pGgZMG+qX8nZYFEV9gOz6kk67/tvUy4S2N8
         WDHYathVIaIXPfIBCdgkKFbyuKxAJliwrQkFRgMNf7bSS/CBI3xflzp27BtvkworzjfC
         TBrg==
X-Gm-Message-State: ACrzQf2v34E/JkL3XJqcxts+iFuY8bp05tuH2ikGtvjlM4JEpZnGIWB3
        pZoz/iVDhpKt0pk1Ve7xxnsheCoZtKpCKmJd/Jw=
X-Google-Smtp-Source: AMsMyM5jiBmDId/B+UJ8DI3FE8pVWS871TjurBrhdyda5R+5rIje5n8Grjt5ouCDW6IryWM/sHBGHU+H64Wm2SEWL58=
X-Received: by 2002:a9d:6848:0:b0:661:a608:cbc3 with SMTP id
 c8-20020a9d6848000000b00661a608cbc3mr4157875oto.206.1665531540410; Tue, 11
 Oct 2022 16:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-9-namhyung@kernel.org>
 <CAP-5=fX_sHxLAnj6CLSDv4w7yPrMmTQ8ZT0+36d6VjNkJqUChw@mail.gmail.com>
In-Reply-To: <CAP-5=fX_sHxLAnj6CLSDv4w7yPrMmTQ8ZT0+36d6VjNkJqUChw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Oct 2022 16:38:49 -0700
Message-ID: <CAM9d7cjed=JxNMruxqnp=E36wiHLz6-GcybdewPm1PbKpWJNnA@mail.gmail.com>
Subject: Re: [PATCH 08/19] perf stat: Allocate evsel->stats->aggr properly
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

On Mon, Oct 10, 2022 at 4:03 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The perf_stat_config.aggr_map should have a correct size of the
> > aggregation map.  Use it to allocate aggr_counts.
> >
> > Also AGGR_NONE with per-core events can be tricky because it doesn't
> > aggreate basically but it needs to do so for per-core events only.
>
> nit: s/aggreate/aggregate/
>
> > So only per-core evsels will have stats->aggr data.
> >
> > Note that other caller of evlist__alloc_stat() might not have
> > stat_config or aggr_map.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Ian Rogers <irogers@google.com>
>
> nit: Below there are use of constants true, false and NULL, it would
> be nice to use the /*argument_name=*/... style parameter passing to be
> clearer on what the parameter means.

Sounds good.  Will add.

Thanks,
Namhyung
