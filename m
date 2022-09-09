Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172F45B42DF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiIIXH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiIIXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8323E115CC6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764798; x=1694300798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=epYtVjcbLviWKnJTVHgtRgUsqwNMxXWwwx/cQDLQkHc=;
  b=TERmdQdd/25me7JzWUbtqiiIR4Mo41t1VHOdh8AYTvLO9XLytZ21rbnR
   zfFLKQkb2bR6Iv95YgBeXRZPInGrDb0RJwppkj+gSoDVTlfSxTKTqOscU
   HdeqMDO7aIZGZy4Q53JGHt3RhjvEiQ40+E9d6pgp1Uaaihzz9UnffeGgV
   WEgBUVIxDUvk5zd3oA7uEO6HwZgBVW7moGXOEJj2Rr3VPex1tGGc2EYV0
   oPgwYyyEUKgFw9ZedOUa9DTc+fGSAjOkP5cppJrc0cHHcR/99isz6Trme
   3833aDgJOqPAIJTx3Edv0GqyplO5hyc/a3qpKJB5LfaqYAGVdig6OXd1E
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298386920"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298386920"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677355029"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:35 -0700
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
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [RFC PATCH 16/23] thermal: intel: hfi: Define a default classification for unclassified tasks
Date:   Fri,  9 Sep 2022 16:11:58 -0700
Message-Id: <20220909231205.14009-17-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasks may be unclassified if they have been recently created, spend most
of its lifetime sleeping, or hardware has not provided a classification.

Most tasks will be eventually classified as 0. This class corresponds to
the capabilities in the legacy, classless, Hardware Feedback Interface
table.

Class 0 is a reasonable choice until hardware provides an actual
classification. Meanwhile, the scheduler will place tasks of higher-
performance classes on higher-performance CPUs.

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
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 1b6072c828ff..967899d2c01f 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -184,6 +184,20 @@ static struct workqueue_struct *hfi_updates_wq;
 #define HFI_MAX_THERM_NOTIFY_COUNT	16
 
 #ifdef CONFIG_INTEL_THREAD_DIRECTOR
+
+/*
+ * Tasks may be unclassified if they have been recently created, spend most
+ * of its lifetime sleeping, or hardware has not provided a classification.
+ *
+ * Most tasks will be classified as 0 eventually. Meanwhile, the scheduler
+ * will place tasks of higher per-class performance on higher-performance
+ * CPUs.
+ *
+ * Class 0 is a reasonable choice. It matches the performance capability
+ * of the legacy, classless, Hardware Feedback Interface table.
+ */
+#define UNCLASSIFIED_TASK_DEFAULT 0
+
 int intel_hfi_has_task_classes(void)
 {
 	return cpu_feature_enabled(X86_FEATURE_ITD);
@@ -222,14 +236,14 @@ int intel_hfi_get_task_class_score(int class, int cpu)
 	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, cpu);
 	struct hfi_instance *instance;
 	struct hfi_cpu_data caps;
+	int cap, _class = class;
 	unsigned long flags;
-	int cap;
 
 	if (cpu < 0 || cpu >= nr_cpu_ids)
 		return -EINVAL;
 
 	if (class == TASK_CLASS_UNCLASSIFIED)
-		return -EINVAL;
+		_class = UNCLASSIFIED_TASK_DEFAULT;
 
 	if (class >= (int)hfi_features.nr_classes)
 		return -EINVAL;
@@ -239,7 +253,7 @@ int intel_hfi_get_task_class_score(int class, int cpu)
 		return -ENOENT;
 
 	raw_spin_lock_irqsave(&instance->table_lock, flags);
-	get_one_hfi_cap(instance, info->index, &caps, class);
+	get_one_hfi_cap(instance, info->index, &caps, _class);
 	cap = caps.perf_cap;
 	raw_spin_unlock_irqrestore(&instance->table_lock, flags);
 
-- 
2.25.1

