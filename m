Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA32C6A9DFE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjCCRv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjCCRv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:51:56 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD465D8B2;
        Fri,  3 Mar 2023 09:51:30 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PSwSm0wMSz6J9gC;
        Sat,  4 Mar 2023 01:48:56 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 17:51:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <will@kernel.org>,
        <dan.j.williams@intel.com>, <bwidawsk@kernel.org>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <linuxarm@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] cxl/pci: Find and register CXL PMU devices
Date:   Fri, 3 Mar 2023 17:50:20 +0000
Message-ID: <20230303175022.10806-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
References: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

In order to register the minimum number of IRQ vectors necessary
to support all CPMUs found, separate the registration into two
steps.  First find the devices, and query the IRQs used and then
register the devices. Between these two steps, request the
IRQ vectors necessary and enable bus master support.

Future IRQ users for CXL type 3 devices (e.g. DOEs) will need to
follow a similar pattern the number of vectors necessary is known
before any parts of the driver stack rely on their availability.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v1 (since RFC v3): thanks to Davidlohr for review.
- Do not error out if CPMU registration fails.  It is not critical
  for normal operation.
- Generally a lot simpler now we don't have to deal with dynamic
  establishment of the required irq vectors.
---
 drivers/cxl/core/Makefile |  1 +
 drivers/cxl/core/core.h   |  3 ++
 drivers/cxl/core/cpmu.c   | 69 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c   |  2 ++
 drivers/cxl/core/regs.c   | 16 +++++++++
 drivers/cxl/cxl.h         | 14 ++++++++
 drivers/cxl/cxlpci.h      |  1 +
 drivers/cxl/pci.c         | 25 +++++++++++++-
 8 files changed, 130 insertions(+), 1 deletion(-)

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
index cde475e13216..05e18fed3a75 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -17,12 +17,14 @@ extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
 extern const struct device_type cxl_dax_region_type;
 extern const struct device_type cxl_region_type;
+extern const struct device_type cxl_cpmu_type;
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
 #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
 #define CXL_REGION_TYPE(x) (&cxl_region_type)
 #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
 #define CXL_PMEM_REGION_TYPE(x) (&cxl_pmem_region_type)
 #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
+#define CXL_CPMU_TYPE(x) (&cxl_cpmu_region_type)
 int cxl_region_init(void);
 void cxl_region_exit(void);
 #else
@@ -41,6 +43,7 @@ static inline void cxl_region_exit(void)
 #define SET_CXL_REGION_ATTR(x)
 #define CXL_PMEM_REGION_TYPE(x) NULL
 #define CXL_DAX_REGION_TYPE(x) NULL
+#define CXL_CPMU_TYPE(x) NULL
 #endif
 
 struct cxl_send_command;
diff --git a/drivers/cxl/core/cpmu.c b/drivers/cxl/core/cpmu.c
new file mode 100644
index 000000000000..cad02f3d43c3
--- /dev/null
+++ b/drivers/cxl/core/cpmu.c
@@ -0,0 +1,69 @@
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
+	cpmu->base = regs->cpmu;
+	dev = &cpmu->dev;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = parent;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_cpmu_type;
+	rc = ida_alloc(&cpmu_ida, GFP_KERNEL);
+	if (rc < 0)
+		goto err;
+	cpmu->id = rc;
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
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 86c4b3cf69d9..62a47d9f0cd3 100644
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
@@ -748,6 +760,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_REGION		6
 #define CXL_DEVICE_PMEM_REGION		7
 #define CXL_DEVICE_DAX_REGION		8
+#define CXL_DEVICE_CPMU			9
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
@@ -787,6 +800,7 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
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

