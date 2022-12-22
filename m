Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6FA6546A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiLVTcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiLVTch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:32:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DCD18397
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nwuxfEC6Gb0vIq2Hbbxk0mRVcp59Q8gj8CXFGWgAiYo=; b=A4l9eEt8rW9W1OLxKT4mmvjtFc
        jflmKYCBenVw1W6DC8c1Y/2TkAE4jMyvqJFlKmNHOx4GXB9Yrr0TCDpe/g9/4xp52wM69Qw7iodP1
        lWRtpvN+Te09uzN/EO9eARArzKOx8AVbYxJSKy7XuRWup9QVPcHXJfVU/1uh94P4t+WzWrS6CTvXL
        6hsVpr5SryB5/oTaTSGjU1nAkJjYFhTbjpK7Ip/hshY6KbUB6W+6B5WxAxTViPwkbW6bi+ZROW/Qv
        JMtR51rTY5eMnHkj/J4lunoX6Xtlw9bhXXKawJyzDJ5M+uuAxV002KrjQOP6xMNe61B4BuaQMVmZj
        g5eouU3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p8RId-00Dwsy-2P;
        Thu, 22 Dec 2022 19:32:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69DDA300322;
        Thu, 22 Dec 2022 20:32:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4810420165191; Thu, 22 Dec 2022 20:32:16 +0100 (CET)
Date:   Thu, 22 Dec 2022 20:32:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-tip v3] sched: Use kfree_rcu() in do_set_cpus_allowed()
Message-ID: <Y6SwwNy2OMSjUlbT@hirez.programming.kicks-ass.net>
References: <20221205163936.2149640-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205163936.2149640-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 11:39:36AM -0500, Waiman Long wrote:
> Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
> do_set_cpus_allowed()") may call kfree() if user_cpus_ptr was previously
> set. Unfortunately, some of the callers of do_set_cpus_allowed()
> may have pi_lock held when calling it. So the following splats may be
> printed especially when running with a PREEMPT_RT kernel:
> 
>    WARNING: possible circular locking dependency detected
>    BUG: sleeping function called from invalid context
> 
> To avoid these problems, kfree_rcu() is used instead. An internal
> cpumask_rcuhead union is created for the sole purpose of facilitating
> the use of kfree_rcu() to free the cpumask.
> 
> Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/core.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
>  [v3: Fix build problem reported by kernel test robot]
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 57e5932f81a9..155b6cfe119a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2604,9 +2604,19 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
>  		.user_mask = NULL,
>  		.flags     = SCA_USER,	/* clear the user requested mask */
>  	};
> +	union cpumask_rcuhead {
> +		cpumask_t cpumask;
> +		struct rcu_head rcu;
> +	};
>  
>  	__do_set_cpus_allowed(p, &ac);
> -	kfree(ac.user_mask);
> +
> +	/*
> +	 * Because this is called with p->pi_lock held, it is not possible
> +	 * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
> +	 * kfree_rcu().
> +	 */
> +	kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
>  }
>  
>  int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
> @@ -8220,7 +8230,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>  	struct affinity_context ac;
>  	struct cpumask *user_mask;
>  	struct task_struct *p;
> -	int retval;
> +	int retval, size;
>  
>  	rcu_read_lock();
>  
> @@ -8253,7 +8263,11 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>  	if (retval)
>  		goto out_put_task;
>  
> -	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
> +	/*
> +	 * See do_set_cpus_allowed() for the rcu_head usage.
> +	 */
> +	size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
> +	user_mask = kmalloc(size, GFP_KERNEL);
>  	if (!user_mask) {
>  		retval = -ENOMEM;
>  		goto out_put_task;

AFAICT you forgot dup_user_cpus_ptr().
