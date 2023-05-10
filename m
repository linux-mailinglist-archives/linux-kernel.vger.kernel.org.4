Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368A06FE7EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjEJXGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbjEJXGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10560524C
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683759934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nyK0Cj80YL5pH3xJwOgTVCYG+yezilBbkZJfFsbbmok=;
        b=bKgWcMDY0c+8ZJjM5IOwPNjFNnsFRLEMOS7MMHCW8jydLUSgyb0Liw7TAvl2/THRVpJ1Pk
        tWxKa1WsgUDySnaqwbYyqmg1+qjl2fZgXJXkL8V+zSXsjLQQXG8QSbFCupp53h0NQOKERh
        vVbABrYjebLnzYr5M3ZFOgF+COgZ11Y=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-YKSzNptXNXOpN13mLbtduw-1; Wed, 10 May 2023 19:05:33 -0400
X-MC-Unique: YKSzNptXNXOpN13mLbtduw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7578369dff3so1482205285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683759932; x=1686351932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyK0Cj80YL5pH3xJwOgTVCYG+yezilBbkZJfFsbbmok=;
        b=hbnpyZGrj62x3cUNgbHLQOi5DMfWlYY4NlUtFKKAi1r9/xAZNhrqfKLr6y9S5Wptix
         z8Bj5hNG0iNmNpIDmSMpNS5c5VEk8pcZmvunIggmb4TATsfXSYtTm6e+Q1hdreHl1+ls
         d+3Iw4SckPIfdhKT2a6YET5B4+lPlj2gqfLtDLeGgr0LwCdLiSoF2L4LziTpiBzeNiJY
         pPJa2ZnxcK/xcUW9sFfAgecmA40abL6S4h2qNbSu4VkpVYjz94kNg6pppH8nwFt1DZeK
         wB+47NsRqfXaEyeZW7TRIEQQvHrEZxsOTvr91SB4KbXfVngbZvIigtX3DaimDx7SqALw
         hePg==
X-Gm-Message-State: AC+VfDzMRAaWkuF4xF7yZVj+ZnO6yHFgH6ZSq60nOG6+7jyFPyuKuZrf
        GdAN8qLQYLsgTYGQBOSV8zNTAH2NxrHouqO6vmwCASmfIMWlhCv9j45ANBT2VWwxji+H82Fj0do
        1vPanqY1nH5TEmN9nidnxfNuty/nBbZDzIAvOi8Wi
X-Received: by 2002:a05:622a:1a0c:b0:3ef:3008:bf with SMTP id f12-20020a05622a1a0c00b003ef300800bfmr27870306qtb.9.1683759932632;
        Wed, 10 May 2023 16:05:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6U4wMukMwe5Du2AeL5X6nzRVB05Eio1VacJ5xAl+fsGk+dmX46WYu/008svIFjo2nk9+BNssgMtwhX8ES3tYc=
X-Received: by 2002:a05:622a:1a0c:b0:3ef:3008:bf with SMTP id
 f12-20020a05622a1a0c00b003ef300800bfmr27870273qtb.9.1683759932346; Wed, 10
 May 2023 16:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230510221513.93297-1-leobras@redhat.com>
In-Reply-To: <20230510221513.93297-1-leobras@redhat.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 10 May 2023 20:05:21 -0300
Message-ID: <CAJ6HWG6dP=Oy79F4SoMXg47ak7ygwzJLdhqx-U9BoY8hKb+VNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] trace,smp: Add tracepoints around remotelly
 called functions
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
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

On Wed, May 10, 2023 at 7:16=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> When running RT workloads in isolated CPUs, many cases of deadline misses
> are caused by remote CPU requests such as smp_call_function*().
>
> For those cases, having the names of those functions running around the
> deadline miss moment could help (a lot) finding a target for the next
> improvements.
>
> Add tracepoints for acquiring the function name & csd before entry and
> after returning from the remote-cpu requested function.
>
> Also, add tracepoints on the remote cpus requesting them.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>
> Changes since RFCv1:
> - Implemented trace_csd_queue_cpu() as suggested by Valentin Schneider
> - Using EVENT_CLASS in order to avoid duplication
> - Introduced new helper: csd_do_func()
> - Name change from smp_call_function_* to csd_function_*
> - Rebased on top of torvalds/master
>
>  include/trace/events/smp.h | 72 ++++++++++++++++++++++++++++++++++++++
>  kernel/smp.c               | 41 +++++++++++++---------
>  2 files changed, 96 insertions(+), 17 deletions(-)
>  create mode 100644 include/trace/events/smp.h
>
> diff --git a/include/trace/events/smp.h b/include/trace/events/smp.h
> new file mode 100644
> index 000000000000..5fd75399d3f1
> --- /dev/null
> +++ b/include/trace/events/smp.h
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM smp
> +
> +#if !defined(_TRACE_SMP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_SMP_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(csd_queue_cpu,
> +
> +       TP_PROTO(const unsigned int cpu,
> +                unsigned long callsite,
> +                smp_call_func_t func,
> +                call_single_data_t *csd),
> +
> +       TP_ARGS(cpu, callsite, func, csd),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned int, cpu)
> +               __field(void *, callsite)
> +               __field(void *, func)
> +               __field(void *, csd)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->cpu =3D cpu;
> +               __entry->callsite =3D (void *)callsite;
> +               __entry->func =3D func;
> +               __entry->csd  =3D csd;
> +       ),
> +
> +       TP_printk("cpu=3D%u callsite=3D%pS func=3D%pS csd=3D%p",
> +                 __entry->cpu, __entry->callsite, __entry->func, __entry=
->csd)
> +);
> +
> +/*
> + * Tracepoints for a function which is called as an effect of smp_call_f=
unction.*
> + */
> +DECLARE_EVENT_CLASS(csd_function,
> +
> +       TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> +
> +       TP_ARGS(func, csd),
> +
> +       TP_STRUCT__entry(
> +               __field(void *, func)
> +               __field(void *, csd)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->func   =3D func;
> +               __entry->csd    =3D csd;
> +       ),
> +
> +       TP_printk("function %ps, csd =3D %p", __entry->func, __entry->csd=
)
> +);
> +
> +DEFINE_EVENT(csd_function, csd_function_entry,
> +       TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> +       TP_ARGS(func, csd),
> +);
> +
> +DEFINE_EVENT(csd_function, csd_function_exit,
> +       TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> +       TP_ARGS(func, csd),
> +);
> +
> +#endif /* _TRACE_SMP_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/kernel/smp.c b/kernel/smp.c
> index ab3e5dad6cfe..a34aa2b92050 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -27,6 +27,9 @@
>  #include <linux/jump_label.h>
>
>  #include <trace/events/ipi.h>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/smp.h>
> +#undef CREATE_TRACE_POINTS
>
>  #include "smpboot.h"
>  #include "sched/smp.h"
> @@ -121,6 +124,14 @@ send_call_function_ipi_mask(struct cpumask *mask)
>         arch_send_call_function_ipi_mask(mask);
>  }
>
> +static __always_inline void
> +csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd)
> +{
> +       trace_csd_function_entry(func, csd);
> +       func(info);
> +       trace_csd_function_exit(func, csd);
> +}
> +
>  #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
>
>  static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, csdlo=
ck_debug_enabled);
> @@ -329,7 +340,7 @@ void __smp_call_single_queue(int cpu, struct llist_no=
de *node)
>          * even if we haven't sent the smp_call IPI yet (e.g. the stopper
>          * executes migration_cpu_stop() on the remote CPU).
>          */
> -       if (trace_ipi_send_cpu_enabled()) {
> +       if (trace_csd_queue_cpu_enabled()) {
>                 call_single_data_t *csd;
>                 smp_call_func_t func;
>
> @@ -337,7 +348,7 @@ void __smp_call_single_queue(int cpu, struct llist_no=
de *node)
>                 func =3D CSD_TYPE(csd) =3D=3D CSD_TYPE_TTWU ?
>                         sched_ttwu_pending : csd->func;
>
> -               trace_ipi_send_cpu(cpu, _RET_IP_, func);
> +               trace_csd_queue_cpu(cpu, _RET_IP_, func);
>         }
>
>         /*
> @@ -375,7 +386,7 @@ static int generic_exec_single(int cpu, struct __call=
_single_data *csd)
>                 csd_lock_record(csd);
>                 csd_unlock(csd);
>                 local_irq_save(flags);
> -               func(info);
> +               csd_do_func(func, info, csd);
>                 csd_lock_record(NULL);
>                 local_irq_restore(flags);
>                 return 0;
> @@ -477,7 +488,7 @@ static void __flush_smp_call_function_queue(bool warn=
_cpu_offline)
>                         }
>
>                         csd_lock_record(csd);
> -                       func(info);
> +                       csd_do_func(func, info, csd);
>                         csd_unlock(csd);
>                         csd_lock_record(NULL);
>                 } else {
> @@ -508,7 +519,7 @@ static void __flush_smp_call_function_queue(bool warn=
_cpu_offline)
>
>                                 csd_lock_record(csd);
>                                 csd_unlock(csd);
> -                               func(info);
> +                               csd_do_func(func, info, csd);
>                                 csd_lock_record(NULL);
>                         } else if (type =3D=3D CSD_TYPE_IRQ_WORK) {
>                                 irq_work_single(csd);
> @@ -522,8 +533,10 @@ static void __flush_smp_call_function_queue(bool war=
n_cpu_offline)
>         /*
>          * Third; only CSD_TYPE_TTWU is left, issue those.
>          */
> -       if (entry)
> -               sched_ttwu_pending(entry);
> +       if (entry) {
> +               csd =3D llist_entry(entry, typeof(*csd), node.llist);
> +               csd_do_func(sched_ttwu_pending, entry, csd);
> +       }
>  }
>
>
> @@ -728,7 +741,7 @@ static void smp_call_function_many_cond(const struct =
cpumask *mask,
>         int cpu, last_cpu, this_cpu =3D smp_processor_id();
>         struct call_function_data *cfd;
>         bool wait =3D scf_flags & SCF_WAIT;
> -       int nr_cpus =3D 0, nr_queued =3D 0;
> +       int nr_cpus =3D 0;
>         bool run_remote =3D false;
>         bool run_local =3D false;
>
> @@ -786,21 +799,15 @@ static void smp_call_function_many_cond(const struc=
t cpumask *mask,
>                         csd->node.src =3D smp_processor_id();
>                         csd->node.dst =3D cpu;
>  #endif
> +                       trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
> +
>                         if (llist_add(&csd->node.llist, &per_cpu(call_sin=
gle_queue, cpu))) {
>                                 __cpumask_set_cpu(cpu, cfd->cpumask_ipi);
>                                 nr_cpus++;
>                                 last_cpu =3D cpu;
>                         }
> -                       nr_queued++;
>                 }
>
> -               /*
> -                * Trace each smp_function_call_*() as an IPI, actual IPI=
s
> -                * will be traced with func=3D=3Dgeneric_smp_call_functio=
n_single_ipi().
> -                */
> -               if (nr_queued)
> -                       trace_ipi_send_cpumask(cfd->cpumask, _RET_IP_, fu=
nc);
> -
>                 /*
>                  * Choose the most efficient way to send an IPI. Note tha=
t the
>                  * number of CPUs might be zero due to concurrent changes=
 to the
> @@ -816,7 +823,7 @@ static void smp_call_function_many_cond(const struct =
cpumask *mask,
>                 unsigned long flags;
>
>                 local_irq_save(flags);
> -               func(info);
> +               csd_do_func(func, info, csd);
>                 local_irq_restore(flags);
>         }
>
> --
> 2.40.1
>

Argh, I accidentally sent an unfinished patch, sorry about that.
Please disconsider above v2, and review the v3 instead:
https://lore.kernel.org/lkml/20230510230128.150384-1-leobras@redhat.com/

Leo

