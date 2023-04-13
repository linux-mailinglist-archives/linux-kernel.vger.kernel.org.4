Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFE76E0FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjDMO1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjDMO1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:27:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BEE9EEE;
        Thu, 13 Apr 2023 07:27:50 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Py20y52SGz6J7JS;
        Thu, 13 Apr 2023 22:25:22 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 15:27:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v6 3/5] cxl/pci: Find and register CXL PMU devices
Date:   Thu, 13 Apr 2023 15:26:15 +0100
Message-ID: <20230413142617.15995-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230413142617.15995-1-Jonathan.Cameron@huawei.com>
References: <20230413142617.15995-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CXL PMU devices can be found from entries in the Register
Locator DVSEC.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v6: No change

v5:
- Switch to cxl_find_regblock_instance() as replacement for
  indexed version of cxl_find_reblock()
- Dropped stale patch description.
- Rename all structure, functions etc from cpmu to pmu / cxl_pmu as
  appropriate.
- Register definitions pushed down into drivers/perf/pmu.c as not
  needed from drivers/cxl/
- Allow richer device naming based on which CXL memdev the CPMU is
  associated with.  /sys/bus/cxl/devices/pmu_memX.Y for instance Y
  on device /sys/bus/cxl/devices/memX
- Tidy up definitions by adding include to linux/device.h for
  struct device and a forwards reference for struct cxl_pmu_regs.
---
 drivers/cxl/core/Makefile |  1 +
 drivers/cxl/core/core.h   |  1 +
 drivers/cxl/core/pmu.c    | 69 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c   |  2 ++
 drivers/cxl/core/regs.c   | 16 +++++++++
 drivers/cxl/cxl.h         | 13 ++++++++
 drivers/cxl/cxlpci.h      |  1 +
 drivers/cxl/pci.c         | 26 ++++++++++++++-
 drivers/cxl/pmu.h         | 28 ++++++++++++++++
 9 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ca4ae31d8f57..1f66b5d4d935 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -12,5 +12,6 @@ cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
+cxl_core-y += pmu.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index cde475e13216..c9504dfddfed 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
+extern const struct device_type cxl_pmu_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
diff --git a/drivers/cxl/core/pmu.c b/drivers/cxl/core/pmu.c
new file mode 100644
index 000000000000..b55eb962235f
--- /dev/null
+++ b/drivers/cxl/core/pmu.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Huawei. All rights reserved. */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <cxlmem.h>
+#include <pmu.h>
+#include <cxl.h>
+#include "core.h"
+
+static void cxl_pmu_release(struct device *dev)
+{
+	struct cxl_pmu *pmu = to_cxl_pmu(dev);
+
+	kfree(pmu);
+}
+
+const struct device_type cxl_pmu_type = {
+	.name = "cxl_pmu",
+	.release = cxl_pmu_release,
+};
+
+static void remove_dev(void *dev)
+{
+	device_del(dev);
+}
+
+int devm_cxl_pmu_add(struct device *parent, struct cxl_pmu_regs *regs,
+		     int assoc_id, int index, enum cxl_pmu_type type)
+{
+	struct cxl_pmu *pmu;
+	struct device *dev;
+	int rc;
+
+	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	pmu->assoc_id = assoc_id;
+	pmu->index = index;
+	pmu->type = type;
+	pmu->base = regs->pmu;
+	dev = &pmu->dev;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = parent;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_pmu_type;
+	switch (pmu->type) {
+	case CXL_PMU_MEMDEV:
+		rc = dev_set_name(dev, "pmu_mem%d.%d", assoc_id, index);
+		break;
+	}
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
+	put_device(&pmu->dev);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_pmu_add, CXL);
+
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 4d1f9c5b5029..9a71e249f458 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -57,6 +57,8 @@ static int cxl_device_id(const struct device *dev)
 		return CXL_DEVICE_MEMORY_EXPANDER;
 	if (dev->type == CXL_REGION_TYPE())
 		return CXL_DEVICE_REGION;
+	if (dev->type == &cxl_pmu_type)
+		return CXL_DEVICE_PMU;
 	return 0;
 }
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 4b9672db867d..518bc2ad2c1e 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
+#include <pmu.h>
 
 #include "core.h"
 
@@ -379,6 +380,21 @@ int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, CXL);
 
+int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
+		     struct cxl_register_map *map)
+{
+	struct device *dev = &pdev->dev;
+	resource_size_t phys_addr;
+
+	phys_addr = map->resource;
+	regs->pmu = devm_cxl_iomap_block(dev, phys_addr, CXL_PMU_REGMAP_SIZE);
+	if (!regs->pmu)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_map_pmu_regs, CXL);
+
 resource_size_t cxl_rcrb_to_component(struct device *dev,
 				      resource_size_t rcrb,
 				      enum cxl_rcrb which)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f6e2a9ea5f41..610aa430276b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -209,6 +209,10 @@ struct cxl_regs {
 	struct_group_tagged(cxl_device_regs, device_regs,
 		void __iomem *status, *mbox, *memdev;
 	);
+
+	struct_group_tagged(cxl_pmu_regs, pmu_regs,
+		void __iomem *pmu;
+	);
 };
 
 struct cxl_reg_map {
@@ -229,6 +233,10 @@ struct cxl_device_reg_map {
 	struct cxl_reg_map memdev;
 };
 
+struct cxl_pmu_reg_map {
+	struct cxl_reg_map pmu;
+};
+
 /**
  * struct cxl_register_map - DVSEC harvested register block mapping parameters
  * @base: virtual base of the register-block-BAR + @block_offset
@@ -237,6 +245,7 @@ struct cxl_device_reg_map {
  * @reg_type: see enum cxl_regloc_type
  * @component_map: cxl_reg_map for component registers
  * @device_map: cxl_reg_maps for device registers
+ * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
  */
 struct cxl_register_map {
 	void __iomem *base;
@@ -246,6 +255,7 @@ struct cxl_register_map {
 	union {
 		struct cxl_component_reg_map component_map;
 		struct cxl_device_reg_map device_map;
+		struct cxl_pmu_reg_map pmu_map;
 	};
 };
 
@@ -258,6 +268,8 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
 			   unsigned long map_mask);
 int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
 			struct cxl_register_map *map);
+int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
+		     struct cxl_register_map *map);
 
 enum cxl_regloc_type;
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
@@ -752,6 +764,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_REGION		6
 #define CXL_DEVICE_PMEM_REGION		7
 #define CXL_DEVICE_DAX_REGION		8
+#define CXL_DEVICE_PMU			9
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0465ef963cd6..b1bbf69b62c5 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -65,6 +65,7 @@ enum cxl_regloc_type {
 	CXL_REGLOC_RBI_COMPONENT,
 	CXL_REGLOC_RBI_VIRT,
 	CXL_REGLOC_RBI_MEMDEV,
+	CXL_REGLOC_RBI_PMU,
 	CXL_REGLOC_RBI_TYPES
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 60b23624d167..8a39e9ef081f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -14,6 +14,7 @@
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
+#include "pmu.h"
 
 /**
  * DOC: cxl pci
@@ -704,7 +705,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dev_state *cxlds;
-	int rc;
+	int i, rc, pmu_count;
 
 	/*
 	 * Double check the anonymous union trickery in struct cxl_regs
@@ -785,6 +786,29 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
+	for (i = 0; i < pmu_count; i++) {
+		struct cxl_pmu_regs pmu_regs;
+
+		rc = cxl_find_regblock_instance(pdev, CXL_REGLOC_RBI_PMU, &map, i);
+		if (rc) {
+			dev_dbg(&pdev->dev, "Could not find PMU regblock\n");
+			break;
+		}
+
+		rc = cxl_map_pmu_regs(pdev, &pmu_regs, &map);
+		if (rc) {
+			dev_dbg(&pdev->dev, "Could not map PMU regs\n");
+			break;
+		}
+
+		rc = devm_cxl_pmu_add(cxlds->dev, &pmu_regs, cxlmd->id, i, CXL_PMU_MEMDEV);
+		if (rc) {
+			dev_dbg(&pdev->dev, "Could not add PMU instance\n");
+			break;
+		}
+	}
+
 	rc = cxl_event_config(host_bridge, cxlds);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/pmu.h b/drivers/cxl/pmu.h
new file mode 100644
index 000000000000..b1e9bcd9f28c
--- /dev/null
+++ b/drivers/cxl/pmu.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright(c) 2023 Huawei
+ * CXL Specification rev 3.0 Setion 8.2.7 (CPMU Register Interface)
+ */
+#ifndef CXL_PMU_H
+#define CXL_PMU_H
+#include <linux/device.h>
+
+enum cxl_pmu_type {
+	CXL_PMU_MEMDEV,
+};
+
+#define CXL_PMU_REGMAP_SIZE 0xe00 /* Table 8-32 CXL 3.0 specification */
+struct cxl_pmu {
+	struct device dev;
+	void __iomem *base;
+	int assoc_id;
+	int index;
+	enum cxl_pmu_type type;
+};
+
+#define to_cxl_pmu(dev) container_of(dev, struct cxl_pmu, dev)
+struct cxl_pmu_regs;
+int devm_cxl_pmu_add(struct device *parent, struct cxl_pmu_regs *regs,
+		     int assoc_id, int idx, enum cxl_pmu_type type);
+
+#endif
-- 
2.37.2

