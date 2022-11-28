Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79D663A93B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiK1NOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiK1NNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269C4B7CD;
        Mon, 28 Nov 2022 05:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641220; x=1701177220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qxJuo8ldTPva48VrC4qfDcG1QduoBAzNsZcRAMiSMzk=;
  b=SQSfzVDV4acHSgxO+V4fEB7SGuM6IXwhmyu3xFdfQ1kjwSwIb4r/quzz
   BJG7BVzw/Xmgo9oAsDUdGYlPzAMqQO9l4OvYeg4JKsHKANxXdnHkhSm09
   E2dPiyApFjz4Hn1G2al7R+nFmQ/g5+nSmiXUkM2W6ZCucSJEv5+0/ONVe
   9NEhRhedJSzYn3AFfHRUMVtMly1x5cn8g64spKA5FYbiE5IOWIGNQqtgn
   FO9TNgK/AcbrixzE6ZySqpBq+pveGInvudQWM/A8TTApwPBlCECpVichx
   pYzZL8vOkvjrPe2x574h1d1xJZSuf233YV3TKjtsc7gfAU3XDOPr19J7/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117200"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117200"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381381"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381381"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 05:13:34 -0800
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
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v2 15/22] thermal: intel: hfi: Define a default class for unclassified tasks
Date:   Mon, 28 Nov 2022 05:20:53 -0800
Message-Id: <20221128132100.30253-16-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
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
classification. Meanwhile, the scheduler will place other tasks with higher
scores on higher-performance CPUs.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Len Brown <len.brown@intel.com>
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
Changes since v1:
 * Now the default class is 1.
---
 drivers/thermal/intel/intel_hfi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 1f7b18198bd4..1b3fd704ae9a 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -187,6 +187,19 @@ static struct workqueue_struct *hfi_updates_wq;
 #ifdef CONFIG_IPC_CLASSES
 static int __percpu *hfi_ipcc_scores;
 
+/*
+ * A task may be unclassified if it has been recently created, spend most of
+ * its lifetime sleeping, or hardware has not provided a classification.
+ *
+ * Most tasks will be classified as scheduler's IPC class 1 (HFI class 0)
+ * eventually. Meanwhile, the scheduler will place tasks of higher IPC score
+ * on higher-performance CPUs.
+ *
+ * IPC class 1 is a reasonable choice. It matches the performance capability
+ * of the legacy, classless, HFI table.
+ */
+#define HFI_UNCLASSIFIED_DEFAULT 1
+
 int intel_hfi_has_ipc_classes(void)
 {
 	return cpu_feature_enabled(X86_FEATURE_ITD);
@@ -222,7 +235,7 @@ int intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu)
 		return -EINVAL;
 
 	if (ipcc == IPC_CLASS_UNCLASSIFIED)
-		return -EINVAL;
+		ipcc = HFI_UNCLASSIFIED_DEFAULT;
 
 	/*
 	 * Scheduler IPC classes start at 1. HFI classes start at 0.
-- 
2.25.1

