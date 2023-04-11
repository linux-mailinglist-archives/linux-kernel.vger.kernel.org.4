Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD4A6DE36F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjDKSEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjDKSE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:04:29 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929F06A48;
        Tue, 11 Apr 2023 11:03:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1alQLzKEg2H/tXGvd4w6CaqljvaM3RW1R0gsDpaQqBpYrJJW73pWy2wn4hIfEoS0pCVPeBIi4oyjsqGl/hesjdMH6XF/6B4pxaoxFSW6vQ1kp3xST6N/FrlAO55h+0urufwHHnm49/pnZcgUtOW9+ryp8wwvH1idsvUj9yauUnmvifpQu0UjOSyZByhO20xykL4K6EDoSlvrPipOd5h7AqFkGwrRF/M+sX8K6dZoNcfPkmjt163nDcTAyZhUwXcEjWr0YRshy7qDXPanen0+QvbRz87AvPLXNobxzAHp1RRB4AbN01sF3ssEQ6QSYneSNFXtlqbhzTjVXbZp2uZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3P6ZpZ4Byd7FgMB+f1+rDbZwUVfEc3EjiGHpk2Yobk=;
 b=nBPcDMMzE2Chel5vRMPZLfrtfTWZ0o/DfSCUzSdNgcVf1kUZrV3YzPHH59KtstHh0V4Qn1ltfbnuMIBLUolIj+M12EIoXITCQbM7KPppou6CQVptQT9FvCHvzEMimjgSk6801jCcu95RyhvZCkGZ7OXxCpS/4ZSpDrWjCeoFS60kJ9SnHuhoBrmCra36RMKT3Rje9NepbFQr49Piwc3NUI0QmDVWlnV+5yslCy4NMzRe1INb8dHRSwXRJ9C2dX4nFlXqzJ90zI24x8ckpBYkLDBywSwX5ZZYqVqFqvAEbnGZdw0T8SeiYnhGH0sPhAmNSptdofE4Pw5DmVxho49xOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3P6ZpZ4Byd7FgMB+f1+rDbZwUVfEc3EjiGHpk2Yobk=;
 b=EwvyqoQyovibIZb2OcSZh+UrXCr3IaScsyoxvdFcEqMjf9lrvgvZBPPgQyl47smSqt+B5Ch/3ekI8XOl11g05KRu2DsT/NQovjeJjKHkaSttAmOW4cC0DMPnhevXxR2pjVGxxZShczOwXL35xnsbIAnxpEugH/wOkPvU0jAFRX4=
Received: from BN8PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:d4::23)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.35; Tue, 11 Apr 2023 18:03:24 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::86) by BN8PR04CA0049.outlook.office365.com
 (2603:10b6:408:d4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Tue, 11 Apr 2023 18:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.29 via Frontend Transport; Tue, 11 Apr 2023 18:03:24 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 13:03:23 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v3 1/6] cxl/pci: Add RCH downstream port AER and RAS register discovery
Date:   Tue, 11 Apr 2023 13:02:57 -0500
Message-ID: <20230411180302.2678736-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411180302.2678736-1-terry.bowman@amd.com>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7dd313-8306-41cc-86a5-08db3ab70b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sUFGJyL8V4y5zuln0KFmPAmG01vMrqxu1c2IL0FcwFMHxMWwzpM0r4IyCmswA5tGvxg2xp7fmpIMfZpGa2qOO4avtUBjEJrpmDhRhy49m4sUL/cCJAHoV7bPbm5fvY+POj2ipvsq87CadlpsU2kFblkiaus2HUCZqlJibfQopqGYhlC5OobcD2PBAj5Nxr5eD0FXb7FGe+a9bmVBYHx4MSN3rF+J0FoNF15+ZhxOAP0v8Hr9wP+vwSJjvK9yEsZ6ut88pSKMCcs8GkECRWih9vDS/gh/i4PX4hZSRxD6gLhhIcJRZpXzsZRDzpWjN2m8eU/oMB8tuOI1IaSDNIumG4oQybgBKolybqwoXEVFmQsdeW9JRE/p25pcM7gH3Zc92rKzFrETrnDAuaOdBE9hDNfl7ZK7aXVPgANvkj27q9WP3nHcS07x7S961nl2gmy8oT28e6WPlQcey+xhhAUXxpgSmhMcT7quZvO5V0RV2dPhcR3Ftosl8/NlhaDNMmg2hFresfj2t+4SIipUVOk3xwCZ4yntjMkGRi4/I9pj80ziyACB5Bh706VzdUqx8mLJFBItp+yVF8XtF1P6iAyg2Jik1Go51EsC7iBhenzGc85OxrdNdU7hTLQ0UL+oiCrI+aBqdYOixU8V8Wb3L7hypMj5wog58n/+tuaiOR2laiJbT/+NXJnagCNvmSU3xxt4SP145tUfdhGmcEichs7mR6M3gDEuP9yK1ZfaQgo6eI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(44832011)(36756003)(7416002)(40460700003)(82310400005)(2906002)(5660300002)(8936002)(8676002)(40480700001)(86362001)(7696005)(6666004)(26005)(1076003)(83380400001)(36860700001)(110136005)(54906003)(478600001)(47076005)(2616005)(426003)(336012)(16526019)(186003)(70586007)(70206006)(82740400003)(356005)(81166007)(41300700001)(4326008)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 18:03:24.4137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7dd313-8306-41cc-86a5-08db3ab70b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restricted CXL host (RCH) downstream port AER information is not currently
logged while in the error state. One problem preventing existing PCIe AER
functions from logging errors is the AER registers are not accessible. The
CXL driver requires changes to find RCH downstream port AER registers for
purpose of error logging.

RCH downstream ports are not enumerated during a PCI bus scan and are
instead discovered using system firmware, ACPI in this case.[1] The
downstream port is implemented as a Root Complex Register Block (RCRB).
The RCRB is a 4k memory block containing PCIe registers based on the PCIe
root port.[2] The RCRB includes AER extended capability registers used for
reporting errors. Note, the RCH's AER Capability is located in the RCRB
memory space instead of PCI configuration space, thus its register access
is different. Existing kernel PCIe AER functions can not be used to manage
the downstream port AER capabilities because the port was not enumerated
during PCI scan and the registers are not PCI config accessible.

Discover RCH downstream port AER extended capability registers. This
requires using MMIO accesses to search for extended AER capability in
RCRB register space.

[1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
[2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/regs.c | 93 +++++++++++++++++++++++++++++++++++------
 drivers/cxl/cxl.h       |  5 +++
 drivers/cxl/mem.c       | 39 +++++++++++------
 3 files changed, 113 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 1476a0299c9b..bde1fffab09e 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -332,10 +332,36 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
 
+static void __iomem *cxl_map_reg(struct device *dev, struct cxl_register_map *map,
+				 char *name)
+{
+
+	if (!request_mem_region(map->resource, map->max_size, name))
+		return NULL;
+
+	map->base = ioremap(map->resource, map->max_size);
+	if (!map->base) {
+		release_mem_region(map->resource, map->max_size);
+		return NULL;
+	}
+
+	return map->base;
+}
+
+static void cxl_unmap_reg(struct device *dev, struct cxl_register_map *map)
+{
+	iounmap(map->base);
+	release_mem_region(map->resource, map->max_size);
+}
+
 resource_size_t cxl_rcrb_to_component(struct device *dev,
 				      resource_size_t rcrb,
 				      enum cxl_rcrb which)
 {
+	struct cxl_register_map map = {
+		.resource = rcrb,
+		.max_size = SZ_4K
+	};
 	resource_size_t component_reg_phys;
 	void __iomem *addr;
 	u32 bar0, bar1;
@@ -343,7 +369,10 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 	u32 id;
 
 	if (which == CXL_RCRB_UPSTREAM)
-		rcrb += SZ_4K;
+		map.resource += SZ_4K;
+
+	if (!cxl_map_reg(dev, &map, "CXL RCRB"))
+		return CXL_RESOURCE_NONE;
 
 	/*
 	 * RCRB's BAR[0..1] point to component block containing CXL
@@ -351,21 +380,12 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 	 * the PCI Base spec here, esp. 64 bit extraction and memory
 	 * ranges alignment (6.0, 7.5.1.2.1).
 	 */
-	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))
-		return CXL_RESOURCE_NONE;
-	addr = ioremap(rcrb, SZ_4K);
-	if (!addr) {
-		dev_err(dev, "Failed to map region %pr\n", addr);
-		release_mem_region(rcrb, SZ_4K);
-		return CXL_RESOURCE_NONE;
-	}
-
+	addr = map.base;
 	id = readl(addr + PCI_VENDOR_ID);
 	cmd = readw(addr + PCI_COMMAND);
 	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
 	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
-	iounmap(addr);
-	release_mem_region(rcrb, SZ_4K);
+	cxl_unmap_reg(dev, &map);
 
 	/*
 	 * Sanity check, see CXL 3.0 Figure 9-8 CXL Device that Does Not
@@ -396,3 +416,52 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 	return component_reg_phys;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);
+
+u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
+{
+	struct cxl_register_map map = {
+		.resource = rcrb,
+		.max_size = SZ_4K,
+	};
+	u32 cap_hdr;
+	u16 offset = 0;
+
+	if (!cxl_map_reg(dev, &map, "CXL RCRB"))
+		return 0;
+
+	cap_hdr = readl(map.base + offset);
+	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
+
+		offset = PCI_EXT_CAP_NEXT(cap_hdr);
+		if (!offset) {
+			cxl_unmap_reg(dev, &map);
+			return 0;
+		}
+		cap_hdr = readl(map.base + offset);
+	}
+
+	dev_dbg(dev, "found AER extended capability (0x%x)\n", offset);
+	cxl_unmap_reg(dev, &map);
+
+	return offset;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, CXL);
+
+u16 cxl_component_to_ras(struct device *dev, resource_size_t component_reg_phys)
+{
+	struct cxl_register_map map = {
+		.resource = component_reg_phys,
+		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
+	};
+
+	if (!cxl_map_reg(dev, &map, "component"))
+		return 0;
+
+	cxl_probe_component_regs(dev, map.base, &map.component_map);
+	cxl_unmap_reg(dev, &map);
+	if (!map.component_map.ras.valid)
+		return 0;
+
+	return map.component_map.ras.offset;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_component_to_ras, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 044a92d9813e..df64c402e6e6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -270,6 +270,9 @@ enum cxl_rcrb {
 resource_size_t cxl_rcrb_to_component(struct device *dev,
 				      resource_size_t rcrb,
 				      enum cxl_rcrb which);
+u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
+u16 cxl_component_to_ras(struct device *dev,
+			 resource_size_t component_reg_phys);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
@@ -601,6 +604,8 @@ struct cxl_dport {
 	int port_id;
 	resource_size_t component_reg_phys;
 	resource_size_t rcrb;
+	u16 aer_cap;
+	u16 ras_cap;
 	bool rch;
 	struct cxl_port *port;
 };
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 39c4b54f0715..014295ab6bc6 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,13 +45,36 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
+static void cxl_setup_rcrb(struct cxl_dev_state *cxlds,
+			   struct cxl_dport *parent_dport)
+{
+	struct cxl_memdev *cxlmd  = cxlds->cxlmd;
+
+	if (!parent_dport->rch)
+		return;
+
+	/*
+	 * The component registers for an RCD might come from the
+	 * host-bridge RCRB if they are not already mapped via the
+	 * typical register locator mechanism.
+	 */
+	if (cxlds->component_reg_phys == CXL_RESOURCE_NONE)
+		cxlds->component_reg_phys = cxl_rcrb_to_component(
+			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
+
+	parent_dport->aer_cap = cxl_rcrb_to_aer(parent_dport->dport,
+						parent_dport->rcrb);
+
+	parent_dport->ras_cap = cxl_component_to_ras(parent_dport->dport,
+						     parent_dport->component_reg_phys);
+}
+
 static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
 	struct cxl_port *parent_port = parent_dport->port;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint, *iter, *down;
-	resource_size_t component_reg_phys;
 	int rc;
 
 	/*
@@ -66,17 +89,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 		ep->next = down;
 	}
 
-	/*
-	 * The component registers for an RCD might come from the
-	 * host-bridge RCRB if they are not already mapped via the
-	 * typical register locator mechanism.
-	 */
-	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
-		component_reg_phys = cxl_rcrb_to_component(
-			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
-	else
-		component_reg_phys = cxlds->component_reg_phys;
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
+	cxl_setup_rcrb(cxlds, parent_dport);
+
+	endpoint = devm_cxl_add_port(host, &cxlmd->dev, cxlds->component_reg_phys,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
-- 
2.34.1

