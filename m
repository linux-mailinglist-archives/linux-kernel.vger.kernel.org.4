Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCA86A043B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjBWIw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjBWIwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:52:54 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED216468A;
        Thu, 23 Feb 2023 00:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677142373; x=1708678373;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0Ie5tVgztugX8zVKgtvT55Wl799Y51l0mPbQolcRB38=;
  b=mhhOqsLmYIOM4iHwVq2jvyu7kldtcZ31AM22J5fPd9FzsX7aJ4dAw4F/
   5NpEBV2YzrndfFXMmQ+KjDeVJ7Gf4yxYAoz3KFaN5hMKG6+wtOQnxRZuI
   wVlGi1QXyCopb30kKp6n84+FOldj8glwqL/D/WS00jU5l3PmQnABWyYkm
   Fj+f1x4Sx9sfhDciBamII9WQr82pby+kexzu3yeUtKvnLhp0dxzE3gz16
   3pfIhxrPGZRnskGEpEf2shTcTIKBJk18UDjAm1Y0cVbFEGWptUPIfGnNB
   Vp/vUTESOBZhDCdhfFLLb7zoGIfhMnrtD+3n44v+ElqrbpNuhHTrhRzZO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="335359285"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="335359285"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 00:52:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="846478575"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="846478575"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 00:52:46 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu-tasks: Directly invoke rcuwait_wake_up() in call_rcu_tasks_generic()
Date:   Thu, 23 Feb 2023 16:57:39 +0800
Message-Id: <20230223085739.2594570-1-qiang1.zhang@intel.com>
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
call_rcu_tasks_generic() holds a raw-spinlock, when the kernel is
built with CONFIG_PROVE_RAW_LOCK_NESTING=y, due to a spinlock will
be hold in wake_up(), so the lockdep splats will happen. but now
using rcuwait_wake_up() to wakeup grace-period kthread instead of
wake_up(), in rcuwait_wake_up() using raw-spinlock instead of spinlock,
so this commit remove using irq_work_queue(), invoke rcuwait_wake_up()
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

