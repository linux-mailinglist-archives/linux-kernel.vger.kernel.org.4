Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D107617102
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKBWyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiKBWx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:53:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F2DF80;
        Wed,  2 Nov 2022 15:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AD8FB82521;
        Wed,  2 Nov 2022 22:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB4AC433C1;
        Wed,  2 Nov 2022 22:53:50 +0000 (UTC)
Date:   Wed, 2 Nov 2022 18:53:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Fix use-after-free for dynamic ftrace_ops
Message-ID: <20221102185348.40f9deab@rorschach.local.home>
In-Reply-To: <20221101064146.69551-1-lihuafei1@huawei.com>
References: <20221101064146.69551-1-lihuafei1@huawei.com>
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

On Tue, 1 Nov 2022 14:41:46 +0800
Li Huafei <lihuafei1@huawei.com> wrote:


> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index fbf2543111c0..4219cc2a04a6 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3030,13 +3030,16 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
>  
>  	if (!command || !ftrace_enabled) {

ftrace_enabled is seldom not set. I don't think we even need to check
it. It's just the value of /proc/sys/kernel/ftrace_enabled, where most
people don't even know that file exists. I do want to get rid of it one
day too. So let's not optimize for it.

>  		/*
> -		 * If these are dynamic or per_cpu ops, they still
> -		 * need their data freed. Since, function tracing is
> -		 * not currently active, we can just free them
> -		 * without synchronizing all CPUs.
> +		 * If these are dynamic, they still need their data freed. If
> +		 * function tracing is currently active, we neet to synchronize
> +		 * all CPUs before we can release them.
>  		 */
> -		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
> +		if (ops->flags & FTRACE_OPS_FL_DYNAMIC) {
> +			if (ftrace_enabled)
> +				goto sync_rcu;
> +
>  			goto free_ops;

Change the above just to "goto out;"

> +		}
>  
>  		return 0;
>  	}
> @@ -3083,6 +3086,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
>  	 * ops.
>  	 */

Add here:

 out:

>  	if (ops->flags & FTRACE_OPS_FL_DYNAMIC) {
> + sync_rcu:
>  		/*
>  		 * We need to do a hard force of sched synchronization.
>  		 * This is because we use preempt_disable() to do RCU, but

And get rid of the labels in the if block.

Thanks!

-- Steve
