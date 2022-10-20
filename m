Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE96065E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiJTQeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJTQd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:33:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88681D8F20;
        Thu, 20 Oct 2022 09:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9378DB826C8;
        Thu, 20 Oct 2022 16:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57611C433D6;
        Thu, 20 Oct 2022 16:33:53 +0000 (UTC)
Date:   Thu, 20 Oct 2022 12:33:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Add trace_trigger kernel command line option
Message-ID: <20221020123357.0f90e823@gandalf.local.home>
In-Reply-To: <20221020155900.GM5600@paulmck-ThinkPad-P17-Gen-1>
References: <20221019200137.70343645@gandalf.local.home>
        <20221019200745.0152fc51@gandalf.local.home>
        <20221020155900.GM5600@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 08:59:00 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Wed, Oct 19, 2022 at 08:07:45PM -0400, Steven Rostedt wrote:
> > On Wed, 19 Oct 2022 20:01:37 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > @@ -90,6 +90,10 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
> > >  #ifdef CONFIG_TRACEPOINTS
> > >  static inline void tracepoint_synchronize_unregister(void)
> > >  {
> > > +	/* Early updates do not need synchronization */
> > > +	if (early_boot_irqs_disabled)
> > > +		return;
> > > +
> > >  	synchronize_srcu(&tracepoint_srcu);
> > >  	synchronize_rcu();  
> > 
> > I wonder if this check should be just moved to the RCU synchronization
> > code? That is, if early_boot_irqs_disabled is set, do nothing, as there
> > should be nothing to synchronize against.  
> 
> There already is a similar check, but it follows the lockdep check.
> 
> Does the following patch help?

Not sure if it would.

I added this:


diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c03fd7037add..79ac31a6a87b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2748,9 +2748,12 @@ void trace_buffered_event_disable(void)
 			       disable_trace_buffered_event, NULL, 1);
 	preempt_enable();
 
+	if (!irqs_disabled())
+		printk("IRQS DISABLED!! before %s:%d\n", __func__, __LINE__);
 	/* Wait for all current users to finish */
-	if (!early_boot_irqs_disabled)
-		synchronize_rcu();
+	synchronize_rcu();
+	if (!irqs_disabled())
+		printk("IRQS DISABLED!! after %s:%d\n", __func__, __LINE__);
 
 	for_each_tracing_cpu(cpu) {
 		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));

Which produced this:


[    0.972867] ftrace: allocating 47021 entries in 184 pages
[    0.978285] ftrace section at ffffffffacef74c0 sorted properly
[    0.991153] ftrace: allocated 184 pages with 4 groups
[    0.996163] Dynamic Preempt: full
[    0.999354] rcu: Preemptible hierarchical RCU implementation.
[    1.005020] rcu:     RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=8.
[    1.011680]  Tasks-RCU CPU stall warnings timeout set to 120000 (rcu_task_stall_timeout).
[    1.019813]  Trampoline variant of Tasks RCU enabled.
[    1.024831]  Rude variant of Tasks RCU enabled.
[    1.029330]  Tracing variant of Tasks RCU enabled.
[    1.034089] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    1.041699] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    1.052607] IRQS DISABLED!! after trace_buffered_event_disable:2756
[    1.058712] NR_IRQS: 8448, nr_irqs: 488, preallocated irqs: 16
[    1.064670] NO_HZ: Full dynticks CPUs: 3.
[    1.068501] rcu:     Offload RCU callbacks from CPUs: 3.
[    1.073519] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    1.080400] ------------[ cut here ]------------
[    1.084938] Interrupts were enabled early
[    1.088919] WARNING: CPU: 0 PID: 0 at init/main.c:1061 start_kernel+0x36f/0x4e8
[    1.096184] Modules linked in:
[    1.099213] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-rc1-test+ #468
[    1.106047] Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
[    1.114960] RIP: 0010:start_kernel+0x36f/0x4e8
[    1.119373] Code: 48 27 53 e8 fd 7b 03 00 e8 55 72 e5 fe e8 6b 05 03 00 ff 15 2a f9 89 ff 0f ba e0 09 73 0e 48 c7 c7 98 25 31 ac e8 01 5b df fe <0f> 0b c6 05 c7 2c af ff 00 e8 ba 36 47 fe ff 15 14 f9 89 ff e8 56
[    1.138057] RSP: 0000:ffffffffac603f30 EFLAGS: 00010286
[    1.143248] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    1.150343] RDX: 0000000000000002 RSI: 00000000ffffdfff RDI: 0000000000000001
[    1.157438] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffac603dd8
[    1.164537] R10: 0000000000000003 R11: ffffffffac734168 R12: 000000000000180a
[    1.171633] R13: 00000000010fecf0 R14: 0000000000000000 R15: 00000000d44e3018
[    1.178730] FS:  0000000000000000(0000) GS:ffff93ee1aa00000(0000) knlGS:0000000000000000
[    1.186778] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.192489] CR2: ffff93ee1edff000 CR3: 000000002e60a001 CR4: 00000000000606f0
[    1.199584] Call Trace:
[    1.202009]  <TASK>


So I'm not sure how just updating srcu will do anything to prevent this.

-- Steve

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index ca4b5dcec675b..356ef70d5442c 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1267,14 +1267,15 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
>  {
>  	struct rcu_synchronize rcu;
>  
> +	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> +		return;
> +
>  	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
>  			 lock_is_held(&rcu_bh_lock_map) ||
>  			 lock_is_held(&rcu_lock_map) ||
>  			 lock_is_held(&rcu_sched_lock_map),
>  			 "Illegal synchronize_srcu() in same-type SRCU (or in RCU) read-side critical section");
>  
> -	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> -		return;
>  	might_sleep();
>  	check_init_srcu_struct(ssp);
>  	init_completion(&rcu.completion);

