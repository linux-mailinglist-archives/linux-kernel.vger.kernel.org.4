Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9D7653BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 06:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbiLVFzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 00:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVFzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 00:55:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8542424A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 21:55:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B33B619E4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBE3C433EF;
        Thu, 22 Dec 2022 05:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671688515;
        bh=7wgtpazBmreGkMXHDvoM3SUUAXlNsEBe1y9JNML7M/A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GuCxuvbCIxYqzkHM2v9/Mg0JxRPkVTr1BlKPd45TZ5eIsDDj6DKcQI7ws0puoxQ5L
         BCiUCQzVItsaNeCzR9p4I2J8QEeizl5PKsMV71mhIBPidWcqihFmJIvLAvBYXaPipj
         lcVwxwittGaZk3SnlCOLanG1yZ04UKb3GFp4fmNFHaSxG6LFsXF3P9cMTst63N5co7
         Q3LyYxaLY3uOpiJ/ySfz9pwqPdq5JRWkjfOl9ToiaEiJzk0IKL48XXLTOYBU+CQvki
         /xN65ppVlIPxlIeJ8w3q14THhtuSYZufYEYZLXWS61GxiVUWICWVxiae45y2ILKBZk
         Kqj5Zkgo/MEjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1C3685C1409; Wed, 21 Dec 2022 21:55:15 -0800 (PST)
Date:   Wed, 21 Dec 2022 21:55:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Feng Tang <feng.tang@intel.com>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Message-ID: <20221222055515.GJ4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221220082512.186283-1-feng.tang@intel.com>
 <6fb04ee9-ce77-4835-2ad1-b7f8419cfb77@redhat.com>
 <20221220183400.GY4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6Ja+kYQAi4pppV6@feng-clx>
 <8a9bed0d-c166-37e9-24c3-8cea7a336c76@redhat.com>
 <20221222004032.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <a82092f5-abc8-584f-b2ba-f06c82ffbe7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a82092f5-abc8-584f-b2ba-f06c82ffbe7d@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 10:39:53PM -0500, Waiman Long wrote:
> On 12/21/22 19:40, Paul E. McKenney wrote:
> > commit 199dfa2ba23dd0d650b1482a091e2e15457698b7
> > Author: Paul E. McKenney<paulmck@kernel.org>
> > Date:   Wed Dec 21 16:20:25 2022 -0800
> > 
> >      clocksource: Verify HPET and PMTMR when TSC unverified
> >      On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
> >      NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
> >      TSC is disabled.  This works well much of the time, but there is the
> >      occasional system that meets all of these criteria, but which still
> >      has a TSC that skews significantly from atomic-clock time.  This is
> >      usually attributed to a firmware or hardware fault.  Yes, the various
> >      NTP daemons do express their opinions of userspace-to-atomic-clock time
> >      skew, but they put them in various places, depending on the daemon and
> >      distro in question.  It would therefore be good for the kernel to have
> >      some clue that there is a problem.
> >      The old behavior of marking the TSC unstable is a non-starter because a
> >      great many workloads simply cannot tolerate the overheads and latencies
> >      of the various non-TSC clocksources.  In addition, NTP-corrected systems
> >      often seem to be able to tolerate significant kernel-space time skew as
> >      long as the userspace time sources are within epsilon of atomic-clock
> >      time.
> >      Therefore, when watchdog verification of TSC is disabled, enable it for
> >      HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
> >      time-skew diagnostic without degrading the system's performance.
> >      Signed-off-by: Paul E. McKenney<paulmck@kernel.org>
> >      Cc: Thomas Gleixner<tglx@linutronix.de>
> >      Cc: Ingo Molnar<mingo@redhat.com>
> >      Cc: Borislav Petkov<bp@alien8.de>
> >      Cc: Dave Hansen<dave.hansen@linux.intel.com>
> >      Cc: "H. Peter Anvin"<hpa@zytor.com>
> >      Cc: Daniel Lezcano<daniel.lezcano@linaro.org>
> >      Cc: Feng Tang<feng.tang@intel.com>
> >      Cc: Waiman Long <longman@redhat.com
> >      Cc:<x86@kernel.org>
> 
> As I currently understand, you are trying to use TSC as a watchdog to check
> against HPET and PMTMR. I do have 2 questions about this patch.
> 
> First of all, why you need to use both HPET and PMTMR? Can you just use one
> of those that are available. Secondly, is it possible to enable this
> time-skew diagnostic for a limit amount of time instead running
> indefinitely? The running of the clocksource watchdog itself will still
> consume a tiny amount of CPU cycles.

I could certainly do something so that only the first of HPET and PMTMR
is checked.  Could you give me a quick run-through of the advantages of
using only one?  I would need to explain that in the commit log.

Would it make sense to have a kernel boot variable giving the number of
minutes for which the watchdog was to run, with a default of zero
meaning "indefinitely"?

							Thanx, Paul
