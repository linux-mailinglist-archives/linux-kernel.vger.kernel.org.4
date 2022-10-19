Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BA1605388
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiJSW6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiJSW6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:58:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D8A1CBA94;
        Wed, 19 Oct 2022 15:58:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9195D61920;
        Wed, 19 Oct 2022 22:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA56CC433C1;
        Wed, 19 Oct 2022 22:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220328;
        bh=lC2ZhkuunFA2ksKMDckPtMceJ6zVcRmtLkRgyIgtcls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cnfRlwEud8zypsIPnkwkCkn4HzzhbvLYXCgPFisO8zPb3C9evnYf+kZ3SQCxwnJHu
         5R9xpAjW3LITHmqT4vuhUGiA6f3pnLgLI1uyh2NP3h/sgiOfkqgUUb+PO5BAhzptBn
         dgGpyTdlk4eBWNcDLem7An8S6TbmugUekGrA3uLk1rv/K6gNaoJ416WnYw19pRhroW
         7rXKmCMtL/u2/czbqQraIF1CRXk/WWpE2VQqm3SVOyUOt393LxO9arF800iV3GXnmN
         jEEvmzO5mbnEppwdS85MqBgABaBfTg783962fITifkN43P+5H2drvNoQk4319L54O+
         oGF8SQRQ88njA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AA4CD5C06B4; Wed, 19 Oct 2022 15:58:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 rcu 01/11] srcu: Convert ->srcu_lock_count and ->srcu_unlock_count to atomic
Date:   Wed, 19 Oct 2022 15:58:36 -0700
Message-Id: <20221019225846.2501109-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
References: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NMI-safe variants of srcu_read_lock() and srcu_read_unlock() are needed
by printk(), which on many architectures entails read-modify-write
atomic operations.  This commit prepares Tree SRCU for this change by
making both ->srcu_lock_count and ->srcu_unlock_count by atomic_long_t.

[ paulmck: Apply feedback from John Ogness. ]

Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
---
 include/linux/srcutree.h |  4 ++--
 kernel/rcu/srcutree.c    | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index e3014319d1ade..0c4eca07d78d5 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -23,8 +23,8 @@ struct srcu_struct;
  */
 struct srcu_data {
 	/* Read-side state. */
-	unsigned long srcu_lock_count[2];	/* Locks per CPU. */
-	unsigned long srcu_unlock_count[2];	/* Unlocks per CPU. */
+	atomic_long_t srcu_lock_count[2];	/* Locks per CPU. */
+	atomic_long_t srcu_unlock_count[2];	/* Unlocks per CPU. */
 
 	/* Update-side state. */
 	spinlock_t __private lock ____cacheline_internodealigned_in_smp;
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c02..25e9458da6a26 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -417,7 +417,7 @@ static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += READ_ONCE(cpuc->srcu_lock_count[idx]);
+		sum += atomic_long_read(&cpuc->srcu_lock_count[idx]);
 	}
 	return sum;
 }
@@ -434,7 +434,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += READ_ONCE(cpuc->srcu_unlock_count[idx]);
+		sum += atomic_long_read(&cpuc->srcu_unlock_count[idx]);
 	}
 	return sum;
 }
@@ -503,10 +503,10 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += READ_ONCE(cpuc->srcu_lock_count[0]);
-		sum += READ_ONCE(cpuc->srcu_lock_count[1]);
-		sum -= READ_ONCE(cpuc->srcu_unlock_count[0]);
-		sum -= READ_ONCE(cpuc->srcu_unlock_count[1]);
+		sum += atomic_long_read(&cpuc->srcu_lock_count[0]);
+		sum += atomic_long_read(&cpuc->srcu_lock_count[1]);
+		sum -= atomic_long_read(&cpuc->srcu_unlock_count[0]);
+		sum -= atomic_long_read(&cpuc->srcu_unlock_count[1]);
 	}
 	return sum;
 }
@@ -636,7 +636,7 @@ int __srcu_read_lock(struct srcu_struct *ssp)
 	int idx;
 
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
+	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
 	return idx;
 }
@@ -650,7 +650,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	smp_mb(); /* C */  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_unlock_count[idx]);
+	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
@@ -1687,8 +1687,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 			struct srcu_data *sdp;
 
 			sdp = per_cpu_ptr(ssp->sda, cpu);
-			u0 = data_race(sdp->srcu_unlock_count[!idx]);
-			u1 = data_race(sdp->srcu_unlock_count[idx]);
+			u0 = data_race(atomic_long_read(&sdp->srcu_unlock_count[!idx]));
+			u1 = data_race(atomic_long_read(&sdp->srcu_unlock_count[idx]));
 
 			/*
 			 * Make sure that a lock is always counted if the corresponding
@@ -1696,8 +1696,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 			 */
 			smp_rmb();
 
-			l0 = data_race(sdp->srcu_lock_count[!idx]);
-			l1 = data_race(sdp->srcu_lock_count[idx]);
+			l0 = data_race(atomic_long_read(&sdp->srcu_lock_count[!idx]));
+			l1 = data_race(atomic_long_read(&sdp->srcu_lock_count[idx]));
 
 			c0 = l0 - u0;
 			c1 = l1 - u1;
-- 
2.31.1.189.g2e36527f23

