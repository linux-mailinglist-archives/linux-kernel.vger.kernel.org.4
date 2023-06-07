Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF523727165
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjFGWSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjFGWRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:17:51 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FED211B;
        Wed,  7 Jun 2023 15:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ik+vUz91Iha2s8KtIXsjwWlzac3idkDDVkNBqnOsnWMLdKR8FpKzfTb8xa3hz2kJreTMRWmD3k+ZxdsnGqLIXY0DX+/q1g2YsmdNc7RqyAUr1+fbwrQr1fyvVWcinBi4s7vnWNY61SQ1+hve/3Xjn6lkHmt38shwzTryf8OKJthdh5XMI4I6jEo7oEgJfbVKq45kAed4j+mCdsWiz3maxD+CE8J5QgDhPtIxEmNTra1ainsL7aHsqZIm9HDUljWPY6uXr+5+Rvxqp11TUoVLp9rxw9L23ttOx6j2Miq/Hu5sfg3mFIHgqmHsYlmGssGhg/tExbBvrLcM3fqZUGea1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBuYfiQPoTrgbVnlN7SqkQopfA+9tkIFDjjAG8n4d00=;
 b=ln3wChgm7M1aAJ2KDRhc1rIZAJZcVsm33CGzm9OU7C9//wHbrubKcXW/tEmCmNt0RetNtPFrMCDlE07y+RzfAs6rSI8S4IAyj3L232ObKlSjYe13/+qthrK5gC0g9+Y1IyjhKlLI+MZr9jU/yJo0yKAF2PzG/LL2wF01qWR85+h8gsa8i3d8daGBEn2/A+FHBj2UFwuh3i5/PWXf3M4Jx9ttCFPTDOlzVY7DQlf0qYOpcSP2TWAH9ccB8Tgy/DGZDEMyU+oCfU2OgfBzzPXq4vP91Z4wvmYtnq/lU9lNPpdFpQPc8r3qKKqAh67PQRrYeCZxPu8qIBbkdm2iMAjRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBuYfiQPoTrgbVnlN7SqkQopfA+9tkIFDjjAG8n4d00=;
 b=PwJ8J4bRq8asOd0V7Rz/v8cr5+zrFZLH94aWYDSejQw2zvH3XbgntE+Q6SxHRiaH0TDK+96vzzq73ro3OsbHvVkin22ZNQjZpUBCnNZNN2aMUMcM7dRB4Bg8m5gL2Go6eghnZUeV8pgzmu9mDQdMXB/wXWGUvoXGL9Ewjlo4O4s=
Received: from SA9PR10CA0006.namprd10.prod.outlook.com (2603:10b6:806:a7::11)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 22:17:30 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::ed) by SA9PR10CA0006.outlook.office365.com
 (2603:10b6:806:a7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:17:30 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:17:27 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 02/26] cxl/rch: Prepare for caching the MMIO mapped PCIe AER capability
Date:   Wed, 7 Jun 2023 17:16:27 -0500
Message-ID: <20230607221651.2454764-3-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b96afc-5092-4b8b-4628-08db67a4fbf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3A/u6us2x6NCPI+x05czEDojwvoM61iolkGfioZK6UxkQZjEsASITlFYmCW5LQgsz+aSbX+0aV1RJ+URUYqlewXdkCLGeVE6f/flpdM5Loi8CsYYFejN44hZCDkXJNE07Al+pUxcmy8dPdZi1ShotaQtjgWumbU0GSP+T3tpPCg65aoDGlN1eKwZy/CfwhNFikvI8+JJEJ72yWkXrDMcNQydSNMxKoSnAk8+Li+FxWI/BSUF3N3Y7UAMcjgwaESQFeRk5KQ8zslAjFOqiWcN1NPDh+e9edWrgWXRj/x3hm47/W2iYTVeFVdPu9J8YMd6qXIxA/0qDU1SkxsjTKMXgNYtV03jhMNR63l9hMob9cKN8cP6r6LTSc4xbeBJVTH2v1N/blKbgvA/E0cscq9qTjYJkt4XQVhU0ArRG/Qk0zP9y1JrQJ7bmj5JIgnN6gKpt2d4RKbo3MMSumk0huAos9CilpdAWi9itxt88SRgDFrntWndruUvKUprh7PCX5plzWk0scmiUvuK2aY3UBW8pPtKHFJyvjmHPhJLn3K3oGlNAyKww20IWwHrvVfjfWvJIZfDwgQD70a5W7dg+3B7wey30AGUJXkccLAJqDQRxoP1k6oKzQo1Fh7ucId2TK1K4l3sp7ABaAs7VAGuORL9ASEvbZNqi5Y3rDDWEkfLu+rlVlMjXRgTsYqzvPJh5/834YqgpfAS2Q8ZPktKB4iA+T8mq9OPkQOGrBpoGO+Kh5/ongDZzYwRv0aN/jZimbdYiyr5Yu/aSyfRLJPWWoFGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(2906002)(82740400003)(356005)(81166007)(70586007)(70206006)(54906003)(110136005)(36756003)(5660300002)(7416002)(8936002)(86362001)(8676002)(44832011)(41300700001)(4326008)(40480700001)(316002)(478600001)(40460700003)(426003)(336012)(2616005)(186003)(26005)(1076003)(16526019)(36860700001)(82310400005)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:17:30.1885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b96afc-5092-4b8b-4628-08db67a4fbf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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

From: Dan Williams <dan.j.williams@intel.com>

Prepare cxl_probe_rcrb() for retrieving more than just the component
register block. The RCH AER handling code wants to get back to the AER
capability that happens to be MMIO mapped rather then configuration
cycles.

Move RCRB specific downstream port data, like the RCRB base and the
AER capability offset, into its own data structure ('struct
cxl_rcrb_info') for cxl_probe_rcrb() to fill. Extend 'struct
cxl_dport' to include a 'struct cxl_rcrb_info' attribute.

This centralizes all RCRB scanning in one routine.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c       |  6 +++---
 drivers/cxl/core/regs.c       | 10 ++++++----
 drivers/cxl/cxl.h             | 19 ++++++++++++-------
 drivers/cxl/mem.c             |  5 +++--
 tools/testing/cxl/Kbuild      |  2 +-
 tools/testing/cxl/test/cxl.c  | 10 ++++++----
 tools/testing/cxl/test/mock.c | 12 ++++++------
 tools/testing/cxl/test/mock.h |  7 ++++---
 8 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1a3f8729a616..7c75e8832afb 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -939,8 +939,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		return ERR_PTR(-ENOMEM);
 
 	if (rcrb != CXL_RESOURCE_NONE) {
-		component_reg_phys = cxl_rcrb_to_component(dport_dev,
-						rcrb, CXL_RCRB_DOWNSTREAM);
+		component_reg_phys =
+			cxl_probe_rcrb(dport_dev, rcrb, &dport->rcrb,
+				       CXL_RCRB_DOWNSTREAM);
 		if (component_reg_phys == CXL_RESOURCE_NONE) {
 			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
 			return ERR_PTR(-ENXIO);
@@ -957,7 +958,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	dport->port_id = port_id;
 	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
-	dport->rcrb = rcrb;
 
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 1476a0299c9b..08da4c917f99 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -332,9 +332,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
 
-resource_size_t cxl_rcrb_to_component(struct device *dev,
-				      resource_size_t rcrb,
-				      enum cxl_rcrb which)
+resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
+			       struct cxl_rcrb_info *ri, enum cxl_rcrb which)
 {
 	resource_size_t component_reg_phys;
 	void __iomem *addr;
@@ -344,6 +343,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 
 	if (which == CXL_RCRB_UPSTREAM)
 		rcrb += SZ_4K;
+	else if (ri)
+		ri->base = rcrb;
 
 	/*
 	 * RCRB's BAR[0..1] point to component block containing CXL
@@ -364,6 +365,7 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 	cmd = readw(addr + PCI_COMMAND);
 	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
 	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
+
 	iounmap(addr);
 	release_mem_region(rcrb, SZ_4K);
 
@@ -395,4 +397,4 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 
 	return component_reg_phys;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);
+EXPORT_SYMBOL_NS_GPL(cxl_probe_rcrb, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a5cd661face2..29e0bd2b8f2a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -267,9 +267,9 @@ enum cxl_rcrb {
 	CXL_RCRB_DOWNSTREAM,
 	CXL_RCRB_UPSTREAM,
 };
-resource_size_t cxl_rcrb_to_component(struct device *dev,
-				      resource_size_t rcrb,
-				      enum cxl_rcrb which);
+struct cxl_rcrb_info;
+resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
+			       struct cxl_rcrb_info *ri, enum cxl_rcrb which);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
@@ -587,22 +587,27 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 	return xa_load(&port->dports, (unsigned long)dport_dev);
 }
 
+struct cxl_rcrb_info {
+	resource_size_t base;
+	u16 aer_cap;
+};
+
 /**
  * struct cxl_dport - CXL downstream port
  * @dport: PCI bridge or firmware device representing the downstream link
+ * @port: reference to cxl_port that contains this downstream port
  * @port_id: unique hardware identifier for dport in decoder target list
  * @component_reg_phys: downstream port component registers
- * @rcrb: base address for the Root Complex Register Block
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
- * @port: reference to cxl_port that contains this downstream port
+ * @rcrb: Data about the Root Complex Register Block layout
  */
 struct cxl_dport {
 	struct device *dport;
+	struct cxl_port *port;
 	int port_id;
 	resource_size_t component_reg_phys;
-	resource_size_t rcrb;
 	bool rch;
-	struct cxl_port *port;
+	struct cxl_rcrb_info rcrb;
 };
 
 /**
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 519edd0eb196..43ecd150bdc7 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -72,8 +72,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	 * typical register locator mechanism.
 	 */
 	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
-		component_reg_phys = cxl_rcrb_to_component(
-			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
+		component_reg_phys =
+			cxl_probe_rcrb(&cxlmd->dev, parent_dport->rcrb.base,
+				       NULL, CXL_RCRB_UPSTREAM);
 	else
 		component_reg_phys = cxlds->component_reg_phys;
 	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6f9347ade82c..32b9d398d399 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -12,7 +12,7 @@ ldflags-y += --wrap=devm_cxl_enumerate_decoders
 ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_hdm_decode_init
 ldflags-y += --wrap=cxl_dvsec_rr_decode
-ldflags-y += --wrap=cxl_rcrb_to_component
+ldflags-y += --wrap=cxl_probe_rcrb
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index bf00dc52fe96..790dec597a70 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -971,12 +971,14 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 	return 0;
 }
 
-resource_size_t mock_cxl_rcrb_to_component(struct device *dev,
-					   resource_size_t rcrb,
-					   enum cxl_rcrb which)
+resource_size_t mock_cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
+				    struct cxl_rcrb_info *ri, enum cxl_rcrb which)
 {
 	dev_dbg(dev, "rcrb: %pa which: %d\n", &rcrb, which);
 
+	if (which == CXL_RCRB_DOWNSTREAM)
+		ri->base = rcrb;
+
 	return (resource_size_t) which + 1;
 }
 
@@ -988,7 +990,7 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.is_mock_dev = is_mock_dev,
 	.acpi_table_parse_cedt = mock_acpi_table_parse_cedt,
 	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
-	.cxl_rcrb_to_component = mock_cxl_rcrb_to_component,
+	.cxl_probe_rcrb = mock_cxl_probe_rcrb,
 	.acpi_pci_find_root = mock_acpi_pci_find_root,
 	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
 	.devm_cxl_setup_hdm = mock_cxl_setup_hdm,
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 284416527644..4790055fe25a 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -259,9 +259,9 @@ int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dvsec_rr_decode, CXL);
 
-resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
-					     resource_size_t rcrb,
-					     enum cxl_rcrb which)
+resource_size_t __wrap_cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
+				      struct cxl_rcrb_info *ri,
+				      enum cxl_rcrb which)
 {
 	int index;
 	resource_size_t component_reg_phys;
@@ -269,14 +269,14 @@ resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
 
 	if (ops && ops->is_mock_port(dev))
 		component_reg_phys =
-			ops->cxl_rcrb_to_component(dev, rcrb, which);
+			ops->cxl_probe_rcrb(dev, rcrb, ri, which);
 	else
-		component_reg_phys = cxl_rcrb_to_component(dev, rcrb, which);
+		component_reg_phys = cxl_probe_rcrb(dev, rcrb, ri, which);
 	put_cxl_mock_ops(index);
 
 	return component_reg_phys;
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcrb_to_component, CXL);
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_probe_rcrb, CXL);
 
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(ACPI);
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index bef8817b01f2..7ef21356d052 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -15,9 +15,10 @@ struct cxl_mock_ops {
 					     acpi_string pathname,
 					     struct acpi_object_list *arguments,
 					     unsigned long long *data);
-	resource_size_t (*cxl_rcrb_to_component)(struct device *dev,
-						 resource_size_t rcrb,
-						 enum cxl_rcrb which);
+	resource_size_t (*cxl_probe_rcrb)(struct device *dev,
+					  resource_size_t rcrb,
+					  struct cxl_rcrb_info *ri,
+					  enum cxl_rcrb which);
 	struct acpi_pci_root *(*acpi_pci_find_root)(acpi_handle handle);
 	bool (*is_mock_bus)(struct pci_bus *bus);
 	bool (*is_mock_port)(struct device *dev);
-- 
2.34.1

