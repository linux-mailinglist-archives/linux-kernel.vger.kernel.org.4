Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F5F5F550A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiJENJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJENJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:09:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6676291B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AAF1614E6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63546C433C1;
        Wed,  5 Oct 2022 13:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664975339;
        bh=qiiNIC/FcrmgPHVzeRbsmdw3fo4HlqWZVydKa5k0ufc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gbd+AgUJeEO11daQ1mB7/fVvGriZ0uavf7o3pQTCjTEq3fB39R7FRX63gociEEkRI
         WnLz+Doti5RhX3zrBKw0Ki4HcqADRTb9aYUre+eJdQqfLARUFrMSirrqC0Dm/CVKd6
         Tj7L9oQqmjtvdhXp7Ss+ZJONyo0KqDXte5n05JVHpCA5r+4S7uAInTyIauadOt612+
         /eONjqJR8BvuVv9zsm+f0jywIqHJNuEE0RQeJ6rtiPPbTLVEb/CKb5F83/suGuCwI5
         87olLD9E/SwfmTJ0SJoBAXV6F+coTA18DwQv1B80Vwvfngt/dgHV5JIXnP+sQUfNuk
         3ffhOdvziETEw==
Date:   Wed, 5 Oct 2022 22:08:56 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@kernel.org>
Subject: Re: [PATCH] tracing: Do not free snapshot if tracer is on cmdline
Message-Id: <20221005220856.d2c2db5a499a79874f0c96e3@kernel.org>
In-Reply-To: <20221004180452.6cf967f8@gandalf.local.home>
References: <20221004180452.6cf967f8@gandalf.local.home>
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

On Tue, 4 Oct 2022 18:04:52 -0400
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
> Cc: stable@vger.kernel.org
> Fixes: 55034cd6e6481 ("tracing: Add alloc_snapshot kernel command line parameter")
> Reported-by: Ross Zwisler <zwisler@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index def721de68a0..871e2b592969 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6432,7 +6432,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  	tr->current_trace = &nop_trace;
>  
>  #ifdef CONFIG_TRACER_MAX_TRACE
> -	had_max_tr = tr->allocated_snapshot;
> +	had_max_tr = tr->current_trace->use_max_tr;
>  
>  	if (had_max_tr && !t->use_max_tr) {
>  		/*
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
