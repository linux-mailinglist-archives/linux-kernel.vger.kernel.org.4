Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4EB62DAE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbiKQMaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKQM3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE2F725D7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668688132; x=1700224132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IWN+Jc3bIdcog99k6C0X9y70oAbhT4EqrD0N2igtiLI=;
  b=OYb2zRG3JKMyjTXGN2TZn22p5Gx3M/KRkiHMf+2o/kb4sS/TaXrPJx7Z
   5EeVLKBegohq8pRhAzHOrfsksFe0g2K4EH5Y2U+7zeDTESSRyl9jLL/Yq
   4Jz/9eJ9gLaL4/ims+ymz7/KmQSRQ95y/ERks0RIF3o3BvVtjLPsRvtXF
   JjQXuFJXd7x3cA0Btyx/4zcrHYorAMjjQTXCDb5vsqNl1jjMSD8COP1Bz
   /vbutgWh0lF4L09ZX0/zOgo7vvvbhv6yEH0RFcr0XwlI3K6QugCzclRN/
   hmiJMq7KCUAx/i5yGIbaw0xczcJv7SY9your/GHfsWKpOLRTQVk+EJX+B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296199878"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296199878"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590604561"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590604561"
Received: from jfdev013vml03.jf.intel.com ([10.23.26.52])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2022 04:28:47 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 11/11] perf/x86/intel/uncore: Make set_mapping() procedure void
Date:   Thu, 17 Nov 2022 12:28:33 +0000
Message-Id: <20221117122833.3103580-12-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117122833.3103580-1-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Return value of set_mapping() is not needed to be checked anymore.
So, make this procedure void.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.h       |  2 +-
 arch/x86/events/intel/uncore_snbep.c | 41 +++++++++++++---------------
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index fac3612289f1..e278e2e7c051 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -94,7 +94,7 @@ struct intel_uncore_type {
 	 * Optional callbacks for managing mapping of Uncore units to PMONs
 	 */
 	int (*get_topology)(struct intel_uncore_type *type);
-	int (*set_mapping)(struct intel_uncore_type *type);
+	void (*set_mapping)(struct intel_uncore_type *type);
 	void (*cleanup_mapping)(struct intel_uncore_type *type);
 };
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 4c2d5b5ea445..b8f9bd150b42 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3924,7 +3924,7 @@ static void pmu_clear_mapping_attr(const struct attribute_group **groups,
 	}
 }
 
-static int
+static void
 pmu_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag,
 		ssize_t (*show)(struct device*, struct device_attribute*, char*),
 		int topology_type)
@@ -3943,8 +3943,6 @@ pmu_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag,
 	if (ret < 0)
 		goto clear_topology;
 
-	ret = -ENOMEM;
-
 	/* One more for NULL. */
 	attrs = kcalloc((uncore_max_dies() + 1), sizeof(*attrs), GFP_KERNEL);
 	if (!attrs)
@@ -3968,7 +3966,7 @@ pmu_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag,
 	}
 	ag->attrs = attrs;
 
-	return 0;
+	return;
 err:
 	for (; die >= 0; die--)
 		kfree(eas[die].attr.attr.name);
@@ -3979,7 +3977,6 @@ pmu_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag,
 	pmu_free_topology(type);
 clear_attr_update:
 	pmu_clear_mapping_attr(type->attr_update, ag);
-	return ret;
 }
 
 static void
@@ -3998,15 +3995,15 @@ pmu_cleanup_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
 	pmu_free_topology(type);
 }
 
-static int
+static void
 pmu_iio_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
 {
-	return pmu_set_mapping(type, ag, skx_iio_mapping_show, IIO_TOPOLOGY_TYPE);
+	pmu_set_mapping(type, ag, skx_iio_mapping_show, IIO_TOPOLOGY_TYPE);
 }
 
-static int skx_iio_set_mapping(struct intel_uncore_type *type)
+static void skx_iio_set_mapping(struct intel_uncore_type *type)
 {
-	return pmu_iio_set_mapping(type, &skx_iio_mapping_group);
+	pmu_iio_set_mapping(type, &skx_iio_mapping_group);
 }
 
 static void skx_iio_cleanup_mapping(struct intel_uncore_type *type)
@@ -4382,15 +4379,15 @@ static const struct attribute_group *skx_upi_attr_update[] = {
 	NULL
 };
 
-static int
+static void
 pmu_upi_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
 {
-	return pmu_set_mapping(type, ag, skx_upi_mapping_show, UPI_TOPOLOGY_TYPE);
+	pmu_set_mapping(type, ag, skx_upi_mapping_show, UPI_TOPOLOGY_TYPE);
 }
 
-static int skx_upi_set_mapping(struct intel_uncore_type *type)
+static void skx_upi_set_mapping(struct intel_uncore_type *type)
 {
-	return pmu_upi_set_mapping(type, &skx_upi_mapping_group);
+	pmu_upi_set_mapping(type, &skx_upi_mapping_group);
 }
 
 static void skx_upi_cleanup_mapping(struct intel_uncore_type *type)
@@ -4773,9 +4770,9 @@ static int snr_iio_get_topology(struct intel_uncore_type *type)
 	return sad_cfg_iio_topology(type, snr_sad_pmon_mapping);
 }
 
-static int snr_iio_set_mapping(struct intel_uncore_type *type)
+static void snr_iio_set_mapping(struct intel_uncore_type *type)
 {
-	return pmu_iio_set_mapping(type, &snr_iio_mapping_group);
+	pmu_iio_set_mapping(type, &snr_iio_mapping_group);
 }
 
 static void snr_iio_cleanup_mapping(struct intel_uncore_type *type)
@@ -5391,14 +5388,14 @@ static int icx_iio_get_topology(struct intel_uncore_type *type)
 	return sad_cfg_iio_topology(type, icx_sad_pmon_mapping);
 }
 
-static int icx_iio_set_mapping(struct intel_uncore_type *type)
+static void icx_iio_set_mapping(struct intel_uncore_type *type)
 {
 	/* Detect ICX-D system. This case is not supported */
 	if (boot_cpu_data.x86_model == INTEL_FAM6_ICELAKE_D) {
 		pmu_clear_mapping_attr(type->attr_update, &icx_iio_mapping_group);
-		return -EPERM;
+		return;
 	}
-	return pmu_iio_set_mapping(type, &icx_iio_mapping_group);
+	pmu_iio_set_mapping(type, &icx_iio_mapping_group);
 }
 
 static void icx_iio_cleanup_mapping(struct intel_uncore_type *type)
@@ -5656,9 +5653,9 @@ static const struct attribute_group *icx_upi_attr_update[] = {
 	NULL
 };
 
-static int icx_upi_set_mapping(struct intel_uncore_type *type)
+static void icx_upi_set_mapping(struct intel_uncore_type *type)
 {
-	return pmu_upi_set_mapping(type, &icx_upi_mapping_group);
+	pmu_upi_set_mapping(type, &icx_upi_mapping_group);
 }
 
 static void icx_upi_cleanup_mapping(struct intel_uncore_type *type)
@@ -6125,9 +6122,9 @@ static const struct attribute_group *spr_upi_attr_update[] = {
 
 #define SPR_UPI_REGS_ADDR_DEVICE_LINK0	0x01
 
-static int spr_upi_set_mapping(struct intel_uncore_type *type)
+static void spr_upi_set_mapping(struct intel_uncore_type *type)
 {
-	return pmu_upi_set_mapping(type, &spr_upi_mapping_group);
+	pmu_upi_set_mapping(type, &spr_upi_mapping_group);
 }
 
 static void spr_upi_cleanup_mapping(struct intel_uncore_type *type)
-- 
2.25.1

