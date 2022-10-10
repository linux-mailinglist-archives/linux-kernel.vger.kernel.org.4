Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2B35FA064
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJJOq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJJOqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:46:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97AD65EDD2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:46:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9120012FC;
        Mon, 10 Oct 2022 07:47:00 -0700 (PDT)
Received: from wubuntu (unknown [10.57.35.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98D8F3F766;
        Mon, 10 Oct 2022 07:46:52 -0700 (PDT)
Date:   Mon, 10 Oct 2022 15:46:50 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Youssef Esmat <youssefesmat@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Sum of weights idea for CFS PI
Message-ID: <20221010144650.fjwhjdbqqaxz4sow@wubuntu>
References: <CALUeGD0OP4ZqDFcT10=ih40tGsm9gjjno7NP_Jwd1RxiUJZ0CQ@mail.gmail.com>
 <0BFD3887-60A2-4C74-9D37-49B7B6E64299@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0BFD3887-60A2-4C74-9D37-49B7B6E64299@joelfernandes.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/22 11:04, Joel Fernandes wrote:
> 
> 
> > On Oct 6, 2022, at 3:40 PM, Youssef Esmat <youssefesmat@google.com> wrote:
> > 
> [..]
> >> 
> >>> Anyway - just trying to explain how I see it and why C is unlikely to be
> >>> taking too much time. I could be wrong. As Youssef said, I think there's
> >>> no fundamental problem here.
> >> 
> >> I know on Android where they use smaller HZ, the large tick causes lots of
> >> problems for large nice deltas. Example if a highly niced task was to be
> >> preempted for 1ms, and preempts instead at 3ms, then the less-niced task
> >> will not be so nice (even less nice than it promised to be) any more
> >> because of the 2ms boost that the higher niced task got. This can lead the
> >> the sched_latency thrown out of the window. Not adjusting the weights
> >> properly can potentially make that problem much worse IMO.
> > 
> > Once C releases the lock it should get adjusted and A will get adjusted
> > also regardless of tick. At the point we adjust the weights we have
> > a chance to check for preemption and cause a reschedule.
> 
> Yes but the lock can be held for potentially long time (and even user space
> lock). I’m more comfortable with Peter’s PE patch which seems a more generic
> solution, than sum of weights if we can get it working. I’m studying Connor’s
> patch set now…

The 2 solutions are equivalent AFAICT.


With summation:

   A    ,    B   ,    C   ,    D
sleeping, running, running, running
   -    ,   1/5  ,   3/5  ,   1/5

Where we'll treat A as running but donate its bandwidth to C, the mutex owner.



With PE:

   A    ,    B   ,    C   ,    D
 running, running, running, running
   2/5  ,   1/5  ,   1/5  ,   1/5

Where A will donate its execution context to C, the mutex owner.


In both cases we should end up with the same distribution as if neither A nor
C ever go to sleep because of holding the mutex.


I still can't see how B and D fairness will be impacted as the solution to the
problem is to never treat a waiter as sleeping and let the owner run for more,
but only within the limit of what the waiter is allowed to run for. AFAICS,
both solutions maintain this relationship.


Thanks

--
Qais Yousef
