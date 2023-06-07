Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976BA726969
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjFGTEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjFGTEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:04:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAEE193
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4E5760AAF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 19:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3307FC433EF;
        Wed,  7 Jun 2023 19:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686164690;
        bh=690SB1MKb/qbVP5q5O00E1AwFji+D3GDh3OpSlRXyCI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OB9YV/ZcvvPB2+bAevPHst63/olTqeJmaj5QiQfY2AGR0o4GP+tSbZkavijbvyh3d
         jR8+Nwzxuq2udVuJln74LPhSCfiqf+1Qt+tJTn6vx6s0dF26VldM9vMlRSoho3DW+N
         mBhDnDDoNWzqcvHkhxo35+WecGkBBnZTrm4VLuC471b3E5hto/ZFJQK0v2diEOOWs/
         m1bvI+FBisv8Du3UoI4iv80Q4oBsy0fFPLkbnMqQDNI3HaJty5RbGTLTNwRbwIApz0
         yYrP9Y/qgObcxQ60xPtDTtJXJkDfcmNGl8HS90pqs6NztJ+xdb7ZfvTCAXqRhcPpHi
         noPEmc9HKlvwQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C010DCE0018; Wed,  7 Jun 2023 12:04:49 -0700 (PDT)
Date:   Wed, 7 Jun 2023 12:04:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Chris Bainbridge <chris.bainbridge@gmail.com>, tglx@linutronix.de,
        sboyd@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: skew message does not handle negative ns skew
Message-ID: <86521835-f13f-4d43-9a38-9a55abae0b89@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAP-bSRZuLhZQ4Kpb4NRF2yY6XifYpB3ei4=6oFDAaG+OmeGebQ@mail.gmail.com>
 <ZH8YS+LxMM1ZPpsc@feng-clx>
 <CAP-bSRaNQj+fi1r0MZ64wB5_rfjHmEBFQ+QueiNQ9dnyJixG8A@mail.gmail.com>
 <ZH8pyG1SyfGxQKAm@feng-clx>
 <CAP-bSRa3_Janfh0yAnwmG=bh9niNUjWRPG2fQqc2SxcQR=OHGA@mail.gmail.com>
 <ZH86C4A4qpeAz/n4@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH86C4A4qpeAz/n4@feng-clx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:52:11PM +0800, Feng Tang wrote:
> On Tue, Jun 06, 2023 at 02:09:08PM +0100, Chris Bainbridge wrote:
> > On Tue, 6 Jun 2023 at 13:50, Feng Tang <feng.tang@intel.com> wrote:
> > >
> > > And I'm have no idea if there is a real hardware/firmware issue
> > > or just a false alarm.
> > 
> > Is a negative reported skew valid? I don't know, I had assumed so, so
> > the problem was the conversion from -878159 ns to 18446744073708 ms.
> 
> I think it's valid. The related code is from kernel/time/clocksource.c: 
> 
> 	"
> 	cs_wd_msec = div_u64_rem(cs_nsec - wd_nsec, 1000U * 1000U, &wd_rem);
> 	wd_msec = div_u64_rem(wd_nsec, 1000U * 1000U, &wd_rem);
> 	pr_warn("                      Clocksource '%s' skewed %lld ns (%lld ms) over watchdog '%s' interval of %lld ns (%lld ms)\n",
> 		cs->name, cs_nsec - wd_nsec, cs_wd_msec, watchdog->name, wd_nsec, wd_msec);
> 	"
> 
> The negative value just means the watchdog is running faster than
> TSC in the 512 ms checking interval. The 18446744073708 ms is just
> a conversion from s64 value in ns (-878159) to a u64 ns, then a
> u64 ms. 

That is a bit user-unfriendly.  Does the following fix address this
issue at your end?

							Thanx, Paul

------------------------------------------------------------------------

commit 8eb836f2dd44cb1e80dfc603cf47c03603dadcdb
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Jun 7 11:59:49 2023 -0700

    clocksource: Handle negative skews in "skew is too large" messages
    
    The nanosecond-to-millisecond skew computation uses unsigned arithmetic,
    which produces user-unfriendly large positive numbers for negative skews.
    Therefore, use signed arithmetic for this computation in order to preserve
    the negativity.
    
    Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
    Reported-by: Feng Tang <feng.tang@intel.com>
    Fixes: dd029269947a ("clocksource: Improve "skew is too large" messages")
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 91836b727cef..0600e16dbafe 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -473,8 +473,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
 		if (abs(cs_nsec - wd_nsec) > md) {
-			u64 cs_wd_msec;
-			u64 wd_msec;
+			s64 cs_wd_msec;
+			s64 wd_msec;
 			u32 wd_rem;
 
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
@@ -483,8 +483,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 				watchdog->name, wd_nsec, wdnow, wdlast, watchdog->mask);
 			pr_warn("                      '%s' cs_nsec: %lld cs_now: %llx cs_last: %llx mask: %llx\n",
 				cs->name, cs_nsec, csnow, cslast, cs->mask);
-			cs_wd_msec = div_u64_rem(cs_nsec - wd_nsec, 1000U * 1000U, &wd_rem);
-			wd_msec = div_u64_rem(wd_nsec, 1000U * 1000U, &wd_rem);
+			cs_wd_msec = div_s64_rem(cs_nsec - wd_nsec, 1000 * 1000, &wd_rem);
+			wd_msec = div_s64_rem(wd_nsec, 1000 * 1000, &wd_rem);
 			pr_warn("                      Clocksource '%s' skewed %lld ns (%lld ms) over watchdog '%s' interval of %lld ns (%lld ms)\n",
 				cs->name, cs_nsec - wd_nsec, cs_wd_msec, watchdog->name, wd_nsec, wd_msec);
 			if (curr_clocksource == cs)
