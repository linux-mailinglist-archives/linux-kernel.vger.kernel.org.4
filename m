Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393EB6D128E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjC3WtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjC3WsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:48:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5397D11661;
        Thu, 30 Mar 2023 15:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5377E621E5;
        Thu, 30 Mar 2023 22:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12691C433AF;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216449;
        bh=MD+awJifXgTYI+jyEqGzeuNPTY3Ajor2DFf2Vk7QvuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Omd3bkbSSQ85EDKlRcNrmSv7Gx9EyIH2tcVwgP74/U9olZ1in1sOuCwEtCfCpYt1b
         ZFVMt9s/heinnyS+k+GuhV58THC/cL2wUqqYWHXt0mk9uudAoYhazEh8iFl4K5/mXZ
         qEsxbV93TvpuXea1VqyJQ4sjZIxZoixdq2QJ/LNhGx+OebiI/gk+l1CvIiyY4Bc1zE
         7hHdyzQNO+GF4LFDHauLq4q5hRbnogswkAZbDdGl6LPKxPwxDHWqGmUSEZcMVGZ5/y
         3WOIIFdhLM0hgZQbBGlR1s44TUkIkZD+upDAuTKNySxi6X4yv71Z/kAF2WVB9D8i14
         1GFYoCidkqATw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 30B06154048B; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 15/20] srcu: Move work-scheduling fields from srcu_struct to srcu_usage
Date:   Thu, 30 Mar 2023 15:47:21 -0700
Message-Id: <20230330224726.662344-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit moves the ->reschedule_jiffies, ->reschedule_count, and
->work fields from the srcu_struct structure to the srcu_usage structure
to reduce the size of the former in order to improve cache locality.

However, this means that the container_of() calls cannot get a pointer
to the srcu_struct because they are no longer in the srcu_struct.
This issue is addressed by adding a ->srcu_ssp field in the srcu_usage
structure that references the corresponding srcu_struct structure.
And given the presence of the sup pointer to the srcu_usage structure,
replace some ssp->srcu_usage-> instances with sup->.

[ paulmck Apply feedback from kernel test robot. ]

Link: https://lore.kernel.org/oe-kbuild-all/202303191400.iO5BOqka-lkp@intel.com/
Suggested-by: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |  9 +++++----
 kernel/rcu/srcutree.c    | 41 +++++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index d544ec1c0c8e..cd0cdd8142c5 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -84,6 +84,10 @@ struct srcu_usage {
 	atomic_t srcu_barrier_cpu_cnt;		/* # CPUs not yet posting a */
 						/*  callback for the barrier */
 						/*  operation. */
+	unsigned long reschedule_jiffies;
+	unsigned long reschedule_count;
+	struct delayed_work work;
+	struct srcu_struct *srcu_ssp;
 };
 
 /*
@@ -92,9 +96,6 @@ struct srcu_usage {
 struct srcu_struct {
 	unsigned int srcu_idx;			/* Current rdr array element. */
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
-	unsigned long reschedule_jiffies;
-	unsigned long reschedule_count;
-	struct delayed_work work;
 	struct lockdep_map dep_map;
 	struct srcu_usage *srcu_sup;		/* Update-side data. */
 };
@@ -119,10 +120,10 @@ struct srcu_struct {
 {												\
 	.lock = __SPIN_LOCK_UNLOCKED(name.lock),						\
 	.srcu_gp_seq_needed = -1UL,								\
+	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
 }
 
 #define __SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
-	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
 	.srcu_sup = &usage_name,								\
 	__SRCU_DEP_MAP_INIT(name)
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 97d1fe9a160c..169a6513b739 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -251,7 +251,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->srcu_barrier_seq = 0;
 	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
-	INIT_DELAYED_WORK(&ssp->work, process_srcu);
+	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
 	ssp->srcu_sup->sda_is_static = is_static;
 	if (!is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
@@ -275,6 +275,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
 		}
 	}
+	ssp->srcu_sup->srcu_ssp = ssp;
 	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
 	return 0;
 }
@@ -647,7 +648,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(ssp)))
 		return; /* Just leak it! */
-	flush_delayed_work(&ssp->work);
+	flush_delayed_work(&ssp->srcu_sup->work);
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
@@ -1059,10 +1060,10 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		// can only be executed during early boot when there is only
 		// the one boot CPU running with interrupts still disabled.
 		if (likely(srcu_init_done))
-			queue_delayed_work(rcu_gp_wq, &ssp->work,
+			queue_delayed_work(rcu_gp_wq, &ssp->srcu_sup->work,
 					   !!srcu_get_delay(ssp));
-		else if (list_empty(&ssp->work.work.entry))
-			list_add(&ssp->work.work.entry, &srcu_boot_list);
+		else if (list_empty(&ssp->srcu_sup->work.work.entry))
+			list_add(&ssp->srcu_sup->work.work.entry, &srcu_boot_list);
 	}
 	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 }
@@ -1723,7 +1724,7 @@ static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay)
 	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 
 	if (pushgp)
-		queue_delayed_work(rcu_gp_wq, &ssp->work, delay);
+		queue_delayed_work(rcu_gp_wq, &ssp->srcu_sup->work, delay);
 }
 
 /*
@@ -1734,22 +1735,24 @@ static void process_srcu(struct work_struct *work)
 	unsigned long curdelay;
 	unsigned long j;
 	struct srcu_struct *ssp;
+	struct srcu_usage *sup;
 
-	ssp = container_of(work, struct srcu_struct, work.work);
+	sup = container_of(work, struct srcu_usage, work.work);
+	ssp = sup->srcu_ssp;
 
 	srcu_advance_state(ssp);
 	curdelay = srcu_get_delay(ssp);
 	if (curdelay) {
-		WRITE_ONCE(ssp->reschedule_count, 0);
+		WRITE_ONCE(sup->reschedule_count, 0);
 	} else {
 		j = jiffies;
-		if (READ_ONCE(ssp->reschedule_jiffies) == j) {
-			WRITE_ONCE(ssp->reschedule_count, READ_ONCE(ssp->reschedule_count) + 1);
-			if (READ_ONCE(ssp->reschedule_count) > srcu_max_nodelay)
+		if (READ_ONCE(sup->reschedule_jiffies) == j) {
+			WRITE_ONCE(sup->reschedule_count, READ_ONCE(sup->reschedule_count) + 1);
+			if (READ_ONCE(sup->reschedule_count) > srcu_max_nodelay)
 				curdelay = 1;
 		} else {
-			WRITE_ONCE(ssp->reschedule_count, 1);
-			WRITE_ONCE(ssp->reschedule_jiffies, j);
+			WRITE_ONCE(sup->reschedule_count, 1);
+			WRITE_ONCE(sup->reschedule_jiffies, j);
 		}
 	}
 	srcu_reschedule(ssp, curdelay);
@@ -1848,7 +1851,7 @@ early_initcall(srcu_bootup_announce);
 
 void __init srcu_init(void)
 {
-	struct srcu_struct *ssp;
+	struct srcu_usage *sup;
 
 	/* Decide on srcu_struct-size strategy. */
 	if (SRCU_SIZING_IS(SRCU_SIZING_AUTO)) {
@@ -1868,13 +1871,13 @@ void __init srcu_init(void)
 	 */
 	srcu_init_done = true;
 	while (!list_empty(&srcu_boot_list)) {
-		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
+		sup = list_first_entry(&srcu_boot_list, struct srcu_usage,
 				      work.work.entry);
-		list_del_init(&ssp->work.work.entry);
+		list_del_init(&sup->work.work.entry);
 		if (SRCU_SIZING_IS(SRCU_SIZING_INIT) &&
-		    ssp->srcu_sup->srcu_size_state == SRCU_SIZE_SMALL)
-			ssp->srcu_sup->srcu_size_state = SRCU_SIZE_ALLOC;
-		queue_work(rcu_gp_wq, &ssp->work.work);
+		    sup->srcu_size_state == SRCU_SIZE_SMALL)
+			sup->srcu_size_state = SRCU_SIZE_ALLOC;
+		queue_work(rcu_gp_wq, &sup->work.work);
 	}
 }
 
-- 
2.40.0.rc2

