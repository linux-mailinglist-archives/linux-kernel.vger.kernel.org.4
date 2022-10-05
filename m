Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830AA5F5229
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJEKEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJEKEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:04:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F9D857263
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 03:04:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FFDE113E;
        Wed,  5 Oct 2022 03:04:13 -0700 (PDT)
Received: from wubuntu (unknown [10.57.32.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B1BB3F67D;
        Wed,  5 Oct 2022 03:04:04 -0700 (PDT)
Date:   Wed, 5 Oct 2022 11:04:02 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Youssef Esmat <youssefesmat@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Sum of weights idea for CFS PI
Message-ID: <20221005100402.3i46oqx5lxsw2qer@wubuntu>
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu>
 <00140e95-0fe2-1ce4-1433-a3211f9da20c@joelfernandes.org>
 <20221003161404.kdow5uyj7kvbqyxs@wubuntu>
 <bb28d85a-c50f-a25f-aeb4-672eecb75b55@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb28d85a-c50f-a25f-aeb4-672eecb75b55@joelfernandes.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel

On 10/04/22 16:27, Joel Fernandes wrote:

[...]

> I am treating the following the same:
> 
>  	a.  when A is running, it would be as above.
>  	b.  but if A was sleeping, B, C, and D would get 1/3.
> 
>  similar to
> 
>  	a.  when A is running *and blocked on C for all its runtime*
> 		^^ -- in this case, B and D should not have their distributions
> 		      changed at all because they are not participating in the
> 		      lock acquire and release. So they should neither be hurt
> 		      any more, nor be boosted. They should simply stay same [1]
> 
>  	b.  but if A was sleeping, B, C, and D would get 1/3.
> 
> 
> [1] Why? Consider 3 tasks in the all-RT case, A high, B medium and C low prio.
> 
> If all are running 100% and A does not block on C, B is blocked by A
> indefinitely. So the prio of A and B are inverted. We seek to rectify this, that
> is we need make changes such that, B is returned back to the blocked state. We
> do this by boosting C.
> 
> In other words, the prio inheritance will cause B's distribution to not be
> changed (it was supposed to be blocked before and it is now going to be blocked
> state again).
> 
> CFS should not behave any differently, B's distribution should not be changed
> before/after the priority inhertiance of A by C. That's just my opinion - and
> that's how I calculated to distribution. With that mind, could you go back to
> seeing if my math was originally correct or did I mess something up?

It's not about the math. But I think the before and after can't be the same for
C..

> I do think though that Youssef's point of not worrying about being too accurate
> is reasonable if the critical sections are short lived but I'm not sure.

.. I do agree with that as well. I was just trying to highlight that looking at
average can be misleading and I don't see C taking too much time.

If any worries I have, it'd be not accounting correctly for the stolen time
C takes from A. Otherwise A + C share combined would be higher than it should
be. Which might be the problem you're trying to highlight but I am unable to
get/see. But this is an implementation detail and an artefact of wrong
accounting, not how shares are summed.

> > I don't think this is valid. If A is blocked on C for 50% of the time, and
> > sleeping for 50% of the time, when did it get blocked/unblocked?
> > 
> > This will have an impact on the average share for C and skew it, no?
> > 
> > Unless I missed something, the average share of C being (3/5 + 1/3) is an
> > impossible state. You need to consider the portion of time when C runs as 1/5,
> > when A is actually not blocked on anything, too.
> > 
> > Hmm actually I just re-read your statement below and you just say 3/5 (18/30)
> > is too much. You didn't consider the average. I'll leave the above in hope to
> > help me understand what am I missing and where I went wrong :-)
> > 
> > Generally IMHO looking at the average will not help. I think if the share
> > values make sense in each state individually (and I believe they are), that
> > would be enough. AFAICS, B and D are still taking the right amount of time when
> > C inherits the bandwidth. And C by definition will run longer when A is blocked
> > on it for the whole duration of this blocked time.
> 
> I was degenerating the case where A sleeps (say I/O) vs A blocks, to simplify
> the math, and then taking average of that. I think that's reasonable?

I'm not sure. This is skewing the results in my view.

I think the comparison should just be:

1) A, B, C, and D are all running and nothing gets blocked at all. Then shares
   would be:

   2/5, 1/5, 1/5, 1/5

2) A is blocked and C; B, C, D are running with no blocked time. Shares would
   be:

   - , 1/5, 3/5, 1/5

By definition, we want to treat A in (2) as RUNNING because as soon as
C unblocks A we should return to (1). From B and D perspective, their share is
not impacted throughout this transition. Which is AFAIU is what we want to
achieve.

I think considering the sleeping time and averaging can lead to misleading
results if care is not taken.

Anyway - just trying to explain how I see it and why C is unlikely to be taking
too much time. I could be wrong. As Youssef said, I think there's no
fundamental problem here.

My 2 cents ;-)


Thanks!

--
Qais Yousef
