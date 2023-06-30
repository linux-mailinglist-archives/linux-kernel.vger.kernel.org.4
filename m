Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED7974451D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjF3XTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjF3XTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:19:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D274685;
        Fri, 30 Jun 2023 16:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKWPVCYGM+JaKPnHSu3lZt2in2rnblH7F6EDGNDVZSDc0O0l5YJfwSAYY7f/mlnZx2g7oobfeYLs7L0pPpF3QkynZkn8Pa/fUrrgHLHdWh90bLdgcYza7FewROESbB7Nw6WUh3tJ24G55vzinss+qsffXLwXewBW0dMGW/4U3YWZlynZ6b61+OuZAN/5HfcHVKQbo+ZKZRDJuFz2C6bg7Rb9X1bvXIKrm6V+KY5AYX2moSi83Zi5rZ0ACKLp8ktEyMQXbiqOML7swyyzKG7lE5U512vCF863ctWKOxwXZdU2bCtijDLzCU/K+Bi3x+/riDEs76M51pIH+43JVrVQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpZZlFSQ39FD4xZ/cKtRMaQoFJzsy066BpuHtqs9uS0=;
 b=NqH8ONQfuzHzCjAEEO7cmcx21jGX5YYsEjh9IO6P4P49+RF1COQ7PxxEeh8dQTI5YVm4rE6G1m1Y4+MivWxvrPzvrTAS3A9jTX57W8czebEUiqdbv3Uj2kJyjGYfaaqAcNWdb6KqbF3PydZK65DpepBSpBv/ZYix2at6fWpPiWKAdCbZ9/Rr2aIGgFROLC5TEjtGml3muLP6BQHr4U00+0l3sYKDb6DtrYDWhAvYolLaPgFa/F5fiefoYXtYZcyBLIfy8o7eS8/CyyLvlLPIKpaRnoDxxvnVPoNBNZvXa5MNLfQrl3ban7VmxNu9OYh1o+2iotd/M/fiMSH1pPj+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpZZlFSQ39FD4xZ/cKtRMaQoFJzsy066BpuHtqs9uS0=;
 b=FvnAmbuF0VaMukSjTuYqGX4UjXLzwhIRu9jCmOP1fdL/SCIEbPp79Y4iHNHJOl0PEDkxRvyCzlQiBX30p7F3DBWbYUgi1XOIGxYIGTU3INWz26OYdVkP7GwAhAUN6STli3GeBXM9YRFNhbsoXDLwdrKLnkQkAGFHPujo+f/nj/k=
Received: from DM6PR02CA0161.namprd02.prod.outlook.com (2603:10b6:5:332::28)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 23:18:33 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::fd) by DM6PR02CA0161.outlook.office365.com
 (2603:10b6:5:332::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 23:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 23:18:33 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 18:18:28 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v8 09/14] cxl/pci: Map RCH downstream AER registers for logging protocol errors
Date:   Fri, 30 Jun 2023 18:16:30 -0500
Message-ID: <20230630231635.3132638-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630231635.3132638-1-terry.bowman@amd.com>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef1abe6-7617-478d-bbe8-08db79c052e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2uVLxPHdBR2cN4sOtTJmd7S0fORhu9kECJqiAtjSmhH0ekbyRY/WUT0ORxVfddadXemUdUYnHh2nKG4WFDBP1gP+ugnl8+u/98+zbaYigw1v5hbVYzAhuyUH+7LWy9pKGD1cAVUf1H5lkqLbVFpxAamKMqAADQ/02FJJSX7CbjnFpabO0T++U724fTPAdAPZd4hbPu0qRfvZXDjzL/gzeMb6GzswMUcck3nPE4bFK9OJSb9rIjf1OlQ+wHGJvylU7mGyTOqTqQEIoEnmy7ogxbDkt+9VjOEDtUlVDxetYgmm8MplrDbF/BNjHPztBA6B4qtjG9+nsjJ0N6WeguaspRo/PPx7Qk+pILT8v6U8sZF1ty+R7xLc2okFQ47VLbI9PtIkUySao7xyA7lQl2pwbX21IBBgO7WVB1wyGblGN58B/GhdvBS9YW14y9w5uVoUCcvtCzGIkmaJOyXiLSZ3TnS/PnKEUVMkKTwgWaSR8kErcGf2np48vVg4c8xPYaBKGjFAYCFVe/RZ5uvo4kq8NDpl5DPhj4jLAqI0ryZFrbhBoKFLBRpKMflV4VxVUDH8+dYQ5w6NtDd5S7sr9+ADGsQQ+Vmn3+g4s5qT5q88n5g5tWmuE7fnrxFJOcFBV6ycscpQIywjHQ+gc7dRugwG0T2WSQaXeHI1qvOP8PQKrKe7M0QlI9WZMrQI+ScFFzCZ1IteLB1u4UfMEKWoSjq0AgLgsuF+55E0seEUUAQRFCqXA+NEnrVD/ZtQBeAiFiV1pWVstywZpwC8tC3SWuSTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(54906003)(8936002)(8676002)(5660300002)(82310400005)(110136005)(7416002)(26005)(44832011)(1076003)(7696005)(478600001)(4326008)(70206006)(70586007)(41300700001)(316002)(6666004)(16526019)(186003)(2616005)(2906002)(40460700003)(83380400001)(47076005)(336012)(426003)(36860700001)(36756003)(40480700001)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 23:18:33.4007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef1abe6-7617-478d-bbe8-08db79c052e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 33 +++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  1 +
 drivers/cxl/cxl.h       | 12 ++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f3bb7ea37b44..a482341c0d89 100644
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
@@ -948,6 +949,36 @@ static void cxl_dport_unlink(void *data)
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
+		dev_dbg(dport->dport_dev, "RAS registers not found\n");
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
@@ -1007,6 +1038,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
 
+	cxl_dport_map_regs(dport);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index b34192bad2af..2360b480c5c5 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
 
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6c045a13ecf3..ec656abad9b3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -221,6 +221,14 @@ struct cxl_regs {
 	struct_group_tagged(cxl_pmu_regs, pmu_regs,
 		void __iomem *pmu;
 	);
+
+	/*
+	 * RCH downstream port specific RAS register
+	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
+	 */
+	struct_group_tagged(cxl_rch_regs, rch_regs,
+		void __iomem *dport_aer;
+	);
 };
 
 struct cxl_reg_map {
@@ -273,6 +281,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
@@ -623,6 +633,7 @@ struct cxl_rcrb_info {
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
+ * @regs: Dport parsed register blocks
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -631,6 +642,7 @@ struct cxl_dport {
 	struct cxl_rcrb_info rcrb;
 	bool rch;
 	struct cxl_port *port;
+	struct cxl_regs regs;
 };
 
 /**
-- 
2.34.1

