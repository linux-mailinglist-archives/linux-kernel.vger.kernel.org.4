Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36716A9DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjCCRvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCCRu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:50:57 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB2237B59;
        Fri,  3 Mar 2023 09:50:56 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PSwVj4bRvz6J7RX;
        Sat,  4 Mar 2023 01:50:37 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 17:50:53 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <will@kernel.org>,
        <dan.j.williams@intel.com>, <bwidawsk@kernel.org>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <linuxarm@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] cxl: Add function to count regblocks of a given type.
Date:   Fri, 3 Mar 2023 17:50:19 +0000
Message-ID: <20230303175022.10806-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
References: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

Until the recently release CXL 3.0 specification, there
was only ever one instance of any given register block pointed
to by the Register Block Locator DVSEC. Now, the specification allows
for multiple CXL PMU instances, each with their own register block.

To enable this add an index parameter to cxl_find_regblock()
and use that to implement cxl_count_regblock().

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c  |  2 +-
 drivers/cxl/core/port.c |  2 +-
 drivers/cxl/core/regs.c | 34 +++++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h       |  3 ++-
 drivers/cxl/pci.c       |  2 +-
 5 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7328a2552411..c90251f60771 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -50,7 +50,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 				  &lnkcap))
 		return 0;
 
-	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map, 0);
 	if (rc)
 		dev_dbg(&port->dev, "failed to find component registers\n");
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8ee6b6e2e2a4..97cc03dbceee 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1333,7 +1333,7 @@ static resource_size_t find_component_registers(struct device *dev)
 
 	pdev = to_pci_dev(dev);
 
-	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map, 0);
 	return map.resource;
 }
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 1476a0299c9b..7389dd1af967 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -290,6 +290,7 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
  * @pdev: The CXL PCI device to enumerate.
  * @type: Register Block Indicator id
  * @map: Enumeration output, clobbered on error
+ * @index: Index into which particular instance of a regblock we want.
  *
  * Return: 0 if register block enumerated, negative error code otherwise
  *
@@ -297,9 +298,10 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
  * by @type.
  */
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-		      struct cxl_register_map *map)
+		      struct cxl_register_map *map, int index)
 {
 	u32 regloc_size, regblocks;
+	int instance = 0;
 	int regloc, i;
 
 	map->resource = CXL_RESOURCE_NONE;
@@ -323,8 +325,11 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		if (!cxl_decode_regblock(pdev, reg_lo, reg_hi, map))
 			continue;
 
-		if (map->reg_type == type)
-			return 0;
+		if (map->reg_type == type) {
+			if (index == instance)
+				return 0;
+			instance++;
+		}
 	}
 
 	map->resource = CXL_RESOURCE_NONE;
@@ -332,6 +337,29 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
 
+/**
+ * cxl_count_regblock() - Count instances of a given regblock type.
+ * @pdev: The CXL PCI device to enumerate.
+ * @type: Register Block Indicator id
+ *
+ * Some regblocks may be repeated. Count how many instances.
+ *
+ * Return: count of matching regblocks.
+ */
+int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
+{
+	struct cxl_register_map map;
+	int rc, count = 0;
+
+	while (1) {
+		rc = cxl_find_regblock(pdev, type, &map, count);
+		if (rc)
+			return count;
+		count++;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, CXL);
+
 resource_size_t cxl_rcrb_to_component(struct device *dev,
 				      resource_size_t rcrb,
 				      enum cxl_rcrb which)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f2b0962a552d..86c4b3cf69d9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -260,8 +260,9 @@ int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
 			struct cxl_register_map *map);
 
 enum cxl_regloc_type;
+int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-		      struct cxl_register_map *map);
+		      struct cxl_register_map *map, int index);
 
 enum cxl_rcrb {
 	CXL_RCRB_DOWNSTREAM,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 60b23624d167..74443a5c3cc8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -343,7 +343,7 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 {
 	int rc;
 
-	rc = cxl_find_regblock(pdev, type, map);
+	rc = cxl_find_regblock(pdev, type, map, 0);
 	if (rc)
 		return rc;
 
-- 
2.37.2

