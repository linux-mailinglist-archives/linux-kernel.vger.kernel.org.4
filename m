Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2068CE98
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjBGFDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjBGFB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:01:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7C7D518;
        Mon,  6 Feb 2023 21:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746117; x=1707282117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=L0pxmqCmeAEPVOWhuC7xe5KQw/uWTSvYwYWe6PdvQds=;
  b=k8lpySZEZuKpnEK6BNh3MqDFNj8noa8cmCiWoDb0FpmCUQuYh2NwIloX
   Na7gEE8syVSHC4CF6E4fkewSmjcUZLevai8p0s3bodM2YHP2DQxiUqHkS
   X9kfu8jHMvU0GzwCtoaqkd3YwvzKT/keEfNVk5M+n07Pa+NFwiyz4Qltb
   kt/XUIaH2tkpyNJd2zHEs7tQZh6oFOUv+jcguXtrEZO4ge9KVVHssA3md
   EjGRan8X8RDlLc192EpYjS0vRv59HNbF6HJ6gmjJq5DnylQWOYhlBNm2K
   0Yws1c81pAawAKeAwqd36Nf5SEHv4K9ewHpLMVw5BA6YUnB8/MwlZOxrN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625907"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625907"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657755"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657755"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 21:01:44 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v3 16/24] thermal: intel: hfi: Define a default class for unclassified tasks
Date:   Mon,  6 Feb 2023 21:10:57 -0800
Message-Id: <20230207051105.11575-17-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A task may be unclassified if it has been recently created, spend most of
its lifetime sleeping, or hardware has not provided a classification.

Most tasks will be eventually classified as scheduler's IPC class 1
(HFI class 0). This class corresponds to the capabilities in the legacy,
classless, HFI table.

IPC class 1 is a reasonable choice until hardware provides an actual
classification. Meanwhile, the scheduler will place classes of tasks with
higher IPC scores on higher-performance CPUs.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 * None

Changes since v1:
 * Now the default class is 1.
---
 drivers/thermal/intel/intel_hfi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index fa9b4a678d92..7ea6acce7107 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -185,6 +185,19 @@ static struct workqueue_struct *hfi_updates_wq;
 #ifdef CONFIG_IPC_CLASSES
 static int __percpu *hfi_ipcc_scores;
 
+/*
+ * A task may be unclassified if it has been recently created, spend most of
+ * its lifetime sleeping, or hardware has not provided a classification.
+ *
+ * Most tasks will be classified as scheduler's IPC class 1 (HFI class 0)
+ * eventually. Meanwhile, the scheduler will place classes of tasks with higher
+ * IPC scores on higher-performance CPUs.
+ *
+ * IPC class 1 is a reasonable choice. It matches the performance capability
+ * of the legacy, classless, HFI table.
+ */
+#define HFI_UNCLASSIFIED_DEFAULT 1
+
 void intel_hfi_update_ipcc(struct task_struct *curr)
 {
 	union hfi_thread_feedback_char_msr msr;
@@ -215,7 +228,7 @@ unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu)
 		return -EINVAL;
 
 	if (ipcc == IPC_CLASS_UNCLASSIFIED)
-		return -EINVAL;
+		ipcc = HFI_UNCLASSIFIED_DEFAULT;
 
 	/*
 	 * Scheduler IPC classes start at 1. HFI classes start at 0.
-- 
2.25.1

