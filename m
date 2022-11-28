Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F5E63A92F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiK1NOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiK1NNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4391D67C;
        Mon, 28 Nov 2022 05:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641218; x=1701177218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Ts4gZATy16m9TfKQnjzi/8+7PtA65oHBAtgxhfYL63g=;
  b=dUhTCKb9+Deq3nD5cKNThUR5G3vwq71Bg7saPFZ5um7Wlua7/F/upQPJ
   RRhTDsz7xqH2nud8wqpz2x+cjS2FUh9DA8y5OaMabpdhwpPlnpD+JebNT
   I64o+SdsjNXkSJafO02AOp2dNx4l6jQ/wOeGCh/5CTDSkjxgYaL176zvp
   RnQblt2WgZVSPuYjmIeacSm+RFs6KtICOWyLzMp3JWyV/hBo2RohGJinx
   tSRsslZnuK83Ho8zgLGyo7HBvbJ3tt7NJQXXrVcDzP2cwqKLlcEIqvrUM
   2Ok9NSyUMCJER11DT73mRPUUPMv8NYriZnKCr3Z2Y6oYG6y5TC/jOOWoY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117148"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117148"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381357"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381357"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 05:13:33 -0800
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
Subject: [PATCH v2 10/22] thermal: intel: hfi: Introduce Intel Thread Director classes
Date:   Mon, 28 Nov 2022 05:20:48 -0800
Message-Id: <20221128132100.30253-11-ricardo.neri-calderon@linux.intel.com>
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

On Intel hybrid parts, each type of CPU has specific performance and
energy efficiency capabilities. The Intel Thread Director technology
extends the Hardware Feedback Interface (HFI) to provide performance and
energy efficiency data for advanced classes of instructions.

Add support to parse and parse per-class capabilities.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
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
 * Removed a now obsolete comment.
---
 drivers/thermal/intel/intel_hfi.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index a0640f762dc5..df4dc50e19fb 100644
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
+	unsigned int	nr_classes;
 	unsigned int	nr_table_pages;
 	unsigned int	cpu_stride;
+	unsigned int	class_stride;
 	unsigned int	hdr_size;
 };
 
@@ -325,8 +331,8 @@ static void init_hfi_cpu_index(struct hfi_cpu_info *info)
 }
 
 /*
- * The format of the HFI table depends on the number of capabilities that the
- * hardware supports. Keep a data structure to navigate the table.
+ * The format of the HFI table depends on the number of capabilities and classes
+ * that the hardware supports. Keep a data structure to navigate the table.
  */
 static void init_hfi_instance(struct hfi_instance *hfi_instance)
 {
@@ -507,18 +513,30 @@ static __init int hfi_parse_features(void)
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

