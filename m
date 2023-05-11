Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150EA6FF049
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbjEKK5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbjEKK5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D227297
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683802588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tJZQ2TQo82z6Oemv+3a/ZReUoAgQPxK5a+WyIZI499E=;
        b=YVv34xLd9inl1TZ/tyA21PRYg6/RHz0RhC+EjHQhIdD9PeIrVPEsEk7Prgdegjkw3jUVmJ
        AD5r8nEDXbmVplrxXkDP1SxtYKLakTY/Fnl/mjJovYf9F6JTw5ValYC4RE+03A33Azkym7
        aiqYbjU1KdZfL7f4ZzB8TS1B70/yrHQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-k13SAWWTM_alWDS9fMILHQ-1; Thu, 11 May 2023 06:56:26 -0400
X-MC-Unique: k13SAWWTM_alWDS9fMILHQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f4245ffbb4so26788985e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683802585; x=1686394585;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJZQ2TQo82z6Oemv+3a/ZReUoAgQPxK5a+WyIZI499E=;
        b=RSwPb3WTQguMY50+Mj79el9s8MEYxrcQTp6j/GHpY+glXGNg00KuOrxVjlzSPxL2kx
         Ii/5yFPaR1S2D6E+YR1XlqI1SuZG9VXTa86tvg+fU21Kv9Hsw8SNgATNncj8oSryTNG7
         P/yEr703BXzgJ4Hs/l9kzamgYKXq82xV8TxvFu8O/M3pcYORvh1SpiC5P9SwjVZUe7gg
         z9ZPxcsG0UNWeWgU6TwLKzguVyshEkvoO6fOF62K3jBVNXMMZb7XZdYUyDToTuAOFmr7
         xc2vYJNGFOxdedRiPQtGQwkyAHT+0jgqqY4aeqwJ2DR7N0y95r1nOcQ58QrlqLUfwcM0
         dAmg==
X-Gm-Message-State: AC+VfDz8Q+nLr7eJfxACeGfbO0lKYNJV5XnNP0uIf0dtZuibpQgVwuFS
        SyPxqqhAJnALMaWJUjT9UcS7/5xVIXTQJc0/4mKzZPc8lbEMbqfT4OD73HQHKrG/Cyf2JX+jCNq
        zi4g7S9qQ/Gm5X/KmpSPB1XfxCfuDBfko
X-Received: by 2002:a7b:cc13:0:b0:3f3:468d:d017 with SMTP id f19-20020a7bcc13000000b003f3468dd017mr15288296wmh.6.1683802585062;
        Thu, 11 May 2023 03:56:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4H/cgL05AV28bp78/4RrLkVyRmBQBkCfDxojUE6Q4dcoXKlU4gD3MeQOb/1rNztmQYtxnPcQ==
X-Received: by 2002:a7b:cc13:0:b0:3f3:468d:d017 with SMTP id f19-20020a7bcc13000000b003f3468dd017mr15288266wmh.6.1683802584736;
        Thu, 11 May 2023 03:56:24 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id l4-20020a5d4104000000b00304832cd960sm19965543wrp.10.2023.05.11.03.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 03:56:24 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Leonardo Bras <leobras@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/1] trace,smp: Add tracepoints around remotelly
 called functions
In-Reply-To: <20230510230128.150384-1-leobras@redhat.com>
References: <20230510230128.150384-1-leobras@redhat.com>
Date:   Thu, 11 May 2023 11:56:23 +0100
Message-ID: <xhsmhsfc3i1bc.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/23 20:01, Leonardo Bras wrote:
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

Per the v1 thread, I got some context as to why we want this, but this
changelog is quite sparse on the subject. How about:

"""
The recently added ipi_send_{cpu,cpumask} tracepoints allow finding sources
of IPIs targeting CPUs running latency-sensitive applications.

For NOHZ_FULL CPUs, all IPIs are interference, and those tracepoints are
sufficient to find them and work on getting rid of them. In some setups
however, not *all* IPIs are to be suppressed, but long-running IPI
callbacks can still be problematic.

Add a pair of tracepoints to mark the start and end of processing a CSD IPI
callback, similar to what exists for softirq, workqueue or timer callbacks.
"""

And you can probably split the csd_queue_cpu TP into a separate commit,
with something along the lines of:

"""
Add a tracepoint for when a CSD is queued to a remote CPU's
call_single_queue. This allows finding exactly which CPU queued a given CSD
when looking at a csd_function_{entry,exit} event, and also enables us to
accurately measure IPI delivery time with e.g. a synthetic event:

  $ echo 'hist:keys=cpu,csd.hex:ts=common_timestamp.usecs' >\
      /sys/kernel/tracing/events/smp/csd_queue_cpu/trigger
  $ echo 'csd_latency unsigned int dst_cpu; unsigned long csd; u64 time' >\
      /sys/kernel/tracing/synthetic_events
  $ echo \
  'hist:keys=common_cpu,csd.hex:'\
  'time=common_timestamp.usecs-$ts:'\
  'onmatch(smp.csd_queue_cpu).trace(csd_latency,common_cpu,csd,$time)' >\
      /sys/kernel/tracing/events/smp/csd_function_entry/trigger

  $ trace-cmd record -e 'synthetic:csd_latency' hackbench
  $ trace-cmd report
  <...>-467   [001]    21.824263: csd_queue_cpu:        cpu=0 callsite=try_to_wake_up+0x2ea func=sched_ttwu_pending csd=0xffff8880076148b8
  <...>-467   [001]    21.824280: ipi_send_cpu:         cpu=0 callsite=try_to_wake_up+0x2ea callback=generic_smp_call_function_single_interrupt+0x0
  <...>-489   [000]    21.824299: csd_function_entry:   func=sched_ttwu_pending csd=0xffff8880076148b8
  <...>-489   [000]    21.824320: csd_latency:          dst_cpu=0, csd=18446612682193848504, time=36
"""

>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

Overall I like the CSD vs IPI split, it's a saner approach than logging it
all as IPIs, even if it does generate more events as we have to emit an
event for every csd queued (i.e. no _cpumask() variant is possible).

Some nitpicks below, and one other thing: are we happy with the smp event
namespace, and with the new TP names? Should the namespace be csd instead,
to match the trace_<namespace>_* nomenclature?

> ---
>
> Changes since RFCv2:
> - Fixed some spacing issues and trace calls
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
> index 000000000000..c304318a0203
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
> +	TP_PROTO(const unsigned int cpu,
> +		 unsigned long callsite,
> +		 smp_call_func_t func,
> +		 call_single_data_t *csd),
> +
> +	TP_ARGS(cpu, callsite, func, csd),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(void *, callsite)
> +		__field(void *, func)
> +		__field(void *, csd)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->callsite = (void *)callsite;
> +		__entry->func = func;
> +		__entry->csd  = csd;
> +	),
> +
> +	TP_printk("cpu=%u callsite=%pS func=%pS csd=%p",
                                       ^^^^^^^^
This can be func=%ps, offsets should always be 0 so not very useful (I know
I put %pS for the IPI TPs, that's a force of habit...)

> +		  __entry->cpu, __entry->callsite, __entry->func, __entry->csd)
> +);

> +
> +/*
> + * Tracepoints for a function which is called as an effect of smp_call_function.*
> + */
> +DECLARE_EVENT_CLASS(csd_function,
> +
> +	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> +
> +	TP_ARGS(func, csd),
> +
> +	TP_STRUCT__entry(
> +		__field(void *,	func)
> +		__field(void *,	csd)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->func	= func;
> +		__entry->csd	= csd;
> +	),
> +
> +	TP_printk("function %ps, csd = %p", __entry->func, __entry->csd)

To match the style of the other TPs, that should be:

        TP_printk("func=%ps csd=%p", __entry->func, __entry->csd)

