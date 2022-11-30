Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EA563CE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiK3FHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiK3FHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:07:08 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5565FBA3;
        Tue, 29 Nov 2022 21:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669784827; x=1701320827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MdcoTele+YCk3gfzp+iczOdXGO9dvaQBIAfyrWo9lRE=;
  b=cZ0H1C7D1o3L/h9+/Wm7Yowz/2Upqa1a15/1d2kSX6ZXIdru2dHEu8/7
   dOu14VIKNdPC9KgxibZid2WBPhiv5EwVf65APg436Q7DbUMEV5QuJ+gxD
   3LkNnu4X8d+5bxdbfWOa8yXZI/aXWb7FhaxumsQW/PgbpWZOVshT1VjdA
   iK0H/vJKzUf1+SXgu2RHAKmAG1X551SU1GV5g21P6+Dw3eG7LbWBHP3o4
   TJbnl2hEPQoJlsMK1sW1gvpGlYxg+3HqBLM/BYPHGbOOL/LLLFyXoarRf
   iYw2q4YP76DYI5qtF5cZ1lZanuM8HKCmhkf87w0gZYVi2/SfWpNkdqOio
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="295000356"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="295000356"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 21:07:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="972959660"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="972959660"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 21:07:05 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Make shrink down to a single callback queue safely
Date:   Wed, 30 Nov 2022 13:12:53 +0800
Message-Id: <20221130051253.1884572-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assume that the current RCU-task belongs to per-CPU callback queuing
mode and the rcu_task_cb_adjust is true.

      CPU0					CPU1

rcu_tasks_need_gpcb()
  ncbsnz == 0 and
  ncbs < rcu_task_collapse_lim

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


  if (rcu_task_cb_adjust && !ncbsnz &&
  poll_state_synchronize_rcu(
    rtp->percpu_dequeue_gpseq) == true
    if (rtp->percpu_enqueue_lim <
	rtp->percpu_dequeue_lim)
        rtp->percpu_dequeue_lim = 1
    for (cpu = rtp->percpu_dequeue_lim;
        cpu < nr_cpu_ids; cpu++)
        find CPU1 n_cbs is not zero
        trigger warning

The above scenario will not only trigger WARN_ONCE(), but also set the
rcu_tasks structure's->percpu_dequeue_lim is one when CPU1 still have
callbacks, which will cause the callback of CPU1 to have no chance to be
called.

This commit add per-cpu callback check(except CPU0) before set the rcu_tasks
structure's->percpu_dequeue_lim to one, if other CPUs(except CPU0) still have
callback, not set the rcu_tasks structure's->percpu_dequeue_lim to one, set it
until the all CPUs(except CPU0) has no callback.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e4f7d08bde64..690af479074f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -433,14 +433,17 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	    poll_state_synchronize_rcu(rtp->percpu_dequeue_gpseq)) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim < rtp->percpu_dequeue_lim) {
+			for (cpu = rtp->percpu_enqueue_lim; cpu < nr_cpu_ids; cpu++) {
+				struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
+
+				if(rcu_segcblist_n_cbs(&rtpcp->cblist)) {
+					raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
+					return needgpcb;
+				}
+			}
 			WRITE_ONCE(rtp->percpu_dequeue_lim, 1);
 			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
 		}
-		for (cpu = rtp->percpu_dequeue_lim; cpu < nr_cpu_ids; cpu++) {
-			struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
-
-			WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
-		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
 
-- 
2.25.1

