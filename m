Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D43703B54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbjEOSBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244847AbjEOSBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:01:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB8E1D4B3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684173422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AxRKUz43mkyWHnl3hhc85iFtDBgXfNEcSSyxnUZSGk=;
        b=GMEp3trqJwMlXWsSeRdcfTuYn/240L4EdhsrzGPw+bF03a1/9i1i6IT1GXdkdcmNobjGlw
        dvYLku4R5g0cvirdgc8MkMUCOwUaY9mR03e5Mvlvd0jLAkRzCI18WS8GvIZuUQK4f0eVRl
        oQWvYwuo29T5oYHv3xMLxDkLkNxuUTI=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-fpRYTOwENhOQ5Nn2XwJlhg-1; Mon, 15 May 2023 13:56:59 -0400
X-MC-Unique: fpRYTOwENhOQ5Nn2XwJlhg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-199a5334b4aso1878231fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684173419; x=1686765419;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9AxRKUz43mkyWHnl3hhc85iFtDBgXfNEcSSyxnUZSGk=;
        b=iqNrAfPMu2XOFZljiLVt0XviK6ieJgdc7afZqqqldun28AkQRi950gPmnYYHLCgFS4
         s5xDwedfCXJrHbmxPl38FrN9ymXenllc0xXuLeD1IultHn/HMxrqTm+EM4NsSmRkpgtM
         TOaweqj9HzN18829dzDSnJKD/Bbkyj+ALWkJgA/7Xvj6qWJEHaqecj4yJX56xgOquEqq
         JCoyjrVCm+A/MRtE+53xOmFOtcPH5Wujo8/db2bSX0IEDGAUwUn/ilPl2Y4X08waIEn5
         wm40cwdD1QJo0dhMbeX15JP+M80LCcRngAd/0/1LieOHi6bQQTrjh1yBplAiCspuRs3h
         G4Mw==
X-Gm-Message-State: AC+VfDxEuzfptPQra3bu4EQr8KDrBkfJiZ17aUNfmsuowMOZlOD690p2
        o8zGKCKDsuoJWVPV8nZVY4wJL6umFICu8LC7XzKCPEk8lO6+PqKf692AzpI4WJDOgedFe8Bn2IF
        vUWQldDtJXezS0r3UQj/8k9LC
X-Received: by 2002:a05:6870:a8ac:b0:187:b836:4d33 with SMTP id eb44-20020a056870a8ac00b00187b8364d33mr16272153oab.30.1684173418995;
        Mon, 15 May 2023 10:56:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7MnfqueXLdJ6vZqBxL7+2U0zreUXrURbrDpvt+0D82wLc+J7YxbrsaXtWgvNHkuh5Hof4oiA==
X-Received: by 2002:a05:6870:a8ac:b0:187:b836:4d33 with SMTP id eb44-20020a056870a8ac00b00187b8364d33mr16272148oab.30.1684173418667;
        Mon, 15 May 2023 10:56:58 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3? ([2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3])
        by smtp.gmail.com with ESMTPSA id g5-20020a05687085c500b00187e500e7b3sm12185025oal.49.2023.05.15.10.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 10:56:58 -0700 (PDT)
Message-ID: <27e4a2b4557ae24e673b6fb85b34fe0e32efa06f.camel@redhat.com>
Subject: Re: [RFC PATCH v3 1/1] trace,smp: Add tracepoints around remotelly
 called functions
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
Date:   Mon, 15 May 2023 14:56:53 -0300
In-Reply-To: <xhsmhsfc3i1bc.mognet@vschneid.remote.csb>
References: <20230510230128.150384-1-leobras@redhat.com>
         <xhsmhsfc3i1bc.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-11 at 11:56 +0100, Valentin Schneider wrote:
> On 10/05/23 20:01, Leonardo Bras wrote:
> > When running RT workloads in isolated CPUs, many cases of deadline miss=
es
> > are caused by remote CPU requests such as smp_call_function*().
> >=20
> > For those cases, having the names of those functions running around the
> > deadline miss moment could help (a lot) finding a target for the next
> > improvements.
> >=20
> > Add tracepoints for acquiring the function name & csd before entry and
> > after returning from the remote-cpu requested function.
> >=20
> > Also, add tracepoints on the remote cpus requesting them.
>=20
> Per the v1 thread, I got some context as to why we want this, but this
> changelog is quite sparse on the subject. How about:
>=20
> """
> The recently added ipi_send_{cpu,cpumask} tracepoints allow finding sourc=
es
> of IPIs targeting CPUs running latency-sensitive applications.
>=20
> For NOHZ_FULL CPUs, all IPIs are interference, and those tracepoints are
> sufficient to find them and work on getting rid of them. In some setups
> however, not *all* IPIs are to be suppressed, but long-running IPI
> callbacks can still be problematic.
>=20
> Add a pair of tracepoints to mark the start and end of processing a CSD I=
PI
> callback, similar to what exists for softirq, workqueue or timer callback=
s.
> """
>=20
> And you can probably split the csd_queue_cpu TP into a separate commit,
> with something along the lines of:
>=20
> """
> Add a tracepoint for when a CSD is queued to a remote CPU's
> call_single_queue. This allows finding exactly which CPU queued a given C=
SD
> when looking at a csd_function_{entry,exit} event, and also enables us to
> accurately measure IPI delivery time with e.g. a synthetic event:
>=20
>   $ echo 'hist:keys=3Dcpu,csd.hex:ts=3Dcommon_timestamp.usecs' >\
>       /sys/kernel/tracing/events/smp/csd_queue_cpu/trigger
>   $ echo 'csd_latency unsigned int dst_cpu; unsigned long csd; u64 time' =
>\
>       /sys/kernel/tracing/synthetic_events
>   $ echo \
>   'hist:keys=3Dcommon_cpu,csd.hex:'\
>   'time=3Dcommon_timestamp.usecs-$ts:'\
>   'onmatch(smp.csd_queue_cpu).trace(csd_latency,common_cpu,csd,$time)' >\
>       /sys/kernel/tracing/events/smp/csd_function_entry/trigger
>=20
>   $ trace-cmd record -e 'synthetic:csd_latency' hackbench
>   $ trace-cmd report
>   <...>-467   [001]    21.824263: csd_queue_cpu:        cpu=3D0 callsite=
=3Dtry_to_wake_up+0x2ea func=3Dsched_ttwu_pending csd=3D0xffff8880076148b8
>   <...>-467   [001]    21.824280: ipi_send_cpu:         cpu=3D0 callsite=
=3Dtry_to_wake_up+0x2ea callback=3Dgeneric_smp_call_function_single_interru=
pt+0x0
>   <...>-489   [000]    21.824299: csd_function_entry:   func=3Dsched_ttwu=
_pending csd=3D0xffff8880076148b8
>   <...>-489   [000]    21.824320: csd_latency:          dst_cpu=3D0, csd=
=3D18446612682193848504, time=3D36
> """

Sure, I will split the patch and add the commit msg as suggested.


>=20
> >=20
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
>=20
> Overall I like the CSD vs IPI split, it's a saner approach than logging i=
t
> all as IPIs, even if it does generate more events as we have to emit an
> event for every csd queued (i.e. no _cpumask() variant is possible).
>=20
> Some nitpicks below, and one other thing: are we happy with the smp event
> namespace, and with the new TP names? Should the namespace be csd instead=
,
> to match the trace_<namespace>_* nomenclature?

I selected "smp.h" filename because those tracepoints are getting used on s=
mp.c.

I think keeping a generic name is good for any future tracepoints people en=
d up
designing for smp.c, but I am open to discussion.

>=20
> > ---
> >=20
> > Changes since RFCv2:
> > - Fixed some spacing issues and trace calls
> >=20
> > Changes since RFCv1:
> > - Implemented trace_csd_queue_cpu() as suggested by Valentin Schneider
> > - Using EVENT_CLASS in order to avoid duplication
> > - Introduced new helper: csd_do_func()
> > - Name change from smp_call_function_* to csd_function_*
> > - Rebased on top of torvalds/master
> >=20
> >  include/trace/events/smp.h | 72 ++++++++++++++++++++++++++++++++++++++
> >  kernel/smp.c               | 41 +++++++++++++---------
> >  2 files changed, 96 insertions(+), 17 deletions(-)
> >  create mode 100644 include/trace/events/smp.h
> >=20
> > diff --git a/include/trace/events/smp.h b/include/trace/events/smp.h
> > new file mode 100644
> > index 000000000000..c304318a0203
> > --- /dev/null
> > +++ b/include/trace/events/smp.h
> > @@ -0,0 +1,72 @@
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
> > +	TP_PROTO(const unsigned int cpu,
> > +		 unsigned long callsite,
> > +		 smp_call_func_t func,
> > +		 call_single_data_t *csd),
> > +
> > +	TP_ARGS(cpu, callsite, func, csd),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(unsigned int, cpu)
> > +		__field(void *, callsite)
> > +		__field(void *, func)
> > +		__field(void *, csd)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->cpu =3D cpu;
> > +		__entry->callsite =3D (void *)callsite;
> > +		__entry->func =3D func;
> > +		__entry->csd  =3D csd;
> > +	),
> > +
> > +	TP_printk("cpu=3D%u callsite=3D%pS func=3D%pS csd=3D%p",
>                                        ^^^^^^^^
> This can be func=3D%ps, offsets should always be 0 so not very useful (I =
know
> I put %pS for the IPI TPs, that's a force of habit...)
>=20

I agree, let's do as suggested.

> > +		  __entry->cpu, __entry->callsite, __entry->func, __entry->csd)
> > +);
>=20
> > +
> > +/*
> > + * Tracepoints for a function which is called as an effect of smp_call=
_function.*
> > + */
> > +DECLARE_EVENT_CLASS(csd_function,
> > +
> > +	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> > +
> > +	TP_ARGS(func, csd),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(void *,	func)
> > +		__field(void *,	csd)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->func	=3D func;
> > +		__entry->csd	=3D csd;
> > +	),
> > +
> > +	TP_printk("function %ps, csd =3D %p", __entry->func, __entry->csd)
>=20
> To match the style of the other TPs, that should be:
>=20
>         TP_printk("func=3D%ps csd=3D%p", __entry->func, __entry->csd)
>=20

Done!


Thanks for reviewing!
Leo

