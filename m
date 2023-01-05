Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CC665E22D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjAEBGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjAEBGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:06:21 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895222F7BE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:06:20 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id s9so28847714qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 17:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLZw8C56lIMJzQNkbtwwGx4hGjO8vFqsMmr7mkW8vBw=;
        b=wgRWLOY8/G2cT1t0w3wWMi8d0XK9Y0KkJKdGnu5t97RKeTOK2nqfXIBeWZgyQ++CeR
         6bFTDHWNeQxLDhinHGf5DORS2P5zo/zSdCvlhaC16LFfua+rKLRtormjucojI8/PY0Ph
         hAADetkklddYM2qIyFsifFEwVqWz/8KZRNi9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLZw8C56lIMJzQNkbtwwGx4hGjO8vFqsMmr7mkW8vBw=;
        b=TQqKVRQMdSpzTyAH9SNfhJ/P4b2l2wYU1vj4FsoBUXq53XfqmHEhQdm/Ei4zUHWFwt
         RBuTW+W9xeD26xR7O05lhnE6qC7wFNs9sbxDbWnD9njb+Y/qxyey6dtNhwbtppOXXGik
         lw0giibrrUN35KoYO45WyWFvw5Ie8hyMdteijGPXB0hQZIzBBZQVS3egaoCwjYUdBLu1
         awaFdia2a5Vxzyfipxc+6l7hSqI6ieUX3BPhNwhvwCA924XLHNaMYx5f6jMX9NXYEkxM
         DUMz/qJqzaoq2cVgjsUjC/u8HIQItAybfqpThJk+ErT4frB2S7FVbIMgh5wHVO22Ds5i
         zmeg==
X-Gm-Message-State: AFqh2krNhem4M52iqv1E8ITuTjZ1KI6sw6D19C0GwKh6wbA2mujsq0ag
        1IYwpmllWcracbNgvLIKQe+H9CW3+EW98ktU
X-Google-Smtp-Source: AMrXdXveZ2JUOrizRlhHByXTSfr3sHdgr+EqqbJTUUi5MTzjxBFX9v1rve4kwNRzwMDK76mLaRRzCQ==
X-Received: by 2002:ac8:7583:0:b0:3a7:eb2c:efea with SMTP id s3-20020ac87583000000b003a7eb2cefeamr74409840qtq.19.1672880779620;
        Wed, 04 Jan 2023 17:06:19 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id o6-20020ac872c6000000b003a57a317c17sm21131484qtp.74.2023.01.04.17.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 17:06:18 -0800 (PST)
Date:   Thu, 5 Jan 2023 01:06:18 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing: Make sure trace_printk() can output as soon as
 it can be used
Message-ID: <Y7YiiogG7xbOjrNE@google.com>
References: <20230104161412.019f6c55@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104161412.019f6c55@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 04:14:12PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Currently trace_printk() can be used as soon as early_trace_init() is
> called from start_kernel(). But if a crash happens, and
> "ftrace_dump_on_oops" is set on the kernel command line, all you get will
> be:
> 
>   [    0.456075]   <idle>-0         0dN.2. 347519us : Unknown type 6
>   [    0.456075]   <idle>-0         0dN.2. 353141us : Unknown type 6
>   [    0.456075]   <idle>-0         0dN.2. 358684us : Unknown type 6
> 
> This is because the trace_printk() event (type 6) hasn't been registered
> yet. That gets done via an early_initcall(), which may be early, but not
> early enough.
> 
> Instead of registering the trace_printk() event (and other ftrace events,
> which are not trace events) via an early_initcall(), have them registered at
> the same time that trace_printk() can be used. This way, if there is a
> crash before early_initcall(), then the trace_printk()s will actually be
> useful.
> 
> Cc: stable@vger.kernel.org
> Reported-by: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Fixes: e725c731e3bb1 ("tracing: Split tracing initialization into two for early initialization")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  kernel/trace/trace.c        | 2 ++
>  kernel/trace/trace.h        | 1 +
>  kernel/trace/trace_output.c | 3 +--
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d3005279165d..80de338f1277 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10196,6 +10196,8 @@ void __init early_trace_init(void)
>  			static_key_enable(&tracepoint_printk_key.key);
>  	}
>  	tracer_alloc_buffers();
> +
> +	init_events();
>  }
>  
>  void __init trace_init(void)
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 900e75d96c84..11c4918ff202 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1504,6 +1504,7 @@ extern void trace_event_enable_cmd_record(bool enable);
>  extern void trace_event_enable_tgid_record(bool enable);
>  
>  extern int event_trace_init(void);
> +extern int init_events(void);
>  extern int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr);
>  extern int event_trace_del_tracer(struct trace_array *tr);
>  extern void __trace_early_add_events(struct trace_array *tr);
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 67f47ea27921..5cd4fb656306 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1568,7 +1568,7 @@ static struct trace_event *events[] __initdata = {
>  	NULL
>  };
>  
> -__init static int init_events(void)
> +__init int init_events(void)
>  {
>  	struct trace_event *event;
>  	int i, ret;
> @@ -1581,4 +1581,3 @@ __init static int init_events(void)
>  
>  	return 0;
>  }
> -early_initcall(init_events);
> -- 
> 2.35.1
> 
