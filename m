Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3AF6C1C25
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjCTQlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjCTQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE51315C8F;
        Mon, 20 Mar 2023 09:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0E8E616D4;
        Mon, 20 Mar 2023 16:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203CDC4339E;
        Mon, 20 Mar 2023 16:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679330131;
        bh=RP22Xwt/Frb4zh2FwdW1ZmTjeCQ1cIWoHCq2ZxemqzM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=le/gMaeIpH/u8qk0+EcETSbLjXH0BIOemYIKihw+rUm8eb9Hd2xqWzTgktqb9K/zS
         6UN9zAb2jSZEU9dQB9hqyLTdNndznLH+7xQfEB3qYmN3NESvLR69HHZNfDmbIFU24g
         Gz5FLYNk8RckXvx4PyNUjNagIa7tZkFOK+VJXkqyXFygGtVjfe2FseYBjTR/CBWr1z
         roXRrEEOHHFqRRix9d0FC4iPXZeQBFTbgTh5wv8108LvF/fuvW17fkohvSY/w+J1cY
         1NYryNtGbPlKq/2b7kDXeah32MOWvwgxQATfV9+qLI5uSm6HgBb6RsHE0Nqo7u9MEB
         JYB0wkludtjTQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8BEA51540395; Mon, 20 Mar 2023 09:35:30 -0700 (PDT)
Date:   Mon, 20 Mar 2023 09:35:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Fix srcu structure's->srcu_sup memory leak in
 init_srcu_struct_fields()
Message-ID: <fac310a2-c42f-4a1a-967c-667c210dd062@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230320055751.4120251-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230320055751.4120251-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:57:51PM +0800, Zqiang wrote:
> When use init_srcu_struct() to initializing srcu structure, and
> will allocate memory for srcu structure's->sda and ->srcu_sup,
> however, if allocate srcu structure's->sda memory failed, the
> srcu structure's->srcu_sup memory need to be released.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good catch, and thank you for reviewing this series!!!

I must fold this change into this commit for bisectability, so please
check the updated original patch shown below.

							Thanx, Paul

------------------------------------------------------------------------

commit 0eaf7510703ec0c9fa148bfb6d371ef60f93f44e
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Mar 16 17:58:51 2023 -0700

    srcu: Begin offloading srcu_struct fields to srcu_update
    
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
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
    Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
    Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>

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
index 428480152375..2689e64024bb 100644
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
 
 // Values for size state variable (->srcu_size_state).  Once the state
@@ -121,24 +128,24 @@ struct srcu_struct {
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
@@ -160,15 +167,17 @@ struct srcu_struct {
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
index 1df9e62a9459..02293a202323 100644
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
 
