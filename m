Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5649F6D0BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjC3Qrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjC3Qr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:47:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ACBDBE6;
        Thu, 30 Mar 2023 09:47:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnTpT70wkz6J7vG;
        Fri, 31 Mar 2023 00:46:41 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 17:47:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v4 3/5] cxl/pci: Find and register CXL PMU devices
Date:   Thu, 30 Mar 2023 17:45:54 +0100
Message-ID: <20230330164556.31533-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CXL PMU devices can be found from entries in the Register
Locator DVSEC.

In order to register the minimum number of IRQ vectors necessary
to support all CPMUs found, separate the registration into two
steps.  First find the devices, and query the IRQs used and then
register the devices. Between these two steps, request the
IRQ vectors necessary and enable bus master support.

Future IRQ users for CXL type 3 devices (e.g. DOEs) will need to
follow a similar pattern the number of vectors necessary is known
before any parts of the driver stack rely on their availability.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v4:
- No change.
---
 drivers/cxl/core/Makefile |  1 +
 drivers/cxl/core/core.h   |  1 +
 drivers/cxl/core/cpmu.c   | 72 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c   |  2 ++
 drivers/cxl/core/regs.c   | 16 +++++++++
 drivers/cxl/cpmu.h        | 56 ++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         | 14 ++++++++
 drivers/cxl/cxlpci.h      |  1 +
 drivers/cxl/pci.c         | 25 +++++++++++++-
 9 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ca4ae31d8f57..45e5543aff52 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -12,5 +12,6 @@ cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
+cxl_core-y += cpmu.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index cde475e13216..63a5b709fe8d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
+extern const struct device_type cxl_cpmu_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
diff --git a/drivers/cxl/core/cpmu.c b/drivers/cxl/core/cpmu.c
new file mode 100644
index 000000000000..8aff35055c05
--- /dev/null
+++ b/drivers/cxl/core/cpmu.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Huawei. All rights reserved. */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <cxlmem.h>
+#include <cpmu.h>
+#include <cxl.h>
+#include "core.h"
+
+static DEFINE_IDA(cpmu_ida);
+
+static void cxl_cpmu_release(struct device *dev)
+{
+	struct cxl_cpmu *cpmu = container_of(dev, struct cxl_cpmu, dev);
+
+	ida_free(&cpmu_ida, cpmu->id);
+	kfree(cpmu);
+}
+
+const struct device_type cxl_cpmu_type = {
+	.name = "cxl_cpmu",
+	.release = cxl_cpmu_release,
+};
+
+static void remove_dev(void *dev)
+{
+	device_del(dev);
+}
+
+int devm_cxl_cpmu_add(struct device *parent, struct cxl_cpmu_regs *regs, int index)
+{
+	struct cxl_cpmu *cpmu;
+	struct device *dev;
+	int rc;
+
+	cpmu = kzalloc(sizeof(*cpmu), GFP_KERNEL);
+	if (!cpmu)
+		return -ENOMEM;
+
+	rc = ida_alloc(&cpmu_ida, GFP_KERNEL);
+	if (rc < 0) {
+		kfree(cpmu);
+		return rc;
+	}
+	cpmu->id = rc;
+
+	cpmu->base = regs->cpmu;
+	dev = &cpmu->dev;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = parent;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_cpmu_type;
+
+	rc = dev_set_name(dev, "cpmu%d", cpmu->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	return devm_add_action_or_reset(parent, remove_dev, dev);
+
+err:
+	put_device(&cpmu->dev);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_cpmu_add, CXL);
+
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 97cc03dbceee..2154bf8d2aad 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -57,6 +57,8 @@ static int cxl_device_id(const struct device *dev)
 		return CXL_DEVICE_MEMORY_EXPANDER;
 	if (dev->type == CXL_REGION_TYPE())
 		return CXL_DEVICE_REGION;
+	if (dev->type == &cxl_cpmu_type)
+		return CXL_DEVICE_CPMU;
 	return 0;
 }
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 7389dd1af967..99d6ebe3aba9 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
+#include <cpmu.h>
 
 #include "core.h"
 
@@ -360,6 +361,21 @@ int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, CXL);
 
+int cxl_map_cpmu_regs(struct pci_dev *pdev, struct cxl_cpmu_regs *regs,
+		      struct cxl_register_map *map)
+{
+	struct device *dev = &pdev->dev;
+	resource_size_t phys_addr;
+
+	phys_addr = map->resource;
+	regs->cpmu = devm_cxl_iomap_block(dev, phys_addr, CPMU_REGMAP_SIZE);
+	if (!regs->cpmu)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_map_cpmu_regs, CXL);
+
 resource_size_t cxl_rcrb_to_component(struct device *dev,
 				      resource_size_t rcrb,
 				      enum cxl_rcrb which)
diff --git a/drivers/cxl/cpmu.h b/drivers/cxl/cpmu.h
new file mode 100644
index 000000000000..2cf78a6b9b13
--- /dev/null
+++ b/drivers/cxl/cpmu.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright(c) 2022 Huawei
+ * CXL Specification rev 3.0 Setion 8.2.7 (CPMU Register Interface)
+ */
+#ifndef CXL_CPMU_H
+#define CXL_CPMU_H
+
+#define CPMU_CAP_REG			0x0
+#define   CPMU_CAP_NUM_COUNTERS_MSK		GENMASK_ULL(4, 0)
+#define   CPMU_CAP_COUNTER_WIDTH_MSK		GENMASK_ULL(15, 8)
+#define   CPMU_CAP_NUM_EVN_CAP_REG_SUP_MSK	GENMASK_ULL(24, 20)
+#define   CPMU_CAP_FILTERS_SUP_MSK		GENMASK_ULL(39, 32)
+#define     CPMU_FILTER_HDM			BIT(0)
+#define     CPMU_FILTER_CHAN_RANK_BANK		BIT(1)
+#define   CPMU_CAP_MSI_N_MSK			GENMASK_ULL(47, 44)
+#define   CPMU_CAP_WRITEABLE_WHEN_FROZEN	BIT_ULL(48)
+#define   CPMU_CAP_FREEZE			BIT_ULL(49)
+#define   CPMU_CAP_INT				BIT_ULL(50)
+#define   CPMU_CAP_VERSION_MSK			GENMASK_ULL(63, 60)
+
+#define CPMU_OVERFLOW_REG		0x10
+#define CPMU_FREEZE_REG			0x18
+#define CPMU_EVENT_CAP_REG(n)		(0x100 + 8 * (n))
+#define   CPMU_EVENT_CAP_SUPPORTED_EVENTS_MSK	GENMASK_ULL(31, 0)
+#define   CPMU_EVENT_CAP_GROUP_ID_MSK		GENMASK_ULL(47, 32)
+#define   CPMU_EVENT_CAP_VENDOR_ID_MSK		GENMASK_ULL(63, 48)
+
+#define CPMU_COUNTER_CFG_REG(n)		(0x200 + 8 * (n))
+#define   CPMU_COUNTER_CFG_TYPE_MSK		GENMASK_ULL(1, 0)
+#define     CPMU_COUNTER_CFG_TYPE_FREE_RUN	0
+#define     CPMU_COUNTER_CFG_TYPE_FIXED_FUN	1
+#define     CPMU_COUNTER_CFG_TYPE_CONFIGURABLE	2
+#define   CPMU_COUNTER_CFG_ENABLE		BIT_ULL(8)
+#define   CPMU_COUNTER_CFG_INT_ON_OVRFLW	BIT_ULL(9)
+#define   CPMU_COUNTER_CFG_FREEZE_ON_OVRFLW	BIT_ULL(10)
+#define   CPMU_COUNTER_CFG_EDGE			BIT_ULL(11)
+#define   CPMU_COUNTER_CFG_INVERT		BIT_ULL(12)
+#define   CPMU_COUNTER_CFG_THRESHOLD_MSK	GENMASK_ULL(23, 16)
+#define   CPMU_COUNTER_CFG_EVENTS_MSK		GENMASK_ULL(55, 24)
+#define   CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK	GENMASK_ULL(63, 59)
+
+#define CPMU_FILTER_CFG_REG(n, f)	(0x400 + 4 * ((f) + (n) * 8))
+#define   CPMU_FILTER_CFG_VALUE_MSK		GENMASK(15, 0)
+
+#define CPMU_COUNTER_REG(n)			(0xc00 + 8 * (n))
+
+#define CPMU_REGMAP_SIZE 0xe00 /* Table 8-32 CXL 3.0 specification */
+struct cxl_cpmu {
+	struct device dev;
+	void __iomem *base;
+	int id;
+};
+
+#define to_cxl_cpmu(dev) container_of(dev, struct cxl_cpmu, dev)
+#endif
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0cc33e2a99d7..a7b8a0c46715 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -209,6 +209,10 @@ struct cxl_regs {
 	struct_group_tagged(cxl_device_regs, device_regs,
 		void __iomem *status, *mbox, *memdev;
 	);
+
+	struct_group_tagged(cxl_cpmu_regs, cpmu_regs,
+		void __iomem *cpmu;
+	);
 };
 
 struct cxl_reg_map {
@@ -229,6 +233,10 @@ struct cxl_device_reg_map {
 	struct cxl_reg_map memdev;
 };
 
+struct cxl_cpmu_reg_map {
+	struct cxl_reg_map cpmu;
+};
+
 /**
  * struct cxl_register_map - DVSEC harvested register block mapping parameters
  * @base: virtual base of the register-block-BAR + @block_offset
@@ -237,6 +245,7 @@ struct cxl_device_reg_map {
  * @reg_type: see enum cxl_regloc_type
  * @component_map: cxl_reg_map for component registers
  * @device_map: cxl_reg_maps for device registers
+ * @cpmu_map: cxl_reg_maps for CXL Performance Monitoring Units
  */
 struct cxl_register_map {
 	void __iomem *base;
@@ -246,6 +255,7 @@ struct cxl_register_map {
 	union {
 		struct cxl_component_reg_map component_map;
 		struct cxl_device_reg_map device_map;
+		struct cxl_cpmu_reg_map cpmu_map;
 	};
 };
 
@@ -258,6 +268,8 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
 			   unsigned long map_mask);
 int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
 			struct cxl_register_map *map);
+int cxl_map_cpmu_regs(struct pci_dev *pdev, struct cxl_cpmu_regs *regs,
+		      struct cxl_register_map *map);
 
 enum cxl_regloc_type;
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
@@ -750,6 +762,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_REGION		6
 #define CXL_DEVICE_PMEM_REGION		7
 #define CXL_DEVICE_DAX_REGION		8
+#define CXL_DEVICE_CPMU			9
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
@@ -789,6 +802,7 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 }
 #endif
 
+int devm_cxl_cpmu_add(struct device *parent, struct cxl_cpmu_regs *regs, int idx);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index be6a2ef3cce3..2fd495ab3de1 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -65,6 +65,7 @@ enum cxl_regloc_type {
 	CXL_REGLOC_RBI_COMPONENT,
 	CXL_REGLOC_RBI_VIRT,
 	CXL_REGLOC_RBI_MEMDEV,
+	CXL_REGLOC_RBI_CPMU,
 	CXL_REGLOC_RBI_TYPES
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 74443a5c3cc8..e8bc36cc2724 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -704,7 +704,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dev_state *cxlds;
-	int rc;
+	int i, rc, cpmu_count;
 
 	/*
 	 * Double check the anonymous union trickery in struct cxl_regs
@@ -781,6 +781,29 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	cpmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_CPMU);
+	for (i = 0; i < cpmu_count; i++) {
+		struct cxl_cpmu_regs cpmu_regs;
+
+		rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_CPMU, &map, i);
+		if (rc) {
+			dev_dbg(&pdev->dev, "Could not find CPMU regblock\n");
+			break;
+		}
+
+		rc = cxl_map_cpmu_regs(pdev, &cpmu_regs, &map);
+		if (rc) {
+			dev_dbg(&pdev->dev, "Could not map CPMU regs\n");
+			break;
+		}
+
+		rc = devm_cxl_cpmu_add(cxlds->dev, &cpmu_regs, i);
+		if (rc) {
+			dev_dbg(&pdev->dev, "Could not add CPMU instance\n");
+			break;
+		}
+	}
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
-- 
2.37.2

