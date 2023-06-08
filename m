Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36D6727CE5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjFHKf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFHKf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:35:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312BD2113
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W+eCeOeeUDHATA43MtrXcNLKAStSPnL/Qbv2lbWv0fA=; b=ET9e7YWJfB64VD9MDMYb2+kHSF
        pb0mtJoKITH/C2gZYrdK4MQTRqpUpW68EMzqsaf/y2DYtmhdY5UQbg0Xnok5pr86c7p5sihxiaebS
        YsgKafjLK0bhGspUrPwZrbquLyRI3/oQ4tg9YobXCQzfVNZUA/i9A2becHyz+yxPacekTMEJm+E3J
        b0/rOMZzMginxAzZt9M1SHwA4Caarh4pXdqaDRXYSLlDk211mfh5Prmkxl4ow3MyxeDTxO17odvcP
        Kmq5X/uwWQkZny61Zg9BXEBx6VijlrQjhYDgvu3dpAz2jx4Vrmt++IxIsZuvTKZL+lvdIQdMla+yJ
        56nEe1pQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7Cyt-00FMeV-0n; Thu, 08 Jun 2023 10:35:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB1EA300274;
        Thu,  8 Jun 2023 12:34:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91B9A20D72196; Thu,  8 Jun 2023 12:34:58 +0200 (CEST)
Date:   Thu, 8 Jun 2023 12:34:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: Re: [RFC][PATCH 13/15] sched/fair: Implement latency-nice
Message-ID: <20230608103458.GI998233@hirez.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124604.477939524@infradead.org>
 <CAKfTPtCvsy9rUXiAQ=zm=5DiAgJ1EegEkJ5iOkgro5Mnwsvfog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCvsy9rUXiAQ=zm=5DiAgJ1EegEkJ5iOkgro5Mnwsvfog@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:54:13PM +0200, Vincent Guittot wrote:
> On Wed, 31 May 2023 at 14:47, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Implement latency-nice as a modulation of the EEVDF r_i parameter,
> > specifically apply the inverse sched_prio_to_weight[] relation on
> > base_slice.
> >
> > Given a base slice of 3 [ms], this gives a range of:
> >
> >   latency-nice  19: 3*1024 / 15    ~= 204.8 [ms]
> >   latency-nice -20: 3*1024 / 88761 ~= 0.034 [ms]
> 
> I have reread the publication. I have question about
> 
> Theorem 1: The lag of any active client k in a steady system is
> bounded as follows,
>     -rmax < lagk (d) < max(rmax ; q);
> 
> and
> 
> Corollary 2: Consider a steady system and a client k such that no
> request of client k is larger than a
> time quantum. Then at any time t, the lag of client k is bounded as follows:
>     -q < lagk (t) < q
> 
> q being the time quanta a task can run
> and rmax the maximum slice of active task
> 
> I wonder how it applies to us. What is our time quanta q ?

> I guess that it's the tick because it is assumed that the algorithm
> evaluates which task should run next for each q interval in order to
> fulfill the fairness IIUC.So I don't think that we can assume a q
> shorter than the tick (at least with current implementation) unless we
> trigger some additional interrupts

Indeed, TICK_NSEC is our unit of accounting (unless HRTICK, but I've not
looked at that, it might not DTRT -- also, I still need to rewrite that
whole thing to not be so damn expensive).

> Then asking for a request shorter than the tick also means that
> scheduler must enqueue a new request (on behalf of the task) during
> the tick and evaluate if the task is still the one to be scheduled
> now.

If there is no 'interrupt', we won't update time and the scheduler can't
do anything -- as you well know. The paper only requires (and we
slightly violate this) to push forward the deadline. See the comment
with update_deadline().

Much like pure EDF without a combined CBS.

> So similarly to q, the request size r should be at least a tick
> in order to reevaluate which task will run next after the end of a
> request. In fact, the real limit is : r/wi >= tick/(Sum wj)

> We can always not follow these assumptions made in the publication but
> I wonder how we can then rely on its theorems and corollaries

Again, I'm not entirely following, the corollaries take r_i < q into
account, that's where the max(rmax, q) term comes from.

You're right in that r_i < q does not behave 'right', but it doesn't
invalidate the results. Note that if a task overshoots, it will build of
significant negative lag (right side of the tree) and won't be eligible
for it's next actual period. This 'hole' in the schedule is then used to
make up for the extra time it used previously.

The much bigger problem with those bounds is this little caveat: 'in a
steady state'. They conveniently fail to consider the impact of
leave/join operations on the whole thing -- and that's a much more
interesting case.
