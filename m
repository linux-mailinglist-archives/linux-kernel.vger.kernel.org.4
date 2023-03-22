Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D27F6C402D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjCVCLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCVCLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:11:05 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B9C57094
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:11:02 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i6so19499978ybu.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679451061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eUbqWA9KySMuyv5juifE3y+Fd59o9IFPcHGcsNfLgc=;
        b=ILsZZShT4Yy5mt5JwFt3JF8ziAM4JCZMdZiJ6v/YRzy8wJY8RiXuR76A7hKdHAquzL
         Ps4lN75OXpDJj9ASyq9zVqhiDzNusBjk6la5KaSCF6d0Ig2VTMeEvvuVMDevzV4jodid
         kaeJEhjeoXlPdmk2SXZI24CHMrifk7wFA/MEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679451061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eUbqWA9KySMuyv5juifE3y+Fd59o9IFPcHGcsNfLgc=;
        b=ge0QGWdR6+ZckEWC7WJtlt/an1g5FRlnBysSVb/BewvyZ4WG3Mxpiko+T1BJ5P5Rb/
         n6pOOzlDVyD6DZfesdIigDNV7t4iR9m/8lEUGnmK5kAA/7MwXGexJv2N/X5dXFnrbg+I
         X3pYrJNMdPSBpHn7WqEtIGkx9VWPqIC70iziGipG7Eh/VqZclIk17Wx3J8IvQoGuD8Kx
         Fh8fQwdwXKicq67Zd87d8P50/LRC2M0TP+I2+scwbnInxhPCiSFE1kUQu473qH/qXb1L
         vfZbSHbzurVUY/ZAVKpZl0YFX7mRZgqEkQ9rYLw6Pb9CscwkhMnr/AVGkgOBYDmMv6Mt
         4Tpg==
X-Gm-Message-State: AAQBX9cm0dbREMdfxYNOPnxYMyHajiJvm/QUzQFhL5+Sp3aYQm5AsePq
        Wj9E0ZWO/mbT0N2lKarU131upt6GbvJx/zzQbpuVCw==
X-Google-Smtp-Source: AKy350YvmzgayBwwvOO2gAU0wmzK2QncsJ9H1IvRjyQmdnAS4lGwe+sy10ZCn22hsqX4IMRyujzZPS7FzTkVFzkmqzI=
X-Received: by 2002:a05:6902:1890:b0:b6a:2590:6c7f with SMTP id
 cj16-20020a056902189000b00b6a25906c7fmr2602717ybb.2.1679451061266; Tue, 21
 Mar 2023 19:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230321215121.71b339c5@gandalf.local.home>
In-Reply-To: <20230321215121.71b339c5@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 21 Mar 2023 22:10:50 -0400
Message-ID: <CAEXW_YRjX8_jXD0W7AvEsJ+8AAOm1s9JzQEGU5bbg5ja+k6y4w@mail.gmail.com>
Subject: Re: [PATCH] tracing: Trace instrumentation begin and end
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ross Zwisler <zwisler@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 9:51=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> I do a lot of analysis on how much the kernel is interfering with user
> space and why. One measurement was to trace the length of page faults.
> That was done with:
>
>  trace-cmd start -p function_graph --max-graph_depth 1
>
> Which would produce output like:
>
>  3)   4.429 us    | __do_page_fault();
>  3)   8.208 us    | __do_page_fault();
>  3)   6.877 us    | __do_page_fault();
>  3)   + 10.033 us | __do_page_fault();
>  3)   8.013 us    | __do_page_fault();
>
> But now that entry into the kernel is all protected with noinstr, functio=
n
> graph tracing no longer catches entry into the kernel, and
> __do_page_fault() is no longer traced.
>
> Even trying just:
>
>  trace-cmd start -p function_graph --max-graph_depth 1 -e page_fault_user
>
> produces:
>
>  2)   0.764 us    |  exit_to_user_mode_prepare();
>  2)               |  /* page_fault_user: address=3D0x7fadaba40fd8 ip=3D0x=
7fadaba40fd8 error_code=3D0x14 */
>  2)   0.581 us    |  down_read_trylock();
>
> The "page_fault_user" event is not encapsulated around any function, whic=
h
> means it probably triggered and went back to user space without any trace
> to know how long that page fault took (the down_read_trylock() is likely =
to
> be part of the page fault function, but that's besides the point).
>
> To help bring back the old functionality, two trace points are added. One
> just after instrumentation begins, and one just before it ends. This way,
> we can see all the time that the kernel can do something meaningful, and =
we
> will trace it.
>
>  trace-cmd start -e instrumentation -e page_fault_user

One drawback is it requires the user to know about instrumentation.

I don't have an issue with the new instrumentation tracepoint but I
was wondering, since you have this specific usecase a lot, would it
not also be better to add a dedicated tracepoint to measure pagefault
time? And only collect the start timestamp if the tracepoint is
enabled.

Or even a pair of pagefault begin/end tracepoints and then one can go
create synthetic events on top to measure the time delta. :-P

thanks,

 - Joel


>
> produces:
>
>        trace-cmd-911     [001] d....  2616.730120: instrumentation_begin:=
 exc_page_fault+0x2e/0x250 <- asm_exc_page_fault+0x26/0x30
>        trace-cmd-911     [001] d....  2616.730121: page_fault_user: addre=
ss=3D0x7fcadc16ab70 ip=3D0x7fcadc16ab70 error_code=3D0x14
>        trace-cmd-911     [001] d....  2616.730137: instrumentation_end: e=
xc_page_fault+0x8d/0x250 <- asm_exc_page_fault+0x26/0x30
>
> The time between the instrumentation_begin and the instrumentation_end
> that has the page_fault_user can be considered the time the page fault
> took.
>
> To even make a histogram out of this, and using sqlhist to create
> synthetic events. A synthetic event can be used to join the
> instrumentation_begin with page_fault_user, and then another synthetic
> event can join that synthetic event to instrumentation_end, passing the
> timestamp between them.
>
>  sqlhist -e -n fault_start 'SELECT start.TIMESTAMP AS start_ts
>          FROM instrumentation_begin AS start JOIN page_fault_user AS end
>          ON start.common_pid =3D end.common_pid'
>
>  sqlhist -e -n fault_total 'SELECT (end.TIMESTAMP - start.start_ts) AS de=
lta
>          FROM fault_start AS start JOIN instrumentation_end AS end
>          ON start.common_pid =3D end.common_pid'
>
>  ># cd /sys/kernel/tracing
>  ># echo 'hist:keys=3Dip.sym-offset,pip.sys-offset,delta.buckets=3D20' > =
events/synthetic/fault_total/trigger
>  ># cat events/synthetic/fault_total/hist
>  # event histogram
>  #
>  # trigger info: hist:keys=3Dcommon_pid.execname,delta.buckets=3D2000:val=
s=3Dhitcount:sort=3Dcommon_pid.execname,delta.buckets=3D2000:size=3D2048 [a=
ctive]
>  #
>
>  { common_pid: systemd-journal [       250], delta: ~ 2000-3999 } hitcoun=
t:          7
>  { common_pid: systemd-journal [       250], delta: ~ 4000-5999 } hitcoun=
t:        153
>  { common_pid: systemd-journal [       250], delta: ~ 6000-7999 } hitcoun=
t:          7
>  { common_pid: systemd-journal [       250], delta: ~ 8000-9999 } hitcoun=
t:          1
>  { common_pid: systemd-journal [       250], delta: ~ 14000-15999 } hitco=
unt:          1
>  { common_pid: systemd-journal [       250], delta: ~ 16000-17999 } hitco=
unt:          1
>  { common_pid: systemd-journal [       250], delta: ~ 20000-21999 } hitco=
unt:          9
>  { common_pid: systemd-journal [       250], delta: ~ 22000-23999 } hitco=
unt:          5
>  { common_pid: systemd-journal [       250], delta: ~ 24000-25999 } hitco=
unt:          3
>  { common_pid: systemd-journal [       250], delta: ~ 42000-43999 } hitco=
unt:          2
>  { common_pid: systemd-journal [       250], delta: ~ 44000-45999 } hitco=
unt:          1
>  { common_pid: systemd-journal [       250], delta: ~ 52000-53999 } hitco=
unt:          1
>  { common_pid: systemd-journal [       250], delta: ~ 70000-71999 } hitco=
unt:          1
>  { common_pid: systemd-journal [       250], delta: ~ 74000-75999 } hitco=
unt:          1
>  { common_pid: systemd-journal [       250], delta: ~ 162000-163999 } hit=
count:          1
>  { common_pid: systemd-journal [       250], delta: ~ 172000-173999 } hit=
count:          1
>  { common_pid: NetworkManager  [       393], delta: ~ 10000-11999 } hitco=
unt:          1
>  { common_pid: NetworkManager  [       393], delta: ~ 30000-31999 } hitco=
unt:          1
>  { common_pid: exim4           [       719], delta: ~ 8000-9999 } hitcoun=
t:          1
>  { common_pid: exim4           [       719], delta: ~ 12000-13999 } hitco=
unt:          3
>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/instrumentation.h        | 34 ++++++++++++++++++++--
>  include/trace/events/instrumentation.h | 40 ++++++++++++++++++++++++++
>  kernel/trace/trace.c                   | 20 +++++++++++++
>  3 files changed, 92 insertions(+), 2 deletions(-)
>  create mode 100644 include/trace/events/instrumentation.h
>
> diff --git a/include/linux/instrumentation.h b/include/linux/instrumentat=
ion.h
> index bc7babe91b2e..f013acfc9192 100644
> --- a/include/linux/instrumentation.h
> +++ b/include/linux/instrumentation.h
> @@ -2,6 +2,34 @@
>  #ifndef __LINUX_INSTRUMENTATION_H
>  #define __LINUX_INSTRUMENTATION_H
>
> +#ifdef CONFIG_TRACING
> +#include <linux/kernel.h>
> +#include <linux/tracepoint-defs.h>
> +
> +void call_trace_instrumentation_begin(unsigned long ip, unsigned long pi=
p);
> +void call_trace_instrumentation_end(unsigned long ip, unsigned long pip)=
;
> +
> +DECLARE_TRACEPOINT(instrumentation_begin);
> +DECLARE_TRACEPOINT(instrumentation_end);
> +
> +static inline void do_trace_instrumentation_begin(unsigned long ip,
> +                                                 unsigned long pip)
> +{
> +       if (tracepoint_enabled(instrumentation_begin))
> +               call_trace_instrumentation_begin(ip, pip);
> +}
> +
> +static inline void do_trace_instrumentation_end(unsigned long ip,
> +                                               unsigned long pip)
> +{
> +       if (tracepoint_enabled(instrumentation_end))
> +               call_trace_instrumentation_end(ip, pip);
> +}
> +#else /* !CONFIG_TRACING */
> +static inline void do_trace_instrumentation_begin(unsigned long ip, unsi=
gned long pip) { }
> +static inline void do_trace_instrumentation_end(unsigned long ip, unsign=
ed long pip) { }
> +#endif /* CONFIG_TRACING */
> +
>  #ifdef CONFIG_NOINSTR_VALIDATION
>
>  #include <linux/stringify.h>
> @@ -12,6 +40,7 @@
>                      ".pushsection .discard.instr_begin\n\t"            \
>                      ".long " __stringify(c) "b - .\n\t"                \
>                      ".popsection\n\t" : : "i" (c));                    \
> +       do_trace_instrumentation_begin(_THIS_IP_, _RET_IP_);            \
>  })
>  #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
>
> @@ -47,6 +76,7 @@
>   * part of the condition block and does not escape.
>   */
>  #define __instrumentation_end(c) ({                                    \
> +       do_trace_instrumentation_end(_THIS_IP_, _RET_IP_);              \
>         asm volatile(__stringify(c) ": nop\n\t"                         \
>                      ".pushsection .discard.instr_end\n\t"              \
>                      ".long " __stringify(c) "b - .\n\t"                \
> @@ -54,8 +84,8 @@
>  })
>  #define instrumentation_end() __instrumentation_end(__COUNTER__)
>  #else /* !CONFIG_NOINSTR_VALIDATION */
> -# define instrumentation_begin()       do { } while(0)
> -# define instrumentation_end()         do { } while(0)
> +# define instrumentation_begin() do_trace_instrumentation_begin(_THIS_IP=
_, _RET_IP_);
> +# define instrumentation_end()  do_trace_instrumentation_end(_THIS_IP_, =
_RET_IP_);
>  #endif /* CONFIG_NOINSTR_VALIDATION */
>
>  #endif /* __LINUX_INSTRUMENTATION_H */
> diff --git a/include/trace/events/instrumentation.h b/include/trace/event=
s/instrumentation.h
> new file mode 100644
> index 000000000000..6b92a205d9ae
> --- /dev/null
> +++ b/include/trace/events/instrumentation.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM instrumentation
> +
> +#if !defined(_TRACE_INSTRUMENTATION_H) || defined(TRACE_HEADER_MULTI_REA=
D)
> +#define _TRACE_INSTRUMENTATION_H
> +
> +#include <linux/tracepoint.h>
> +
> +DECLARE_EVENT_CLASS(instrumentation_template,
> +
> +       TP_PROTO(unsigned long ip, unsigned long pip),
> +
> +       TP_ARGS(ip, pip),
> +
> +       TP_STRUCT__entry(
> +               __field( unsigned long,         ip )
> +               __field( unsigned long,         pip )
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->ip =3D ip;
> +               __entry->pip =3D pip;
> +       ),
> +
> +       TP_printk("%pS <- %pS", (void *)__entry->ip, (void *)__entry->pip=
)
> +);
> +
> +DEFINE_EVENT(instrumentation_template, instrumentation_begin,
> +            TP_PROTO(unsigned long ip, unsigned long pip),
> +            TP_ARGS(ip, pip));
> +
> +DEFINE_EVENT(instrumentation_template, instrumentation_end,
> +            TP_PROTO(unsigned long ip, unsigned long pip),
> +            TP_ARGS(ip, pip));
> +
> +#endif /* _TRACE_INSTRUMENTATION_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 937e9676dfd4..071885824408 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -54,6 +54,26 @@
>  #include "trace.h"
>  #include "trace_output.h"
>
> +/* Define instrumentation tracing here, as there is no real home for it =
*/
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/instrumentation.h>
> +#undef CREATE_TRACE_POINTS
> +
> +void call_trace_instrumentation_begin(unsigned long ip, unsigned long pi=
p)
> +{
> +       trace_instrumentation_begin(ip, pip);
> +}
> +EXPORT_SYMBOL_GPL(call_trace_instrumentation_begin);
> +
> +void call_trace_instrumentation_end(unsigned long ip, unsigned long pip)
> +{
> +       trace_instrumentation_end(ip, pip);
> +}
> +EXPORT_SYMBOL_GPL(call_trace_instrumentation_end);
> +
> +EXPORT_TRACEPOINT_SYMBOL_GPL(instrumentation_begin);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(instrumentation_end);
> +
>  /*
>   * On boot up, the ring buffer is set to the minimum size, so that
>   * we do not waste memory on systems that are not using tracing.
> --
> 2.39.1
>
