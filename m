Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA387635B78
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiKWLUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiKWLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:20:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F2E25EB4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dh9okv0CFmE+7ITwvD24RMqqbe+1nNONuHmqI/QVkSs=; b=mcedh0OUT1NlyQZX9hfP6f5sat
        9bc4h2L1lSW0gdrrw/ZuD33Tqby4xtLC4gIU90IgcqSnCBVvQ5kijL7jfGV86aVF03TPYcAHbTRir
        R2VKUZw9vSIuklE0kEhRnjUsoSubJsd9wzQPmv0/dteksBkquAjqTa0OHDutDcGLegDGV7jcrde0E
        sTHsubwa05eR3cJmCFZxkKQEVNtHkDY+lnKHVNTiOsIqA6SX+QSe0LOJi3XQO5vjpLzaBaWL1nP+M
        GaVMg5ibYSj8mYJv4u2FUjZc0Pyg5dYJtn3Hkc8o0hByqlY3yPz2WQYO8oh2XbkcVXOaGrEfeTYg2
        UicYHFcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxnnO-003lRH-3t; Wed, 23 Nov 2022 11:20:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACDDB30034E;
        Wed, 23 Nov 2022 12:20:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BA0520B6C71D; Wed, 23 Nov 2022 12:20:00 +0100 (CET)
Date:   Wed, 23 Nov 2022 12:20:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix NULL user_cpus_ptr check in
 dup_user_cpus_ptr()
Message-ID: <Y34B4N7fzWylFV94@hirez.programming.kicks-ass.net>
References: <20221122190653.818506-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122190653.818506-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:06:53PM -0500, Waiman Long wrote:
> In general, a non-null user_cpus_ptr will remain set until the task dies.
> A possible exception to this is the fact that do_set_cpus_allowed()
> will clear a non-null user_cpus_ptr. To allow this possible racing
> condition, we need to check for NULL user_cpus_ptr under the pi_lock
> before duping the user mask.
> 
> Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/core.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8df51b08bb38..f447a6285ea2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2625,7 +2625,14 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
>  		      int node)
>  {
>  	unsigned long flags;
> +	cpumask_t *user_mask = NULL;

The inverse xmas tree is sad :-(

>  
> +	/*
> +	 * If there is a concurrent sched_setaffinity(), we may miss the
> +	 * newly updated user_cpus_ptr. However, a non-NULL user_cpus_ptr
> +	 * is relatively unlikely and it is not worth the extra overhead
> +	 * of taking the pi_lock on every fork/clone.
> +	 */

I think the correct argument is saying the thing is racy and loosing the
race is a valid situation. IOW, this is the same as if the concurrent
sched_setaffinity() happens after fork().

>  	if (!src->user_cpus_ptr)
>  		return 0;
>  
> @@ -2633,10 +2640,22 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
>  	if (!dst->user_cpus_ptr)
>  		return -ENOMEM;
>  
> -	/* Use pi_lock to protect content of user_cpus_ptr */
> +	/*
> +	 * Use pi_lock to protect content of user_cpus_ptr
> +	 *
> +	 * Though unlikely, user_cpus_ptr can be reset to NULL by a concurrent
> +	 * do_set_cpus_allowed().
> +	 */
>  	raw_spin_lock_irqsave(&src->pi_lock, flags);
> +	if (src->user_cpus_ptr)
> +		cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
> +	else
> +		swap(dst->user_cpus_ptr, user_mask);

Uhhhh, did you mean to write:

	if (src->user_cpus_ptr) {
		cpumask_copy(user_mask, src->user_cpus_ptr);
		swap(dst->user_cpus_ptr, user_mask);
	}

?

>  	raw_spin_unlock_irqrestore(&src->pi_lock, flags);
> +
> +	if (unlikely(user_mask))
> +		kfree(user_mask);
> +
>  	return 0;
>  }
>  
> -- 
> 2.31.1
> 
