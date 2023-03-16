Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026D86BDBE8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCPWqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjCPWqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:46:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8D46C6AE;
        Thu, 16 Mar 2023 15:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679006789; x=1710542789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AOaCAToghAy26rlfAw18N4mt5mdHurZ65GNwqo0xRN0=;
  b=TRePM1sjdCe92razwm6PfeGpfY0+5VC/ZDtfrx2onOKQsX4H3QDyz6ps
   whu+irIlj6SSSkoNjejBMLTvEZEST7AvT9bDGYzx2pCa1In83UWCzjUF+
   5hQk1dvDpREfTxxWq6+D5YHoE19uCvV+h2B+FPM+27Fx+w5Q5yglBVmbD
   WEaO3+fGvyME3SE9tU+lDrJQMYzm6vzie3Ee5FtItEZndF3SAeMUbredk
   QwnzldS/UxHaNyoO9XkJHSirUO/wx15Is9V3d/Zf3q/zdPKhpQfzbI2+z
   P2Z8IHSdxMMMwa3/l4MsduG20k5UbWLNuAu/oSW3UBiCAq4pNpS6u8Oz4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="321982607"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="321982607"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 15:46:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="680069069"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="680069069"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 16 Mar 2023 15:46:28 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.175.15])
        by linux.intel.com (Postfix) with ESMTP id A6EA6580C1F;
        Thu, 16 Mar 2023 15:46:28 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86/intel/vsec: Explicitly enable capabilities
Date:   Thu, 16 Mar 2023 15:46:28 -0700
Message-Id: <20230316224628.2855884-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

Discovered Intel VSEC/DVSEC capabilities are enabled by default and only
get disabled by quirk. Instead, remove such quirks and only enable support
for capabilities that have been explicitly added to a new capabilities
field. While here, also reorder the device info structures alphabetically.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 69 ++++++++++++++-----------------
 drivers/platform/x86/intel/vsec.h |  9 +++-
 2 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 13decf36c6de..01b1f6480e5c 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -67,14 +67,6 @@ enum intel_vsec_id {
 	VSEC_ID_TPMI		= 66,
 };
 
-static enum intel_vsec_id intel_vsec_allow_list[] = {
-	VSEC_ID_TELEMETRY,
-	VSEC_ID_WATCHER,
-	VSEC_ID_CRASHLOG,
-	VSEC_ID_SDSI,
-	VSEC_ID_TPMI,
-};
-
 static const char *intel_vsec_name(enum intel_vsec_id id)
 {
 	switch (id) {
@@ -98,26 +90,19 @@ static const char *intel_vsec_name(enum intel_vsec_id id)
 	}
 }
 
-static bool intel_vsec_allowed(u16 id)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(intel_vsec_allow_list); i++)
-		if (intel_vsec_allow_list[i] == id)
-			return true;
-
-	return false;
-}
-
-static bool intel_vsec_disabled(u16 id, unsigned long quirks)
+static bool intel_vsec_supported(u16 id, unsigned long caps)
 {
 	switch (id) {
+	case VSEC_ID_TELEMETRY:
+		return !!(caps & VSEC_CAP_TELEMETRY);
 	case VSEC_ID_WATCHER:
-		return !!(quirks & VSEC_QUIRK_NO_WATCHER);
-
+		return !!(caps & VSEC_CAP_WATCHER);
 	case VSEC_ID_CRASHLOG:
-		return !!(quirks & VSEC_QUIRK_NO_CRASHLOG);
-
+		return !!(caps & VSEC_CAP_CRASHLOG);
+	case VSEC_ID_SDSI:
+		return !!(caps & VSEC_CAP_SDSI);
+	case VSEC_ID_TPMI:
+		return !!(caps & VSEC_CAP_TPMI);
 	default:
 		return false;
 	}
@@ -205,7 +190,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	unsigned long quirks = info->quirks;
 	int i;
 
-	if (!intel_vsec_allowed(header->id) || intel_vsec_disabled(header->id, quirks))
+	if (!intel_vsec_supported(header->id, info->caps))
 		return -EINVAL;
 
 	if (!header->num_entries) {
@@ -260,14 +245,14 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 static bool intel_vsec_walk_header(struct pci_dev *pdev,
 				   struct intel_vsec_platform_info *info)
 {
-	struct intel_vsec_header **header = info->capabilities;
+	struct intel_vsec_header **header = info->headers;
 	bool have_devices = false;
 	int ret;
 
 	for ( ; *header; header++) {
 		ret = intel_vsec_add_dev(pdev, *header, info);
 		if (ret)
-			dev_info(&pdev->dev, "Could not add device for DVSEC id %d\n",
+			dev_info(&pdev->dev, "Could not add device for VSEC id %d\n",
 				 (*header)->id);
 		else
 			have_devices = true;
@@ -402,14 +387,8 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 	return 0;
 }
 
-/* TGL info */
-static const struct intel_vsec_platform_info tgl_info = {
-	.quirks = VSEC_QUIRK_NO_WATCHER | VSEC_QUIRK_NO_CRASHLOG |
-		  VSEC_QUIRK_TABLE_SHIFT | VSEC_QUIRK_EARLY_HW,
-};
-
 /* DG1 info */
-static struct intel_vsec_header dg1_telemetry = {
+static struct intel_vsec_header dg1_header = {
 	.length = 0x10,
 	.id = 2,
 	.num_entries = 1,
@@ -418,19 +397,31 @@ static struct intel_vsec_header dg1_telemetry = {
 	.offset = 0x466000,
 };
 
-static struct intel_vsec_header *dg1_capabilities[] = {
-	&dg1_telemetry,
+static struct intel_vsec_header *dg1_headers[] = {
+	&dg1_header,
 	NULL
 };
 
 static const struct intel_vsec_platform_info dg1_info = {
-	.capabilities = dg1_capabilities,
+	.caps = VSEC_CAP_TELEMETRY,
+	.headers = dg1_headers,
 	.quirks = VSEC_QUIRK_NO_DVSEC | VSEC_QUIRK_EARLY_HW,
 };
 
 /* MTL info */
 static const struct intel_vsec_platform_info mtl_info = {
-	.quirks = VSEC_QUIRK_NO_WATCHER | VSEC_QUIRK_NO_CRASHLOG,
+	.caps = VSEC_CAP_TELEMETRY,
+};
+
+/* OOBMSM info */
+static const struct intel_vsec_platform_info oobmsm_info = {
+	.caps = VSEC_CAP_TELEMETRY | VSEC_CAP_SDSI | VSEC_CAP_TPMI,
+};
+
+/* TGL info */
+static const struct intel_vsec_platform_info tgl_info = {
+	.caps = VSEC_CAP_TELEMETRY,
+	.quirks = VSEC_QUIRK_TABLE_SHIFT | VSEC_QUIRK_EARLY_HW,
 };
 
 #define PCI_DEVICE_ID_INTEL_VSEC_ADL		0x467d
@@ -445,7 +436,7 @@ static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_MTL_M, &mtl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_MTL_S, &mtl_info) },
-	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &(struct intel_vsec_platform_info) {}) },
+	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &oobmsm_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_RPL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
 	{ }
diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index ae8fe92c5595..0fd042c171ba 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -5,6 +5,12 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/bits.h>
 
+#define VSEC_CAP_TELEMETRY	BIT(0)
+#define VSEC_CAP_WATCHER	BIT(1)
+#define VSEC_CAP_CRASHLOG	BIT(2)
+#define VSEC_CAP_SDSI		BIT(3)
+#define VSEC_CAP_TPMI		BIT(4)
+
 struct pci_dev;
 struct resource;
 
@@ -27,7 +33,8 @@ enum intel_vsec_quirks {
 
 /* Platform specific data */
 struct intel_vsec_platform_info {
-	struct intel_vsec_header **capabilities;
+	struct intel_vsec_header **headers;
+	unsigned long caps;
 	unsigned long quirks;
 };
 

base-commit: 02c464b73645404654359ad21f368a13735e2850
-- 
2.34.1

