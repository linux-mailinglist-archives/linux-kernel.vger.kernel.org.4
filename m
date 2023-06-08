Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5C1728058
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbjFHMqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjFHMp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:45:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633B626B1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1FJ/mNTB17zfJ2aN7TDhiCCKZAgH2w1JIx+mCkoNx/U=; b=UjAEgZwSFene4LA1gOBpEnmv6v
        +WEBmvk46fXlN8vIhvKfDsNwp2M7tOnVeLXh/9NnhPIEdIrhTkRkylLbrMv20J+gKeSr6Bxz9QZHx
        JVcg1Sk80LV1Qf/h6+REJVWAmQ4aquyBmz+SLGerxgLbmooXSHSqm2om9ZJ2s0we5T9V4/qCLaluj
        Q7LAQsVfRbRtP2Uw0AmrDsXl0iPRQyzsuzj6s2YKcMQtiaH61841kfNa54nVEfJ1Dm7/cl4+TibeC
        Ac1YQ581PlzDj/O1uomAX0jnIuOeSg8P9JiOkx8+Ja4qZuEdWZ0O2pbgACiyNsIsiqkrN9rl1SXbV
        jTtGm1KA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7F0N-006DWc-0S;
        Thu, 08 Jun 2023 12:44:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEF0F300274;
        Thu,  8 Jun 2023 14:44:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4A2F245A87E7; Thu,  8 Jun 2023 14:44:40 +0200 (CEST)
Date:   Thu, 8 Jun 2023 14:44:40 +0200
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
Message-ID: <20230608124440.GB1002251@hirez.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124604.477939524@infradead.org>
 <CAKfTPtCvsy9rUXiAQ=zm=5DiAgJ1EegEkJ5iOkgro5Mnwsvfog@mail.gmail.com>
 <20230608103458.GI998233@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608103458.GI998233@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 12:34:58PM +0200, Peter Zijlstra wrote:
> > Then asking for a request shorter than the tick also means that
> > scheduler must enqueue a new request (on behalf of the task) during
> > the tick and evaluate if the task is still the one to be scheduled
> > now.
> 
> If there is no 'interrupt', we won't update time and the scheduler can't
> do anything -- as you well know. The paper only requires (and we
> slightly violate this) to push forward the deadline. See the comment
> with update_deadline().
> 
> Much like pure EDF without a combined CBS.
> 
> > So similarly to q, the request size r should be at least a tick
> > in order to reevaluate which task will run next after the end of a
> > request. In fact, the real limit is : r/wi >= tick/(Sum wj)
> 
> > We can always not follow these assumptions made in the publication but
> > I wonder how we can then rely on its theorems and corollaries
> 
> Again, I'm not entirely following, the corollaries take r_i < q into
> account, that's where the max(rmax, q) term comes from.
> 
> You're right in that r_i < q does not behave 'right', but it doesn't
> invalidate the results. Note that if a task overshoots, it will build of
> significant negative lag (right side of the tree) and won't be eligible
> for it's next actual period. This 'hole' in the schedule is then used to
> make up for the extra time it used previously.

So notably, if your task *does* behave correctly and does not consume
the full request, then it will not build up (large) negative lag and
wakeup-preemption can make it go quickly on the next period.

This is where that FUDGE hack comes in, except I got it wrong, I think
it needs to be something like:

	if (delta / W >= vslice) {
		se->vlag += vslice
		if (se->vlag > 0)
			se->vlag = 0;
	}

To ensure it can't gain time. It's still a gruesome hack, but at least
is shouldn't be able to game the system.
