Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE74F738415
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjFUMuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFUMt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:49:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3447E1717
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=it4tIdpf5jOikItcZr08bwjYpppdq0e5sYWTKZMlD+4=; b=a0s2e4KSnXVMnG2b0QaiSW3udS
        nmonkYFxU2qJnFJifAk1Tt7SNIvLWZzCTjGgSK55sZ02sX2mZE7VCi/lPid/qeqYMTn8qmzv8sukj
        Pqw2E689jPsUrsW29NF9iqrs/qRARsqtUNB8W35NSumpT3ACc5O+cgOGw7YSGJldlMhAyOrUAJPUt
        4QNBS7Kohw1/+TCUhSAj+qxI8F3FK+Rzuk0YZziKml9Pfr3LTtaInPfb70XABvT0OynPy2vvgRBhZ
        NxL9LAlWSkLB7Romp7p5t7cTPGmiQE4/OfnN3HzEqFN3Xn2MvsVJUEijjv2VMUgGPPLroJFnpwm7D
        ADmrrpQA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBxHD-00HS0f-1k;
        Wed, 21 Jun 2023 12:49:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AEDC6300274;
        Wed, 21 Jun 2023 14:49:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 683A82130B3C6; Wed, 21 Jun 2023 14:49:33 +0200 (CEST)
Date:   Wed, 21 Jun 2023 14:49:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH 2/3] sched/fair: Add SWQUEUE sched feature and
 skeleton calls
Message-ID: <20230621124933.GE2053369@hirez.programming.kicks-ass.net>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-3-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613052004.2836135-3-void@manifault.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:20:03AM -0500, David Vernet wrote:

I can't help but read this thing as software-queue :/ Can we please pick
a better name?

> @@ -6368,6 +6390,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	if (!task_new)
>  		update_overutilized_status(rq);
>  
> +	if (sched_feat(SWQUEUE))
> +		swqueue_enqueue(rq, p, flags);
> +
>  enqueue_throttle:
>  	assert_list_leaf_cfs_rq(rq);
>  
> @@ -6449,6 +6474,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  dequeue_throttle:
>  	util_est_update(&rq->cfs, p, task_sleep);
>  	hrtick_update(rq);
> +
> +	if (sched_feat(SWQUEUE))
> +		swqueue_remove_task(p);
>  }
>  
>  #ifdef CONFIG_SMP

_enqueue() should obviously be complemented by _dequeue(). This naming
is offensive :-)

> @@ -8155,12 +8183,18 @@ done: __maybe_unused;
>  
>  	update_misfit_status(p, rq);
>  
> +	if (sched_feat(SWQUEUE))
> +		swqueue_remove_task(p);
> +
>  	return p;
>  
>  idle:
>  	if (!rf)
>  		return NULL;
>  
> +	if (sched_feat(SWQUEUE) && swqueue_pick_next_task(rq, rf))
> +		return RETRY_TASK;
> +
>  	new_tasks = newidle_balance(rq, rf);
>  
>  	/*

That's either not correct or insufficient or both.

It fails to consider the whole core-scheduling mess. But it also fails
to consider the regular (non optimized) pick case that should do newidle
through put_prev_task_balance() -> balance_fair().

I think placing the pick call in newidle_balance() itself is the
simplest solution.

