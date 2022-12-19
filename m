Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF96505D1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 01:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiLSAE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 19:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLSAE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 19:04:26 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4846BA180
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 16:04:25 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 1so11435577lfz.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 16:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tPvUHEz/lJ33Hi7CkPgpILSAI47KZFMUKJUPwIXUyf8=;
        b=kkui8mzTOoVPKxSjezZdbbQ0s/rBXPZnafOSq6CGGtx/xieKNqrH5BUIJxwMQpreS/
         1DnLsMpwxd3NdZuK4dE1swyF8/ZNXGcNPLHDqe5Xz1dqDNNQao9YNQhc+RsI7M9WXO63
         LlCBKkLnlbUlrI6SAeS6djv041CERrijuigJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPvUHEz/lJ33Hi7CkPgpILSAI47KZFMUKJUPwIXUyf8=;
        b=yzCV83YKeg/P+zysWcGPPxc0lXgCwYWhasayGAHdN1kVZPjvODDW3MYiFy7NktoL61
         CqGsfqEyFipfGjAGmVR6rJ8xT/l5z988eMtI5jXk7rH2ezKi0kl9jw5xsfsYEl4PPfy9
         WcK6LAbRXIvm6FWZqArzIAsNyHP3FX1FX9OCRd05oMal4R9Sr3b/jqemt1xulSTDNbiH
         wL9ZQtAgtwnPPYLbDL4CVuXK2xWf5x0NJ1ukM2sG6XIUtvifQj/TM5JDhJgVpz8TH3rG
         3y3AoGaJQHZof/3Z8oCa8vjl1TYDKUhxM2NF/x0ZR1SmvbtM7LgydZjrwPSlYsL1GNFC
         i9+A==
X-Gm-Message-State: AFqh2kol2g8wcaSxst7NUpEMtTJ7kDsm1RWIrd5BOSCAHbsW8UTsMjvN
        OlwsWBNs2Egw1F9APuTTcO4Y9Ej2t/I3o1SpZ0pFRFjqeKhRGXmx
X-Google-Smtp-Source: AMrXdXuYNL3oYDSB6XDvbVneusKWCYh4IuhsbZ0KYqyRO5jfc43I7H0aK3+HTUbfrz1cNNlrDyQKPRgXRJN0wQRB+lQ=
X-Received: by 2002:a05:6512:228c:b0:4bc:bdf5:f163 with SMTP id
 f12-20020a056512228c00b004bcbdf5f163mr755262lfu.583.1671408263534; Sun, 18
 Dec 2022 16:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com> <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
 <2da94283-4fce-9aff-ac5d-ba181fa0f008@efficios.com>
In-Reply-To: <2da94283-4fce-9aff-ac5d-ba181fa0f008@efficios.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 18 Dec 2022 19:04:12 -0500
Message-ID: <CAEXW_YQBmwynuBOWbV6_L2itRr_i3BZUxQ91PDC2We2vXhpztQ@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Sun, Dec 18, 2022 at 6:38 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2022-12-18 16:30, Joel Fernandes wrote:
> > Hi Mathieu,
> >
> > On Sun, Dec 18, 2022 at 3:56 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> On 2022-12-18 14:13, Joel Fernandes (Google) wrote:
> >>> Hello, I believe the pre-flip memory barrier is not required. The only reason I
> >>> can say to remove it, other than the possibility that it is unnecessary, is to
> >>> not have extra code that does not help. However, since we are issuing a fully
> >>> memory-barrier after the flip, I cannot say that it hurts to do it anyway.
> >>>
> >>> For this reason, please consider these patches as "informational", than a
> >>> "please merge". :-) Though, feel free to consider merging if you agree!
> >>>
> >>> All SRCU scenarios pass with these, with 6 hours of testing.
> >>
> >> Hi Joel,
> >>
> >> Please have a look at the comments in my side-rcu implementation [1, 2].
> >> It is similar to what SRCU does (per-cpu counter based grace period
> >> tracking), but implemented for userspace. The comments explain why this
> >> works without the memory barrier you identify as useless in SRCU.
> >>
> >> Following my implementation of side-rcu, I reviewed the SRCU comments
> >> and identified that the barrier "/* E */" appears to be useless. I even
> >> discussed this privately with Paul E. McKenney.
> >>
> >> My implementation and comments go further though, and skip the period
> >> "flip" entirely if the first pass observes that all readers (in both
> >> periods) are quiescent.
> >
> > Actually in SRCU, the first pass scans only 1 index, then does the
> > flip, and the second pass scans the second index. Without doing a
> > flip, an index cannot be scanned for forward progress reasons because
> > it is still "active". So I am curious how you can skip flip and still
> > scan both indexes? I will dig more into your implementation to learn more.
>
> If we look at SRCU read-side:
>
> int __srcu_read_lock(struct srcu_struct *ssp)
> {
>          int idx;
>
>          idx = READ_ONCE(ssp->srcu_idx) & 0x1;
>          this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
>          smp_mb(); /* B */  /* Avoid leaking the critical section. */
>          return idx;
> }
>
> If the thread is preempted for a long period of time between load of
> ssp->srcu_idx and increment of srcu_lock_count[idx], this means this
> thread can appear as a "new reader" for the idx period at any arbitrary
> time in the future, independently of which period is the current one
> within a future grace period.
>
> As a result, the grace period algorithm needs to inherently support the
> fact that a "new reader" can appear in any of the two periods,
> independently of the current period state.
>
> As a result, this means that while within period "0", we _need_ to allow
> newly coming readers to appear as we scan period "0".

Sure, it already does handle it but that is I believe it is a corner
case, not the norm.

> As a result, we can simply scan both periods 0/1 for reader quiescence,
> even while new readers appear within those periods.

I think this is a bit dangerous. Yes there is the preemption thing you
mentioned above, but that is bounded since you can only have a fixed
number of tasks that underwent that preemption, and it is quite rare
in the sense, each reader should get preempted just after sampling idx
but not incrementing lock count.

However, if we scan while new readers appear (outside of the above
preemption problem), we can have counter wrap causing a false match
much quicker.
The scan loop is:
check_readers(idx) {
   count_all_unlocks(idx);
   smp_mb();
   count_all_locks(idx);
   bool done = (locks == unlocks)
   if (done) {
         // readers are done, end scan for this idx.
   } else {
         // try again later
   }
}

So if check_readers() got preempted just after the smp_mb(), then you
can have lots of tasks enter and exit the read-side critical section
and increment the locks count. Eventually locks == unlocks will
happen, and it is screwed. Sure this is also theoretical, but yeah
that issue can be made "worse" by scanning active readers
deliberately, especially when such readers can also nest arbitrarily.

> As a result, flipping between periods 0/1 is just relevant for forward
> progress, not for correctness.

Sure, agreed, forward progress.

>
> As a result, we can remove barrier /* E */.
>

IMO, the "E" is not needed at all even if you do the flip because of
the reasons in the patch series changelogs, so whether we do flip less
frequently, we still don't need "E" IMHO.

Thanks!

 - Joel


> Thoughts ?
>
> Thanks,
>
> Mathieu
>
>
> >
> >> The most relevant comment in side-rcu is:
> >>
> >>    * The grace period completes when it observes that there are no active
> >>    * readers within each of the periods.
> >>    *
> >>    * The active_readers state is initially true for each period, until the
> >>    * grace period observes that no readers are present for each given
> >>    * period, at which point the active_readers state becomes false.
> >>
> >> So I agree with the clarifications you propose here, but I think we can
> >> improve the grace period implementation further by clarifying the SRCU
> >> grace period model.
> >
> > Thanks a lot, I am curious how you do the "detection of no new
> > readers" part without globally doing some kind of synchronization. I
> > will dig more into your implementation to learn more.
> >
> > Thanks,
> >
> >   - Joel
> >
> >
> >
> >>
> >> Thanks,
> >>
> >> Mathieu
> >>
> >>
> >> [1] https://github.com/efficios/libside/blob/master/src/rcu.h
> >> [2] https://github.com/efficios/libside/blob/master/src/rcu.c
> >>
> >>>
> >>> thanks,
> >>>
> >>>    - Joel
> >>>
> >>> Joel Fernandes (Google) (2):
> >>> srcu: Remove comment about prior read lock counts
> >>> srcu: Remove memory barrier "E" as it is not required
> >>>
> >>> kernel/rcu/srcutree.c | 10 ----------
> >>> 1 file changed, 10 deletions(-)
> >>>
> >>> --
> >>> 2.39.0.314.g84b9a713c41-goog
> >>>
> >>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> https://www.efficios.com
> >>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
