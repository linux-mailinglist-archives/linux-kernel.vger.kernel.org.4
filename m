Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56936E0FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDMO1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjDMO1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:27:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D460A9EE0;
        Thu, 13 Apr 2023 07:27:19 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Py20N0l6Xz6J7JS;
        Thu, 13 Apr 2023 22:24:52 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 15:27:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v6 2/5] cxl: Add functions to get an instance of / count regblocks of a given type
Date:   Thu, 13 Apr 2023 15:26:14 +0100
Message-ID: <20230413142617.15995-3-Jonathan.Cameron@huawei.com>
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

Until the recently release CXL 3.0 specification, there
was only ever one instance of any given register block pointed
to by the Register Block Locator DVSEC. Now, the specification allows
for multiple CXL PMU instances, each with their own register block.

To enable this add cxl_find_regblock_instance() that takes an index
parameter and use that to implement cxl_count_regblock() and
cxl_find_regblock().

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v6: No change

Dropped RBs as significant refactor for v5.

v5: Thanks to Dan Williams,
 - As there is only one case of repeated regblocks so far keep
   cxl_find_regblock() as finding the first instance but implement
   it using a new cxl_find_regblock_instance() function, also used
   to implement the counting function.
---
 drivers/cxl/core/regs.c | 59 ++++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxl.h       |  3 +++
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 1476a0299c9b..4b9672db867d 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -286,20 +286,23 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 }
 
 /**
- * cxl_find_regblock() - Locate register blocks by type
+ * cxl_find_regblock_instance() - Locate a register block by type / index
  * @pdev: The CXL PCI device to enumerate.
  * @type: Register Block Indicator id
  * @map: Enumeration output, clobbered on error
+ * @index: Index into which particular instance of a regblock wanted in the
+ *	   order found in register locator DVSEC.
  *
  * Return: 0 if register block enumerated, negative error code otherwise
  *
  * A CXL DVSEC may point to one or more register blocks, search for them
- * by @type.
+ * by @type and @index.
  */
-int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-		      struct cxl_register_map *map)
+int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
+			       struct cxl_register_map *map, int index)
 {
 	u32 regloc_size, regblocks;
+	int instance = 0;
 	int regloc, i;
 
 	map->resource = CXL_RESOURCE_NONE;
@@ -323,15 +326,59 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
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
 	return -ENODEV;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_find_regblock_instance, CXL);
+
+/**
+ * cxl_find_regblock() - Locate register blocks by type
+ * @pdev: The CXL PCI device to enumerate.
+ * @type: Register Block Indicator id
+ * @map: Enumeration output, clobbered on error
+ *
+ * Return: 0 if register block enumerated, negative error code otherwise
+ *
+ * A CXL DVSEC may point to one or more register blocks, search for them
+ * by @type.
+ */
+int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
+		      struct cxl_register_map *map)
+{
+	return cxl_find_regblock_instance(pdev, type, map, 0);
+}
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
+		rc = cxl_find_regblock_instance(pdev, type, &map, count);
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
index 044a92d9813e..f6e2a9ea5f41 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -260,6 +260,9 @@ int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
 			struct cxl_register_map *map);
 
 enum cxl_regloc_type;
+int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
+int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
+			       struct cxl_register_map *map, int index);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 
-- 
2.37.2

