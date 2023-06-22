Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316EF7395FE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjFVD5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjFVD4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:56:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86062697;
        Wed, 21 Jun 2023 20:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJdL5lX47nf/5OCNqWWaUJ3kbZp9xATjrxnKas0rES/FQIIhsWuWWdpfGkDbs4fx3+QLBtRI9WtcnV7TwNEwytASOvdeZ7HVgOBzlZ0iLOOexG2eVH5Xyp93R9IpppYYVPnUwQf8FbpHyIsnVeHJcWaCuM48LoZibC8rE7uEwkJsdR7WyztMqiR+dUBdMEZK2wMr3XDF2/jeHuC8/Zak0yG3Z1jdTSfDPU/7ppc2zgMbeTxyyiRVZUEjr0HFR4b+9UNiMMJ1ogw5nyxUbDAPSipY7Cs5ZWNbJyDwtaDtslQ2z8eT19IvEZ1Ymv9oInFLSg9/irAHFoEKHA/XO6Nj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBvELRqVB7hvBd5b5FCHAc83MFI4yeW3soNfKmg7peE=;
 b=Htbk/SxhlR4+E8ni6Dv/bY3xWs8OaGYdPdP1O7HgoK67mWOYY4/dlB91nnwGrvcfRctDXhWJEVjJro2Ig23ONKbFOw7ajfZ2fF651i0YD8536MQOw9BxisdJ8IslBWmu3ktBUpxFLnxtpuI3gysw3ZuF0X1Ff/49vnikvjKsVs9efF+z1qDS4s32Q+AWnI3laVA613EX8/eDKjXmEX5lnbKWIMiIE2hIffc9/gsLrLG/6w/6Iq5wE6KyK6nA9/Y0MCtzsJh7fecZ1dfLeMmf+cgcIy68pIIwTXA99GxNVH43S5cU5hLHNf0LWGVaUFTZQztwraNm3VF23UHF6QH7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBvELRqVB7hvBd5b5FCHAc83MFI4yeW3soNfKmg7peE=;
 b=AMJZHmvND/YKcSB5YIKsaUU1ZgL4ekFb+mZ5jGDOX55LveQJo6p0eavusO7ku5BnDoe5N7pPCfxqMWldzOhgMbYN9GTEHtuhGWQ6zmVI+rnA84aDy1y0kXWpTQLaqIdRsbwe43/CoOaulqtm4HpVlWKSNbU/8mGU9RgxMFUUa0k=
Received: from BN9PR03CA0078.namprd03.prod.outlook.com (2603:10b6:408:fc::23)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 03:55:17 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::95) by BN9PR03CA0078.outlook.office365.com
 (2603:10b6:408:fc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 03:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 03:55:17 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:55:15 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 14/27] cxl/pci: Early setup RCH dport component registers from RCRB
Date:   Wed, 21 Jun 2023 22:51:13 -0500
Message-ID: <20230622035126.4130151-15-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|BL1PR12MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8838a9-fad3-44c1-a538-08db72d47db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZDDFp0X1JXT/2RvSptqLkztj+iN9HR3V1Jy6oQxH4y+Kn5r5UloUNto9s5cK46wZz1PfgQsJHZpDAXsOW6pjB85CPQYy3BNGfRco1sRFxklazLIHkV2ePa2AutKDldKoHQvg9htS4+AmKEG4wYuUprV+uNbLWAJwY09cUKTzJ7Ve0lkq1m4NHvxr6QAp+0yWf60rmihGeNM3WXJE6DaqSx+chg3lhYprPEJWrWyArKlzuj+VlriybfE8/AzDD16dhXS1gRsrJ/4f5WLuV9t97vZ0kjAV05VP7xwJ2RTLq4RJwz0vCH8HCG1tM4dXeRq7ZlaI11u9LWbiBBv4QXlhGzWJ7UT1oPgZuHTNv4y1Mbv5Um7QThdy16iiYRCHb0Yh0PJ7EnooTcc3N2+asiTSdS7pvLy/YYhNPeKtn+DYZKzKFqYn097O4+GmuXmKleNyH65zVrvctFBj6tRXiqTXznsNHMJrEbDAWCxW68eiDa+PP4uCUC9jHjqArIxy1gy6zjJKSyg4Dz8YRymH/QZJaGJJ0URQ/PHEbmHcHh3EdkM+9GR7IcGZ6D4zMwnxZ81MGulRc79a2Nckc4hstHm3FmZUUFi2W/aJNOJWaqwXcF/t+b/8n87L3Tp+ea5FvJbNOQ4cKAAFJ6DP2uKS8PhsniWhJu9+FCRP4JZHa2j4LUDnmj1R/zgM10KMMfFv1iskHKg6qKHu8IkLSrKyn2s6GH6eTeA1QWedSYiTXv6ZnFrjPBeWJtzT9oxqwJZUNW1MQcDwFIzkiYlb9cxyFsEvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(2616005)(86362001)(110136005)(478600001)(40480700001)(7696005)(16526019)(186003)(4326008)(41300700001)(316002)(47076005)(83380400001)(336012)(426003)(1076003)(26005)(70206006)(70586007)(82310400005)(8676002)(8936002)(5660300002)(36756003)(44832011)(7416002)(40460700003)(36860700001)(2906002)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:55:17.0474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8838a9-fad3-44c1-a538-08db72d47db8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
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

