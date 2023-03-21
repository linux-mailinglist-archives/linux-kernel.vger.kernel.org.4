Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAA76C2E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCUJr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCUJrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:47:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD85141B64;
        Tue, 21 Mar 2023 02:47:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C714AD7;
        Tue, 21 Mar 2023 02:48:05 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.54.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18FAA3F766;
        Tue, 21 Mar 2023 02:47:19 -0700 (PDT)
Date:   Tue, 21 Mar 2023 09:47:17 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kpsingh@kernel.org, jolsa@kernel.org
Subject: Re: [PATCH 1/7] ftrace: Let unregister_ftrace_direct_multi() call
 ftrace_free_filter()
Message-ID: <ZBl9JahKr+50sBW0@FVFF77S0Q05N>
References: <20230316173811.1223508-1-revest@chromium.org>
 <20230316173811.1223508-2-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316173811.1223508-2-revest@chromium.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 06:38:05PM +0100, Florent Revest wrote:
> A common pattern when using the ftrace_direct_multi API is to unregister
> the ops and also immediately free its filter. We've noticed it's very
> easy for users to miss calling ftrace_free_filter().
> 
> This adds a "free_filters" argument to unregister_ftrace_direct_multi()
> to both remind the user they should free filters and also to make their
> life easier.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  include/linux/ftrace.h                      | 6 ++++--
>  kernel/bpf/trampoline.c                     | 2 +-
>  kernel/trace/ftrace.c                       | 6 +++++-
>  samples/ftrace/ftrace-direct-multi-modify.c | 3 +--
>  samples/ftrace/ftrace-direct-multi.c        | 3 +--
>  5 files changed, 12 insertions(+), 8 deletions(-)

This looks good to me; I see that the BPF code frees the filter in
bpf_trampoline_put(), so it not doing so via unregister_ftrace_direct_multi()
looks fine. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 366c730beaa3..5b68ee874bc1 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -407,7 +407,8 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
>  				unsigned long new_addr);
>  unsigned long ftrace_find_rec_direct(unsigned long ip);
>  int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
> -int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
> +int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
> +				   bool free_filters);
>  int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
>  int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr);
>  
> @@ -446,7 +447,8 @@ static inline int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned
>  {
>  	return -ENODEV;
>  }
> -static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> +static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
> +						 bool free_filters)
>  {
>  	return -ENODEV;
>  }
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index d0ed7d6f5eec..88bc23f1e10a 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -198,7 +198,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
>  	int ret;
>  
>  	if (tr->func.ftrace_managed)
> -		ret = unregister_ftrace_direct_multi(tr->fops, (long)old_addr);
> +		ret = unregister_ftrace_direct_multi(tr->fops, (long)old_addr, false);
>  	else
>  		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
>  
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 29baa97d0d53..fa379cf91fdb 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5804,7 +5804,8 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
>   *  0 on success
>   *  -EINVAL - The @ops object was not properly registered.
>   */
> -int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> +int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
> +				   bool free_filters)
>  {
>  	struct ftrace_hash *hash = ops->func_hash->filter_hash;
>  	int err;
> @@ -5822,6 +5823,9 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
>  	/* cleanup for possible another register call */
>  	ops->func = NULL;
>  	ops->trampoline = 0;
> +
> +	if (free_filters)
> +		ftrace_free_filter(ops);
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
> index b58c594efb51..196b43971cb5 100644
> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> @@ -151,8 +151,7 @@ static int __init ftrace_direct_multi_init(void)
>  static void __exit ftrace_direct_multi_exit(void)
>  {
>  	kthread_stop(simple_tsk);
> -	unregister_ftrace_direct_multi(&direct, my_tramp);
> -	ftrace_free_filter(&direct);
> +	unregister_ftrace_direct_multi(&direct, my_tramp, true);
>  }
>  
>  module_init(ftrace_direct_multi_init);
> diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
> index c27cf130c319..ea0e88ee5e43 100644
> --- a/samples/ftrace/ftrace-direct-multi.c
> +++ b/samples/ftrace/ftrace-direct-multi.c
> @@ -78,8 +78,7 @@ static int __init ftrace_direct_multi_init(void)
>  
>  static void __exit ftrace_direct_multi_exit(void)
>  {
> -	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
> -	ftrace_free_filter(&direct);
> +	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp, true);
>  }
>  
>  module_init(ftrace_direct_multi_init);
> -- 
> 2.40.0.rc2.332.ga46443480c-goog
> 
