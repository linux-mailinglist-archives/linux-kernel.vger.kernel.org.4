Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F389063447A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiKVTYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiKVTYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:24:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF86486A5D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=jA4n4p9rQf/drAVKOlr2dkYMa4NLh46iaSTEHTe01TI=; b=JnzcEgpAI/O3NLXSE8U13OIpoH
        bZhDFLDLbCXknGwemNcrMXrdKPENEOmpk7jh2eVna/e1QXb+oV6cQaVFLcbAfLJuywYC8B+lH3Fq5
        vxFQ5sWcWez98CaPHDpuqjhME7jgHhoku/sTrSE+O6hOJoduPHg9BGzmfOO5kXmf09/kb6h87Wvzr
        D+kpWxlp4WLibRB1DglN2Igb1qUu3Wr8z5IdnwPPjBkpYDNQMIraduDa/nzMh0wn0OKEMPLs4po3u
        vMMSPh8otIqcEdkS3CphG5Zb4SMzV1WdmfWMXh8j+MG03HImFguLuP9ixvoSvHaCIBw8NS8deEs60
        RARlBf7w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxYsO-006gGW-1r; Tue, 22 Nov 2022 19:24:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8919D300202;
        Tue, 22 Nov 2022 20:24:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47F9020B6C71D; Tue, 22 Nov 2022 20:24:04 +0100 (CET)
Date:   Tue, 22 Nov 2022 20:24:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH-tip] sched: Don't call kfree() in do_set_cpus_allowed()
Message-ID: <Y30h1NXFmDrHAXcy@hirez.programming.kicks-ass.net>
References: <20221118193302.522399-1-longman@redhat.com>
 <Y3tVPjAjE9OFRLaP@hirez.programming.kicks-ass.net>
 <601640d0-9dc2-a060-e165-c8efac54aa34@redhat.com>
 <Y3zCfQCpBu8aBy6O@hirez.programming.kicks-ass.net>
 <70b65b5b-385d-1c47-f003-1e42de290e86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70b65b5b-385d-1c47-f003-1e42de290e86@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:23:43AM -0500, Waiman Long wrote:
> index 78b2d5cabcc5..5fac4aa6ac7f 100644
> --- a/kernel/sched/core.c
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 78b2d5cabcc5..5fac4aa6ac7f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2593,6 +2593,11 @@ __do_set_cpus_allowed(struct task_struct *p, struct
> affinity_context *ctx)
>                 set_next_task(rq, p);
>  }
> 
> +union cpumask_rcuhead {
> +       void *cpumask;
> +       struct rcu_head rcu;
> +};
> +

Hehe; I had this union too; I just figured it'd be nice to not have to
spend these 4 lines to express this. Esp. since we're casting pointers
*anyway*.

>  /*
>   * Used for kthread_bind() and select_fallback_rq(), in both cases the user
>   * affinity (if any) should be destroyed too.
> @@ -2606,7 +2611,12 @@ void do_set_cpus_allowed(struct task_struct *p, const
> struct cpumask *new_mask)
>         };
> 
>         __do_set_cpus_allowed(p, &ac);
> -       kfree(ac.user_mask);
> +       /*
> +        * Because this is called with p->pi_lock held, it is not possible
> +        * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
> +        * kfree_rcu().
> +        */
> +       kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
>  }
> 
>  int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
> @@ -8196,7 +8206,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask
> *in_mask)
>         struct affinity_context ac;
>         struct cpumask *user_mask;
>         struct task_struct *p;
> -       int retval;
> +       int retval, size;
> 
>         rcu_read_lock();
> 
> @@ -8229,7 +8239,11 @@ long sched_setaffinity(pid_t pid, const struct
> cpumask *in_mask)
>         if (retval)
>                 goto out_put_task;
> 
> -       user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
> +       /*
> +        * See do_set_cpus_allowed() for the rcu_head usage.
> +        */
> +       size = max_t(int, cpumask_size(), sizeof(union cpumask_rcuhead));
> +       user_mask = kmalloc(size, GFP_KERNEL);
>         if (!user_mask) {
>                 retval = -ENOMEM;
>                 goto out_put_task;
> 

We also should fix the allocation in dup_user_cpus_ptr() -- perhaps pull
the thing into a helper.
