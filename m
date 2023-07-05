Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3390374878A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjGEPMI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jul 2023 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjGEPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:12:07 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F50E59;
        Wed,  5 Jul 2023 08:12:06 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-c5e76dfcc36so1807487276.2;
        Wed, 05 Jul 2023 08:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569925; x=1691161925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62I6/PnQSulzyBx7w8Sw+H+PkZ97zLVznFWaYHXFZXA=;
        b=KMOHA+88qszW2ryr5O1Bu8mJ0XcRxbXvJhZDK7DHAceH0Cn0U3EPhcZA+kD00Fa29T
         EmWDErzwIsE34uqTX+Hct81uQVFJAyUXclfhGB5Gv7SCjKh/K7hkkmDkj7DFcUS6akhP
         D5pJjpgU7XFvNwrvMqGLmy5bcAgVsSpvA8GE8IyXmWgIqEWrotSB2dm9eKAUj9rwWxIY
         qSuAHiHf/iK1TOXXzHtns5IX8aFM1BVu9g6tGDSicwwTYklmC685s5EYDUtymN447imj
         SieDDDYQK4sTwKMxxVZBCwH868Fc1sSIVa84+M22XvPtE/dkCumhp96/NdkoO0n+YFhV
         JSsQ==
X-Gm-Message-State: ABy/qLZI6ptVybSgKthuwYJbwFRvHgsMBNoEk7Vx3dbQzWpZTftFBlDt
        rEg+LOOS9IPvDiaGd1kYmgOGDzU8v+f6Kn2Pu74=
X-Google-Smtp-Source: APBJJlHswFByTmusWUdM/l0SjUG7DWJilC1GMRQzVWrmauq5TtLMci6+AJiQbVmfFvmWRcbLqtyYe2vByKNC4bXUi9U=
X-Received: by 2002:a25:154:0:b0:c62:9810:db26 with SMTP id
 81-20020a250154000000b00c629810db26mr1976858ybb.26.1688569924873; Wed, 05 Jul
 2023 08:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230704181516.3293665-1-namhyung@kernel.org> <20230705083833.GE462772@hirez.programming.kicks-ass.net>
In-Reply-To: <20230705083833.GE462772@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 Jul 2023 08:11:53 -0700
Message-ID: <CAM9d7cidyAD67Qr_bVW4EEm0+_87qv8O0JVmO9dmr6La9PRLSQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86: Fix lockdep warning in for_each_sibling_event()
 on SPR
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
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

Hi Peter,

On Wed, Jul 5, 2023 at 1:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 04, 2023 at 11:15:15AM -0700, Namhyung Kim wrote:
> > On SPR, the load latency event needs an auxiliary event in the same
> > group to work properly.  There's a check in intel_pmu_hw_config()
> > for this to iterate sibling events and find a mem-loads-aux event.
> >
> > The for_each_sibling_event() has a lockdep assert to make sure if it
> > disabled hardirq or hold leader->ctx->mutex.  This works well if the
> > given event has a separate leader event since perf_try_init_event()
> > grabs the leader->ctx->mutex to protect the sibling list.  But it can
> > cause a problem when the event itself is a leader since the event is
> > not initialized yet and there's no ctx for the event.
> >
> > Actually I got a lockdep warning when I run the below command on SPR,
> > but I guess it could be a NULL pointer dereference.
> >
> >   $ perf record -d -e cpu/mem-loads/uP true
> >
> > The code path to the warning is:
> >
> >   sys_perf_event_open()
> >     perf_event_alloc()
> >       perf_init_event()
> >         perf_try_init_event()
> >           x86_pmu_event_init()
> >             hsw_hw_config()
> >               intel_pmu_hw_config()
> >                 for_each_sibling_event()
> >                   lockdep_assert_event_ctx()
> >
> > We don't need for_each_sibling_event() when it's a standalone event.
> > Let's return the error code directly.
> >
> > Fixes: f3c0eba28704 ("perf: Add a few assertions")
> > Reported-by: Greg Thelen <gthelen@google.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  arch/x86/events/intel/core.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index 0d09245aa8df..933fe4894c32 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -3983,6 +3983,14 @@ static int intel_pmu_hw_config(struct perf_event *event)
> >               struct perf_event *leader = event->group_leader;
> >               struct perf_event *sibling = NULL;
> >
> > +             /*
> > +              * The event is not fully initialized yet and no ctx is set
> > +              * for the event.  Avoid for_each_sibling_event() since it
> > +              * has a lockdep assert with leader->ctx->mutex.
> > +              */
>
> If I understand things correctly, your patch is indeed correct, however
> I don't much like this comment, does something like:
>
>                 /*
>                  * When this memload event is also the first event (no
>                  * group exists yet), then there is no aux event before
>                  * it.
>                  */
>
> work for you?

Yep, looks good.  Do you want me to resend?

Thanks,
Namhyung


>
> > +             if (leader == event)
> > +                     return -ENODATA;
> > +
> >               if (!is_mem_loads_aux_event(leader)) {
> >                       for_each_sibling_event(sibling, leader) {
> >                               if (is_mem_loads_aux_event(sibling))
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
