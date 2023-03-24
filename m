Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EC56C7471
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCXAT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCXATq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA8E2DE4A;
        Thu, 23 Mar 2023 17:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9660D62920;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9A0C433D2;
        Fri, 24 Mar 2023 00:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617181;
        bh=NfvU5usTkW6B5h8S2WMilLDlOwDmJEkpL6G4bgxR4N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nP3/V17kUQWQO1UOGwccGf/h74BiIzZMw0wXVLx8lRLykGQ2lnft1/BUCKGbJ/HlR
         mBKW5xOJ3+Cca3vQMBS3TtZQ7ePFFNIFk+HKoH/DYvX2QdI1hSUqraHM7DRfET66r3
         c+AdrN8d/V8b3kqwfyYeOJL93sqrVOFrVLWsag/KHddUMXDTVCYmAhxlYnmKcuAHuy
         m7FzAYmSgBc/TMpq4/2lmMKNI1y4W3Knf6utQvm6RBvZHW073radP024xKkPzHTZKL
         CBReo9bfi1XsuD5DFtXWJ97WAZsYDrlcb/GQ5N80NzoiZtxzPqgu/rVBuCDPZENwNp
         EqCwPeMoDziGQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8B7841540338; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 02/19] srcu: Use static init for statically allocated in-module srcu_struct
Date:   Thu, 23 Mar 2023 17:19:21 -0700
Message-Id: <20230324001938.3443499-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
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

Further shrinking the srcu_struct structure is eased by requiring
that in-module srcu_struct structures rely more heavily on static
initialization.  In particular, this preserves the property that
a module-load-time srcu_struct initialization can fail only due
to memory-allocation failure of the per-CPU srcu_data structures.
It might also slightly improve robustness by keeping the number of memory
allocations that must succeed down percpu_alloc() call.

This is in preparation for splitting an srcu_usage structure out
of the srcu_struct structure.

[ paulmck: Fold in qiang1.zhang@intel.com feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 include/linux/srcutree.h | 19 ++++++++++++++-----
 kernel/rcu/srcutree.c    | 19 +++++++++++++------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index ac8af12f93b3..428480152375 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -121,15 +121,24 @@ struct srcu_struct {
 #define SRCU_STATE_SCAN1	1
 #define SRCU_STATE_SCAN2	2
 
-#define __SRCU_STRUCT_INIT(name, pcpu_name)							\
-{												\
-	.sda = &pcpu_name,									\
+#define __SRCU_STRUCT_INIT_COMMON(name)								\
 	.lock = __SPIN_LOCK_UNLOCKED(name.lock),						\
 	.srcu_gp_seq_needed = -1UL,								\
 	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
-	__SRCU_DEP_MAP_INIT(name)								\
+	__SRCU_DEP_MAP_INIT(name)
+
+#define __SRCU_STRUCT_INIT_MODULE(name)								\
+{												\
+	__SRCU_STRUCT_INIT_COMMON(name)								\
 }
 
+#define __SRCU_STRUCT_INIT(name, pcpu_name)							\
+{												\
+	.sda = &pcpu_name,									\
+	__SRCU_STRUCT_INIT_COMMON(name)								\
+}
+
+
 /*
  * Define and initialize a srcu struct at build time.
  * Do -not- call init_srcu_struct() nor cleanup_srcu_struct() on it.
@@ -151,7 +160,7 @@ struct srcu_struct {
  */
 #ifdef MODULE
 # define __DEFINE_SRCU(name, is_static)								\
-	is_static struct srcu_struct name;							\
+	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name);			\
 	extern struct srcu_struct * const __srcu_struct_##name;					\
 	struct srcu_struct * const __srcu_struct_##name						\
 		__section("___srcu_struct_ptrs") = &name
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index cd46fe063e50..7a6d9452a5d0 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1895,13 +1895,14 @@ void __init srcu_init(void)
 static int srcu_module_coming(struct module *mod)
 {
 	int i;
+	struct srcu_struct *ssp;
 	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
-	int ret;
 
 	for (i = 0; i < mod->num_srcu_structs; i++) {
-		ret = init_srcu_struct(*(sspp++));
-		if (WARN_ON_ONCE(ret))
-			return ret;
+		ssp = *(sspp++);
+		ssp->sda = alloc_percpu(struct srcu_data);
+		if (WARN_ON_ONCE(!ssp->sda))
+			return -ENOMEM;
 	}
 	return 0;
 }
@@ -1910,10 +1911,16 @@ static int srcu_module_coming(struct module *mod)
 static void srcu_module_going(struct module *mod)
 {
 	int i;
+	struct srcu_struct *ssp;
 	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
 
-	for (i = 0; i < mod->num_srcu_structs; i++)
-		cleanup_srcu_struct(*(sspp++));
+	for (i = 0; i < mod->num_srcu_structs; i++) {
+		ssp = *(sspp++);
+		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
+		    !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
+				cleanup_srcu_struct(ssp);
+		free_percpu(ssp->sda);
+	}
 }
 
 /* Handle one module, either coming or going. */
-- 
2.40.0.rc2

