Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1EF64DF47
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiLOREp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiLOREO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:04:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E8E45EE5;
        Thu, 15 Dec 2022 09:03:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78447B81C03;
        Thu, 15 Dec 2022 17:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F84C433EF;
        Thu, 15 Dec 2022 17:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671123777;
        bh=rXDGlapaM3Azv+UeAte5jC1QsSGRIgALw2AzMtUQ5yM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=obdOymEu7eYOm+NnFimhdy51BW3QRCfUvTDpOgaJm9kOeNOdBwUp45kJWX8TtpRAL
         YYmwoz3SYpyALGQ+cel1fpM3Y3pZ+Ect4HkLCm47GymFCD32O5bgjgjiwfWB4NOIQs
         hI9hwvR+Rl4aZun3Lmqd5ZCBRdbL6QKD7w8erSIlRy3Yk/Av5t+Vi1xUsD7kfLLzfg
         o7xpHYytkIBYpK//i1vHGqMAUNqJ6uvfCKWuFQbbQqrPZueuxFPbNSRdJI6AKJUTXg
         BNd+fJMADZiB87ZabxPSQxoQjUGR714yLJLhnDSqlz8xdZWpglfduQCVTHdsVRsPIG
         NH8R22LGq4xnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C1C7B5C09D0; Thu, 15 Dec 2022 09:02:56 -0800 (PST)
Date:   Thu, 15 Dec 2022 09:02:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter on
 boot up
Message-ID: <20221215170256.GG4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221213172429.7774f4ba@gandalf.local.home>
 <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
 <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
 <20221215100241.73a30da8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215100241.73a30da8@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 10:02:41AM -0500, Steven Rostedt wrote:
> On Wed, 14 Dec 2022 12:03:33 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > > Avoid calling the synchronization function when system_state is
> > > > SYSTEM_BOOTING.  
> > > 
> > > Shouldn't this be done inside tracepoint_synchronize_unregister()?
> > > Then, it will prevent similar warnings if we expand boot time feature.  
> > 
> > How about the following wide-spectrum fix within RCU_LOCKDEP_WARN()?
> > Just in case there are ever additional issues of this sort?
> 
> Adding more tracing command line parameters is triggering this more. I now
> hit:

Fair point, and apologies for the hassle.

Any chance of getting an official "it is now late enough in boot to
safely invoke lockdep" API?  ;-)

In the meantime, does the (untested and quite crude) patch at the end
of this message help?

							Thanx, Paul

> [    0.213442] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.214653] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
> [    0.232023] ------------[ cut here ]------------
> [    0.232704] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:1410 rcu_poll_gp_seq_start_unlocked+0x8a/0xa0
> [    0.234241] Modules linked in:
> [    0.234715] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-rc6-test-00046-ga0ca17bfe724-dirty #63
> [    0.236069] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [    0.237549] RIP: 0010:rcu_poll_gp_seq_start_unlocked+0x8a/0xa0
> [    0.238495] Code: 02 0f 0b 48 89 ee 5b 48 c7 c7 00 ca b1 b3 5d e9 cc 0f c1 00 65 8b 05 85 f3 dd 4d 85 c0 75 a1 65 8b 05 d6 f0 dd 4d 85 c0 75 96 <0f> 0b eb 92 5b 5d e9 eb 18 fc 00 66 66 2e 0f 1f 84 00 00 00 00 00
> [    0.241433] RSP: 0000:ffffffffb3a03d28 EFLAGS: 00010046
> [    0.242289] RAX: 0000000000000000 RBX: ffffffffb3bcfc48 RCX: 0000000000000001
> [    0.243355] RDX: 0000000080000001 RSI: 0000000000000001 RDI: ffffffffb3bcfc48
> [    0.244421] RBP: 0000000000000000 R08: ffff97a3c012b8f8 R09: fffffffffffffffe
> [    0.245569] R10: ffffffffb3a03e78 R11: 00000000ffffffff R12: 0000000000000040
> [    0.246752] R13: ffffffffb3a30500 R14: ffffffffb3be6180 R15: ffff97a3c0355d10
> [    0.247826] FS:  0000000000000000(0000) GS:ffff97a537c00000(0000) knlGS:0000000000000000
> [    0.249084] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.250012] CR2: ffff97a51e201000 CR3: 000000025c826001 CR4: 00000000000606b0
> [    0.251122] Call Trace:
> [    0.251491]  <TASK>
> [    0.251810]  synchronize_rcu+0xb6/0x1e0
> [    0.252393]  ? smp_call_function_many_cond+0x36d/0x3b0
> [    0.253243]  ? enable_trace_buffered_event+0x10/0x10
> [    0.254021]  trace_buffered_event_disable+0x7c/0x140
> [    0.254786]  __ftrace_event_enable_disable+0x11c/0x250
> [    0.255559]  __ftrace_set_clr_event_nolock+0xe3/0x130
> [    0.256321]  ftrace_set_clr_event+0x9a/0xe0
> [    0.256976]  early_enable_events+0x64/0xa8
> [    0.257647]  trace_event_init+0xd6/0x2dd
> [    0.258305]  start_kernel+0x760/0x9e0
> [    0.258862]  secondary_startup_64_no_verify+0xe5/0xeb
> [    0.259634]  </TASK>
> [    0.259966] irq event stamp: 0
> [    0.260427] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    0.261448] hardirqs last disabled at (0): [<0000000000000000>] 0x0
> [    0.262424] softirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    0.263402] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    0.264345] ---[ end trace 0000000000000000 ]---
> [    0.265088] ------------[ cut here ]------------
> 
> Where kernel/rcu/tree.c:1410 is at:
> 
> // Make the polled API aware of the beginning of a grace period, but
> // where caller does not hold the root rcu_node structure's lock.
> static void rcu_poll_gp_seq_start_unlocked(unsigned long *snap)
> {
> 	unsigned long flags;
> 	struct rcu_node *rnp = rcu_get_root();
> 
> 	if (rcu_init_invoked()) {
> 		lockdep_assert_irqs_enabled(); <<-------------- 1410
> 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> 	}
> 	rcu_poll_gp_seq_start(snap);
> 	if (rcu_init_invoked())
> 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> }

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ee8a6a711719a..af8c99920e1a4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -151,7 +151,6 @@ static void sync_sched_exp_online_cleanup(int cpu);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
-static bool rcu_init_invoked(void);
 static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf);
 static void rcu_init_new_rnp(struct rcu_node *rnp_leaf);
 
@@ -1314,7 +1313,7 @@ static void rcu_poll_gp_seq_start(unsigned long *snap)
 {
 	struct rcu_node *rnp = rcu_get_root();
 
-	if (rcu_init_invoked())
+	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
 		raw_lockdep_assert_held_rcu_node(rnp);
 
 	// If RCU was idle, note beginning of GP.
@@ -1330,7 +1329,7 @@ static void rcu_poll_gp_seq_end(unsigned long *snap)
 {
 	struct rcu_node *rnp = rcu_get_root();
 
-	if (rcu_init_invoked())
+	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
 		raw_lockdep_assert_held_rcu_node(rnp);
 
 	// If the previously noted GP is still in effect, record the
@@ -1352,12 +1351,12 @@ static void rcu_poll_gp_seq_start_unlocked(unsigned long *snap)
 	unsigned long flags;
 	struct rcu_node *rnp = rcu_get_root();
 
-	if (rcu_init_invoked()) {
+	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE) {
 		lockdep_assert_irqs_enabled();
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
 	rcu_poll_gp_seq_start(snap);
-	if (rcu_init_invoked())
+	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
@@ -1368,12 +1367,12 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
 	unsigned long flags;
 	struct rcu_node *rnp = rcu_get_root();
 
-	if (rcu_init_invoked()) {
+	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE) {
 		lockdep_assert_irqs_enabled();
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
 	rcu_poll_gp_seq_end(snap);
-	if (rcu_init_invoked())
+	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
@@ -4042,13 +4041,6 @@ EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
 
 #endif /* #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU) */
 
-// Has rcu_init() been invoked?  This is used (for example) to determine
-// whether spinlocks may be acquired safely.
-static bool rcu_init_invoked(void)
-{
-	return !!rcu_state.n_online_cpus;
-}
-
 /*
  * Near the end of the offline process.  Trace the fact that this CPU
  * is going offline.
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index ed6c3cce28f23..26146530d48f9 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -1019,14 +1019,14 @@ unsigned long start_poll_synchronize_rcu_expedited(void)
 	s = get_state_synchronize_rcu();
 	rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
 	rnp = rdp->mynode;
-	if (rcu_init_invoked())
+	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
 		raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
 	if (!poll_state_synchronize_rcu(s)) {
 		rnp->exp_seq_poll_rq = s;
-		if (rcu_init_invoked())
+		if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
 			queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
 	}
-	if (rcu_init_invoked())
+	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
 		raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
 
 	return s;
