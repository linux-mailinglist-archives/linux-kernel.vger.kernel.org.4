Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C64A6421E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 04:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiLEDcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 22:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiLEDcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 22:32:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D7513DD4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 19:32:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3C8960F59
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92881C433C1;
        Mon,  5 Dec 2022 03:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670211123;
        bh=iX/CWj7jRaxwKpoe30wtybJZUd2l1BaMzsXMlSHYUck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ezUoAfBIvBnKPSeZ4NPwD8N6OMVlXtcD8U2VtnRZRiwzsEBpAm6LhAMJUWgox2rR1
         hmHiSnk7meAU8dyvGi1pYleIO/41/BmCC6Q2/WJmFjrodg7JFZqakwROmsDrWvfKFX
         mA0N/u9WpLzd4exQ1oNigKYMXtJCp4tH9Su2x7Oq3J5k5JNiYM4HfprrJ3pnAu6wid
         SVWySgWvlxWskr1Hm/y9JfTtc4jIpdcio1pvdphZ6Lb37ZXNqlJieUFfVpcqzzz8Xy
         5J6iK1dNXNaJ2ffcQIrqAM75nAPADUtNqoTxnGXmVqGFKQNBDnnNG9quA95qnUydzs
         abS+OKAt4IQMA==
Date:   Mon, 5 Dec 2022 12:32:00 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: Fix some checker warnings
Message-Id: <20221205123200.51539846cb9dd9dc158cc871@kernel.org>
In-Reply-To: <166992525941.1716618.13740663757583361463.stgit@warthog.procyon.org.uk>
References: <166992525941.1716618.13740663757583361463.stgit@warthog.procyon.org.uk>
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

On Thu, 01 Dec 2022 20:07:39 +0000
David Howells <dhowells@redhat.com> wrote:

> Fix some checker warning in the trace code:
> 
>  (1) The declaration of tracing_max_lat_fops should be conditionally
>      defined like its definition.
> 
>  (2) A number of trace functions, and their declarations where present,
>      should have __printf attributes.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steven Rostedt <rostedt@goodmis.org>
> cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
> 
>  include/linux/trace_events.h |    3 ++-
>  include/linux/trace_seq.h    |    3 ++-
>  kernel/trace/trace.c         |    2 ++
>  kernel/trace/trace.h         |    2 +-
>  kernel/trace/trace_output.c  |    5 +++--
>  5 files changed, 10 insertions(+), 5 deletions(-)
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
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 5cfc95a52bc3..9da61a54e187 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1692,7 +1692,9 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
>  }
>  
>  unsigned long __read_mostly	tracing_thresh;
> +#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
>  static const struct file_operations tracing_max_lat_fops;
> +#endif

Oops, I missed this part. Why did you introduced this #ifdefs?

Thank you,

>  
>  #ifdef LATENCY_FS_NOTIFY
>  
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
