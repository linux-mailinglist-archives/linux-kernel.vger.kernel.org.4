Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FF56872D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBBBJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBBBJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:09:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B833F2A9;
        Wed,  1 Feb 2023 17:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675300144; x=1706836144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W9mXuUmIuslWBT27rQo8alF+yF0ZIU0Acn//rOj9SSc=;
  b=MbBslAigMaIQSHV3SsHLUVDQ0QEhHiNp/x9Hl08TmKlH2s7le61YW4ZQ
   JjS3ai1WWfErCYhqrVnW6NY5st8HwQ/VrWNkQuxlTV7V6zyWuGAhgAtKG
   MEBRgJng1KelTyz5qEynwNtVk5j8KsBEziZEjizEFw1bMdAuEX/CYSfJu
   RcGJdallCR+yhyY1GQYncHJeI5Zorm0IOVxLVfBD8S66GzRIzyRRdqoQf
   dEoUGh/kpRcXJMbL28nrZJKhwGiYQUy5P3pl3tWxHHDrIpTmehu9RktIg
   mwkQeKgc3a0pKSfGhQyw03lM7lHIsB5gUanSwj7iPqNYE+1U1Bt7tV7qg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355654317"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="355654317"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665087933"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="665087933"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 17:08:16 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5/7] platform/x86/intel/tpmi: Process CPU package mapping
Date:   Wed,  1 Feb 2023 17:07:36 -0800
Message-Id: <20230202010738.2186174-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
References: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one Intel Out-of-Band (OOB) PCI device per CPU package. Since
TPMI feature is exposed via OOB PCI device, there will be multiple
TPMI device instances on a multi CPU package system.

There are several PM features, which needs to associate APIC based CPU
package ID information to a TPMI instance. For example if Intel Speed
Select feature requires control of a CPU package, it needs to identify
right TPMI device instance.

There is one special TPMI ID (ID = 0x81) in the PFS. The MMIO
region of this TPMI ID points to a mapping table:
- PCI Bus ID
- PCI Device ID
- APIC based Package ID

This mapping information can be used by any PM feature driver which
requires mapping from a CPU package to a TPMI device instance.

Unlike other TPMI features, device node is not created for this feature
ID (0x81). Instead store the mapping information as platform data, which
is part of the per PCI device TPMI instance (struct intel_tpmi_info).
Later the TPMI feature drivers can get the mapping information using an
interface "tpmi_get_platform_data()"

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel/tpmi.c | 72 +++++++++++++++++++++++++++++++
 include/linux/intel_tpmi.h        | 28 ++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 include/linux/intel_tpmi.h

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 1b87b46ba8a9..e612da579b29 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -47,6 +47,7 @@
  */
 
 #include <linux/auxiliary_bus.h>
+#include <linux/intel_tpmi.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -96,6 +97,7 @@ struct intel_tpmi_pm_feature {
  * @vsec_dev:		Pointer to intel_vsec_device structure for this TPMI device
  * @feature_count:	Number of TPMI of TPMI instances pointed by tpmi_features
  * @pfs_start:		Start of PFS offset for the TPMI instances in this device
+ * @plat_info:		Stores platform info which can be used by the client drivers
  *
  * Stores the information for all TPMI devices enumerated from a single PCI device.
  */
@@ -104,8 +106,30 @@ struct intel_tpmi_info {
 	struct intel_vsec_device *vsec_dev;
 	int feature_count;
 	u64 pfs_start;
+	struct intel_tpmi_plat_info plat_info;
 };
 
+/**
+ * struct tpmi_info_header - CPU package ID to PCI device mapping information
+ * @fn:		PCI function number
+ * @dev:	PCI device number
+ * @bus:	PCI bus number
+ * @pkg:	CPU Package id
+ * @reserved:	Reserved for future use
+ * @lock:	When set to 1 the register is locked and becomes read-only
+ *		until next reset. Not for use by the OS driver.
+ *
+ * The structure to read hardware provided mapping information.
+ */
+struct tpmi_info_header {
+	u64 fn:3;
+	u64 dev:5;
+	u64 bus:8;
+	u64 pkg:8;
+	u64 reserved:39;
+	u64 lock:1;
+} __packed;
+
 /*
  * List of supported TMPI IDs.
  * Some TMPI IDs are not used by Linux, so the numbers are not consecutive.
@@ -115,11 +139,20 @@ enum intel_tpmi_id {
 	TPMI_ID_PEM = 1, /* Power and Perf excursion Monitor */
 	TPMI_ID_UNCORE = 2, /* Uncore Frequency Scaling */
 	TPMI_ID_SST = 5, /* Speed Select Technology */
+	TPMI_INFO_ID = 0x81, /* Special ID for PCI BDF and Package ID information */
 };
 
 /* Used during auxbus device creation */
 static DEFINE_IDA(intel_vsec_tpmi_ida);
 
+struct intel_tpmi_plat_info *tpmi_get_platform_data(struct auxiliary_device *auxdev)
+{
+	struct intel_vsec_device *vsec_dev = auxdev_to_ivdev(auxdev);
+
+	return vsec_dev->priv_data;
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_get_platform_data, INTEL_TPMI);
+
 static const char *intel_tpmi_name(enum intel_tpmi_id id)
 {
 	switch (id) {
@@ -177,6 +210,8 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
 	feature_vsec_dev->pcidev = vsec_dev->pcidev;
 	feature_vsec_dev->resource = res;
 	feature_vsec_dev->num_resources = pfs->pfs_header.num_entries;
+	feature_vsec_dev->priv_data = &tpmi_info->plat_info;
+	feature_vsec_dev->priv_data_size = sizeof(tpmi_info->plat_info);
 	feature_vsec_dev->ida = &intel_vsec_tpmi_ida;
 
 	/*
@@ -220,6 +255,31 @@ static int tpmi_create_devices(struct intel_tpmi_info *tpmi_info)
 	return 0;
 }
 
+#define TPMI_INFO_BUS_INFO_OFFSET	0x08
+
+static int tpmi_process_info(struct intel_tpmi_info *tpmi_info,
+			     struct intel_tpmi_pm_feature *pfs)
+{
+	struct tpmi_info_header header;
+	void __iomem *info_mem;
+
+	info_mem = ioremap(pfs->vsec_offset + TPMI_INFO_BUS_INFO_OFFSET,
+			   pfs->pfs_header.entry_size * 4 - TPMI_INFO_BUS_INFO_OFFSET);
+	if (!info_mem)
+		return -ENOMEM;
+
+	memcpy_fromio(&header, info_mem, sizeof(header));
+
+	tpmi_info->plat_info.package_id = header.pkg;
+	tpmi_info->plat_info.bus_number = header.bus;
+	tpmi_info->plat_info.device_number = header.dev;
+	tpmi_info->plat_info.function_number = header.fn;
+
+	iounmap(info_mem);
+
+	return 0;
+}
+
 static int tpmi_fetch_pfs_header(struct intel_tpmi_pm_feature *pfs, u64 start, int size)
 {
 	void __iomem *pfs_mem;
@@ -238,6 +298,7 @@ static int tpmi_fetch_pfs_header(struct intel_tpmi_pm_feature *pfs, u64 start, i
 static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 {
 	struct intel_vsec_device *vsec_dev = auxdev_to_ivdev(auxdev);
+	struct pci_dev *pci_dev = vsec_dev->pcidev;
 	struct intel_tpmi_info *tpmi_info;
 	u64 pfs_start = 0;
 	int i;
@@ -248,6 +309,7 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 
 	tpmi_info->vsec_dev = vsec_dev;
 	tpmi_info->feature_count = vsec_dev->num_resources;
+	tpmi_info->plat_info.bus_number = pci_dev->bus->number;
 
 	tpmi_info->tpmi_features = devm_kcalloc(&auxdev->dev, vsec_dev->num_resources,
 						sizeof(*tpmi_info->tpmi_features),
@@ -282,6 +344,16 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 		pfs->pfs_header.cap_offset *= 1024;
 
 		pfs->vsec_offset = pfs_start + pfs->pfs_header.cap_offset;
+
+		/*
+		 * Process TPMI_INFO to get PCI device to CPU package ID.
+		 * Device nodes for TPMI features are not created in this
+		 * for loop. So, the mapping information will be available
+		 * when actual device nodes created outside this
+		 * loop via tpmi_create_devices().
+		 */
+		if (pfs->pfs_header.tpmi_id == TPMI_INFO_ID)
+			tpmi_process_info(tpmi_info, pfs);
 	}
 
 	tpmi_info->pfs_start = pfs_start;
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
new file mode 100644
index 000000000000..5b665320ecb4
--- /dev/null
+++ b/include/linux/intel_tpmi.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * intel_tpmi.h: Intel TPMI core external interface
+ */
+
+#ifndef _INTEL_TPMI_H_
+#define _INTEL_TPMI_H_
+
+/**
+ * struct intel_tpmi_plat_info - Platform information for a TPMI device instance
+ * @package_id:	CPU Package id
+ * @bus_number:	PCI bus number
+ * @device_number: PCI device number
+ * @function_number: PCI function number
+ *
+ * Structure to store platform data for a TPMI device instance. This
+ * struct is used to return data via tpmi_get_platform_data().
+ */
+struct intel_tpmi_plat_info {
+	u8 package_id;
+	u8 bus_number;
+	u8 device_number;
+	u8 function_number;
+};
+
+struct intel_tpmi_plat_info *tpmi_get_platform_data(struct auxiliary_device *auxdev);
+
+#endif
-- 
2.31.1

