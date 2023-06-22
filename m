Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA394739E91
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFVKaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjFVK36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:29:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985F9DD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NPh3ZaJO+nEQqur6ByBU93wIgiwSDAlUlEQx6GfhKnA=; b=lB+OkCGhc8YwI53q/BhGFf591R
        wJB0HX1MxO5qXtAmg2X6ZG+vbYV7MtviQtyVaIvCyN91xyC+z3VpmqPFc2oYRDzFwWO12onlDcvhv
        TxcIbycZ1xmt9lCQFQVhumSvm1HJwVJH7SPthUcqnc/Xy+h9RAEhsyeseME4NYGoZO7cw492KZQ9t
        Bh4bsO+gitFoB+5xS7ZeGXf7hlVOdkcDeRHtxWLi8vVtDVN4sfSjyInRS0u4KRhGIrPLTaF0szGmB
        RsntFhFRqhYZoTPN355NNRab5N7+29KH+9UKft1gobzm9l9FCppVGRwCOGSVBiR56/cGJHT6LQOuo
        iuqtYBZg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCHZJ-00FVvB-0T; Thu, 22 Jun 2023 10:29:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9EF03300222;
        Thu, 22 Jun 2023 12:29:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 814CF24216AD3; Thu, 22 Jun 2023 12:29:35 +0200 (CEST)
Date:   Thu, 22 Jun 2023 12:29:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230622102935.GG4253@hirez.programming.kicks-ass.net>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <ZI/x+RkSqpct4bM3@BLR-5CG11610CF.amd.com>
 <20230620200822.GC3027191@maniforge>
 <ZJKx/LQwc3bWS5nh@BLR-5CG11610CF.amd.com>
 <20230622014329.GD15990@maniforge>
 <ZJQQXQ/+p4f5FcAd@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJQQXQ/+p4f5FcAd@BLR-5CG11610CF.amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 02:41:57PM +0530, Gautham R. Shenoy wrote:

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -215,21 +215,17 @@ static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
>  {
>  	unsigned long flags;
>  	struct swqueue *swqueue;
> -	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> -	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
>  
>  	/*
>  	 * Only enqueue the task in the shared wakequeue if:
>  	 *
>  	 * - SWQUEUE is enabled
> -	 * - The task is on the wakeup path
> -	 * - The task wasn't purposefully migrated to the current rq by
> -	 *   select_task_rq()
> -	 * - The task isn't pinned to a specific CPU
> +	 * - select_idle_sibling() didn't find an idle CPU to enqueue this wakee task.
>  	 */
> -	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)

You lost the nr_cpus_allowed == 1 case, that actually made sense, except
he didn't don't have a hook in set_cpus_allowed() to fix it back up.

> +	if (!READ_ONCE(p->sched_add_to_swq))
>  		return;

So suppose we fill all CPUs with tasks T_{0..n-n1}, sis finds them a
nice idle cpu and we don't get queued.

Then wake up another n tasks T_{n...2n-1}, none of them find an idle
CPU, as per the above them all taken. These all do get queued.

However, suppose T>=n does a wakeup-preemption, and we end up with T>=n
running while T<n get queued on the rq, but not the 'queue' (I so hate
the swqueue name).

Then one CPU has both it's tasks go 'away' and becomes idle.

At this point the 'queue' contains only running tasks that are not
migratable and all the tasks that could be migrated are not on the queue
-- IOW it is completely useless.

Is this the intention?


