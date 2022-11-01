Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF874614DC8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiKAPGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiKAPGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:06:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91A31DDD6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 08:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b1Cj0chaw9JLH2gXk2AZTiOd2rXLa7xopFMjGx4myaM=; b=GO1A5SoU2ykqlSazqqbbpt53fS
        tiPQJnRVbFOm4yp/siJ3m95ByA6Vzgd2nY6Yx1ltR03u2mMJnyvXpkMA66wFNhMItJ51CiPe/SoR4
        iXMPvBma0/0omCz/pcySWoREN/csO0FsQhnyr7rOMI8qWxgsnt072XL8oSyYXaC+6QV2SHPpdIzIC
        1CAzkIsUuO8fvTiv2WMV/ytqcZxLiEkNmry8XF5m1yZE42WbLKO59pG1rUNBjyKqQwSONyXdBaKQe
        5RZZ4ez7pigqnNg7G3tkFAi65EeTSfIqAUkIebjm4AblEJ4mmflkio/LguqB6iR9rAPOo1sNXLuyb
        89Y0gCxA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opsje-0089Qb-GU; Tue, 01 Nov 2022 14:59:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C6C130007E;
        Tue,  1 Nov 2022 15:59:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3925D28576692; Tue,  1 Nov 2022 15:59:25 +0100 (CET)
Date:   Tue, 1 Nov 2022 15:59:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Tianchen Ding <dtcccc@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Clear ttwu_pending after enqueue_task
Message-ID: <Y2E0TeFJorjOXikX@hirez.programming.kicks-ass.net>
References: <20221101073630.2797-1-dtcccc@linux.alibaba.com>
 <Y2D2HIZuGP81w25+@hirez.programming.kicks-ass.net>
 <Y2EkXYqZ15/Kjl6H@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2EkXYqZ15/Kjl6H@chenyu5-mobl1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 09:51:25PM +0800, Chen Yu wrote:

> > Could you try the below instead? Also note the comment; since you did
> > the work to figure out why -- best record that for posterity.
> > 
> > @@ -3737,6 +3730,13 @@ void sched_ttwu_pending(void *arg)
> >  			set_task_cpu(p, cpu_of(rq));
> >  
> >  		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
> > +		/*
> > +		 * Must be after enqueueing at least once task such that
> > +		 * idle_cpu() does not observe a false-negative -- if it does,
> > +		 * it is possible for select_idle_siblings() to stack a number
> > +		 * of tasks on this CPU during that window.
> > +		 */
> > +		WRITE_ONCE(rq->ttwu_pending, 0);
> Just curious why do we put above code inside llist_for_each_entry_safe loop?

> My understanding is that once 1 task is queued, select_idle_cpu() would not
> treat this rq as idle anymore because nr_running is not 0. But would this bring
> overhead to write the rq->ttwu_pending multiple times, do I miss something?

So the consideration is that by clearing it late, you might also clear a
next set; consider something like:


	cpu0			cpu1			cpu2

	ttwu_queue()
	  ->ttwu_pending = 1;
	  llist_add()

				sched_ttwu_pending()
				  llist_del_all()
				  ... long ...
							ttwu_queue()
							  ->ttwu_pending = 1
							  llist_add()

				  ... time ...
				  ->ttwu_pending = 0

Which leaves you with a non-empty list but with ttwu_pending == 0.

But I suppose that's not actually better with my variant, since it keeps
writing 0s. We can make it more complicated again, but perhaps it
doesn't matter and your version is good enough.

But please update with a comment on why it needs to be after
ttwu_do_activate().

