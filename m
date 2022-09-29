Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258E35EFCAE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbiI2SH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbiI2SHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:07:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BC81BEA42;
        Thu, 29 Sep 2022 11:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B37BB82617;
        Thu, 29 Sep 2022 18:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FCAC433D6;
        Thu, 29 Sep 2022 18:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664474853;
        bh=COTwp+YNWkYNcuFXEJn0ESb5JtmT8hmvHQ9dNRYWXy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4zI8lLkCZY+bqTGbVSq+nYZRmJ42nmS1K2YiXlq8uJXwLk3FvDfWqgdhkmpmY9s8
         1a9oGJm45Y55f0U9i6PXkoxGCqhpkc6Oj7A6B8cKxxb+s4Zh3EX90usGJo9j3Fs55D
         Scu9I24rsjV2CmWdBvFw4NKuU9WFySPBLmm+YiME/AdKk1dYzCeTVE6TdvPt/GgtVy
         B7PKp/0rqxywlJO4sgqLYKFerMtHjHQK4xtTqyHW8F6hOTPSLElkwhaNs8RD5qFNmk
         myJqEhNuMitCt8Pl82eCzXfkDEJIqK6fVevoJ8CMtRc943OJiOSR6+SN7KnskFceH4
         +X46rjFpmTujw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A953D5C0691; Thu, 29 Sep 2022 11:07:32 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH RFC v2 rcu 1/8] srcu: Convert ->srcu_lock_count and ->srcu_unlock_count to atomic
Date:   Thu, 29 Sep 2022 11:07:24 -0700
Message-Id: <20220929180731.2875722-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

