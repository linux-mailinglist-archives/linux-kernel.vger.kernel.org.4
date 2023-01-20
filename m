Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981E5675EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjATUdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjATUdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:33:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A4794314;
        Fri, 20 Jan 2023 12:33:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE046B82A39;
        Fri, 20 Jan 2023 20:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ABAC433EF;
        Fri, 20 Jan 2023 20:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674246780;
        bh=KNeU9dF7BPYYHrfuzAoXR+3/MgCICpanWwSgbqYJdZQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VBIa/Xr6dXGJfcjdbYJb+N38/8x40QMn0sHitrtoPBpqRGBT2AtGIpIq1H8ZDNFTi
         QNgsGmbLk0MnBwF2Hnpbg+xOTpI+A7uJDNs9G/Xg/YMrFkgtCpzfVVZjt+u6oSwMcM
         hu/RpZtPDowBmgliIhhjV4IzSvt/TbHn+UN1Wg9QwLXaTApQON0et7zW4Jr+EMoIXX
         9QZyEmDHQeajQL+sL0ADpd+N7Gx0PTTdkvq9CIC3YqocZvPzhxKp4Jw0wytytnMwUl
         /qB+JPNEbcRrRIOhlZ3BavEbzFOvKmjF2nF2hHVet55kIVRCM02oU3LKwl40f0ZLO6
         huhDfwzVW4QaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 37B5A5C17DC; Fri, 20 Jan 2023 12:33:00 -0800 (PST)
Date:   Fri, 20 Jan 2023 12:33:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Message-ID: <20230120203300.GV2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <PH0PR11MB5880A16045A842AB80A25C4BDAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <B3E458A6-9279-4716-B242-873C77EC1E3A@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B3E458A6-9279-4716-B242-873C77EC1E3A@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 08:27:03AM -0500, Joel Fernandes wrote:
> 
> 
> > On Jan 20, 2023, at 3:19 AM, Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
> > 
> > ﻿
> >> 
> >> 
> >>>> On Wed, Jan 18, 2023 at 03:30:14PM +0800, Zqiang wrote:
> >>>>> When inovke rcu_report_qs_rdp(), if current CPU's rcu_data structure's ->
> >>>>> grpmask has not been cleared from the corresponding rcu_node structure's
> >>>>> ->qsmask, after that will clear and report quiescent state, but in this
> >>>>> time, this also means that current grace period is not end, the current
> >>>>> grace period is ongoing, because the rcu_gp_in_progress() currently return
> >>>>> true, so for non-offloaded rdp, invoke rcu_accelerate_cbs() is impossible
> >>>>> to return true.
> >>>>> 
> >>>>> This commit therefore remove impossible rcu_gp_kthread_wake() calling.
> >>>>> 
> >>>>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >>>>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> >>> 
> >>> Queued (wordsmithed as shown below, as always, please check) for further
> >>> testing and review, thank you both!
> >>> 
> >>>                                                      Thanx, Paul
> >>> 
> >>> ------------------------------------------------------------------------
> >>> 
> >>> commit fbe3e300ec8b3edd2b8f84dab4dc98947cf71eb8
> >>> Author: Zqiang <qiang1.zhang@intel.com>
> >>> Date:   Wed Jan 18 15:30:14 2023 +0800
> >>> 
> >>>    rcu: Remove never-set needwake assignment from rcu_report_qs_rdp()
> >>> 
> >>>    The rcu_accelerate_cbs() function is invoked by rcu_report_qs_rdp()
> >>>    only if there is a grace period in progress that is still blocked
> >>>    by at least one CPU on this rcu_node structure.  This means that
> >>>    rcu_accelerate_cbs() should never return the value true, and thus that
> >>>    this function should never set the needwake variable and in turn never
> >>>    invoke rcu_gp_kthread_wake().
> >>> 
> >>>    This commit therefore removes the needwake variable and the invocation
> >>>    of rcu_gp_kthread_wake() in favor of a WARN_ON_ONCE() on the call to
> >>>    rcu_accelerate_cbs().  The purpose of this new WARN_ON_ONCE() is to
> >>>    detect situations where the system's opinion differs from ours.
> >>> 
> >>>    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >>>    Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> >>>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >>> 
> >>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >>> index b2c2045294780..7a3085ad0a7df 100644
> >>> --- a/kernel/rcu/tree.c
> >>> +++ b/kernel/rcu/tree.c
> >>> @@ -1956,7 +1956,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> >>> {
> >>>      unsigned long flags;
> >>>      unsigned long mask;
> >>> -     bool needwake = false;
> >>>      bool needacc = false;
> >>>      struct rcu_node *rnp;
> >>> 
> >>> @@ -1988,7 +1987,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> >>>               * NOCB kthreads have their own way to deal with that...
> >>>               */
> >>>              if (!rcu_rdp_is_offloaded(rdp)) {
> >>> -                     needwake = rcu_accelerate_cbs(rnp, rdp);
> >>> +                     /*
> >>> +                      * The current GP has not yet ended, so it
> >>> +                      * should not be possible for rcu_accelerate_cbs()
> >>> +                      * to return true.  So complain, but don't awaken.
> >>> +                      */
> >>> +                     WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
> >>>              } else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
> >>>                      /*
> >>>                       * ...but NOCB kthreads may miss or delay callbacks acceleration
> >>> @@ -2000,8 +2004,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> >>>              rcu_disable_urgency_upon_qs(rdp);
> >>>              rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> >>>              /* ^^^ Released rnp->lock */
> >>> -             if (needwake)
> >>> -                     rcu_gp_kthread_wake();
> >>> 
> >>> AFAICS, there is almost no compiler benefit of doing this, and zero runtime
> >>> benefit of doing this. The WARN_ON_ONCE() also involves a runtime condition
> >>> check of the return value of rcu_accelerate_cbs(), so you still have a
> >>> branch. Yes, maybe slightly smaller code without the wake call, but I'm not
> >>> sure that is worth it.
> >>> 
> >>> And, if the opinion of system differs, its a bug anyway, so more added risk.
> >>> 
> >>> 
> >>> 
> >>>              if (needacc) {
> >>>                      rcu_nocb_lock_irqsave(rdp, flags);
> >>> 
> >>> And when needacc = true, rcu_accelerate_cbs_unlocked() tries to do a wake up
> >>> anyway, so it is consistent with nocb vs !nocb.
> >> 
> >> For !nocb, we invoked rcu_accelerate_cbs() before report qs,  so this GP is impossible to end
> >> and we also not set RCU_GP_FLAG_INIT to start new GP in rcu_accelerate_cbs().
> >> but for nocb, when needacc = true, we invoke rcu_accelerate_cbs_unlocked() after current CPU
> >> has reported qs,  if all CPU have been reported qs,  we will wakeup gp kthread to end this GP in
> >> rcu_report_qs_rnp().   after that, the rcu_accelerate_cbs_unlocked() is  possible to try to wake up
> >> gp kthread if this GP has ended at this time.   so nocb vs !nocb is likely to be inconsistent.
> >> 
> >> 
> >> That is a fair point. But after gp ends,  rcu_check_quiescent_state()
> >> -> note_gp_changes() which will do a accel + GP thread wake up at that
> >> point anyway, once it notices that a GP has come to an end. That
> >> should happen for both the nocb and !nocb cases right?
> > 
> > For nocb rdp, we won't invoke rcu_accelerate_cbs() and rcu_advance_cbs() in
> > note_gp_changes().  so also not wakeup gp kthread in note_gp_changes(). 
> 
> Yes correct, ok but…
> > 
> >> 
> >> I am wondering if rcu_report_qs_rdp() needs to be rethought to make
> >> both cases consistent.
> >> 
> >> Why does the nocb case need an accel + GP thread wakeup in the
> >> rcu_report_qs_rdp() function, but the !nocb case does not?
> > 
> > For nocb accel + GP kthread wakeup only happen in the middle of a (de-)offloading process.
> > this is an intermediate state.
> 
> Sure, I know what the code currently does, I am asking why and it feels wrong.
> 
> I suggest you slightly change your approach to not assuming the code should be bonafide correct and then fixing it (which is ok once in a while), and asking higher level questions to why things are the way they are in the first place (that is just my suggestion and I am not in a place to provide advice, far from it, but I am just telling you my approach — I care more about the code than increasing my patch count :P).
> 
> If you are in an intermediate state, part way to a !nocb state — you may have missed a nocb-related accel and wake, correct? Why does that matter? Once we transition to a !nocb state, we do not do a post-qs-report accel+wake anyway as we clearly know from the discussion. So why do we need to do it if we missed it for the intermediate stage? So, I am not fully sure yet what that needac is doing and why it is needed.
> 
> Do not get me wrong, stellar work here. But I suggest challenge the assumptions and the design, not always just the code that was already written :), apologies for any misplaced or noisy advice.

To add to Joel's point, an extra unnecessary check on a slow path can
be OK, but missing a necessary check is of course very bad.

Just to make sure that I am following along, here are the options I see:

1.	Status quo.

2.	Zqiang's current patch, as in remove the wakeup and
	add the WARN_ON_ONCE().

3.	Status quo, and only add the WARN_ON_ONCE(), but still
	keep the needless check for the wakeup.

Are there other options that I have missed?

							Thanx, Paul
