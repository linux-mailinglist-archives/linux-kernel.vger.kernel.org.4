Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4B4705059
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjEPORh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjEPORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE806E85;
        Tue, 16 May 2023 07:17:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1901263A96;
        Tue, 16 May 2023 14:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801ADC433D2;
        Tue, 16 May 2023 14:17:29 +0000 (UTC)
Date:   Tue, 16 May 2023 10:17:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        Mark Bloch <mbloch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH] tracing: Replace all non-returning strlcpy with strscpy
Message-ID: <20230516101727.7f19aae9@gandalf.local.home>
In-Reply-To: <20230516043943.5234-1-azeemshaikh38@gmail.com>
References: <20230516043943.5234-1-azeemshaikh38@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 04:39:43 +0000
Azeem Shaikh <azeemshaikh38@gmail.com> wrote:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> No return values were used, so direct replacement with strlcpy is safe.

> Occurences of strlcpy within TRACE_EVENT macros were replaced with
> __string() and __assign_str() macro helpers instead.

This part I have issues with (see below).

> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  include/trace/events/fib.h         |    2 +-
>  include/trace/events/fib6.h        |    2 +-
>  include/trace/events/kyber.h       |   24 ++++++++++++------------
>  include/trace/events/task.h        |    6 +++---
>  include/trace/events/wbt.h         |   28 ++++++++++++----------------

Please break this up into multiple patches. The above are actually
maintained by the subsystems they are used in. Those changes should go
through them. But I have issues with these changes as I mention below.


>  kernel/trace/trace.c               |    8 ++++----
>  kernel/trace/trace_events.c        |    4 ++--
>  kernel/trace/trace_events_inject.c |    4 ++--
>  kernel/trace/trace_kprobe.c        |    2 +-
>  kernel/trace/trace_probe.c         |    2 +-
>  10 files changed, 39 insertions(+), 43 deletions(-)
> 
> diff --git a/include/trace/events/fib.h b/include/trace/events/fib.h
> index 76297ecd4935..20b914250ce9 100644
> --- a/include/trace/events/fib.h
> +++ b/include/trace/events/fib.h
> @@ -65,7 +65,7 @@ TRACE_EVENT(fib_table_lookup,
>  		}
>  
>  		dev = nhc ? nhc->nhc_dev : NULL;
> -		strlcpy(__entry->name, dev ? dev->name : "-", IFNAMSIZ);
> +		strscpy(__entry->name, dev ? dev->name : "-", IFNAMSIZ);
>  
>  		if (nhc) {
>  			if (nhc->nhc_gw_family == AF_INET) {
> diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
> index 4d3e607b3cde..5d7ee2610728 100644
> --- a/include/trace/events/fib6.h
> +++ b/include/trace/events/fib6.h
> @@ -63,7 +63,7 @@ TRACE_EVENT(fib6_table_lookup,
>  		}
>  
>  		if (res->nh && res->nh->fib_nh_dev) {
> -			strlcpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
> +			strscpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
>  		} else {
>  			strcpy(__entry->name, "-");
>  		}
> diff --git a/include/trace/events/kyber.h b/include/trace/events/kyber.h
> index bf7533f171ff..d4db2fa60e7b 100644
> --- a/include/trace/events/kyber.h
> +++ b/include/trace/events/kyber.h
> @@ -21,8 +21,8 @@ TRACE_EVENT(kyber_latency,
>  
>  	TP_STRUCT__entry(
>  		__field(	dev_t,	dev				)
> -		__array(	char,	domain,	DOMAIN_LEN		)
> -		__array(	char,	type,	LATENCY_TYPE_LEN	)
> +		__string(	domain,	domain				)
> +		__string(	type,	type				)

Note, __string() adds a little bit more overhead. If the length is small
enough (like 16 or 8, as the above are) then it is more efficient in both
speed and size of the ring buffer to use the hard coded array, and not use
the dynamic string.

NACK on the above change.


>  		__field(	u8,	percentile			)
>  		__field(	u8,	numerator			)
>  		__field(	u8,	denominator			)
> @@ -31,8 +31,8 @@ TRACE_EVENT(kyber_latency,
>  
>  	TP_fast_assign(
>  		__entry->dev		= dev;
> -		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
> -		strlcpy(__entry->type, type, sizeof(__entry->type));
> +		__assign_str(domain, domain);
> +		__assign_str(type, type);
>  		__entry->percentile	= percentile;
>  		__entry->numerator	= numerator;
>  		__entry->denominator	= denominator;
> @@ -40,8 +40,8 @@ TRACE_EVENT(kyber_latency,
>  	),
>  
>  	TP_printk("%d,%d %s %s p%u %u/%u samples=%u",
> -		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->domain,
> -		  __entry->type, __entry->percentile, __entry->numerator,
> +		  MAJOR(__entry->dev), MINOR(__entry->dev), __get_str(domain),
> +		  __get_str(type), __entry->percentile, __entry->numerator,
>  		  __entry->denominator, __entry->samples)
>  );
>  
> @@ -53,18 +53,18 @@ TRACE_EVENT(kyber_adjust,
>  
>  	TP_STRUCT__entry(
>  		__field(	dev_t,	dev			)
> -		__array(	char,	domain,	DOMAIN_LEN	)
> +		__string(	domain,	domain			)
>  		__field(	unsigned int,	depth		)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->dev		= dev;
> -		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
> +		__assign_str(domain, domain);
>  		__entry->depth		= depth;
>  	),
>  
>  	TP_printk("%d,%d %s %u",
> -		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->domain,
> +		  MAJOR(__entry->dev), MINOR(__entry->dev), __get_str(domain),
>  		  __entry->depth)
>  );
>  
> @@ -76,16 +76,16 @@ TRACE_EVENT(kyber_throttled,
>  
>  	TP_STRUCT__entry(
>  		__field(	dev_t,	dev			)
> -		__array(	char,	domain,	DOMAIN_LEN	)

Again, do not blindly change fixed size strings to dynamic size, as the
code requires more work to do the dynamic allocation and takes up 4 more
bytes to store the meta data holding the size and offset of the string.

> +		__string(	domain,	domain			)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->dev		= dev;
> -		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
> +		__assign_str(domain, domain);
>  	),
>  
>  	TP_printk("%d,%d %s", MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  __entry->domain)
> +		  __get_str(domain))
>  );
>  
>  #define _TRACE_KYBER_H
> diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> index 64d160930b0d..48b1bb868a86 100644
> --- a/include/trace/events/task.h
> +++ b/include/trace/events/task.h
> @@ -40,20 +40,20 @@ TRACE_EVENT(task_rename,
>  	TP_STRUCT__entry(
>  		__field(	pid_t,	pid)
>  		__array(	char, oldcomm,  TASK_COMM_LEN)
> -		__array(	char, newcomm,  TASK_COMM_LEN)
> +		__string(	newcomm,	comm)

NACK.

>  		__field(	short,	oom_score_adj)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->pid = task->pid;
>  		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
> -		strlcpy(entry->newcomm, comm, TASK_COMM_LEN);
> +		__assign_str(newcomm, comm);
>  		__entry->oom_score_adj = task->signal->oom_score_adj;
>  	),
>  
>  	TP_printk("pid=%d oldcomm=%s newcomm=%s oom_score_adj=%hd",
>  		__entry->pid, __entry->oldcomm,
> -		__entry->newcomm, __entry->oom_score_adj)
> +		__get_str(newcomm), __entry->oom_score_adj)
>  );
>  
>  #endif
> diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
> index 9c66e59d859c..874404822575 100644
> --- a/include/trace/events/wbt.h
> +++ b/include/trace/events/wbt.h
> @@ -19,7 +19,7 @@ TRACE_EVENT(wbt_stat,
>  	TP_ARGS(bdi, stat),
>  
>  	TP_STRUCT__entry(
> -		__array(char, name, 32)
> +		__string(name, bdi_dev_name(bdi))

Again, don't change these.

>  		__field(s64, rmean)
>  		__field(u64, rmin)
>  		__field(u64, rmax)
> @@ -33,8 +33,7 @@ TRACE_EVENT(wbt_stat,
>  	),
>  
>  	TP_fast_assign(
> -		strlcpy(__entry->name, bdi_dev_name(bdi),
> -			ARRAY_SIZE(__entry->name));
> +		__assign_str(name, bdi_dev_name(bdi));
>  		__entry->rmean		= stat[0].mean;
>  		__entry->rmin		= stat[0].min;
>  		__entry->rmax		= stat[0].max;
> @@ -47,7 +46,7 @@ TRACE_EVENT(wbt_stat,
>  
>  	TP_printk("%s: rmean=%llu, rmin=%llu, rmax=%llu, rsamples=%llu, "
>  		  "wmean=%llu, wmin=%llu, wmax=%llu, wsamples=%llu",
> -		  __entry->name, __entry->rmean, __entry->rmin, __entry->rmax,
> +		  __get_str(name), __entry->rmean, __entry->rmin, __entry->rmax,
>  		  __entry->rnr_samples, __entry->wmean, __entry->wmin,
>  		  __entry->wmax, __entry->wnr_samples)
>  );
> @@ -63,17 +62,16 @@ TRACE_EVENT(wbt_lat,
>  	TP_ARGS(bdi, lat),
>  
>  	TP_STRUCT__entry(
> -		__array(char, name, 32)
> +		__string(name, bdi_dev_name(bdi))
>  		__field(unsigned long, lat)
>  	),
>  
>  	TP_fast_assign(
> -		strlcpy(__entry->name, bdi_dev_name(bdi),
> -			ARRAY_SIZE(__entry->name));
> +		__assign_str(name, bdi_dev_name(bdi));
>  		__entry->lat = div_u64(lat, 1000);
>  	),
>  
> -	TP_printk("%s: latency %lluus", __entry->name,
> +	TP_printk("%s: latency %lluus", __get_str(name),
>  			(unsigned long long) __entry->lat)
>  );
>  
> @@ -95,7 +93,7 @@ TRACE_EVENT(wbt_step,
>  	TP_ARGS(bdi, msg, step, window, bg, normal, max),
>  
>  	TP_STRUCT__entry(
> -		__array(char, name, 32)
> +		__string(name, bdi_dev_name(bdi))
>  		__field(const char *, msg)
>  		__field(int, step)
>  		__field(unsigned long, window)
> @@ -105,8 +103,7 @@ TRACE_EVENT(wbt_step,
>  	),
>  
>  	TP_fast_assign(
> -		strlcpy(__entry->name, bdi_dev_name(bdi),
> -			ARRAY_SIZE(__entry->name));
> +		__assign_str(name, bdi_dev_name(bdi));
>  		__entry->msg	= msg;
>  		__entry->step	= step;
>  		__entry->window	= div_u64(window, 1000);
> @@ -116,7 +113,7 @@ TRACE_EVENT(wbt_step,
>  	),
>  
>  	TP_printk("%s: %s: step=%d, window=%luus, background=%u, normal=%u, max=%u",
> -		  __entry->name, __entry->msg, __entry->step, __entry->window,
> +		  __get_str(name), __entry->msg, __entry->step, __entry->window,
>  		  __entry->bg, __entry->normal, __entry->max)
>  );
>  
> @@ -134,21 +131,20 @@ TRACE_EVENT(wbt_timer,
>  	TP_ARGS(bdi, status, step, inflight),
>  
>  	TP_STRUCT__entry(
> -		__array(char, name, 32)
> +		__string(name, bdi_dev_name(bdi))
>  		__field(unsigned int, status)
>  		__field(int, step)
>  		__field(unsigned int, inflight)
>  	),
>  
>  	TP_fast_assign(
> -		strlcpy(__entry->name, bdi_dev_name(bdi),
> -			ARRAY_SIZE(__entry->name));
> +		__assign_str(name, bdi_dev_name(bdi));
>  		__entry->status		= status;
>  		__entry->step		= step;
>  		__entry->inflight	= inflight;
>  	),
>  
> -	TP_printk("%s: status=%u, step=%d, inflight=%u", __entry->name,
> +	TP_printk("%s: status=%u, step=%d, inflight=%u", __get_str(name),
>  		  __entry->status, __entry->step, __entry->inflight)
>  );
>  

The below changes can be sent as its own patch, and I can take it.

-- Steve

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ebc59781456a..28ccd0c9bdf0 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -196,7 +196,7 @@ static int boot_snapshot_index;
>  
>  static int __init set_cmdline_ftrace(char *str)
>  {
> -	strlcpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
> +	strscpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
>  	default_bootup_tracer = bootup_tracer_buf;
>  	/* We are using ftrace early, expand it */
>  	ring_buffer_expanded = true;
> @@ -281,7 +281,7 @@ static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
>  
>  static int __init set_trace_boot_options(char *str)
>  {
> -	strlcpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
> +	strscpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
>  	return 1;
>  }
>  __setup("trace_options=", set_trace_boot_options);
> @@ -291,7 +291,7 @@ static char *trace_boot_clock __initdata;
>  
>  static int __init set_trace_boot_clock(char *str)
>  {
> -	strlcpy(trace_boot_clock_buf, str, MAX_TRACER_SIZE);
> +	strscpy(trace_boot_clock_buf, str, MAX_TRACER_SIZE);
>  	trace_boot_clock = trace_boot_clock_buf;
>  	return 1;
>  }
> @@ -2521,7 +2521,7 @@ static void __trace_find_cmdline(int pid, char comm[])
>  	if (map != NO_CMDLINE_MAP) {
>  		tpid = savedcmd->map_cmdline_to_pid[map];
>  		if (tpid == pid) {
> -			strlcpy(comm, get_saved_cmdlines(map), TASK_COMM_LEN);
> +			strscpy(comm, get_saved_cmdlines(map), TASK_COMM_LEN);
>  			return;
>  		}
>  	}
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 654ffa40457a..dc83a259915b 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2831,7 +2831,7 @@ static __init int setup_trace_triggers(char *str)
>  	char *buf;
>  	int i;
>  
> -	strlcpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
> +	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
>  	ring_buffer_expanded = true;
>  	disable_tracing_selftest("running event triggers");
>  
> @@ -3621,7 +3621,7 @@ static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
>  
>  static __init int setup_trace_event(char *str)
>  {
> -	strlcpy(bootup_event_buf, str, COMMAND_LINE_SIZE);
> +	strscpy(bootup_event_buf, str, COMMAND_LINE_SIZE);
>  	ring_buffer_expanded = true;
>  	disable_tracing_selftest("running event tracing");
>  
> diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
> index d6b4935a78c0..abe805d471eb 100644
> --- a/kernel/trace/trace_events_inject.c
> +++ b/kernel/trace/trace_events_inject.c
> @@ -217,7 +217,7 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
>  			char *addr = (char *)(unsigned long) val;
>  
>  			if (field->filter_type == FILTER_STATIC_STRING) {
> -				strlcpy(entry + field->offset, addr, field->size);
> +				strscpy(entry + field->offset, addr, field->size);
>  			} else if (field->filter_type == FILTER_DYN_STRING ||
>  				   field->filter_type == FILTER_RDYN_STRING) {
>  				int str_len = strlen(addr) + 1;
> @@ -232,7 +232,7 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
>  				}
>  				entry = *pentry;
>  
> -				strlcpy(entry + (entry_size - str_len), addr, str_len);
> +				strscpy(entry + (entry_size - str_len), addr, str_len);
>  				str_item = (u32 *)(entry + field->offset);
>  				if (field->filter_type == FILTER_RDYN_STRING)
>  					str_loc -= field->offset + field->size;
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 59cda19a9033..1b3fa7b854aa 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -30,7 +30,7 @@ static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
>  
>  static int __init set_kprobe_boot_events(char *str)
>  {
> -	strlcpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
> +	strscpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
>  	disable_tracing_selftest("running kprobe events");
>  
>  	return 1;
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 2d2616678295..73055ba8d8ef 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -254,7 +254,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
>  			trace_probe_log_err(offset, GROUP_TOO_LONG);
>  			return -EINVAL;
>  		}
> -		strlcpy(buf, event, slash - event + 1);
> +		strscpy(buf, event, slash - event + 1);
>  		if (!is_good_system_name(buf)) {
>  			trace_probe_log_err(offset, BAD_GROUP_NAME);
>  			return -EINVAL;

