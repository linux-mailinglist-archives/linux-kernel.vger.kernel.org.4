Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EEE73960A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjFVD7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjFVD6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:58:33 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAC22697;
        Wed, 21 Jun 2023 20:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHXlzA5je4uz3arPXqpZKooMwTxRz80N7PumONN9trJP7crUETxH3ATsgY314y79/3bRjQKma7WOjvJ6tfjR9nuGYVg76NXTHRsSB/Qx0cx2yZG77Z/wliGOPGs/VW859xXkBgUG787wPkNcUvtsuxut/GsAM2j/SyOv6EwP2lygqNXIThecFz4ANyoG2sRkNrZwhFxwTeMx6E9yr/3bl7FTjLwPS8ucs9M88iiKhqz0xFAxMcMYtE8BzQoaCmc0kTl7F1j0rpfObYgGoCccbxV5wWeRPy1cvox43AgCltHI5EzCdmObHDdrzmxYl18d3KCUWvrL2hiJxCk0XSjQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45RvYwsX6lKhqKPEKxlfJXUv2r/hkF/Ik0fPbpsoL5E=;
 b=KdF+TzvyCeJJ1UqJN2G5Gy0T20gz8eR84tFrGI8+eat0xoKbOi2Z+Hv2Cwiw3dMgNZXWZGk5y8IsnxblpKKdskfm7Wlo+H0eBAPIG+ysde4Zf4PO25MoWwLx1sp2s+TVc/7kXW16roXjJuu4E0arsbeWx8rrx+m2k0H3GrzQ0xvLjt5vxJ9RZ83/269HvlWwiqyDUogpEdEbIpEOHsHO0aHN64YUv3ZWSbSWYSlX/xwaV0tZd/e+e6r3oQFCCIpkMTJ/AXn6FZIP+Z5eVHfpAWskb8OOauwmyZKEbY4/fFn6FVHUWMiVWM6/W6CPCsXg+YLwhyN1JSFpakoVCcYBjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45RvYwsX6lKhqKPEKxlfJXUv2r/hkF/Ik0fPbpsoL5E=;
 b=kgobhIjQFmK/t62CGHsQz0KJ4pS0lzTP97vUfyCpykYkApdK2TzF59E9axE152rgPlK+kgnFU20Jj1TxAjHRbuEM0M61ROhYSVCYtYVcEWUzVVVN9bNyoFKzWPFME3yzroQktIi8h+YMdktUDKOEgbhuRj8L145uqmpg7f2cwtg=
Received: from BN9PR03CA0394.namprd03.prod.outlook.com (2603:10b6:408:111::9)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 03:56:56 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::e5) by BN9PR03CA0394.outlook.office365.com
 (2603:10b6:408:111::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 03:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 03:56:56 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:56:54 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 23/27] cxl/pci: Map RCH downstream AER registers for logging protocol errors
Date:   Wed, 21 Jun 2023 22:51:22 -0500
Message-ID: <20230622035126.4130151-24-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622035126.4130151-1-terry.bowman@amd.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: 1880aeaa-7454-4ee6-eaa3-08db72d4b8db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SH5+cyBKOTq5/HW7xOQDQdrcMDs++GyKGKwnHDbA5i6J/FwGaX//P5M8WV1bzyjd21c9z4T+BYtsz2kOJnSz1pF3zxe1kY2TDa0Oy0NTcSehUJki9BBaEx9hs3zvWY18iE7AgeJ5pPZBdWOlScZSr4SpfodplHqX1mEOquo1TjVvJp1VANesX9jlFlFCq3jpF8kt3HjFhAK2YVML1xqJ441AOCueZ9yrE/AeIrJM/Pk7O5e1Qe8Reh+M5yEapTOPD6u6h/K0sR+EVKG1x3bOe8QO3QHYZ37TDP6K4ZYIf70CPszlYXBnNOVbDHoPB9P9c+XIeeBhUROgAhzIM5+KlcGj49d8/ZJ3RnXxn8OJUhECRQMclUjjob6ruXxyDYF58MIPrygNn0cki+UyyoGIcGeu/NTE4LitzcZHdntcAP4/xrMGuOKHZRXL0rvTWqL9Cm9z/KuyoX0GNpU6YMTUYsAYubbSL+VHMZxBRQfYZBlcJbyDWRVxPTN8tmgwlrxqulcyPp2p+ByycHK0pEkxj8VRyt86YdUtVQl4zH9m75DS/D2QvSppZzbfHoXViw2Ak8ATm2W30ERvWUe9lolCR9+4Bn0G6B3EaXNQJ1g/qc1i7qfJxOf8mC/8stRQug1lZs5z2BzgvDq2+pX97hohS8QSbG+YXKWZlkoB33r2DoRbl/8tGlTm7BmVI8ScC88Ai5sHkxIzXu337ftpjkigEVCwRDa9OpjorxcKgGSVZ5iVrrD4B/VEpXr7XyoyoNxLAF1aXiqcAllS2LAWqfTgbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(40480700001)(47076005)(7416002)(44832011)(2906002)(1076003)(26005)(41300700001)(8936002)(8676002)(40460700003)(186003)(426003)(83380400001)(478600001)(82310400005)(81166007)(356005)(82740400003)(7696005)(336012)(36756003)(36860700001)(2616005)(316002)(86362001)(70586007)(4326008)(70206006)(16526019)(54906003)(110136005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:56:56.2641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1880aeaa-7454-4ee6-eaa3-08db72d4b8db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The restricted CXL host (RCH) error handler will log protocol errors
using AER and RAS status registers. The AER and RAS registers need
to be virtually memory mapped before enabling interrupts. Update
__devm_cxl_add_dport() to include RCH RAS and AER mapping.

Add 'struct cxl_regs' to 'struct cxl_dport' for saving a unique copy of
the RCH downstream port's mapped registers.

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c | 33 +++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  1 +
 drivers/cxl/cxl.h       | 11 +++++++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 41e79a36c1ae..87a12e69aa8e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
+#include <linux/aer.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
@@ -943,6 +944,36 @@ static void cxl_dport_unlink(void *data)
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
+static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
+{
+	struct cxl_rcrb_info *ri = &dport->rcrb;
+	struct cxl_port *port = dport->port;
+	void __iomem *dport_aer = NULL;
+	resource_size_t aer_phys;
+
+	if (dport->rch && ri->aer_cap) {
+		aer_phys = ri->aer_cap + ri->base;
+		dport_aer = devm_cxl_iomap_block(&port->dev, aer_phys,
+				sizeof(struct aer_capability_regs));
+	}
+
+	dport->regs.dport_aer = dport_aer;
+}
+
+static void cxl_dport_map_regs(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->comp_map;
+
+	if (!map->component_map.ras.valid)
+		dev_dbg(map->dev, "RAS registers not found\n");
+	else if (cxl_map_component_regs(map, &dport->regs.component,
+					BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(dport->dport_dev, "Failed to map RAS capability.\n");
+
+	if (dport->rch)
+		cxl_dport_map_rch_aer(dport);
+}
+
 static struct cxl_dport *
 __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		     int port_id, resource_size_t component_reg_phys,
@@ -1002,6 +1033,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
 
+	cxl_dport_map_regs(dport);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 60b7ba7f4030..982ef79670c7 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
 
 int cxl_map_component_regs(struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9f46a4e1fbec..12f11cf8e280 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -209,6 +209,13 @@ struct cxl_regs {
 	struct_group_tagged(cxl_device_regs, device_regs,
 		void __iomem *status, *mbox, *memdev;
 	);
+	/*
+	 * RCH downstream port specific RAS register
+	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
+	 */
+	struct_group_tagged(cxl_rch_regs, rch_regs,
+		void __iomem *dport_aer;
+	);
 };
 
 struct cxl_reg_map {
@@ -255,6 +262,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
 int cxl_map_component_regs(struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
@@ -598,6 +607,7 @@ struct cxl_rcrb_info {
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
+ * @regs: Dport parsed register blocks
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -606,6 +616,7 @@ struct cxl_dport {
 	struct cxl_rcrb_info rcrb;
 	bool rch;
 	struct cxl_port *port;
+	struct cxl_regs regs;
 };
 
 /**
-- 
2.34.1

