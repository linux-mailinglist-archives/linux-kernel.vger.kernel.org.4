Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EE2641333
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 03:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiLCCTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 21:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiLCCTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 21:19:21 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE2C98E9F;
        Fri,  2 Dec 2022 18:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670033960; x=1701569960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6ntn3zRMxIwgdUpPp1JYwUPfmJv8sbId8mHHuUAb1xg=;
  b=UaHz6/XjMZ2h4wT6xpEZ2TP+DdzCu42RzcWmv757r3zARxZ/K5+yc6dc
   tNxAZw/XUtHstrQi0Xlu2bxX590yvT3VKuqZhkxpt5lnGEZN8Mb2JzwDW
   Li1p2oOKq6KNhdaIQ6kMwiZttYCBxlhtlcj9lIXOp5o/66+lpcp4zS0KT
   FZdZkmYd0iPKOng9oS+cDaePKRR1v/a9wLxW0d28EPdpkry9xgJPC+R+E
   t1rjVlP9qkdYbLpE3mm3KbSlLb88lK+Dy4/mG/K2qO2GwxUHnQyp8o2g2
   rxubZBi2YEeoIbxncWyRYz/GZGZAKlka/uNd+gByBlGNQeSSaj667sUnd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="378238268"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="378238268"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 18:19:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="713829673"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="713829673"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 18:19:17 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu-tasks: Make shrink down to a single callback queue safely
Date:   Sat,  3 Dec 2022 10:25:03 +0800
Message-Id: <20221203022503.2227023-1-qiang1.zhang@intel.com>
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

Assume that the current RCU-task belongs to per-CPU callback queuing
mode. the 'rcu_task_cb_adjust' variable is true and the conditions for
converting to a single CPU-0 queue mode have been met.
(ncbsnz == 0 && ncbs < rcu_task_collapse_lim)

	   CPU0                                          CPU1
rcu_tasks_one_gp()
  rcu_tasks_need_gpcb()

                                            invoke call_rcu_tasks_generic()
                                            enqueue callback to CPU1
                                            (CPU1 n_cbs not equal zero)

  if (rcu_task_cb_adjust &&
  ncbs <= rcu_task_collapse_lim)
    if (rtp->percpu_enqueue_lim > 1)
      rtp->percpu_enqueue_lim = 1;
      rtp->percpu_dequeue_gpseq =
      get_state_synchronize_rcu();

  A full RCU grace period has passed
  (it means that poll_state_synchronize_rcu
  rtp->percpu_dequeue_gpseq) maybe return true)

  if (rcu_task_cb_adjust && !ncbsnz &&
  poll_state_synchronize_rcu(
    rtp->percpu_dequeue_gpseq) {

    if (rtp->percpu_enqueue_lim <
        rtp->percpu_dequeue_lim)
        rtp->percpu_dequeue_lim = 1
    for (cpu = rtp->percpu_dequeue_lim;
        cpu < nr_cpu_ids; cpu++)
        find CPU1 n_cbs is not zero
        trigger warning
  }

The above scenario will not only trigger WARN_ONCE(), but also set the
rcu_tasks structure's->percpu_dequeue_lim is one when CPU1 still have
callbacks, which will cause the callback of CPU1 to have no chance to
be called.

This commit put get_state_synchronize_rcu() and poll_state_synchronize_rcu()
into a RCU read critical section. it means that current readers will block
completion of the current or next RCU grace period. this ensures that after
we snapshot current RCU gp number and then polling it will return false.

This will lead us to judge per-CPU callback numbers again after a grace
period of RCU tasks, until the callbacks of other CPUs(except CPU0) are
executed and the specified RCU grace period has completed, we have just
completed the conversion of single queue.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d845723c1af4..26f67d8220ec 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -419,6 +419,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	// if there has not been an increase in callbacks, limit dequeuing
 	// to CPU 0.  Note the matching RCU read-side critical section in
 	// call_rcu_tasks_generic().
+	rcu_read_lock();
 	if (rcu_task_cb_adjust && ncbs <= rcu_task_collapse_lim) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim > 1) {
@@ -443,6 +444,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
+	rcu_read_unlock();
 
 	return needgpcb;
 }
-- 
2.25.1

