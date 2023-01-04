Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEEE65D695
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbjADOwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjADOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:51:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE11A2BD9;
        Wed,  4 Jan 2023 06:51:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DEF661778;
        Wed,  4 Jan 2023 14:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC9BC433F0;
        Wed,  4 Jan 2023 14:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672843913;
        bh=CFY5lmAxDCiA9GQJomfC84bDG7JMoINirecDbhFKtvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lhJnaS/wplVM5NfD0ruuniQtA58NLuNliwRjkME9CQmtT6KtYadBFZwqDWH0LTxdj
         UEBZmOA2cdIGNql9L+qafaGxQG+bIfR6J+f8J+7ivaw800frf/rNldKqoMC5nyXvUU
         RNvLsOqehubgwGVOlWIKz1NrtQ2dg0Jwlkh94LcwofKeiLyCYAAzVuQkRJz8Q0xV7j
         3WzUqwgxRxPcEtnaAT+0fBaUaHejOjnRlJe1pFk9tYPRgAbuxfyiWl6omZGYO7nAdX
         NXWuPB/ShKw721YjMxtXIGFN9RWT1x3r3v3uflKTqc6z+3igSIBE91SaKIRSTaybWG
         mrehK8hszxbkg==
Date:   Wed, 4 Jan 2023 23:51:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        revest@chromium.org, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ftrace: Export ftrace_free_filter() to modules
Message-Id: <20230104235149.2416d0b57f6fba0f2f31ba77@kernel.org>
In-Reply-To: <20230103124912.2948963-3-mark.rutland@arm.com>
References: <20230103124912.2948963-1-mark.rutland@arm.com>
        <20230103124912.2948963-3-mark.rutland@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Jan 2023 12:49:11 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> Setting filters on an ftrace ops results in some memory being allocated
> for the filter hashes, which must be freed before the ops can be freed.
> This can be done by removing every individual element of the hash by
> calling ftrace_set_filter_ip() or ftrace_set_filter_ips() with `remove`
> set, but this is somewhat error prone as it's easy to forget to remove
> an element.
> 
> Make it easier to clean this up by exporting ftrace_free_filter(), which
> can be used to clean up all of the filter hashes after an ftrace_ops has
> been unregistered.
> 
> Using this, fix the ftrace-direct* samples to free hashes prior to being
> unloaded. All other code either removes individual filters explicitly or
> is built-in and already calls ftrace_free_filter().

So, it seems to fix memory leaks. Then, it may need to go to stable.

Fixes: e1067a07cfbc ("ftrace/samples: Add module to test multi direct modify interface")
Fixes: 5fae941b9a6f ("ftrace/samples: Add multi direct interface test module")
Cc: stable@vger.kernel.org

And 

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Florent Revest <revest@chromium.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/ftrace.c                       | 23 ++++++++++++++++++++-
>  samples/ftrace/ftrace-direct-multi-modify.c |  1 +
>  samples/ftrace/ftrace-direct-multi.c        |  1 +
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 442438b93fe98..750aa3f08b25a 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1248,12 +1248,17 @@ static void free_ftrace_hash_rcu(struct ftrace_hash *hash)
>  	call_rcu(&hash->rcu, __free_ftrace_hash_rcu);
>  }
>  
> +/**
> + * ftrace_free_filter - remove all filters for an ftrace_ops
> + * @ops - the ops to remove the filters from
> + */
>  void ftrace_free_filter(struct ftrace_ops *ops)
>  {
>  	ftrace_ops_init(ops);
>  	free_ftrace_hash(ops->func_hash->filter_hash);
>  	free_ftrace_hash(ops->func_hash->notrace_hash);
>  }
> +EXPORT_SYMBOL_GPL(ftrace_free_filter);
>  
>  static struct ftrace_hash *alloc_ftrace_hash(int size_bits)
>  {
> @@ -5839,6 +5844,10 @@ EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi);
>   *
>   * Filters denote which functions should be enabled when tracing is enabled
>   * If @ip is NULL, it fails to update filter.
> + *
> + * This can allocate memory which must be freed before @ops can be freed,
> + * either by removing each filtered addr or by using
> + * ftrace_free_filter(@ops).
>   */
>  int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
>  			 int remove, int reset)
> @@ -5858,7 +5867,11 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter_ip);
>   *
>   * Filters denote which functions should be enabled when tracing is enabled
>   * If @ips array or any ip specified within is NULL , it fails to update filter.
> - */
> + *
> + * This can allocate memory which must be freed before @ops can be freed,
> + * either by removing each filtered addr or by using
> + * ftrace_free_filter(@ops).
> +*/
>  int ftrace_set_filter_ips(struct ftrace_ops *ops, unsigned long *ips,
>  			  unsigned int cnt, int remove, int reset)
>  {
> @@ -5900,6 +5913,10 @@ ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
>   *
>   * Filters denote which functions should be enabled when tracing is enabled.
>   * If @buf is NULL and reset is set, all functions will be enabled for tracing.
> + *
> + * This can allocate memory which must be freed before @ops can be freed,
> + * either by removing each filtered addr or by using
> + * ftrace_free_filter(@ops).
>   */
>  int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
>  		       int len, int reset)
> @@ -5919,6 +5936,10 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter);
>   * Notrace Filters denote which functions should not be enabled when tracing
>   * is enabled. If @buf is NULL and reset is set, all functions will be enabled
>   * for tracing.
> + *
> + * This can allocate memory which must be freed before @ops can be freed,
> + * either by removing each filtered addr or by using
> + * ftrace_free_filter(@ops).
>   */
>  int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
>  			int len, int reset)
> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
> index d52370cad0b6e..a825dbd2c9cfd 100644
> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> @@ -152,6 +152,7 @@ static void __exit ftrace_direct_multi_exit(void)
>  {
>  	kthread_stop(simple_tsk);
>  	unregister_ftrace_direct_multi(&direct, my_tramp);
> +	ftrace_free_filter(&direct);
>  }
>  
>  module_init(ftrace_direct_multi_init);
> diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
> index ec1088922517d..d955a26506053 100644
> --- a/samples/ftrace/ftrace-direct-multi.c
> +++ b/samples/ftrace/ftrace-direct-multi.c
> @@ -79,6 +79,7 @@ static int __init ftrace_direct_multi_init(void)
>  static void __exit ftrace_direct_multi_exit(void)
>  {
>  	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
> +	ftrace_free_filter(&direct);
>  }
>  
>  module_init(ftrace_direct_multi_init);
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
