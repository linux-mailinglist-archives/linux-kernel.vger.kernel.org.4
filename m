Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BF568CE95
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjBGFC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjBGFB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:01:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901C7C678;
        Mon,  6 Feb 2023 21:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746115; x=1707282115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=d7YOpMlf1P1ORwPsFp8Wf2z9+WUpcXCD+VCa+NWGzJ0=;
  b=KgwOpYS9wwI5sG+q542pWz5u/vqrl00gdbipfL2/6e4zuRlSjEa2a1FL
   EByuNyYUqIIm1c1vhNPO/wgqf+J91afi2g6JOobXDlY4H+cSFYwbpilRE
   k2W035GmwVnSMmxflsN0H6BOW+8rw4OyOtxAf4PArdcu1YtuXJQjLuDxU
   UdfT1ID5O/f8u7Lo1tBAdnH3XwyjQoLIOC1CwkU7FvRHl+99J5lfaDCKx
   KinJoe/DUXiPwN55nUT5Qw8qoJhb7j5HVmHuNplFkU+0dkhqn8Rc+jMg8
   msjsuc6nY5h3tVppu8rYD5ZtiImDWUCq9i95V9D/HTtapQu0W+SMGgVrg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625861"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625861"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657733"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657733"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 21:01:43 -0800
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
Subject: [PATCH v3 11/24] thermal: intel: hfi: Introduce Intel Thread Director classes
Date:   Mon,  6 Feb 2023 21:10:52 -0800
Message-Id: <20230207051105.11575-12-ricardo.neri-calderon@linux.intel.com>
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
 * Removed a now obsolete comment.
---
 drivers/thermal/intel/intel_hfi.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 6e604bda2b93..2527ae3836c7 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -77,7 +77,7 @@ union cpuid6_edx {
  * @ee_cap:		Energy efficiency capability
  *
  * Capabilities of a logical processor in the HFI table. These capabilities are
- * unitless.
+ * unitless and specific to each HFI class.
  */
 struct hfi_cpu_data {
 	u8	perf_cap;
@@ -89,7 +89,8 @@ struct hfi_cpu_data {
  * @perf_updated:	Hardware updated performance capabilities
  * @ee_updated:		Hardware updated energy efficiency capabilities
  *
- * Properties of the data in an HFI table.
+ * Properties of the data in an HFI table. There exists one header per each
+ * HFI class.
  */
 struct hfi_hdr {
 	u8	perf_updated;
@@ -127,16 +128,21 @@ struct hfi_instance {
 
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
 
@@ -333,8 +339,8 @@ static void init_hfi_cpu_index(struct hfi_cpu_info *info)
 }
 
 /*
- * The format of the HFI table depends on the number of capabilities that the
- * hardware supports. Keep a data structure to navigate the table.
+ * The format of the HFI table depends on the number of capabilities and classes
+ * that the hardware supports. Keep a data structure to navigate the table.
  */
 static void init_hfi_instance(struct hfi_instance *hfi_instance)
 {
@@ -515,18 +521,30 @@ static __init int hfi_parse_features(void)
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

