Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DE96A148C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBXBPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 20:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBXBPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:15:46 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F6B77B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677201346; x=1708737346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QsfdgQZvsGRE9SouMzIYaJNkdCg1AcGM3tcRVJFSpJY=;
  b=YCGSkWI9oNmMpR4bdjpPCmwg02eGpm0euVTEQDcZsvttEyLsYZJjs+7U
   OqAROhgDX45f+KaQ5DkDVx8LnjBpkVqIFeu2q1EG2YAMvy8T33oJqFn0P
   jZdwsRZBj4fKqgIStLLntPTaR/IbywE3Vvkak7psySCqhA3AZPVPow8j7
   w8JFSbw53Vmu0mrgaRYVYTXLNH92W89ku4P+nTcqPQ+LomVlm8uM5E3wk
   98B1sZ+Z08ZrWw5Afn7xj5GATBPIdBaNL3mOLRbPOwZnYx+AkVhZyv/7k
   Ak0921b9e6enZvfstFlgsNajNUEPa97sQr2KpTEKlSi56vALoz0l28y0h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="334789427"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="334789427"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 17:15:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="665998365"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="665998365"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 17:15:43 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     dave@stgolabs.net, paulmck@kernel.org, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org, qiang1.zhang@intel.com
Subject: [PATCH v2] locktorture: Add raw_spinlock* torture tests for PREEMPT_RT kernels
Date:   Fri, 24 Feb 2023 09:20:35 +0800
Message-Id: <20230224012035.2693610-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In PREEMPT_RT kernels, both spin_lock() and spin_lock_irq() are converted
to sleepable rt_spin_lock().  This means that the interrupt related suffix
for spin_lock/unlock(_irq, irqsave/irqrestore) do not affect the CPU's
interrupt state. This commit therefore adds raw spin-lock torture tests.
This in turn permits pure spin locks to be tested in PREEMPT_RT kernels.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
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
2.25.1

