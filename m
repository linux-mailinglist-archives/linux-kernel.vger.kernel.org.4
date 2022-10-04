Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6BC5F4897
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJDRf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJDRek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:40 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4E46746D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:34:32 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-345528ceb87so142131747b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uB+xgYQO/9hSmh+whT13wcnQWr/VgecN0kcqIDAF7KU=;
        b=Ymg9ZZ0rCYV004hey+X5aunoJoXTYWqOvGNKWxWo5DRhFGqJUg9aUXCzdJG7oM0nK5
         x1flcyWuH7k1XXAK97h8X2z/zA95xE8LK1zwD8b1gdQhEWAiyuPUBVhi6gISkcpgb0IZ
         E+b3Bs8+19zioI4NXvSzRdEQvSVuBRuWGVbNr7X/Vt9tRwrp65pPvrK2FSrfXX57I6qA
         s0a8NVaBewxbts/ybeZK11cjIDivdxB18zAQPXNX7mCeUqYnSGqNO8t5XZYTAaiMc/J/
         BKrbs2rnkUvi9KGIzxgl9UpM6IqsLz9EGhuxtCx5wMIoqr0txEY0tqMaFlmloS9hBuGe
         dsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uB+xgYQO/9hSmh+whT13wcnQWr/VgecN0kcqIDAF7KU=;
        b=Qu9DMLiuLnt71or84h/zcxKirBdjvyB3rhmQeBFm6BiVVJNA8D1iT6k2HtIrgBxDG4
         Wc1uj2rbG7zJ5jtYh6BFwcRAyRnks2XroQEhzB6yZB0d3nPBqXVW6KeNygBk8l2ETqns
         9fJiuqsPR0fEME4jxUf23kH/QVohezJEkmkyndqjBqU53G33UTGeFO8X/TEg779WIQjc
         E/U74xiPfH4TFIDNzD3qL9rdiDXRDYjOljSnVODiGEz0J++rAi8EicPHRTxUTIb6yUPY
         cVVz6eICT64p7jhdexW6YS7TN0dKFOZJBNFWwC9FyIz9aV0MGVrB+f89NUA/RQgMBLXZ
         JFGQ==
X-Gm-Message-State: ACrzQf1NKN1GPBHvtvzxbMwxD3yX4yfX92R+D6ByQ95BYWYZSR98ZY+n
        H0/2Fy7RLcZnBzfhF+UxOTKSlA+lctWN3VCQi9NIBA==
X-Google-Smtp-Source: AMsMyM5cQoPLva6xEYl1WBGOv5wxv8efRmpjaJLhMkW737wvZJYkDmrHkr+gKzfeU4pE55muGoMdbmSytcAvqax2XNg=
X-Received: by 2002:a81:6dc5:0:b0:358:6a18:b73d with SMTP id
 i188-20020a816dc5000000b003586a18b73dmr14847990ywc.267.1664904871847; Tue, 04
 Oct 2022 10:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220927121322.1236730-1-elver@google.com> <YzM/BUsBnX18NoOG@hirez.programming.kicks-ass.net>
 <YzNu5bgASbuVi0S3@elver.google.com> <YzQcqe9p9C5ZbjZ1@elver.google.com>
 <YzRgcnMXWuUZ4rlt@elver.google.com> <Yzxou9HB/1XjMXWI@hirez.programming.kicks-ass.net>
In-Reply-To: <Yzxou9HB/1XjMXWI@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 4 Oct 2022 19:33:55 +0200
Message-ID: <CANpmjNPwiL279B5id5dPF821aXYdTUqsfDNAtB4q7jXX+41Qgg@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs due to pending_disable abuse
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2022 at 19:09, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Sep 28, 2022 at 04:55:46PM +0200, Marco Elver wrote:
> > On Wed, Sep 28, 2022 at 12:06PM +0200, Marco Elver wrote:
> >
> > > My second idea about introducing something like irq_work_raw_sync().
> > > Maybe it's not that crazy if it is actually safe. I expect this case
> > > where we need the irq_work_raw_sync() to be very very rare.
> >
> > The previous irq_work_raw_sync() forgot about irq_work_queue_on(). Alas,
> > I might still be missing something obvious, because "it's never that
> > easy". ;-)
> >
> > And for completeness, the full perf patch of what it would look like
> > together with irq_work_raw_sync() (consider it v1.5). It's already
> > survived some shorter stress tests and fuzzing.
>
> So.... I don't like it. But I cooked up the below, which _almost_ works :-/
>
> For some raisin it sometimes fails with 14999 out of 15000 events
> delivered and I've not yet figured out where it goes sideways. I'm
> currently thinking it's that sigtrap clear on OFF.
>
> Still, what do you think of the approach?

It looks reasonable, but obviously needs to pass tests. :-)
Also, see comment below (I think you're still turning signals
asynchronous, which we shouldn't do).

> ---
>  include/linux/perf_event.h |  8 ++--
>  kernel/events/core.c       | 92 +++++++++++++++++++++++++---------------------
>  2 files changed, 55 insertions(+), 45 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index ee8b9ecdc03b..c54161719d37 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -736,9 +736,11 @@ struct perf_event {
>         struct fasync_struct            *fasync;
>
>         /* delayed work for NMIs and such */
> -       int                             pending_wakeup;
> -       int                             pending_kill;
> -       int                             pending_disable;
> +       unsigned int                    pending_wakeup  :1;
> +       unsigned int                    pending_disable :1;
> +       unsigned int                    pending_sigtrap :1;
> +       unsigned int                    pending_kill    :3;
> +
>         unsigned long                   pending_addr;   /* SIGTRAP */
>         struct irq_work                 pending;
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2621fd24ad26..8e5dbe971d9e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2268,11 +2268,15 @@ event_sched_out(struct perf_event *event,
>         event->pmu->del(event, 0);
>         event->oncpu = -1;
>
> -       if (READ_ONCE(event->pending_disable) >= 0) {
> -               WRITE_ONCE(event->pending_disable, -1);
> +       if (event->pending_disable) {
> +               event->pending_disable = 0;
>                 perf_cgroup_event_disable(event, ctx);
>                 state = PERF_EVENT_STATE_OFF;
>         }
> +
> +       if (event->pending_sigtrap && state == PERF_EVENT_STATE_OFF)
> +               event->pending_sigtrap = 0;
> +
>         perf_event_set_state(event, state);
>
>         if (!is_software_event(event))
> @@ -2463,8 +2467,7 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
>
>  void perf_event_disable_inatomic(struct perf_event *event)
>  {
> -       WRITE_ONCE(event->pending_disable, smp_processor_id());
> -       /* can fail, see perf_pending_event_disable() */
> +       event->pending_disable = 1;
>         irq_work_queue(&event->pending);
>  }
>
> @@ -2527,6 +2530,9 @@ event_sched_in(struct perf_event *event,
>         if (event->attr.exclusive)
>                 cpuctx->exclusive = 1;
>
> +       if (event->pending_disable || event->pending_sigtrap)
> +               irq_work_queue(&event->pending);
> +
>  out:
>         perf_pmu_enable(event->pmu);
>
> @@ -6440,47 +6446,40 @@ static void perf_sigtrap(struct perf_event *event)
>                       event->attr.type, event->attr.sig_data);
>  }
>
> -static void perf_pending_event_disable(struct perf_event *event)
> +/*
> + * Deliver the pending work in-event-context or follow the context.
> + */
> +static void __perf_pending_event(struct perf_event *event)
>  {
> -       int cpu = READ_ONCE(event->pending_disable);
> +       int cpu = READ_ONCE(event->oncpu);
>
> +       /*
> +        * If the event isn't running; we done. event_sched_in() will restart
> +        * the irq_work when needed.
> +        */
>         if (cpu < 0)
>                 return;
>
> +       /*
> +        * Yay, we hit home and are in the context of the event.
> +        */
>         if (cpu == smp_processor_id()) {
> -               WRITE_ONCE(event->pending_disable, -1);
> -
> -               if (event->attr.sigtrap) {
> +               if (event->pending_sigtrap) {
> +                       event->pending_sigtrap = 0;
>                         perf_sigtrap(event);
> -                       atomic_set_release(&event->event_limit, 1); /* rearm event */
> -                       return;
>                 }
> -
> -               perf_event_disable_local(event);
> -               return;
> +               if (event->pending_disable) {
> +                       event->pending_disable = 0;
> +                       perf_event_disable_local(event);
> +               }
>         }
>
>         /*
> -        *  CPU-A                       CPU-B
> -        *
> -        *  perf_event_disable_inatomic()
> -        *    @pending_disable = CPU-A;
> -        *    irq_work_queue();
> -        *
> -        *  sched-out
> -        *    @pending_disable = -1;
> -        *
> -        *                              sched-in
> -        *                              perf_event_disable_inatomic()
> -        *                                @pending_disable = CPU-B;
> -        *                                irq_work_queue(); // FAILS
> -        *
> -        *  irq_work_run()
> -        *    perf_pending_event()
> -        *
> -        * But the event runs on CPU-B and wants disabling there.
> +        * Requeue if there's still any pending work left, make sure to follow
> +        * where the event went.
>          */
> -       irq_work_queue_on(&event->pending, cpu);
> +       if (event->pending_disable || event->pending_sigtrap)
> +               irq_work_queue_on(&event->pending, cpu);

I considered making the irq_work "chase" the right CPU but it doesn't
work for sigtrap. This will make the signal asynchronous (it should be
synchronous), and the reason why I had to do irq_work_raw_sync().

Thanks,
-- Marco
