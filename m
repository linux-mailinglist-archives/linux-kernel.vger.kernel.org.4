Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ABB6222A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiKIDer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKIDem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:34:42 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EBE1DDFB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:34:39 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13b23e29e36so18394311fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 19:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjDOJuZ+MEe00z/NbsaiPqM9xcZWZUmt2unSoYxgDlk=;
        b=TJ+IqANR2Pk7PwxGB5aNOKz9eaVbFHvddb+MNDklrK/2mB0W/mEZXh/jM+ruqPjV9z
         X7QOJd0PESZd1rvz/8O1iHbCrmllFrfyg9JP2oGmT7XdWLdZqhaZXWQWTH1oHhZ7sCrk
         t1IQv+tlcMSlm7bEctTVcxrEbtYEYGyyJYSwO2sRqdfufJo9EypGudVxuJlx/rvaUvj0
         7A1CygQ5B642ruK1TzA/XJa90B1fM5dE3afJiq+YuaUACDE+/5pSFRjzXAy4+QTQvJC+
         AUqRqCanwHmZTSl9TAuLlvKgv9WJv8j7gttWnDMJ7K2Zu1J8Ob79xGtW6yD8neXm9NP4
         hwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjDOJuZ+MEe00z/NbsaiPqM9xcZWZUmt2unSoYxgDlk=;
        b=pD0n0o7MFwwHrFOq3BETnGD8e/DlFiB3XagBq+7THCi8eed4tDNxgeXApnKq7m1MhA
         9HsUm/O2MgkCbZBpewnhD8erlwN3km657Ar56CJtOrHljymFhSb0YfPF6SHYd9ls8e8V
         w49ZNCfApaiXD0VGCFroECO0PX1PsYwQihU+1pHgypi+5TfCeZYR8GO0DTbViHXtrrP0
         AIzvjoQsnmWZNR9Dnkc3NvsHKmEwexYNF7l9ISzKENASR7YoM2Ac2MIxOB6CHch6HY7g
         EGExXebvjNQZ1gxZH/f9aVs4fbmWzxhDkcMlJV8J+6f7xkgwBY8yldGFB4IjyaIYXRyI
         bdHA==
X-Gm-Message-State: ACrzQf2ECq1R8aMT+KjtWx/AenzL5yOWyCFSb0hYF89POExTgn7O1NAi
        JIrj35KZYr4irviqSmCG5NIzaWOvXqA=
X-Google-Smtp-Source: AMsMyM4QxLXVkyW0kZBG8LPug8ORcnfVjYexKKGZHImfTMie2BHLv/mC8RXagjWMY3iKGAmILPjX7w==
X-Received: by 2002:a05:6870:d29f:b0:132:bd27:825d with SMTP id d31-20020a056870d29f00b00132bd27825dmr35440234oae.99.1667964822720;
        Tue, 08 Nov 2022 19:33:42 -0800 (PST)
Received: from macondo ([2804:431:e7cc:805:20d8:ca0b:7b1e:63d3])
        by smtp.gmail.com with ESMTPSA id m8-20020a4aab88000000b00480816a5b8csm3843765oon.18.2022.11.08.19.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:33:42 -0800 (PST)
Date:   Wed, 9 Nov 2022 00:33:37 -0300
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] tracing/eprobe: Add eprobe filter support
Message-ID: <Y2sfkaIa4sBLuHGX@macondo>
References: <165932112555.2850673.7704483936633223533.stgit@devnote2>
 <165932114513.2850673.2592206685744598080.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165932114513.2850673.2592206685744598080.stgit@devnote2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 11:32:25AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add the filter option to the event probe. This is useful if user wants
> to derive a new event based on the condition of the original event.
> 
> E.g.
>  echo 'e:egroup/stat_runtime_4core sched/sched_stat_runtime \
>         runtime=$runtime:u32 if cpu < 4' >> ../dynamic_events
> 
> Then it can filter the events only on first 4 cores.
> Note that the fields used for 'if' must be the fields in the original
> events, not eprobe events.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_eprobe.c |  104 ++++++++++++++++++++++++++++++++++++++++---
>  kernel/trace/trace_probe.h  |    3 +
>  2 files changed, 98 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 4a0e9d927443..8b32d1a3b9c7 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -26,6 +26,9 @@ struct trace_eprobe {
>  	/* tracepoint event */
>  	const char *event_name;
>  
> +	/* filter string for the tracepoint */
> +	char *filter_str;
> +
>  	struct trace_event_call *event;
>  
>  	struct dyn_event	devent;
> @@ -589,14 +592,15 @@ static struct event_trigger_data *
>  new_eprobe_trigger(struct trace_eprobe *ep, struct trace_event_file *file)
>  {
>  	struct event_trigger_data *trigger;
> +	struct event_filter *filter = NULL;
>  	struct eprobe_data *edata;
> +	int ret;
>  
>  	edata = kzalloc(sizeof(*edata), GFP_KERNEL);
>  	trigger = kzalloc(sizeof(*trigger), GFP_KERNEL);
>  	if (!trigger || !edata) {
> -		kfree(edata);
> -		kfree(trigger);
> -		return ERR_PTR(-ENOMEM);
> +		ret = -ENOMEM;
> +		goto error;
>  	}
>  
>  	trigger->flags = EVENT_TRIGGER_FL_PROBE;
> @@ -611,13 +615,25 @@ new_eprobe_trigger(struct trace_eprobe *ep, struct trace_event_file *file)
>  	trigger->cmd_ops = &event_trigger_cmd;
>  
>  	INIT_LIST_HEAD(&trigger->list);
> -	RCU_INIT_POINTER(trigger->filter, NULL);
> +
> +	if (ep->filter_str) {
> +		ret = create_event_filter(file->tr, file->event_call,

Hi Masami,
I was playing around with the filter option and couldn't get it to work the way
I was expecting. For example, I'm getting the following output:

root@localhost:/sys/kernel/tracing# echo 'e syscalls/sys_enter_openat \
	flags_rename=$flags:u32 if flags < 1000' >> dynamic_events
root@localhost:/sys/kernel/tracing# echo 1 > events/eprobes/sys_enter_openat/enable
[  114.551550] event trace: Could not enable event sys_enter_openat
-bash: echo: write error: Invalid argument

I was wondering if the trace_event_call passed to create_event_filter()
shouldn't be 'ep->event' instead of 'file->event_call' as such:

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index e888446d80fa..123d2c0a6b68 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -643,7 +643,7 @@ new_eprobe_trigger(struct trace_eprobe *ep, struct
trace_event_file *file)
	INIT_LIST_HEAD(&trigger->list);
 
	if (ep->filter_str) {
-               ret = create_event_filter(file->tr, file->event_call,
+               ret = create_event_filter(file->tr, ep->event,
					ep->filter_str, false, &filter);
		if (ret)
			goto error;

Applying the above change seems to make it work the way I was expecting:

root@localhost:/sys/kernel/tracing# echo 'e syscalls/sys_enter_openat \
	flags_rename=$flags:u32 if flags < 1000' >> dynamic_events
root@localhost:/sys/kernel/tracing# echo 1 > events/eprobes/sys_enter_openat/enable
root@localhost:/sys/kernel/tracing# tail trace
cat-241     [000] ...1.   266.498449: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
cat-242     [000] ...1.   266.977640: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
cat-242     [000] ...1.   266.979883: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
bash-223     [000] ...1.   272.322714: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=577
cat-243     [000] ...1.   273.630900: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
cat-243     [000] ...1.   273.633464: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
tail-244     [000] ...1.   300.013530: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
tail-244     [000] ...1.   300.018584: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
tail-245     [000] ...1.   301.237883: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
tail-245     [000] ...1.   301.243375: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0

I'm not familiar with the eprobe code, sorry if this is nonsense.

> +					ep->filter_str, false, &filter);
> +		if (ret)
> +			goto error;
> +	}
> +	RCU_INIT_POINTER(trigger->filter, filter);
>  
>  	edata->file = file;
>  	edata->ep = ep;
>  	trigger->private_data = edata;
>  
>  	return trigger;
> +error:
> +	free_event_filter(filter);
> +	kfree(edata);
> +	kfree(trigger);
> +	return ERR_PTR(ret);
>  }
>  
>  static int enable_eprobe(struct trace_eprobe *ep,
> @@ -651,6 +667,7 @@ static int disable_eprobe(struct trace_eprobe *ep,
>  {
>  	struct event_trigger_data *trigger = NULL, *iter;
>  	struct trace_event_file *file;
> +	struct event_filter *filter;
>  	struct eprobe_data *edata;
>  
>  	file = find_event_file(tr, ep->event_system, ep->event_name);
> @@ -677,6 +694,10 @@ static int disable_eprobe(struct trace_eprobe *ep,
>  	/* Make sure nothing is using the edata or trigger */
>  	tracepoint_synchronize_unregister();
>  
> +	filter = rcu_access_pointer(trigger->filter);
> +
> +	if (filter)
> +		free_event_filter(filter);
>  	kfree(edata);
>  	kfree(trigger);
>  
> @@ -848,12 +869,62 @@ static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[
>  	return ret;
>  }
>  
> +static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const char *argv[])
> +{
> +	struct event_filter *dummy;
> +	int i, ret, len = 0;
> +	char *p;
> +
> +	if (argc == 0) {
> +		trace_probe_log_err(0, NO_EP_FILTER);
> +		return -EINVAL;
> +	}
> +
> +	/* Recover the filter string */
> +	for (i = 0; i < argc; i++)
> +		len += strlen(argv[i]) + 1;
> +
> +	ep->filter_str = kzalloc(len, GFP_KERNEL);
> +	if (!ep->filter_str)
> +		return -ENOMEM;
> +
> +	p = ep->filter_str;
> +	for (i = 0; i < argc; i++) {
> +		ret = snprintf(p, len, "%s ", argv[i]);
> +		if (ret < 0)
> +			goto error;
> +		if (ret > len) {
> +			ret = -E2BIG;
> +			goto error;
> +		}
> +		p += ret;
> +		len -= ret;
> +	}
> +	p[-1] = '\0';
> +
> +	/*
> +	 * Ensure the filter string can be parsed correctly. Note, this
> +	 * filter string is for the original event, not for the eprobe.
> +	 */
> +	ret = create_event_filter(top_trace_array(), ep->event, ep->filter_str,
> +				  true, &dummy);
> +	free_event_filter(dummy);
> +	if (ret)
> +		goto error;
> +
> +	return 0;
> +error:
> +	kfree(ep->filter_str);
> +	ep->filter_str = NULL;
> +	return ret;
> +}
> +
>  static int __trace_eprobe_create(int argc, const char *argv[])
>  {
>  	/*
>  	 * Argument syntax:
> -	 *      e[:[GRP/][ENAME]] SYSTEM.EVENT [FETCHARGS]
> -	 * Fetch args:
> +	 *      e[:[GRP/][ENAME]] SYSTEM.EVENT [FETCHARGS] [if FILTER]
> +	 * Fetch args (no space):
>  	 *  <name>=$<field>[:TYPE]
>  	 */
>  	const char *event = NULL, *group = EPROBE_EVENT_SYSTEM;
> @@ -863,8 +934,8 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  	char buf1[MAX_EVENT_NAME_LEN];
>  	char buf2[MAX_EVENT_NAME_LEN];
>  	char gbuf[MAX_EVENT_NAME_LEN];
> -	int ret = 0;
> -	int i;
> +	int ret = 0, filter_idx = 0;
> +	int i, filter_cnt;
>  
>  	if (argc < 2 || argv[0][0] != 'e')
>  		return -ECANCELED;
> @@ -894,6 +965,15 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  		event = buf1;
>  	}
>  
> +	for (i = 2; i < argc; i++) {
> +		if (!strcmp(argv[i], "if")) {
> +			filter_idx = i + 1;
> +			filter_cnt = argc - filter_idx;
> +			argc = i;
> +			break;
> +		}
> +	}
> +
>  	mutex_lock(&event_mutex);
>  	event_call = find_and_get_event(sys_name, sys_event);
>  	ep = alloc_event_probe(group, event, event_call, argc - 2);
> @@ -909,6 +989,14 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  		goto error;
>  	}
>  
> +	if (filter_idx) {
> +		trace_probe_log_set_index(filter_idx);
> +		ret = trace_eprobe_parse_filter(ep, filter_cnt, argv + filter_idx);
> +		if (ret)
> +			goto parse_error;
> +	} else
> +		ep->filter_str = NULL;
> +
>  	argc -= 2; argv += 2;
>  	/* parse arguments */
>  	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 3b3869ae8cfd..de38f1c03776 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -445,7 +445,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(SAME_PROBE,		"There is already the exact same probe event"),\
>  	C(NO_EVENT_INFO,	"This requires both group and event name to attach"),\
>  	C(BAD_ATTACH_EVENT,	"Attached event does not exist"),\
> -	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),
> +	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),\
> +	C(NO_EP_FILTER,		"No filter rule after 'if'"),
>  
>  #undef C
>  #define C(a, b)		TP_ERR_##a
> 
