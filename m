Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677A66D5E84
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjDDLDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjDDLCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:02:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C68F540DE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:00:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 040A7C14;
        Tue,  4 Apr 2023 04:00:21 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.58.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18EEB3F6C4;
        Tue,  4 Apr 2023 03:59:34 -0700 (PDT)
Date:   Tue, 4 Apr 2023 11:59:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] tracepoint: Fix CFI failures with tp_sub_func
Message-ID: <ZCwDAnRHjNr9ZftR@FVFF77S0Q05N>
References: <20230324123142.7463-1-mathieu.desnoyers@efficios.com>
 <75dbeff6-fd0c-aec1-5821-919088eda6c4@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75dbeff6-fd0c-aec1-5821-919088eda6c4@efficios.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, Mar 24, 2023 at 08:33:35AM -0400, Mathieu Desnoyers wrote:
> On 2023-03-24 08:31, Mathieu Desnoyers wrote:
> > When CLANG_CFI is in use, using tracing will occasionally result in
> > CFI failures, e.g.
> > 
> > | CFI failure at syscall_trace_enter+0x66c/0x7d0 (target: tp_stub_func+0x0/0x2c; expected type: 0x4877830c)
> > | Internal error: Oops - CFI: 00000000f200823a [#1] PREEMPT SMP
> > | CPU: 2 PID: 118 Comm: klogd Not tainted 6.3.0-rc3-00002-gc242ea6f2f98 #2
> > | Hardware name: linux,dummy-virt (DT)
> > | pstate: 30400005 (nzCV daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > | pc : syscall_trace_enter+0x66c/0x7d0
> > | lr : syscall_trace_enter+0x5e8/0x7d0
> > | sp : ffff800015ce7d80
> > | x29: ffff800015ce7d80 x28: ffff000017538000 x27: 0000000000000003
> > | x26: ffff8000084c9454 x25: ffff00001182bd10 x24: dfff800000000000
> > | x23: 1fffe00002ea7001 x22: ffff00001182bd10 x21: ffff000017538008
> > | x20: ffff000017538000 x19: ffff800015ce7eb0 x18: 0000000000000000
> > | x17: 000000004877830c x16: 00000000a540670c x15: 0000000000000000
> > | x14: 0000000000000000 x13: 0000000000000000 x12: ff80800008039d8c
> > | x11: ff80800008039dd0 x10: 0000000000000000 x9 : 0000000000000000
> > | x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > | x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > | x2 : 00000000000000ce x1 : ffff800015ce7eb0 x0 : ffff800013d55000
> > | Call trace:
> > |  syscall_trace_enter+0x66c/0x7d0
> > |  el0_svc_common+0x1dc/0x268
> > |  do_el0_svc+0x70/0x1a4
> > |  el0_svc+0x58/0x14c
> > |  el0t_64_sync_handler+0x84/0xf0
> > |  el0t_64_sync+0x190/0x194
> > | Code: 72906191 72a90ef1 6b11021f 54000040 (d4304740)
> > | ---[ end trace 0000000000000000 ]---
> > 
> > This happens because the function prototype of tp_sub_func doesn't match
> > the prototype of the tracepoint function. As each tracepoint may have a
> > distinct prototype, it's not possible to share a common stub function.
> > 
> > Avoid this by comparing the tracepoint function pointer to the value 1
> > before calling each function.

[...]

> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Tested-by: Mark Rutland <mark.rutlnand@arm.com>
> 
> It appears there was a typo in this Tested-by address from Mark. Steven,
> should I resend or can you correct this as you pick it up ?

Sorry to ping, but are you planning to pick this up, and/or did you want this
resent with the Testing-by typo fixed?

I couldn't spot it in the tracing tree, and I'm not sure if it's still on your
TODO list for review or has just been missed.

Thanks,
Mark.

> 
> Thanks,
> 
> Mathieu
> 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Jose E. Marchesi <jose.marchesi@oracle.com>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > ---
> > Changes since v2:
> > - Fix typo in commit message.
> > - Add acked-by, tested-by.
> > ---
> >   include/linux/tracepoint.h | 14 ++++++++++++--
> >   kernel/tracepoint.c        | 20 +++++++-------------
> >   2 files changed, 19 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 4b33b95eb8be..0aeac249d412 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -33,6 +33,9 @@ struct trace_eval_map {
> >   #define TRACEPOINT_DEFAULT_PRIO	10
> > +/* Reserved value for tracepoint callback. */
> > +#define TRACEPOINT_FUNC_SKIP	((void *) 0x1)
> > +
> >   extern struct srcu_struct tracepoint_srcu;
> >   extern int
> > @@ -314,11 +317,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >   		it_func_ptr =						\
> >   			rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
> >   		if (it_func_ptr) {					\
> > -			do {						\
> > +			for (;;) {					\
> >   				it_func = READ_ONCE((it_func_ptr)->func); \
> > +				if ((uintptr_t) it_func <= (uintptr_t) TRACEPOINT_FUNC_SKIP) { \
> > +					if (it_func == TRACEPOINT_FUNC_SKIP) \
> > +						continue;		\
> > +					else				\
> > +						break;			\
> > +				}					\
> >   				__data = (it_func_ptr)->data;		\
> >   				((void(*)(void *, proto))(it_func))(__data, args); \
> > -			} while ((++it_func_ptr)->func);		\
> > +				it_func_ptr++;				\
> > +			}						\
> >   		}							\
> >   		return 0;						\
> >   	}								\
> > diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> > index f23144af5743..2fa108ddbbc2 100644
> > --- a/kernel/tracepoint.c
> > +++ b/kernel/tracepoint.c
> > @@ -98,12 +98,6 @@ struct tp_probes {
> >   	struct tracepoint_func probes[];
> >   };
> > -/* Called in removal of a func but failed to allocate a new tp_funcs */
> > -static void tp_stub_func(void)
> > -{
> > -	return;
> > -}
> > -
> >   static inline void *allocate_probes(int count)
> >   {
> >   	struct tp_probes *p  = kmalloc(struct_size(p, probes, count),
> > @@ -193,8 +187,8 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
> >   	if (old) {
> >   		/* (N -> N+1), (N != 0, 1) probes */
> >   		for (iter_probes = 0; old[iter_probes].func; iter_probes++) {
> > -			if (old[iter_probes].func == tp_stub_func)
> > -				continue;	/* Skip stub functions. */
> > +			if (old[iter_probes].func == TRACEPOINT_FUNC_SKIP)
> > +				continue;
> >   			if (old[iter_probes].func == tp_func->func &&
> >   			    old[iter_probes].data == tp_func->data)
> >   				return ERR_PTR(-EEXIST);
> > @@ -208,7 +202,7 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
> >   	if (old) {
> >   		nr_probes = 0;
> >   		for (iter_probes = 0; old[iter_probes].func; iter_probes++) {
> > -			if (old[iter_probes].func == tp_stub_func)
> > +			if (old[iter_probes].func == TRACEPOINT_FUNC_SKIP)
> >   				continue;
> >   			/* Insert before probes of lower priority */
> >   			if (pos < 0 && old[iter_probes].prio < prio)
> > @@ -246,7 +240,7 @@ static void *func_remove(struct tracepoint_func **funcs,
> >   		for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
> >   			if ((old[nr_probes].func == tp_func->func &&
> >   			     old[nr_probes].data == tp_func->data) ||
> > -			    old[nr_probes].func == tp_stub_func)
> > +			    old[nr_probes].func == TRACEPOINT_FUNC_SKIP)
> >   				nr_del++;
> >   		}
> >   	}
> > @@ -269,7 +263,7 @@ static void *func_remove(struct tracepoint_func **funcs,
> >   			for (i = 0; old[i].func; i++) {
> >   				if ((old[i].func != tp_func->func ||
> >   				     old[i].data != tp_func->data) &&
> > -				    old[i].func != tp_stub_func)
> > +				    old[i].func != TRACEPOINT_FUNC_SKIP)
> >   					new[j++] = old[i];
> >   			}
> >   			new[nr_probes - nr_del].func = NULL;
> > @@ -277,12 +271,12 @@ static void *func_remove(struct tracepoint_func **funcs,
> >   		} else {
> >   			/*
> >   			 * Failed to allocate, replace the old function
> > -			 * with calls to tp_stub_func.
> > +			 * with TRACEPOINT_FUNC_SKIP.
> >   			 */
> >   			for (i = 0; old[i].func; i++) {
> >   				if (old[i].func == tp_func->func &&
> >   				    old[i].data == tp_func->data)
> > -					WRITE_ONCE(old[i].func, tp_stub_func);
> > +					WRITE_ONCE(old[i].func, TRACEPOINT_FUNC_SKIP);
> >   			}
> >   			*funcs = old;
> >   		}
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
