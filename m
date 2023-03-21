Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09506C29D4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCUFYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCUFYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:24:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC24318A91;
        Mon, 20 Mar 2023 22:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679376263; x=1710912263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=nqNq6hBpFp6r6NRgDicIUmgboxRSlDZI/134df8WGSw=;
  b=hQFWd2y5u+SrPqpYSmQqnjbbwdCbmcbQHewgeylsF3IdoDZUhZ+YRIz4
   LkRc7afiJPe1H78nvk6c/K4KYnzUQIMSBrbbxn9T/d9VKo5L0ypMUillh
   tWR+dISGAFfOidd1jmTKL5jZBlujcFNN7KRt8YIfEVuJR+tMn09hVkZIr
   EkvYvLgmWIN+68JP5t5wFyQS/WA+dN73+qMvBqQPF64xNSNyEQDKdAiVb
   Hwo9b5TJXk1648xBSpxddMJ+3OSOw/Ox3PJvIAp0RBE3B3ce8HzWhFUmd
   B0W4XVRApU9sEJSujkDM6k1U52lIidIpZd3AOgpPG4TaUIb9NNvJr0Yzb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="337571134"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="337571134"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="750397857"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="750397857"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:24:20 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     paulmck@kernel.org
Cc:     dave@stgolabs.net, frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        qiuxu.zhuo@intel.com, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, rostedt@goodmis.org
Subject: [PATCH v3 1/2] rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()
Date:   Tue, 21 Mar 2023 13:23:36 +0800
Message-Id: <20230321052337.26553-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <72ba8619-88cb-4bf4-8232-18d8a1b6b5bf@paulmck-laptop>
References: <72ba8619-88cb-4bf4-8232-18d8a1b6b5bf@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move rcu_scale_cleanup() and rcu_scale_shutdown() functions after
kfree_scale_cleanup(). There are no function changes.

The intention of this moving is a preparation for a subsequent patch
that will fix a call-trace bug by invoking kfree_scale_cleanup() from
rcu_scale_cleanup() without the declaration of kfree_scale_cleanup().

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 Paul, please modify the commit message if needed. Thanks!

 kernel/rcu/rcuscale.c | 196 +++++++++++++++++++++---------------------
 1 file changed, 98 insertions(+), 98 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 91fb5905a008..e99096a4f094 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -522,89 +522,6 @@ rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
 		 scale_type, tag, nrealreaders, nrealwriters, verbose, shutdown);
 }
 
-static void
-rcu_scale_cleanup(void)
-{
-	int i;
-	int j;
-	int ngps = 0;
-	u64 *wdp;
-	u64 *wdpp;
-
-	/*
-	 * Would like warning at start, but everything is expedited
-	 * during the mid-boot phase, so have to wait till the end.
-	 */
-	if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
-		SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
-	if (rcu_gp_is_normal() && gp_exp)
-		SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
-	if (gp_exp && gp_async)
-		SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
-
-	if (torture_cleanup_begin())
-		return;
-	if (!cur_ops) {
-		torture_cleanup_end();
-		return;
-	}
-
-	if (reader_tasks) {
-		for (i = 0; i < nrealreaders; i++)
-			torture_stop_kthread(rcu_scale_reader,
-					     reader_tasks[i]);
-		kfree(reader_tasks);
-	}
-
-	if (writer_tasks) {
-		for (i = 0; i < nrealwriters; i++) {
-			torture_stop_kthread(rcu_scale_writer,
-					     writer_tasks[i]);
-			if (!writer_n_durations)
-				continue;
-			j = writer_n_durations[i];
-			pr_alert("%s%s writer %d gps: %d\n",
-				 scale_type, SCALE_FLAG, i, j);
-			ngps += j;
-		}
-		pr_alert("%s%s start: %llu end: %llu duration: %llu gps: %d batches: %ld\n",
-			 scale_type, SCALE_FLAG,
-			 t_rcu_scale_writer_started, t_rcu_scale_writer_finished,
-			 t_rcu_scale_writer_finished -
-			 t_rcu_scale_writer_started,
-			 ngps,
-			 rcuscale_seq_diff(b_rcu_gp_test_finished,
-					   b_rcu_gp_test_started));
-		for (i = 0; i < nrealwriters; i++) {
-			if (!writer_durations)
-				break;
-			if (!writer_n_durations)
-				continue;
-			wdpp = writer_durations[i];
-			if (!wdpp)
-				continue;
-			for (j = 0; j < writer_n_durations[i]; j++) {
-				wdp = &wdpp[j];
-				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
-					scale_type, SCALE_FLAG,
-					i, j, *wdp);
-				if (j % 100 == 0)
-					schedule_timeout_uninterruptible(1);
-			}
-			kfree(writer_durations[i]);
-		}
-		kfree(writer_tasks);
-		kfree(writer_durations);
-		kfree(writer_n_durations);
-	}
-
-	/* Do torture-type-specific cleanup operations.  */
-	if (cur_ops->cleanup != NULL)
-		cur_ops->cleanup();
-
-	torture_cleanup_end();
-}
-
 /*
  * Return the number if non-negative.  If -1, the number of CPUs.
  * If less than -1, that much less than the number of CPUs, but
@@ -624,21 +541,6 @@ static int compute_real(int n)
 	return nr;
 }
 
-/*
- * RCU scalability shutdown kthread.  Just waits to be awakened, then shuts
- * down system.
- */
-static int
-rcu_scale_shutdown(void *arg)
-{
-	wait_event(shutdown_wq,
-		   atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
-	smp_mb(); /* Wake before output. */
-	rcu_scale_cleanup();
-	kernel_power_off();
-	return -EINVAL;
-}
-
 /*
  * kfree_rcu() scalability tests: Start a kfree_rcu() loop on all CPUs for number
  * of iterations and measure total time and number of GP for all iterations to complete.
@@ -875,6 +777,104 @@ kfree_scale_init(void)
 	return firsterr;
 }
 
+static void
+rcu_scale_cleanup(void)
+{
+	int i;
+	int j;
+	int ngps = 0;
+	u64 *wdp;
+	u64 *wdpp;
+
+	/*
+	 * Would like warning at start, but everything is expedited
+	 * during the mid-boot phase, so have to wait till the end.
+	 */
+	if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
+		SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
+	if (rcu_gp_is_normal() && gp_exp)
+		SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
+	if (gp_exp && gp_async)
+		SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
+
+	if (torture_cleanup_begin())
+		return;
+	if (!cur_ops) {
+		torture_cleanup_end();
+		return;
+	}
+
+	if (reader_tasks) {
+		for (i = 0; i < nrealreaders; i++)
+			torture_stop_kthread(rcu_scale_reader,
+					     reader_tasks[i]);
+		kfree(reader_tasks);
+	}
+
+	if (writer_tasks) {
+		for (i = 0; i < nrealwriters; i++) {
+			torture_stop_kthread(rcu_scale_writer,
+					     writer_tasks[i]);
+			if (!writer_n_durations)
+				continue;
+			j = writer_n_durations[i];
+			pr_alert("%s%s writer %d gps: %d\n",
+				 scale_type, SCALE_FLAG, i, j);
+			ngps += j;
+		}
+		pr_alert("%s%s start: %llu end: %llu duration: %llu gps: %d batches: %ld\n",
+			 scale_type, SCALE_FLAG,
+			 t_rcu_scale_writer_started, t_rcu_scale_writer_finished,
+			 t_rcu_scale_writer_finished -
+			 t_rcu_scale_writer_started,
+			 ngps,
+			 rcuscale_seq_diff(b_rcu_gp_test_finished,
+					   b_rcu_gp_test_started));
+		for (i = 0; i < nrealwriters; i++) {
+			if (!writer_durations)
+				break;
+			if (!writer_n_durations)
+				continue;
+			wdpp = writer_durations[i];
+			if (!wdpp)
+				continue;
+			for (j = 0; j < writer_n_durations[i]; j++) {
+				wdp = &wdpp[j];
+				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
+					scale_type, SCALE_FLAG,
+					i, j, *wdp);
+				if (j % 100 == 0)
+					schedule_timeout_uninterruptible(1);
+			}
+			kfree(writer_durations[i]);
+		}
+		kfree(writer_tasks);
+		kfree(writer_durations);
+		kfree(writer_n_durations);
+	}
+
+	/* Do torture-type-specific cleanup operations.  */
+	if (cur_ops->cleanup != NULL)
+		cur_ops->cleanup();
+
+	torture_cleanup_end();
+}
+
+/*
+ * RCU scalability shutdown kthread.  Just waits to be awakened, then shuts
+ * down system.
+ */
+static int
+rcu_scale_shutdown(void *arg)
+{
+	wait_event(shutdown_wq,
+		   atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
+	smp_mb(); /* Wake before output. */
+	rcu_scale_cleanup();
+	kernel_power_off();
+	return -EINVAL;
+}
+
 static int __init
 rcu_scale_init(void)
 {
-- 
2.17.1

