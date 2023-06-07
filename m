Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C51F727176
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjFGWUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjFGWUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:20:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F87270C;
        Wed,  7 Jun 2023 15:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0CCSpyOz/Y/Zwn8L/t2LwWevFUtpbBIj4c/7yTxkahuYQBeLhQUxUT3r7nY8p4J+AoyZI5+ZIKVEeH+Jt/9KdAkYQXgE8isF+RVmfN5MC4CFBdZTkSp1J7wRxNLOrg9N/m0PnrWVFyqjv89bpe/nuMXGjCnZkh5wHNLQYMs9HKDJKe5QEHOG9S25tvi5LHoyWr/E6cyfTr9r1l0trvV4RelXEXU7XDAbf2fOQmFwjX1tPf5iFm8CBlAyFdqGsu5HaMSl6Bf11YfoZ8Vu6u+nhssXPADuQnUb4WLZ2o0l5joGCC8xUSGSPctez0g8vPeFU6sgZKvsdrkHHb/LBlzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFtk+FAACaSejDjIUCr0zn1C0KbSNuTSqMQYkLEYSW4=;
 b=R+FBVYSplQOaJGlf9pRPl/sn1ptxgvM6Ql06kecosMrf9G7Zbw2oD2K4GuXer7M9ok+n5+7wrk/H8nZYHRbKpufyP8r7aLcRs7t9WQPPQfsPPBf0gl09JGEMuwyshz4n75LpqlKK6ZpT0NHroPTNb6X5rhw6COx6TmZVd/zNVk5heh5220mnEg2OHg26wfp1looSkPGu1Ig9kHfppptgxvhmLLCD7UzBIBOLfcVVrRnELBtPBYNZ9gYBzSDlZKPwv39J87XzzT22c++/l15NvG/FAg3b/rGweu8BY2ocl/nFfr5+nxYPPVJZKkCVwmW6RuUyK/ahcr/TBHMuhH9tPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFtk+FAACaSejDjIUCr0zn1C0KbSNuTSqMQYkLEYSW4=;
 b=mrG9bqnKmVSwxlYHwWLKCWOiKAKFrXrVt0TzROWUD8y6mbkDStGopmVL2R/0olMoUdkTwzsvmOo/swmypeNuFY6MOD7eLWP8DGOmqsMorRzelUWNTs0PfA1IiprwEaukWfMfa+KZNr6V7rDJ0KdeUSIxtAGRWwdlPyktt7G2ZeI=
Received: from SN4PR0501CA0055.namprd05.prod.outlook.com
 (2603:10b6:803:41::32) by MW6PR12MB8866.namprd12.prod.outlook.com
 (2603:10b6:303:24c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 22:19:08 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:803:41:cafe::ac) by SN4PR0501CA0055.outlook.office365.com
 (2603:10b6:803:41::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:19:07 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:19:06 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 11/26] cxl/pci: Early setup RCH dport component registers from RCRB
Date:   Wed, 7 Jun 2023 17:16:36 -0500
Message-ID: <20230607221651.2454764-12-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: a986f0bf-0325-4e0c-c975-08db67a5361b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAse6f0ZXOgNM13FNG5TacbqNd3xjCWtHOXAJUcENtzNKOnBz5MfEQgdlWHCtAdZyn3YCw45M+H8sSW/zKr0EsI8gSVRWuqrrVgY1LRrDl4nmtLcVn6SNaeRXwn08ZbkAITySSThbqVNCME4iVippWQnMBqV7Oi0g45tfCFlgg1reM5RJqrOUMLe3jZONX9oXG9ss89TrvnPpF61qhHeYQAEnB8zjO20hyxdryjVoSR6q8l9T/4olspVEIARp4Umi3S+of0/gjeyOeV8nvV9yZ+Wc2Cv+0l6X5sMco1feaGh2JfbqnPcCblMwATZT9AYQEQvVms2SsXuGXhLReWHtZXNAbsp8un3VYG47foYwIYzKY+zF5MhTuV/c2wWTdv8sPFX1IZiEAPpxWL41Izq4xPQN2HKxHx6ZiYTb7daZiUtJLL0IVsTEoVPPRreG0DiEGPO/mwGLDN+lFpBwFuEmrSpTO+uky/WeGvh1D8mYPQInQYnriErIGjf+zEBUL0kXg25gMrFjG31783O4iWicGx96RLRetBK+OlX9ubygDlkYF2Geqt9ijh/2V2/fWNsN6/DUYN6zwBJgmEHAY4DoSNkjmYCNTbEbc6e8FF3dFGQxzEBuGxv3+zI2UY40PrrRzstKl6PUBBgxOVQYA6Ri5dRIrsXmLp8VY3pHneYBRefr63PoB4uX2OuQpTKPCShU1nLuB+k1HehzqJ1L0iOJyM4Q5hcev6+UboG8bZUMOQeWBXiP0pCMCIsNHgbgIp6CuIB1cg70d7Q2oDTp00E2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(40480700001)(40460700003)(70586007)(36756003)(81166007)(70206006)(82740400003)(356005)(110136005)(54906003)(4326008)(7416002)(2906002)(5660300002)(44832011)(86362001)(82310400005)(41300700001)(8936002)(316002)(8676002)(478600001)(186003)(16526019)(336012)(426003)(36860700001)(83380400001)(2616005)(6666004)(47076005)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:19:07.7643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a986f0bf-0325-4e0c-c975-08db67a5361b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
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

From: Robert Richter <rrichter@amd.com>

CXL RAS capabilities must be enabled and accessible as soon as the CXL
endpoint is detected in the PCI hierarchy and bound to the cxl_pci
driver. This needs to be independent of other modules such as cxl_port
or cxl_mem.

CXL RAS capabilities reside in the Component Registers. For an RCH
this is determined by probing RCRB which is implemented very late once
the CXL Memory Device is created.

Change this by moving the RCRB probe to the cxl_pci driver. Do this by
using a new introduced function cxl_pci_find_port() similar to
cxl_mem_find_port() to determine the involved dport by the endpoint's
PCI handle. Plug this into the existing cxl_pci_setup_regs() function
to setup Component Registers. Probe the RCRB in case the Component
Registers cannot be located through the CXL Register Locator
capability.

This unifies code and early sets up the Component Registers at the
same time for both, VH and RCH mode. Only the cxl_pci driver is
involved for this. This allows an early mapping of the CXL RAS
capability registers.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c |  7 +++++++
 drivers/cxl/cxl.h       |  2 ++
 drivers/cxl/mem.c       | 10 ----------
 drivers/cxl/pci.c       | 37 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 82de858506c7..8b688ac506ca 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1476,6 +1476,13 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
 
+struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
+				   struct cxl_dport **dport)
+{
+	return find_cxl_port(pdev->dev.parent, dport);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_find_port, CXL);
+
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1c6fe53e9dc7..e5ae5f4e6669 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -670,6 +670,8 @@ struct cxl_port *find_cxl_root(struct cxl_port *port);
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
+struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
+				   struct cxl_dport **dport);
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport);
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index a34d6560c25c..0643852444f3 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -65,16 +65,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 		ep->next = down;
 	}
 
-	/*
-	 * The component registers for an RCD might come from the
-	 * host-bridge RCRB if they are not already mapped via the
-	 * typical register locator mechanism.
-	 */
-	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
-		cxlds->component_reg_phys =
-			cxl_probe_rcrb(&cxlmd->dev, parent_dport->rcrb.base,
-				       NULL, CXL_RCRB_UPSTREAM);
-
 	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
 				     cxlds->component_reg_phys,
 				     parent_dport);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 945ca0304d68..2975b232fcd1 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -274,13 +274,48 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
+/* Extract RCRB, use same function interface as cxl_find_regblock(). */
+static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
+				  enum cxl_regloc_type type,
+				  struct cxl_register_map *map)
+{
+	struct cxl_dport *dport;
+	resource_size_t component_reg_phys;
+
+	memset(map, 0, sizeof(*map));
+	map->dev = &pdev->dev;
+	map->resource = CXL_RESOURCE_NONE;
+
+	if (type != CXL_REGLOC_RBI_COMPONENT)
+		return -ENODEV;
+
+	if (!cxl_pci_find_port(pdev, &dport) || !dport->rch)
+		return -ENXIO;
+
+	component_reg_phys = cxl_probe_rcrb(&pdev->dev, dport->rcrb.base,
+					    NULL, CXL_RCRB_UPSTREAM);
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return -ENXIO;
+
+	map->resource = component_reg_phys;
+	map->reg_type = type;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
+	return 0;
+}
+
 static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 			      struct cxl_register_map *map)
 {
 	int rc;
 
+	/*
+	 * If the Register Locator DVSEC does not contain the
+	 * Component Registers, assume it is an RCH and try to extract
+	 * them from an RCRB.
+	 */
 	rc = cxl_find_regblock(pdev, type, map);
-	if (rc)
+	if (rc && cxl_rcrb_get_comp_regs(pdev, type, map))
 		return rc;
 
 	return cxl_setup_regs(map);
-- 
2.34.1

