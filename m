Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B4F5BB889
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiIQNgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIQNf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:35:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F1F31EE6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=kSVGLwjHHpXADlmgu1J5mJ+LZ5I+HG7t0XI3xSThcYM=; b=q1hYmOby16d2al+llIDR8ZWK7F
        znf4AQoG2fHEflkvkMpNXAWbSg3/T8yLMm6pPEo8btJQ66RHb0xtRK0p4Bi6xuqjk5xpV+HgFjbvZ
        69m4TIW5aymgMw0w/SKp3+LVNtKuZ3DHBwjITVC6xPbsDf6qQ3VWkM80VIatm9pGJUJNv6o6ccJb6
        rYQ91Q+aHed1IYQ1wmeGazhqheJIccKQ5F8+Vm3qTdFoInEq/s3gDlTeDhMAGUorlNEdQ5g0ORl3f
        V6Wo4MZvaWEdKHT4IUdEBRjJrKysHVifOSzqcitRInczZ7MTWOJXoVYGVCr8JfhIoIJMgak4gGWKu
        sdXxf6ww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oZXyv-003Ei1-2n; Sat, 17 Sep 2022 13:35:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5BAEE30013F;
        Sat, 17 Sep 2022 15:35:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A1FF207EC255; Sat, 17 Sep 2022 15:35:32 +0200 (CEST)
Date:   Sat, 17 Sep 2022 15:35:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RCU vs NOHZ
Message-ID: <YyXNJEH6xafOcp39@hirez.programming.kicks-ass.net>
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <CAEXW_YTN7mnQSN2eJCysLsZOq+8JEOV6pvgw3LDTT=0mnkC2SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTN7mnQSN2eJCysLsZOq+8JEOV6pvgw3LDTT=0mnkC2SA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 02:11:10PM -0400, Joel Fernandes wrote:
> Hi Peter,
> 
> On Fri, Sep 16, 2022 at 5:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
> [...]
> > > It wasn't enabled for ChromeOS.
> > >
> > > When fully enabled, it gave them the energy-efficiency advantages Joel
> > > described.  And then Joel described some additional call_rcu_lazy()
> > > changes that provided even better energy efficiency.  Though I believe
> > > that the application should also be changed to avoid incessantly opening
> > > and closing that file while the device is idle, as this would remove
> > > -all- RCU work when nearly idle.  But some of the other call_rcu_lazy()
> > > use cases would likely remain.
> >
> > So I'm thinking the scheme I outlined gets you most if not all of what
> > lazy would get you without having to add the lazy thing. A CPU is never
> > refused deep idle when it passes off the callbacks.
> >
> > The NOHZ thing is a nice hook for 'this-cpu-wants-to-go-idle-long-term'
> > and do our utmost bestest to move work away from it. You *want* to break
> > affinity at this point.
> >
> > If you hate on the global, push it to a per rcu_node offload list until
> > the whole node is idle and then push it up the next rcu_node level until
> > you reach the top.
> >
> > Then when the top rcu_node is full idle; you can insta progress the QS
> > state and run the callbacks and go idle.
> 
> In my opinion the speed brakes have to be applied before the GP and
> other threads are even awakened. The issue Android and ChromeOS
> observe is that even a single CB queued every few jiffies can cause
> work that can be otherwise delayed / batched, to be scheduled in. I am
> not sure if your suggestions above address that. Does it?

Scheduled how? Is this callbacks doing queue_work() or something?

Anyway; the thinking is that by passing off the callbacks on NOHZ, the
idle CPUs stay idle. By running the callbacks before going full idle,
all work is done and you can stay idle longer.

> Try this experiment on your ADL system (for fun). Boot to the login
> screen on any distro,

All my dev boxes are headless :-) I don't thinkt he ADL even has X or
wayland installed.

> and before logging in, run turbostat over ssh
> and observe PC8 percent residencies. Now increase
> jiffies_till_first_fqs boot parameter value to 64 or so and try again.
> You may be surprised how much PC8 percent increases by delaying RCU
> and batching callbacks (via jiffies boot option) Admittedly this is
> more amplified on ADL because of package-C-states, firmware and what
> not, and isn’t as much a problem on Android; but still gives a nice
> power improvement there.

I can try; but as of now turbostat doesn't seem to work on that thing at
all. I think localyesconfig might've stripped a required bit. I'll poke
at it later.
