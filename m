Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD01607E75
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJUS5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJUS4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:56:51 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2042.outbound.protection.outlook.com [40.107.96.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DF628E06D;
        Fri, 21 Oct 2022 11:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUFvp9ImtWMjH64DprJdPt+JwojGOr1uMiDek6bPgDfFAtdzDKNDlbAx6K6rDGAJ+VCeavTi9wU9dSSURr1zRBlnKIQjk8YzNeVsITCFwCZOzxyBy8ligmIBcothrbMrepz1+OlbwxEt1CV9auM1rHuHuMMSzi9Otvh+r92ALLpGOSZaTRseRKI7fWjC28OHcm2ZPJ9U8cntMwWON0AcO52NsK0hKtz0yAoEiViVoou5vQTOap6xEeeI2yRkxoDa4BualHfFIhWUhajkQ9Av6F/WAJzSLFlJQtyhNkrUy9H4KnskcRsaWOkHY7qWUSV7pqrqg+vHIqkx8mjbup5t+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+8ygDnWYxrVFXWLHgnB8BUyt5hlla6dTF1pKqeRd8g=;
 b=P65/D/ues+RtXgyywMTAy2LwY53aZLt0xy7xqbrUTeOx7NZeHYunypujIGFzL/64zZi9XBXYdTAeuLm7o3WndUuF7nVIhnz6SBDegXN5ZWA1HtXNnmniwyis7RtBmXAGMRwfFA2MoAJceXVI8oOWqY4La254+06l/RjEWtQBI0LNF7fGrCFqF2PEfGEM1VLytF9rFM5UCB4j4YB+ucgloECudg9hrn05CEktrwGnj4mfrltTZ/DOAQUlNfUpPztNoNWvDNBr6hjwcR2CjU/j+q0opW5ttrk7pT4iQZx3Lpg5Q2UMqIGv4NmcX8vmZMFQ5fNOhdcZxnVd0T8kMl8F/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+8ygDnWYxrVFXWLHgnB8BUyt5hlla6dTF1pKqeRd8g=;
 b=0DiHuCeE3kUfEzj4RFhrBXdwvDOUVjb41HySleLPSk6zuUp/azMJEhabBdgwUzETMDvSC0a4KPZzrO2Ds+P1HaYHohgVBZDwrUckhiJFVb0KZ6/RufJwIoG8ta6LEYjCIcz6AZnteO0HgA64ACyTv6Az1W5ZJe6n5iGBEkBmSEc=
Received: from BN9PR03CA0964.namprd03.prod.outlook.com (2603:10b6:408:109::9)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 18:56:44 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::6) by BN9PR03CA0964.outlook.office365.com
 (2603:10b6:408:109::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21 via Frontend
 Transport; Fri, 21 Oct 2022 18:56:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 18:56:43 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 13:56:42 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>
Subject: [PATCH 2/5] cxl/pci: Discover and cache pointer to RCD dport's PCIe AER capability
Date:   Fri, 21 Oct 2022 13:56:12 -0500
Message-ID: <20221021185615.605233-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021185615.605233-1-terry.bowman@amd.com>
References: <20221021185615.605233-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: d33bc205-64cd-4261-3b61-08dab395ff12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +bNO+/Xx7t5gCcrmwTwkQFIIOdUdvjud+fTIvPSFt956x0cXtmnTexzqzcoNoJDuwpf+mryl6s4At7MTxFOCXYKgddZk9mFJVUbvuaTJWUjtklC05Hvb7Oh1tZSbnRP4OBr5FjkUhMrQKh6RsAmNHm16Jk4se/fSMI1zh/8ioo9nCo1lNU6BiyjFqgE94eHa/GWXK4rr91IlqEvaE9tGvapnNMbPIAVA2HVV8zstmt2hG+0TWG7SnOFQSZsFdV87OLamct+G8UxvJS3GrMEZUMhrD+5lYMULZwr9gNvPStvyrwtwvf0lgThoIPuyNTWu35B/W5mZu7wDuZenN1lMGqygWUti6HKG+1ZHawcJdcA8lTRpYha65w9UjxbbtIU5t3owsFoXEVCi7kQtHTxB/aO9P5GmgLVOxI1NaIC89W9F/NTlU4sI6x23oIfPWI9EQwaHHkB1KNyshv1uulRRQ3uk1+pfpmbcfcMsFyDgEZtRinm5a6OYKLV6Yl0ZPVYHxqYfMuF7GraT0Q9nzS5hjC0/fr3vBKQ8NDyuJK4berp+HQgzaa6FAdF9a2kr/OJWdrbFIaNrbJSjY5tuHNLubhfUR5jqhSgr+86Ud2ZnlBMsKTmQPoswCBbj9ofo2SZ4maHYt0jVMkm/GZm2s0TgFFo/WdeI3s0t/hf+XA868fk3VAyoVJ9MIUUofhl6CRA0UGPbZJ6m/oP8V3oI3qXk/Hph505V3xyXBYxoHLkhSMKhly5HWtyRg4IlPwXmOxxembiKu8tqnUc0rLPyaBEC+tpc+WX7rv+670De7bF3juoHLSu4mA+VU50wtUPkV3g3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(41300700001)(83380400001)(44832011)(2906002)(40460700003)(316002)(1076003)(110136005)(16526019)(186003)(2616005)(54906003)(36860700001)(8936002)(36756003)(5660300002)(40480700001)(26005)(336012)(6666004)(70586007)(7416002)(7696005)(426003)(8676002)(70206006)(86362001)(47076005)(82310400005)(4326008)(82740400003)(478600001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 18:56:43.6761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d33bc205-64cd-4261-3b61-08dab395ff12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CXL downport PCIe AER information needs to be logged during error handling.
The RCD downport/upport does not have a BDF and is not PCI enumerable. As a
result the CXL PCIe driver is not aware of the AER in 'PCI Express'
capability located in the RCRB downport/upport. Logic must be introduced to
use the downport/upport AER information.

Update the CXL driver to find the downport's PCIe AER capability and cache
a pointer for using later. First, find the RCRB to provide the
downport/upport memory region. The downport/upport are mapped as MMIO not
PCI config space. Use readl/writel/readq/writeq as required by the CXL spec
to find and operate on the AER registers.[1]

Also, add function to detect if the device is a CXL1.1 RCD device.

[1] CXL3.0, 8.2 'Memory Mapped Registers'

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/acpi.c      |  56 ++++++++++++++
 drivers/cxl/core/regs.c |   1 +
 drivers/cxl/cxl.h       |   9 +++
 drivers/cxl/cxlmem.h    |   2 +
 drivers/cxl/mem.c       |   2 +
 drivers/cxl/pci.c       | 158 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 228 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index bf251a27e460..5d543c789e8d 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -232,6 +232,7 @@ struct cxl_chbs_context {
 	struct device *dev;
 	unsigned long long uid;
 	struct acpi_cedt_chbs chbs;
+	resource_size_t chbcr;
 };
 
 static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
@@ -417,6 +418,61 @@ static void remove_cxl_resources(void *data)
 	}
 }
 
+static const struct acpi_device_id cxl_host_ids[] = {
+	{ "ACPI0016", 0 },
+	{ "PNP0A08", 0 },
+	{ },
+};
+
+static int __cxl_get_rcrb(union acpi_subtable_headers *header, void *arg,
+			  const unsigned long end)
+{
+	struct cxl_chbs_context *ctx = arg;
+	struct acpi_cedt_chbs *chbs;
+
+	if (ctx->chbcr)
+		return 0;
+
+	chbs = (struct acpi_cedt_chbs *)header;
+
+	if (ctx->uid != chbs->uid)
+		return 0;
+
+	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11)
+		return 0;
+
+	if (chbs->length != SZ_8K)
+		return 0;
+
+	ctx->chbcr = chbs->base;
+
+	return 0;
+}
+
+resource_size_t cxl_get_rcrb(struct cxl_memdev *cxlmd)
+{
+	struct pci_host_bridge *host = NULL;
+	struct cxl_chbs_context ctx = {0};
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+
+	port = cxl_mem_find_port(cxlmd, NULL);
+	if (!port)
+		return 0;
+
+	dport = port->parent_dport;
+	ctx.uid = dport ? dport->port_id : 0;
+	if (!dport)
+		return 0;
+
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, __cxl_get_rcrb, &ctx);
+
+	dev_dbg(&host->dev, "RCRB found: 0x%08llx\n", (u64)ctx.chbcr);
+
+	return ctx.chbcr;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_rcrb, CXL);
+
 /**
  * add_cxl_resources() - reflect CXL fixed memory windows in iomem_resource
  * @cxl_res: A standalone resource tree where each CXL window is a sibling
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index ec178e69b18f..0d4f633e5c01 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -184,6 +184,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
 
 int cxl_map_component_regs(struct pci_dev *pdev,
 			   struct cxl_component_regs *regs,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ac8998b627b5..7d507ab80a78 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -204,6 +204,14 @@ struct cxl_register_map {
 	};
 };
 
+struct cxl_memdev;
+int cxl_pci_probe_dport(struct cxl_memdev *cxlmd);
+
+void cxl_pci_aer_init(struct cxl_memdev *cxlmd);
+
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
+
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
@@ -549,6 +557,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
 	return port->uport == port->dev.parent;
 }
 
+resource_size_t cxl_get_rcrb(struct cxl_memdev *cxlmd);
 bool is_cxl_port(struct device *dev);
 struct cxl_port *to_cxl_port(struct device *dev);
 struct pci_bus;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 88e3a8e54b6a..079db2e15acc 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -242,6 +242,8 @@ struct cxl_dev_state {
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
 
+	struct cxl_register_map aer_map;
+
 	resource_size_t component_reg_phys;
 	u64 serial;
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 64ccf053d32c..d1e663be43c2 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -74,6 +74,8 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	cxl_pci_aer_init(cxlmd);
+
 	parent_port = cxl_mem_find_port(cxlmd, &dport);
 	if (!parent_port) {
 		dev_err(dev, "CXL port topology not found\n");
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faeb5d9d7a7a..2287b5225862 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -35,6 +35,15 @@
 	(readl((cxlds)->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET) &                  \
 	 CXLDEV_MBOX_CTRL_DOORBELL)
 
+/* PCI 5.0 - 7.8.4 Advanced Error Reporting Extended Capability */
+#define PCI_AER_CAP_SIZE 0x48
+
+/* CXL 3.0 - 8.2.1.3.3, Offset to DVSEC Port Status */
+#define CXL_DVSEC_PORT_STATUS_OFF 0xE
+
+/* CXL 3.0 - 8.2.1.3.3 */
+#define CXL_DVSEC_VH_SUPPORT 0x20
+
 /* CXL 2.0 - 8.2.8.4 */
 #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
 
@@ -428,6 +437,155 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
 	}
 }
 
+static resource_size_t cxl_get_dport_ext_cap(struct cxl_memdev *cxlmd, u32 cap_id)
+{
+	resource_size_t rcrb, offset;
+	void *rcrb_mapped;
+	u32 cap_hdr;
+
+	rcrb = cxl_get_rcrb(cxlmd);
+	if (!rcrb)
+		return 0;
+
+	rcrb_mapped = ioremap(rcrb, SZ_4K);
+	if (!rcrb_mapped)
+		return 0;
+
+	offset = PCI_CFG_SPACE_SIZE;
+	cap_hdr = readl(rcrb_mapped + offset);
+
+	while (PCI_EXT_CAP_ID(cap_hdr)) {
+		if (PCI_EXT_CAP_ID(cap_hdr) == cap_id)
+			break;
+
+		offset = PCI_EXT_CAP_NEXT(cap_hdr);
+		if (offset == 0)
+			break;
+
+		cap_hdr = readl(rcrb_mapped + offset);
+	}
+	iounmap((void *)rcrb_mapped);
+
+	if (PCI_EXT_CAP_ID(cap_hdr) != cap_id)
+		return 0;
+
+	pr_debug("Found capability %X @ %llX (%X)\n",
+		 cap_id, rcrb + offset, cap_hdr);
+
+	return rcrb + offset;
+}
+
+bool is_rcd(struct cxl_memdev *cxlmd)
+{
+	struct pci_dev *pdev;
+	resource_size_t dvsec;
+	void *dvsec_mapped;
+	u32 dvsec_data;
+
+	if (!dev_is_pci(cxlmd->cxlds->dev))
+		return false;
+
+	pdev = to_pci_dev(cxlmd->cxlds->dev);
+
+	/*
+	 * 'CXL devices operating in this mode always set the Device/Port
+	 * Type field in the PCI Express Capabilities register to RCiEP.'
+	 * - CXL3.0 9.11.1 'RCD Mode'
+	 */
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
+		return false;
+
+	/*
+	 * Check if VH is enabled
+	 * - CXL3.0 8.2.1.3.1 'DVSEC Flex Bus Port Capability'
+	 */
+	dvsec = cxl_get_dport_ext_cap(cxlmd, PCI_EXT_CAP_ID_DVSEC);
+	if (!dvsec)
+		return false;
+
+	dvsec_mapped = ioremap(dvsec, SZ_4K);
+	dvsec_data = readl(dvsec_mapped + CXL_DVSEC_PORT_STATUS_OFF);
+	iounmap(dvsec_mapped);
+	if (dvsec_data & CXL_DVSEC_VH_SUPPORT)
+		return false;
+
+	return true;
+}
+
+#define PCI_CAP_ID(header)	(header & 0x000000ff)
+#define PCI_CAP_NEXT(header)	((header >> 8) & 0xff)
+
+static resource_size_t cxl_get_dport_cap(struct cxl_memdev *cxlmd, int cap_id)
+{
+	resource_size_t offset, rcrb;
+	void *rcrb_mapped;
+	u32 cap_hdr;
+
+	rcrb = cxl_get_rcrb(cxlmd);
+	if (!rcrb)
+		return 0;
+
+	rcrb_mapped = ioremap(rcrb, SZ_4K);
+	if (!rcrb_mapped)
+		return 0;
+
+	offset = readl(rcrb_mapped + PCI_CAPABILITY_LIST);
+	cap_hdr = readl(rcrb_mapped + offset);
+
+	while (PCI_CAP_ID(cap_hdr)) {
+		if (PCI_CAP_ID(cap_hdr) == cap_id)
+			break;
+
+		offset = PCI_CAP_NEXT(cap_hdr);
+		if (offset == 0)
+			break;
+
+		cap_hdr = readl(rcrb_mapped + offset);
+	}
+	iounmap((void *)rcrb_mapped);
+
+	if (PCI_CAP_ID(cap_hdr) != cap_id)
+		return 0;
+
+	pr_debug("Found capability %X @ %llX (%X)\n",
+		 cap_id, rcrb + offset, cap_hdr);
+
+	return rcrb + offset;
+}
+
+static int cxl_setup_dport_aer(struct cxl_memdev *cxlmd, resource_size_t cap_base)
+{
+	struct cxl_register_map *map = &cxlmd->cxlds->aer_map;
+	struct pci_dev *pdev = to_pci_dev(&cxlmd->dev);
+
+	if (!cap_base)
+		return  -ENODEV;
+
+	map->base = devm_cxl_iomap_block(&pdev->dev, cap_base,
+					 PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1);
+	if (!map->base)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void cxl_pci_aer_init(struct cxl_memdev *cxlmd)
+{
+	resource_size_t cap_base;
+
+	/* CXL2.0 is enumerable and will use AER attached to `struct pci_dev` */
+	if (!is_rcd(cxlmd))
+		return;
+
+	/*
+	 * Read base address of the PCI express cap. Cache the cap's
+	 * PCI_EXP_DEVCTL and PCI_EXP_DEVSTA for AER control and status.
+	 */
+	cap_base = cxl_get_dport_cap(cxlmd, PCI_CAP_ID_EXP);
+	cxl_setup_dport_aer(cxlmd, cap_base);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_aer_init, CXL);
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
-- 
2.34.1

