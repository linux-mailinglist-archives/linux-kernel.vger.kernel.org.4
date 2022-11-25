Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB572638DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKYPsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKYPso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:48:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9F322516;
        Fri, 25 Nov 2022 07:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669391318; x=1700927318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YL+ZrS8YaYyzd70/eAm0Uh+wmNDQlivpxdI7bvBiGwo=;
  b=PqEkLrmb7QFmeDZ52Z5Z+fuNbv8l95sNZoXcfw1NJlUk6dL5NeFAgWIC
   bEZ9XNC17q7IAImYGlHUzlAFwiBydGo4O+WXEf8pEE8SYSKs5Xjd7EGQm
   3tRtQbu+Sc3rIBDn4VrzyTuCJxIfNFWbk7td7VGCVVEsDEeIDdeigVjyp
   cHuYYhGgi4WAflY9i86eK18C7AP39OKSj58aTPdifmzo8wh8RCiW1JreI
   t6paq+bSMb1+hnYo/Ns02ACS15nfVihVbHl2sIhFX1PDye6uAjkRhPLzL
   pQvzAh4It7jkbK2l4ybfZWOgcG09Ny/04Z0BzjacLITU8PcvNk3dPPpRW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="341407124"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="341407124"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 07:48:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="644834099"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="644834099"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 07:48:36 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Date:   Fri, 25 Nov 2022 23:54:27 +0800
Message-Id: <20221125155427.1381933-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, for the case of num_online_cpus() <= 1, return directly,
indicates the end of current grace period and then release old data.
it's not accurate, for SMP system, when num_online_cpus() is equal
one, maybe another cpu that in offline process(after invoke
__cpu_disable()) is still in the rude RCU-Tasks critical section
holding the old data, this lead to memory corruption.

Therefore, this commit add cpus_read_lock/unlock() before executing
num_online_cpus().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4a991311be9b..08e72c6462d8 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct *work)
 {
 }
 
+static DEFINE_PER_CPU(struct work_struct, rude_work);
+
 // Wait for one rude RCU-tasks grace period.
 static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 {
+	int cpu;
+	struct work_struct *work;
+
+	cpus_read_lock();
 	if (num_online_cpus() <= 1)
-		return;	// Fastpath for only one CPU.
+		goto end;// Fastpath for only one CPU.
 
 	rtp->n_ipis += cpumask_weight(cpu_online_mask);
-	schedule_on_each_cpu(rcu_tasks_be_rude);
+	for_each_online_cpu(cpu) {
+		work = per_cpu_ptr(&rude_work, cpu);
+		INIT_WORK(work, rcu_tasks_be_rude);
+		schedule_work_on(cpu, work);
+	}
+
+	for_each_online_cpu(cpu)
+		flush_work(per_cpu_ptr(&rude_work, cpu));
+
+end:
+	cpus_read_unlock();
 }
 
 void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
-- 
2.25.1

