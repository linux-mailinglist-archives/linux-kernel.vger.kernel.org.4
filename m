Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820C56AFF69
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCHHGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCHHGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:06:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A091FA2F1C;
        Tue,  7 Mar 2023 23:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678259205; x=1709795205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z04W7IK3HWPevOQCOCC1nmevtDlBplawxogbGdCtTYc=;
  b=Woz/7CRPFEZTjN/InVcQr5EfK3qyNMvpvG/tP8m7m5WcOjLNQLH6eMYD
   X39k5YaUrl6jHnytW2t+af6FZjDNSl+/DlFPSK9lvLUNvEiKtKZU2iB7j
   YHQc4Cwfnq5W5XEhD4mIZmM3g2x9wqBrIL6CGpejiCSL+5hgDUX2oBK9q
   Q4hHwWvxzzOPtPk3RGcXhnVuQnZV1qlHeNuj9wOjA4S6hVXhcrc8nrKkb
   OZRfHWHgBSRoDfmLwkmXNYKDKYr6k8SGCX9Uxh1yX3dF9nu551piZmHmB
   o2hITVmPT+CFIWBwGN3kXBCV3MmJYlaQVkaiT8XPXTE+DSNylOL6BgJKI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333553971"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="333553971"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 23:06:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="850986380"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="850986380"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2023 23:06:43 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Pragya Tanwar <pragya.tanwar@intel.com>
Subject: [PATCH v2 2/8] platform/x86: ISST: Enumerate TPMI SST and create framework
Date:   Tue,  7 Mar 2023 23:06:36 -0800
Message-Id: <20230308070642.1727167-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230308070642.1727167-1-srinivas.pandruvada@linux.intel.com>
References: <20230308070642.1727167-1-srinivas.pandruvada@linux.intel.com>
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

Enumerate TPMI SST driver and create basic framework to add more
features.

The basic user space interface is still same as the legacy using
/dev/isst_interface. Users of "intel-speed-select" utility should
be able to use same commands as prior gens without being aware
of new underlying hardware interface.

TPMI SST driver enumerates on device "intel_vsec.tpmi-sst". Since there
can be multiple instances and there is one common SST core, split
implementation into two parts: A common core part and an enumeration
part. The enumeration driver is loaded for each device instance and
register with the TPMI SST core driver.

On very first enumeration the TPMI SST core driver register with SST
core driver to get IOCTL callbacks. The api_version is incremented
for IOCTL ISST_IF_GET_PLATFORM_INFO, so that user space can issue
new IOCTLs.

Each TPMI package contains multiple power domains. Each power domain
has its own set of SST controls. For each domain map the MMIO memory
and update per domain struct tpmi_per_power_domain_info. This information
will be used to implement other SST interfaces.

Implement first IOCTL commands to get number of TPMI SST instances
and instance mask as some of the power domains may not have any
SST controls.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Pragya Tanwar <pragya.tanwar@intel.com>
---
v2:
No change

 .../x86/intel/speed_select_if/Kconfig         |   4 +
 .../x86/intel/speed_select_if/Makefile        |   2 +
 .../x86/intel/speed_select_if/isst_tpmi.c     |  53 ++++
 .../intel/speed_select_if/isst_tpmi_core.c    | 274 ++++++++++++++++++
 .../intel/speed_select_if/isst_tpmi_core.h    |  16 +
 include/uapi/linux/isst_if.h                  |  18 ++
 6 files changed, 367 insertions(+)
 create mode 100644 drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
 create mode 100644 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
 create mode 100644 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h

diff --git a/drivers/platform/x86/intel/speed_select_if/Kconfig b/drivers/platform/x86/intel/speed_select_if/Kconfig
index ce3e3dc076d2..4eb3ad299db0 100644
--- a/drivers/platform/x86/intel/speed_select_if/Kconfig
+++ b/drivers/platform/x86/intel/speed_select_if/Kconfig
@@ -2,8 +2,12 @@ menu "Intel Speed Select Technology interface support"
 	depends on PCI
 	depends on X86_64 || COMPILE_TEST
 
+config INTEL_SPEED_SELECT_TPMI
+	tristate
+
 config INTEL_SPEED_SELECT_INTERFACE
 	tristate "Intel(R) Speed Select Technology interface drivers"
+	select INTEL_SPEED_SELECT_TPMI if INTEL_TPMI
 	help
 	  This config enables the Intel(R) Speed Select Technology interface
 	  drivers. The Intel(R) speed select technology features are non
diff --git a/drivers/platform/x86/intel/speed_select_if/Makefile b/drivers/platform/x86/intel/speed_select_if/Makefile
index 856076206f35..1d878a36d0ab 100644
--- a/drivers/platform/x86/intel/speed_select_if/Makefile
+++ b/drivers/platform/x86/intel/speed_select_if/Makefile
@@ -8,3 +8,5 @@ obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_common.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_mmio.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_mbox_pci.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_mbox_msr.o
+obj-$(CONFIG_INTEL_SPEED_SELECT_TPMI) += isst_tpmi_core.o
+obj-$(CONFIG_INTEL_SPEED_SELECT_TPMI) += isst_tpmi.o
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
new file mode 100644
index 000000000000..7b4bdeefb8bc
--- /dev/null
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * isst_tpmi.c: SST TPMI interface
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ * All Rights Reserved.
+ *
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/module.h>
+#include <linux/intel_tpmi.h>
+
+#include "isst_tpmi_core.h"
+
+static int intel_sst_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
+{
+	int ret;
+
+	ret = tpmi_sst_init();
+	if (ret)
+		return ret;
+
+	ret = tpmi_sst_dev_add(auxdev);
+	if (ret)
+		tpmi_sst_exit();
+
+	return ret;
+}
+
+static void intel_sst_remove(struct auxiliary_device *auxdev)
+{
+	tpmi_sst_dev_remove(auxdev);
+	tpmi_sst_exit();
+}
+
+static const struct auxiliary_device_id intel_sst_id_table[] = {
+	{ .name = "intel_vsec.tpmi-sst" },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, intel_sst_id_table);
+
+static struct auxiliary_driver intel_sst_aux_driver = {
+	.id_table       = intel_sst_id_table,
+	.remove         = intel_sst_remove,
+	.probe          = intel_sst_probe,
+};
+
+module_auxiliary_driver(intel_sst_aux_driver);
+
+MODULE_IMPORT_NS(INTEL_TPMI_SST);
+MODULE_DESCRIPTION("Intel TPMI SST Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
new file mode 100644
index 000000000000..6b37016c0417
--- /dev/null
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * isst_tpmi.c: SST TPMI interface core
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * This information will be useful to understand flows:
+ * In the current generation of platforms, TPMI is supported via OOB
+ * PCI device. This PCI device has one instance per CPU package.
+ * There is a unique TPMI ID for SST. Each TPMI ID also has multiple
+ * entries, representing per power domain information.
+ *
+ * There is one dev file for complete SST information and control same as the
+ * prior generation of hardware. User spaces don't need to know how the
+ * information is presented by the hardware. The TPMI core module implements
+ * the hardware mapping.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/intel_tpmi.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <uapi/linux/isst_if.h>
+
+#include "isst_tpmi_core.h"
+#include "isst_if_common.h"
+
+/**
+ * struct tpmi_per_power_domain_info -	Store per power_domain SST info
+ * @package_id:		Package id for this power_domain
+ * @power_domain_id:	Power domain id, Each entry from the SST-TPMI instance is a power_domain.
+ * @sst_base:		Mapped SST base IO memory
+ * @auxdev:		Auxiliary device instance enumerated this instance
+ *
+ * This structure is used store complete SST information for a power_domain. This information
+ * is used to read/write request for any SST IOCTL. Each physical CPU package can have multiple
+ * power_domains. Each power domain describes its own SST information and has its own controls.
+ */
+struct tpmi_per_power_domain_info {
+	int package_id;
+	int power_domain_id;
+	void __iomem *sst_base;
+	struct auxiliary_device *auxdev;
+};
+
+/**
+ * struct tpmi_sst_struct -	Store sst info for a package
+ * @package_id:			Package id for this aux device instance
+ * @number_of_power_domains:	Number of power_domains pointed by power_domain_info pointer
+ * @power_domain_info:		Pointer to power domains information
+ *
+ * This structure is used store full SST information for a package.
+ * Each package has a unique OOB PCI device, which enumerates TPMI.
+ * Each Package will have multiple power_domains.
+ */
+struct tpmi_sst_struct {
+	int package_id;
+	int number_of_power_domains;
+	struct tpmi_per_power_domain_info *power_domain_info;
+};
+
+/**
+ * struct tpmi_sst_common_struct -	Store all SST instances
+ * @max_index:		Maximum instances currently present
+ * @sst_inst:		Pointer to per package instance
+ *
+ * Stores every SST Package instance.
+ */
+struct tpmi_sst_common_struct {
+	int max_index;
+	struct tpmi_sst_struct **sst_inst;
+};
+
+/*
+ * Each IOCTL request is processed under this lock. Also used to protect
+ * registration functions and common data structures.
+ */
+static DEFINE_MUTEX(isst_tpmi_dev_lock);
+
+/* Usage count to track, number of TPMI SST instances registered to this core. */
+static int isst_core_usage_count;
+
+/* Stores complete SST information for every package and power_domain */
+static struct tpmi_sst_common_struct isst_common;
+
+static int isst_if_get_tpmi_instance_count(void __user *argp)
+{
+	struct isst_tpmi_instance_count tpmi_inst;
+	struct tpmi_sst_struct *sst_inst;
+	int i;
+
+	if (copy_from_user(&tpmi_inst, argp, sizeof(tpmi_inst)))
+		return -EFAULT;
+
+	if (tpmi_inst.socket_id >= topology_max_packages())
+		return -EINVAL;
+
+	tpmi_inst.count = isst_common.sst_inst[tpmi_inst.socket_id]->number_of_power_domains;
+
+	sst_inst = isst_common.sst_inst[tpmi_inst.socket_id];
+	tpmi_inst.valid_mask = 0;
+	for (i = 0; i < sst_inst->number_of_power_domains; ++i) {
+		struct tpmi_per_power_domain_info *power_domain_info;
+
+		power_domain_info = &sst_inst->power_domain_info[i];
+		if (power_domain_info->sst_base)
+			tpmi_inst.valid_mask |= BIT(i);
+	}
+
+	if (copy_to_user(argp, &tpmi_inst, sizeof(tpmi_inst)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	long ret = -ENOTTY;
+
+	mutex_lock(&isst_tpmi_dev_lock);
+	switch (cmd) {
+	case ISST_IF_COUNT_TPMI_INSTANCES:
+		ret = isst_if_get_tpmi_instance_count(argp);
+		break;
+	default:
+		break;
+	}
+	mutex_unlock(&isst_tpmi_dev_lock);
+
+	return ret;
+}
+
+int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
+{
+	struct intel_tpmi_plat_info *plat_info;
+	struct tpmi_sst_struct *tpmi_sst;
+	int i, pkg = 0, inst = 0;
+	int num_resources;
+
+	plat_info = tpmi_get_platform_data(auxdev);
+	if (!plat_info) {
+		dev_err(&auxdev->dev, "No platform info\n");
+		return -EINVAL;
+	}
+
+	pkg = plat_info->package_id;
+	if (pkg >= topology_max_packages()) {
+		dev_err(&auxdev->dev, "Invalid package id :%x\n", pkg);
+		return -EINVAL;
+	}
+
+	if (isst_common.sst_inst[pkg])
+		return -EEXIST;
+
+	num_resources = tpmi_get_resource_count(auxdev);
+
+	if (!num_resources)
+		return -EINVAL;
+
+	tpmi_sst = devm_kzalloc(&auxdev->dev, sizeof(*tpmi_sst), GFP_KERNEL);
+	if (!tpmi_sst)
+		return -ENOMEM;
+
+	tpmi_sst->power_domain_info = devm_kcalloc(&auxdev->dev, num_resources,
+						   sizeof(*tpmi_sst->power_domain_info),
+						   GFP_KERNEL);
+	if (!tpmi_sst->power_domain_info)
+		return -ENOMEM;
+
+	tpmi_sst->number_of_power_domains = num_resources;
+
+	for (i = 0; i < num_resources; ++i) {
+		struct resource *res;
+
+		res = tpmi_get_resource_at_index(auxdev, i);
+		if (!res) {
+			tpmi_sst->power_domain_info[i].sst_base = NULL;
+			continue;
+		}
+
+		tpmi_sst->power_domain_info[i].package_id = pkg;
+		tpmi_sst->power_domain_info[i].power_domain_id = i;
+		tpmi_sst->power_domain_info[i].auxdev = auxdev;
+		tpmi_sst->power_domain_info[i].sst_base = devm_ioremap_resource(&auxdev->dev, res);
+		if (IS_ERR(tpmi_sst->power_domain_info[i].sst_base))
+			return PTR_ERR(tpmi_sst->power_domain_info[i].sst_base);
+
+		++inst;
+	}
+
+	if (!inst)
+		return -ENODEV;
+
+	tpmi_sst->package_id = pkg;
+	auxiliary_set_drvdata(auxdev, tpmi_sst);
+
+	mutex_lock(&isst_tpmi_dev_lock);
+	if (isst_common.max_index < pkg)
+		isst_common.max_index = pkg;
+	isst_common.sst_inst[pkg] = tpmi_sst;
+	mutex_unlock(&isst_tpmi_dev_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_add, INTEL_TPMI_SST);
+
+void tpmi_sst_dev_remove(struct auxiliary_device *auxdev)
+{
+	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
+
+	mutex_lock(&isst_tpmi_dev_lock);
+	isst_common.sst_inst[tpmi_sst->package_id] = NULL;
+	mutex_unlock(&isst_tpmi_dev_lock);
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_remove, INTEL_TPMI_SST);
+
+#define ISST_TPMI_API_VERSION	0x02
+
+int tpmi_sst_init(void)
+{
+	struct isst_if_cmd_cb cb;
+	int ret = 0;
+
+	mutex_lock(&isst_tpmi_dev_lock);
+
+	if (isst_core_usage_count) {
+		++isst_core_usage_count;
+		goto init_done;
+	}
+
+	isst_common.sst_inst = kcalloc(topology_max_packages(),
+				       sizeof(*isst_common.sst_inst),
+				       GFP_KERNEL);
+	if (!isst_common.sst_inst)
+		return -ENOMEM;
+
+	memset(&cb, 0, sizeof(cb));
+	cb.cmd_size = sizeof(struct isst_if_io_reg);
+	cb.offset = offsetof(struct isst_if_io_regs, io_reg);
+	cb.cmd_callback = NULL;
+	cb.api_version = ISST_TPMI_API_VERSION;
+	cb.def_ioctl = isst_if_def_ioctl;
+	cb.owner = THIS_MODULE;
+	ret = isst_if_cdev_register(ISST_IF_DEV_TPMI, &cb);
+	if (ret)
+		kfree(isst_common.sst_inst);
+init_done:
+	mutex_unlock(&isst_tpmi_dev_lock);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_sst_init, INTEL_TPMI_SST);
+
+void tpmi_sst_exit(void)
+{
+	mutex_lock(&isst_tpmi_dev_lock);
+	if (isst_core_usage_count)
+		--isst_core_usage_count;
+
+	if (!isst_core_usage_count) {
+		isst_if_cdev_unregister(ISST_IF_DEV_TPMI);
+		kfree(isst_common.sst_inst);
+	}
+	mutex_unlock(&isst_tpmi_dev_lock);
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_sst_exit, INTEL_TPMI_SST);
+
+MODULE_IMPORT_NS(INTEL_TPMI);
+MODULE_IMPORT_NS(INTEL_TPMI_POWER_DOMAIN);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
new file mode 100644
index 000000000000..356cb02273b1
--- /dev/null
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Intel Speed Select Interface: Drivers Internal defines
+ * Copyright (c) 2023, Intel Corporation.
+ * All rights reserved.
+ *
+ */
+
+#ifndef _ISST_TPMI_CORE_H
+#define _ISST_TPMI_CORE_H
+
+int tpmi_sst_init(void);
+void tpmi_sst_exit(void);
+int tpmi_sst_dev_add(struct auxiliary_device *auxdev);
+void tpmi_sst_dev_remove(struct auxiliary_device *auxdev);
+#endif
diff --git a/include/uapi/linux/isst_if.h b/include/uapi/linux/isst_if.h
index ba078f8e9add..bf32d959f6e8 100644
--- a/include/uapi/linux/isst_if.h
+++ b/include/uapi/linux/isst_if.h
@@ -163,10 +163,28 @@ struct isst_if_msr_cmds {
 	struct isst_if_msr_cmd msr_cmd[1];
 };
 
+/**
+ * struct isst_tpmi_instance_count - Get number of TPMI instances per socket
+ * @socket_id:	Socket/package id
+ * @count:	Number of instances
+ * @valid_mask: Mask of instances as there can be holes
+ *
+ * Structure used to get TPMI instances information using
+ * IOCTL ISST_IF_COUNT_TPMI_INSTANCES.
+ */
+struct isst_tpmi_instance_count {
+	__u8 socket_id;
+	__u8 count;
+	__u16 valid_mask;
+};
+
 #define ISST_IF_MAGIC			0xFE
 #define ISST_IF_GET_PLATFORM_INFO	_IOR(ISST_IF_MAGIC, 0, struct isst_if_platform_info *)
 #define ISST_IF_GET_PHY_ID		_IOWR(ISST_IF_MAGIC, 1, struct isst_if_cpu_map *)
 #define ISST_IF_IO_CMD		_IOW(ISST_IF_MAGIC, 2, struct isst_if_io_regs *)
 #define ISST_IF_MBOX_COMMAND	_IOWR(ISST_IF_MAGIC, 3, struct isst_if_mbox_cmds *)
 #define ISST_IF_MSR_COMMAND	_IOWR(ISST_IF_MAGIC, 4, struct isst_if_msr_cmds *)
+
+#define ISST_IF_COUNT_TPMI_INSTANCES	_IOR(ISST_IF_MAGIC, 5, struct isst_tpmi_instance_count *)
+
 #endif
-- 
2.34.1

