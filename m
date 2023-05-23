Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A0C70E981
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbjEWXZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbjEWXZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:25:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C95FE68;
        Tue, 23 May 2023 16:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpwIqkVRM6B21xvkMy0jFGEFpb+K5ykF0uZ+0I38zCq/GiE5U/oW4/IFzmzNQMvE0EywsDByMNeOxSa0ncoEf3NGrMpM66f8c3+bDKZoMtoyStHc6k/B0M5dWNLnChJpTl1xvJQ4l9ua6sxzcb767SCtWxEU9GvyV60TGk1QVximHng7DZdYQ/SB/lReMfVVlpDvnvLRM2njAtAPuyBVEWglkeDDAGDWzehebGjT83awtuNV3AiwAwPYKgQrQADqkK4b2VIhWXzRmktFttxEvvCpGZBTxKGsXYIgqIxCKysUR0rZ2/3BLdqxrX+PUohAEjNwybaHUNMHVfxZYg9ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG+C/yH6FeEcl+1Yz1DOiJHYp6GBxwEEi/e75p4qm3A=;
 b=I2YcgLQpCGCoZWSraCiwB12wpJhIETOlp8nonVEDl3B5cngtHfS+2py1jhvR60FjNMsKQ9yM1gTSXzytrDp5MZRjl9R1dCrUEJcRvOAGepSmFT1h3uqxbzfsKYwwvbcAR34Klp/nhcfYRKA/lZ5mLENs94BnHJWJAiX7j4Kk9zdmBc12SzPMzNRSgO+PhVtrayr4HbMsmK0bCoP9BgXeyu61aNi4O4V/DG/oYV7Y3UgZbKlM4rvNx8X/n89Tt5bEGggBAi923ObiIT5kc4IdSWUB2MYxIExi3ALjx3vfWnTKRL+L+zNYhuGXiCT1fVV3X565MejYzUD978fOFxIPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG+C/yH6FeEcl+1Yz1DOiJHYp6GBxwEEi/e75p4qm3A=;
 b=Rj2hhKKYj+OWUTyzRGKwKVmn7Y6qlZSI6jYWezNqdxc9BDXVqoLEliRtq1ZgPjofBKTcfIHXpwk8DcKduLTR1/n8co8VLXM3Nil964kRRkJ3MtGOfBZWLsTgSg9Y5iS3qhw5fkEKg/+joR7Yf8poq1ktrBGj60j+ZnelTwW0ifY=
Received: from MW4PR04CA0282.namprd04.prod.outlook.com (2603:10b6:303:89::17)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:24:44 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::bc) by MW4PR04CA0282.outlook.office365.com
 (2603:10b6:303:89::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 23:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:24:43 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:24:39 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 09/23] cxl/pci: Early setup RCH dport component registers from RCRB
Date:   Tue, 23 May 2023 18:22:00 -0500
Message-ID: <20230523232214.55282-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523232214.55282-1-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT011:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 39418d08-762b-4c38-9af6-08db5be4e3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ss+Mtddbxearu9ke2LGLADJhAWSjXtvQqRIFN7oZ/iKM4R4hBlWHwMlv1nNKv6f2XniJIVPkfy64at5RlLCK/OsFTumtrbMT7GtOcNedJBVeryUPmgykcJUyWB46W1bgzQSUQFrGSf/E5LE8iEKZWf+nxGRCc/tZqGC3xDOmLl1/V9xFuYrSjM5DxD2YSPqQ+dP1016AsuHR7i9F5Qlzi64eypWb7avHJnvVamMNKGu7UzlmBFexaONidgTwsptAbHJpCFejmTioTBqipjdRDyDEU51mAKwTqVeAwo5jRNMMEd/WJ03GmP/NmUKmZZBdNF0KAa2S9qfuk7jI2FS5fPQGJ769hmJDjUv54Z9rDRCUZ9AuC/xKGFok9tS+RGwpVud+Ck2MHrCs/oCsGE4wG8u0a0gYnVFQbkfu59I25U+CiVwnL/djAASDghME3PhjnB3sVM3P3mUxpNYg2mjZJyZvqqYwety0Thu4D4PS/AYgztWOYGeR1HqC82nLyur6N/rwSfCby/f24g3AFFwuwiDiGZtA7CcEMcLdoHXvUzVWpWxuWSyvzkrIPGM3Tug/wxIBJha4a83G4A62OxYecI7i4DaclPy28RA/ua35n1B0iaoBkkKUQVc22eNjynlLGPJp47J0/eH0dFF/ESXXzhJ8olHp7jA5S+Psqn0CKxm/rDvcb5JPwgm2FGoy7OWqtUvrZH4ESiIlqV9I6qDTTrd8taVkUl+UhWge16882DvIzFAvEvdnzYXMCMpkYIdXijcg9YyhDwEajN5h6VoFKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(110136005)(82310400005)(82740400003)(86362001)(70206006)(70586007)(478600001)(54906003)(81166007)(356005)(36860700001)(83380400001)(2906002)(47076005)(7696005)(2616005)(36756003)(6666004)(336012)(426003)(316002)(4326008)(1076003)(7416002)(8676002)(8936002)(40480700001)(26005)(186003)(40460700003)(5660300002)(41300700001)(16526019)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:24:43.6296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39418d08-762b-4c38-9af6-08db5be4e3ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457
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
---
 drivers/cxl/core/port.c |  7 +++++++
 drivers/cxl/cxl.h       |  2 ++
 drivers/cxl/mem.c       | 12 ------------
 drivers/cxl/pci.c       | 37 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 66f567480238..eff91f141fde 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1477,6 +1477,13 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
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
index 7ecdaa7f9315..0643852444f3 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -65,18 +65,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 		ep->next = down;
 	}
 
-	/*
-	 * The component registers for an RCD might come from the
-	 * host-bridge RCRB if they are not already mapped via the
-	 * typical register locator mechanism.
-	 */
-	if (parent_dport->rch &&
-	    cxlds->component_reg_phys == CXL_RESOURCE_NONE) {
-		cxlds->component_reg_phys =
-			cxl_probe_rcrb(&cxlmd->dev, parent_dport->rcrb.base,
-				       NULL, CXL_RCRB_UPSTREAM);
-	}
-
 	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
 				     cxlds->component_reg_phys,
 				     parent_dport);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 945ca0304d68..54c486cd65dd 100644
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
+	 * Component Registers, try to extract them from the RCRB if
+	 * it is an RCH.
+	 */
 	rc = cxl_find_regblock(pdev, type, map);
-	if (rc)
+	if (rc && cxl_rcrb_get_comp_regs(pdev, type, map))
 		return rc;
 
 	return cxl_setup_regs(map);
-- 
2.34.1

