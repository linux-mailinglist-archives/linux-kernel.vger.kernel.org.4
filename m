Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C818E6C08F1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCTCjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCTCjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:39:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A24A10EA;
        Sun, 19 Mar 2023 19:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679279947; x=1710815947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LwKKOSf9AIO9c6cEs3IFTS7K74vFTrrNvaG6hnwJNQE=;
  b=Vqt30vKwd76caKu+DSn8Yzz/zvkFXHsljhM1HJ4GEF1oUdSfi+Na7oHn
   uI+01QRy3S8fJ7PUHFffYmAYsap2GjBRM0aBEPCZ3nf+AWcWg2ZaZm5hR
   xmFzsV03TRKVPV0UEVL8GNQmRXp1jZLLykyGsJtOzg45y3dRYCLd2LA/n
   LuRAHP1I+ccxSQawKnGaEh+YF6qC1MGPhQ9LmZ6ZiNUvvpvl6HsHAi154
   YsO3BCLooYCDi5BH1RJah4+ZqjWoU6Z7krr/d5GghplwGTQpRh+3ZHv6K
   foj2S9cb2ULjISS1tnDwA6ntO1G2+FDKXdz0O7Z+xwnfuKVc3Ncj2FtHv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="424836838"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="424836838"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 19:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="791424254"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="791424254"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 19:39:05 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu: Fix some incorrect trace log in rcu_boost and rcuc kthreads
Date:   Mon, 20 Mar 2023 10:43:41 +0800
Message-Id: <20230320024341.3956543-1-qiang1.zhang@intel.com>
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

In rcu_boost kthreads, before invoke rcu_wait(), the trace string
should mark "Start boost kthread@rcu_wait", after rcu_wait() end,
mark "End boost kthread@rcu_wait". for boost kthread enter idle
state, the trace should also do same.
In rcuc kthreads, when the rcu_cpu_has_work is set zero, indicates
that there are no works to process, the rcuc kthreads will enter
waiting state, so the trace string should mark "Start @rcu_wait".

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c        | 2 +-
 kernel/rcu/tree_plugin.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 734c252c1e80..c1915408796f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2465,7 +2465,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
 			rcu_core();
 		local_bh_enable();
 		if (*workp == 0) {
-			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
+			trace_rcu_utilization(TPS("Start CPU kthread@rcu_wait"));
 			*statusp = RCU_KTHREAD_WAITING;
 			return;
 		}
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7b0fe741a088..7b622b5196a8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1114,10 +1114,10 @@ static int rcu_boost_kthread(void *arg)
 	trace_rcu_utilization(TPS("Start boost kthread@init"));
 	for (;;) {
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_WAITING);
-		trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
+		trace_rcu_utilization(TPS("Start boost kthread@rcu_wait"));
 		rcu_wait(READ_ONCE(rnp->boost_tasks) ||
 			 READ_ONCE(rnp->exp_tasks));
-		trace_rcu_utilization(TPS("Start boost kthread@rcu_wait"));
+		trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_RUNNING);
 		more2boost = rcu_boost(rnp);
 		if (more2boost)
@@ -1126,9 +1126,9 @@ static int rcu_boost_kthread(void *arg)
 			spincnt = 0;
 		if (spincnt > 10) {
 			WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_YIELDING);
-			trace_rcu_utilization(TPS("End boost kthread@rcu_yield"));
-			schedule_timeout_idle(2);
 			trace_rcu_utilization(TPS("Start boost kthread@rcu_yield"));
+			schedule_timeout_idle(2);
+			trace_rcu_utilization(TPS("End boost kthread@rcu_yield"));
 			spincnt = 0;
 		}
 	}
-- 
2.25.1

