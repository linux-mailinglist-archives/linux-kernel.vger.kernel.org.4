Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8A6385C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKYI7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKYI7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:59:45 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BA032040
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vZoNCJjY0Q3X4k84Vewd1QspSTLiUHiINRsOJnCDUeY=; b=G0TWOUnL2Bs1HNe8xv88rMjAHi
        SS4KNfHDy7Wv5OaTWxtfd8Xr3lfyQdgugh3Wmo111XYvkC04P3QEkixYCdMj4O9aLzImlSjTjH7ns
        EH5k1KDmAEU68mhpLKRsAw7nb34q9gDSvVVoPq0l2Hsmxg/Ye/GWGbIZfMwuxVhms0A4gAVFScu7/
        //geUu1wRuegtMi15Bls0u+jVl9F2GwBfqCjhak/KH2hyVA0JTieikhNxcOciIUW98IjyZ5lTBdib
        loNZ/9vNfpaLiBohBE4rMpBG7b5bK1c4yJec6W+N7J6/DOmrXWKlkCFoQUt5DEKG1ie5g4nRV3MPK
        +wXgqOTw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oyUYP-004Tc0-FC; Fri, 25 Nov 2022 08:59:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08931300422;
        Fri, 25 Nov 2022 09:59:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA4AE2BB639CD; Fri, 25 Nov 2022 09:59:23 +0100 (CET)
Date:   Fri, 25 Nov 2022 09:59:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        anna-maria@linutronix.de
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
Message-ID: <Y4CD615rYurnV6h7@hirez.programming.kicks-ass.net>
References: <20221117005418.3499691-1-joshdon@google.com>
 <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
 <094299a3-f039-04c1-d749-2bea0bc14246@linux.dev>
 <Y3tn5wz6TjsqfGTA@hirez.programming.kicks-ass.net>
 <CABk29Nuyp=Ba=qiJAospx-SR2ZQM9GrKW0pDUeJ3sfgNB4uLFg@mail.gmail.com>
 <Y3ymBOfRikUci/PD@hirez.programming.kicks-ass.net>
 <Y4CDZXZJpPB0J1BV@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4CDZXZJpPB0J1BV@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 09:57:09AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 22, 2022 at 11:35:48AM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 21, 2022 at 11:37:14AM -0800, Josh Don wrote:
> > > Yep, this tradeoff feels "best", but there are some edge cases where
> > > this could potentially disrupt fairness. For example, if we have
> > > non-trivial W, a lot of cpus to iterate through for dispatching remote
> > > unthrottle, and quota is small. Doesn't help that the timer is pinned
> > > so that this will continually hit the same cpu.
> > 
> > We could -- if we wanted to -- manually rotate the timer around the
> > relevant CPUs. Doing that sanely would require a bit of hrtimer surgery
> > though I'm afraid.
> 
> Here; something like so should enable us to cycle the bandwidth timer.
> Just need to figure out a way to find another CPU or something.

Some more preparation...

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5617,7 +5617,7 @@ static int do_sched_cfs_period_timer(str
 	if (!throttled) {
 		/* mark as potentially idle for the upcoming period */
 		cfs_b->idle = 1;
-		return 0;
+		return HRTIMER_RESTART;
 	}
 
 	/* account preceding periods in which throttling occurred */
@@ -5641,10 +5641,10 @@ static int do_sched_cfs_period_timer(str
 	 */
 	cfs_b->idle = 0;
 
-	return 0;
+	return HRTIMER_RESTART;
 
 out_deactivate:
-	return 1;
+	return HRTIMER_NORESTART;
 }
 
 /* a cfs_rq won't donate quota below this amount */
@@ -5836,9 +5836,9 @@ static enum hrtimer_restart sched_cfs_pe
 {
 	struct cfs_bandwidth *cfs_b =
 		container_of(timer, struct cfs_bandwidth, period_timer);
+	int restart = HRTIMER_RESTART;
 	unsigned long flags;
 	int overrun;
-	int idle = 0;
 	int count = 0;
 
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
@@ -5847,7 +5847,7 @@ static enum hrtimer_restart sched_cfs_pe
 		if (!overrun)
 			break;
 
-		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
+		restart = do_sched_cfs_period_timer(cfs_b, overrun, flags);
 
 		if (++count > 3) {
 			u64 new, old = ktime_to_ns(cfs_b->period);
@@ -5880,11 +5880,11 @@ static enum hrtimer_restart sched_cfs_pe
 			count = 0;
 		}
 	}
-	if (idle)
+	if (restart == HRTIMER_NORESTART)
 		cfs_b->period_active = 0;
 	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 
-	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
+	return restart;
 }
 
 void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
