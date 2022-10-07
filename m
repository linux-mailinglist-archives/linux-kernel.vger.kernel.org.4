Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0AC5F7241
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 02:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiJGA2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 20:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiJGA2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:28:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77355BA243
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 17:28:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3887BB821DC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B55C433D6;
        Fri,  7 Oct 2022 00:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665102526;
        bh=XCLkTzT/aVfQF7+vbgtMBvodMvXDZOXGq3UghiMsY7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gzVzsWk3OMgeWOmUZfzO0IkOMi9dqF1qLLfK72mwmiSspuf1p3dO9BHLCAz2TpGk2
         j2HdvLKyrsZKVWcWN+i85tCASN54gvMYIlRq1GaQ49w7Zz3nm5koksuTr2PfL63QCn
         plmdg/ze6rwsoFl5jp5YsJBLYdc4ccgEbEBMHBoL8oCbRmVYf1ymuHPrPG0Bzusf6o
         1KC7JfG9oSG2r1Hl+Ar6ne3JXGqRMpaAHULsumO8jMeHd4PXceuaUVfiUR02eYzSaV
         +9ext4+ginHOotaSQAPU9jKb6QwVyDgg4S1xHMRXTsUMRBPPXV1OI0kMVRNW7qGfnb
         5vam9zcYB13fQ==
Date:   Fri, 7 Oct 2022 09:28:43 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] tracing: Do not free snapshot if tracer is on
 cmdline
Message-Id: <20221007092843.618d5a8276ef20d909ab9340@kernel.org>
In-Reply-To: <20221005113757.041df7fe@gandalf.local.home>
References: <20221005113757.041df7fe@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022 11:37:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The ftrace_boot_snapshot and alloc_snapshot cmdline options allocate the
> snapshot buffer at boot up for use later. The ftrace_boot_snapshot in
> particular requires the snapshot to be allocated because it will take a
> snapshot at the end of boot up allowing to see the traces that happened
> during boot so that it's not lost when user space takes over.
> 
> When a tracer is registered (started) there's a path that checks if it
> requires the snapshot buffer or not, and if it does not and it was
> allocated it will do a synchronization and free the snapshot buffer.
> 
> This is only required if the previous tracer was using it for "max
> latency" snapshots, as it needs to make sure all max snapshots are
> complete before freeing. But this is only needed if the previous tracer
> was using the snapshot buffer for latency (like irqoff tracer and
> friends). But it does not make sense to free it, if the previous tracer
> was not using it, and the snapshot was allocated by the cmdline
> parameters. This basically takes away the point of allocating it in the
> first place!
> 
> Note, the allocated snapshot worked fine for just trace events, but fails
> when a tracer is enabled on the cmdline.
> 
> Further investigation, this goes back even further and it does not require
> a tracer on the cmdline to fail. Simply enable snapshots and then enable a
> tracer, and it will remove the snapshot.
> 

This looks good to me :)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: stable@vger.kernel.org
> Fixes: 45ad21ca5530 ("tracing: Have trace_array keep track if snapshot buffer is allocated")
> Reported-by: Ross Zwisler <zwisler@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lkml.kernel.org/r/20221004180452.6cf967f8@gandalf.local.home
>   - Didn't notice that tr->current_trace was set to &nop_trace just before
>     testing if the last tracer had use_max_tr. Which would always be false
>     as it was testing the nop_trace.use_max_tr which is false.
> 
>  kernel/trace/trace.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index def721de68a0..47a44b055a1d 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6428,12 +6428,12 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  	if (tr->current_trace->reset)
>  		tr->current_trace->reset(tr);
>  
> +#ifdef CONFIG_TRACER_MAX_TRACE
> +	had_max_tr = tr->current_trace->use_max_tr;
> +
>  	/* Current trace needs to be nop_trace before synchronize_rcu */
>  	tr->current_trace = &nop_trace;
>  
> -#ifdef CONFIG_TRACER_MAX_TRACE
> -	had_max_tr = tr->allocated_snapshot;
> -
>  	if (had_max_tr && !t->use_max_tr) {
>  		/*
>  		 * We need to make sure that the update_max_tr sees that
> @@ -6446,11 +6446,13 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  		free_snapshot(tr);
>  	}
>  
> -	if (t->use_max_tr && !had_max_tr) {
> +	if (t->use_max_tr && !tr->allocated_snapshot) {
>  		ret = tracing_alloc_snapshot_instance(tr);
>  		if (ret < 0)
>  			goto out;
>  	}
> +#else
> +	tr->current_trace = &nop_trace;
>  #endif
>  
>  	if (t->init) {
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
