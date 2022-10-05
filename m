Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EB85F5074
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJEHuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiJEHuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:50:17 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7CA13CF1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 00:50:11 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3560e81aa1dso133861577b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UzQmyinUVh0gYIU7G22SjWrGZvbDKlQeEbxckrHhAUQ=;
        b=PxghZPSauK8r+1xS1tKNR2vcd36ecPbCBUeTs+qEqDQ7d+0dp/g7+b8NDjaF4Slgzo
         jfqYUglaaXvnzUuGxVykK0PseshahovDJT4gRNEvmu3pM9qPgu09KA1pvz3x0aqeukTV
         nDdSuCk3xqN797FyXPfwIBztdqpiluv5HIZJtTfuXEPTNNoUHmbFdV5llqdUN9XEzBis
         csSyMQHrc3ZZF8WSQsM9QEWZIYDx7S86wcyQHosIEUh+CFmiEqwQbCC1LgLbkc1z9uw0
         SLZGC613Ug6DcHwGTwGtzUFhYuCSVQjirxRZnjG4bhIn04Y1cFGTmvyIUKLchHlY5teC
         eyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UzQmyinUVh0gYIU7G22SjWrGZvbDKlQeEbxckrHhAUQ=;
        b=H1XWJ7YNjiaeDjcpzSwszSrFLbWJWr0gIHjSlNiVuFPM/SQSz9hO6xEqltyuk4EVcZ
         1JujBnq1ytZIDBttiePLBzkX82FT3Qdk9Arrp42tBd5NEqB76bkQKSrWLmqT20VGSPqW
         Nqchuv59DcFoKmaGlBInmLZUDiYpborUeHvMV8XX7hXXI9rHbFyuTGVEIZ3Hgj55dRK0
         ODtlUjhfXpZhFHBzAkLayh7RIBPZsA7/9JrXGTz+RBHHq6GYaIwaZRAMGNdMumY+t9/m
         MrVAoFvvv8zzc+Gf9Fx+Tqkpwj3VERe1W2oeeLjIn4eGCgrbRU2Uvq5mFKElR7dwGBNN
         qYiA==
X-Gm-Message-State: ACrzQf2kNY3F8e1cnS7C2wL5/gaUjle/Gs+P4SRHtHEFMsg9Z+6pV8lP
        +yT8ZUyrFa21BiAkl7Zf1P7xhOoF7GLWqSv5JqyXJw==
X-Google-Smtp-Source: AMsMyM744h9xBfmmakOjhS+QI2GdcOswNAtz7t7Ml48tIv9py64/iXyI/SkTWufUK8FcqIktLVMNQWuwO5nLEXuHoNY=
X-Received: by 2002:a81:7787:0:b0:349:8bbe:64b with SMTP id
 s129-20020a817787000000b003498bbe064bmr29166335ywc.465.1664956211013; Wed, 05
 Oct 2022 00:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220927121322.1236730-1-elver@google.com> <YzM/BUsBnX18NoOG@hirez.programming.kicks-ass.net>
 <YzNu5bgASbuVi0S3@elver.google.com> <YzQcqe9p9C5ZbjZ1@elver.google.com>
 <YzRgcnMXWuUZ4rlt@elver.google.com> <Yzxou9HB/1XjMXWI@hirez.programming.kicks-ass.net>
 <CANpmjNPwiL279B5id5dPF821aXYdTUqsfDNAtB4q7jXX+41Qgg@mail.gmail.com> <Yz00IjTZjlsKlNvy@hirez.programming.kicks-ass.net>
In-Reply-To: <Yz00IjTZjlsKlNvy@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 Oct 2022 09:49:34 +0200
Message-ID: <CANpmjNNWWBs97tXzjnzR8NitN9L6WH=yjbpQRVKWKS7t=0wAww@mail.gmail.com>
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

On Wed, 5 Oct 2022 at 09:37, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 04, 2022 at 07:33:55PM +0200, Marco Elver wrote:
> > It looks reasonable, but obviously needs to pass tests. :-)
>
> Ikr :-)
>
> > Also, see comment below (I think you're still turning signals
> > asynchronous, which we shouldn't do).
>
> Indeed so; I tried fixing that this morning, but so far that doesn't
> seem to want to actually cure things :/ I'll need to stomp on this
> harder.
>
> Current hackery below. The main difference is that instead of trying to
> restart the irq_work on sched_in, sched_out will now queue a task-work.
>
> The event scheduling is done from 'regular' IRQ context and as such
> there should be a return-to-userspace for the relevant task in the
> immediate future (either directly or after scheduling).

Does this work if we get a __perf_event_enable() IPI as described in
the commit message of the patch I sent? I.e. it does a sched-out
immediately followed by a sched-in aka resched; presumably in that
case it should still have the irq_work on the same CPU, but the
task_work will be a noop?

> Alas, something still isn't right...
>
> ---
>  include/linux/perf_event.h |   9 ++--
>  kernel/events/core.c       | 115 ++++++++++++++++++++++++++++-----------------
>  2 files changed, 79 insertions(+), 45 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 853f64b6c8c2..f15726a6c127 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -756,11 +756,14 @@ struct perf_event {
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
> +       struct callback_head            pending_sig;
>
>         atomic_t                        event_limit;
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b981b879bcd8..e28257fb6f00 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -54,6 +54,7 @@
>  #include <linux/highmem.h>
>  #include <linux/pgtable.h>
>  #include <linux/buildid.h>
> +#include <linux/task_work.h>
>
>  #include "internal.h"
>
> @@ -2276,11 +2277,19 @@ event_sched_out(struct perf_event *event,
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
> +       if (event->pending_sigtrap) {
> +               if (state != PERF_EVENT_STATE_OFF)
> +                       task_work_add(current, &event->pending_sig, TWA_NONE);
> +               else
> +                       event->pending_sigtrap = 0;
> +       }
> +
>         perf_event_set_state(event, state);
>
>         if (!is_software_event(event))
> @@ -2471,8 +2480,7 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
>
>  void perf_event_disable_inatomic(struct perf_event *event)
>  {
> -       WRITE_ONCE(event->pending_disable, smp_processor_id());
> -       /* can fail, see perf_pending_event_disable() */
> +       event->pending_disable = 1;
>         irq_work_queue(&event->pending);
>  }
>
> @@ -6448,47 +6456,40 @@ static void perf_sigtrap(struct perf_event *event)
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

This probably should not queue an irq_work if pending_sigtrap, given
it just doesn't work. It probably should just ignore?

Thanks,
-- Marco
