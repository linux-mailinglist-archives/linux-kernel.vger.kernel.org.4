Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896406D1284
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjC3WsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjC3Wry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:47:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9E611679;
        Thu, 30 Mar 2023 15:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD61EB82A63;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFE6C4339E;
        Thu, 30 Mar 2023 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216448;
        bh=baiqNfiKN0xK0xnAMrWYTsGtF5Y9bktVViRp7Wy3+IM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qe1o5fJqFTuNkTZYNW7neS2oN7cqpKc+QhxHtqm+hDE5uO9iJGb5RJ+4Vb8kuA7tU
         SskRaxs1yhTwgq9X/7RR8ugB6SRSE2mb86h7Q7Q1Hr/z2jii81L/bV+ZCq/DyIelmi
         ieEenNQzLOaQFs/nQI1YQAt5tuECO7bOl8PgTtlDG1X++nr4ivdfzkG2/bbfR1baUC
         LPpxh16Gjq+/XtBprHTQAG8FiHejjRFy/rE4axaxnKXdzxUhJTjkM8mgngstI1VDAr
         FS8v2CXgr7UGvSzFnWemT6i7mIz5Eb3BQUMUmc8QoHWvp4CMg4Z2nNwQVC9Et3ck5+
         Xc6GSvNnD8NqA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0A7FD1540480; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 04/20] srcu: Begin offloading srcu_struct fields to srcu_update
Date:   Thu, 30 Mar 2023 15:47:10 -0700
Message-Id: <20230330224726.662344-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current srcu_struct structure is on the order of 200 bytes in size
(depending on architecture and .config), which is much better than the
old-style 26K bytes, but still all too inconvenient when one is trying
to achieve good cache locality on a fastpath involving SRCU readers.

However, only a few fields in srcu_struct are used by SRCU readers.
The remaining fields could be offloaded to a new srcu_update
structure, thus shrinking the srcu_struct structure down to a few
tens of bytes.  This commit begins this noble quest, a quest that is
complicated by open-coded initialization of the srcu_struct within the
srcu_notifier_head structure.  This complication is addressed by updating
the srcu_notifier_head structure's open coding, given that there does
not appear to be a straightforward way of abstracting that initialization.

This commit moves only the ->node pointer to srcu_update.  Later commits
will move additional fields.

[ paulmck: Fold in qiang1.zhang@intel.com's memory-leak fix. ]

Link: https://lore.kernel.org/all/20230320055751.4120251-1-qiang1.zhang@intel.com/
Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/notifier.h |  5 ++++-
 include/linux/srcutiny.h |  6 +++---
 include/linux/srcutree.h | 27 ++++++++++++++++++---------
 kernel/rcu/rcu.h         |  6 ++++--
 kernel/rcu/srcutree.c    | 28 +++++++++++++++++++---------
 5 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index aef88c2d1173..2aba75145144 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -73,6 +73,9 @@ struct raw_notifier_head {
 
 struct srcu_notifier_head {
 	struct mutex mutex;
+#ifdef CONFIG_TREE_SRCU
+	struct srcu_usage srcuu;
+#endif
 	struct srcu_struct srcu;
 	struct notifier_block __rcu *head;
 };
@@ -107,7 +110,7 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 	{							\
 		.mutex = __MUTEX_INITIALIZER(name.mutex),	\
 		.head = NULL,					\
-		.srcu = __SRCU_STRUCT_INIT(name.srcu, pcpu),	\
+		.srcu = __SRCU_STRUCT_INIT(name.srcu, name.srcuu, pcpu), \
 	}
 
 #define ATOMIC_NOTIFIER_HEAD(name)				\
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 5aa5e0faf6a1..ebd72491af99 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -31,7 +31,7 @@ struct srcu_struct {
 
 void srcu_drive_gp(struct work_struct *wp);
 
-#define __SRCU_STRUCT_INIT(name, __ignored)				\
+#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored)			\
 {									\
 	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
 	.srcu_cb_tail = &name.srcu_cb_head,				\
@@ -44,9 +44,9 @@ void srcu_drive_gp(struct work_struct *wp);
  * Tree SRCU, which needs some per-CPU data.
  */
 #define DEFINE_SRCU(name) \
-	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name)
+	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
 #define DEFINE_STATIC_SRCU(name) \
-	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name)
+	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
 
 void synchronize_srcu(struct srcu_struct *ssp);
 
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 3ce6deee1dbe..276f325f1296 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -57,11 +57,17 @@ struct srcu_node {
 	int grphi;				/* Biggest CPU for node. */
 };
 
+/*
+ * Per-SRCU-domain structure, update-side data linked from srcu_struct.
+ */
+struct srcu_usage {
+	struct srcu_node *node;			/* Combining tree. */
+};
+
 /*
  * Per-SRCU-domain structure, similar in function to rcu_state.
  */
 struct srcu_struct {
-	struct srcu_node *node;			/* Combining tree. */
 	struct srcu_node *level[RCU_NUM_LVLS + 1];
 						/* First node at each level. */
 	int srcu_size_state;			/* Small-to-big transition state. */
@@ -90,6 +96,7 @@ struct srcu_struct {
 	unsigned long reschedule_count;
 	struct delayed_work work;
 	struct lockdep_map dep_map;
+	struct srcu_usage *srcu_sup;		/* Update-side data. */
 };
 
 /* Values for size state variable (->srcu_size_state). */
@@ -108,24 +115,24 @@ struct srcu_struct {
 #define SRCU_STATE_SCAN1	1
 #define SRCU_STATE_SCAN2	2
 
-#define __SRCU_STRUCT_INIT_COMMON(name)								\
+#define __SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
 	.lock = __SPIN_LOCK_UNLOCKED(name.lock),						\
 	.srcu_gp_seq_needed = -1UL,								\
 	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
+	.srcu_sup = &usage_name,								\
 	__SRCU_DEP_MAP_INIT(name)
 
-#define __SRCU_STRUCT_INIT_MODULE(name)								\
+#define __SRCU_STRUCT_INIT_MODULE(name, usage_name)						\
 {												\
-	__SRCU_STRUCT_INIT_COMMON(name)								\
+	__SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
 }
 
-#define __SRCU_STRUCT_INIT(name, pcpu_name)							\
+#define __SRCU_STRUCT_INIT(name, usage_name, pcpu_name)						\
 {												\
 	.sda = &pcpu_name,									\
-	__SRCU_STRUCT_INIT_COMMON(name)								\
+	__SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
 }
 
-
 /*
  * Define and initialize a srcu struct at build time.
  * Do -not- call init_srcu_struct() nor cleanup_srcu_struct() on it.
@@ -147,15 +154,17 @@ struct srcu_struct {
  */
 #ifdef MODULE
 # define __DEFINE_SRCU(name, is_static)								\
-	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name);			\
+	static struct srcu_usage name##_srcu_usage;						\
+	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name, name##_srcu_usage);	\
 	extern struct srcu_struct * const __srcu_struct_##name;					\
 	struct srcu_struct * const __srcu_struct_##name						\
 		__section("___srcu_struct_ptrs") = &name
 #else
 # define __DEFINE_SRCU(name, is_static)								\
 	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);				\
+	static struct srcu_usage name##_srcu_usage;						\
 	is_static struct srcu_struct name =							\
-		__SRCU_STRUCT_INIT(name, name##_srcu_data)
+		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data)
 #endif
 #define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
 #define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 115616ac3bfa..8d18d4bf0e29 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -341,11 +341,13 @@ extern void rcu_init_geometry(void);
  * specified state structure (for SRCU) or the only rcu_state structure
  * (for RCU).
  */
-#define srcu_for_each_node_breadth_first(sp, rnp) \
+#define _rcu_for_each_node_breadth_first(sp, rnp) \
 	for ((rnp) = &(sp)->node[0]; \
 	     (rnp) < &(sp)->node[rcu_num_nodes]; (rnp)++)
 #define rcu_for_each_node_breadth_first(rnp) \
-	srcu_for_each_node_breadth_first(&rcu_state, rnp)
+	_rcu_for_each_node_breadth_first(&rcu_state, rnp)
+#define srcu_for_each_node_breadth_first(ssp, rnp) \
+	_rcu_for_each_node_breadth_first(ssp->srcu_sup, rnp)
 
 /*
  * Scan the leaves of the rcu_node hierarchy for the rcu_state structure.
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7e6e7dfb1a87..049e20dbec76 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -173,12 +173,12 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 
 	/* Initialize geometry if it has not already been initialized. */
 	rcu_init_geometry();
-	ssp->node = kcalloc(rcu_num_nodes, sizeof(*ssp->node), gfp_flags);
-	if (!ssp->node)
+	ssp->srcu_sup->node = kcalloc(rcu_num_nodes, sizeof(*ssp->srcu_sup->node), gfp_flags);
+	if (!ssp->srcu_sup->node)
 		return false;
 
 	/* Work out the overall tree geometry. */
-	ssp->level[0] = &ssp->node[0];
+	ssp->level[0] = &ssp->srcu_sup->node[0];
 	for (i = 1; i < rcu_num_lvls; i++)
 		ssp->level[i] = ssp->level[i - 1] + num_rcu_lvl[i - 1];
 	rcu_init_levelspread(levelspread, num_rcu_lvl);
@@ -195,7 +195,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 		snp->srcu_gp_seq_needed_exp = SRCU_SNP_INIT_SEQ;
 		snp->grplo = -1;
 		snp->grphi = -1;
-		if (snp == &ssp->node[0]) {
+		if (snp == &ssp->srcu_sup->node[0]) {
 			/* Root node, special case. */
 			snp->srcu_parent = NULL;
 			continue;
@@ -236,8 +236,12 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
  */
 static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 {
+	if (!is_static)
+		ssp->srcu_sup = kzalloc(sizeof(*ssp->srcu_sup), GFP_KERNEL);
+	if (!ssp->srcu_sup)
+		return -ENOMEM;
 	ssp->srcu_size_state = SRCU_SIZE_SMALL;
-	ssp->node = NULL;
+	ssp->srcu_sup->node = NULL;
 	mutex_init(&ssp->srcu_cb_mutex);
 	mutex_init(&ssp->srcu_gp_mutex);
 	ssp->srcu_idx = 0;
@@ -249,8 +253,11 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->sda_is_static = is_static;
 	if (!is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
-	if (!ssp->sda)
+	if (!ssp->sda) {
+		if (!is_static)
+			kfree(ssp->srcu_sup);
 		return -ENOMEM;
+	}
 	init_srcu_struct_data(ssp);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
@@ -259,6 +266,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 			if (!ssp->sda_is_static) {
 				free_percpu(ssp->sda);
 				ssp->sda = NULL;
+				kfree(ssp->srcu_sup);
 				return -ENOMEM;
 			}
 		} else {
@@ -656,13 +664,15 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 			rcu_seq_current(&ssp->srcu_gp_seq), ssp->srcu_gp_seq_needed);
 		return; /* Caller forgot to stop doing call_srcu()? */
 	}
+	kfree(ssp->srcu_sup->node);
+	ssp->srcu_sup->node = NULL;
+	ssp->srcu_size_state = SRCU_SIZE_SMALL;
 	if (!ssp->sda_is_static) {
 		free_percpu(ssp->sda);
 		ssp->sda = NULL;
+		kfree(ssp->srcu_sup);
+		ssp->srcu_sup = NULL;
 	}
-	kfree(ssp->node);
-	ssp->node = NULL;
-	ssp->srcu_size_state = SRCU_SIZE_SMALL;
 }
 EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
 
-- 
2.40.0.rc2

