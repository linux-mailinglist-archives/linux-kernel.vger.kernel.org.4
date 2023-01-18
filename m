Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA82B672B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjARWnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjARWni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:43:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D655EF81;
        Wed, 18 Jan 2023 14:43:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B76AB61A81;
        Wed, 18 Jan 2023 22:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7047DC433EF;
        Wed, 18 Jan 2023 22:43:35 +0000 (UTC)
Date:   Wed, 18 Jan 2023 17:43:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 9/9] tracing/probes: Add fprobe-events
Message-ID: <20230118174333.3b301d2e@gandalf.local.home>
In-Reply-To: <166792263423.919356.14181339761424544980.stgit@devnote3>
References: <166792255429.919356.14116090269057513181.stgit@devnote3>
        <166792263423.919356.14181339761424544980.stgit@devnote3>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Nov 2022 00:50:34 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add fprobe events for tracing function entry and exit.
> 
> The fprobe event is a new dynamic events which is only for the
> function (symbol) entry and exit. This event accepts non
> register fetch arguments so that user can trace the function
> arguments and return values.
> 
> The fprobe events syntax is here;
> 
>  f[:[GRP/][EVENT]] FUNCTION [FETCHARGS]
>  f[MAXACTIVE][:[GRP/][EVENT]] FUNCTION%return [FETCHARGS]
> 
> E.g.
> 
>  # echo 'f vfs_read $arg1'  >> dynamic_events
>  # echo 'f vfs_read%return $retval'  >> dynamic_events
>  # cat dynamic_events
>  f:fprobes/vfs_read_entry vfs_read arg1=$arg1
>  f:fprobes/vfs_read_exit vfs_read%return arg1=$retval
>  # echo 1 > events/fprobes/enable

So what exactly is the advantage of this over a normal kprobe event?

Less overhead?

>  # head -n 20 trace | tail
>  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>  #              | |         |   |||||     |         |
>               sh-142     [005] ...1.   448.386420: vfs_read_entry: (vfs_read+0x4/0x340) arg1=0xffff888007f7c540
>               sh-142     [005] .....   448.386436: vfs_read_exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
>               sh-142     [005] ...1.   448.386451: vfs_read_entry: (vfs_read+0x4/0x340) arg1=0xffff888007f7c540
>               sh-142     [005] .....   448.386458: vfs_read_exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
>               sh-142     [005] ...1.   448.386469: vfs_read_entry: (vfs_read+0x4/0x340) arg1=0xffff888007f7c540
>               sh-142     [005] .....   448.386476: vfs_read_exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
>               sh-142     [005] ...1.   448.602073: vfs_read_entry: (vfs_read+0x4/0x340) arg1=0xffff888007f7c540
>               sh-142     [005] .....   448.602089: vfs_read_exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
> 
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> 


> +static int __trace_fprobe_create(int argc, const char *argv[])
> +{
> +	/*
> +	 * Argument syntax:
> +	 *  - Add fentry probe:
> +	 *      f[:[GRP/][EVENT]] [MOD:]KSYM [FETCHARGS]
> +	 *  - Add fexit probe:
> +	 *      f[N][:[GRP/][EVENT]] [MOD:]KSYM%return [FETCHARGS]
> +	 *
> +	 * Fetch args:
> +	 *  $retval	: fetch return value
> +	 *  $stack	: fetch stack address
> +	 *  $stackN	: fetch Nth entry of stack (N:0-)
> +	 *  $argN	: fetch Nth argument (N:1-)
> +	 *  $comm       : fetch current task comm
> +	 *  @ADDR	: fetch memory at ADDR (ADDR should be in kernel)
> +	 *  @SYM[+|-offs] : fetch memory at SYM +|- offs (SYM is a data symbol)
> +	 * Dereferencing memory fetch:
> +	 *  +|-offs(ARG) : fetch memory at ARG +|- offs address.
> +	 * Alias name of args:
> +	 *  NAME=FETCHARG : set NAME as alias of FETCHARG.
> +	 * Type of args:
> +	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
> +	 */
> +	struct trace_fprobe *tf = NULL;
> +	int i, len, ret = 0;
> +	bool is_return = false;
> +	char *symbol = NULL, *tmp = NULL;
> +	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
> +	int maxactive = 0;
> +	char buf[MAX_EVENT_NAME_LEN];
> +	char gbuf[MAX_EVENT_NAME_LEN];
> +	unsigned int flags = TPARG_FL_KERNEL;
> +

To make it easier to understand, I would add:

	char *first = argv[0];
	char *second = argv[1];

And then you could have:

	if (first[0] != 'f' || argc < 2)

Which is easier to read.

> +	if (argv[0][0] != 'f' || argc < 2)
> +		return -ECANCELED;
> +
> +	trace_probe_log_init("trace_fprobe", argc, argv);
> +
> +	event = strchr(&argv[0][1], ':');
> +	if (event)
> +		event++;
> +
> +	if (isdigit(argv[0][1])) {

	if (isdigit(second[1])) {

Or some other name that is perhaps more understandable.

-- Steve

> +		if (event)
> +			len = event - &argv[0][1] - 1;
> +		else
> +			len = strlen(&argv[0][1]);
> +		if (len > MAX_EVENT_NAME_LEN - 1) {
> +			trace_probe_log_err(1, BAD_MAXACT);
> +			goto parse_error;
> +		}
> +		memcpy(buf, &argv[0][1], len);
> +		buf[len] = '\0';
> +		ret = kstrtouint(buf, 0, &maxactive);
> +		if (ret || !maxactive) {
> +			trace_probe_log_err(1, BAD_MAXACT);
> +			goto parse_error;
> +		}
> +		/* fprobe rethook instances are iterated over via a list. The
> +		 * maximum should stay reasonable.
> +		 */
> +		if (maxactive > RETHOOK_MAXACTIVE_MAX) {
> +			trace_probe_log_err(1, MAXACT_TOO_BIG);
> +			goto parse_error;
> +		}
> +	}
> +
> +	trace_probe_log_set_index(1);
> +
> +	/* a symbol specified */
> +	symbol = kstrdup(argv[1], GFP_KERNEL);
> +	if (!symbol)
> +		return -ENOMEM;
> +
> +	tmp = strchr(symbol, '%');
> +	if (tmp) {
> +		if (!strcmp(tmp, "%return")) {
> +			*tmp = '\0';
> +			is_return = true;
> +		} else {
> +			trace_probe_log_err(tmp - symbol, BAD_ADDR_SUFFIX);
> +			goto parse_error;
> +		}
> +	}
> +
> +	flags |= TPARG_FL_FENTRY;
> +	if (is_return)
> +		flags |= TPARG_FL_RETURN;
> +
> +	trace_probe_log_set_index(0);
> +	if (event) {
> +		ret = traceprobe_parse_event_name(&event, &group, gbuf,
> +						  event - argv[0]);
> +		if (ret)
> +			goto parse_error;
> +	}
> +
> +	if (!event) {
> +		/* Make a new event name */
> +		snprintf(buf, MAX_EVENT_NAME_LEN, "%s_%s", symbol,
> +			 is_return ? "exit" : "entry");
> +		sanitize_event_name(buf);
> +		event = buf;
> +	}
> +
> +	/* setup a probe */
> +	tf = alloc_trace_fprobe(group, event, symbol, maxactive,
> +			       argc - 2, is_return);
> +	if (IS_ERR(tf)) {
> +		ret = PTR_ERR(tf);
> +		/* This must return -ENOMEM, else there is a bug */
> +		WARN_ON_ONCE(ret != -ENOMEM);
> +		goto out;	/* We know tf is not allocated */
> +	}
> +	argc -= 2; argv += 2;
> +
> +	/* parse arguments */
> +	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
> +		trace_probe_log_set_index(i + 2);
> +		ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], flags);
> +		if (ret)
> +			goto error;	/* This can be -ENOMEM */
> +	}
> +
> +	ret = traceprobe_set_print_fmt(&tf->tp,
> +			is_return ? PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL);
> +	if (ret < 0)
> +		goto error;
> +
> +	ret = register_trace_fprobe(tf);
> +	if (ret) {
> +		trace_probe_log_set_index(1);
> +		if (ret == -EILSEQ)
> +			trace_probe_log_err(0, BAD_INSN_BNDRY);
> +		else if (ret == -ENOENT)
> +			trace_probe_log_err(0, BAD_PROBE_ADDR);
> +		else if (ret != -ENOMEM && ret != -EEXIST)
> +			trace_probe_log_err(0, FAIL_REG_PROBE);
> +		goto error;
> +	}
> +
> +out:
> +	trace_probe_log_clear();
> +	kfree(symbol);
> +	return ret;
> +
> +parse_error:
> +	ret = -EINVAL;
> +error:
> +	free_trace_fprobe(tf);
> +	goto out;
> +}
> +
> +static int trace_fprobe_create(const char *raw_command)
> +{
> +	return trace_probe_create(raw_command, __trace_fprobe_create);
> +}
> +
> +static int trace_fprobe_release(struct dyn_event *ev)
> +{
> +	struct trace_fprobe *tf = to_trace_fprobe(ev);
> +	int ret = unregister_trace_fprobe(tf);
> +
> +	if (!ret)
> +		free_trace_fprobe(tf);
> +	return ret;
> +}
> +
> +static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
> +{
> +	struct trace_fprobe *tf = to_trace_fprobe(ev);
> +	int i;
> +
> +	seq_putc(m, 'f');
> +	if (trace_fprobe_is_return(tf) && tf->fp.nr_maxactive)
> +		seq_printf(m, "%d", tf->fp.nr_maxactive);
> +	seq_printf(m, ":%s/%s", trace_probe_group_name(&tf->tp),
> +				trace_probe_name(&tf->tp));
> +
> +	seq_printf(m, " %s%s", trace_fprobe_symbol(tf),
> +			       trace_fprobe_is_return(tf) ? "%return" : "");
> +
> +	for (i = 0; i < tf->tp.nr_args; i++)
> +		seq_printf(m, " %s=%s", tf->tp.args[i].name, tf->tp.args[i].comm);
> +	seq_putc(m, '\n');
> +
> +	return 0;
> +}
> +
> +/*
> + * called by perf_trace_init() or __ftrace_set_clr_event() under event_mutex.
> + */
> +static int fprobe_register(struct trace_event_call *event,
> +			   enum trace_reg type, void *data)
> +{
> +	struct trace_event_file *file = data;
> +
> +	switch (type) {
> +	case TRACE_REG_REGISTER:
> +		return enable_trace_fprobe(event, file);
> +	case TRACE_REG_UNREGISTER:
> +		return disable_trace_fprobe(event, file);
> +
> +#ifdef CONFIG_PERF_EVENTS
> +	case TRACE_REG_PERF_REGISTER:
> +		return enable_trace_fprobe(event, NULL);
> +	case TRACE_REG_PERF_UNREGISTER:
> +		return disable_trace_fprobe(event, NULL);
> +	case TRACE_REG_PERF_OPEN:
> +	case TRACE_REG_PERF_CLOSE:
> +	case TRACE_REG_PERF_ADD:
> +	case TRACE_REG_PERF_DEL:
> +		return 0;
> +#endif
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Register dynevent at core_initcall. This allows kernel to setup fprobe
> + * events in postcore_initcall without tracefs.
> + */
> +static __init int init_fprobe_trace_early(void)
> +{
> +	int ret;
> +
> +	ret = dyn_event_register(&trace_fprobe_ops);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +core_initcall(init_fprobe_trace_early);
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 36dff277de46..df7fb60b40b6 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -384,8 +384,8 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  		break;
>  
>  	case '%':	/* named register */
> -		if (flags & TPARG_FL_TPOINT) {
> -			/* eprobes do not handle registers */
> +		if (flags & (TPARG_FL_TPOINT || TPARG_FL_FPROBE)) {
> +			/* eprobe and fprobe do not handle registers */
>  			trace_probe_log_err(offs, BAD_VAR);
>  			break;
>  		}
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index de38f1c03776..b316b1254583 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -353,7 +353,9 @@ int trace_probe_create(const char *raw_command, int (*createfn)(int, const char
>  #define TPARG_FL_KERNEL BIT(1)
>  #define TPARG_FL_FENTRY BIT(2)
>  #define TPARG_FL_TPOINT BIT(3)
> -#define TPARG_FL_MASK	GENMASK(3, 0)
> +#define TPARG_FL_USER   BIT(4)
> +#define TPARG_FL_FPROBE BIT(5)
> +#define TPARG_FL_MASK	GENMASK(5, 0)
>  
>  extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
>  				const char *argv, unsigned int flags);

