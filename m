Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED3C5C003D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiIUOqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIUOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:46:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E2477EBE;
        Wed, 21 Sep 2022 07:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CD31B81F94;
        Wed, 21 Sep 2022 14:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C137CC433D6;
        Wed, 21 Sep 2022 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663771600;
        bh=COTwp+YNWkYNcuFXEJn0ESb5JtmT8hmvHQ9dNRYWXy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZIBmMqgmwkUpaCp4elrrrXwJWKSmcf7lVESmTr2Lqp1JYrB4KJ2JcAdkmCuf+C1o
         m0PKbsJNTGBzyxNnyVqJvkcKDRITlEAEd2525z3mJ4F1Z4Maeej6uu1OchrpSsr9qE
         mx99srCFuS2lpM+IVxkswwPiLEHDk2Aw+jfiV0hhV7/k4Me9Q+viuszR+XLLHMSnZ3
         EYQJ0EKFKfdHXenPfOWCxg2ZOuzQwuC+NwbiSFP0pJNMWuer2S4C3C/50mz/oG3kqf
         Y8s/k53V21i97nDEk/IAgH/YkjddYMrN2RsEnITsMfqX8m/9zcu9RRqHvYt1rPY03N
         BzvEyp7alHI1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 771F55C0849; Wed, 21 Sep 2022 07:46:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH RFC rcu 1/4] srcu: Convert ->srcu_lock_count and ->srcu_unlock_count to atomic
Date:   Wed, 21 Sep 2022 07:46:35 -0700
Message-Id: <20220921144638.1201361-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
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

NMI-safe variants of srcu_read_lock() and srcu_read_unlock() are needed
by printk(), which on many architectures entails read-modify-write
atomic operations.  This commit prepares Tree SRCU for this change by
making both ->srcu_lock_count and ->srcu_unlock_count by atomic_long_t.

Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
---
 include/linux/srcutree.h |  4 ++--
 kernel/rcu/srcutree.c    | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index e3014319d1ad..0c4eca07d78d 100644
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
index 1c304fec89c0..6fd0665f4d1f 100644
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
+			u0 = data_race(sdp->srcu_unlock_count[!idx].counter);
+			u1 = data_race(sdp->srcu_unlock_count[idx].counter);
 
 			/*
 			 * Make sure that a lock is always counted if the corresponding
@@ -1696,8 +1696,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 			 */
 			smp_rmb();
 
-			l0 = data_race(sdp->srcu_lock_count[!idx]);
-			l1 = data_race(sdp->srcu_lock_count[idx]);
+			l0 = data_race(sdp->srcu_lock_count[!idx].counter);
+			l1 = data_race(sdp->srcu_lock_count[idx].counter);
 
 			c0 = l0 - u0;
 			c1 = l1 - u1;
-- 
2.31.1.189.g2e36527f23

