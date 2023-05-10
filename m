Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37866FE7EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbjEJXGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbjEJXGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F347685
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683759930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LnHObFtk7TiZepY8Oa0TD9vr5C9onvQJcg+O+VlDJM4=;
        b=P64THDLwRk4+WxImZn21YqdTh3rApACcRmBF8eNwgCbba2/CqHA8hwvGVz0DDiXqMDMrX2
        iIRbSf4medgpdkFrVHB17siigYCg5SMTC/U5CQVHSjSAXoLobh7VIdOusTS7NqblLwFpGh
        KxmlCSGEiIRjG0dsSgjuLNiwVv7JcZc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-OeXBU66QPeCFXN-um6rX_Q-1; Wed, 10 May 2023 19:05:28 -0400
X-MC-Unique: OeXBU66QPeCFXN-um6rX_Q-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ef5c322d53so44488031cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683759928; x=1686351928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnHObFtk7TiZepY8Oa0TD9vr5C9onvQJcg+O+VlDJM4=;
        b=FVsA9Xfcfn5yZy6NFT2crNdhNwgWp+P34+NeftX7Ukv8i/cQgX+14bSVFKycJTlNGX
         z/KgkBpj4ri8Rl3rDECMfwkJFsdVZ9t2omS612bZAiPH6ZvpVSQ8zqfS4lZeSWg4969c
         a5MjRFP1RuyNophg5MqWfo+PSWQB5NR7Ijgl08nyNTukkxpX1JNATlSgI5KA8qxvR9MG
         Y5LwmELbWmbR1pPAX3B2SK1lN93qqKnm2NBHiVUtG1BMGvhOPs/d0Xz5PlXgsReWR9DQ
         mgYfzeQ0oBhp6qdZe5ZpkTJiC6MP+WfIpUfrl5JR2xkpoocbDEyYJsaNRkwRe00fxCxD
         +g0w==
X-Gm-Message-State: AC+VfDzbwVzsYKIc/XLalf/rMkp32EGJknUXI+ss7G2gYhiiqa9j1aZh
        Y4zZTK1DD2vLdTNg9UHriiS8ORMMG+EhJtJBQFFGmg3XxOX0EFg7p1FVGPek5ACVmTxC/UgXvUW
        hfBI3GM0td6D569ntTmriNiw/dgQFwrhfEg9ASVq2
X-Received: by 2002:a05:622a:4:b0:3bd:1a8a:8015 with SMTP id x4-20020a05622a000400b003bd1a8a8015mr28520172qtw.16.1683759928340;
        Wed, 10 May 2023 16:05:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66xEy8IIVXfXG7mbio5fnSGVgIdeSNr5x/ULr6MA3CBW0ul0AYWaUsAYJU83egyzA+DWy0UWR/iYOB7f7Pb/g=
X-Received: by 2002:a05:622a:4:b0:3bd:1a8a:8015 with SMTP id
 x4-20020a05622a000400b003bd1a8a8015mr28520134qtw.16.1683759928053; Wed, 10
 May 2023 16:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230406075718.68672-1-leobras@redhat.com> <20230406095519.GG386572@hirez.programming.kicks-ass.net>
 <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
 <20230503145900.GC1689514@hirez.programming.kicks-ass.net>
 <xhsmh7ctojoia.mognet@vschneid.remote.csb> <f96442e9166e4f73be772656a93c89093eddbb8b.camel@redhat.com>
 <CAJ6HWG4PP=yUBw6Vp8--E3__hwuHqJ8uUJ2j+oWfHr7sQsXoJw@mail.gmail.com>
In-Reply-To: <CAJ6HWG4PP=yUBw6Vp8--E3__hwuHqJ8uUJ2j+oWfHr7sQsXoJw@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 10 May 2023 20:05:17 -0300
Message-ID: <CAJ6HWG7yBu37sYOwyBSq7kOKwbtACJAc1vosVJaV7Sq2sEwjCw@mail.gmail.com>
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

On Wed, May 10, 2023 at 7:18=E2=80=AFPM Leonardo Bras Soares Passos
<leobras@redhat.com> wrote:
>
> On Wed, May 10, 2023 at 5:27=E2=80=AFPM Leonardo Br=C3=A1s <leobras@redha=
t.com> wrote:
> >
> > On Thu, 2023-05-04 at 12:59 +0100, Valentin Schneider wrote:
> > > +Daniel
> > >
> > > On 03/05/23 16:59, Peter Zijlstra wrote:
> > > > On Wed, Apr 19, 2023 at 12:45:08AM -0300, Leonardo Br=C3=A1s wrote:
> > > > >
> > > > > IIUC the last commits add tracepoints that are collected in the
> > > > > requesting CPU, at the moment of scheduling the IPI, which are al=
so useful in
> > > > > some scenarios.
> > > > >
> > > > > On my scenario, it could help a little, since it makes possible t=
o filter what
> > > > > all other cpus are scheduling on the requested cpu. OTOH it could=
 be also be
> > > > > misleading, as the requested cpu could be running something that =
was scheduled
> > > > > way before.
> > > > >
> > > > > The change I propose does exactly what my scenario need: track ex=
actly which
> > > > > function was running at given time in the requested CPU. With thi=
s info, we can
> > > > > check which (if any) remotely requested function was running on g=
iven time
> > > > > window.
> > > >
> > > > I was thinking you could simply (graph)-trace
> > > > __flush_smp_call_function_queue() with a max_graph_depth or so (Ste=
ve
> > > > says that ought to work).
> > > >
> > > > But even that might be too specific, your use case sounds more like=
 what
> > > > we have the irq-off latency tracer for, and that thing will immedia=
tely
> > > > tell you what functions were being ran.
> > > >
> > > > > (An unrelated thing I just thought: We could even use the commits=
 you pointed
> > > > > together with my proposed change in order to measure how long doe=
s it take for a
> > > > > requested function to run / complete in the requested cpu)
> > > >
> > > > I don't think you could actually do that; the send tracepoints Vale=
ntin
> > > > added don't log the csd address, this means you cannot distinguish
> > > > two CSDs with the same function send from different CPUs.
> > > >
> > > > To do this you'd need to add the csd address to the the ipi_send
> > > > tracepoints and your own (possibly replacing info -- because I don'=
t
> > > > think that's too useful).
> > > >
> > > > Valentin -- is any of this something you'd also find useful?
> > >
> > > Conceptually yeah, however:
> > >
> > > With isolcpus + NOHZ_FULL, *any* IPI sent to an isolated CPU is game =
over,
> > > you interrupt the userspace task and you eat the full meal that is
> > > NOHZ_FULL kernel entry. Pretty much any such IPI will show up when
> > > evaluating your setup with rteval/rlta/whatever, so having an event a=
t
> > > IPI reception is redundant.
> > >
> > > IIUC Leonardo's looking at a setup with isolcpus but not necessarily
> > > NOHZ_FULL, so he wants to look at *which* IPIs (if any) are pushing t=
he
> > > isolated task over its deadline/period. I would argue any IPI receive=
d
> > > there is at risk of doing that, so it's the same fight as with NOHZ_F=
ULL.
> > >
> > > With that said, I suppose this could still be helpful for e.g. osnois=
e to
> > > hook into and point the finger at which CPU/context sent the problema=
tic
> > > IPI. Or more generally, as Leonardo suggested, to measure CSD IPI del=
ivery
> > > times.
> > >
> > > One thing though is that trace_ipi_send_cpu*() is not used solely for
> > > CSD's, cf. irq_work_raise() or smp_send_reschedule(). We might want t=
o
> > > split that into e.g. trace_csd_queue_cpu*() + trace_ipi_send*().
> > >
> > > Something like so...
> > >
> > > ---
> > > diff --git a/include/trace/events/smp.h b/include/trace/events/smp.h
> > > new file mode 100644
> > > index 0000000000000..8fc725a2b45b9
> > > --- /dev/null
> > > +++ b/include/trace/events/smp.h
> > > @@ -0,0 +1,69 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM smp
> > > +
> > > +#if !defined(_TRACE_SMP_H) || defined(TRACE_HEADER_MULTI_READ)
> > > +#define _TRACE_SMP_H
> > > +
> > > +#include <linux/tracepoint.h>
> > > +
> > > +TRACE_EVENT(csd_queue_cpu,
> > > +
> > > +     TP_PROTO(const unsigned int cpu,
> > > +              unsigned long callsite,
> > > +              smp_call_func_t func,
> > > +              call_single_data_t *csd),
> > > +
> > > +     TP_ARGS(cpu, callsite, func, csd),
> > > +
> > > +     TP_STRUCT__entry(
> > > +             __field(unsigned int, cpu)
> > > +             __field(void *, callsite)
> > > +             __field(void *, func)
> > > +             __field(void *, csd)
> > > +     ),
> > > +
> > > +     TP_fast_assign(
> > > +             __entry->cpu =3D cpu;
> > > +             __entry->callsite =3D (void *)callsite;
> > > +             __entry->func =3D func;
> > > +             __entry->csd  =3D csd;
> > > +     ),
> > > +
> > > +     TP_printk("cpu=3D%u callsite=3D%pS func=3D%pS csd=3D%p",
> > > +               __entry->cpu, __entry->callsite, __entry->func, __ent=
ry->csd)
> > > +);
> >
> > This is for the caller side, right?
> >
> > > +
> > > +DECLARE_EVENT_CLASS(csd_function,
> > > +
> > > +     TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> > > +
> > > +     TP_ARGS(func, csd),
> > > +
> > > +     TP_STRUCT__entry(
> > > +             __field(void *, func)
> > > +             __field(void *, csd)
> > > +     ),
> > > +
> > > +     TP_fast_assign(
> > > +             __entry->func   =3D func;
> > > +             __entry->csd    =3D csd;
> > > +     ),
> > > +
> > > +     TP_printk("func=3D%pS csd=3D%p", __entry->func, __entry->csd)
> > > +);
> > > +
> > > +DEFINE_EVENT(csd_function, csd_function_entry,
> > > +     TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> > > +     TP_ARGS(func, csd)
> > > +);
> > > +
> > > +DEFINE_EVENT(csd_function, csd_function_exit,
> > > +     TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> > > +     TP_ARGS(func, csd)
> > > +);
> >
> > Oh, this is what event_class is for. Thanks for the example :)
> >
> > > +
> > > +#endif /* _TRACE_SMP_H */
> > > +
> > > +/* This part must be outside protection */
> > > +#include <trace/define_trace.h>
> > > diff --git a/kernel/smp.c b/kernel/smp.c
> > > index ab3e5dad6cfe9..7d28db303e9bc 100644
> > > --- a/kernel/smp.c
> > > +++ b/kernel/smp.c
> > > @@ -27,6 +27,9 @@
> > >  #include <linux/jump_label.h>
> > >
> > >  #include <trace/events/ipi.h>
> > > +#define CREATE_TRACE_POINTS
> > > +#include <trace/events/smp.h>
> > > +#undef CREATE_TRACE_POINTS
> > >
> > >  #include "smpboot.h"
> > >  #include "sched/smp.h"
> > > @@ -121,6 +124,14 @@ send_call_function_ipi_mask(struct cpumask *mask=
)
> > >       arch_send_call_function_ipi_mask(mask);
> > >  }
> > >
> > > +static __always_inline void
> > > +csd_do_func(smp_call_func_t func, void *info, call_single_data_t *cs=
d)
> > > +{
> > > +     trace_csd_function_entry(func, csd);
> > > +     func(info);
> > > +     trace_csd_function_exit(func, csd);
> > > +}
> > > +
> >
> > Good one, a helper to avoid calling those traces everywhere.
> >
> > Honest question:
> > Since info =3D=3D csd->info and func =3D=3D csd->func, we could just pa=
ss csd, right?
> > I suppose the suggestion on the 3-argument version is to use the values=
 already
> > fetched from memory instead of fetching them again. Is that correct?
> >
> > >  #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> > >
> > >  static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, c=
sdlock_debug_enabled);
> > > @@ -329,7 +340,7 @@ void __smp_call_single_queue(int cpu, struct llis=
t_node *node)
> > >        * even if we haven't sent the smp_call IPI yet (e.g. the stopp=
er
> > >        * executes migration_cpu_stop() on the remote CPU).
> > >        */
> > > -     if (trace_ipi_send_cpu_enabled()) {
> > > +     if (trace_csd_queue_cpu_enabled()) {
> > >               call_single_data_t *csd;
> > >               smp_call_func_t func;
> > >
> > > @@ -337,7 +348,7 @@ void __smp_call_single_queue(int cpu, struct llis=
t_node *node)
> > >               func =3D CSD_TYPE(csd) =3D=3D CSD_TYPE_TTWU ?
> > >                       sched_ttwu_pending : csd->func;
> > >
> > > -             trace_ipi_send_cpu(cpu, _RET_IP_, func);
> > > +             trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
> > >       }
> > >
> > >       /*
> > > @@ -375,7 +386,7 @@ static int generic_exec_single(int cpu, struct __=
call_single_data *csd)
> > >               csd_lock_record(csd);
> > >               csd_unlock(csd);
> > >               local_irq_save(flags);
> > > -             func(info);
> > > +             csd_do_func(func, info, NULL);
> > >               csd_lock_record(NULL);
> > >               local_irq_restore(flags);
> > >               return 0;
> > > @@ -477,7 +488,7 @@ static void __flush_smp_call_function_queue(bool =
warn_cpu_offline)
> > >                       }
> > >
> > >                       csd_lock_record(csd);
> > > -                     func(info);
> > > +                     csd_do_func(func, info, csd);
> > >                       csd_unlock(csd);
> > >                       csd_lock_record(NULL);
> > >               } else {
> > > @@ -508,7 +519,7 @@ static void __flush_smp_call_function_queue(bool =
warn_cpu_offline)
> > >
> > >                               csd_lock_record(csd);
> > >                               csd_unlock(csd);
> > > -                             func(info);
> > > +                             csd_do_func(func, info, csd);
> > >                               csd_lock_record(NULL);
> > >                       } else if (type =3D=3D CSD_TYPE_IRQ_WORK) {
> > >                               irq_work_single(csd);
> > > @@ -522,8 +533,10 @@ static void __flush_smp_call_function_queue(bool=
 warn_cpu_offline)
> > >       /*
> > >        * Third; only CSD_TYPE_TTWU is left, issue those.
> > >        */
> > > -     if (entry)
> > > -             sched_ttwu_pending(entry);
> > > +     if (entry) {
> > > +             csd =3D llist_entry(entry, typeof(*csd), node.llist);
> > > +             csd_do_func(sched_ttwu_pending, entry, csd);
> > > +     }
> > >  }
> > >
> > >
> > > @@ -624,7 +637,7 @@ EXPORT_SYMBOL(smp_call_function_single);
> > >
> > >  /**
> > >   * smp_call_function_single_async() - Run an asynchronous function o=
n a
> > > - *                            specific CPU.
> > > + *                            specific CPU.
> > >   * @cpu: The CPU to run on.
> > >   * @csd: Pre-allocated and setup data structure
> > >   *
> > > @@ -728,7 +741,7 @@ static void smp_call_function_many_cond(const str=
uct cpumask *mask,
> > >       int cpu, last_cpu, this_cpu =3D smp_processor_id();
> > >       struct call_function_data *cfd;
> > >       bool wait =3D scf_flags & SCF_WAIT;
> > > -     int nr_cpus =3D 0, nr_queued =3D 0;
> > > +     int nr_cpus =3D 0;
> > >       bool run_remote =3D false;
> > >       bool run_local =3D false;
> > >
> > > @@ -786,21 +799,16 @@ static void smp_call_function_many_cond(const s=
truct cpumask *mask,
> > >                       csd->node.src =3D smp_processor_id();
> > >                       csd->node.dst =3D cpu;
> > >  #endif
> > > +
> > > +                     trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
> > > +
> > >                       if (llist_add(&csd->node.llist, &per_cpu(call_s=
ingle_queue, cpu))) {
> > >                               __cpumask_set_cpu(cpu, cfd->cpumask_ipi=
);
> > >                               nr_cpus++;
> > >                               last_cpu =3D cpu;
> > >                       }
> > > -                     nr_queued++;
> > >               }
> > >
> > > -             /*
> > > -              * Trace each smp_function_call_*() as an IPI, actual I=
PIs
> > > -              * will be traced with func=3D=3Dgeneric_smp_call_funct=
ion_single_ipi().
> > > -              */
> > > -             if (nr_queued)
> > > -                     trace_ipi_send_cpumask(cfd->cpumask, _RET_IP_, =
func);
> > > -
> > >               /*
> > >                * Choose the most efficient way to send an IPI. Note t=
hat the
> > >                * number of CPUs might be zero due to concurrent chang=
es to the
> > > @@ -816,7 +824,7 @@ static void smp_call_function_many_cond(const str=
uct cpumask *mask,
> > >               unsigned long flags;
> > >
> > >               local_irq_save(flags);
> > > -             func(info);
> > > +             csd_do_func(func, info, NULL);
> > >               local_irq_restore(flags);
> > >       }
> > >
> > >
> >
> > I will rebase my patch on top of tip/smp/core and apply the suggested c=
hanges.
> > A v2 will be send shortly.
>
> RFC-v2 sent:
> https://lore.kernel.org/lkml/20230510221513.93297-1-leobras@redhat.com/
>

Argh, I accidentally sent an unfinished patch, sorry about that.
Please disconsider above v2, and review the v3 instead:
https://lore.kernel.org/lkml/20230510230128.150384-1-leobras@redhat.com/


> >
> > Thank you all for reviewing!
> > Leo
> >
> >

