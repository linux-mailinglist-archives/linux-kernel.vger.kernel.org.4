Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1C46BD440
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjCPPoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjCPPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:43:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4420CD64E;
        Thu, 16 Mar 2023 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981380; x=1710517380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gk08OP3UytLpcfoh/8pSuEU7Qq14RVnbk23FVUYj0cw=;
  b=e0DDPynnEW5xJphPVRybVrlSRYMufkogq8g1/06eglh77h2eJoy3gXlA
   xFv0zRADKclQIZm9JPHKXZVevBLspefnOq4/M0bXxov0GEsF5o22BB+Uk
   CvO91W8IfALrXCTHB0pjANUuDECxPWFagL/2hcafdF6Df4pjStXYytpgO
   jXHXaSM00iZNcK34cl5R2uAsZJt337MJFwi3vnv1ZfEnRjygYOmBdlAo6
   HH+gKtHN2bAf77COl5BKD3bUFmojQbKrwroN5t/70zFpKZXjz3oLIgrOK
   5RsBfvNaTeiRF8JRIRZptcvloBRjUQE7/ctnxMQnaz3Iqin69s4trWO8w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339571113"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339571113"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009267243"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009267243"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:15 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 15/15] powercap/intel_rapl_tpmi: Introduce RAPL TPMI interface driver
Date:   Thu, 16 Mar 2023 23:38:41 +0800
Message-Id: <20230316153841.3666-16-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316153841.3666-1-rui.zhang@intel.com>
References: <20230316153841.3666-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TPMI (Topology Aware Register and PM Capsule Interface) provides a
flexible, extendable and PCIe enumerable MMIO interface for PM features.

Intel RAPL (Running Average Power Limit) is one of the features that
benefit from this. Using TPMI Interface has advantage over traditional MSR
(Model Specific Register) interface, where a thread needs to be scheduled
on the target CPU to read or write. Also the RAPL features vary between
CPU models, and hence lot of model specific code. Here TPMI provides an
architectural interface by providing hierarchical tables and fields,
which will not need any model specific implementation.

TPMI interface uses a PCI VSEC structure to expose the location of MMIO
interface for PM feature enumeration and control.

The Intel VSEC driver parses VSEC structures present in the PCI
configuration space of the given device and creates an auxiliary device
object for each of them. In particular, it creates an auxiliary device
object representing TPMI that can be bound to by an auxiliary driver.

Then the TPMI enumeration driver binds to the TPMI auxiliary device
object created by the Intel VSEC driver, parses the PM Feature Structure
(PFS) present in the TPMI MMIO region and creates device nodes for PM
features described in the PFS.

This RAPL TPMI Interface driver binds the RAPL auxiliary device created
by the TPMI enumeration driver and expose the RAPL control to userspace
via powercap sysfs class.

RAPL TPMI details are published in the following document:
https://github.com/intel/tpmi_power_management/blob/main/RAPL_TPMI_public_disclosure_FINAL.docx

Note, for now, the RAPL TPMI Interface and RAPL MSR Interface cannot
co-exists on the same platform (RAPL TPMI Interface is not supported on
any platforms in the CPU model list for RAPL MSR Interface). Thus
register the RAPL TPMI powercap control type with name "intel-rapl",
the same as RAPL MSR Interface, so that it is transparent to userspace.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/Kconfig           |  14 ++
 drivers/powercap/Makefile          |   1 +
 drivers/powercap/intel_rapl_tpmi.c | 325 +++++++++++++++++++++++++++++
 3 files changed, 340 insertions(+)
 create mode 100644 drivers/powercap/intel_rapl_tpmi.c

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 90d33cd1b670..e71399804c14 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -33,6 +33,20 @@ config INTEL_RAPL
 	  controller, CPU core (Power Plane 0), graphics uncore (Power Plane
 	  1), etc.
 
+config INTEL_RAPL_TPMI
+	tristate "Intel RAPL Support via TPMI Interface"
+	depends on X86
+	depends on INTEL_TPMI
+	select INTEL_RAPL_CORE
+	help
+	  This enables support for the Intel Running Average Power Limit (RAPL)
+	  technology via TPMI interface, which allows power limits to be enforced
+	  and monitored.
+
+	  In RAPL, the platform level settings are divided into domains for
+	  fine grained control. These domains include processor package, DRAM
+	  controller, platform, etc.
+
 config IDLE_INJECT
 	bool "Idle injection framework"
 	depends on CPU_IDLE
diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
index 4474201b4aa7..5ab0dce565b9 100644
--- a/drivers/powercap/Makefile
+++ b/drivers/powercap/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_DTPM_DEVFREQ) += dtpm_devfreq.o
 obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
 obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
 obj-$(CONFIG_INTEL_RAPL) += intel_rapl_msr.o
+obj-$(CONFIG_INTEL_RAPL_TPMI) += intel_rapl_tpmi.o
 obj-$(CONFIG_IDLE_INJECT) += idle_inject.o
 obj-$(CONFIG_ARM_SCMI_POWERCAP) += arm_scmi_powercap.o
diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
new file mode 100644
index 000000000000..c016127b3497
--- /dev/null
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * intel_rapl_tpmi: Intel RAPL driver via TPMI interface
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ * All Rights Reserved.
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/auxiliary_bus.h>
+#include <linux/io.h>
+#include <linux/intel_tpmi.h>
+#include <linux/intel_rapl.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#define TPMI_RAPL_VERSION 1
+
+/* 1 header + 10 registers + 5 reserved. 8 bytes for each. */
+#define TPMI_RAPL_DOMAIN_SIZE 128
+
+enum tpmi_rapl_domain_type {
+	TPMI_RAPL_DOMAIN_INVALID,
+	TPMI_RAPL_DOMAIN_SYSTEM,
+	TPMI_RAPL_DOMAIN_PACKAGE,
+	TPMI_RAPL_DOMAIN_RESERVED,
+	TPMI_RAPL_DOMAIN_MEMORY,
+	TPMI_RAPL_DOMAIN_MAX,
+};
+
+enum tpmi_rapl_register {
+	TPMI_RAPL_REG_HEADER,
+	TPMI_RAPL_REG_UNIT,
+	TPMI_RAPL_REG_PL1,
+	TPMI_RAPL_REG_PL2,
+	TPMI_RAPL_REG_PL3,
+	TPMI_RAPL_REG_PL4,
+	TPMI_RAPL_REG_RESERVED,
+	TPMI_RAPL_REG_ENERGY_STATUS,
+	TPMI_RAPL_REG_PERF_STATUS,
+	TPMI_RAPL_REG_POWER_INFO,
+	TPMI_RAPL_REG_INTERRUPT,
+	TPMI_RAPL_REG_MAX = 15,
+};
+
+struct tpmi_rapl_package {
+	struct rapl_if_priv priv;
+	struct intel_tpmi_plat_info *tpmi_info;
+	struct rapl_package *rp;
+	void __iomem *base;
+	struct list_head node;
+};
+
+static LIST_HEAD(tpmi_rapl_packages);
+static DEFINE_MUTEX(tpmi_rapl_lock);
+
+static struct powercap_control_type *tpmi_control_type;
+
+static int tpmi_rapl_read_raw(int id, struct reg_action *ra)
+{
+	if (!ra->reg)
+		return -EINVAL;
+
+	ra->value = readq((void __iomem *)ra->reg);
+
+	ra->value &= ra->mask;
+	return 0;
+}
+
+static int tpmi_rapl_write_raw(int id, struct reg_action *ra)
+{
+	u64 val;
+
+	if (!ra->reg)
+		return -EINVAL;
+
+	val = readq((void __iomem *)ra->reg);
+
+	val &= ~ra->mask;
+	val |= ra->value;
+
+	writeq(val, (void __iomem *)ra->reg);
+	return 0;
+}
+
+static struct tpmi_rapl_package *trp_alloc(int pkg_id)
+{
+	struct tpmi_rapl_package *trp;
+	int ret;
+
+	mutex_lock(&tpmi_rapl_lock);
+
+	if (list_empty(&tpmi_rapl_packages)) {
+		tpmi_control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
+		if (IS_ERR(tpmi_control_type)) {
+			ret = PTR_ERR(tpmi_control_type);
+			goto err_unlock;
+		}
+	}
+
+	trp = kzalloc(sizeof(*trp), GFP_KERNEL);
+	if (!trp) {
+		ret = -ENOMEM;
+		goto err_del_powercap;
+	}
+
+	list_add(&trp->node, &tpmi_rapl_packages);
+
+	mutex_unlock(&tpmi_rapl_lock);
+	return trp;
+
+err_del_powercap:
+	if (list_empty(&tpmi_rapl_packages))
+		powercap_unregister_control_type(tpmi_control_type);
+err_unlock:
+	mutex_unlock(&tpmi_rapl_lock);
+	return ERR_PTR(ret);
+}
+
+static void trp_release(struct tpmi_rapl_package *trp)
+{
+	mutex_lock(&tpmi_rapl_lock);
+	list_del(&trp->node);
+
+	if (list_empty(&tpmi_rapl_packages))
+		powercap_unregister_control_type(tpmi_control_type);
+
+	kfree(trp);
+	mutex_unlock(&tpmi_rapl_lock);
+}
+
+static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
+{
+	u8 tpmi_domain_version;
+	enum rapl_domain_type domain_type;
+	enum tpmi_rapl_domain_type tpmi_domain_type;
+	enum tpmi_rapl_register reg_index;
+	enum rapl_domain_reg_id reg_id;
+	int tpmi_domain_size, tpmi_domain_flags;
+	u64 *tpmi_rapl_regs = trp->base + offset;
+	u64 tpmi_domain_header = readq((void __iomem *)tpmi_rapl_regs);
+
+	/* Domain Parent bits are ignored for now */
+	tpmi_domain_version = tpmi_domain_header & 0xff;
+	tpmi_domain_type = tpmi_domain_header >> 8 & 0xff;
+	tpmi_domain_size = tpmi_domain_header >> 16 & 0xff;
+	tpmi_domain_flags = tpmi_domain_header >> 32 & 0xffff;
+
+	if (tpmi_domain_version != TPMI_RAPL_VERSION) {
+		pr_warn(FW_BUG "Unsupported version:%d\n", tpmi_domain_version);
+		return -ENODEV;
+	}
+
+	/* Domain size: in unit of 128 Bytes */
+	if (tpmi_domain_size != 1) {
+		pr_warn(FW_BUG "Invalid Domain size %d\n", tpmi_domain_size);
+		return -EINVAL;
+	}
+
+	/* Unit register and Energy Status register are mandatory for each domain */
+	if (!(tpmi_domain_flags & BIT(TPMI_RAPL_REG_UNIT)) ||
+	    !(tpmi_domain_flags & BIT(TPMI_RAPL_REG_ENERGY_STATUS))) {
+		pr_warn(FW_BUG "Invalid Domain flag 0x%x\n", tpmi_domain_flags);
+		return -EINVAL;
+	}
+
+	switch (tpmi_domain_type) {
+	case TPMI_RAPL_DOMAIN_PACKAGE:
+		domain_type = RAPL_DOMAIN_PACKAGE;
+		break;
+	case TPMI_RAPL_DOMAIN_SYSTEM:
+		domain_type = RAPL_DOMAIN_PLATFORM;
+		break;
+	case TPMI_RAPL_DOMAIN_MEMORY:
+		domain_type = RAPL_DOMAIN_DRAM;
+		break;
+	default:
+		pr_warn(FW_BUG "Unsupported Domain type %d\n", tpmi_domain_type);
+		return -EINVAL;
+	}
+
+	if (trp->priv.regs[domain_type][RAPL_DOMAIN_REG_UNIT]) {
+		pr_warn(FW_BUG "Duplicate Domain type %d\n", tpmi_domain_type);
+		return -EINVAL;
+	}
+
+	reg_index = TPMI_RAPL_REG_HEADER;
+	while (++reg_index != TPMI_RAPL_REG_MAX) {
+		if (!(tpmi_domain_flags & BIT(reg_index)))
+			continue;
+
+		switch (reg_index) {
+		case TPMI_RAPL_REG_UNIT:
+			reg_id = RAPL_DOMAIN_REG_UNIT;
+			break;
+		case TPMI_RAPL_REG_PL1:
+			reg_id = RAPL_DOMAIN_REG_LIMIT;
+			trp->priv.limits[domain_type] |= BIT(POWER_LIMIT1);
+			break;
+		case TPMI_RAPL_REG_PL2:
+			reg_id = RAPL_DOMAIN_REG_PL2;
+			trp->priv.limits[domain_type] |= BIT(POWER_LIMIT2);
+			break;
+		case TPMI_RAPL_REG_PL4:
+			reg_id = RAPL_DOMAIN_REG_PL4;
+			trp->priv.limits[domain_type] |= BIT(POWER_LIMIT4);
+			break;
+		case TPMI_RAPL_REG_ENERGY_STATUS:
+			reg_id = RAPL_DOMAIN_REG_STATUS;
+			break;
+		case TPMI_RAPL_REG_PERF_STATUS:
+			reg_id = RAPL_DOMAIN_REG_PERF;
+			break;
+		case TPMI_RAPL_REG_POWER_INFO:
+			reg_id = RAPL_DOMAIN_REG_INFO;
+			break;
+		default:
+			continue;
+		}
+		trp->priv.regs[domain_type][reg_id] = (u64)&tpmi_rapl_regs[reg_index];
+	}
+
+	return 0;
+}
+
+static int intel_rapl_tpmi_probe(struct auxiliary_device *auxdev,
+				 const struct auxiliary_device_id *id)
+{
+	struct tpmi_rapl_package *trp;
+	struct intel_tpmi_plat_info *info;
+	struct resource *res;
+	u32 offset;
+	int ret;
+
+	info = tpmi_get_platform_data(auxdev);
+	if (!info)
+		return -ENODEV;
+
+	trp = trp_alloc(info->package_id);
+	if (IS_ERR(trp))
+		return PTR_ERR(trp);
+
+	if (tpmi_get_resource_count(auxdev) > 1) {
+		dev_err(&auxdev->dev, "does not support multiple resources\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	res = tpmi_get_resource_at_index(auxdev, 0);
+	if (!res) {
+		dev_err(&auxdev->dev, "can't fetch device resource info\n");
+		ret = -EIO;
+		goto err;
+	}
+
+	trp->base = devm_ioremap_resource(&auxdev->dev, res);
+	if (!trp->base) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	for (offset = 0; offset < resource_size(res); offset += TPMI_RAPL_DOMAIN_SIZE) {
+		ret = parse_one_domain(trp, offset);
+		if (ret)
+			goto err;
+	}
+
+	trp->tpmi_info = info;
+	trp->priv.type = RAPL_IF_TPMI;
+	trp->priv.read_raw = tpmi_rapl_read_raw;
+	trp->priv.write_raw = tpmi_rapl_write_raw;
+	trp->priv.control_type = tpmi_control_type;
+
+	/* RAPL TPMI I/F is per physical package */
+	trp->rp = rapl_find_package_domain(info->package_id, &trp->priv, false);
+	if (trp->rp) {
+		dev_err(&auxdev->dev, "Domain for Package%d already exists\n", info->package_id);
+		ret = -EEXIST;
+		goto err;
+	}
+
+	trp->rp = rapl_add_package(info->package_id, &trp->priv, false);
+	if (IS_ERR(trp->rp)) {
+		dev_err(&auxdev->dev, "Failed to add RAPL Domain for Package%d, %ld\n",
+			info->package_id, PTR_ERR(trp->rp));
+		ret = PTR_ERR(trp->rp);
+		goto err;
+	}
+
+	auxiliary_set_drvdata(auxdev, trp);
+
+	return 0;
+err:
+	trp_release(trp);
+	return ret;
+}
+
+static void intel_rapl_tpmi_remove(struct auxiliary_device *auxdev)
+{
+	struct tpmi_rapl_package *trp = auxiliary_get_drvdata(auxdev);
+
+	rapl_remove_package(trp->rp);
+	trp_release(trp);
+}
+
+static const struct auxiliary_device_id intel_rapl_tpmi_ids[] = {
+	{.name = "intel_vsec.tpmi-rapl" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(auxiliary, intel_rapl_tpmi_ids);
+
+static struct auxiliary_driver intel_rapl_tpmi_driver = {
+	.probe = intel_rapl_tpmi_probe,
+	.remove = intel_rapl_tpmi_remove,
+	.id_table = intel_rapl_tpmi_ids,
+};
+
+module_auxiliary_driver(intel_rapl_tpmi_driver)
+
+MODULE_IMPORT_NS(INTEL_TPMI);
+
+MODULE_DESCRIPTION("Intel RAPL TPMI Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

