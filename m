Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4395D6C68E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjCWMxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCWMx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:53:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB45DD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13D92B820F7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB01C433EF;
        Thu, 23 Mar 2023 12:53:24 +0000 (UTC)
Date:   Thu, 23 Mar 2023 08:53:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] tracepoint: Fix CFI failures with tp_stub_func
Message-ID: <20230323085321.0f8d1b98@gandalf.local.home>
In-Reply-To: <20230323114012.2162285-1-mark.rutland@arm.com>
References: <20230323114012.2162285-1-mark.rutland@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 11:40:12 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> When CLANG_CFI is in use, using tracing will occasionally result in
> CFI failures, e.g.
> 
> | CFI failure at syscall_trace_enter+0x66c/0x7d0 (target: tp_stub_func+0x0/0x2c; expected type: 0x4877830c)
> | Internal error: Oops - CFI: 00000000f200823a [#1] PREEMPT SMP
> | CPU: 2 PID: 118 Comm: klogd Not tainted 6.3.0-rc3-00002-gc242ea6f2f98 #2
> | Hardware name: linux,dummy-virt (DT)
> | pstate: 30400005 (nzCV daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> | pc : syscall_trace_enter+0x66c/0x7d0
> | lr : syscall_trace_enter+0x5e8/0x7d0
> | sp : ffff800015ce7d80
> | x29: ffff800015ce7d80 x28: ffff000017538000 x27: 0000000000000003
> | x26: ffff8000084c9454 x25: ffff00001182bd10 x24: dfff800000000000
> | x23: 1fffe00002ea7001 x22: ffff00001182bd10 x21: ffff000017538008
> | x20: ffff000017538000 x19: ffff800015ce7eb0 x18: 0000000000000000
> | x17: 000000004877830c x16: 00000000a540670c x15: 0000000000000000
> | x14: 0000000000000000 x13: 0000000000000000 x12: ff80800008039d8c
> | x11: ff80800008039dd0 x10: 0000000000000000 x9 : 0000000000000000
> | x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> | x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> | x2 : 00000000000000ce x1 : ffff800015ce7eb0 x0 : ffff800013d55000
> | Call trace:
> |  syscall_trace_enter+0x66c/0x7d0
> |  el0_svc_common+0x1dc/0x268
> |  do_el0_svc+0x70/0x1a4
> |  el0_svc+0x58/0x14c
> |  el0t_64_sync_handler+0x84/0xf0
> |  el0t_64_sync+0x190/0x194
> | Code: 72906191 72a90ef1 6b11021f 54000040 (d4304740)
> | ---[ end trace 0000000000000000 ]---
> 
> This happens because the function prototype of tp_sub_func doesn't match
> the prototype of the tracepoint function. As each tracepoint may have a
> distinct prototype, it's not possible to share a common stub function.

I hate C!

> 
> Avoid this by creating a stub function for each tracepoint with the
> correct prototype, and using these rather than tp_stub_func.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org
> ---
>  include/linux/tracepoint-defs.h |  1 +
>  include/linux/tracepoint.h      |  5 +++++
>  kernel/tracepoint.c             | 31 ++++++++++++++-----------------
>  3 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> index e7c2276be33eb..a306ac7255220 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -35,6 +35,7 @@ struct tracepoint {
>  	struct static_call_key *static_call_key;
>  	void *static_call_tramp;
>  	void *iterator;
> +	void *stub;
>  	int (*regfunc)(void);
>  	void (*unregfunc)(void);
>  	struct tracepoint_func __rcu *funcs;
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 6811e43c1b5c2..1640926441910 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -303,6 +303,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	__section("__tracepoints_strings") = #_name;			\
>  	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
>  	int __traceiter_##_name(void *__data, proto);			\
> +	void __tracestub_##_name(void *, proto);			\
>  	struct tracepoint __tracepoint_##_name	__used			\
>  	__section("__tracepoints") = {					\
>  		.name = __tpstrtab_##_name,				\
> @@ -310,6 +311,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		.static_call_key = &STATIC_CALL_KEY(tp_func_##_name),	\
>  		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
>  		.iterator = &__traceiter_##_name,			\
> +		.stub = &__tracestub_##_name,				\
>  		.regfunc = _reg,					\
>  		.unregfunc = _unreg,					\
>  		.funcs = NULL };					\
> @@ -330,6 +332,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		}							\
>  		return 0;						\
>  	}								\
> +	void __tracestub_##_name(void *__data, proto)			\
> +	{								\
> +	}								\

I purposely did not do this because this adds over a thousand stub
functions! It adds one for *every* tracepoint (and that is a superset of
trace events).

Is there some other way we could do this?

C really really needs a way to make a generic void do_nothing(...) function!

I added some compiler folks to the Cc to hear our grievances.

-- Steve


>  	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
>  
>  #define DEFINE_TRACE(name, proto, args)		\
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 8d1507dd07246..d9186629a0095 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -98,12 +98,6 @@ struct tp_probes {
>  	struct tracepoint_func probes[];
>  };
>  
> -/* Called in removal of a func but failed to allocate a new tp_funcs */
> -static void tp_stub_func(void)
> -{
> -	return;
> -}
> -
>  static inline void *allocate_probes(int count)
>  {
>  	struct tp_probes *p  = kmalloc(struct_size(p, probes, count),
> @@ -177,13 +171,15 @@ static void debug_print_probes(struct tracepoint_func *funcs)
>  }
>  
>  static struct tracepoint_func *
> -func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
> +func_add(struct tracepoint *tp, struct tracepoint_func **funcs,
> +	 struct tracepoint_func *tp_func,
>  	 int prio)
>  {
>  	struct tracepoint_func *old, *new;
>  	int iter_probes;	/* Iterate over old probe array. */
>  	int nr_probes = 0;	/* Counter for probes */
>  	int pos = -1;		/* Insertion position into new array */
> +	void *stub_func = tp->stub;
>  
>  	if (WARN_ON(!tp_func->func))
>  		return ERR_PTR(-EINVAL);
> @@ -193,7 +189,7 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
>  	if (old) {
>  		/* (N -> N+1), (N != 0, 1) probes */
>  		for (iter_probes = 0; old[iter_probes].func; iter_probes++) {
> -			if (old[iter_probes].func == tp_stub_func)
> +			if (old[iter_probes].func == stub_func)
>  				continue;	/* Skip stub functions. */
>  			if (old[iter_probes].func == tp_func->func &&
>  			    old[iter_probes].data == tp_func->data)
> @@ -208,7 +204,7 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
>  	if (old) {
>  		nr_probes = 0;
>  		for (iter_probes = 0; old[iter_probes].func; iter_probes++) {
> -			if (old[iter_probes].func == tp_stub_func)
> +			if (old[iter_probes].func == stub_func)
>  				continue;
>  			/* Insert before probes of lower priority */
>  			if (pos < 0 && old[iter_probes].prio < prio)
> @@ -229,11 +225,12 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
>  	return old;
>  }
>  
> -static void *func_remove(struct tracepoint_func **funcs,
> -		struct tracepoint_func *tp_func)
> +static void *func_remove(struct tracepoint *tp, struct tracepoint_func **funcs,
> +			 struct tracepoint_func *tp_func)
>  {
>  	int nr_probes = 0, nr_del = 0, i;
>  	struct tracepoint_func *old, *new;
> +	void *stub_func = tp->stub;
>  
>  	old = *funcs;
>  
> @@ -246,7 +243,7 @@ static void *func_remove(struct tracepoint_func **funcs,
>  		for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
>  			if ((old[nr_probes].func == tp_func->func &&
>  			     old[nr_probes].data == tp_func->data) ||
> -			    old[nr_probes].func == tp_stub_func)
> +			    old[nr_probes].func == stub_func)
>  				nr_del++;
>  		}
>  	}
> @@ -269,7 +266,7 @@ static void *func_remove(struct tracepoint_func **funcs,
>  			for (i = 0; old[i].func; i++) {
>  				if ((old[i].func != tp_func->func ||
>  				     old[i].data != tp_func->data) &&
> -				    old[i].func != tp_stub_func)
> +				    old[i].func != stub_func)
>  					new[j++] = old[i];
>  			}
>  			new[nr_probes - nr_del].func = NULL;
> @@ -277,12 +274,12 @@ static void *func_remove(struct tracepoint_func **funcs,
>  		} else {
>  			/*
>  			 * Failed to allocate, replace the old function
> -			 * with calls to tp_stub_func.
> +			 * with calls to stub_func.
>  			 */
>  			for (i = 0; old[i].func; i++) {
>  				if (old[i].func == tp_func->func &&
>  				    old[i].data == tp_func->data)
> -					WRITE_ONCE(old[i].func, tp_stub_func);
> +					WRITE_ONCE(old[i].func, stub_func);
>  			}
>  			*funcs = old;
>  		}
> @@ -335,7 +332,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
>  
>  	tp_funcs = rcu_dereference_protected(tp->funcs,
>  			lockdep_is_held(&tracepoints_mutex));
> -	old = func_add(&tp_funcs, func, prio);
> +	old = func_add(tp, &tp_funcs, func, prio);
>  	if (IS_ERR(old)) {
>  		WARN_ON_ONCE(warn && PTR_ERR(old) != -ENOMEM);
>  		return PTR_ERR(old);
> @@ -400,7 +397,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>  
>  	tp_funcs = rcu_dereference_protected(tp->funcs,
>  			lockdep_is_held(&tracepoints_mutex));
> -	old = func_remove(&tp_funcs, func);
> +	old = func_remove(tp, &tp_funcs, func);
>  	if (WARN_ON_ONCE(IS_ERR(old)))
>  		return PTR_ERR(old);
>  

