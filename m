Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3117A749311
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjGFB1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 21:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGFB1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB137102;
        Wed,  5 Jul 2023 18:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58823617F0;
        Thu,  6 Jul 2023 01:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07823C433C7;
        Thu,  6 Jul 2023 01:26:59 +0000 (UTC)
Date:   Wed, 5 Jul 2023 21:26:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] fprobe: Ensure running fprobe_exit_handler() finished
 before calling rethook_free()
Message-ID: <20230705212657.5968daf7@gandalf.local.home>
In-Reply-To: <168796344232.46347.7947681068822514750.stgit@devnote2>
References: <20230628012305.978e34d44f1a53fe20327fde@kernel.org>
        <168796344232.46347.7947681068822514750.stgit@devnote2>
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

On Wed, 28 Jun 2023 23:44:02 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Ensure running fprobe_exit_handler() has finished before
> calling rethook_free() in the unregister_fprobe() so that caller can free
> the fprobe right after unregister_fprobe().
> 
> unregister_fprobe() ensured that all running fprobe_entry/exit_handler()
> have finished by calling unregister_ftrace_function() which synchronizes
> RCU. But commit 5f81018753df ("fprobe: Release rethook after the
> ftrace_ops is unregistered") changed to call rethook_free() after
> unregister_ftrace_function(). So call rethook_stop() to make rethook
> disabled before unregister_ftrace_function() and ensure it again.

I'm confused. I still don't understand why it is bad to call
unregister_ftrace_function() *before* rethook_free().

Can you show the race condition you are trying to avoid?

-- Steve



> 
> Fixes: 5f81018753df ("fprobe: Release rethook after the ftrace_ops is
> unregistered") Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  include/linux/rethook.h |    1 +
>  kernel/trace/fprobe.c   |    3 +++
>  kernel/trace/rethook.c  |   13 +++++++++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/include/linux/rethook.h b/include/linux/rethook.h
> index c8ac1e5afcd1..bdbe6717f45a 100644
> --- a/include/linux/rethook.h
> +++ b/include/linux/rethook.h
> @@ -59,6 +59,7 @@ struct rethook_node {
>  };
>  
>  struct rethook *rethook_alloc(void *data, rethook_handler_t handler);
> +void rethook_stop(struct rethook *rh);
>  void rethook_free(struct rethook *rh);
>  void rethook_add_node(struct rethook *rh, struct rethook_node *node);
>  struct rethook_node *rethook_try_get(struct rethook *rh);
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 0121e8c0d54e..75517667b54f 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -364,6 +364,9 @@ int unregister_fprobe(struct fprobe *fp)
>  		    fp->ops.saved_func != fprobe_kprobe_handler))
>  		return -EINVAL;
>  
> +	if (fp->rethook)
> +		rethook_stop(fp->rethook);
> +
>  	ret = unregister_ftrace_function(&fp->ops);
>  	if (ret < 0)
>  		return ret;
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index 60f6cb2b486b..468006cce7ca 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -53,6 +53,19 @@ static void rethook_free_rcu(struct rcu_head *head)
>  		kfree(rh);
>  }
>  
> +/**
> + * rethook_stop() - Stop using a rethook.
> + * @rh: the struct rethook to stop.
> + *
> + * Stop using a rethook to prepare for freeing it. If you want to wait
> for
> + * all running rethook handler before calling rethook_free(), you need to
> + * call this first and wait RCU, and call rethook_free().
> + */
> +void rethook_stop(struct rethook *rh)
> +{
> +	WRITE_ONCE(rh->handler, NULL);
> +}
> +
>  /**
>   * rethook_free() - Free struct rethook.
>   * @rh: the struct rethook to be freed.

