Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12C8705316
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjEPQGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjEPQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:06:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B958EE5;
        Tue, 16 May 2023 09:06:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A1F363397;
        Tue, 16 May 2023 16:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6FDC433EF;
        Tue, 16 May 2023 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684253206;
        bh=aaPDpdXKFo27zJIkXjU1Qd3DKHP9ARhLfJfUTFTOqEY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hpsa/jnho95UGexCV+NHnarr1vdLu7qZwJi8Q4AfhGFLs13dqsonyvEBZTtxjtGuI
         03vTNJE9ZKhojPETwPzRJzKKSdi7hvSJdKGrRiqtUa0c1UEWhmnKhJ3oAvKh3N2XQz
         yXuP69wWQOA0BaMpBesqJ+aT/lmpsPa6WLjWK3adoxk8QkTIz8hrSw9Q9mFoCXkEmE
         4IaGl9ePacPmCvNrefM3XOyOqASZ850HoIwT59lIrzA7Ztn7zTv5dojI2iFM2LAaLn
         75lHGyhmG3V/lZoolVpRc4dYao9yYjSz5VUyFTSaw3P8uMJXHfQy48Lq8bUAwBAgtp
         VLEEaQem7ItOQ==
Date:   Wed, 17 May 2023 01:06:43 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Replace all non-returning strlcpy with
 strscpy
Message-Id: <20230517010643.aa4c5dc5e7e6787d72aa9012@kernel.org>
In-Reply-To: <20230516143956.1367827-1-azeemshaikh38@gmail.com>
References: <20230516143956.1367827-1-azeemshaikh38@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 14:39:56 +0000
Azeem Shaikh <azeemshaikh38@gmail.com> wrote:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> No return values were used, so direct replacement with strlcpy is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> ---
> v1: https://lore.kernel.org/all/20230516043943.5234-1-azeemshaikh38@gmail.com/
> Changes from v1:
>  - Removed subsystem specific files.
>  - Minor update to commit log.
> 
>  kernel/trace/trace.c               |    8 ++++----
>  kernel/trace/trace_events.c        |    4 ++--
>  kernel/trace/trace_events_inject.c |    4 ++--
>  kernel/trace/trace_kprobe.c        |    2 +-
>  kernel/trace/trace_probe.c         |    2 +-
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
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
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
