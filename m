Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B366C270D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCUBLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjCUBLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F48536455;
        Mon, 20 Mar 2023 18:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFE06618FA;
        Tue, 21 Mar 2023 01:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E99C433A0;
        Tue, 21 Mar 2023 01:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360903;
        bh=3UMDmzecbQnMS3HKOBjegoopX/Bv/UkwzjwMIKGA+oA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pED5iexpHrvAw9Q+86ZMBeDuE8SYy7/aLrqJW0P+Fy7cC46E81znWiiO2nRPktYxg
         FzDE6D940PD95SzupBwE8kSIyphHBAyUfbN14nTA6IxT8h+O3lr2SPHCLILQLQjg8/
         0x+dS+zw+gYiqP2JmGyxWEug33j+8CX/tNpKKe3+YqOoIvhYrXbC3ZqXZ7Lgp9kZH5
         jE6W5P0veqTKQPlK9QFbkyOumw6z54lpuB18SgxkMKwXIoZML4qHW6/eX+1U4REQmr
         1raCGRacrswtxGCuQazwCJ+S1wpq6cnvbsnr93N/XjXw9QcXnytZpUjG4SA6NyYVWW
         h3eKNAz/2OgmA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B9DF2154039D; Mon, 20 Mar 2023 18:08:22 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH locktorture 5/5] locktorture: Add raw_spinlock* torture tests for PREEMPT_RT kernels
Date:   Mon, 20 Mar 2023 18:08:21 -0700
Message-Id: <20230321010821.51601-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3679d2b2-bdb9-4fa3-8134-240a8d0f449b@paulmck-laptop>
References: <3679d2b2-bdb9-4fa3-8134-240a8d0f449b@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

In PREEMPT_RT kernels, both spin_lock() and spin_lock_irq() are converted
to sleepable rt_spin_lock().  This means that the interrupt related
suffixes for spin_lock/unlock(_irq, irqsave/irqrestore) do not affect
the CPU's interrupt state. This commit therefore adds raw spin-lock
torture tests.  This in turn permits pure spin locks to be tested in
PREEMPT_RT kernels.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 56 +++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 9425aff08936..153ddc4c47ef 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -55,7 +55,7 @@ torture_param(int, nested_locks, 0, "Number of nested locks (max = 8)");
 /* Going much higher trips "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!" errors */
 #define MAX_NESTED_LOCKS 8
 
-static char *torture_type = "spin_lock";
+static char *torture_type = IS_ENABLED(CONFIG_PREEMPT_RT) ? "raw_spin_lock" : "spin_lock";
 module_param(torture_type, charp, 0444);
 MODULE_PARM_DESC(torture_type,
 		 "Type of lock to torture (spin_lock, spin_lock_irq, mutex_lock, ...)");
@@ -257,6 +257,59 @@ static struct lock_torture_ops spin_lock_irq_ops = {
 	.name		= "spin_lock_irq"
 };
 
+static DEFINE_RAW_SPINLOCK(torture_raw_spinlock);
+
+static int torture_raw_spin_lock_write_lock(int tid __maybe_unused)
+__acquires(torture_raw_spinlock)
+{
+	raw_spin_lock(&torture_raw_spinlock);
+	return 0;
+}
+
+static void torture_raw_spin_lock_write_unlock(int tid __maybe_unused)
+__releases(torture_raw_spinlock)
+{
+	raw_spin_unlock(&torture_raw_spinlock);
+}
+
+static struct lock_torture_ops raw_spin_lock_ops = {
+	.writelock	= torture_raw_spin_lock_write_lock,
+	.write_delay	= torture_spin_lock_write_delay,
+	.task_boost	= torture_rt_boost,
+	.writeunlock	= torture_raw_spin_lock_write_unlock,
+	.readlock	= NULL,
+	.read_delay	= NULL,
+	.readunlock	= NULL,
+	.name		= "raw_spin_lock"
+};
+
+static int torture_raw_spin_lock_write_lock_irq(int tid __maybe_unused)
+__acquires(torture_raw_spinlock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&torture_raw_spinlock, flags);
+	cxt.cur_ops->flags = flags;
+	return 0;
+}
+
+static void torture_raw_spin_lock_write_unlock_irq(int tid __maybe_unused)
+__releases(torture_raw_spinlock)
+{
+	raw_spin_unlock_irqrestore(&torture_raw_spinlock, cxt.cur_ops->flags);
+}
+
+static struct lock_torture_ops raw_spin_lock_irq_ops = {
+	.writelock	= torture_raw_spin_lock_write_lock_irq,
+	.write_delay	= torture_spin_lock_write_delay,
+	.task_boost	= torture_rt_boost,
+	.writeunlock	= torture_raw_spin_lock_write_unlock_irq,
+	.readlock	= NULL,
+	.read_delay	= NULL,
+	.readunlock	= NULL,
+	.name		= "raw_spin_lock_irq"
+};
+
 static DEFINE_RWLOCK(torture_rwlock);
 
 static int torture_rwlock_write_lock(int tid __maybe_unused)
@@ -1017,6 +1070,7 @@ static int __init lock_torture_init(void)
 	static struct lock_torture_ops *torture_ops[] = {
 		&lock_busted_ops,
 		&spin_lock_ops, &spin_lock_irq_ops,
+		&raw_spin_lock_ops, &raw_spin_lock_irq_ops,
 		&rw_lock_ops, &rw_lock_irq_ops,
 		&mutex_lock_ops,
 		&ww_mutex_lock_ops,
-- 
2.40.0.rc2

