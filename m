Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3681606527
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiJTP7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiJTP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:59:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E017F1B1574;
        Thu, 20 Oct 2022 08:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D1E761C54;
        Thu, 20 Oct 2022 15:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4632C433D6;
        Thu, 20 Oct 2022 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666281540;
        bh=lLsjQ8odA6TMieWgMSl0zc7xfIvNSxiJ2vygOSe2c64=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=H3rY1v8M4kh0CEKOLakCtpxmO/1RvJUYsVM5sotfYltMsxArrY4gbsbHGbvwgi8HN
         2ALsOVMahBki0TCYq5OevYF4uOBD1ovJ1Cjqln+Qf/d/KwvC8bVYL+NhRdOMGantaV
         jR03lzkjD/3AqdpSw2MvuP079LGnFacLvKKHFai1/6q+ALC3CTLcs0cES7hog7qBLf
         V4+53Aqtok0C8mykqe45jQBkrQ7TBZmTN5mFrzl3xBpG/9ZOx7dw2F9KjSrS09tciR
         Q/MZmJNANC409k9P/C063cr0UtRkODsxhMfJ/zi9GLXT4KDk8G0N5vnsSPFHuQ7ZbT
         Ry/INN0oX1szw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 71E805C04D0; Thu, 20 Oct 2022 08:59:00 -0700 (PDT)
Date:   Thu, 20 Oct 2022 08:59:00 -0700
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
Message-ID: <20221020155900.GM5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019200137.70343645@gandalf.local.home>
 <20221019200745.0152fc51@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019200745.0152fc51@gandalf.local.home>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:07:45PM -0400, Steven Rostedt wrote:
> On Wed, 19 Oct 2022 20:01:37 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > @@ -90,6 +90,10 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
> >  #ifdef CONFIG_TRACEPOINTS
> >  static inline void tracepoint_synchronize_unregister(void)
> >  {
> > +	/* Early updates do not need synchronization */
> > +	if (early_boot_irqs_disabled)
> > +		return;
> > +
> >  	synchronize_srcu(&tracepoint_srcu);
> >  	synchronize_rcu();
> 
> I wonder if this check should be just moved to the RCU synchronization
> code? That is, if early_boot_irqs_disabled is set, do nothing, as there
> should be nothing to synchronize against.

There already is a similar check, but it follows the lockdep check.

Does the following patch help?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ca4b5dcec675b..356ef70d5442c 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1267,14 +1267,15 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
 {
 	struct rcu_synchronize rcu;
 
+	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
+		return;
+
 	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
 			 lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_srcu() in same-type SRCU (or in RCU) read-side critical section");
 
-	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
-		return;
 	might_sleep();
 	check_init_srcu_struct(ssp);
 	init_completion(&rcu.completion);
