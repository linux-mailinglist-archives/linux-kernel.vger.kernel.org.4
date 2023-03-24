Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDF56C7C30
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCXKFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjCXKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:05:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15621A971
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=02Fbij+mFcM+MFW3bfEpmKnkkNMy+M5sba/5SlYbdMg=; b=YnLoloOieQcL3Hc0oYzwAiF7dH
        /XiZflmC1Gk3xtABSej9FpmbkPec/g4nCVFPcBozR20tvVjWbBu6Mn/VkN4VsYkIiQufXdIEtNcZM
        0ZzKyZjiulyqNYuzFZ5W49c0PwxGOpDpImwQAt3dLS44+CIr4cvhUEMlASX79Gl8qVBj9LltVfD+q
        C8DEIITgP35pSN77hptu+mXvvBVM7ab/5HLxGkekudA3rgfzAkXsy6aXMqvqgooJoMlVxxXWBuX9+
        TLIsokBcANEa2GX2yBOK/EMY77LouQaBp7j/dquIPmaCYt+hHe7OJnLaah0b/O9rHIrhFqGf+kCWf
        XItMQ0Qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfeHK-004nhZ-1l; Fri, 24 Mar 2023 10:04:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D56F93002C0;
        Fri, 24 Mar 2023 11:03:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B05D3235E61E0; Fri, 24 Mar 2023 11:03:52 +0100 (CET)
Date:   Fri, 24 Mar 2023 11:03:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Subject: Re: [PATCH 06/10] sched/fair: Add avg_vruntime
Message-ID: <20230324100352.GA2787125@hirez.programming.kicks-ass.net>
References: <20230306132521.968182689@infradead.org>
 <20230306141502.569748782@infradead.org>
 <ZBm39VNJCwioq+V4@chenyu5-mobl1>
 <20230321160458.GB2273492@hirez.programming.kicks-ass.net>
 <ZB1NU1Yc8DSi4zrW@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB1NU1Yc8DSi4zrW@chenyu5-mobl1>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 03:12:19PM +0800, Chen Yu wrote:

> > Or worse, SCHED_IDLE, where weight is 2 (IIRC) or cgroups, then vtime
> > advances at 512 times realtime. Now, the tick puts a limit on how long
> > we'll overshoot these super low weight entities, for HZ=1000 we still
> > only get 0.5s of vtime for weight=2.
> >
> > That would be only 30 bits used, except we use double FIXEDPOINT_SHIFT
> > on 64bit, so we'll end up at 40-ish.
> > 
> > That should give us enough room to carry an average of deltas around
> > min_vruntime.
> > 
> I'm trying to digest how ticks could prevent the overflow.

They don't prevent overflow per se, but they do limit on how far
vruntime can advance ahead of the pack.

> In update_curr() -> update_min_vruntime(cfs_rq), the cfs_rq->min_vruntime
> is set to
> max (cfs_rq->min_vruntime, min(curr->vruntime, leftmost(se->vruntime)))
> so, although curr->vruntime increase by 0.5 seconds in each tick,
> the leftmost(se->vruntime) could still be very small and unchanged,
> thus the delta between v_i and cfs_rq->min_vruntime is still large.

Well, since the basic task selection rule is: pick leftmost, the idea is
that leftmost and hence min_vruntime advances. The only problem is that
placement can place new entities left of min_vruntime and then it stalls
for a bit. But then rightmost tasks shouldn't get more runtime and the
whole situation should be 'stable'-ish.

> Instead sysctl_sched_latency could decide how far it is between the
> se.vruntime and the cfs_rq.min_vruntime, by calculating the vruntime
> delta between task1 and task2:
> 
>     sched_vslice(task1) = (NICE0_LOAD/se1.weight)  * (w1/Sum wi * sysctl_sched_latency)
>     sched_vslice(task2) = (NICE0_LOAD/se2.weight)  * (w2/Sum wi * sysctl_sched_latency)

Yes, vslice is obviously involved, but low weight tasks are the ones
that tend to shoot away and are tick limited.

> Besides in patch 10, entity_eligible() checks
> \Sum (v_i - v)*w_i >= (v_i - v)*(\Sum w_i)
> and the \Sum w_i could become large if there are many runnable tasks and
> bring overflow?

Indeed; I'll check there too. I think I'll make it do the division on
32bit and use 64x64->128 on 64bit.

Let me have a play..
