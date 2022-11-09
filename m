Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0C46228B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiKIKlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiKIKlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:41:36 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9392F20F53;
        Wed,  9 Nov 2022 02:41:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9lCMjtg8fSYmtfpfULWM5yVsxDvbUoxrFAZrGFQzaTnjM6GxIxQMe3f3yVMXSIa7PvMFmYPyAUgMsyscdKSW9QKkd9aacRLWo3E1sZOgH8l0j8sYUgLB8KdXN9AggQP8LC6m7c4l+G9NXZAJNRStjbCRAX0NhOVPrjFPHU0/QvHpXnAZhiPm/Y57g0O74nANHqx17o1imX+CBuc+WKWLiNPIo4cmgQqOJ8u+6vK1j9Q8SKxW0ETMbG/uKgBkwCxy5bff6X2kriypePglIMZbv2/EF9nY/qHgbZ1o24/uY77cAvdSUUsPRGfNk85vEkucH7qCE6RHidBfNeJwzUbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m51gZr/Au402nQk28eiPuqysiEP2aEYXRP0YUNs5RU=;
 b=g/XhWxDyYxZ18qH6o3yHteGw8Do4l9UJeMCns0FY73TtKI1K3Q3qshNdNK0Slg0Nw7xQzN0ifjAqL7qT4Ulr79zwmCVxpaedjttLwt3fx8Ur0KlcPTAEuyCoFKtShStpk1rSHTpfMeRZjQHnE7PenD5Ctrbq1gVvnr8Nf22IGx5AIqWC3kdn2wqSmn0l9xFgof4bmoyEObjMtHdELUZz9l/afHOaAewcIUkib1WKWhctzQ/x7YoljZaPphRKicvceGIyaQw7DHalmhXr+uB5NITWPBM1w1i+/NGmaKqQUwjSYxPfXUH/JlYgkFlOIvjz4lD9toMGoo2GlLSQOx//pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m51gZr/Au402nQk28eiPuqysiEP2aEYXRP0YUNs5RU=;
 b=bQs4W61CxuGS1n3hzTtc3D2wV5chWZ2g3jeeFAJvf8fOUyl/pmhGc+oKvfmjar/B0eNXvA7qtm8L1bYejt0xvvG/qMU1hvCvJRisKWm7WiUReilLru9v9GVAMIigyePVktLKhST2JpAGin2G6QtS8Wb5JrVqdljH6Hl0HLgqWxw=
Received: from BN9P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::7)
 by CH2PR12MB4923.namprd12.prod.outlook.com (2603:10b6:610:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 10:41:29 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::81) by BN9P220CA0002.outlook.office365.com
 (2603:10b6:408:13e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12 via Frontend
 Transport; Wed, 9 Nov 2022 10:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:41:29 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 04:41:23 -0600
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: [PATCH v3 2/9] cxl/acpi: Extract component registers of restricted hosts from RCRB
Date:   Wed, 9 Nov 2022 11:40:52 +0100
Message-ID: <20221109104059.766720-3-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109104059.766720-1-rrichter@amd.com>
References: <20221109104059.766720-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|CH2PR12MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6d1dab-4814-41d7-8e06-08dac23ef5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wmkdADamZuswThwb1jWVgc7+BuSEywsgFc6v7y+YZWi5YUdKp8h24+50ai2O7FyxePqlCSKjIV4ykOIltHfcFfIQE0KsM1BX2d6G5giWOuQFEl5LpKkYkLeSjK7BPST1L0bTse2RCN8ru33j+K0ZvLoMa7n8EvUzYb5U1uH1tpmVGLE22+SRD11b4PiDMRKB67/LKlO0AgGtgUynJRVyp9oZIIwPBm+DNkj4w8nEd42nK1ef7zaVwRREIzuIJwpT+kM4gLf5qCIxiJ2ejq5e6XhVgvnVqr4wwhOZuNqxi2EaI/MkSqGvoY0lNqfyY8k5rwFCxVXFExhLpH9dsTvkxDgDUgMsklGf0L9gRhZE/v1NPCx6JwOZxIvRP+d0VI7PhWGAYPu63zYUsTUy05RfAj4fLFLHuGo+h9HTteWLZJoi/A983xFvxGAckKF/vTovu2nGYeHCzKP1BiOWZTjsArh/TtWCCc1YprQJd34FKRZL853Xo5Tgl5l8k9du/v0orRzX6FDRdRH48BYSiSIHvkBwnUWMiU4XDGsvs+4hTGfFS/Y43LVvhBUHpsS3wV9n21QOXClwQ0ap44BqofCMIO66XoLYKZiDFd0wdaqwSavnOfnSYDBzvK9ebHN2nlokR3QCSBX1PkZZcDIqJ6H80wx8yO3JMFf5ClvMFTe6H3N0cX4v5cCkvDxF2fZhZAbHQ0QfIs1CVLbENRrWCNbrjnvs/r0GvWlN7dv8fflr8eZ5MG+l4FhLVr8PnQF8JL2F4Rv1dvc4bfZff8F+dfeZBWwc2njCwcGGt5yZmTZJmt0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(478600001)(356005)(110136005)(81166007)(6666004)(54906003)(316002)(336012)(36860700001)(82740400003)(70206006)(70586007)(4326008)(26005)(41300700001)(8676002)(8936002)(36756003)(2616005)(186003)(1076003)(16526019)(5660300002)(7416002)(2906002)(40480700001)(47076005)(426003)(83380400001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:41:29.3789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6d1dab-4814-41d7-8e06-08dac23ef5d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4923
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A downstream port must be connected to a component register block.
For restricted hosts the base address is determined from the RCRB. The
RCRB is provided by the host's CEDT CHBS entry. Rework CEDT parser to
get the RCRB and add code to extract the component register block from
it.

RCRB's BAR[0..1] point to the component block containing CXL subsystem
component registers. MEMBAR extraction follows the PCI base spec here,
esp. 64 bit extraction and memory range alignment (6.0, 7.5.1.2.1).

Note: Right now the component register block is used for HDM decoder
capability only which is optional for RCDs. If unsupported by the RCD,
the HDM init will fail. It is future work to bypass it in this case.

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c      | 43 +++++++++++++++++++++++++++++---------
 drivers/cxl/core/regs.c | 46 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  8 +++++++
 3 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 06150c953f58..caea42cf9522 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -9,6 +9,8 @@
 #include "cxlpci.h"
 #include "cxl.h"
 
+#define CXL_RCRB_SIZE	SZ_8K
+
 static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
 	unsigned long flags = CXL_DECODER_F_ENABLE;
@@ -240,27 +242,46 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 struct cxl_chbs_context {
 	struct device *dev;
 	unsigned long long uid;
-	resource_size_t chbcr;
+	struct acpi_cedt_chbs chbs;
 };
 
-static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
-			 const unsigned long end)
+static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
+			const unsigned long end)
 {
 	struct cxl_chbs_context *ctx = arg;
 	struct acpi_cedt_chbs *chbs;
 
-	if (ctx->chbcr)
+	if (ctx->chbs.base)
 		return 0;
 
 	chbs = (struct acpi_cedt_chbs *) header;
 
 	if (ctx->uid != chbs->uid)
 		return 0;
-	ctx->chbcr = chbs->base;
+	ctx->chbs = *chbs;
 
 	return 0;
 }
 
+static resource_size_t cxl_get_chbcr(struct cxl_chbs_context *ctx)
+{
+	struct acpi_cedt_chbs *chbs = &ctx->chbs;
+
+	if (!chbs->base)
+		return CXL_RESOURCE_NONE;
+
+	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11)
+		return chbs->base;
+
+	if (chbs->length != CXL_RCRB_SIZE)
+		return CXL_RESOURCE_NONE;
+
+	dev_dbg(ctx->dev, "RCRB found for UID %lld: 0x%08llx\n",
+		ctx->uid, (u64)chbs->base);
+
+	return cxl_rcrb_to_component(ctx->dev, chbs->base, CXL_RCRB_DOWNSTREAM);
+}
+
 static int add_host_bridge_dport(struct device *match, void *arg)
 {
 	acpi_status status;
@@ -272,6 +293,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	struct acpi_pci_root *pci_root = to_cxl_pci_root(host, match);
 	struct device *bridge;
 	acpi_handle handle;
+	resource_size_t component_reg_phys;
 
 	if (!pci_root)
 		return 0;
@@ -287,19 +309,20 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	dev_dbg(match, "UID found: %lld\n", uid);
 
 	ctx = (struct cxl_chbs_context) {
-		.dev = host,
+		.dev = match,
 		.uid = uid,
 	};
-	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbcr, &ctx);
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs, &ctx);
 
-	if (ctx.chbcr == 0) {
+	component_reg_phys = cxl_get_chbcr(&ctx);
+	if (component_reg_phys == CXL_RESOURCE_NONE) {
 		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n", uid);
 		return 0;
 	}
 
-	dev_dbg(match, "CHBCR found: 0x%08llx\n", (u64)ctx.chbcr);
+	dev_dbg(match, "CHBCR found: 0x%08llx\n", (u64)component_reg_phys);
 
-	dport = devm_cxl_add_dport(root_port, bridge, uid, ctx.chbcr);
+	dport = devm_cxl_add_dport(root_port, bridge, uid, component_reg_phys);
 	if (IS_ERR(dport))
 		return PTR_ERR(dport);
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index ec178e69b18f..7a5bde81e949 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -307,3 +307,49 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return -ENODEV;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
+
+resource_size_t cxl_rcrb_to_component(struct device *dev,
+				      resource_size_t rcrb,
+				      enum cxl_rcrb which)
+{
+	resource_size_t component_reg_phys;
+	u32 bar0, bar1;
+	void *addr;
+
+	if (which == CXL_RCRB_UPSTREAM)
+		rcrb += SZ_4K;
+
+	/*
+	 * RCRB's BAR[0..1] point to component block containing CXL
+	 * subsystem component registers. MEMBAR extraction follows
+	 * the PCI Base spec here, esp. 64 bit extraction and memory
+	 * ranges alignment (6.0, 7.5.1.2.1).
+	 */
+	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
+	if (!addr) {
+		dev_err(dev, "Failed to map region %pr\n", addr);
+		return CXL_RESOURCE_NONE;
+	}
+
+	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
+	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
+	iounmap(addr);
+
+	/* sanity check */
+	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
+		return CXL_RESOURCE_NONE;
+
+	component_reg_phys = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
+	if (bar0 & PCI_BASE_ADDRESS_MEM_TYPE_64)
+		component_reg_phys |= ((u64)bar1) << 32;
+
+	if (!component_reg_phys)
+		return CXL_RESOURCE_NONE;
+
+	/* MEMBAR is block size (64k) aligned. */
+	if (!IS_ALIGNED(component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE))
+		return CXL_RESOURCE_NONE;
+
+	return component_reg_phys;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ac8998b627b5..d6b4fe68a821 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -219,6 +219,14 @@ enum cxl_regloc_type;
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 
+enum cxl_rcrb {
+	CXL_RCRB_DOWNSTREAM,
+	CXL_RCRB_UPSTREAM,
+};
+resource_size_t cxl_rcrb_to_component(struct device *dev,
+				      resource_size_t rcrb,
+				      enum cxl_rcrb which);
+
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
 
-- 
2.30.2

