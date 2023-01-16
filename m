Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B8666BB14
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjAPKAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjAPKA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:00:28 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B6A193D5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pSkrv3YbEiuXx+uJYXz+N4nLE3VKAnEgFezFR+dKrhw=; b=EGB8C5l9gmr++MEbL3fxDdT3X6
        1lBasx3pKcYGJnr1Z36+CVExAi2CAqG3ZvnCRRN7VosaPe7R7dE0cqMtHtfe6ZPXwEVpRFD7JKr83
        C12SPWSbD2Njx0jON8eEf3Lca19Z0CvQoxSgfig+ubWTa6euwfP0ordV4GiFuMM+cgmhdn5N0s5TC
        ELK6J7bzcmGQHYw6T2gdyEttl4jNOrHyDO+GuHj7XDgHTuaMfMTHEjOrZiGvySzfHOWXyrX0/MkHW
        EHv+5vdBEIirV+1GJaScqwkPpRB7TyFgeJXsRecYIlts6SzkL6X7n4BazsEeIiSaatDO62UQv2OJk
        9x6pUCaw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pHMH0-005YSP-2y;
        Mon, 16 Jan 2023 09:59:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF7DF3005C9;
        Mon, 16 Jan 2023 10:59:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0FD3209684D4; Mon, 16 Jan 2023 10:59:34 +0100 (CET)
Date:   Mon, 16 Jan 2023 10:59:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrei Vagin <avagin@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 3/5] sched: add a few helpers to wake up tasks on the
 current cpu
Message-ID: <Y8UgBnsaGDUJKH5A@hirez.programming.kicks-ass.net>
References: <20230110213010.2683185-1-avagin@google.com>
 <20230110213010.2683185-4-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110213010.2683185-4-avagin@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:30:08PM -0800, Andrei Vagin wrote:

> diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
> index d57a5c1c1cd9..a1931a79c05a 100644
> --- a/kernel/sched/completion.c
> +++ b/kernel/sched/completion.c
> @@ -38,6 +38,18 @@ void complete(struct completion *x)
>  }
>  EXPORT_SYMBOL(complete);
>  
> +void complete_on_current_cpu(struct completion *x)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&x->wait.lock, flags);
> +
> +	if (x->done != UINT_MAX)
> +		x->done++;
> +	swake_up_locked_on_current_cpu(&x->wait);
> +	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
> +}
> +
>  /**
>   * complete_all: - signals all threads waiting on this completion
>   * @x:  holds the state of this particular completion
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6478e819eb99..c81866821139 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6874,7 +6874,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
>  int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
>  			  void *key)
>  {
> -	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~WF_SYNC);
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~(WF_SYNC|WF_CURRENT_CPU));
>  	return try_to_wake_up(curr->private, mode, wake_flags);
>  }
>  EXPORT_SYMBOL(default_wake_function);
> diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
> index 76b9b796e695..9ebe23868942 100644
> --- a/kernel/sched/swait.c
> +++ b/kernel/sched/swait.c
> @@ -31,6 +31,17 @@ void swake_up_locked(struct swait_queue_head *q)
>  }
>  EXPORT_SYMBOL(swake_up_locked);
>  
> +void swake_up_locked_on_current_cpu(struct swait_queue_head *q)
> +{
> +	struct swait_queue *curr;
> +
> +	if (list_empty(&q->task_list))
> +		return;
> +
> +	curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
> +	try_to_wake_up(curr->task, TASK_NORMAL, WF_CURRENT_CPU);
> +	list_del_init(&curr->task_list);
> +}
>  /*
>   * Wake up all waiters. This is an interface which is solely exposed for
>   * completions and not for general usage.
> diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> index 133b74730738..47803a0b8d5d 100644
> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -161,6 +161,11 @@ int __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
>  }
>  EXPORT_SYMBOL(__wake_up);
>  
> +void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key)
> +{
> +	__wake_up_common_lock(wq_head, mode, 1, WF_CURRENT_CPU, key);
> +}
> +
>  /*
>   * Same as __wake_up but called with the spinlock in wait_queue_head_t held.
>   */

So I hate this patch, it adds a whole ton of duplication and litter for
no real reason afaict. For instance you could've just added an
wake_flags argument to swake_up_locked(), there's not *that* many users
-- unlike complete().

And for complete() instead of fully duplicating the function (always a
bad idea) you could've made complete_flags() and implemented complete()
using that, or something.

Anyway, let me go (finally) have a look at Chen's patch, since that
might render all this moot.
