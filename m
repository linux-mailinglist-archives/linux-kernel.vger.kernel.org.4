Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53255731F10
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjFORbU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jun 2023 13:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFORbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:31:18 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23373171F;
        Thu, 15 Jun 2023 10:31:17 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6b16cbe4fb6so6067836a34.1;
        Thu, 15 Jun 2023 10:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850276; x=1689442276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tItqY0dLT7TE8im26b0AHj5uhyTsY6RLngxAlIoi5Io=;
        b=FKqtlB7iaoezDM4eXNRhcdkz4vy7XaWoD+shxsx+Zyy42XB80BG0IG3wSAOZ9/cC/0
         LbyeLhJ1NlGpwtqWh8IBG+jyiRV4RbLjMPwBn78zoUj22ZDB8p8mxoujETYOIdyjVZVZ
         R2KeQ8m0e0Qi1+KGvbaFLi/C8T/aFOIC5M5LkYJPDYKuqXY32mNaBmOYCUdYhGcNfqfI
         wgWJuAV22ZHIIgWrJ/Z9NLtIAlWR/mOox5gDSpdZMuCE83X5fyLCz4HDNklquR0hM82o
         kVft/ioXZTVffgXzktf08dE3RPEBIZ4gy/7mV0hMEdDHTSYYOsy/dHsuISBJEJ4fRwFr
         efDA==
X-Gm-Message-State: AC+VfDwNmNAFFNb58qAnVRIwUQXygwohisqWmKQ746lQ1R9lQFQfRY8g
        Qic9eDadGkT9BbVFmMINX2TlaW36kVD7w4qOZ7E=
X-Google-Smtp-Source: ACHHUZ6ShpSYG3v8Ep3CgtDGJWuhuSZDBmu0TnnSbDh/hc9sadwXl7icovf5mJmUPrJOkJPHcsRUYWSdnm6md2IKXAU=
X-Received: by 2002:a05:6358:cd1e:b0:129:c3fc:691e with SMTP id
 gv30-20020a056358cd1e00b00129c3fc691emr12759284rwb.14.1686850276228; Thu, 15
 Jun 2023 10:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221018020227.85905-1-namhyung@kernel.org> <20221018020227.85905-19-namhyung@kernel.org>
 <ZInDSgrOzYSX124p@krava> <CAP-5=fX2ULvR7KFCwZN4wn1LSQmtJqQk7bK=T=BHdvnHuL=DdA@mail.gmail.com>
 <ZIrHatpIlo3Y2ZPQ@krava>
In-Reply-To: <ZIrHatpIlo3Y2ZPQ@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 15 Jun 2023 10:31:04 -0700
Message-ID: <CAM9d7ciT77ZJNuSnHZFg1XrjtTFoDg1TYn4PByaHtbz2e3OO5g@mail.gmail.com>
Subject: Re: [PATCH 18/20] perf stat: Display event stats using aggr counts
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Jun 15, 2023 at 1:10 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Jun 14, 2023 at 09:20:53AM -0700, Ian Rogers wrote:
> > On Wed, Jun 14, 2023 at 6:40 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Mon, Oct 17, 2022 at 07:02:25PM -0700, Namhyung Kim wrote:
> > > > Now aggr counts are ready for use.  Convert the display routines to use
> > > > the aggr counts and update the shadow stat with them.  It doesn't need
> > > > to aggregate counts or collect aliases anymore during the display.  Get
> > > > rid of now unused struct perf_aggr_thread_value.
> > > >
> > > > Note that there's a difference in the display order among the aggr mode.
> > > > For per-core/die/socket/node aggregation, it shows relevant events in
> > > > the same unit together, whereas global/thread/no aggregation it shows
> > > > the same events for different units together.  So it still uses separate
> > > > codes to display them due to the ordering.
> > > >
> > > > One more thing to note is that it breaks per-core event display for now.
> > > > The next patch will fix it to have identical output as of now.
> > > >
> > > > Acked-by: Ian Rogers <irogers@google.com>
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > > hi,
> > > this one seems to break 'perf stat -r X' not sure why so far..
> > >
> > > final counts seems to be accumulated instead of displaying average, like:
> > >
> > >
> > > with this patch:
> > >
> > >          Performance counter stats for './test_progs -n 103/1' (2 runs):
> > >
> > >                206,815,929      cycles:u                                                             ( +-  0.05% )
> > >             16,052,747,533      cycles:k                                                             ( +-  0.10% )
> > >             16,259,643,167      cycles                                                               ( +-  0.10% )
> > >
> > >                    1.98093 +- 0.00586 seconds time elapsed  ( +-  0.30% )
> > >
> > >
> > > without this patch:
> > >
> > >          Performance counter stats for './test_progs -n 103/1' (2 runs):
> > >
> > >                103,300,812      cycles:u                                                             ( +-  0.37% )
> > >              8,016,856,866      cycles:k                                                             ( +-  0.32% )
> > >              8,120,200,572      cycles                                                               ( +-  0.32% )
> > >
> > >                    1.97272 +- 0.00270 seconds time elapsed  ( +-  0.14% )
> > >
> > >
> > > any idea? ;-)
> >
> > Is this still broken in perf-tools-next? The patch is quite old and
> > there's been work in this area. I'm assuming yes, but thought it was
> > worth checking.
>
> yes

I'll take a look.
