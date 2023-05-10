Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3256FE2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjEJQ66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjEJQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:58:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0940A0;
        Wed, 10 May 2023 09:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 244C6648A5;
        Wed, 10 May 2023 16:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CA7C433A0;
        Wed, 10 May 2023 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683737914;
        bh=/JbkLgwzzOQw92qBmmq/yGo6ZclGT5J4rQaInPIkh3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BD+k8SWq90YgLMtHTS24acU0iCn9eU2nCp4Z4aNrQGfhlQF1IN2hBetV/VGpBm+uZ
         Lt+p/aOzggTlzacrVMzwAbdiTJ46iVS+FkazkI2ynZR4u1ytOywQK46oCLPJAAnDNP
         6tvcOI8UZ1tcCuxRcLTzvzmH0Bh52Jvg2uaJlytq7WdfBF37Al6bfcqTONfyhIZ5k2
         1ul2MImZG8wTzQ4ORh3/EWyCQzhQT5cfe9UJYClX0z0/c190K4ZGucjlmUwnQCEHVt
         BZqo1MLet+fhu90ivqHlblDEyrWIYPG2fMVwVPDjEuXnzX8xa/pOdiqNfovopk/ffi
         BNGwyMH9dtevw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 98EF1CE134A; Wed, 10 May 2023 09:58:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH rcu 8/8] rcu-tasks: Stop rcu_tasks_invoke_cbs() from using never-onlined CPUs
Date:   Wed, 10 May 2023 09:58:32 -0700
Message-Id: <20230510165832.2187453-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
References: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_tasks_invoke_cbs() function relies on queue_work_on() to silently
fall back to WORK_CPU_UNBOUND when the specified CPU is offline.  However,
the queue_work_on() function's silent fallback mechanism relies on that
CPU having been online at some time in the past.  When queue_work_on()
is passed a CPU that has never been online, workqueue lockups ensue,
which can be bad for your kernel's general health and well-being.

This commit therefore checks whether a given CPU has ever been online,
and, if not substitutes WORK_CPU_UNBOUND in the subsequent call to
queue_work_on().  Why not simply omit the queue_work_on() call entirely?
Because this function is flooding callback-invocation notifications
to all CPUs, and must deal with possibilities that include a sparse
cpu_possible_mask.

This commit also moves the setting of the rcu_data structure's
->beenonline field to rcu_cpu_starting(), which executes on the
incoming CPU before that CPU has ever enabled interrupts.  This ensures
that the required workqueues are present.  In addition, because the
incoming CPU has not yet enabled its interrupts, there cannot yet have
been any softirq handlers running on this CPU, which means that the
WARN_ON_ONCE(!rdp->beenonline) within the RCU_SOFTIRQ handler cannot
have triggered yet.

Fixes: d363f833c6d88 rcu-tasks: Use workqueues for multiple rcu_tasks_invoke_cbs() invocations
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h   |  6 ++++++
 kernel/rcu/tasks.h |  7 +++++--
 kernel/rcu/tree.c  | 12 +++++++++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 4a1b9622598b..98c1544cf572 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -642,4 +642,10 @@ void show_rcu_tasks_trace_gp_kthread(void);
 static inline void show_rcu_tasks_trace_gp_kthread(void) {}
 #endif
 
+#ifdef CONFIG_TINY_RCU
+static inline bool rcu_cpu_beenfullyonline(int cpu) { return true; }
+#else
+bool rcu_cpu_beenfullyonline(int cpu);
+#endif
+
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 5f4fc8184dd0..8f08c087142b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -463,6 +463,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 {
 	int cpu;
 	int cpunext;
+	int cpuwq;
 	unsigned long flags;
 	int len;
 	struct rcu_head *rhp;
@@ -473,11 +474,13 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 	cpunext = cpu * 2 + 1;
 	if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 		rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-		queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
+		cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
+		queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
 		cpunext++;
 		if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-			queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
+			cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
+			queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
 		}
 	}
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 23685407dcf6..54963f8c244c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4305,7 +4305,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	 */
 	rnp = rdp->mynode;
 	raw_spin_lock_rcu_node(rnp);		/* irqs already disabled. */
-	rdp->beenonline = true;	 /* We have now been online. */
 	rdp->gp_seq = READ_ONCE(rnp->gp_seq);
 	rdp->gp_seq_needed = rdp->gp_seq;
 	rdp->cpu_no_qs.b.norm = true;
@@ -4332,6 +4331,16 @@ static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
 	rcu_boost_kthread_setaffinity(rdp->mynode, outgoing);
 }
 
+/*
+ * Has the specified (known valid) CPU ever been fully online?
+ */
+bool rcu_cpu_beenfullyonline(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	return smp_load_acquire(&rdp->beenonline);
+}
+
 /*
  * Near the end of the CPU-online process.  Pretty much all services
  * enabled, and the CPU is now very much alive.
@@ -4435,6 +4444,7 @@ void rcu_cpu_starting(unsigned int cpu)
 		raw_spin_unlock_rcu_node(rnp);
 	}
 	arch_spin_unlock(&rcu_state.ofl_lock);
+	smp_store_release(&rdp->beenonline, true);
 	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
 }
 
-- 
2.40.1

