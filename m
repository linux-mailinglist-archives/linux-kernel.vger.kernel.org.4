Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A5C6FEDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjEKIOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjEKIOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6BF2720
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683792814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ISts0ooOqDRfuZXF0qq5A4HD7E+tCGV5ujF6/xdMaMg=;
        b=PzgRB9stweH5iS4FO+VIw9DhD7A6TyddIKo5AEg2CgODlTZDQr1Ot8BccHu5/oF3tz0AVO
        38PduJibRwuBgAdzq7sXT9fntJ9oXshcwYOn/s8T7xhIztkhtqsWzhVCOAb3EYVg3PAQT/
        usbomoYm0DECl8yqSVzLg+ZvybyiuFA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-A6A5wXPgPF2zA58ttn3wjA-1; Thu, 11 May 2023 04:13:31 -0400
X-MC-Unique: A6A5wXPgPF2zA58ttn3wjA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30635d18e55so2887841f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683792810; x=1686384810;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISts0ooOqDRfuZXF0qq5A4HD7E+tCGV5ujF6/xdMaMg=;
        b=CHZKjEH/EQiN59DdRpwpUpBsDPB3mIekdHJX1E4k/5/aYoSl/0nBxfEwC7LX9hupWr
         ZiWV2pSSDQJQ6hyxy009lHio2iYB1sx4E0SzHkQv41tqzSpMPXAXzTX6O+Qw8uEMtYP/
         5p0fLMt6D5sQyrlOxcSru/DRLxuhxcMGJ3emBLWC5zTpqwrETlCs1h5R47BxrAjbxroC
         IAh7ET2mc9QMEI6RMxRsY+grysOds1E20Akst5585l/0FQ/HIkm4Dn8pV1QMWFN4Mp4J
         pd+zpAfpY0yX0ImxWryRj8zIzZ9s5KmnHrTpf46MS9djtb52w98t8hiJLbWjbdJXwfc3
         EVnw==
X-Gm-Message-State: AC+VfDyJrFaKlEKeOO6Ib/49LUarxlKFSfGk0V/A7Z+Lq8tXFCou7n7b
        VLlC29YYTnw6oCKv6WZ/OQBu8w3LMbvqhC8Co4d4l4KiJHuBa1N5ib7Aa9uYyfeYk4g+rwlDgU9
        N0PTDawZFme44MBMXbkutXMbr
X-Received: by 2002:a5d:6ad2:0:b0:306:3b39:9a3d with SMTP id u18-20020a5d6ad2000000b003063b399a3dmr15181732wrw.15.1683792809977;
        Thu, 11 May 2023 01:13:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wzkHxXA98ZgAI5RK3TMyhcDtRnsVdn01Y5Ujktfp0w0cSPqr08X4KOya9osApYAYUFMqmaQ==
X-Received: by 2002:a5d:6ad2:0:b0:306:3b39:9a3d with SMTP id u18-20020a5d6ad2000000b003063b399a3dmr15181702wrw.15.1683792809674;
        Thu, 11 May 2023 01:13:29 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id y12-20020adffa4c000000b00306281cfa59sm19596655wrr.47.2023.05.11.01.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 01:13:29 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Leonardo =?utf-8?Q?Br=C3=A1s?= <leobras@redhat.com>,
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
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
In-Reply-To: <f96442e9166e4f73be772656a93c89093eddbb8b.camel@redhat.com>
References: <20230406075718.68672-1-leobras@redhat.com>
 <20230406095519.GG386572@hirez.programming.kicks-ass.net>
 <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
 <20230503145900.GC1689514@hirez.programming.kicks-ass.net>
 <xhsmh7ctojoia.mognet@vschneid.remote.csb>
 <f96442e9166e4f73be772656a93c89093eddbb8b.camel@redhat.com>
Date:   Thu, 11 May 2023 09:13:27 +0100
Message-ID: <xhsmhv8gzi8uw.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On 10/05/23 17:27, Leonardo Br=C3=A1s wrote:
> On Thu, 2023-05-04 at 12:59 +0100, Valentin Schneider wrote:
>> +TRACE_EVENT(csd_queue_cpu,
>> +
>> +	TP_PROTO(const unsigned int cpu,
>> +		 unsigned long callsite,
>> +		 smp_call_func_t func,
>> +		 call_single_data_t *csd),
>> +
>> +	TP_ARGS(cpu, callsite, func, csd),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(unsigned int, cpu)
>> +		__field(void *, callsite)
>> +		__field(void *, func)
>> +		__field(void *, csd)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->cpu =3D cpu;
>> +		__entry->callsite =3D (void *)callsite;
>> +		__entry->func =3D func;
>> +		__entry->csd  =3D csd;
>> +	),
>> +
>> +	TP_printk("cpu=3D%u callsite=3D%pS func=3D%pS csd=3D%p",
>> +		  __entry->cpu, __entry->callsite, __entry->func, __entry->csd)
>> +);
>
> This is for the caller side, right?
>

Yep, see usage lower down.

>> +
>> +DECLARE_EVENT_CLASS(csd_function,
>> +
>> +	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
>> +
>> +	TP_ARGS(func, csd),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(void *,	func)
>> +		__field(void *,	csd)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->func	=3D func;
>> +		__entry->csd	=3D csd;
>> +	),
>> +
>> +	TP_printk("func=3D%pS csd=3D%p", __entry->func, __entry->csd)
>> +);
>> +
>> +DEFINE_EVENT(csd_function, csd_function_entry,
>> +	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
>> +	TP_ARGS(func, csd)
>> +);
>> +
>> +DEFINE_EVENT(csd_function, csd_function_exit,
>> +	TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
>> +	TP_ARGS(func, csd)
>> +);
>
> Oh, this is what event_class is for. Thanks for the example :)
>
>> +
>> +#endif /* _TRACE_SMP_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index ab3e5dad6cfe9..7d28db303e9bc 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -27,6 +27,9 @@
>>  #include <linux/jump_label.h>
>>
>>  #include <trace/events/ipi.h>
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/smp.h>
>> +#undef CREATE_TRACE_POINTS
>>
>>  #include "smpboot.h"
>>  #include "sched/smp.h"
>> @@ -121,6 +124,14 @@ send_call_function_ipi_mask(struct cpumask *mask)
>>      arch_send_call_function_ipi_mask(mask);
>>  }
>>
>> +static __always_inline void
>> +csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd)
>> +{
>> +	trace_csd_function_entry(func, csd);
>> +	func(info);
>> +	trace_csd_function_exit(func, csd);
>> +}
>> +
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

There's also the special case of CSD_TYPE_TTWU where there is no csd->func,
instead we have an implicit func mapping to sched_ttwu_pending). I think
it's preferable to directly feed the right things to the TP than to
duplicate the "decoding" logic against the *csd passed as TP argument.

