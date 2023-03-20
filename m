Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F336C1100
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjCTLjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCTLjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:39:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF9716326
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nTPJriVz5UF1q5+zsnxgQEHEGS+3iwP7PgvNgGkR9sY=; b=VD0cf4VZWH3PBijArUHmJcoRIa
        sISG8p5S8u7ZStHlwSQ0ZeuJDnvdIfv7L7XkOkIvhheVG5LTs1/y46QYmmYpQJ1zh3etCMvF14IXn
        q8xoPmZSMk0KTfKqiV26MURaq+0A+d7Oo6W3Co+6fMXg0rhRbfvMjmFKALGhnkfB639nAFvS8HqXv
        TGZOc37TXs1cjmMONDsaAjkSYCinsbSgHtZP+u2o3Zeens3si1A0+3Aovh8emHGMkaWDlNVqiHS2M
        Xzs2FGqYhlOIu6xSpt8ZXoRS0NIprd1sPcH5gddOrKOwdDevsrhSZ1S++VlMDzJKzK9SH26/LV333
        gyoczKmw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peDr7-003u9L-2C;
        Mon, 20 Mar 2023 11:39:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78DDF30006D;
        Mon, 20 Mar 2023 12:39:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 603E2209F7546; Mon, 20 Mar 2023 12:39:10 +0100 (CET)
Date:   Mon, 20 Mar 2023 12:39:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Minor optimize pick_next_task() when
 core-sched enable
Message-ID: <20230320113910.GI2194297@hirez.programming.kicks-ass.net>
References: <20230308100414.37114-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308100414.37114-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 06:04:13PM +0800, Hao Jia wrote:

> core max: task2 (cookie 0)
> 
> 	rq0				rq1
> task0(cookie non-zero)		task2(cookie 0)
> task1(cookie 0)
> task3(cookie 0)
> ...
> 
> pick-task: idle			pick-task: task2
> 
> CPU0 and CPU1 are two CPUs on the same core, task0 and task2 are the
> highest priority tasks on rq0 and rq1 respectively, task2 is @max
> on the entire core.

I'm assuming this all starts by rq0 doing a pick and getting task0.
Because any other selection would go down the whole !need_sync route.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index af017e038b48..765cd14c52e1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -236,8 +236,8 @@ void sched_core_enqueue(struct rq *rq, struct task_struct *p)
>  {
>  	rq->core->core_task_seq++;
>  
> -	if (!p->core_cookie)
> -		return;
> +	if (p->core_cookie)
> +		rq->cookied_count++;
>  
>  	rb_add(&p->core_node, &rq->core_tree, rb_sched_core_less);
>  }

> @@ -2061,14 +2066,12 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>  	uclamp_rq_inc(rq, p);
>  	p->sched_class->enqueue_task(rq, p, flags);
>  
> -	if (sched_core_enabled(rq))
> -		sched_core_enqueue(rq, p);
> +	sched_core_enqueue(rq, p);
>  }
>  
>  static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  {
> -	if (sched_core_enabled(rq))
> -		sched_core_dequeue(rq, p, flags);
> +	sched_core_dequeue(rq, p, flags);
>  
>  	if (!(flags & DEQUEUE_NOCLOCK))
>  		update_rq_clock(rq);

Yeah, this is an absolute no-no, it makes the overhead of the second rb
tree unconditional.

