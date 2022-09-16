Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082D35BA7AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiIPH6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiIPH6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:58:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5873AA287D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADF656289E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EB9C433C1;
        Fri, 16 Sep 2022 07:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663315100;
        bh=MBOSxYYLxTC0AA0RQL/v6KkTIIHiAlcDosHo7JoDucE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=io3x+1dRD/uZGHpVeZwZCRXl69L5pPXzM/xfK7OR8cRzoHXdt/XrY3zMzu+KSPnyt
         Xpb2NNWKQJ6K02gjfTzfcvZ7TGjxLiO3ujcmhV8/UCoUPgZa+SLTXCfTMio/2eWw19
         c7jkXYoSGOuAJVBJpf1dUdMFLr1LhmP20CcrBCFfLhDJiUnCA2k1XJEirBkW8qQ1U4
         mDTtP+2DHRgaH5YZLFiJtKQ3p6DybOxCNSWVfoL0l0GuzirD3nSMW2gkORbQePZXJj
         FW3lgW6WMsguPCKpWddXoC1t+aU7TFl5Am3VwgC2HkkJsLNSGhBH/n8FzjPK5oCGef
         faSU+B2BZ8mUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 801775C09ED; Fri, 16 Sep 2022 00:58:17 -0700 (PDT)
Date:   Fri, 16 Sep 2022 00:58:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 12:30:34AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 15, 2022 at 12:14:27PM -0700, Paul E. McKenney wrote:
> > On Thu, Sep 15, 2022 at 08:50:44PM +0200, Peter Zijlstra wrote:
> > > On Thu, Sep 15, 2022 at 09:06:00AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Sep 15, 2022 at 10:39:12AM +0200, Peter Zijlstra wrote:
> > > > > Hi,
> > > > > 
> > > > > After watching Joel's talk about RCU and idle ticks I was wondering
> > > > > about why RCU doesn't have NOHZ hooks -- that is regular NOHZ, not the
> > > > > NOHZ_FULL stuff.
> > > > 
> > > > It actually does, but they have recently moved into the context-tracking
> > > > code, courtesy of Frederic's recent patch series.
> > > 
> > > afair that's idle and that is not nohz.
> > 
> > For nohz_full CPUs, it does both.
> 
> Normal people don't have nohz_full cpus (and shouldn't want any).

To the best of my knowledge at this point in time, agreed.  Who knows
what someone will come up with next week?  But for people running certain
types of real-time and HPC workloads, context tracking really does handle
both idle and userspace transitions.

> > > > > These deep idle states are only feasible during NOHZ idle, and the NOHZ
> > > > > path is already relatively expensive (which is offset by then mostly
> > > > > staying idle for a long while).
> > > > > 
> > > > > Specifically my thinking was that when a CPU goes NOHZ it can splice
> > > > > it's callback list onto a global list (cmpxchg), and then the
> > > > > jiffy-updater CPU can look at and consume this global list (xchg).
> > > > > 
> > > > > Before you say... but globals suck (they do), NOHZ already has a fair
> > > > > amount of global state, and as said before, it's offset by the CPU then
> > > > > staying idle for a fair while. If there is heavy contention on the NOHZ
> > > > > data, the idle governor is doing a bad job by selecting deep idle states
> > > > > whilst we're not actually idle for long.
> > > > > 
> > > > > The above would remove the reason for RCU to inhibit NOHZ.
> > > > > 
> > > > > 
> > > > > Additionally; when the very last CPU goes idle (I think we know this
> > > > > somewhere, but I can't reaily remember where) we can insta-advance the
> > > > > QS machinery and run the callbacks before going (NOHZ) idle.
> > > > > 
> > > > > 
> > > > > Is there a reason this couldn't work? To me this seems like a much
> > > > > simpler solution than the whole rcu-cb thing.
> > > > 
> > > > To restate Joel's reply a bit...
> > > > 
> > > > Maybe.
> > > > 
> > > > Except that we need rcu_nocbs anyway for low latency and HPC applications.
> > > > Given that we have it, and given that it totally eliminates RCU-induced
> > > > idle ticks, how would it help to add cmpxchg-based global offloading?
> > > 
> > > Because that nocb stuff isn't default enabled?
> > 
> > Last I checked, both RHEL and Fedora were built with CONFIG_RCU_NOCB_CPU=y.
> > And I checked Fedora just now.
> > 
> > Or am I missing your point?
> 
> I might be missing the point; but why did Joel have a talk if it's all
> default on?

It wasn't enabled for ChromeOS.

When fully enabled, it gave them the energy-efficiency advantages Joel
described.  And then Joel described some additional call_rcu_lazy()
changes that provided even better energy efficiency.  Though I believe
that the application should also be changed to avoid incessantly opening
and closing that file while the device is idle, as this would remove
-all- RCU work when nearly idle.  But some of the other call_rcu_lazy()
use cases would likely remain.

If someone believes that their workload would benefit similarly and they
are running Fedora or RHEL (and last I knew, the SUSE distros as well),
then they can boot with rcu_nocbs=0-N and try it out.  No need to further
change RCU until proven otherwise.

							Thanx, Paul
