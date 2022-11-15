Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F273F6299C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiKONN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiKONNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:13:45 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6554B1D2;
        Tue, 15 Nov 2022 05:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668518019; x=1700054019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KJFXj3YWKvBgdKbZAu8eoga4jTJKbrFgb7rok5iDpxA=;
  b=HtIx8PUnM7oNMLWloO2Yg3latnTs7KgnJOSzZT6+9kW2Lr+Cv+7HVLrQ
   qJuV1ULwqyYCapdtI+LYAITqsDud4XPS83bsXWBHo2WEH4cI3KcLbKRjk
   et5JWV2kmKo3sgAzlPff7Gq2+xMEeHOh1VJ2Pe5ib8yHvGoeNfHydcUHk
   kiZy4MvnvXgjj+AvY2jU1mfBJF5Z16vyHOnm9nb9MNrHppnBu7b8dpXHR
   EsSHSNwuSIeixGzS6yWDDK0q2btRU/64oDZ0WDiCDFGEQybrlilQuJGOC
   JKzBzxbIvHdwTB4ZO99G0JD7YiV6azABaXhlEFNyydQqlrbO6aEPBz8zW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="309875258"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="309875258"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 05:13:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="744586943"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="744586943"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 05:13:28 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Avoid invalid wakeup for rcuc kthreads in RCU_KTHREAD_OFFCPU status
Date:   Tue, 15 Nov 2022 21:19:26 +0800
Message-Id: <20221115131926.3409974-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For CONFIG_PREEMPT_RT=y kernel, the "use_softirq=0" will be set, the
RCU_SOFTIRQ processing is moved to per-CPU rcuc kthreads which created
by smpboot_register_percpu_thread(). when CPU is going offline, the
corresponding rcu_data.rcu_cpu_kthread_status is set RCU_KTHREAD_OFFCPU,
and the rcuc kthreads enter TASK_PARKED state, kthreads in TASK_PARKED
state only accept kthread_unpark() to wakeup.

Therefore, This commit avoid invoke wake_up_process() to rcuc kthreads
in TASK_PARKED state.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3ccad468887e..49dd87356851 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2375,7 +2375,8 @@ static void rcu_wake_cond(struct task_struct *t, int status)
 	 * If the thread is yielding, only wake it when this
 	 * is invoked from idle
 	 */
-	if (t && (status != RCU_KTHREAD_YIELDING || is_idle_task(current)))
+	if (t && (status != RCU_KTHREAD_YIELDING || is_idle_task(current)) &&
+				status != RCU_KTHREAD_OFFCPU)
 		wake_up_process(t);
 }
 
-- 
2.25.1

