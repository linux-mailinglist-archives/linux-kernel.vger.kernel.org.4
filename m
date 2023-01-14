Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BFB66A75C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 01:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjANAIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 19:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjANAIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:08:15 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434AD4D716
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:08:14 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id h26so11528434ila.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GncgTa9MHdkyN8z/wlCSEEO7c/owOku0bBu1ulxLWXE=;
        b=cEDYrD8E1z5PrKNynxNg0lrFYo5k2HwT7OuOmQfPxS4iEn30Ac4F4UEPBiP/ja0rKl
         qvPN+/gCNo8kkL4OYZA79EzqRDRAnPFDyniOtzoE44i8J90AiFG4gXwVVljxoxgmAUou
         dhKIe/yt4QVfEOg+pmlFzuJlF9jko/uDMuryWbveRtTRrpAsOHHzNnNBbgqpIxVDUSjR
         RYq0ITSX9x/rrcavawBDpSj1/6UdayRdH8TxrIvsPZGw276fywqubVfuWN5oFx6C/bT2
         3eoqN0c4LqwjupALW1U3n+OcpXPuarHksSOs2b3NyqYdRZHJ4gIDpNAsl8mdr+Ep+XhR
         EAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GncgTa9MHdkyN8z/wlCSEEO7c/owOku0bBu1ulxLWXE=;
        b=GN9as9hLizSx22Xgwu/Sp1C3bufq7qDihlKg8ngJ7D2ta+N50zhjZHoeaAVFWsVIxH
         mbhh6l0bQB7ewUBA6UKxpPQ6aYcMnqXiIA4XvdD9HBcWRt4YavqoRKlF3twZ2xvKAh6U
         tEVBYfZbTCW8RMsmZucYN6ZIFA10wc3J0nnon+9Gkj3MGyvEH8qyI86RgASkNr9F5v6Z
         PNNsTi4eEKcBzA2B2shnN5E6jY7xyH1UzFX1F4e0+2C0GzZbEZWUOVQ78BiKujDMtaan
         Ur3crKjdCRUQu1Vh/8GY0ZyZt/U6Ck1m6GmnhH/H4Mpy9MwzM9Zq9JUAsW0U62Tg1pc+
         Vulg==
X-Gm-Message-State: AFqh2kpc0W6VsYcJ2K0zL0zNGhGFNb1l1kBud1G+V+J7NEL8xrRO13Wf
        sGQXbtH/BuPHIG5c9UMZBGCvJdHDsxbYg3K5
X-Google-Smtp-Source: AMrXdXvHyaCuHgbFtXhiMlsxn34c/LvkxHzfnXWjt6YTc9PmB5ryPQ+1cdxQLwC2kyWfwWbOiSYvtg==
X-Received: by 2002:a05:6e02:ef3:b0:30d:91e9:4540 with SMTP id j19-20020a056e020ef300b0030d91e94540mr19147763ilk.22.1673654893369;
        Fri, 13 Jan 2023 16:08:13 -0800 (PST)
Received: from google.com ([2620:15c:183:200:8579:d15f:baaf:1133])
        by smtp.gmail.com with ESMTPSA id a12-20020a92d10c000000b002eb3b43cd63sm6429851ilb.18.2023.01.13.16.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 16:08:12 -0800 (PST)
Date:   Fri, 13 Jan 2023 17:08:09 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] tracing: Allow boot instances to have snapshot
 buffers
Message-ID: <Y8HyaeNeWvDlBshg@google.com>
References: <20230111145636.450953217@goodmis.org>
 <20230111145842.847715402@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111145842.847715402@goodmis.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:56:40AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Add to ftrace_boot_snapshot, "=<instance>" name, where the instance will
> get a snapshot buffer, and will take a snapshot at the end of boot (which
> will save the boot traces).
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  9 +++
>  kernel/trace/trace.c                          | 77 +++++++++++++++++--
>  2 files changed, 79 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7a7f41652719..f4e87b17427f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1532,6 +1532,15 @@
>  			boot up that is likely to be overridden by user space
>  			start up functionality.
>  
> +			Optionally, the snapshot can also be defined for a tracing
> +			instance that was created by the trace_instance= command
> +			line parameter.
> +
> +			trace_instance=foo,sched_switch ftrace_boot_snapshot=foo
> +
> +			The above will cause the "foo" tracing instance to trigger
> +			a snapshot at the end of boot up.
> +
>  	ftrace_dump_on_oops[=orig_cpu]
>  			[FTRACE] will dump the trace buffers on oops.
>  			If no parameter is passed, ftrace will dump
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 3cb9bbc0f076..d445789dc247 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -192,6 +192,9 @@ static bool snapshot_at_boot;
>  static char boot_instance_info[COMMAND_LINE_SIZE] __initdata;
>  static int boot_instance_index;
>  
> +static char boot_snapshot_info[COMMAND_LINE_SIZE] __initdata;

For x86 machines at least COMMAND_LINE_SIZE is pretty big (2048), so between
boot_instance_info and boot_snapshot_info we are using an entire 4k of memory.
It seems unlikely that any user would need a string this long for these
options.  Should we trim this down to something smaller?

> +static int boot_snapshot_index;
> +
>  static int __init set_cmdline_ftrace(char *str)
>  {
>  	strlcpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
> @@ -228,9 +231,22 @@ __setup("traceoff_on_warning", stop_trace_on_warning);
>  
>  static int __init boot_alloc_snapshot(char *str)
>  {
> -	allocate_snapshot = true;
> -	/* We also need the main ring buffer expanded */
> -	ring_buffer_expanded = true;
> +	char *slot = boot_snapshot_info + boot_snapshot_index;
> +	int left = COMMAND_LINE_SIZE - boot_snapshot_index;

sizeof(boot_snapshot_info) is a bit safer than COMMAND_LINE_SIZE so they don't
get out of sync, plus we may also want to shrink it a bit as mentioned above.

Just two nits, other than that you can add:

Reviewed-by: Ross Zwisler <zwisler@google.com>
