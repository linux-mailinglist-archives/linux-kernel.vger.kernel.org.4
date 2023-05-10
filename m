Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F7B6FE2F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjEJRDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbjEJRDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:03:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E32340DC;
        Wed, 10 May 2023 10:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 328FA63F42;
        Wed, 10 May 2023 17:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B8CC433EF;
        Wed, 10 May 2023 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738163;
        bh=VXlyCdDwVi1FMedvB2vqwj5QtYQEukG0P+JwjZR1bkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yr24vjNQzy6y8a/ZgmUM5NN3QAqR/LXTihrlNgOixMFI6pRC8zy4Ek2uH7mOqBefT
         8isdsQBXjpBZKQqsCIpG0ZTAXSLWhqJrqtQc9lZCerlA1kwklNQdqEmc7sE9AZ/ADy
         goPpxzLUwrVs/O/lDrKh2hb3XAgJvJGUcuHGHQoF8c+buS99nR++ztzVGEn7rDFbsa
         icxbWRTxlcCrgCca7jMC+zJ2c6SD7oh4t0IM+gLeASifW4MXkQomuBNN4qNGwk0cOk
         exusTeFR3M+Hzd627FgujhUZm+HtlE0I/bGytX+7QynTNZVakgEpGw7NK8M4vOQVkO
         FuzP2oPzcTV4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4C16ECE126E; Wed, 10 May 2023 10:02:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH rcu 1/8] rcu/kvfree: Eliminate k[v]free_rcu() single argument macro
Date:   Wed, 10 May 2023 10:02:35 -0700
Message-Id: <20230510170242.2187714-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
References: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
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

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kvfree_rcu() and kfree_rcu() APIs are hazardous in that if you forget
the second argument, it works, but might sleep.  This sleeping can be a
correctness bug from atomic contexts, and even in non-atomic contexts it
might introduce unacceptable latencies.  This commit therefore removes the
single-argument kvfree_rcu() and kfree_rcu() macros.  Code that would have
previously used these single-argument kvfree_rcu() and kfree_rcu() macros
should instead use kvfree_rcu_mightsleep() or kfree_rcu_mightsleep().

[ paulmck: Apply Joel Fernandes feedback. ]

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate.h | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index dcd2cf1e8326..744869ef930a 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -957,9 +957,8 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /**
  * kfree_rcu() - kfree an object after a grace period.
- * @ptr: pointer to kfree for both single- and double-argument invocations.
- * @rhf: the name of the struct rcu_head within the type of @ptr,
- *       but only for double-argument invocations.
+ * @ptr: pointer to kfree for double-argument invocations.
+ * @rhf: the name of the struct rcu_head within the type of @ptr.
  *
  * Many rcu callbacks functions just call kfree() on the base structure.
  * These functions are trivial, but their size adds up, and furthermore
@@ -984,26 +983,18 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * The BUILD_BUG_ON check must not involve any function calls, hence the
  * checks are done in macros here.
  */
-#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
+#define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
+#define kvfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
 
 /**
- * kvfree_rcu() - kvfree an object after a grace period.
- *
- * This macro consists of one or two arguments and it is
- * based on whether an object is head-less or not. If it
- * has a head then a semantic stays the same as it used
- * to be before:
- *
- *     kvfree_rcu(ptr, rhf);
- *
- * where @ptr is a pointer to kvfree(), @rhf is the name
- * of the rcu_head structure within the type of @ptr.
+ * kfree_rcu_mightsleep() - kfree an object after a grace period.
+ * @ptr: pointer to kfree for single-argument invocations.
  *
  * When it comes to head-less variant, only one argument
  * is passed and that is just a pointer which has to be
  * freed after a grace period. Therefore the semantic is
  *
- *     kvfree_rcu(ptr);
+ *     kfree_rcu_mightsleep(ptr);
  *
  * where @ptr is the pointer to be freed by kvfree().
  *
@@ -1012,13 +1003,9 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * annotation. Otherwise, please switch and embed the
  * rcu_head structure within the type of @ptr.
  */
-#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,		\
-	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
-
+#define kfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
 #define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
-#define kfree_rcu_mightsleep(ptr) kvfree_rcu_mightsleep(ptr)
 
-#define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
 #define kvfree_rcu_arg_2(ptr, rhf)					\
 do {									\
 	typeof (ptr) ___p = (ptr);					\
-- 
2.40.1

