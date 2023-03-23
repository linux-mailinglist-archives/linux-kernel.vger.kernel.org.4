Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A8F6C7264
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCWVie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCWVib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:38:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51240CDCA;
        Thu, 23 Mar 2023 14:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF3anK6ytoelsF/Laynx4d5jeBF/k9RdkECcGilXJdsYb8v+F+8s0lQF62bdLwaj2+YcNEkUdY5zoXnxLoaONW7bnnnWX87/VIXP5sDEQ27enfiDyqOqIT+5jUeoURhbO+h4K3aWZi/vDFPzv9gEScXxRavT5MRaHYE2zlf0kWlhQrosuaurZCdTsvHiG57gO/hsXyIyNmrUXzy2VLOMvWr6fSPRQGctMzq1il2wPPIOxPQ4334puiXXjiqDDZJSJvkIwBvh2FhpVaUVdNBs6vqcEbGfqlAmRoahc/IcAiDFXy5yhK3qHCiFMF4UkGK6iJdS5NhfFI1b05CHotfA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt908iITx8CzmAgTweWqu2SCENJjyQQA2v6kFbA1Nwg=;
 b=buDyQQS8kpTW4+P/xvIghT08Eeh+sXGyF4Jnr/nfuTZDJqPeyl0G1liSeuP/oD7AD39WllWLpANrftCgnB9YGcDFMFWETj1WNB8oL+hWCD0b6ATXj0YCZ1WaqRwRS0t3LPhmwVTrcySg5RyhI9ezr+H0SUU6QbBfN7oIXR7Tr/cF20hpIKlvoBSPQ3bRbk361VTZMytdPcGUJWu/zuIHICMGA2TCSWA6s2jlQ6y8VhxgdkTtrIAT6wtSmxMGvkukJmRVk+GtCR4cu/Zrpe0M95lKzndLzkGpYjp2BaaYlnua2AiPmwqlGhLZ4mRX/ZUvur6EnogkKRDpcA5ifVPC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt908iITx8CzmAgTweWqu2SCENJjyQQA2v6kFbA1Nwg=;
 b=Eo3WT5fWnHsSqYftkDy8zAwKy5OSLw/g86m/3KeGGUMHHSjaz9oYGrsczThw6s5FEBbZTK+eDYQueriBDdf7h48UHVAKu6EWxqWjQE+wlSXvTZGQXRYlGA/aP34YQhtGR9/0Dp95ZsipG+GuhHUHk2erJCluYcw7tBiM+y8L/mk=
Received: from DS7PR03CA0304.namprd03.prod.outlook.com (2603:10b6:8:2b::16) by
 SJ0PR12MB5455.namprd12.prod.outlook.com (2603:10b6:a03:3ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 21:38:26 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::ff) by DS7PR03CA0304.outlook.office365.com
 (2603:10b6:8:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Thu, 23 Mar 2023 21:38:26 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:38:25 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v2 1/5] cxl/pci: Add RCH downstream port AER and RAS register discovery
Date:   Thu, 23 Mar 2023 16:38:04 -0500
Message-ID: <20230323213808.398039-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323213808.398039-1-terry.bowman@amd.com>
References: <20230323213808.398039-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|SJ0PR12MB5455:EE_
X-MS-Office365-Filtering-Correlation-Id: de8a8f64-3268-4509-aacf-08db2be6ef7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/7l+nxkVSJVusnBoUGvZfqQqL3R8x0J9HX+PmhyDjWyg2lhryXDaSFUqW2Oe68YIF3QI/ydsrpDE/oCBiceOeXWyTDj5hZ/1uzfsvsNI3ncitpFQh4Ur8zNdJet18Hkb0lVqxjRRsF3FGmvp5m5CaCB7La7XwVJ9LVJzbYpL6lcSrecKY2u3J3X+Ye4kbS3vBWeMAVtH6JBRfiICpSNSpL8Msg9NwFg7vrj+ReOegnY+0CFKSQmT6PhqJ4Dpq8vWWvKkZHVax2ZxzRDFYD37h9j6p+D8ABjRGCR6AI4mGoblQp9VYhpnuoRWphrHoLp8rCVSD4SLP9DNp8rcYaGbUtX7WrAorjsAauucizC1baoFD1QhTdNux/je9ly3VTpQF0IJ9a3wi1eA/g4qMPiexkgi6z/1H24MEwqNXyxQPznwaLmEbLH7H1MSk3r8u6co0Odb+zW7S8w1rhZYg9Js7zOdS+IUWVA/yPq/ispwbQbLWevcvkMKzHdutnAzLHVzMKDP8Ac0bT+71THFDMhGOs3y5DK3eMin1fzg53aYwP4ICrF0lipwFlv36TFtCsghjGUGIfmJalJvuQiARsTm2vFQkAjLAKTHoSI7qlYq7mtHf0CGVeu09ys0i8bWHk161TzUiKMGuyTkAv2sXxyWQ8UDQKGq8GHJ275S/b4P0/rPHWT8D6qH67asicrCMg6LSPMhg4/WmBO9PFMhul/g2n1ojeC8P9Q8cGs61EuY4x75fVfoT/95PtuvFQLCf1r
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(36860700001)(8676002)(4326008)(70586007)(70206006)(54906003)(6636002)(41300700001)(5660300002)(7416002)(44832011)(82740400003)(26005)(47076005)(426003)(81166007)(1076003)(8936002)(6666004)(16526019)(316002)(186003)(478600001)(83380400001)(2616005)(336012)(7696005)(110136005)(36756003)(82310400005)(86362001)(40480700001)(2906002)(921005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:38:26.2738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de8a8f64-3268-4509-aacf-08db2be6ef7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5455
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/cxl/mem.c       | 41 ++++++++++++------
 3 files changed, 115 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 1476a0299c9b..108a349d8101 100644
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
+		return 0;
+
+	map->base = ioremap(map->resource, map->max_size);
+	if (!map->base) {
+		release_mem_region(map->resource, map->max_size);
+		return 0;
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
index d853a0238ad7..9fd7df48ce99 100644
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
index 39c4b54f0715..12e8e8ebaac0 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,13 +45,38 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
+static void cxl_rcrb_setup(struct cxl_dev_state *cxlds,
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
+	/* RCH AER is required. CXL3.0 Spec Table 8-12 */
+	parent_dport->aer_cap = cxl_rcrb_to_aer(parent_dport->dport,
+						parent_dport->rcrb);
+
+	/* RCH RAS is required. CXL3.0 Spec Table 8-22 */
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
@@ -66,17 +91,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
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
+	cxl_rcrb_setup(cxlds, parent_dport);
+
+	endpoint = devm_cxl_add_port(host, &cxlmd->dev, cxlds->component_reg_phys,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
-- 
2.34.1

