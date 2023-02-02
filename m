Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD966872D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjBBBJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBBBJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:09:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12439976B;
        Wed,  1 Feb 2023 17:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675300143; x=1706836143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8OTCFgot6YtkvyOUn1WN3r4ERlKA92jPkF4SlfqW0C8=;
  b=IwlfkfPNOzvHaRuuKutxsyaK9oSWrGoYhrF05XDuMaCAZTYSoOgWVmk7
   9NJNWviU/GbUV5oMuzb3jHhJL2lZ78HMyrNPDiY4h2Qo01e6lR4jrkOvK
   fs3FZlamb3WA/O7wNt3ppeHo2GXmfkAcrMecZsNINXcMOVr4mausV8H7H
   ak+JHoALSbxV2iTDN+YITtODvmosXEmoVRNzLE83OTllroIwojmH5i8Ue
   Kf1/YBOWx/HSMbavs+003EMpJqRdBkXCmRL12I4kKh2Sen9yJNn+zaTuM
   /lciBTNOUBnmg5p/iYHHve5/4aacPqP/rZLRoZUD5NJqIB+f9c0mG6Xo9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355654314"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="355654314"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665087930"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="665087930"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 17:08:15 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4/7] platform/x86/intel: Intel TPMI enumeration driver
Date:   Wed,  1 Feb 2023 17:07:35 -0800
Message-Id: <20230202010738.2186174-5-srinivas.pandruvada@linux.intel.com>
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

The TPMI (Topology Aware Register and PM Capsule Interface) provides a
flexible, extendable and PCIe enumerable MMIO interface for PM features.

For example Intel RAPL (Running Average Power Limit) provides a MMIO
interface using TPMI. This has advantage over traditional MSR
(Model Specific Register) interface, where a thread needs to be scheduled
on the target CPU to read or write. Also the RAPL features vary between
CPU models, and hence lot of model specific code. Here TPMI provides an
architectural interface by providing hierarchical tables and fields,
which will not need any model specific implementation.

The TPMI interface uses a PCI VSEC structure to expose the location of
MMIO region.

This VSEC structure is present in the PCI configuration space of the
Intel Out-of-Band (OOB) device, which  is handled by the Intel VSEC
driver. The Intel VSEC driver parses VSEC structures present in the PCI
configuration space of the given device and creates an auxiliary device
object for each of them. In particular, it creates an auxiliary device
object representing TPMI that can be bound by an auxiliary driver.

Introduce a TPMI driver that will bind to the TPMI auxiliary device
object created by the Intel VSEC driver.

The TPMI specification defines a PFS (PM Feature Structure) table.
This table is present in the TPMI MMIO region. The starting address
of PFS is derived from the tBIR (Bar Indicator Register) and "Address"
field from the VSEC header.

Each TPMI PM feature has one entry in the PFS with a unique TPMI
ID and its access details. The TPMI driver creates device nodes
for the supported PM features.

The names of the devices created by the TPMI driver start with the
"intel_vsec.tpmi-" prefix which is followed by a specific name of the
given PM feature (for example, "intel_vsec.tpmi-rapl.0").

The device nodes are create by using interface "intel_vsec_add_aux()"
provided by the Intel VSEC driver.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel/Kconfig  |  13 ++
 drivers/platform/x86/intel/Makefile |   4 +
 drivers/platform/x86/intel/tpmi.c   | 321 ++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+)
 create mode 100644 drivers/platform/x86/intel/tpmi.c

diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index d5a33473e838..bbbd9e54e9ee 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -182,6 +182,19 @@ config INTEL_SMARTCONNECT
 	  This driver checks to determine whether the device has Intel Smart
 	  Connect enabled, and if so disables it.
 
+config INTEL_TPMI
+	tristate "Intel Topology Aware Register and PM Capsule Interface (TPMI)"
+	depends on INTEL_VSEC
+	depends on X86_64
+	help
+	  The Intel Topology Aware Register and PM Capsule Interface (TPMI),
+	  provides enumerable MMIO interface for power management features.
+	  This driver creates devices, so that other PM feature driver can
+	  be loaded for PM specific feature operation.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel_vsec_tpmi.
+
 config INTEL_TURBO_MAX_3
 	bool "Intel Turbo Boost Max Technology 3.0 enumeration driver"
 	depends on X86_64 && SCHED_MC_PRIO
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 717933dd0cfd..411df4040427 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -47,6 +47,10 @@ obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 intel_punit_ipc-y			:= punit_ipc.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 
+# TPMI drivers
+intel_vsec_tpmi-y			:= tpmi.o
+obj-$(CONFIG_INTEL_TPMI)		+= intel_vsec_tpmi.o
+
 # Intel Uncore drivers
 intel-rst-y				:= rst.o
 obj-$(CONFIG_INTEL_RST)			+= intel-rst.o
diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
new file mode 100644
index 000000000000..1b87b46ba8a9
--- /dev/null
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * intel-tpmi : Driver to enumerate TPMI features and create devices
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * The TPMI (Topology Aware Register and PM Capsule Interface) provides a
+ * flexible, extendable and PCIe enumerable MMIO interface for PM features.
+ *
+ * For example Intel RAPL (Running Average Power Limit) provides a MMIO
+ * interface using TPMI. This has advantage over traditional MSR
+ * (Model Specific Register) interface, where a thread needs to be scheduled
+ * on the target CPU to read or write. Also the RAPL features vary between
+ * CPU models, and hence lot of model specific code. Here TPMI provides an
+ * architectural interface by providing hierarchical tables and fields,
+ * which will not need any model specific implementation.
+ *
+ * The TPMI interface uses a PCI VSEC structure to expose the location of
+ * MMIO region.
+ *
+ * This VSEC structure is present in the PCI configuration space of the
+ * Intel Out-of-Band (OOB) device, which  is handled by the Intel VSEC
+ * driver. The Intel VSEC driver parses VSEC structures present in the PCI
+ * configuration space of the given device and creates an auxiliary device
+ * object for each of them. In particular, it creates an auxiliary device
+ * object representing TPMI that can be bound by an auxiliary driver.
+ *
+ * This TPMI driver will bind to the TPMI auxiliary device object created
+ * by the Intel VSEC driver.
+ *
+ * The TPMI specification defines a PFS (PM Feature Structure) table.
+ * This table is present in the TPMI MMIO region. The starting address
+ * of PFS is derived from the tBIR (Bar Indicator Register) and "Address"
+ * field from the VSEC header.
+ *
+ * Each TPMI PM feature has one entry in the PFS with a unique TPMI
+ * ID and its access details. The TPMI driver creates device nodes
+ * for the supported PM features.
+ *
+ * The names of the devices created by the TPMI driver start with the
+ * "intel_vsec.tpmi-" prefix which is followed by a specific name of the
+ * given PM feature (for example, "intel_vsec.tpmi-rapl.0").
+ *
+ * The device nodes are create by using interface "intel_vsec_add_aux()"
+ * provided by the Intel VSEC driver.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "vsec.h"
+
+/**
+ * struct intel_tpmi_pfs_entry - TPMI PM Feature Structure (PFS) entry
+ * @tpmi_id:	TPMI feature identifier (what the feature is and its data format).
+ * @num_entries: Number of feature interface instances present in the PFS.
+ *		 This represents the maximum number of Power domains in the SoC.
+ * @entry_size:	Interface instance entry size in 32-bit words.
+ * @cap_offset:	Offset from the PM_Features base address to the base of the PM VSEC
+ *		register bank in KB.
+ * @attribute:	Feature attribute: 0=BIOS. 1=OS. 2-3=Reserved.
+ * @reserved:	Bits for use in the future.
+ *
+ * Represents one TPMI feature entry data in the PFS retrieved as is
+ * from the hardware.
+ */
+struct intel_tpmi_pfs_entry {
+	u64 tpmi_id:8;
+	u64 num_entries:8;
+	u64 entry_size:16;
+	u64 cap_offset:16;
+	u64 attribute:2;
+	u64 reserved:14;
+} __packed;
+
+/**
+ * struct intel_tpmi_pm_feature - TPMI PM Feature information for a TPMI ID
+ * @pfs_header:	PFS header retireved from the hardware.
+ * @vsec_offset: Starting MMIO address for this feature in bytes. Essentially
+ *		 this offset = "Address" from VSEC header + PFS Capability
+ *		 offset for this feature entry.
+ *
+ * Represents TPMI instance information for one TPMI ID.
+ */
+struct intel_tpmi_pm_feature {
+	struct intel_tpmi_pfs_entry pfs_header;
+	unsigned int vsec_offset;
+};
+
+/**
+ * struct intel_tpmi_info - TPMI information for all IDs in an instance
+ * @tpmi_features:	Pointer to a list of TPMI feature instances
+ * @vsec_dev:		Pointer to intel_vsec_device structure for this TPMI device
+ * @feature_count:	Number of TPMI of TPMI instances pointed by tpmi_features
+ * @pfs_start:		Start of PFS offset for the TPMI instances in this device
+ *
+ * Stores the information for all TPMI devices enumerated from a single PCI device.
+ */
+struct intel_tpmi_info {
+	struct intel_tpmi_pm_feature *tpmi_features;
+	struct intel_vsec_device *vsec_dev;
+	int feature_count;
+	u64 pfs_start;
+};
+
+/*
+ * List of supported TMPI IDs.
+ * Some TMPI IDs are not used by Linux, so the numbers are not consecutive.
+ */
+enum intel_tpmi_id {
+	TPMI_ID_RAPL = 0, /* Running Average Power Limit */
+	TPMI_ID_PEM = 1, /* Power and Perf excursion Monitor */
+	TPMI_ID_UNCORE = 2, /* Uncore Frequency Scaling */
+	TPMI_ID_SST = 5, /* Speed Select Technology */
+};
+
+/* Used during auxbus device creation */
+static DEFINE_IDA(intel_vsec_tpmi_ida);
+
+static const char *intel_tpmi_name(enum intel_tpmi_id id)
+{
+	switch (id) {
+	case TPMI_ID_RAPL:
+		return "rapl";
+	case TPMI_ID_PEM:
+		return "pem";
+	case TPMI_ID_UNCORE:
+		return "uncore";
+	case TPMI_ID_SST:
+		return "sst";
+	default:
+		return NULL;
+	}
+}
+
+/* String Length for tpmi-"feature_name(upto 8 bytes)" */
+#define TPMI_FEATURE_NAME_LEN	14
+
+static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
+			      struct intel_tpmi_pm_feature *pfs,
+			      u64 pfs_start)
+{
+	struct intel_vsec_device *vsec_dev = tpmi_info->vsec_dev;
+	char feature_id_name[TPMI_FEATURE_NAME_LEN];
+	struct intel_vsec_device *feature_vsec_dev;
+	struct resource *res, *tmp;
+	const char *name;
+	int ret, i;
+
+	name = intel_tpmi_name(pfs->pfs_header.tpmi_id);
+	if (!name)
+		return -EOPNOTSUPP;
+
+	feature_vsec_dev = kzalloc(sizeof(*feature_vsec_dev), GFP_KERNEL);
+	if (!feature_vsec_dev)
+		return -ENOMEM;
+
+	res = kcalloc(pfs->pfs_header.num_entries, sizeof(*res), GFP_KERNEL);
+	if (!res) {
+		ret = -ENOMEM;
+		goto free_vsec;
+	}
+
+	snprintf(feature_id_name, sizeof(feature_id_name), "tpmi-%s", name);
+
+	for (i = 0, tmp = res; i < pfs->pfs_header.num_entries; i++, tmp++) {
+		u64 entry_size_bytes = pfs->pfs_header.entry_size * 4;
+
+		tmp->start = pfs->vsec_offset + entry_size_bytes * i;
+		tmp->end = tmp->start + entry_size_bytes - 1;
+		tmp->flags = IORESOURCE_MEM;
+	}
+
+	feature_vsec_dev->pcidev = vsec_dev->pcidev;
+	feature_vsec_dev->resource = res;
+	feature_vsec_dev->num_resources = pfs->pfs_header.num_entries;
+	feature_vsec_dev->ida = &intel_vsec_tpmi_ida;
+
+	/*
+	 * intel_vsec_add_aux() is resource managed, no explicit
+	 * delete is required on error or on module unload.
+	 */
+	ret = intel_vsec_add_aux(vsec_dev->pcidev, &vsec_dev->auxdev.dev,
+				 feature_vsec_dev, feature_id_name);
+	if (ret)
+		goto free_res;
+
+	return 0;
+
+free_res:
+	kfree(res);
+free_vsec:
+	kfree(feature_vsec_dev);
+
+	return ret;
+}
+
+static int tpmi_create_devices(struct intel_tpmi_info *tpmi_info)
+{
+	struct intel_vsec_device *vsec_dev = tpmi_info->vsec_dev;
+	int ret, i;
+
+	for (i = 0; i < vsec_dev->num_resources; i++) {
+		ret = tpmi_create_device(tpmi_info, &tpmi_info->tpmi_features[i],
+					 tpmi_info->pfs_start);
+		/*
+		 * Fail, if the supported features fails to create device,
+		 * otherwise, continue. Even if one device failed to create,
+		 * fail the loading of driver. Since intel_vsec_add_aux()
+		 * is resource managed, no clean up is required for the
+		 * successfully created devices.
+		 */
+		if (ret && ret != -EOPNOTSUPP)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int tpmi_fetch_pfs_header(struct intel_tpmi_pm_feature *pfs, u64 start, int size)
+{
+	void __iomem *pfs_mem;
+
+	pfs_mem = ioremap(start, size);
+	if (!pfs_mem)
+		return -ENOMEM;
+
+	memcpy_fromio(&pfs->pfs_header, pfs_mem, sizeof(pfs->pfs_header));
+
+	iounmap(pfs_mem);
+
+	return 0;
+}
+
+static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
+{
+	struct intel_vsec_device *vsec_dev = auxdev_to_ivdev(auxdev);
+	struct intel_tpmi_info *tpmi_info;
+	u64 pfs_start = 0;
+	int i;
+
+	tpmi_info = devm_kzalloc(&auxdev->dev, sizeof(*tpmi_info), GFP_KERNEL);
+	if (!tpmi_info)
+		return -ENOMEM;
+
+	tpmi_info->vsec_dev = vsec_dev;
+	tpmi_info->feature_count = vsec_dev->num_resources;
+
+	tpmi_info->tpmi_features = devm_kcalloc(&auxdev->dev, vsec_dev->num_resources,
+						sizeof(*tpmi_info->tpmi_features),
+						GFP_KERNEL);
+	if (!tpmi_info->tpmi_features)
+		return -ENOMEM;
+
+	for (i = 0; i < vsec_dev->num_resources; i++) {
+		struct intel_tpmi_pm_feature *pfs;
+		struct resource *res;
+		u64 res_start;
+		int size, ret;
+
+		pfs = &tpmi_info->tpmi_features[i];
+
+		res = &vsec_dev->resource[i];
+		if (!res)
+			continue;
+
+		res_start = res->start;
+		size = resource_size(res);
+		if (size < 0)
+			continue;
+
+		ret = tpmi_fetch_pfs_header(pfs, res_start, size);
+		if (ret)
+			continue;
+
+		if (!pfs_start)
+			pfs_start = res_start;
+
+		pfs->pfs_header.cap_offset *= 1024;
+
+		pfs->vsec_offset = pfs_start + pfs->pfs_header.cap_offset;
+	}
+
+	tpmi_info->pfs_start = pfs_start;
+
+	auxiliary_set_drvdata(auxdev, tpmi_info);
+
+	return tpmi_create_devices(tpmi_info);
+}
+
+static int tpmi_probe(struct auxiliary_device *auxdev,
+		      const struct auxiliary_device_id *id)
+{
+	return intel_vsec_tpmi_init(auxdev);
+}
+
+/*
+ * Remove callback is not needed currently as there is no
+ * cleanup required. All memory allocs are device managed. All
+ * devices created by this modules are also device managed.
+ */
+
+static const struct auxiliary_device_id tpmi_id_table[] = {
+	{ .name = "intel_vsec.tpmi" },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, tpmi_id_table);
+
+static struct auxiliary_driver tpmi_aux_driver = {
+	.id_table	= tpmi_id_table,
+	.probe		= tpmi_probe,
+};
+
+module_auxiliary_driver(tpmi_aux_driver);
+
+MODULE_IMPORT_NS(INTEL_VSEC);
+MODULE_DESCRIPTION("Intel TPMI enumeration module");
+MODULE_LICENSE("GPL");
-- 
2.31.1

