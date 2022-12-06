Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338D0644471
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiLFNSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiLFNSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:18:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC649D6F;
        Tue,  6 Dec 2022 05:18:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 234E36174A;
        Tue,  6 Dec 2022 13:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DE9C433C1;
        Tue,  6 Dec 2022 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670332696;
        bh=yWnHX7kQZN3gZ80y4mJxNlC5EcUmNw+ipJWVjMmo7Oc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S+rTSqM3V6kujMp9fWQUrJBGViad5OIG53s08rYSOh/Nozo/q+0cXlAAYMtNMlnOs
         o5JhxfzlHnFbW2UUroCJ5Yjo4UdNO8afIBOQvdTsqhuyRr+vRl6s0Z409wKnPsGEoK
         inwjUKp+MMR0D9Tm/BPtiN7RqCIfzy5U0X61qOe+LGaLlpd2AG97p74p1nTVHEEhEB
         EV0B2/VvwzuKczykBD1AbAe86tcL1KROo74nvAzRl2NEDLgwujill6DUc4ql5cefsM
         AqvTH8RGNaLyBqoFZPeKjby4sAsGLW031rqBlEWhHRAYlRuCPp94SxI70/S/ZuI7nZ
         gb1M6+CJCSb6Q==
Date:   Tue, 6 Dec 2022 22:18:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] trace: Fix some checker warnings
Message-Id: <20221206221813.3c7cfa0c6e51b551869912b3@kernel.org>
In-Reply-To: <167023571258.382307.15314866482834835192.stgit@warthog.procyon.org.uk>
References: <167023571258.382307.15314866482834835192.stgit@warthog.procyon.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Mon, 05 Dec 2022 10:21:52 +0000
David Howells <dhowells@redhat.com> wrote:

> Fix some checker warnings in the trace code by adding __printf attributes
> to a number of trace functions and their declarations.
> 
> Changes:
> ========
> ver #2)
>  - Dropped the fix for the unconditional tracing_max_lat_fops decl[1].
> 

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steven Rostedt <rostedt@goodmis.org>
> cc: Masami Hiramatsu <mhiramat@kernel.org>
> Link: https://lore.kernel.org/r/20221205180617.9b9d3971cbe06ee536603523@kernel.org/ [1]
> Link: https://lore.kernel.org/r/166992525941.1716618.13740663757583361463.stgit@warthog.procyon.org.uk/ # v1
> ---
> 
>  include/linux/trace_events.h |    3 ++-
>  include/linux/trace_seq.h    |    3 ++-
>  kernel/trace/trace.h         |    2 +-
>  kernel/trace/trace_output.c  |    5 +++--
>  4 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 20749bd9db71..112b08ca2c5c 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -235,7 +235,8 @@ void tracing_record_taskinfo_sched_switch(struct task_struct *prev,
>  void tracing_record_cmdline(struct task_struct *task);
>  void tracing_record_tgid(struct task_struct *task);
>  
> -int trace_output_call(struct trace_iterator *iter, char *name, char *fmt, ...);
> +int trace_output_call(struct trace_iterator *iter, char *name, char *fmt, ...)
> +	 __printf(3, 4);
>  
>  struct event_filter;
>  
> diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
> index 5a2c650d9e1c..0c4c7587d6c3 100644
> --- a/include/linux/trace_seq.h
> +++ b/include/linux/trace_seq.h
> @@ -97,7 +97,8 @@ extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
>  			      const void *buf, size_t len, bool ascii);
>  
>  #else /* CONFIG_TRACING */
> -static inline void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
> +static inline __printf(2, 3)
> +void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
>  {
>  }
>  static inline void
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index d42e24507152..ecc6120116da 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -615,7 +615,7 @@ void trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
>  bool trace_is_tracepoint_string(const char *str);
>  const char *trace_event_format(struct trace_iterator *iter, const char *fmt);
>  void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
> -			 va_list ap);
> +			 va_list ap) __printf(2, 0);
>  
>  int trace_empty(struct trace_iterator *iter);
>  
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 67f47ea27921..7039cd883c8b 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -323,8 +323,9 @@ void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...)
>  }
>  EXPORT_SYMBOL(trace_event_printf);
>  
> -static int trace_output_raw(struct trace_iterator *iter, char *name,
> -			    char *fmt, va_list ap)
> +static __printf(3, 0)
> +int trace_output_raw(struct trace_iterator *iter, char *name,
> +		     char *fmt, va_list ap)
>  {
>  	struct trace_seq *s = &iter->seq;
>  
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
