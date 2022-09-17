Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFDE5BB8C0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 16:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIQO2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 10:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 10:28:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7BF33A38
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A7D2614DE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 14:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947F7C433D6;
        Sat, 17 Sep 2022 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663424903;
        bh=ACi2/f2g//l/QvWQFig1ZMbtw0k5YA3AhD/2reqrx0A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PNoCEPopyeemmWDlLGurERNcvZT8pWh4S9mYDeZkPHBSlJPMFbW8OeR3dVSi6X0lg
         qkxBXLz9aehDq8K/LG+zlccw0LNgj6vHxWzlDpiW/NuK2FGIKtFHygfgGSu9TgU5ql
         Npqr7eZedP5MOm+msJsB7qpew1RM7xNWwhyek2Hc6kGAs+olpaOog1OxXW1EvKV8V3
         LFkBMgTKzThXgoIVRCLxL3UjFFw0K36xx2v0DUpru669aPRbQtNMigEcnP7ETm4FMN
         rS20ij3GFbQaQcBg9/g4wo2kpQz76xbk8lv/aqeIBj36HF0DxH3wfUJGEeDeURiJ5M
         CsDZybA0DKvRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F3475C04D0; Sat, 17 Sep 2022 07:28:23 -0700 (PDT)
Date:   Sat, 17 Sep 2022 07:28:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RCU vs NOHZ
Message-ID: <20220917142823.GG246308@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <CAEXW_YTN7mnQSN2eJCysLsZOq+8JEOV6pvgw3LDTT=0mnkC2SA@mail.gmail.com>
 <YyXNJEH6xafOcp39@hirez.programming.kicks-ass.net>
 <82a58d5c-73e7-6e78-e72e-3e46a1a3afbc@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82a58d5c-73e7-6e78-e72e-3e46a1a3afbc@joelfernandes.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 09:52:49AM -0400, Joel Fernandes wrote:
> On 9/17/2022 9:35 AM, Peter Zijlstra wrote:
> > On Fri, Sep 16, 2022 at 02:11:10PM -0400, Joel Fernandes wrote:
> >> Hi Peter,
> >>
> >> On Fri, Sep 16, 2022 at 5:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >> [...]
> >>>> It wasn't enabled for ChromeOS.
> >>>>
> >>>> When fully enabled, it gave them the energy-efficiency advantages Joel
> >>>> described.  And then Joel described some additional call_rcu_lazy()
> >>>> changes that provided even better energy efficiency.  Though I believe
> >>>> that the application should also be changed to avoid incessantly opening
> >>>> and closing that file while the device is idle, as this would remove
> >>>> -all- RCU work when nearly idle.  But some of the other call_rcu_lazy()
> >>>> use cases would likely remain.
> >>>
> >>> So I'm thinking the scheme I outlined gets you most if not all of what
> >>> lazy would get you without having to add the lazy thing. A CPU is never
> >>> refused deep idle when it passes off the callbacks.
> >>>
> >>> The NOHZ thing is a nice hook for 'this-cpu-wants-to-go-idle-long-term'
> >>> and do our utmost bestest to move work away from it. You *want* to break
> >>> affinity at this point.
> >>>
> >>> If you hate on the global, push it to a per rcu_node offload list until
> >>> the whole node is idle and then push it up the next rcu_node level until
> >>> you reach the top.
> >>>
> >>> Then when the top rcu_node is full idle; you can insta progress the QS
> >>> state and run the callbacks and go idle.
> >>
> >> In my opinion the speed brakes have to be applied before the GP and
> >> other threads are even awakened. The issue Android and ChromeOS
> >> observe is that even a single CB queued every few jiffies can cause
> >> work that can be otherwise delayed / batched, to be scheduled in. I am
> >> not sure if your suggestions above address that. Does it?
> > 
> > Scheduled how? Is this callbacks doing queue_work() or something?
> 
> Way before the callback is even ready to execute, you can rcuog, rcuop,
> rcu_preempt threads running to go through the grace period state machine.
> 
> > Anyway; the thinking is that by passing off the callbacks on NOHZ, the
> > idle CPUs stay idle. By running the callbacks before going full idle,
> > all work is done and you can stay idle longer.
> 
> But all CPUs idle does not mean grace period is over, you can have a task (at
> least on PREEMPT_RT) block in the middle of an RCU read-side critical section
> and then all CPUs go idle.
> 
> Other than that, a typical flow could look like:
> 
> 1. CPU queues a callback.
> 2. CPU then goes idle.
> 3. Another CPU is running the RCU threads waking up otherwise idle CPUs.
> 4. Grace period completes and an RCU thread runs a callback.
> 
> >> Try this experiment on your ADL system (for fun). Boot to the login
> >> screen on any distro,
> > 
> > All my dev boxes are headless :-) I don't thinkt he ADL even has X or
> > wayland installed.
> 
> Ah, ok. Maybe what you have (like daemons) are already requesting RCU for
> something. Android folks had some logger requesting RCU all the time.
> 
> >> and before logging in, run turbostat over ssh
> >> and observe PC8 percent residencies. Now increase
> >> jiffies_till_first_fqs boot parameter value to 64 or so and try again.
> >> You may be surprised how much PC8 percent increases by delaying RCU
> >> and batching callbacks (via jiffies boot option) Admittedly this is
> >> more amplified on ADL because of package-C-states, firmware and what
> >> not, and isn’t as much a problem on Android; but still gives a nice
> >> power improvement there.
> > 
> > I can try; but as of now turbostat doesn't seem to work on that thing at
> > all. I think localyesconfig might've stripped a required bit. I'll poke
> > at it later.
> 
> Cool! I believe Len Brown can help on that , or maybe there is another way you
> can read the counters to figure out the PC8% and RAPL power.

Whatever the evaluation scheme, it absolutely -must- measure real power
consumed by real hardware running some real-world workload compared to
Joel et al.'s scheme, or I will cheerfully ignore it.  ;-)

							Thanx, Paul
