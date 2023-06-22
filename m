Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EC573AA8D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjFVVBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjFVU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:59:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02ED2729;
        Thu, 22 Jun 2023 13:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2WBAFJV+3PKUnNEV3EFTDeaaMtzadWOP4alnCEtzurpUsUyfn9M/Pqth8SKAF13BWKTA1FJdhz7D8Axizh23dwhYV7KlnRFq80JF3d7HpKuElfuF2TvE/eHAcd0FRgfrQ2w/VPfuHyIyDwBYfQr2rTkmXxVhMP4Zr6O3rcl2ivktopV5YkYaw9qvoYkVRk1X5QkQcQ/w+9fvVjSiwSgvwGnLwAQqlfFymo7EadEgS5jtW+meGsWzyvt08BuoLAv+qbz0AleHRpB1nS6hNkzwbMOk+HcdAua7aCt58BPiEwm1P2kGclXL7+OlIfo+VCX8IihEKs32vSdetqlhtPFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBvELRqVB7hvBd5b5FCHAc83MFI4yeW3soNfKmg7peE=;
 b=W+sRjYiC/x3zXHXIum9U5PT3HXtYX/QFpgPLJu9eZCgnfuXfltFx/QSj7ZaGoySua3u0q3IdE543YCTmMmHcCEg3Macdr2AAwykqcfA2H2+/cHjKHbl2N7g+MNIyLcFzX6/xekIIYrDKKMmFYrgvxs1/5O9i8uGk1RYNhVP3TePIezYXDMao3h0wcLiiM4UYdOVlNBm6+fxzzrnyuCSBKEeqGnZKS6jeZj6ZY9WPlhSYdLEbDrzbsKmYi7vNFw33Y1mLPXd0RDXs6zLychEuNRDxYStB00ZOJ+KCg2pkMSr+Rt0RzUvVsiVnRue5xBIwbqm/cCzo0W6nXqPmyU9X+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBvELRqVB7hvBd5b5FCHAc83MFI4yeW3soNfKmg7peE=;
 b=W6TUYHZ3JuosUkW4Xqpo2REaDK4ESo5PpTsxMRPEQwm4c3BAhGNYHfpxWAUs952Xt5AnQiyFLasikiy81Bdbu4cW+ZfhfFmBGXnfDq3ftcggwYNL4G4EzdNHchJHN4vtzkp5AgOy2j/ZroKlLgq6L0ikWVDAPSy1QBWKsoSTjpI=
Received: from CYZPR11CA0018.namprd11.prod.outlook.com (2603:10b6:930:8d::27)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:57:56 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:8d:cafe::cc) by CYZPR11CA0018.outlook.office365.com
 (2603:10b6:930:8d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:57:56 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:57:55 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 13/27] cxl/pci: Early setup RCH dport component registers from RCRB
Date:   Thu, 22 Jun 2023 15:55:09 -0500
Message-ID: <20230622205523.85375-14-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MN0PR12MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: f0134999-1cc0-4fca-67b4-08db73635aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixBBSoz/OxTk4x6a9v760/AFHxsWih1+3JwusR1McsCGdS8dPIcrHwkrSqv6KbCHGHw1LpsdH1j+xTzX8F41a1U6fowaeoIYZM7E7Qfr9KA1ByZfTNvZFBvfYX38+fxUkt22/L4bgZvkm4rzhECCjjmIvd59kvt7RqB6lLr+RsODzTGFlCDJZ69VNik3Vts+nn2vm4ICZgpGOM6Y8cNWYSM4FYS1DLzAwsE+dXseNCDDfgrIMMSw+Mcm0j7Bk1gkUKBzZ/q9OP6RxH5CbXAoHycUtrDXPmSwYbyUFJT1XB4Q8wmyjiuQY0Ux0VMGRXKQjZo2T0gfXQAAx8WsBhvmPS/McpoIg57bGm7sgp5cdogQstKS+Jtl3VPv+Bh+ZQcPijzZbBdxLW3jLEkAShTklipFtrh0VP14XCO5dtkiCT8EC2a+3QB/WPtqg0W9eoKD//X5/YAWGrvHsCRBdwnJgbKpalKX1mq4+p1XtgB7rzxoSsXIKhIyE5PLotPWD3+cHAFRzHX1g1JBH5rQs6Si3gDrKYqkymZ2bTNxn9W3HILeNYVZ6pJFxCazx8dC19RoxtjMUTWHVvti+Rg+tXGAgBi+5QDMoAQsff2kwKvg/exOAI8e7ORVh1/uQIh4HEKtZLp+p2nO455sBKL8WOFi3q6puXE+2d3UoPmLj5Q8fze4fe++UVKUGlicZDgnKNIkJTt8OhkBliD4bl8J1UKClynjXnY58/L+6Wa45IKGreki966pCrsklYwBTxmmP+8pQFJnyvIVXlgQxYx/OL0zEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(4326008)(36756003)(6666004)(2616005)(54906003)(316002)(81166007)(70586007)(82740400003)(70206006)(83380400001)(7416002)(36860700001)(47076005)(44832011)(1076003)(86362001)(426003)(2906002)(7696005)(5660300002)(8676002)(8936002)(26005)(186003)(16526019)(40460700003)(336012)(41300700001)(40480700001)(110136005)(356005)(478600001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:57:56.1593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0134999-1cc0-4fca-67b4-08db73635aa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/cxl/core/port.c |  7 +++++
 drivers/cxl/cxl.h       |  2 ++
 drivers/cxl/mem.c       |  9 -------
 drivers/cxl/pci.c       | 57 ++++++++++++++++++++++++++++++++++-------
 4 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e0d2e7596440..679226023f0c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1480,6 +1480,13 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
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
index 7fbc52b81554..fe95f08acb69 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -664,6 +664,8 @@ struct cxl_port *find_cxl_root(struct cxl_port *port);
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
+struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
+				   struct cxl_dport **dport);
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport);
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 7638a7f8f333..205e2e280aed 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -65,15 +65,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 		ep->next = down;
 	}
 
-	/*
-	 * The component registers for an RCD might come from the
-	 * host-bridge RCRB if they are not already mapped via the
-	 * typical register locator mechanism.
-	 */
-	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
-		cxlds->component_reg_phys =
-			cxl_rcd_component_reg_phys(&cxlmd->dev, parent_dport);
-
 	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
 				     cxlds->component_reg_phys,
 				     parent_dport);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 945ca0304d68..99a75c54ee39 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -274,27 +274,66 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
+/*
+ * Assume that any RCIEP that emits the CXL memory expander class code
+ * is an RCD
+ */
+static bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
+
+static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
+				  struct cxl_register_map *map)
+{
+	struct cxl_port *port;
+	struct cxl_dport *dport;
+	resource_size_t component_reg_phys;
+
+	*map = (struct cxl_register_map) {
+		.dev = &pdev->dev,
+		.resource = CXL_RESOURCE_NONE,
+	};
+
+	port = cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return -EPROBE_DEFER;
+
+	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
+
+	put_device(&port->dev);
+
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return -ENXIO;
+
+	map->resource = component_reg_phys;
+	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
+	return 0;
+}
+
 static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 			      struct cxl_register_map *map)
 {
 	int rc;
 
 	rc = cxl_find_regblock(pdev, type, map);
+
+	/*
+	 * If the Register Locator DVSEC does not exist, check if it
+	 * is an RCH and try to extract the Component Registers from
+	 * an RCRB.
+	 */
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
+		rc = cxl_rcrb_get_comp_regs(pdev, map);
+
 	if (rc)
 		return rc;
 
 	return cxl_setup_regs(map);
 }
 
-/*
- * Assume that any RCIEP that emits the CXL memory expander class code
- * is an RCD
- */
-static bool is_cxl_restricted(struct pci_dev *pdev)
-{
-	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
-}
-
 /*
  * CXL v3.0 6.2.3 Table 6-4
  * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
-- 
2.34.1

