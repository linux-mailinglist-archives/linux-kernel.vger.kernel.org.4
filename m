Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC4B72D877
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbjFMEXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239417AbjFMEWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:22:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156531989;
        Mon, 12 Jun 2023 21:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630110; x=1718166110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=y0o6+f37IqB/eFr8r5TzCIQyyzU0NBcgN26gcc8sIuI=;
  b=kBCIU+OSNYuYe5r2Zr+l7Vqiu4BRRWn/L28IswR6z3ghBGYgiWy7TslQ
   8VXQY4E8OtfdII2MaL4kXe6Sje0lOYx7pzlPoHQRBRzox4qAIK3HlrC9v
   gOKL5QEqqRpLGbBlJvLRz7r3Fxm/KbTuQwoNAeHgS6xtolo3ZHYLGm2dH
   lEBdqtbr/wuT4QPPjOF/v8KWM9JKHdAcWco3zO+PNrjXf8JViPqonM+3i
   lt9w5g581eRWZMXxhDX+4t1czZUHoQha4BA2bXlCmR0AotyVwLtkh0dJt
   MhKKQHUImipWhnf3VO52xjuP3Bm7BPYUArE2Qgw3EP29mKdoJO9gY1G5s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222159"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222159"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854965"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854965"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:48 -0700
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
Subject: [PATCH v4 11/24] thermal: intel: hfi: Introduce Intel Thread Director classes
Date:   Mon, 12 Jun 2023 21:24:09 -0700
Message-Id: <20230613042422.5344-12-ricardo.neri-calderon@linux.intel.com>
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

On Intel hybrid parts, each type of CPU has specific performance and
energy efficiency capabilities. The Intel Thread Director technology
extends the Hardware Feedback Interface (HFI) to provide performance and
energy efficiency data for advanced classes of instructions.

Add support to parse per-class capabilities.

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
 * Removed a now obsolete comment.
---
 drivers/thermal/intel/intel_hfi.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index c69db6c90869..b41547912fda 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -78,7 +78,7 @@ union cpuid6_edx {
  * @ee_cap:		Energy efficiency capability
  *
  * Capabilities of a logical processor in the HFI table. These capabilities are
- * unitless.
+ * unitless and specific to each HFI class.
  */
 struct hfi_cpu_data {
 	u8	perf_cap;
@@ -90,7 +90,8 @@ struct hfi_cpu_data {
  * @perf_updated:	Hardware updated performance capabilities
  * @ee_updated:		Hardware updated energy efficiency capabilities
  *
- * Properties of the data in an HFI table.
+ * Properties of the data in an HFI table. There exists one header per each
+ * HFI class.
  */
 struct hfi_hdr {
 	u8	perf_updated;
@@ -128,16 +129,21 @@ struct hfi_instance {
 
 /**
  * struct hfi_features - Supported HFI features
+ * @nr_classes:		Number of classes supported
  * @nr_table_pages:	Size of the HFI table in 4KB pages
  * @cpu_stride:		Stride size to locate the capability data of a logical
  *			processor within the table (i.e., row stride)
+ * @class_stride:	Stride size to locate a class within the capability
+ *			data of a logical processor or the HFI table header
  * @hdr_size:		Size of the table header
  *
  * Parameters and supported features that are common to all HFI instances
  */
 struct hfi_features {
+	unsigned int	nr_classes;
 	size_t		nr_table_pages;
 	unsigned int	cpu_stride;
+	unsigned int	class_stride;
 	unsigned int	hdr_size;
 };
 
@@ -334,8 +340,8 @@ static void init_hfi_cpu_index(struct hfi_cpu_info *info)
 }
 
 /*
- * The format of the HFI table depends on the number of capabilities that the
- * hardware supports. Keep a data structure to navigate the table.
+ * The format of the HFI table depends on the number of capabilities and classes
+ * that the hardware supports. Keep a data structure to navigate the table.
  */
 static void init_hfi_instance(struct hfi_instance *hfi_instance)
 {
@@ -516,18 +522,30 @@ static __init int hfi_parse_features(void)
 	/* The number of 4KB pages required by the table */
 	hfi_features.nr_table_pages = edx.split.table_pages + 1;
 
+	/*
+	 * Capability fields of an HFI class are grouped together. Classes are
+	 * contiguous in memory.  Hence, use the number of supported features to
+	 * locate a specific class.
+	 */
+	hfi_features.class_stride = nr_capabilities;
+
+	/* For now, use only one class of the HFI table */
+	hfi_features.nr_classes = 1;
+
 	/*
 	 * The header contains change indications for each supported feature.
 	 * The size of the table header is rounded up to be a multiple of 8
 	 * bytes.
 	 */
-	hfi_features.hdr_size = DIV_ROUND_UP(nr_capabilities, 8) * 8;
+	hfi_features.hdr_size = DIV_ROUND_UP(nr_capabilities *
+					     hfi_features.nr_classes, 8) * 8;
 
 	/*
 	 * Data of each logical processor is also rounded up to be a multiple
 	 * of 8 bytes.
 	 */
-	hfi_features.cpu_stride = DIV_ROUND_UP(nr_capabilities, 8) * 8;
+	hfi_features.cpu_stride = DIV_ROUND_UP(nr_capabilities *
+					       hfi_features.nr_classes, 8) * 8;
 
 	return 0;
 }
-- 
2.25.1

