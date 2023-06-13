Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A29E72D887
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbjFMEYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239417AbjFMEXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:23:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796341FC1;
        Mon, 12 Jun 2023 21:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630120; x=1718166120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GW8okMpPu8O5W0GUNzkAELrhDTCKsrn++d0PdMiQWnw=;
  b=XM9btBK+ABby0KiBW8RJMZSdDMT9F21wimEwyTS5xITb6pwDsY7eFH6t
   WabTHB5yiVraY3WiYkxeA9NgntUD+jVvL8teAf9mEEEj0Zwh5VjrpcviJ
   OeiNpoojSuWI5pu6gKbP5Az4H/0F17nkpQ/xSp286WD5XtjubCMU8PtQq
   cdLCHjJarr1w9x3caCBU4MnodGvE6zFpgG+cWzj/wtbMJMUvPZ2bqwK9c
   aJxGaoEUzve3MkKOW7DPh1eYsPTluWcdyrFzUeEbwYqyoSasWwxCVWqK2
   PhikGJj+HS2+n5C9lcJUsvGdr3hgwPInyRFJbuRj8y0Fo8val4nxSqMp9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222218"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222218"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854980"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854980"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:54 -0700
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
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: [PATCH v4 16/24] thermal: intel: hfi: Define a default class for unclassified tasks
Date:   Mon, 12 Jun 2023 21:24:14 -0700
Message-Id: <20230613042422.5344-17-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
Cc: Perry Yuan <Perry.Yuan@amd.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * Added Acked-by tag from Rafael.

Changes since v2:
 * None

Changes since v1:
 * Now the default class is 1.
---
 drivers/thermal/intel/intel_hfi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index fec2c01fda1b..e23c49da02ee 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -182,6 +182,19 @@ static struct workqueue_struct *hfi_updates_wq;
 #define HFI_UPDATE_INTERVAL		HZ
 #define HFI_MAX_THERM_NOTIFY_COUNT	16
 
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
 /* A cache of the HFI perf capabilities for lockless access. */
 static int __percpu *hfi_ipcc_scores;
 /* Sequence counter for hfi_ipcc_scores */
@@ -212,7 +225,7 @@ unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu)
 		return -EINVAL;
 
 	if (ipcc == IPC_CLASS_UNCLASSIFIED)
-		return -EINVAL;
+		ipcc = HFI_UNCLASSIFIED_DEFAULT;
 
 	/*
 	 * Scheduler IPC classes start at 1. HFI classes start at 0.
-- 
2.25.1

