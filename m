Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E12C6BBC25
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjCOSeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjCOSeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:34:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F32ABDFB;
        Wed, 15 Mar 2023 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905250; x=1710441250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+M93RTmQljP8okVyTKg1YF0nbH2IJeJvC34zMCSMUuA=;
  b=TeS5Z0iIqGhZf5RvX8zIjroIlUrGZBp2uqc04cnbhLb927eF43az2FnC
   C8GKS6SoULy8tw2odpCVRPoNUrsqhRsW9UEiCfHjEfvybO/Os14ERmhhm
   M9RIkztLfrZt70nhY390B7iIZAt/5SsPzuUJeV0kHJbjPsgditShelh7w
   eh4bP6WbttxnZRUKQ8vA5mP3ksJ/oCfye6sb9cK2zILibIpZFVz7f1K1b
   Mg2CMmkexHJBGM3euRsgaSXbFZR+5FudFzQnRAIJrpR3cYTPps0FVikCD
   KiduWAbybgQTCGeWPla7xVCLp8bvlfi2LU2dmV6p9a8Po+pZJogaqUP2G
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340154528"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340154528"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:34:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925435202"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925435202"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:34:06 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.75.205])
        by linux.intel.com (Postfix) with ESMTP id A01C5580D29;
        Wed, 15 Mar 2023 11:34:06 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com, rajvi.jingar@linux.intel.com,
        xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 02/11] platform/x86/intel/vsec: Explicitly enable capabilities
Date:   Wed, 15 Mar 2023 11:33:56 -0700
Message-Id: <20230315183405.2465630-3-david.e.box@linux.intel.com>
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

Any discovered Intel VSEC/DVSEC capabilities are enabled by default and
only get disabled by quirk. Instead, remove such quirks and only enable
support for capabilities that have been explicitly added to a new
capabilities field. While here, also reorder the device info structures
alphabetically.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 65 +++++++++++++------------------
 drivers/platform/x86/intel/vsec.h | 11 +++++-
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index a22354ee6ce3..0d5cf250e288 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -32,14 +32,6 @@ static DEFINE_IDA(intel_vsec_ida);
 static DEFINE_IDA(intel_vsec_sdsi_ida);
 static DEFINE_XARRAY_ALLOC(auxdev_array);
 
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
@@ -63,26 +55,19 @@ static const char *intel_vsec_name(enum intel_vsec_id id)
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
@@ -170,7 +155,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	unsigned long quirks = info->quirks;
 	int i;
 
-	if (!intel_vsec_allowed(header->id) || intel_vsec_disabled(header->id, quirks))
+	if (!intel_vsec_supported(header->id, info->caps))
 		return -EINVAL;
 
 	if (!header->num_entries) {
@@ -234,14 +219,14 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
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
@@ -386,12 +371,6 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 	return 0;
 }
 
-/* TGL info */
-static const struct intel_vsec_platform_info tgl_info = {
-	.quirks = VSEC_QUIRK_NO_WATCHER | VSEC_QUIRK_NO_CRASHLOG |
-		  VSEC_QUIRK_TABLE_SHIFT | VSEC_QUIRK_EARLY_HW,
-};
-
 /* DG1 info */
 static struct intel_vsec_header dg1_telemetry = {
 	.length = 0x10,
@@ -402,19 +381,31 @@ static struct intel_vsec_header dg1_telemetry = {
 	.offset = 0x466000,
 };
 
-static struct intel_vsec_header *dg1_capabilities[] = {
+static struct intel_vsec_header *dg1_headers[] = {
 	&dg1_telemetry,
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
@@ -429,7 +420,7 @@ static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_MTL_M, &mtl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_MTL_S, &mtl_info) },
-	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &(struct intel_vsec_platform_info) {}) },
+	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &oobmsm_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_RPL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
 	{ }
diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index f600d6fe0830..54fdea93f762 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -61,9 +61,18 @@ enum intel_vsec_quirks {
 	VSEC_QUIRK_EARLY_HW     = BIT(4),
 };
 
+enum intel_vsec_capabilities {
+	VSEC_CAP_TELEMETRY	= BIT(0),
+	VSEC_CAP_WATCHER	= BIT(1),
+	VSEC_CAP_CRASHLOG	= BIT(2),
+	VSEC_CAP_SDSI		= BIT(3),
+	VSEC_CAP_TPMI		= BIT(4),
+};
+
 /* Platform specific data */
 struct intel_vsec_platform_info {
-	struct intel_vsec_header **capabilities;
+	struct intel_vsec_header **headers;
+	unsigned long caps;
 	unsigned long quirks;
 };
 
-- 
2.34.1

