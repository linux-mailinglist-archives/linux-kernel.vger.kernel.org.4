Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFE76349B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 22:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiKVV7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 16:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiKVV7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:59:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DB7716CD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 13:59:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B20618EE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 21:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7266C433C1;
        Tue, 22 Nov 2022 21:59:39 +0000 (UTC)
Date:   Tue, 22 Nov 2022 16:59:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        revest@chromium.org
Subject: Re: [PATCH 2/3] ftrace: export ftrace_free_filter() to modules
Message-ID: <20221122165938.353ee7c0@gandalf.local.home>
In-Reply-To: <20221103170907.931465-3-mark.rutland@arm.com>
References: <20221103170907.931465-1-mark.rutland@arm.com>
        <20221103170907.931465-3-mark.rutland@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Nov 2022 17:09:06 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

FYI, the subject should start with a capital letter.

  ftrace: Export ftrace_free_filter() to modules


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
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Florent Revest <revest@chromium.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/ftrace.c                       | 23 ++++++++++++++++++++-
>  samples/ftrace/ftrace-direct-multi-modify.c |  1 +
>  samples/ftrace/ftrace-direct-multi.c        |  1 +
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index fbf2543111c05..1ecdda1df6d47 100644
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
> @@ -5837,6 +5842,10 @@ EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi);
>   *
>   * Filters denote which functions should be enabled when tracing is enabled
>   * If @ip is NULL, it fails to update filter.
> + *
> + * This can allocate memory which must be freed before @ops can be freed,
> + * either by remvoing eached filtered addr or by using
> + * ftrace_free_filter(@ops).
>   */
>  int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
>  			 int remove, int reset)
> @@ -5856,7 +5865,11 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter_ip);
>   *
>   * Filters denote which functions should be enabled when tracing is enabled
>   * If @ips array or any ip specified within is NULL , it fails to update filter.
> - */
> + *
> + * This can allocate memory which must be freed before @ops can be freed,
> + * either by remvoing eached filtered addr or by using
> + * ftrace_free_filter(@ops).
> +*/
>  int ftrace_set_filter_ips(struct ftrace_ops *ops, unsigned long *ips,
>  			  unsigned int cnt, int remove, int reset)
>  {
> @@ -5898,6 +5911,10 @@ ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
>   *
>   * Filters denote which functions should be enabled when tracing is enabled.
>   * If @buf is NULL and reset is set, all functions will be enabled for tracing.
> + *
> + * This can allocate memory which must be freed before @ops can be freed,
> + * either by remvoing eached filtered addr or by using
> + * ftrace_free_filter(@ops).
>   */
>  int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
>  		       int len, int reset)
> @@ -5917,6 +5934,10 @@ EXPORT_SYMBOL_GPL(ftrace_set_filter);
>   * Notrace Filters denote which functions should not be enabled when tracing
>   * is enabled. If @buf is NULL and reset is set, all functions will be enabled
>   * for tracing.
> + *
> + * This can allocate memory which must be freed before @ops can be freed,
> + * either by remvoing eached filtered addr or by using

I love how you cut and pasted two typos four times. ;-)

-- Steve

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

