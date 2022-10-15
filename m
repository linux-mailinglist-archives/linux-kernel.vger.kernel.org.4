Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E265FFB02
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJOP27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJOP25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:28:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F81130543
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xdaEfLjtKCfA7Lz1H/kDSbp28bYsxiUEU9CsBW+KweE=; b=jjyuCPRLnFhTrToemIwnDGJJUR
        +ny3xP5/Y5YjYopIzIVkkffq22A6frEZe4QwTuBeFnff9UQr8Mi5SFMiZB6VKJMVFJuxC7aeSMFRS
        ayuAK8KE24mIJqulym3HZZUXtM4ViHoIcmMj8hmgOB7v67+P0jzEwYtt5dk6gcWT4eM9gndUDuLh0
        EjpU+xAUAlKoVPSTtmkLBrw2a73+7mivPCVP/2Lt/qNIVyV8Cb5SaUaR8gA6sDwtUnGrLi7MBSrKQ
        fUx367RRdQSTbJJtfZmlkOmxjZIokY+7uwaTeCy70VjkpMA78jtM80hPEhbakpzgovisTcqYzYVtk
        O2N7zzRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojj5d-008Soj-OS; Sat, 15 Oct 2022 15:28:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5AAE430015F;
        Sat, 15 Oct 2022 17:28:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43C7B201FD678; Sat, 15 Oct 2022 17:28:36 +0200 (CEST)
Date:   Sat, 15 Oct 2022 17:28:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, youssefesmat@google.com
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <Y0rRpOf89upGnCMe@hirez.programming.kicks-ass.net>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-8-connoro@google.com>
 <Y0YeUhDZWb49mpLo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0YeUhDZWb49mpLo@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 01:54:26AM +0000, Joel Fernandes wrote:

> > +migrate_task:
> > +	/*
> > +	 * The blocked-on relation must not cross CPUs, if this happens
> > +	 * migrate @p to the @owner's CPU.
> > +	 *
> > +	 * This is because we must respect the CPU affinity of execution
> > +	 * contexts (@owner) but we can ignore affinity for scheduling
> > +	 * contexts (@p). So we have to move scheduling contexts towards
> > +	 * potential execution contexts.
> > +	 *
> > +	 * XXX [juril] what if @p is not the highest prio task once migrated
> > +	 * to @owner's CPU?
> 
> Then that sounds like the right thing is happening, and @p will not proxy()
> to @owner. Why does @p need to be highest prio?

So all this is a head-ache and definitely introduces some inversion
cases -- doubly so when combined with lovely things like
migrate_disable().

But even aside from the obvious affinity related pain; there is another
issue. Per:

--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1548,7 +1548,8 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)

	enqueue_rt_entity(rt_se, flags);

-       if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
+       if (!task_current(rq, p) && p->nr_cpus_allowed > 1 &&
+           !task_is_blocked(p))
		enqueue_pushable_task(rq, p);
}

blocked entries are NOT put on the pushable list -- this means that the
normal mitigation for resolving a priority inversion like described
above (having both P_max and P_max-1 on the same CPU) no longer works.
That is, normally we would resolve the situation by pushing P_max-1 to
another CPU. But not with PE as it currently stands.

The reason we remove blocked entries from the pushable list is because
must migrate them towards the execution context (and respect the
execution context's affinity constraints).


Basically the whole push-pull RT balancer scheme is broken vs PE, and
that is a bit of a head-ache :/
