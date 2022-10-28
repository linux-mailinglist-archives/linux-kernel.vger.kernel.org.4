Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216126119A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJ1RwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1RwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:52:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3851285D0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:52:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C4BEB82BE2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 17:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D851BC433D6;
        Fri, 28 Oct 2022 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666979527;
        bh=NMhfxBggYpCBsOUbB3G/6qw4BBdvNzcv96zYd+scd/0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CEUidl/VaIA5gNNq7vpXOrvuxTzrhGxeEJb6HvwEFDvF3HIc06jmdbDobjgw4cBLL
         gTvKqCqjsX0tJeeN9yWjIvNy1Dbvswb7uWi9CD3Ro4i+rMAsurNHeBNiyrWm2q52V3
         RXU/4Zd5yB9JByshRdF19TOF5wt/GDw9av1hGigYVXKy+WUAzVajXfBLRxWwScnvkz
         djn6j/fAC3y+W37UJZKdAOaCZhDqOvzpnc/zk64ms4ND6ii/WooMpqNvx7gYlHxGa9
         UoIh4GnJ44yaFWRbxKRZb9j7R4AenPc55MudrUm2mKVXSIdKybjXplMpLH3/TSvTA8
         3yXpr4ozv1oEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 81E665C0692; Fri, 28 Oct 2022 10:52:07 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:52:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-kernel@vger.kernel.org, clm@meta.com, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, longman@redhat.com
Subject: Re: [PATCH clocksource] Reject bogus watchdog clocksource
 measurements
Message-ID: <20221028175207.GM5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
 <Y1ECHVUHilqgKD9o@feng-clx>
 <20221020140944.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1Hr6PNy9EJk245f@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Hr6PNy9EJk245f@feng-clx>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 08:46:32AM +0800, Feng Tang wrote:
> On Thu, Oct 20, 2022 at 07:09:44AM -0700, Paul E. McKenney wrote:
> [...]
> > > >  static void clocksource_watchdog(struct timer_list *unused)
> > > >  {
> > > > -	u64 csnow, wdnow, cslast, wdlast, delta;
> > > > +	u64 csnow, wdnow, cslast, wdlast, delta, wdi;
> > > >  	int next_cpu, reset_pending;
> > > >  	int64_t wd_nsec, cs_nsec;
> > > >  	struct clocksource *cs;
> > > > @@ -440,6 +440,17 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > >  		if (atomic_read(&watchdog_reset_pending))
> > > >  			continue;
> > > >  
> > > > +		/* Check for bogus measurements. */
> > > > +		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> > > > +		if (wd_nsec < (wdi >> 2)) {
> > > > +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> > > > +			continue;
> > > > +		}
> > > 
> > > If this happens (500ms timer happens only after less than 125ms),
> > > there is some severe problem with timer/interrupt system. 
> > 
> > Should I add ", suspect timer/interrupt bug" just after "jiffy time
> > interval"?  Or would a comment before that pr_warn() work better for you?
> 
> Both are fine for me.

Here is the patch, which just adds comments.  (The exponential-backoff
patch is on its way.)

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 59d9db36dc15b3b40a30d7a3d733dbd412c8557a
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Oct 27 11:58:27 2022 -0700

    clocksource: Add comments to classify bogus measurements
    
    An extremely busy system can delay the clocksource watchdog, so that
    the corresponding too-long bogus-measurement error does not necessarily
    imply an error in the system.  However, a too-short bogus-measurement
    error likely indicates a bug in hardware, firmware or software.
    
    Therefore, add comments clarifying these bogus-measurement pr_warn()s.
    
    Reported-by: Feng Tang <feng.tang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: John Stultz <jstultz@google.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Stephen Boyd <sboyd@kernel.org>
    Cc: Feng Tang <feng.tang@intel.com>
    Cc: Waiman Long <longman@redhat.com>

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index dcaf38c062161..3f5317faf891f 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -443,10 +443,12 @@ static void clocksource_watchdog(struct timer_list *unused)
 		/* Check for bogus measurements. */
 		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
 		if (wd_nsec < (wdi >> 2)) {
+			/* This usually indicates broken timer code or hardware. */
 			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
 			continue;
 		}
 		if (wd_nsec > (wdi << 2)) {
+			/* This can happen on busy systems, which can delay the watchdog. */
 			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
 			continue;
 		}
