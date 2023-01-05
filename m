Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863FF65E182
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjAEAX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbjAEAXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:23:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC6F44360;
        Wed,  4 Jan 2023 16:23:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BEFFB81990;
        Thu,  5 Jan 2023 00:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C11C433A8;
        Thu,  5 Jan 2023 00:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878188;
        bh=MI3c5QYGakL+wl+pPfIjyXc4qZP1Ce7fJ4Wh6kV0Nls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FuMuwQZWImSI4uvXh25bZyrTECbTfsUQcHsxAcxzPyj5uDX3IUUIWSb0164looBl1
         39qNBTnjnDgnu5ecFHmjdUsFNeG+ReoSu+1SsHtNCAODDaruP6e1BMYWbmdCQ505RP
         uymMeJPCQe3nA/NWZaDRcsXgBucBJRmHO9a/l1YiZ5J0Z/6gBJR82FEJppHO5uYFDX
         7yGYGPcYL8t/QNCJwBos7xi8WF72mo5Gdlq3x00ZR/Y94iuogFSRV+UxHsQstT0lw0
         AyQ3DlebyRg61Vm6tw/YDCboAR8O1fcK8hFXc/ofMPLUUoQhznNA+ArtGCuelH5as4
         GAVr2FwxoJEkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 82E155C1C5D; Wed,  4 Jan 2023 16:23:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH rcu 09/10] rcu: Allow expedited RCU CPU stall warnings to dump task stacks
Date:   Wed,  4 Jan 2023 16:23:04 -0800
Message-Id: <20230105002305.1768591-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces the rcupdate.rcu_exp_stall_task_details kernel
boot parameter, which cause expedited RCU CPU stall warnings to dump
the stacks of any tasks blocking the current expedited grace period.

Reported-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 kernel/rcu/rcu.h                              |  1 +
 kernel/rcu/tree_exp.h                         | 41 +++++++++++++++++++
 kernel/rcu/update.c                           |  2 +
 4 files changed, 49 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf7..aa453f9202d89 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5113,6 +5113,11 @@
 			rcupdate.rcu_cpu_stall_timeout to be used (after
 			conversion from seconds to milliseconds).
 
+	rcupdate.rcu_exp_stall_task_details= [KNL]
+			Print stack dumps of any tasks blocking the
+			current expedited RCU grace period during an
+			expedited RCU CPU stall warning.
+
 	rcupdate.rcu_expedited= [KNL]
 			Use expedited grace-period primitives, for
 			example, synchronize_rcu_expedited() instead
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index c5aa934de59b0..fa640c45172e9 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -224,6 +224,7 @@ extern int rcu_cpu_stall_ftrace_dump;
 extern int rcu_cpu_stall_suppress;
 extern int rcu_cpu_stall_timeout;
 extern int rcu_exp_cpu_stall_timeout;
+extern bool rcu_exp_stall_task_details __read_mostly;
 int rcu_jiffies_till_stall_check(void);
 int rcu_exp_jiffies_till_stall_check(void);
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 927abaf6c822e..249c2967d9e6c 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -11,6 +11,7 @@
 
 static void rcu_exp_handler(void *unused);
 static int rcu_print_task_exp_stall(struct rcu_node *rnp);
+static void rcu_exp_print_detail_task_stall_rnp(struct rcu_node *rnp);
 
 /*
  * Record the start of an expedited grace period.
@@ -671,6 +672,7 @@ static void synchronize_rcu_expedited_wait(void)
 				dump_cpu_task(cpu);
 				preempt_enable();
 			}
+			rcu_exp_print_detail_task_stall_rnp(rnp);
 		}
 		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
 		panic_on_rcu_stall();
@@ -813,6 +815,36 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
 	return ndetected;
 }
 
+/*
+ * Scan the current list of tasks blocked within RCU read-side critical
+ * sections, dumping the stack of each that is blocking the current
+ * expedited grace period.
+ */
+static void rcu_exp_print_detail_task_stall_rnp(struct rcu_node *rnp)
+{
+	unsigned long flags;
+	struct task_struct *t;
+
+	if (!rcu_exp_stall_task_details)
+		return;
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	if (!READ_ONCE(rnp->exp_tasks)) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		return;
+	}
+	t = list_entry(rnp->exp_tasks->prev,
+		       struct task_struct, rcu_node_entry);
+	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
+		/*
+		 * We could be printing a lot while holding a spinlock.
+		 * Avoid triggering hard lockup.
+		 */
+		touch_nmi_watchdog();
+		sched_show_task(t);
+	}
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+}
+
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
 /* Request an expedited quiescent state. */
@@ -885,6 +917,15 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
 	return 0;
 }
 
+/*
+ * Because preemptible RCU does not exist, we never have to print out
+ * tasks blocked within RCU read-side critical sections that are blocking
+ * the current expedited grace period.
+ */
+static void rcu_exp_print_detail_task_stall_rnp(struct rcu_node *rnp)
+{
+}
+
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
 /**
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 587b97c401914..6ed5020aee6d1 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -509,6 +509,8 @@ int rcu_cpu_stall_timeout __read_mostly = CONFIG_RCU_CPU_STALL_TIMEOUT;
 module_param(rcu_cpu_stall_timeout, int, 0644);
 int rcu_exp_cpu_stall_timeout __read_mostly = CONFIG_RCU_EXP_CPU_STALL_TIMEOUT;
 module_param(rcu_exp_cpu_stall_timeout, int, 0644);
+bool rcu_exp_stall_task_details __read_mostly;
+module_param(rcu_exp_stall_task_details, bool, 0644);
 #endif /* #ifdef CONFIG_RCU_STALL_COMMON */
 
 // Suppress boot-time RCU CPU stall warnings and rcutorture writer stall
-- 
2.31.1.189.g2e36527f23

