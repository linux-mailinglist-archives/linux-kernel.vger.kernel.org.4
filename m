Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853B16363BE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiKWPbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbiKWPbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:31:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332B47648;
        Wed, 23 Nov 2022 07:30:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C799C61DA1;
        Wed, 23 Nov 2022 15:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF62C433D7;
        Wed, 23 Nov 2022 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669217450;
        bh=qxiD6f09mDM/UjBI4O3tDzawaA36nwGekM2uCLPRvQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZQ9uIIdNi/YxP6NOhvbUDULqC1WcioBOdMtNv6k4LhSAfk8iJA1ri9BqEaAlJGTii
         1MKrsme+/dXJzBcXwLuaxHuzYuI/MjUv/1hILDuqymyjYeYgIeuC0fCikado4DKQ/Q
         XCI5w9EXyDGoUgBSFAX7K1n8o0qZaqVu3lQRVMMzYK5pjb2rmfd3JIIAUWtqyOJBtC
         HlP3i++EQixkiSvbuMwgcdNgRj3vaer0paptGvyMRiJDP94LeE2NO4fUNBx4B4a/Tf
         zqddJHdd9kpIUCh8LPwutin+Pvey9F04tsZiTMd7lddx9LVQ12zxr0ixE5H/Vbbhzg
         6tnrvEd4HK3rA==
Date:   Thu, 24 Nov 2022 00:30:47 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Song Shuai <suagrfillet@gmail.com>
Subject: Re: [PATCH] ftrace: Avoid needless updates of the ftrace function
 call
Message-Id: <20221124003047.827b6ef942b0dc529face3b9@kernel.org>
In-Reply-To: <20221122180905.737b6f52@gandalf.local.home>
References: <20221122180905.737b6f52@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 18:09:05 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Song Shuai reported:
> 
>     The list func (ftrace_ops_list_func) will be patched first
>     before the transition between old and new calls are set,
>     which fixed the race described in this commit `59338f75`.
> 
>     While ftrace_trace_function changes from the list func to a
>     ftrace_ops func, like unregistering the klp_ops to leave the only
>     global_ops in ftrace_ops_list, the ftrace_[regs]_call will be
>     replaced with the list func although it already exists. So there
>     should be a condition to avoid this.
> 
> And suggested using another variable to keep track of what the ftrace
> function is set to. But this could be simplified by using a helper
> function that does the same with a static variable.
> 
> Link: https://lore.kernel.org/lkml/20221026132039.2236233-1-suagrfillet@gmail.com/
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Reported-by: Song Shuai <suagrfillet@gmail.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ftrace.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 65a5d36463e0..d04552c0c275 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2763,6 +2763,19 @@ void __weak ftrace_arch_code_modify_post_process(void)
>  {
>  }
>  
> +static int update_ftrace_func(ftrace_func_t func)
> +{
> +	static ftrace_func_t save_func;
> +
> +	/* Avoid updating if it hasn't changed */
> +	if (func == save_func)
> +		return 0;
> +
> +	save_func = func;
> +
> +	return ftrace_update_ftrace_func(func);
> +}
> +
>  void ftrace_modify_all_code(int command)
>  {
>  	int update = command & FTRACE_UPDATE_TRACE_FUNC;
> @@ -2783,7 +2796,7 @@ void ftrace_modify_all_code(int command)
>  	 * traced.
>  	 */
>  	if (update) {
> -		err = ftrace_update_ftrace_func(ftrace_ops_list_func);
> +		err = update_ftrace_func(ftrace_ops_list_func);
>  		if (FTRACE_WARN_ON(err))
>  			return;
>  	}
> @@ -2799,7 +2812,7 @@ void ftrace_modify_all_code(int command)
>  		/* If irqs are disabled, we are in stop machine */
>  		if (!irqs_disabled())
>  			smp_call_function(ftrace_sync_ipi, NULL, 1);
> -		err = ftrace_update_ftrace_func(ftrace_trace_function);
> +		err = update_ftrace_func(ftrace_trace_function);
>  		if (FTRACE_WARN_ON(err))
>  			return;
>  	}
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
