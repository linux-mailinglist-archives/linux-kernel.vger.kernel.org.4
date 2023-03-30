Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E966D1280
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjC3WsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjC3Wrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:47:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC041204E;
        Thu, 30 Mar 2023 15:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B8DF621D5;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DF5C4339B;
        Thu, 30 Mar 2023 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216448;
        bh=GXD9GdY8v3RIh7U3GnYda6kTJ4k3Fbay0wPf8sbul44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYu6zzK4uYWEr++FJTeAbZu8VihfPXtIwVPZT5hBLXmEM9za5DTsHAHQhiNbBmMj9
         L3fbdQ9jOu0yHiKVv+41VBbUKiLvsQludNOsrA//E98fsUrVXp2RIMbiQ6FLRI+ZaH
         EztDJm+zyYozrYWwqA/rP2YHK9JlofEbIwLrAKxOF+mL45+UZCT4qoZv6ba3FeI1QO
         JEfnI65bUm5/dxd+JVgnp5MlVJUB3gMC/eUo8L2F1RJ+oCZDOE0QQlu/tQ4bJGGv1d
         4qR8SFwFXUeSZx+47sZQilv0AOfKWMTCZZQwD9xU/Fi0LhBwlJn64JAolAFiOOXUDr
         fjMGKWq3BTvAA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0455D154047F; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 03/20] srcu: Use static init for statically allocated in-module srcu_struct
Date:   Thu, 30 Mar 2023 15:47:09 -0700
Message-Id: <20230330224726.662344-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

Cc: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 19 ++++++++++++++-----
 kernel/rcu/srcutree.c    | 19 +++++++++++++------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 488d0e5d1ba3..3ce6deee1dbe 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -108,15 +108,24 @@ struct srcu_struct {
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
@@ -138,7 +147,7 @@ struct srcu_struct {
  */
 #ifdef MODULE
 # define __DEFINE_SRCU(name, is_static)								\
-	is_static struct srcu_struct name;							\
+	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name);			\
 	extern struct srcu_struct * const __srcu_struct_##name;					\
 	struct srcu_struct * const __srcu_struct_##name						\
 		__section("___srcu_struct_ptrs") = &name
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ab4ee58af84b..7e6e7dfb1a87 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1873,13 +1873,14 @@ void __init srcu_init(void)
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
@@ -1888,10 +1889,16 @@ static int srcu_module_coming(struct module *mod)
 static void srcu_module_going(struct module *mod)
 {
 	int i;
+	struct srcu_struct *ssp;
 	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
 
-	for (i = 0; i < mod->num_srcu_structs; i++)
-		cleanup_srcu_struct(*(sspp++));
+	for (i = 0; i < mod->num_srcu_structs; i++) {
+		ssp = *(sspp++);
+		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_gp_seq_needed)) &&
+		    !WARN_ON_ONCE(!ssp->sda_is_static))
+			cleanup_srcu_struct(ssp);
+		free_percpu(ssp->sda);
+	}
 }
 
 /* Handle one module, either coming or going. */
-- 
2.40.0.rc2

