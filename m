Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B89606759
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiJTRzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJTRzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:55:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B441011B1;
        Thu, 20 Oct 2022 10:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97BE6B828D6;
        Thu, 20 Oct 2022 17:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3D5C433D6;
        Thu, 20 Oct 2022 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666288513;
        bh=olCfwFcAKX0CaOdhAxPuZ2aK3sQulZxTkJ9xo9OgHKM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e8GafLvJJtn6M443GySVQpu934AuEoEharJyAM6buEZzQYo9XXpkSmRfuWarbrHLS
         7mcpugpytRpHM7biaN/eAP3uaMaId/AeRyQhnMAvCyADDHgPgLV1VJ5MmPveGbRt6b
         7hVzmc/MOUyvzuBIuWOSJQKXB1P3fXYFZa8kixpXOAtK7DOiPaVdxtoyl/P6An3hNf
         Mon8mTtiUGEEAmpEHFT/Ye4fz3cv/RGBq97xHQgo9H5EAkao7Swvh38iEiSIzWZ9MT
         vAYQvLj2F3Rb1ziQwMEytJ0lQX3VOelPtVep8flogqt31ZUFNHBLML0vhh1VNX+toA
         Q+AkqQrz97a1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DE7AE5C0624; Thu, 20 Oct 2022 10:55:12 -0700 (PDT)
Date:   Thu, 20 Oct 2022 10:55:12 -0700
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
Message-ID: <20221020175512.GT5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019200137.70343645@gandalf.local.home>
 <20221019200745.0152fc51@gandalf.local.home>
 <20221020155900.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <20221020123357.0f90e823@gandalf.local.home>
 <20221020130528.5f7436c3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020130528.5f7436c3@gandalf.local.home>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 01:05:28PM -0400, Steven Rostedt wrote:
> On Thu, 20 Oct 2022 12:33:57 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index c03fd7037add..79ac31a6a87b 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -2748,9 +2748,12 @@ void trace_buffered_event_disable(void)
> >  			       disable_trace_buffered_event, NULL, 1);
> >  	preempt_enable();
> >  
> > +	if (!irqs_disabled())
> > +		printk("IRQS DISABLED!! before %s:%d\n", __func__, __LINE__);
> >  	/* Wait for all current users to finish */
> > -	if (!early_boot_irqs_disabled)
> > -		synchronize_rcu();
> > +	synchronize_rcu();
> > +	if (!irqs_disabled())
> > +		printk("IRQS DISABLED!! after %s:%d\n", __func__, __LINE__);
> >  
> >  	for_each_tracing_cpu(cpu) {
> >  		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
> 
> 
> Continuing the above printk()s I found the culprit.
> 
> synchronize_rcu() {
>     rcu_poll_gp_seq_start_unlocked() {
> 	struct rcu_node *rnp = rcu_get_root();
> 
> 	if (rcu_init_invoked()) {
> 		lockdep_assert_irqs_enabled();
> 		raw_spin_lock_irq_rcu_node(rnp);
> 	}
> 	rcu_poll_gp_seq_start(snap);
> 	if (rcu_init_invoked())
> 		raw_spin_unlock_irq_rcu_node(rnp);  <<-- Interrupts enabled here
>    }

Thank you for digging into this!

Does the following help?

							Thanx, Paul

------------------------------------------------------------------------

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
