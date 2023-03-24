Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB66C7C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjCXKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjCXKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:05:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A003C1D904
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:04:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AF3E11FB;
        Fri, 24 Mar 2023 03:05:39 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.56.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8BC33F6C4;
        Fri, 24 Mar 2023 03:04:53 -0700 (PDT)
Date:   Fri, 24 Mar 2023 10:04:47 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] tracepoint: Fix CFI failures with tp_sub_func (v2)
Message-ID: <ZB11vw+U39WMA+Cr@FVFF77S0Q05N>
References: <20230323212832.5691-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323212832.5691-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:28:32PM -0400, Mathieu Desnoyers wrote:
> When CLANG_CFI is in use, using tracing will occasionally result in
> CFI failures, e.g.

> Avoid this by comparing the tracepoint function pointer to the value 1
> before calling each function.

> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>

Thanks for this!

This looks good to me, and in testing it solves the CFI failure, so FWIW:

Tested-by: Mark Rutland <mark.rutlnand@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  include/linux/tracepoint.h | 14 ++++++++++++--
>  kernel/tracepoint.c        | 20 +++++++-------------
>  2 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 4b33b95eb8be..0aeac249d412 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -33,6 +33,9 @@ struct trace_eval_map {
>  
>  #define TRACEPOINT_DEFAULT_PRIO	10
>  
> +/* Reserved value for tracepoint callback. */
> +#define TRACEPOINT_FUNC_SKIP	((void *) 0x1)
> +
>  extern struct srcu_struct tracepoint_srcu;
>  
>  extern int
> @@ -314,11 +317,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		it_func_ptr =						\
>  			rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
>  		if (it_func_ptr) {					\
> -			do {						\
> +			for (;;) {					\
>  				it_func = READ_ONCE((it_func_ptr)->func); \
> +				if ((uintptr_t) it_func <= (uintptr_t) TRACEPOINT_FUNC_SKIP) { \
> +					if (it_func == TRACEPOINT_FUNC_SKIP) \
> +						continue;		\
> +					else				\
> +						break;			\
> +				}					\
>  				__data = (it_func_ptr)->data;		\
>  				((void(*)(void *, proto))(it_func))(__data, args); \
> -			} while ((++it_func_ptr)->func);		\
> +				it_func_ptr++;				\
> +			}						\
>  		}							\
>  		return 0;						\
>  	}								\
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index f23144af5743..2fa108ddbbc2 100644
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
> @@ -193,8 +187,8 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
>  	if (old) {
>  		/* (N -> N+1), (N != 0, 1) probes */
>  		for (iter_probes = 0; old[iter_probes].func; iter_probes++) {
> -			if (old[iter_probes].func == tp_stub_func)
> -				continue;	/* Skip stub functions. */
> +			if (old[iter_probes].func == TRACEPOINT_FUNC_SKIP)
> +				continue;
>  			if (old[iter_probes].func == tp_func->func &&
>  			    old[iter_probes].data == tp_func->data)
>  				return ERR_PTR(-EEXIST);
> @@ -208,7 +202,7 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
>  	if (old) {
>  		nr_probes = 0;
>  		for (iter_probes = 0; old[iter_probes].func; iter_probes++) {
> -			if (old[iter_probes].func == tp_stub_func)
> +			if (old[iter_probes].func == TRACEPOINT_FUNC_SKIP)
>  				continue;
>  			/* Insert before probes of lower priority */
>  			if (pos < 0 && old[iter_probes].prio < prio)
> @@ -246,7 +240,7 @@ static void *func_remove(struct tracepoint_func **funcs,
>  		for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
>  			if ((old[nr_probes].func == tp_func->func &&
>  			     old[nr_probes].data == tp_func->data) ||
> -			    old[nr_probes].func == tp_stub_func)
> +			    old[nr_probes].func == TRACEPOINT_FUNC_SKIP)
>  				nr_del++;
>  		}
>  	}
> @@ -269,7 +263,7 @@ static void *func_remove(struct tracepoint_func **funcs,
>  			for (i = 0; old[i].func; i++) {
>  				if ((old[i].func != tp_func->func ||
>  				     old[i].data != tp_func->data) &&
> -				    old[i].func != tp_stub_func)
> +				    old[i].func != TRACEPOINT_FUNC_SKIP)
>  					new[j++] = old[i];
>  			}
>  			new[nr_probes - nr_del].func = NULL;
> @@ -277,12 +271,12 @@ static void *func_remove(struct tracepoint_func **funcs,
>  		} else {
>  			/*
>  			 * Failed to allocate, replace the old function
> -			 * with calls to tp_stub_func.
> +			 * with TRACEPOINT_FUNC_SKIP.
>  			 */
>  			for (i = 0; old[i].func; i++) {
>  				if (old[i].func == tp_func->func &&
>  				    old[i].data == tp_func->data)
> -					WRITE_ONCE(old[i].func, tp_stub_func);
> +					WRITE_ONCE(old[i].func, TRACEPOINT_FUNC_SKIP);
>  			}
>  			*funcs = old;
>  		}
> -- 
> 2.25.1
> 
