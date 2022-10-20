Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823B0606322
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJTOd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJTOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:33:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC67FD9E;
        Thu, 20 Oct 2022 07:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58EFAB82766;
        Thu, 20 Oct 2022 14:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39ECC433D6;
        Thu, 20 Oct 2022 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666276403;
        bh=6mym10teQuN4RdAoDKG6aI/Q3eXFIC/UAf7HvukRKgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fz8aiveQ8EMFN8cNU+wrwGl7oE3/qnT8bx89nHJ9KGomTYkUHLO21LZ+t9pBjxGI+
         ZxRWfee6ju/dDu3zPpPusbmcRtQrZNueQIsJ2x708fe204bSlWTyr8Th1tdvSNmAfn
         4mdN7vhhXnsG2g7nRn3I68KBqrbaS2hJB/LD52/1PDfMJHfax0DqAr9CnJN2c19CaR
         wKwm/W/PyXuIdCanxo3ECCY5+FdgEitYL93DGN/6y/z3U3+nKnG7X0b9ZBgE0VTpF8
         ZDEQciyFETWIEEv99EL2uLKjEhDIEhbrH4nIIXPJJDJCXvXaumdAFl/9E0W3+ckHGH
         FqG9gWF9dkXiw==
Date:   Thu, 20 Oct 2022 23:33:18 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Add trace_trigger kernel command line option
Message-Id: <20221020233318.aa41f0b5bb123c87af881316@kernel.org>
In-Reply-To: <20221019200137.70343645@gandalf.local.home>
References: <20221019200137.70343645@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 20:01:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Allow triggers to be enabled at kernel boot up. For example:
> 
>   trace_trigger="sched_switch.stacktrace if prev_state == 2"
> 
> The above will enable the stacktrace trigger on top of the sched_switch
> event and only trigger if its prev_state is 2 (TASK_UNINTERRUPTIBLE). Then
> at boot up, a stacktrace will trigger and be recorded in the tracing ring
> buffer every time the sched_switch happens where the previous state is
> TASK_INTERRUPTIBLE.
> 
> As this calls into tracepoint logic during very early boot (before
> interrupts are enabled), a check has to be done to see if early boot
> interrupts are still disabled, and if so, avoid any call to RCU
> synchronization, as that will enable interrupts and cause boot up issues.

Just out of curiousity, can you do it by boot-time tracer?
(Is it too late for your issue?)

$ cat >> stacktrace.bconf
ftrace.event.sched.sched_switch.actions = "stacktrace if prev_state == 2"
^D
$ bootconfig -a stacktrace.bconf initrd.img

And boot kernel with "bootconfig".
Then, 

----------
            init-1       [000] d..3.     0.546668: <stack trace>
 => trace_event_raw_event_sched_switch
 => __traceiter_sched_switch
 => __schedule
 => schedule
 => schedule_timeout
 => wait_for_completion_killable
 => __kthread_create_on_node
 => kthread_create_on_node
 => audit_init
 => do_one_initcall
 => kernel_init_freeable
 => kernel_init
 => ret_from_fork
         kauditd-57      [007] d..3.     0.546677: <stack trace>
 => trace_event_raw_event_sched_switch
 => __traceiter_sched_switch
 => __schedule
 => schedule
 => schedule_preempt_disabled
 => kthread
 => ret_from_fork
----------

Thank you,

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../admin-guide/kernel-parameters.txt         | 19 ++++++
>  include/linux/tracepoint.h                    |  4 ++
>  kernel/trace/trace.c                          |  3 +-
>  kernel/trace/trace_events.c                   | 63 ++++++++++++++++++-
>  kernel/tracepoint.c                           |  6 ++
>  5 files changed, 92 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a465d5242774..ccf91a4bf113 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6257,6 +6257,25 @@
>  			See also Documentation/trace/ftrace.rst "trace options"
>  			section.
>  
> +	trace_trigger=[trigger-list]
> +			[FTRACE] Add a event trigger on specific events.
> +			Set a trigger on top of a specific event, with an optional
> +			filter.
> +
> +			The format is is "trace_trigger=<event>.<trigger>[ if <filter>],..."
> +			Where more than one trigger may be specified that are comma deliminated.
> +
> +			For example:
> +
> +			  trace_trigger="sched_switch.stacktrace if prev_state == 2"
> +
> +			The above will enable the "stacktrace" trigger on the "sched_switch"
> +			event but only trigger it if the "prev_state" of the "sched_switch"
> +			event is "2" (TASK_UNINTERUPTIBLE).
> +
> +			See also "Event triggers" in Documentation/trace/events.rst
> +
> +
>  	traceoff_on_warning
>  			[FTRACE] enable this option to disable tracing when a
>  			warning is hit. This turns off "tracing_on". Tracing can
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 4b33b95eb8be..a5c6b5772897 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -90,6 +90,10 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
>  #ifdef CONFIG_TRACEPOINTS
>  static inline void tracepoint_synchronize_unregister(void)
>  {
> +	/* Early updates do not need synchronization */
> +	if (early_boot_irqs_disabled)
> +		return;
> +
>  	synchronize_srcu(&tracepoint_srcu);
>  	synchronize_rcu();
>  }
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 47a44b055a1d..c03fd7037add 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2749,7 +2749,8 @@ void trace_buffered_event_disable(void)
>  	preempt_enable();
>  
>  	/* Wait for all current users to finish */
> -	synchronize_rcu();
> +	if (!early_boot_irqs_disabled)
> +		synchronize_rcu();
>  
>  	for_each_tracing_cpu(cpu) {
>  		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 0356cae0cf74..06554939252c 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2796,6 +2796,44 @@ trace_create_new_event(struct trace_event_call *call,
>  	return file;
>  }
>  
> +#ifdef CONFIG_HIST_TRIGGERS
> +#define MAX_BOOT_TRIGGERS 32
> +
> +static struct boot_triggers {
> +	const char		*event;
> +	char			*trigger;
> +} bootup_triggers[MAX_BOOT_TRIGGERS];
> +
> +static char bootup_trigger_buf[COMMAND_LINE_SIZE];
> +static int nr_boot_triggers;
> +
> +static __init int setup_trace_triggers(char *str)
> +{
> +	char *trigger;
> +	char *buf;
> +	int i;
> +
> +	strlcpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
> +	ring_buffer_expanded = true;
> +	disable_tracing_selftest("running event triggers");
> +
> +	buf = bootup_trigger_buf;
> +	for (i = 0; i < MAX_BOOT_TRIGGERS; i++) {
> +		trigger = strsep(&buf, ",");
> +		if (!trigger)
> +			break;
> +		bootup_triggers[i].event = strsep(&trigger, ".");
> +		bootup_triggers[i].trigger = strsep(&trigger, ".");
> +		if (!bootup_triggers[i].trigger)
> +			break;
> +	}
> +
> +	nr_boot_triggers = i;
> +	return 1;
> +}
> +__setup("trace_trigger=", setup_trace_triggers);
> +#endif
> +
>  /* Add an event to a trace directory */
>  static int
>  __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
> @@ -2822,12 +2860,32 @@ __trace_early_add_new_event(struct trace_event_call *call,
>  			    struct trace_array *tr)
>  {
>  	struct trace_event_file *file;
> +	int ret;
> +	int i;
>  
>  	file = trace_create_new_event(call, tr);
>  	if (!file)
>  		return -ENOMEM;
>  
> -	return event_define_fields(call);
> +	ret = event_define_fields(call);
> +	if (ret)
> +		return ret;
> +
> +#ifdef CONFIG_HIST_TRIGGERS
> +	for (i = 0; i < nr_boot_triggers; i++) {
> +		if (strcmp(trace_event_name(call), bootup_triggers[i].event))
> +			continue;
> +		mutex_lock(&event_mutex);
> +		ret = trigger_process_regex(file, bootup_triggers[i].trigger);
> +		mutex_unlock(&event_mutex);
> +		if (ret)
> +			pr_err("Failed to register trigger '%s' on event %s\n",
> +			       bootup_triggers[i].trigger,
> +			       bootup_triggers[i].event);
> +	}
> +#endif
> +
> +	return 0;
>  }
>  
>  struct ftrace_module_file_ops;
> @@ -3726,6 +3784,8 @@ static __init int event_trace_enable(void)
>  			list_add(&call->list, &ftrace_events);
>  	}
>  
> +	register_trigger_cmds();
> +
>  	/*
>  	 * We need the top trace array to have a working set of trace
>  	 * points at early init, before the debug files and directories
> @@ -3740,7 +3800,6 @@ static __init int event_trace_enable(void)
>  
>  	register_event_cmds();
>  
> -	register_trigger_cmds();
>  
>  	return 0;
>  }
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index f23144af5743..f6e4ee1e40b3 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -48,6 +48,9 @@ static void tp_rcu_get_state(enum tp_transition_sync sync)
>  {
>  	struct tp_transition_snapshot *snapshot = &tp_transition_snapshot[sync];
>  
> +	if (early_boot_irqs_disabled)
> +		return;
> +
>  	/* Keep the latest get_state snapshot. */
>  	snapshot->rcu = get_state_synchronize_rcu();
>  	snapshot->srcu = start_poll_synchronize_srcu(&tracepoint_srcu);
> @@ -58,6 +61,9 @@ static void tp_rcu_cond_sync(enum tp_transition_sync sync)
>  {
>  	struct tp_transition_snapshot *snapshot = &tp_transition_snapshot[sync];
>  
> +	if (early_boot_irqs_disabled)
> +		return;
> +
>  	if (!snapshot->ongoing)
>  		return;
>  	cond_synchronize_rcu(snapshot->rcu);
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
