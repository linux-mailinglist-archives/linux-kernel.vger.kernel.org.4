Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2B6FEEC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbjEKJ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjEKJ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC0A5F4
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683797140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nv3K94+E4w0eulJx7qgnISp/XkLo7GNu+tDWDqLNLbc=;
        b=DNwTlFtwf4Q8enSNP1A4QmWP8kSsnrR7cX9F1/9b9m02C+Yof3HQk+X+eb1yaL4YFbevsj
        eNbe8uQTHX2AAYPNMeXjti/cSVHrxKUk0ToqIjL+NvhQHYIv9gip596M7ajRQgv69mm9QC
        KuYrYXs1gIh/tvgJAkZ9dD1C/LocJMo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-8bbIRa_iNiGoTOx7l-Jr6A-1; Thu, 11 May 2023 05:25:39 -0400
X-MC-Unique: 8bbIRa_iNiGoTOx7l-Jr6A-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-757890c1de9so548357185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797139; x=1686389139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv3K94+E4w0eulJx7qgnISp/XkLo7GNu+tDWDqLNLbc=;
        b=gRxOpkiYRrQ+Lbwi+o4pR6Oja/ATFUXxdg5MJVaMOJ/gaL4mmQQkOsvNkiEoEPFh/W
         zNGjnK2vbsqUjCbRFilcNU8M8ptwQ4vigrxMYqq+yKDAEGZILJhJm12Hj313cfKmE8OZ
         ASfXCp1RnXgk/+bNn0w70+owV8J3kF/6x1M0ORBeLzMa5AuoFqN7cAdPiPi2w0Fjn2m3
         eFhrjve/43x2rRBqOYXk1wotxBVBAYKrWulF2wM92k41Po6ojMfGSuipd1BM+iN7q7wD
         PnI53hB3LXfnMCC3/M0aMsEt1+pmh52NyNNV6bydmTFS/mVsEMoVCqBA6w1i5amHba0J
         kF+w==
X-Gm-Message-State: AC+VfDxar3ikOTmlBom44XVHqvJZaLin9fFihiNugjHGRp0xMVT9S08W
        Icaqm6TOK9NRe4H5fpybnJZlcETSeNbwGRWxq5YwsvFAmlPrEsF6dANtLzR/7Rx2UQ5IEu8uyyA
        ccgfhgYCKerWGpjCeqKk59jNuT/+kH/4bpTe22PgV
X-Received: by 2002:ac8:5b50:0:b0:3d9:45a4:e7b9 with SMTP id n16-20020ac85b50000000b003d945a4e7b9mr29625316qtw.45.1683797139032;
        Thu, 11 May 2023 02:25:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6CfC+bzRY7It1UM9llGJVITAqGcpFflzAfkOiFZXTD0kgT1jc1DuCUQIWmLykpBNhVTPaWN1QFNLpoEV2gonE=
X-Received: by 2002:ac8:5b50:0:b0:3d9:45a4:e7b9 with SMTP id
 n16-20020ac85b50000000b003d945a4e7b9mr29625303qtw.45.1683797138774; Thu, 11
 May 2023 02:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230406075718.68672-1-leobras@redhat.com> <20230406095519.GG386572@hirez.programming.kicks-ass.net>
 <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
 <20230503145900.GC1689514@hirez.programming.kicks-ass.net>
 <xhsmh7ctojoia.mognet@vschneid.remote.csb> <f96442e9166e4f73be772656a93c89093eddbb8b.camel@redhat.com>
 <xhsmhv8gzi8uw.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhv8gzi8uw.mognet@vschneid.remote.csb>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Thu, 11 May 2023 06:25:27 -0300
Message-ID: <CAJ6HWG4g+KgqbJR+AsAKGG9vPViJpwXO-8bMSPzMZzYKXD_rWg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with smp_call_function*()
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 5:13=E2=80=AFAM Valentin Schneider <vschneid@redhat=
.com> wrote:
>
> On 10/05/23 17:27, Leonardo Br=C3=A1s wrote:
> > On Thu, 2023-05-04 at 12:59 +0100, Valentin Schneider wrote:
> >> +TRACE_EVENT(csd_queue_cpu,
> >> +
> >> +    TP_PROTO(const unsigned int cpu,
> >> +             unsigned long callsite,
> >> +             smp_call_func_t func,
> >> +             call_single_data_t *csd),
> >> +
> >> +    TP_ARGS(cpu, callsite, func, csd),
> >> +
> >> +    TP_STRUCT__entry(
> >> +            __field(unsigned int, cpu)
> >> +            __field(void *, callsite)
> >> +            __field(void *, func)
> >> +            __field(void *, csd)
> >> +    ),
> >> +
> >> +    TP_fast_assign(
> >> +            __entry->cpu =3D cpu;
> >> +            __entry->callsite =3D (void *)callsite;
> >> +            __entry->func =3D func;
> >> +            __entry->csd  =3D csd;
> >> +    ),
> >> +
> >> +    TP_printk("cpu=3D%u callsite=3D%pS func=3D%pS csd=3D%p",
> >> +              __entry->cpu, __entry->callsite, __entry->func, __entry=
->csd)
> >> +);
> >
> > This is for the caller side, right?
> >
>
> Yep, see usage lower down.
>
> >> +
> >> +DECLARE_EVENT_CLASS(csd_function,
> >> +
> >> +    TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> >> +
> >> +    TP_ARGS(func, csd),
> >> +
> >> +    TP_STRUCT__entry(
> >> +            __field(void *, func)
> >> +            __field(void *, csd)
> >> +    ),
> >> +
> >> +    TP_fast_assign(
> >> +            __entry->func   =3D func;
> >> +            __entry->csd    =3D csd;
> >> +    ),
> >> +
> >> +    TP_printk("func=3D%pS csd=3D%p", __entry->func, __entry->csd)
> >> +);
> >> +
> >> +DEFINE_EVENT(csd_function, csd_function_entry,
> >> +    TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> >> +    TP_ARGS(func, csd)
> >> +);
> >> +
> >> +DEFINE_EVENT(csd_function, csd_function_exit,
> >> +    TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> >> +    TP_ARGS(func, csd)
> >> +);
> >
> > Oh, this is what event_class is for. Thanks for the example :)
> >
> >> +
> >> +#endif /* _TRACE_SMP_H */
> >> +
> >> +/* This part must be outside protection */
> >> +#include <trace/define_trace.h>
> >> diff --git a/kernel/smp.c b/kernel/smp.c
> >> index ab3e5dad6cfe9..7d28db303e9bc 100644
> >> --- a/kernel/smp.c
> >> +++ b/kernel/smp.c
> >> @@ -27,6 +27,9 @@
> >>  #include <linux/jump_label.h>
> >>
> >>  #include <trace/events/ipi.h>
> >> +#define CREATE_TRACE_POINTS
> >> +#include <trace/events/smp.h>
> >> +#undef CREATE_TRACE_POINTS
> >>
> >>  #include "smpboot.h"
> >>  #include "sched/smp.h"
> >> @@ -121,6 +124,14 @@ send_call_function_ipi_mask(struct cpumask *mask)
> >>      arch_send_call_function_ipi_mask(mask);
> >>  }
> >>
> >> +static __always_inline void
> >> +csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd=
)
> >> +{
> >> +    trace_csd_function_entry(func, csd);
> >> +    func(info);
> >> +    trace_csd_function_exit(func, csd);
> >> +}
> >> +
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
>
> There's also the special case of CSD_TYPE_TTWU where there is no csd->fun=
c,
> instead we have an implicit func mapping to sched_ttwu_pending). I think
> it's preferable to directly feed the right things to the TP than to
> duplicate the "decoding" logic against the *csd passed as TP argument.
>

Quite interesting, thank you for sharing!

I sent a v3 which got a warning from the kernel testing robot. I
already solved the warning, so please provide feedback on the rest of
the patch.

About the warning:
It is an alignment error between 'struct __call_single_data' from
generic_exec_single() and 'call_single_data_t' from csd_do_func(): the
first is 8-byte aligned, and the second is 32-byte aligned according
to the typedef.

My first idea was to convert my patches' parameters from
call_single_data_t to 'struct __call_single_data', but then I found
out the 'struct' option allows splitting csd between 2 cachelines,
which is usually bad.
Then I decided to send a patchset [1] fixing generic_exec_single() and
its callers. If it's accepted, the warning will go away, and v3 will
merge cleanly.

If not, I will send a v4 changing the parameters.

Thanks for reviewing,
Leo


1. https://lore.kernel.org/lkml/20230511085836.579679-1-leobras@redhat.com

