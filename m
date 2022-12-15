Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220A864DF95
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiLORZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLORZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:25:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F61BC3A;
        Thu, 15 Dec 2022 09:25:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBFE561E60;
        Thu, 15 Dec 2022 17:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2247AC433F0;
        Thu, 15 Dec 2022 17:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671125122;
        bh=X37v7XzNueR/5gBOowSK8raHMO6tLmlUx+Zxhxvy/7s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FoAFnjsu8+Vn6ME9VVL4TVeoLCUvwCQF693hy5q5W0HE859uMZ1nb/XDk5yN8KGMB
         wzKP5QVzoy2qAWhM1RyipI/HBSqnOD6bC1Ns1f9IxotEoC+uTxW10/yYVT100//SVu
         FHnlVW+4KrE5AvHiNnc0dBYVLrcTOfJmC6g3du4PR1ih373piUBBIVGyH64V2Twakb
         u965GSfCtFc45qVLbZpaGkuvgtJV4jREenwgCYxkDEphfOKUGp7KjIdBLfzBQzyfYG
         ZUZZMMl8Hb4Lb0dfeC9JJcaQZyOGkGDpNAeTTxX8MU7s/m8/ePDFSU4eSWO59B1iz3
         pqa+knD2npRbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C05B15C09D0; Thu, 15 Dec 2022 09:25:21 -0800 (PST)
Date:   Thu, 15 Dec 2022 09:25:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter on
 boot up
Message-ID: <20221215172521.GA2325254@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221213172429.7774f4ba@gandalf.local.home>
 <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
 <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
 <20221215100241.73a30da8@gandalf.local.home>
 <20221215170256.GG4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215170256.GG4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 09:02:56AM -0800, Paul E. McKenney wrote:
> On Thu, Dec 15, 2022 at 10:02:41AM -0500, Steven Rostedt wrote:
> > On Wed, 14 Dec 2022 12:03:33 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > > > Avoid calling the synchronization function when system_state is
> > > > > SYSTEM_BOOTING.  
> > > > 
> > > > Shouldn't this be done inside tracepoint_synchronize_unregister()?
> > > > Then, it will prevent similar warnings if we expand boot time feature.  
> > > 
> > > How about the following wide-spectrum fix within RCU_LOCKDEP_WARN()?
> > > Just in case there are ever additional issues of this sort?
> > 
> > Adding more tracing command line parameters is triggering this more. I now
> > hit:
> 
> Fair point, and apologies for the hassle.
> 
> Any chance of getting an official "it is now late enough in boot to
> safely invoke lockdep" API?  ;-)
> 
> In the meantime, does the (untested and quite crude) patch at the end
> of this message help?

OK, I was clearly not yet awake.  :-/

The more targeted (but still untested) patch below might be more
appropriate...

							Thanx, Paul

------------------------------------------------------------------------

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
