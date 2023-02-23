Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E686A02C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjBWGZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjBWGZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:25:34 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2703803F;
        Wed, 22 Feb 2023 22:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677133533; x=1708669533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TgLi49IW34LbRGQNmGM2xD5vJvj6jAn4cnTtBB1bWqc=;
  b=H07Fn3K9MmxNGHH7M/vAf5OwnxKIhST66ntVEM41Co1sOUgiCHB1r4cc
   HNldFR26hGJwbH1vXo6ZWvXeNNnqM+/uSP/hd/+/wmmyDw6qKpKP+qJCv
   N7rokFfwA4Pq9VFJ+7UkoS6+Eglh5j8t77YSdW0eXRwriFeeExhfGK8QU
   TyNa2SIxg4ZqVdUfpffG5utgMrO2QwKAAWKXh9exUbg58JKizMq3rTn2R
   SlS/zUeJNFE3P8n19eHyio3CpcGA7hsjlBokWzq66EL3RYwuFR2SVbb4a
   d1K5xxxuGwMZSBG0EcoYjq/d9LLhDMgc7kc5LfozyhbcF+oO+kC0FDjlM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="335331921"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="335331921"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 22:25:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="741144252"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="741144252"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 22:25:29 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in call_rcu_tasks_generic()
Date:   Thu, 23 Feb 2023 14:30:22 +0800
Message-Id: <20230223063022.2592212-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to commit '3063b33a347c ("Avoid raw-spinlocked wakeups
from call_rcu_tasks_generic()")', the grace-period kthread is delayed
to wakeup using irq_work_queue() is because if the caller of
call_rcu_tasks_generic() holds a raw spinlock, when the kernel is
built with CONFIG_PROVE_RAW_LOCK_NESTING=y, due to a spinlock will
be hold in wake_up(), so the lockdep splats will happen. but now
using rcuwait_wake_up() to wakeup grace-period kthread instead of
wake_up(), in rcuwait_wake_up() no spinlock will be acquired, so
this commit remove using irq_work_queue(), invoke rcuwait_wake_up()
directly in call_rcu_tasks_generic().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index baf7ec178155..757b8c6da1ad 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -39,7 +39,6 @@ struct rcu_tasks_percpu {
 	unsigned long rtp_jiffies;
 	unsigned long rtp_n_lock_retries;
 	struct work_struct rtp_work;
-	struct irq_work rtp_irq_work;
 	struct rcu_head barrier_q_head;
 	struct list_head rtp_blkd_tasks;
 	int cpu;
@@ -112,12 +111,9 @@ struct rcu_tasks {
 	char *kname;
 };
 
-static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
-
 #define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
 static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
 	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
-	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),			\
 };											\
 static struct rcu_tasks rt_name =							\
 {											\
@@ -273,16 +269,6 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
 }
 
-// IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
-static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
-{
-	struct rcu_tasks *rtp;
-	struct rcu_tasks_percpu *rtpcp = container_of(iwp, struct rcu_tasks_percpu, rtp_irq_work);
-
-	rtp = rtpcp->rtpp;
-	rcuwait_wake_up(&rtp->cbs_wait);
-}
-
 // Enqueue a callback for the specified flavor of Tasks RCU.
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
@@ -334,7 +320,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	rcu_read_unlock();
 	/* We can't create the thread unless interrupts are enabled. */
 	if (needwake && READ_ONCE(rtp->kthread_ptr))
-		irq_work_queue(&rtpcp->rtp_irq_work);
+		rcuwait_wake_up(&rtp->cbs_wait);
 }
 
 // RCU callback function for rcu_barrier_tasks_generic().
-- 
2.25.1

