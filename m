Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D76D6C1245
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjCTMsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjCTMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:47:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0F113DCC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XLBp9z4jHPXPhyEKm/QB9i8pKLEI2J2Xgwp1nVh26q0=; b=kDIEVwdOeBKP8nq2/lRplFdVGg
        uomGRPfJxp6l/2XAC4F+sthbf9+ffFa+ub1gKAwUK1VKx/q4YJe/UDwvFNjUG3jzRiaesPqrc4QCy
        3DGZdxAt7KbSnjsr14GUtFDjn5Eo3OcM6R9BVHNfyeOkQtzOodJN/hjAhrDDhH68Lp+NwrN+mx01J
        L0oV0gzA99Bstfyo3aIru+DCtscjd3Q+Mmgl3bHXQjpEjuIGG/HiIAuUDKF85/Ej2CAHmXEaIDvjH
        IFRWAjxtPTj34h3ePoJyiGvKsCtVifMi1eknQW2VW6hzvsOYMUYvcN81IZhfsmhUAZ1SdprvSclUL
        +/c7Xsmw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1peEum-00123W-BC; Mon, 20 Mar 2023 12:47:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F15D30006D;
        Mon, 20 Mar 2023 13:47:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2EDF20EF49A0; Mon, 20 Mar 2023 13:47:01 +0100 (CET)
Date:   Mon, 20 Mar 2023 13:47:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
Subject: Re: [PATCH] sched/core: Avoid selecting the task that is throttled
 to run when core-sched enable
Message-ID: <20230320124701.GL2194297@hirez.programming.kicks-ass.net>
References: <20230316081806.69544-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316081806.69544-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 04:18:06PM +0800, Hao Jia wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index af017e038b48..27cb06e19b12 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -261,36 +261,51 @@ void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
>  		resched_curr(rq);
>  }
>  
> +static int sched_task_is_throttled(struct task_struct *p, int cpu)
>  {
> +	if (p->sched_class->task_is_throttled)
> +		return p->sched_class->task_is_throttled(p, cpu);
>  
> +	return 0;
>  }
>  
>  static struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
>  {
>  	struct rb_node *node = &p->core_node;
> +	int cpu = task_cpu(p);
> +
> +	do {
> +		node = rb_next(node);
> +		if (!node)
> +			return NULL;
> +
> +		p = container_of(node, struct task_struct, core_node);

I've changed this to __node_2_sc() to match the rest. It looks to have
been randomly not using it.

> +		if (p->core_cookie != cookie)
> +			return NULL;
> +	} while (sched_task_is_throttled(p, cpu));
> +
> +	return p;
> +}
>  
> +/*
> + * Find left-most (aka, highest priority) and unthrottled task matching @cookie.
> + * If no suitable task is found, NULL will be returned.
> + */
> +static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
> +{
> +	struct task_struct *p;
> +	struct rb_node *node;
> +
> +	node = rb_find_first((void *)cookie, &rq->core_tree, rb_sched_core_cmp);
>  	if (!node)
>  		return NULL;
>  
> +	p = __node_2_sc(node);
> +	if (!sched_task_is_throttled(p, rq->cpu))
> +		return p;
> +
> +	return sched_core_next(p, cookie);
>  }
>  
>  /*

OK, fair enough.


