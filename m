Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25606BBC20
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjCOSeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjCOSeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:34:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FB928D34;
        Wed, 15 Mar 2023 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905248; x=1710441248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hHV55N0QiZMcT4V3m9CPVkpMG+H53YsJVo4BOQ9V6kk=;
  b=O2zr4KPgXKfEJTuZdo8iE4lUHCHMtrEfWJV4ZKnc99JHmjA6/Nyyff7M
   fWg/asdb3ikfVHuMkqRFjEMMU+iHQ0OFkvQ74K0nKXSVGGaizHHeN8xm2
   pG2HZ+ePuWbAc/6aePz6gP979/YI+usoYwW5QIbUN39Ix7/uN6SlBXeIP
   maonZJ3QB0Bh7TLbsj1a/zdDstJ6zuAKL9FdbWdgAfd8saHMAy2yEaVdl
   FoyM25YYmlhga33ms0nmqis5tWTDzdtwxrp/9XT5E9Ets2qNgapUbcwLk
   WVZzzmOlpvz+vCm75lamY5YRgjDoLVO3u2lIqTNJm5TxqjTzbUtlfod5n
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340154523"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340154523"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:34:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925435199"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925435199"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:34:06 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.75.205])
        by linux.intel.com (Postfix) with ESMTP id 64DF3580BF2;
        Wed, 15 Mar 2023 11:34:06 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com, rajvi.jingar@linux.intel.com,
        xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 01/11] platform/x86/intel/vsec: Add intel_vsec_register
Date:   Wed, 15 Mar 2023 11:33:55 -0700
Message-Id: <20230315183405.2465630-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315183405.2465630-1-david.e.box@linux.intel.com>
References: <20230315183405.2465630-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@linux.intel.com>

Intel PCIe VSEC capabilities may be emulated in the MMIO space of other
Intel devices like the Power Management Controller (PMC) SSRAM device.  Add
and export intel_vsec_register to allow those capabilities to be registered
by other drivers. Reuses the existing intel_vsec_walk_header function which
already creates entries from device data in lieu of a config space (used by
DG1). Add a check to ensure that the memory region is available before
creating a VSEC auxiliary device.

Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/class.c |  2 +-
 drivers/platform/x86/intel/pmt/class.h |  5 ++-
 drivers/platform/x86/intel/vsec.c      | 56 +++++++++-----------------
 drivers/platform/x86/intel/vsec.h      | 51 ++++++++++++++++++++++-
 4 files changed, 73 insertions(+), 41 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 46598dcb634a..9f505c6ef278 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -31,7 +31,7 @@ bool intel_pmt_is_early_client_hw(struct device *dev)
 	 * differences from the server platforms (which use the Out Of Band
 	 * Management Services Module OOBMSM).
 	 */
-	return !!(ivdev->info->quirks & VSEC_QUIRK_EARLY_HW);
+	return !!(ivdev->quirks & VSEC_QUIRK_EARLY_HW);
 }
 EXPORT_SYMBOL_GPL(intel_pmt_is_early_client_hw);
 
diff --git a/drivers/platform/x86/intel/pmt/class.h b/drivers/platform/x86/intel/pmt/class.h
index db11d58867ce..17bc40b77efc 100644
--- a/drivers/platform/x86/intel/pmt/class.h
+++ b/drivers/platform/x86/intel/pmt/class.h
@@ -2,11 +2,10 @@
 #ifndef _INTEL_PMT_CLASS_H
 #define _INTEL_PMT_CLASS_H
 
-#include <linux/xarray.h>
-#include <linux/types.h>
 #include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/types.h>
 
 #include "../vsec.h"
 
@@ -18,6 +17,8 @@
 #define GET_BIR(v)		((v) & GENMASK(2, 0))
 #define GET_ADDRESS(v)		((v) & GENMASK(31, 3))
 
+struct xarray;
+
 struct intel_pmt_entry {
 	struct bin_attribute	pmt_bin_attr;
 	struct kobject		*kobj;
diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 13decf36c6de..a22354ee6ce3 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -24,13 +24,6 @@
 
 #include "vsec.h"
 
-/* Intel DVSEC offsets */
-#define INTEL_DVSEC_ENTRIES		0xA
-#define INTEL_DVSEC_SIZE		0xB
-#define INTEL_DVSEC_TABLE		0xC
-#define INTEL_DVSEC_TABLE_BAR(x)	((x) & GENMASK(2, 0))
-#define INTEL_DVSEC_TABLE_OFFSET(x)	((x) & GENMASK(31, 3))
-#define TABLE_OFFSET_SHIFT		3
 #define PMT_XA_START			0
 #define PMT_XA_MAX			INT_MAX
 #define PMT_XA_LIMIT			XA_LIMIT(PMT_XA_START, PMT_XA_MAX)
@@ -39,34 +32,6 @@ static DEFINE_IDA(intel_vsec_ida);
 static DEFINE_IDA(intel_vsec_sdsi_ida);
 static DEFINE_XARRAY_ALLOC(auxdev_array);
 
-/**
- * struct intel_vsec_header - Common fields of Intel VSEC and DVSEC registers.
- * @rev:         Revision ID of the VSEC/DVSEC register space
- * @length:      Length of the VSEC/DVSEC register space
- * @id:          ID of the feature
- * @num_entries: Number of instances of the feature
- * @entry_size:  Size of the discovery table for each feature
- * @tbir:        BAR containing the discovery tables
- * @offset:      BAR offset of start of the first discovery table
- */
-struct intel_vsec_header {
-	u8	rev;
-	u16	length;
-	u16	id;
-	u8	num_entries;
-	u8	entry_size;
-	u8	tbir;
-	u32	offset;
-};
-
-enum intel_vsec_id {
-	VSEC_ID_TELEMETRY	= 2,
-	VSEC_ID_WATCHER		= 3,
-	VSEC_ID_CRASHLOG	= 4,
-	VSEC_ID_SDSI		= 65,
-	VSEC_ID_TPMI		= 66,
-};
-
 static enum intel_vsec_id intel_vsec_allow_list[] = {
 	VSEC_ID_TELEMETRY,
 	VSEC_ID_WATCHER,
@@ -241,12 +206,21 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 			     header->offset + i * (header->entry_size * sizeof(u32));
 		tmp->end = tmp->start + (header->entry_size * sizeof(u32)) - 1;
 		tmp->flags = IORESOURCE_MEM;
+
+		/* Check resource is not in use */
+		if (!request_mem_region(tmp->start, resource_size(tmp), "")) {
+			kfree(res);
+			kfree(intel_vsec_dev);
+			return -EBUSY;
+		}
+
+		release_mem_region(tmp->start, resource_size(tmp));
 	}
 
 	intel_vsec_dev->pcidev = pdev;
 	intel_vsec_dev->resource = res;
 	intel_vsec_dev->num_resources = header->num_entries;
-	intel_vsec_dev->info = info;
+	intel_vsec_dev->quirks = info->quirks;
 
 	if (header->id == VSEC_ID_SDSI)
 		intel_vsec_dev->ida = &intel_vsec_sdsi_ida;
@@ -371,6 +345,16 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
 	return have_devices;
 }
 
+void intel_vsec_register(struct pci_dev *pdev,
+			 struct intel_vsec_platform_info *info)
+{
+	if (!pdev || !info)
+		return;
+
+	intel_vsec_walk_header(pdev, info);
+}
+EXPORT_SYMBOL_NS_GPL(intel_vsec_register, INTEL_VSEC);
+
 static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct intel_vsec_platform_info *info;
diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index ae8fe92c5595..f600d6fe0830 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -1,13 +1,49 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _VSEC_H
-#define _VSEC_H
+#ifndef _INTEL_VSEC_H
+#define _INTEL_VSEC_H
 
 #include <linux/auxiliary_bus.h>
 #include <linux/bits.h>
 
+/* Intel DVSEC offsets */
+#define INTEL_DVSEC_ENTRIES		0xA
+#define INTEL_DVSEC_SIZE		0xB
+#define INTEL_DVSEC_TABLE		0xC
+#define INTEL_DVSEC_TABLE_BAR(x)	((x) & GENMASK(2, 0))
+#define INTEL_DVSEC_TABLE_OFFSET(x)	((x) & GENMASK(31, 3))
+#define TABLE_OFFSET_SHIFT		3
+
 struct pci_dev;
 struct resource;
 
+enum intel_vsec_id {
+	VSEC_ID_TELEMETRY	= 2,
+	VSEC_ID_WATCHER		= 3,
+	VSEC_ID_CRASHLOG	= 4,
+	VSEC_ID_SDSI		= 65,
+	VSEC_ID_TPMI		= 66,
+};
+
+/**
+ * struct intel_vsec_header - Common fields of Intel VSEC and DVSEC registers.
+ * @rev:	Revision ID of the VSEC/DVSEC register space
+ * @length:	Length of the VSEC/DVSEC register space
+ * @id:		ID of the feature
+ * @num_entries:Number of instances of the feature
+ * @entry_size:	Size of the discovery table for each feature
+ * @tbir:	BAR containing the discovery tables
+ * @offset:	BAR offset of start of the first discovery table
+ */
+struct intel_vsec_header {
+	u8	rev;
+	u16	length;
+	u16	id;
+	u8	num_entries;
+	u8	entry_size;
+	u8	tbir;
+	u32	offset;
+};
+
 enum intel_vsec_quirks {
 	/* Watcher feature not supported */
 	VSEC_QUIRK_NO_WATCHER	= BIT(0),
@@ -40,6 +76,7 @@ struct intel_vsec_device {
 	int num_resources;
 	void *priv_data;
 	size_t priv_data_size;
+	unsigned long quirks;
 };
 
 int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
@@ -55,4 +92,14 @@ static inline struct intel_vsec_device *auxdev_to_ivdev(struct auxiliary_device
 {
 	return container_of(auxdev, struct intel_vsec_device, auxdev);
 }
+
+#if IS_ENABLED(CONFIG_INTEL_VSEC)
+void intel_vsec_register(struct pci_dev *pdev,
+			 struct intel_vsec_platform_info *info);
+#else
+static inline void
+intel_vsec_register(struct pci_dev *pdev,
+		    struct intel_vsec_platform_info *info) {}
+#endif
+
 #endif
-- 
2.34.1

