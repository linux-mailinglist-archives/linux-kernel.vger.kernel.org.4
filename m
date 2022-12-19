Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6880A650E27
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiLSO7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiLSO6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:58:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0987C384;
        Mon, 19 Dec 2022 06:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IxbTudA4feCy7V4StycL6z3Gw08KgIGquvj8lJQM3zk=; b=MjHPsuR/gNwPkXqJiBXeujMeaF
        MbcU+ntQeEnKkeD8AIYI5Om7Zla+mCZpC1yZu2/IqzTf47X8cKwI+esGRtLusDM4jWw67zF+0ZBek
        5QZcF4CcHPoUgkKj55+Aj9daMz0U1XNluJouvy/rOoXUEGmV9U+bAkMSGA8zww1aJpKr2AZkpGsIV
        PcsJRKSZl/bLvAdWKdD8t3JVWV2HHGdJLFKWHd8fkVjy3p2OTtqj+xfqoCdi70KUcNZ/1YI6WN5RB
        Q+Hkj1sX772uV3M9jjvlw5re2MPAO7GjmZLOeLTmCdQmKZU8Q1h+wnvVDe05b8p1J/q3t3VSYGOwn
        gfNMjmVg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p7HZZ-00CdMu-17;
        Mon, 19 Dec 2022 14:56:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B53E8300348;
        Mon, 19 Dec 2022 15:56:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 92EC620A1489F; Mon, 19 Dec 2022 15:56:56 +0100 (CET)
Date:   Mon, 19 Dec 2022 15:56:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC/RFT PATCH 1/2] sched/core: Check and schedule ksoftirq
Message-ID: <Y6B7uOBjzYrLhmOu@hirez.programming.kicks-ass.net>
References: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
 <20221215184300.1592872-2-srinivas.pandruvada@linux.intel.com>
 <Y5xURk3CkzhIjmmq@hirez.programming.kicks-ass.net>
 <20221216220748.GA1967978@lothringen>
 <Y6BMAp6A731F8ZL4@hirez.programming.kicks-ass.net>
 <Y6BPLoHJNWjjMUv8@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6BPLoHJNWjjMUv8@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 12:46:54PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-12-19 12:33:22 [+0100], Peter Zijlstra wrote:
> > ksoftirq is typically a CFS task while idle injection is required to be
> > a FIFO (typically FIFO-1) task -- so that would require lifting
> > ksoftirqd to FIFO and that has other problems.
> > 
> > I'm guessing the problem case is where idle injection comes in while
> > ksoftirq is running (and preempted), because in that case you cannot run
> > the softirq stuff in-place.
> > 
> > The 'right' thing to do would be to PI boost ksoftirqd in that case I
> > suppose. Perhaps something like so, it would boost ksoftirq when it's
> > running, and otherwise runs the ksoftirqd thing in-situ.
> > 
> > I've not really throught hard about this though, so perhaps I completely
> > wrecked things.
> 
> I don't know why you intend to run ksoftirqd but in general it breaks RT

So the upstream problem is where softirq is punted to ksoftirq (obvious
from hardirq tail) and idle-injection comes in and either:

 - runs before ksoftirq had a chance to run, or
 - preempts ksoftirqd.

In both cases we'll appear to go idle with softirqs pending -- which
triggers a pesky warning, because obviously undesirable.

In the first case we can run 'ksoftirqd' in-context, but then need to
serialize against the actual ksoftirqd. In the second case we need to
serialize against ksoftirqd and ensure it is complete before proceeding
with going 'idle'.

Since idle-injection runs FIFO and ksoftirqd typically does not, some
form of PI is required.

> left and right and we attempt to avoid running ksoftirqd as much as
> possible. If it runs and you go and boost it then it probably gets even
> worse from RT point of view.

So if you never run ksoftirqd, the above problem doesn't happen. If
ksoftirqd *can* run, you still need to deal with it somehow. Boosting
ksoftirqd to whatever priority the idle-injection thread has should not
be worse than anything the idle-injection already does, no?

Specifically, without idle-injection involved the patch as proposed (+-
fixes required to make it compile and work) should be a no-op.

> ksoftirqd runs softirqs from hardirq context. Everything else is handled
> in is handled within local-bh-disable+enable loop. We already have have
> the boost-ksoftird hammer which is the per-CPU BLK called
> local_bh_disable(). In general everything should be moved out of it.
> For timers we have the ktimerd thread which needs clean up. 


