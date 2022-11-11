Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C43624EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiKKAey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiKKAew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:34:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85837678;
        Thu, 10 Nov 2022 16:34:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 834F0B822D7;
        Fri, 11 Nov 2022 00:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5DDC433D6;
        Fri, 11 Nov 2022 00:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668126889;
        bh=Ap1nvrhkIjs4qdg0qdCA2R2K/RdjZ1WeVKnB6c889EM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aCCwKaW+RrNixMTVePvLJyPPdmKGvTRaLcJBSTnm+oWhdzaTJjrLgjHx0AAHJlZhI
         2oXGe4O2N+lbub5sBykp/6Ye5Y3YW3mN8VuUNxzcO+2H5rzgZVlrXkEXJuMtJ6g35C
         T4QSBl1Za/R7rxr3EiVqsY8yY9tHAeb2LFDPxA8ai04T/qAjkv7trS36+QKfzERnCa
         5fDqd9mLoQYf/Cdto+A04C0N7lFtZ37TvuXXk3bGFtB9q0+3YmNqXpXomE30PyKqPS
         fRJSTsMyQzsnAQ6pjCNaFvkDF74Cr9te1MoSREEIl5IHSqx37TPK3lLY9yWgpYEkgZ
         2tBWsId633jIg==
Date:   Fri, 11 Nov 2022 09:34:45 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org,
        Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH v2] tracing: Dump instance traces into dmesg on
 ftrace_dump_on_oops
Message-Id: <20221111093445.e195afe799822d5a7ffbaca4@kernel.org>
In-Reply-To: <20221110175959.3240475-1-joel@joelfernandes.org>
References: <20221110175959.3240475-1-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 17:59:59 +0000
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> Currently ftrace only dumps the global trace buffer on an OOPs. For
> debugging a production usecase, I'd like to dump instance traces as
> well, into the kernel logs. The reason is we cannot use the global trace
> buffer as it may be used for other purposes.
> 
> This patch adds support for dumping the trace buffer instances along
> with the global trace buffer.
> 
> The instance traces are dumped first, and then the global trace buffer.
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Cc: Ross Zwisler <zwisler@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/trace/trace.c | 67 ++++++++++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 47a44b055a1d..2cc75497d6d3 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9914,12 +9914,12 @@ trace_printk_seq(struct trace_seq *s)
>  	trace_seq_init(s);
>  }
>  
> -void trace_init_global_iter(struct trace_iterator *iter)
> +void trace_init_iter_with_tr(struct trace_iterator *iter, struct trace_array *tr)
>  {
> -	iter->tr = &global_trace;
> +	iter->tr = tr;
>  	iter->trace = iter->tr->current_trace;
>  	iter->cpu_file = RING_BUFFER_ALL_CPUS;
> -	iter->array_buffer = &global_trace.array_buffer;
> +	iter->array_buffer = &tr->array_buffer;
>  
>  	if (iter->trace && iter->trace->open)
>  		iter->trace->open(iter);
> @@ -9939,36 +9939,14 @@ void trace_init_global_iter(struct trace_iterator *iter)
>  	iter->fmt_size = STATIC_FMT_BUF_SIZE;
>  }
>  
> -void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
> +void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode oops_dump_mode)
>  {
> -	/* use static because iter can be a bit big for the stack */
>  	static struct trace_iterator iter;
> -	static atomic_t dump_running;
> -	struct trace_array *tr = &global_trace;
>  	unsigned int old_userobj;
> -	unsigned long flags;
>  	int cnt = 0, cpu;
>  
> -	/* Only allow one dump user at a time. */
> -	if (atomic_inc_return(&dump_running) != 1) {
> -		atomic_dec(&dump_running);
> -		return;
> -	}
> -
> -	/*
> -	 * Always turn off tracing when we dump.
> -	 * We don't need to show trace output of what happens
> -	 * between multiple crashes.
> -	 *
> -	 * If the user does a sysrq-z, then they can re-enable
> -	 * tracing with echo 1 > tracing_on.
> -	 */
> -	tracing_off();
> -
> -	local_irq_save(flags);
> -
>  	/* Simulate the iterator */
> -	trace_init_global_iter(&iter);
> +	trace_init_iter_with_tr(&iter, tr);
>  
>  	for_each_tracing_cpu(cpu) {
>  		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
> @@ -9993,7 +9971,10 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
>  		iter.cpu_file = RING_BUFFER_ALL_CPUS;
>  	}
>  
> -	printk(KERN_TRACE "Dumping ftrace buffer:\n");
> +	if (tr == &global_trace)
> +		printk(KERN_TRACE "Dumping ftrace buffer:\n");
> +	else
> +		printk(KERN_TRACE "Dumping ftrace instance %s buffer:\n", tr->name);
>  
>  	/* Did function tracer already get disabled? */
>  	if (ftrace_is_dead()) {
> @@ -10041,6 +10022,36 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
>  	for_each_tracing_cpu(cpu) {
>  		atomic_dec(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
>  	}
> +}
> +
> +void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
> +{
> +	/* use static because iter can be a bit big for the stack */
> +	static atomic_t dump_running;
> +	struct trace_array *tr;
> +	unsigned long flags;
> +
> +	/* Only allow one dump user at a time. */
> +	if (atomic_inc_return(&dump_running) != 1) {
> +		atomic_dec(&dump_running);
> +		return;
> +	}
> +
> +	/*
> +	 * Always turn off tracing when we dump.
> +	 * We don't need to show trace output of what happens
> +	 * between multiple crashes.
> +	 *
> +	 * If the user does a sysrq-z, then they can re-enable
> +	 * tracing with echo 1 > tracing_on.
> +	 */
> +	tracing_off();
> +	local_irq_save(flags);
> +
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> +		ftrace_dump_one(tr, oops_dump_mode);
> +	}
> +
>  	atomic_dec(&dump_running);
>  	local_irq_restore(flags);
>  }
> -- 
> 2.38.1.493.g58b659f92b-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
