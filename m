Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0966FE71E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjEJWUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbjEJWT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B36198
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683757147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXstG2DXAO8SmuKQ+JlWAUi+NkitF2zkwGirgCaNmDY=;
        b=d3ktLLJVNKqDg57TcdW5PIaAhEuR11GBS5fqqawOrKeRG8AIWXpdFhATdT8qs4m5DPfjfl
        dtOdtndsJx1FVdIYbQ2akw2R8yONHEdT/E4RaU7+DWj3+9BvYW5gUZidFki/TRDdU82pLz
        ikNHQB30r7SjOI/wVHBo5lsG7LVZc7o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-Jz2OyHzBO8eYUrcva6Y3Yw-1; Wed, 10 May 2023 18:19:06 -0400
X-MC-Unique: Jz2OyHzBO8eYUrcva6Y3Yw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f38fe55146so26522551cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 15:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683757146; x=1686349146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXstG2DXAO8SmuKQ+JlWAUi+NkitF2zkwGirgCaNmDY=;
        b=ZowRAOhu/6C0hlDdbYHIYzWI5oqU+WZW5I9sP4/JeVpA42Tb76gZ0XnphPT+97++RN
         lRNR9BWdtRFIojxCjlKyfs/A/nykZDpjzKEm0FvAXlH5H+0Za6s4P27xNZ24v5h3q1Vy
         dhzzF45jxLb+oLTlqGMJGwS2h9p6y5db2xWEn+4Xv9OPsWtdyzsb4LkDy5bzhVouvt+Q
         DFRjo1sRShbUgu6usXMBUPNOWMJLTZ1upu+qZWQuEtS2odPVIXfxAsEM60lRRSzeQLVy
         6VoelPH1IjFoZj34KPDHzK83AFSjf7obBJJURaVhX9Rt7MHTsw/oHLingHZJrOjlquMc
         VqpQ==
X-Gm-Message-State: AC+VfDyEqjvokXLThM8ndRtPgNms8r4rlZ9xSwfEAoWRRbRdStJI13Gn
        3cmB0z0+zOyz2XxL/SlQWn6yqEUWsL7HlX33ouo+SPprQTJE25nLJMl/rVF7kq1yxLmXJg2afG2
        YskgQOVtJTV/L0GvRcQbnlpR0zTlfjlCgPJItY+Hx
X-Received: by 2002:a05:622a:10:b0:3e4:26de:162d with SMTP id x16-20020a05622a001000b003e426de162dmr28909916qtw.16.1683757145952;
        Wed, 10 May 2023 15:19:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7S3bOB2/QS98YME9mttkGLB3+SSYhwyT6pt2iI/4giIM9uw4pbPNGSDHUbZ52U1iUaBz08iIa/ctv02GdGHzo=
X-Received: by 2002:a05:622a:10:b0:3e4:26de:162d with SMTP id
 x16-20020a05622a001000b003e426de162dmr28909882qtw.16.1683757145578; Wed, 10
 May 2023 15:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230406075718.68672-1-leobras@redhat.com> <20230406095519.GG386572@hirez.programming.kicks-ass.net>
 <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
 <20230503145900.GC1689514@hirez.programming.kicks-ass.net>
 <xhsmh7ctojoia.mognet@vschneid.remote.csb> <f96442e9166e4f73be772656a93c89093eddbb8b.camel@redhat.com>
In-Reply-To: <f96442e9166e4f73be772656a93c89093eddbb8b.camel@redhat.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 10 May 2023 19:18:54 -0300
Message-ID: <CAJ6HWG4PP=yUBw6Vp8--E3__hwuHqJ8uUJ2j+oWfHr7sQsXoJw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with smp_call_function*()
To:     Valentin Schneider <vschneid@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 5:27=E2=80=AFPM Leonardo Br=C3=A1s <leobras@redhat.=
com> wrote:
>
> On Thu, 2023-05-04 at 12:59 +0100, Valentin Schneider wrote:
> > +Daniel
> >
> > On 03/05/23 16:59, Peter Zijlstra wrote:
> > > On Wed, Apr 19, 2023 at 12:45:08AM -0300, Leonardo Br=C3=A1s wrote:
> > > >
> > > > IIUC the last commits add tracepoints that are collected in the
> > > > requesting CPU, at the moment of scheduling the IPI, which are also=
 useful in
> > > > some scenarios.
> > > >
> > > > On my scenario, it could help a little, since it makes possible to =
filter what
> > > > all other cpus are scheduling on the requested cpu. OTOH it could b=
e also be
> > > > misleading, as the requested cpu could be running something that wa=
s scheduled
> > > > way before.
> > > >
> > > > The change I propose does exactly what my scenario need: track exac=
tly which
> > > > function was running at given time in the requested CPU. With this =
info, we can
> > > > check which (if any) remotely requested function was running on giv=
en time
> > > > window.
> > >
> > > I was thinking you could simply (graph)-trace
> > > __flush_smp_call_function_queue() with a max_graph_depth or so (Steve
> > > says that ought to work).
> > >
> > > But even that might be too specific, your use case sounds more like w=
hat
> > > we have the irq-off latency tracer for, and that thing will immediate=
ly
> > > tell you what functions were being ran.
> > >
> > > > (An unrelated thing I just thought: We could even use the commits y=
ou pointed
> > > > together with my proposed change in order to measure how long does =
it take for a
> > > > requested function to run / complete in the requested cpu)
> > >
> > > I don't think you could actually do that; the send tracepoints Valent=
in
> > > added don't log the csd address, this means you cannot distinguish
> > > two CSDs with the same function send from different CPUs.
> > >
> > > To do this you'd need to add the csd address to the the ipi_send
> > > tracepoints and your own (possibly replacing info -- because I don't
> > > think that's too useful).
> > >
> > > Valentin -- is any of this something you'd also find useful?
> >
> > Conceptually yeah, however:
> >
> > With isolcpus + NOHZ_FULL, *any* IPI sent to an isolated CPU is game ov=
er,
> > you interrupt the userspace task and you eat the full meal that is
> > NOHZ_FULL kernel entry. Pretty much any such IPI will show up when
> > evaluating your setup with rteval/rlta/whatever, so having an event at
> > IPI reception is redundant.
> >
> > IIUC Leonardo's looking at a setup with isolcpus but not necessarily
> > NOHZ_FULL, so he wants to look at *which* IPIs (if any) are pushing the
> > isolated task over its deadline/period. I would argue any IPI received
> > there is at risk of doing that, so it's the same fight as with NOHZ_FUL=
L.
> >
> > With that said, I suppose this could still be helpful for e.g. osnoise =
to
> > hook into and point the finger at which CPU/context sent the problemati=
c
> > IPI. Or more generally, as Leonardo suggested, to measure CSD IPI deliv=
ery
> > times.
> >
> > One thing though is that trace_ipi_send_cpu*() is not used solely for
> > CSD's, cf. irq_work_raise() or smp_send_reschedule(). We might want to
> > split that into e.g. trace_csd_queue_cpu*() + trace_ipi_send*().
> >
> > Something like so...
> >
> > ---
> > diff --git a/include/trace/events/smp.h b/include/trace/events/smp.h
> > new file mode 100644
> > index 0000000000000..8fc725a2b45b9
> > --- /dev/null
> > +++ b/include/trace/events/smp.h
> > @@ -0,0 +1,69 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM smp
> > +
> > +#if !defined(_TRACE_SMP_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_SMP_H
> > +
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_EVENT(csd_queue_cpu,
> > +
> > +     TP_PROTO(const unsigned int cpu,
> > +              unsigned long callsite,
> > +              smp_call_func_t func,
> > +              call_single_data_t *csd),
> > +
> > +     TP_ARGS(cpu, callsite, func, csd),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(unsigned int, cpu)
> > +             __field(void *, callsite)
> > +             __field(void *, func)
> > +             __field(void *, csd)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->cpu =3D cpu;
> > +             __entry->callsite =3D (void *)callsite;
> > +             __entry->func =3D func;
> > +             __entry->csd  =3D csd;
> > +     ),
> > +
> > +     TP_printk("cpu=3D%u callsite=3D%pS func=3D%pS csd=3D%p",
> > +               __entry->cpu, __entry->callsite, __entry->func, __entry=
->csd)
> > +);
>
> This is for the caller side, right?
>
> > +
> > +DECLARE_EVENT_CLASS(csd_function,
> > +
> > +     TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> > +
> > +     TP_ARGS(func, csd),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(void *, func)
> > +             __field(void *, csd)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->func   =3D func;
> > +             __entry->csd    =3D csd;
> > +     ),
> > +
> > +     TP_printk("func=3D%pS csd=3D%p", __entry->func, __entry->csd)
> > +);
> > +
> > +DEFINE_EVENT(csd_function, csd_function_entry,
> > +     TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> > +     TP_ARGS(func, csd)
> > +);
> > +
> > +DEFINE_EVENT(csd_function, csd_function_exit,
> > +     TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> > +     TP_ARGS(func, csd)
> > +);
>
> Oh, this is what event_class is for. Thanks for the example :)
>
> > +
> > +#endif /* _TRACE_SMP_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index ab3e5dad6cfe9..7d28db303e9bc 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -27,6 +27,9 @@
> >  #include <linux/jump_label.h>
> >
> >  #include <trace/events/ipi.h>
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/smp.h>
> > +#undef CREATE_TRACE_POINTS
> >
> >  #include "smpboot.h"
> >  #include "sched/smp.h"
> > @@ -121,6 +124,14 @@ send_call_function_ipi_mask(struct cpumask *mask)
> >       arch_send_call_function_ipi_mask(mask);
> >  }
> >
> > +static __always_inline void
> > +csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd)
> > +{
> > +     trace_csd_function_entry(func, csd);
> > +     func(info);
> > +     trace_csd_function_exit(func, csd);
> > +}
> > +
>
> Good one, a helper to avoid calling those traces everywhere.
>
> Honest question:
> Since info =3D=3D csd->info and func =3D=3D csd->func, we could just pass=
 csd, right?
> I suppose the suggestion on the 3-argument version is to use the values a=
lready
> fetched from memory instead of fetching them again. Is that correct?
>
> >  #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> >
> >  static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, csd=
lock_debug_enabled);
> > @@ -329,7 +340,7 @@ void __smp_call_single_queue(int cpu, struct llist_=
node *node)
> >        * even if we haven't sent the smp_call IPI yet (e.g. the stopper
> >        * executes migration_cpu_stop() on the remote CPU).
> >        */
> > -     if (trace_ipi_send_cpu_enabled()) {
> > +     if (trace_csd_queue_cpu_enabled()) {
> >               call_single_data_t *csd;
> >               smp_call_func_t func;
> >
> > @@ -337,7 +348,7 @@ void __smp_call_single_queue(int cpu, struct llist_=
node *node)
> >               func =3D CSD_TYPE(csd) =3D=3D CSD_TYPE_TTWU ?
> >                       sched_ttwu_pending : csd->func;
> >
> > -             trace_ipi_send_cpu(cpu, _RET_IP_, func);
> > +             trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
> >       }
> >
> >       /*
> > @@ -375,7 +386,7 @@ static int generic_exec_single(int cpu, struct __ca=
ll_single_data *csd)
> >               csd_lock_record(csd);
> >               csd_unlock(csd);
> >               local_irq_save(flags);
> > -             func(info);
> > +             csd_do_func(func, info, NULL);
> >               csd_lock_record(NULL);
> >               local_irq_restore(flags);
> >               return 0;
> > @@ -477,7 +488,7 @@ static void __flush_smp_call_function_queue(bool wa=
rn_cpu_offline)
> >                       }
> >
> >                       csd_lock_record(csd);
> > -                     func(info);
> > +                     csd_do_func(func, info, csd);
> >                       csd_unlock(csd);
> >                       csd_lock_record(NULL);
> >               } else {
> > @@ -508,7 +519,7 @@ static void __flush_smp_call_function_queue(bool wa=
rn_cpu_offline)
> >
> >                               csd_lock_record(csd);
> >                               csd_unlock(csd);
> > -                             func(info);
> > +                             csd_do_func(func, info, csd);
> >                               csd_lock_record(NULL);
> >                       } else if (type =3D=3D CSD_TYPE_IRQ_WORK) {
> >                               irq_work_single(csd);
> > @@ -522,8 +533,10 @@ static void __flush_smp_call_function_queue(bool w=
arn_cpu_offline)
> >       /*
> >        * Third; only CSD_TYPE_TTWU is left, issue those.
> >        */
> > -     if (entry)
> > -             sched_ttwu_pending(entry);
> > +     if (entry) {
> > +             csd =3D llist_entry(entry, typeof(*csd), node.llist);
> > +             csd_do_func(sched_ttwu_pending, entry, csd);
> > +     }
> >  }
> >
> >
> > @@ -624,7 +637,7 @@ EXPORT_SYMBOL(smp_call_function_single);
> >
> >  /**
> >   * smp_call_function_single_async() - Run an asynchronous function on =
a
> > - *                            specific CPU.
> > + *                            specific CPU.
> >   * @cpu: The CPU to run on.
> >   * @csd: Pre-allocated and setup data structure
> >   *
> > @@ -728,7 +741,7 @@ static void smp_call_function_many_cond(const struc=
t cpumask *mask,
> >       int cpu, last_cpu, this_cpu =3D smp_processor_id();
> >       struct call_function_data *cfd;
> >       bool wait =3D scf_flags & SCF_WAIT;
> > -     int nr_cpus =3D 0, nr_queued =3D 0;
> > +     int nr_cpus =3D 0;
> >       bool run_remote =3D false;
> >       bool run_local =3D false;
> >
> > @@ -786,21 +799,16 @@ static void smp_call_function_many_cond(const str=
uct cpumask *mask,
> >                       csd->node.src =3D smp_processor_id();
> >                       csd->node.dst =3D cpu;
> >  #endif
> > +
> > +                     trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
> > +
> >                       if (llist_add(&csd->node.llist, &per_cpu(call_sin=
gle_queue, cpu))) {
> >                               __cpumask_set_cpu(cpu, cfd->cpumask_ipi);
> >                               nr_cpus++;
> >                               last_cpu =3D cpu;
> >                       }
> > -                     nr_queued++;
> >               }
> >
> > -             /*
> > -              * Trace each smp_function_call_*() as an IPI, actual IPI=
s
> > -              * will be traced with func=3D=3Dgeneric_smp_call_functio=
n_single_ipi().
> > -              */
> > -             if (nr_queued)
> > -                     trace_ipi_send_cpumask(cfd->cpumask, _RET_IP_, fu=
nc);
> > -
> >               /*
> >                * Choose the most efficient way to send an IPI. Note tha=
t the
> >                * number of CPUs might be zero due to concurrent changes=
 to the
> > @@ -816,7 +824,7 @@ static void smp_call_function_many_cond(const struc=
t cpumask *mask,
> >               unsigned long flags;
> >
> >               local_irq_save(flags);
> > -             func(info);
> > +             csd_do_func(func, info, NULL);
> >               local_irq_restore(flags);
> >       }
> >
> >
>
> I will rebase my patch on top of tip/smp/core and apply the suggested cha=
nges.
> A v2 will be send shortly.

RFC-v2 sent:
https://lore.kernel.org/lkml/20230510221513.93297-1-leobras@redhat.com/

>
> Thank you all for reviewing!
> Leo
>
>

