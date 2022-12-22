Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B54653C15
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiLVGOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiLVGOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:14:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B982036A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 22:14:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0DB1B80185
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9572EC433D2;
        Thu, 22 Dec 2022 06:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671689669;
        bh=XnC+DgEWZz+YzDRGf5j6G0o5KbicYko0CA3hGhqODfg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KDEBy+SCQg7ytllnxTEjOzexshAtWrlZQeLU46fYvbjdLjRBO7nDWSWdivyUHCKY4
         pjcsk5nBJ0z/zNfYoqtjs5516GGXESSG4pOlmMNgfs44VZ9g2/6iFbTsgRuGoyNLDP
         IV4CFSq1J0QMPfEnMDhOgW1FNdJgjfXEzlzzVQr+aGTw8rRTgtwKmQMRKUL/IIIsLS
         ZJxqEWwz/BL5Y8v2K30Yxcbqk+VidGJYVw6Bc4s86K9pKDMfkvBHz7avopEd/c7lRY
         /wDwj9JVODyYMhG5kbRQlhh7sIkQ6SVBb+kPaWya6GmMIX2evSoumc7YKTtblTY42P
         qUeOy3k45RP+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2E78B5C1409; Wed, 21 Dec 2022 22:14:29 -0800 (PST)
Date:   Wed, 21 Dec 2022 22:14:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Waiman Long <longman@redhat.com>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Message-ID: <20221222061429.GL4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221220082512.186283-1-feng.tang@intel.com>
 <6fb04ee9-ce77-4835-2ad1-b7f8419cfb77@redhat.com>
 <20221220183400.GY4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6Ja+kYQAi4pppV6@feng-clx>
 <8a9bed0d-c166-37e9-24c3-8cea7a336c76@redhat.com>
 <20221222004032.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <a82092f5-abc8-584f-b2ba-f06c82ffbe7d@redhat.com>
 <20221222055515.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6PyisHYYtde/6Xk@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6PyisHYYtde/6Xk@feng-clx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 02:00:42PM +0800, Feng Tang wrote:
> On Wed, Dec 21, 2022 at 09:55:15PM -0800, Paul E. McKenney wrote:
> > On Wed, Dec 21, 2022 at 10:39:53PM -0500, Waiman Long wrote:
> > > On 12/21/22 19:40, Paul E. McKenney wrote:
> > > > commit 199dfa2ba23dd0d650b1482a091e2e15457698b7
> > > > Author: Paul E. McKenney<paulmck@kernel.org>
> > > > Date:   Wed Dec 21 16:20:25 2022 -0800
> > > > 
> > > >      clocksource: Verify HPET and PMTMR when TSC unverified
> > > >      On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
> > > >      NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
> > > >      TSC is disabled.  This works well much of the time, but there is the
> > > >      occasional system that meets all of these criteria, but which still
> > > >      has a TSC that skews significantly from atomic-clock time.  This is
> > > >      usually attributed to a firmware or hardware fault.  Yes, the various
> > > >      NTP daemons do express their opinions of userspace-to-atomic-clock time
> > > >      skew, but they put them in various places, depending on the daemon and
> > > >      distro in question.  It would therefore be good for the kernel to have
> > > >      some clue that there is a problem.
> > > >      The old behavior of marking the TSC unstable is a non-starter because a
> > > >      great many workloads simply cannot tolerate the overheads and latencies
> > > >      of the various non-TSC clocksources.  In addition, NTP-corrected systems
> > > >      often seem to be able to tolerate significant kernel-space time skew as
> > > >      long as the userspace time sources are within epsilon of atomic-clock
> > > >      time.
> > > >      Therefore, when watchdog verification of TSC is disabled, enable it for
> > > >      HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
> > > >      time-skew diagnostic without degrading the system's performance.
> > > >      Signed-off-by: Paul E. McKenney<paulmck@kernel.org>
> > > >      Cc: Thomas Gleixner<tglx@linutronix.de>
> > > >      Cc: Ingo Molnar<mingo@redhat.com>
> > > >      Cc: Borislav Petkov<bp@alien8.de>
> > > >      Cc: Dave Hansen<dave.hansen@linux.intel.com>
> > > >      Cc: "H. Peter Anvin"<hpa@zytor.com>
> > > >      Cc: Daniel Lezcano<daniel.lezcano@linaro.org>
> > > >      Cc: Feng Tang<feng.tang@intel.com>
> > > >      Cc: Waiman Long <longman@redhat.com
> > > >      Cc:<x86@kernel.org>
> > > 
> > > As I currently understand, you are trying to use TSC as a watchdog to check
> > > against HPET and PMTMR. I do have 2 questions about this patch.
> > > 
> > > First of all, why you need to use both HPET and PMTMR? Can you just use one
> > > of those that are available. Secondly, is it possible to enable this
> > > time-skew diagnostic for a limit amount of time instead running
> > > indefinitely? The running of the clocksource watchdog itself will still
> > > consume a tiny amount of CPU cycles.
> > 
> > I could certainly do something so that only the first of HPET and PMTMR
> > is checked.  Could you give me a quick run-through of the advantages of
> > using only one?  I would need to explain that in the commit log.
> > 
> > Would it make sense to have a kernel boot variable giving the number of
> > minutes for which the watchdog was to run, with a default of zero
> > meaning "indefinitely"?
> 
> We've discussed about the "os noise", which customer may really care.
> IIUC, this patch intends to test if HPET/PMTIMER HW is broken, so how
> about making it run for a number of minutes the default behavior.   

It is also intended to determine if TSC is broken, with NTP drift rates
used to determine which timer is at fault.

OK, how about a Kconfig option for the number of minutes, set to whatever
you guys tell me?  (Three minutes?  Five minutes?  Something else?)
People wanting to run it continuously could then build their kernels
with that Kconfig option set to zero.

> Also I've run the patch on a Alderlake system, with a fine acpi pm_timer
> and a fake broken pm_timer, and they both works without errors.

Thank you!  Did it correctly identify the fake broken pm_timer as being
broken?  If so, may I have your Tested-by?

							Thanx, Paul
