Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E93606B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJTWVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJTWVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:21:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14AA167247;
        Thu, 20 Oct 2022 15:21:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56BC9B82963;
        Thu, 20 Oct 2022 22:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0289EC433D7;
        Thu, 20 Oct 2022 22:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666304469;
        bh=+s0de9l8e0H+4Fr2UmKetsX8PYYA9HTQe45xIaD6/2M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WKXzSrMXf77CXWQOiaLP4RH1R0/K3UwCe9an59b50CqWHxw7zYMWKv1xdYkYeRu38
         BLV0Uc9k4IOyRelnUuZpnkrR172Ahn8cBzgRstIEOu2aVmJq+O9TkWJnc2s3vRRMfr
         hx3vJ/FKwvzaFMEdcvK4sXq+xGFMyt9nBiLRU5HmUxULMrhIPwWGT/+TK4xKj2+ltq
         KRldNytFh0iMcajMrOIMcCXw4RRrC3LSfxMQ+dtbyUa9zFWXeawBRg4NMa1jHYJZMu
         dNWEGEZeb1p54U9Lq4/DLXIRZpwBgSTBlZuf1eUO/tNvXECUmfWrFsvelWEroX/siI
         C9HYUz1wcGeyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A6C4B5C1109; Thu, 20 Oct 2022 15:21:08 -0700 (PDT)
Date:   Thu, 20 Oct 2022 15:21:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Add trace_trigger kernel command line option
Message-ID: <20221020222108.GZ5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019200137.70343645@gandalf.local.home>
 <20221019200745.0152fc51@gandalf.local.home>
 <20221020155900.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <20221020123357.0f90e823@gandalf.local.home>
 <20221020130528.5f7436c3@gandalf.local.home>
 <20221020175512.GT5600@paulmck-ThinkPad-P17-Gen-1>
 <20221020145340.5feef48f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020145340.5feef48f@gandalf.local.home>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 02:53:40PM -0400, Steven Rostedt wrote:
> On Thu, 20 Oct 2022 10:55:12 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > synchronize_rcu() {
> > >     rcu_poll_gp_seq_start_unlocked() {
> > > 	struct rcu_node *rnp = rcu_get_root();
> > > 
> > > 	if (rcu_init_invoked()) {
> > > 		lockdep_assert_irqs_enabled();
> > > 		raw_spin_lock_irq_rcu_node(rnp);
> > > 	}
> > > 	rcu_poll_gp_seq_start(snap);
> > > 	if (rcu_init_invoked())
> > > 		raw_spin_unlock_irq_rcu_node(rnp);  <<-- Interrupts enabled here
> > >    }  
> > 
> > Thank you for digging into this!
> > 
> > Does the following help?
> 
> It does indeed!
> 
> I can remove the early_boot_irqs_disabled checks if you can add this to
> this rc cycle and mark it stable.

My plan is to push it in after a bit of testing.  The Fixes tag should
make the right -stable stuff happen.

							Thanx, Paul

------------------------------------------------------------------------

commit 952643575669332565c77066fb42d67987680f12
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Oct 20 10:58:14 2022 -0700

    rcu: Keep synchronize_rcu() from enabling irqs in early boot
    
    Making polled RCU grace periods account for expedited grace periods
    required acquiring the leaf rcu_node structure's lock during early boot,
    but after rcu_init() was called.  This lock is irq-disabled, but the
    code incorrectly assumes that irqs are always disabled when invoking
    synchronize_rcu().  The exception is early boot before the scheduler has
    started, which means that upon return from synchronize_rcu(), irqs will
    be incorrectly enabled.
    
    This commit fixes this bug by using irqsave/irqrestore locking primitives.
    
    Fixes: bf95b2bc3e42 ("rcu: Switch polled grace-period APIs to ->gp_seq_polled")
    
    Reported-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index abc615808b6e8..45ad9ef00d647 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1425,30 +1425,32 @@ static void rcu_poll_gp_seq_end(unsigned long *snap)
 // where caller does not hold the root rcu_node structure's lock.
 static void rcu_poll_gp_seq_start_unlocked(unsigned long *snap)
 {
+	unsigned long flags;
 	struct rcu_node *rnp = rcu_get_root();
 
 	if (rcu_init_invoked()) {
 		lockdep_assert_irqs_enabled();
-		raw_spin_lock_irq_rcu_node(rnp);
+		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
 	rcu_poll_gp_seq_start(snap);
 	if (rcu_init_invoked())
-		raw_spin_unlock_irq_rcu_node(rnp);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
 // Make the polled API aware of the end of a grace period, but where
 // caller does not hold the root rcu_node structure's lock.
 static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
 {
+	unsigned long flags;
 	struct rcu_node *rnp = rcu_get_root();
 
 	if (rcu_init_invoked()) {
 		lockdep_assert_irqs_enabled();
-		raw_spin_lock_irq_rcu_node(rnp);
+		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
 	rcu_poll_gp_seq_end(snap);
 	if (rcu_init_invoked())
-		raw_spin_unlock_irq_rcu_node(rnp);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
 /*
