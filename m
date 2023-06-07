Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411617271A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjFGW1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjFGW1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:27:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDDF272B;
        Wed,  7 Jun 2023 15:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRyvyV/DJC/vKH3OpZboKeMnyxZPyyv/nanfgxHzR1l/tBk6vZKbRScKeqTngfYj8rf3SvyoMdB0zHVcCGWUn/eQi/wJs/jNjCwgrFe4ghlCSAAygFf2+6dzLPmDp8cD3lwgi70FwX6EaqPAQ7C7nW2+0CmB+NaZp7luQOZ1IPCm8HQxrcm6cIpV0wrjNL/zWY6oAWDKBhkB2Rp5b62/c3hfbLNK/+bfRzxBiZoExHvxEu3BtAQoypw/AwccszMZ0d3hXwTxQgNJdR15cycQwdUmsNTf7Hak8M93DZacTy9P3IgC4duOoeSByP1iro6bPzZZi4tY0MHKdE3UPd0jXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM1WCiToGUlyjJml7EjvT9iHn+CXlR9V8Lhschak3TM=;
 b=HJaJCxnOS+n+2oeziYo5Neb8kWiwiEiJz3CEXlXIuEsnZf+jnyWk68QqCBK/jNeBUGoYfdY2LAS+mHChGH7uJC+radC5UprYY7vKX8miDY6RYvRqM9fJ/oAdlxwTknlhmM37rnO545/4uMjm8hz1F3SDnBhrP/iMQmB91XKyB/eflrM3bbQblkid3FKYF6t/oMKzOFh7H05QcxSToz1ZoeXeLGeuAW9R9LmDw2BNbvooKjhf1VDgIVdbp+rYOqWk7pShPoPnsaA91zFdZraZpH/kFR3wlq10b4qAVnVD3EeDtMl5oXTpzmJAP3P4OlRoihQ+xg+DauPv52PfhOAt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM1WCiToGUlyjJml7EjvT9iHn+CXlR9V8Lhschak3TM=;
 b=O2gwDC4BiUYXJDfSMDxjBb+Z4f5T0wtlEQKdXaIa+SKZBjYG7fBXv0OnwzYA2tVgw2NmbtqKm/4Z1DiDR9PHwg/F2yHW9ZoDYiBTbxgNw8Mkv/OmNieWFPCYZRAm4oWTmFGtOP7pkQyuGhhs8hcdnGb7Vg+tOqypLCQQ9y81GZE=
Received: from CY8PR12CA0068.namprd12.prod.outlook.com (2603:10b6:930:4c::8)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:21:09 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:4c:cafe::91) by CY8PR12CA0068.outlook.office365.com
 (2603:10b6:930:4c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:21:08 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:21:07 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 22/26] cxl/pci: Map RCH downstream AER registers for logging protocol errors
Date:   Wed, 7 Jun 2023 17:16:47 -0500
Message-ID: <20230607221651.2454764-23-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607221651.2454764-1-terry.bowman@amd.com>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6f52b3-220f-41b2-75ef-08db67a57ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UP3h+63TA7ykCPqwAK0AOVa2nNZ/HXxTdnWKkCSDUSheQjj86wQoKlFnpXLyAwLD6uKuqRXaT8+EvG+ndvnxBiloABhJmxkq39tmHsJgo+kzfNFbeX+wqH7H9E8lsP+KMyWX7vxrn/18IXp6ihZHe4Mwk7tmGZnty37ANSHcLOTrQxvx3RP+LNipay5hIkg78GQqnXcdXr825YnoxDjGvwfMk2Otxpel4Ph6//dL4lHqfdcYvz5YAt7NrhISUG1lap0hGd7mDefF7+4Hjtxk1xTsOo7XXFSZf5EIX4YjwQsdGeGIuYARkuGnv7Cv/iP6s/X5APr0S0ZUKVx0t20vBpwPjR/XcAJU2bw6qHOXNDr+RpXxWNd6qf9gnTkmt5uYmjqs7gge4sjQa7L1BwWPBciVFVzOnePa0o27YptVUhSCZb/AT/nBUKFpICkfsBf8oBW1GAKPte5FQZtARoALtBcYaQJ9nsCD5waeAAD3o2TnlhthmInabUmOxf/pUdfQpZ0d69/gUWgKOrU8hVWZKVfnlK2bUTgHzQzG4ve6cpgdqlgjVEIuIoPKfAGyN8VsJBMdE7YaJ1nyZT2N+AMGzn0YBjG3WhLYB7aQzXrHyZc5TMKD18cOSk6Uo7Ho8yApFXZmXf8yO7wSusvb4KfcGPbiuD80MBq5MXEJs0pwMiOg/wiGCMTcYem+yNr5oyuwDopxbz1RDPkxyyt99G3OG+oE76SVxTPz2XjJvuTAsUSfQIFp1NsXHl0ev4hFsLU/Ym7ieaaqUdHVoaP8sPmBIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(110136005)(40460700003)(478600001)(40480700001)(44832011)(8936002)(8676002)(7416002)(2906002)(36756003)(5660300002)(86362001)(82310400005)(4326008)(81166007)(70206006)(70586007)(356005)(82740400003)(316002)(2616005)(1076003)(41300700001)(16526019)(47076005)(26005)(36860700001)(186003)(83380400001)(336012)(7696005)(6666004)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:21:08.0893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6f52b3-220f-41b2-75ef-08db67a57ddd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/cxl/core/port.c | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  1 +
 drivers/cxl/cxl.h       | 11 +++++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 3111f754c740..bc5d0ee9da54 100644
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
@@ -947,6 +948,39 @@ static void cxl_dport_unlink(void *data)
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
+static int cxl_dport_map_rch_aer(struct cxl_dport *dport)
+{
+	struct cxl_rcrb_info *ri = &dport->rcrb;
+	resource_size_t aer_phys;
+	void __iomem *dport_aer;
+
+	if (!dport->rch || !ri->aer_cap)
+		return -ENODEV;
+
+	aer_phys = ri->aer_cap + ri->base;
+	dport_aer = devm_cxl_iomap_block(dport->dev, aer_phys,
+					 sizeof(struct aer_capability_regs));
+	if (!dport_aer)
+		return -ENOMEM;
+
+	dport->regs.dport_aer = dport_aer;
+
+	return 0;
+}
+
+static int cxl_dport_map_regs(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->comp_map;
+
+	if (!map->component_map.ras.valid)
+		dev_dbg(map->dev, "RAS registers not found\n");
+	else if (cxl_map_component_regs(map, &dport->regs.component,
+					BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(dport->dev, "Failed to map RAS capability.\n");
+
+	return cxl_dport_map_rch_aer(dport);
+}
+
 static struct cxl_dport *
 __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		     int port_id, resource_size_t component_reg_phys,
@@ -1000,6 +1034,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc && rc != -ENODEV)
 		return ERR_PTR(rc);
 
+	rc = cxl_dport_map_regs(dport);
+	if (rc && rc != -ENODEV)
+		return ERR_PTR(rc);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index dd6c3c898cff..26fb4f395365 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
 
 int cxl_map_component_regs(struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6134644b51f8..0e0bcbefefaf 100644
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
@@ -603,6 +612,7 @@ struct cxl_rcrb_info {
  * @port_id: unique hardware identifier for dport in decoder target list
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @rcrb: Data about the Root Complex Register Block layout
+ * @regs: Dport parsed register blocks
  */
 struct cxl_dport {
 	struct device *dev;
@@ -611,6 +621,7 @@ struct cxl_dport {
 	int port_id;
 	bool rch;
 	struct cxl_rcrb_info rcrb;
+	struct cxl_regs regs;
 };
 
 /**
-- 
2.34.1

