Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29CB64E176
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiLOTCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLOTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:02:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B715831;
        Thu, 15 Dec 2022 11:02:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CA1EB81C51;
        Thu, 15 Dec 2022 19:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97995C433F0;
        Thu, 15 Dec 2022 19:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671130918;
        bh=EqlnpiF2hW1ZTB3GkDpp5xDI2I47oa83tVOKqs81Ee8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BxX9zkZFxrSRUDNL1oxj+pBO/E2xSwm1C9TS7qyiDOiIfLxsfcQQvL90jj76wfjGX
         wYCqijbisAjDrcNyPdwKuQmG3N6+9oNS4U8IDUQGRnc9O1SCPmiYmvZY4piCdYpbaM
         kG8C3MP5ee/7twNvAhutdbIsxQ8sQGQLzxau9K9EXvz1peSlRHpIUZj0nCKKzFH64w
         MbbziJ2CaNA4VSEv2lY3eP7yJ9ee9l0Cp/eodBWJRae+5GtE5lBoEDUD5j7quN8UGx
         Rhfik3ZgbbvjxNZ8p3jSClCjrl6YKoH8BZiw8cKP8sYIh1ZFdBuXLRWE1TTM1Ydblm
         sE36mEZ+vbMtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2CEEE5C09D0; Thu, 15 Dec 2022 11:01:58 -0800 (PST)
Date:   Thu, 15 Dec 2022 11:01:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter on
 boot up
Message-ID: <20221215190158.GK4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221213172429.7774f4ba@gandalf.local.home>
 <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
 <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
 <20221215100241.73a30da8@gandalf.local.home>
 <20221215170256.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <20221215135102.556ee076@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215135102.556ee076@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 01:51:02PM -0500, Steven Rostedt wrote:
> On Thu, 15 Dec 2022 09:02:56 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Thu, Dec 15, 2022 at 10:02:41AM -0500, Steven Rostedt wrote:
> > > On Wed, 14 Dec 2022 12:03:33 -0800
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >   
> > > > > > Avoid calling the synchronization function when system_state is
> > > > > > SYSTEM_BOOTING.    
> > > > > 
> > > > > Shouldn't this be done inside tracepoint_synchronize_unregister()?
> > > > > Then, it will prevent similar warnings if we expand boot time feature.    
> > > > 
> > > > How about the following wide-spectrum fix within RCU_LOCKDEP_WARN()?
> > > > Just in case there are ever additional issues of this sort?  
> > > 
> > > Adding more tracing command line parameters is triggering this more. I now
> > > hit:  
> > 
> > Fair point, and apologies for the hassle.
> > 
> > Any chance of getting an official "it is now late enough in boot to
> > safely invoke lockdep" API?  ;-)
> 
> lockdep API isn't the problem, it's that we are still in the earlyboot stage
> where interrupts are disabled, and you can't enable them. Lockdep works
> just fine there, and is reporting interrupts being disabled correctly. The
> backtrace reported *does* have interrupts disabled.
> 
> The thing is, because we are still running on a single CPU with interrupts
> disabled, there is no need for synchronization. Even grabbing a mutex is
> safe because there's guaranteed to be no contention (unless it's not
> released). This is why a lot of warnings are suppressed if system_state is
> SYSTEM_BOOTING.

Agreed, and my second attempt is a bit more surgical.  (Please see below
for a more official version of it.)

> > In the meantime, does the (untested and quite crude) patch at the end
> > of this message help?
> 
> I'll go and test it, but I'm guessing it will work fine. You could also test
> against system_state != SYSTEM_BOOTING, as that gets cleared just before
> kernel_init() can continue (it waits for the complete() that is called
> after system_state is set to SYSTEM_SCHEDULING). Which happens shortly
> after rcu_scheduler_starting().
> 
> I wonder if you could even replace RCU_SCHEDULER_RUNNING with
> system_state != SYSTEM_BOOTING, and remove the rcu_scheduler_starting()
> call.

In this particular case, agreed, I could use system_state.  But there are
other cases that must change behavior as soon as preemption can happen,
which is upon return from that call to user_mode_thread().  The update to
system_state doesn't happen until much later.  So I don't get to remove
that rcu_scheduler_starting() call.

What case?

Here is one:

o	The newly spawned init process does something that uses RCU,
	but is preempted while holding rcu_read_lock().

o	The boot thread, which did the preempting, waits for a grace
	period.  If we use rcu_scheduler_active, all is well because
	synchronize_rcu() will do a real run-time grace period, thus
	waiting for that reader.

	But system_state has not yet been updated, so if synchronize_rcu()
	were instead to pay attention to that one, there might be a
	tragically too-short RCU grace period.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 876c5ac113fa66a64fa241e69d9a2251b8daa5ee
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Dec 15 09:26:09 2022 -0800

    rcu: Don't assert interrupts enabled too early in boot
    
    The rcu_poll_gp_seq_end() and rcu_poll_gp_seq_end_unlocked() both check
    that interrupts are enabled, as they normally should be when waiting for
    an RCU grace period.  Except that it is legal to wait for grace periods
    during early boot, before interrupts have been enabled for the first time,
    and polling for grace periods is required to work during this time.
    This can result in false-positive lockdep splats in the presence of
    boot-time-initiated tracing.
    
    This commit therefore conditions those interrupts-enabled checks on
    rcu_scheduler_active having advanced past RCU_SCHEDULER_INACTIVE, by
    which time interrupts have been enabled.
    
    Reported-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ee8a6a711719a..f627888715dca 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1314,7 +1314,7 @@ static void rcu_poll_gp_seq_start(unsigned long *snap)
 {
 	struct rcu_node *rnp = rcu_get_root();
 
-	if (rcu_init_invoked())
+	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
 		raw_lockdep_assert_held_rcu_node(rnp);
 
 	// If RCU was idle, note beginning of GP.
@@ -1330,7 +1330,7 @@ static void rcu_poll_gp_seq_end(unsigned long *snap)
 {
 	struct rcu_node *rnp = rcu_get_root();
 
-	if (rcu_init_invoked())
+	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
 		raw_lockdep_assert_held_rcu_node(rnp);
 
 	// If the previously noted GP is still in effect, record the
@@ -1353,7 +1353,8 @@ static void rcu_poll_gp_seq_start_unlocked(unsigned long *snap)
 	struct rcu_node *rnp = rcu_get_root();
 
 	if (rcu_init_invoked()) {
-		lockdep_assert_irqs_enabled();
+		if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
+			lockdep_assert_irqs_enabled();
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
 	rcu_poll_gp_seq_start(snap);
@@ -1369,7 +1370,8 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
 	struct rcu_node *rnp = rcu_get_root();
 
 	if (rcu_init_invoked()) {
-		lockdep_assert_irqs_enabled();
+		if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
+			lockdep_assert_irqs_enabled();
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
 	rcu_poll_gp_seq_end(snap);
