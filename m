Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D8973AB35
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjFVVJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjFVVJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:09:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DEC30F7;
        Thu, 22 Jun 2023 14:07:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDp3XiNUfg7gi7PIwyhbPUn5cX2lWvHw1kw9hOG1/bGZMHMmA0Uxpkh851hJ9cjU6+fjgo2JmDmzNtvuqwfgQAO65HXknjVrE3Ib+MSQncIWFczNcHkpRULHYlOH3BXnYRizBmo+7g2HsfvDrmrkVovmZ99J1DCKLza1PNjGhVYTZv4sA6DI1DbIHyMf4i9dZm+UWgsLrlmgKzFUIBy4WEzevbn5cYC46iP+pqaKwlSaCJznoWAUSKfQnkJR0L/d0m/uF5luYLJx6irc0ni5sc71UIwtWnVfzKagNAPhuLUBb0xdAjJRQtl8+oVbKHUwVomy0cdVi/XtSnkmFWbaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prJjsVv0acgU6k7PG156rIEUcdiwG7kzcb6KDwpfbBE=;
 b=Vdq+3HT1PzJPXPoKsscKyqpRRxIzMJJeDo2FWQcWHTLAyPqIBjFEfE87Fmid/qTJOLpBy9xr3AoqOahdEO/yAJilzolYamGx8a6fYIhKWfgDzna2ld4NTDt/VAHpFjJs0NG3cMcoiE5rBZ/zN9SLTgQJN8KNTwmfrvm/b1uIxV0hIBPWahUJ3F1DuCrTeXBUZksxH5C2PgIJ1MI+cd9WrRVxPtPBcjC4sFgQBS/oFlQJ5mMycrqn4atOmpuEg3ff8PgwLl/US0uQ7r+7WZEj7tESqbb5Mfv13qoymuZJkJi0tfLI624asr9MLrfQJAVCl+Zot0+B223OKmZRIS2luA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prJjsVv0acgU6k7PG156rIEUcdiwG7kzcb6KDwpfbBE=;
 b=hsBO9rKhAVFyMC1ejXaDSWQYBF2tPwjJjOtGYqwgC463vM50JVCaW40x7c/L8meh8sxRXUQncljO4EFkuU6+DaVbeXVwjEL4JYnwoXtm+j1f/4Z8AMl0awPBOLd7IBtIXnHSTRrUqBbS26lbExncZWEqQMXDbZph15Knad1vuns=
Received: from CY8PR02CA0003.namprd02.prod.outlook.com (2603:10b6:930:4d::10)
 by PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:59:35 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::98) by CY8PR02CA0003.outlook.office365.com
 (2603:10b6:930:4d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:59:35 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:59:34 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 22/27] cxl/pci: Map RCH downstream AER registers for logging protocol errors
Date:   Thu, 22 Jun 2023 15:55:18 -0500
Message-ID: <20230622205523.85375-23-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622205523.85375-1-terry.bowman@amd.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f54644-a7c3-4c8a-bd6f-08db73639590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxCwxi0wUlG0rwr5IPA/Mqyraf8l2zW5FJT0A0QFcDn6TEZl0zYuT07mihbBXQO1WpkkuDgGWvARsQs0BcbITO+MkFeluh68YeUph4V4stdiEvl/TnpBWmu/i5ASw4/+fQnBqgNTeT9dnXKvMhnDGmT73ChOLPITBb+QDffKWJYvF3OPXMrc5LQMbUZOoVITUiFbmn5oEr2arZqH1wRyIEQzPMMCU35tbjq+Z6R/DpBK8179f8VZUoMZ2gbYET4BAoab24zJ4Hy4dsi0rM5HSroxQK1CwqDs6noMrW99Pu7Jbmez+v01DszeUA+5hSqhoPertpNwy1eYXTjwFZwR2V+te/q6zEopQXpp7bYPlyGuZA1IsUpA/ejLvtVhYE1a7KUq1fygQOlCOQFXQupGTnIr8GJHCLAkZ6dtxX7mbND6uaajVS2zqOSwzK51yJFWvhvB1srn1HXnQpOrje/4qmDnBF3uZZTVvtFveH/Ccc5YmgxyMAU0bznGn+7sgbfh0xgqM9iZCOVmg/ii4ysheYDS63xWpiGbuYknq3c/rIYo51JhzYB5T09sfniD6YnjW9nDRwCqKo6WxXF5WxS1a29OU5gvQdEW5vF4RTYT4TTWik4WEF8firOsu1MOP5gUXInLcXKD5QCxqs5qZopYSxhWhpKlWOUcqfuCU6vRukJyOZkq+l6HHEOUwC8L/VIBUqlHHGMh+dHXtmS8d+bMYaXYCxDBa1RvEHQiEFp6ggpY/a7E6pWYbendvzTDGPYSwS6wqaepD21rw2uzxGn7JA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(8936002)(186003)(16526019)(8676002)(40460700003)(41300700001)(2906002)(26005)(1076003)(54906003)(110136005)(70206006)(86362001)(70586007)(4326008)(316002)(6666004)(478600001)(356005)(82310400005)(81166007)(7696005)(82740400003)(83380400001)(36756003)(336012)(426003)(2616005)(36860700001)(40480700001)(47076005)(44832011)(5660300002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:59:35.0210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f54644-a7c3-4c8a-bd6f-08db73639590
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The restricted CXL host (RCH) error handler will log protocol errors
using AER and RAS status registers. The AER and RAS registers need
to be virtually memory mapped before enabling interrupts. Update
__devm_cxl_add_dport() to include RCH RAS and AER mapping.

Add 'struct cxl_regs' to 'struct cxl_dport' for saving a pointer to
the RCH downstream port's AER and RAS registers.

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c | 33 +++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  1 +
 drivers/cxl/cxl.h       | 11 +++++++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 683f40e98119..a92794e6b7b4 100644
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
@@ -945,6 +946,36 @@ static void cxl_dport_unlink(void *data)
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
@@ -1004,6 +1035,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
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

