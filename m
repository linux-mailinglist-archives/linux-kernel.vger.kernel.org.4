Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB385B42CF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiIIXHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiIIXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B62114A4F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764796; x=1694300796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=spEa4CAXn7MTUE1zSapnlyxFmIuHPNbYjXwqFnk4Zi4=;
  b=DaRwzdUVCzUA9YGnSC11Kw527fCCK3ifukFzjOb+sEIqS4lsZ24or/FK
   B/2BxB78uMnMYCNOOx7lwTdHtl/2jXjbxQFOuAMeeLhp5+sPxsoI1p8vF
   pjO9V5c4vzYY1kprWhGDXeLL8VMtzRX+piiwdWeT66WcWtzPbKb+GkNj+
   kBeRikt0W6Mdc+SI3CJ4XSUZwSs1mRYXE9VtLBzM9OoBkv6KZyzTrpTTO
   ZRuu+WuvF4CsprxnWYPSxHZo7qAg+WPfsWLpsErEcScCstPaqh4ecU0Rv
   TjPKDd7K0fpnxnXmAWdWtxXj3ZjXQ6G4M18mVzjdc/Izua3DVlE3246CB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298386915"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298386915"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677355007"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:33 -0700
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
Subject: [RFC PATCH 11/23] thermal: intel: hfi: Introduce Hardware Feedback Interface classes
Date:   Fri,  9 Sep 2022 16:11:53 -0700
Message-Id: <20220909231205.14009-12-ricardo.neri-calderon@linux.intel.com>
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

On Intel hybrid parts, each type of CPU has specific performance and
energy efficiency capabilities. The Intel Thread Director technology
extends the Hardware Feedback Interface (HFI) to provide performance and
energy efficiency data for advanced classes of instructions.

Add support to parse and parse per-class capabilities.

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
 drivers/thermal/intel/intel_hfi.c | 34 +++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 239afe02e518..405495dad0b2 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -79,7 +79,7 @@ union cpuid6_edx {
  * @ee_cap:		Energy efficiency capability
  *
  * Capabilities of a logical processor in the HFI table. These capabilities are
- * unitless.
+ * unitless and specific to each HFI class.
  */
 struct hfi_cpu_data {
 	u8	perf_cap;
@@ -91,7 +91,8 @@ struct hfi_cpu_data {
  * @perf_updated:	Hardware updated performance capabilities
  * @ee_updated:		Hardware updated energy efficiency capabilities
  *
- * Properties of the data in an HFI table.
+ * Properties of the data in an HFI table. There exists one header per each
+ * HFI class.
  */
 struct hfi_hdr {
 	u8	perf_updated;
@@ -129,16 +130,21 @@ struct hfi_instance {
 
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
+	int		nr_classes;
 	size_t		nr_table_pages;
 	unsigned int	cpu_stride;
+	unsigned int	class_stride;
 	unsigned int	hdr_size;
 };
 
@@ -177,6 +183,10 @@ static void get_hfi_caps(struct hfi_instance *hfi_instance,
 		s16 index;
 
 		index = per_cpu(hfi_cpu_info, cpu).index;
+		/*
+		 * Only report the legacy (i.e., class 0) capabilities. No need
+		 * of hfi_features.class_stride.
+		 */
 		caps = hfi_instance->data + index * hfi_features.cpu_stride;
 		cpu_caps[i].cpu = cpu;
 
@@ -325,8 +335,8 @@ static void init_hfi_cpu_index(struct hfi_cpu_info *info)
 }
 
 /*
- * The format of the HFI table depends on the number of capabilities that the
- * hardware supports. Keep a data structure to navigate the table.
+ * The format of the HFI table depends on the number of capabilities and classes
+ * that the hardware supports. Keep a data structure to navigate the table.
  */
 static void init_hfi_instance(struct hfi_instance *hfi_instance)
 {
@@ -507,18 +517,30 @@ static __init int hfi_parse_features(void)
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

