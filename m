Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C3C65470E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLVUZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLVUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:25:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC99123E99
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 12:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m8RK6yXoqlrTOTJUPCI+4BVlHcx8ff1/GtwVnZc24kA=; b=NxO2NNt+/JDL1NV3EbZWdz8Lxd
        liuazUyMpJ/LLSw32/A6SzbjgxFKewxWxyl4bw5v6591enlh8q2GMrE7Irrw6wh++8Dlxzn3AG4QI
        cgx39df7qACwuYsspMM3O7k3QYoe/WohKqbbrjXMkSIIUa2b9EQpSnAOJ3rn0Ovuxpm0K4OXQGWJF
        Uom3FmwVBUH8GXn8BCQWY0/PsrzPhHjdQOj7c+fKCrfrm15Y6z4iY3kFs0d7Y2Bv26TJmZupj9pIm
        W4aW2Jbn+ibR3X+ioTWtyeeSRbPG3F74PXf0DCiCdWRzYZJg1VpByqBGkuZlo2y0HD/S9fJJrHAII
        f28Jb9UA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8S83-003vWW-Uu; Thu, 22 Dec 2022 20:25:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9894300E04;
        Thu, 22 Dec 2022 21:25:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 979CE20165191; Thu, 22 Dec 2022 21:25:12 +0100 (CET)
Date:   Thu, 22 Dec 2022 21:25:12 +0100
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
Message-ID: <Y6S9KBYQbbFIQFWa@hirez.programming.kicks-ass.net>
References: <20221205163936.2149640-1-longman@redhat.com>
 <Y6SwwNy2OMSjUlbT@hirez.programming.kicks-ass.net>
 <56792f82-951e-04c5-f7ea-fbf9ab375eec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56792f82-951e-04c5-f7ea-fbf9ab375eec@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 03:18:29PM -0500, Waiman Long wrote:

> > > @@ -8220,7 +8230,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
> > >   	struct affinity_context ac;
> > >   	struct cpumask *user_mask;
> > >   	struct task_struct *p;
> > > -	int retval;
> > > +	int retval, size;
> > >   	rcu_read_lock();
> > > @@ -8253,7 +8263,11 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
> > >   	if (retval)
> > >   		goto out_put_task;
> > > -	user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
> > > +	/*
> > > +	 * See do_set_cpus_allowed() for the rcu_head usage.
> > > +	 */
> > > +	size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
> > > +	user_mask = kmalloc(size, GFP_KERNEL);
> > >   	if (!user_mask) {
> > >   		retval = -ENOMEM;
> > >   		goto out_put_task;
> > AFAICT you forgot dup_user_cpus_ptr().
> 
> I haven't received any response from you for a while. So it is just a ping.

I was out sick :/

> Of course, I am aware that there is another dup_user_cpus_ptr() patch
> ouststanding. I will of course talk about that when you respond. I also have
> a pending rwsem patch series waiting for your review:-)

The point was that dup_user_cpus_ptr() also does an allocation and needs
to allocate the possibly bigger size too, no?
