Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EE170E974
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbjEWXXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjEWXXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:23:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D8F126;
        Tue, 23 May 2023 16:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NP45ow41d/nGsZbltVa2lmNdPhqJKbi/WwyBeY7aTYcZT7IwW9OvkbT6kUi3zjfSdIwrOQ7eK1egK3cY1/Gf40vEcpCW5I5HC7bBI1z1Ao9WcDaWmY9dxlYyDlQqztpA45gJjmtJs5M9zBHc0ejJXQa0RdCNdGhGOeCaKfhll5H0pujn2so3ZZmtooPWVWBAHnpKAA/WTg6EgDtATL3J1X95l3Q5KpS5gonwzmfuI+j2u9OzRyv5+c8xnhiWxPb+txMUzkfzSGHsrv9H9ThbM97bskTphQMzy+Aihx52W3W17UfpifqzHfmp1NzOq3c2orTlWWfArb52uQFUgwYcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oQKaCuHIW1mJdkqfX9KyRHf6RHjbGMoMHREq9RKndM=;
 b=E4sBu7rKn4EtBvH8O38Aks2sj3uonKefaik2Fl297eRO1m5+5rmKCPQc2Ie7JGbCTV0zvG0NdNMUN1wE0TBJCgBYzusDs2V3W1GBttRsVoNEY7oZ0Par2t0edzSVtku4h4+h75N5yS1utUNaick4ArxEcnui3Pa+U7qJMhrEA2/PP2w0HFPswJyEfDHona/q3ZznqV5LveciHgTCaQsNLs79Em1NwzbmnrDo/eUdFsirLz1eCFhMNy6LoIRH/i2/haZQcfSp59tbpxNyCSQSuCxrt0QjG/QdBrhnOfO17hMumlhkcwWCK6f3BI51GS9CdoocRJ+pIcfZrTqO5GsHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oQKaCuHIW1mJdkqfX9KyRHf6RHjbGMoMHREq9RKndM=;
 b=sIP2QXXQybTsGeku7/hSSgpMck36P8xt1b8cOe1Qm2NqoXhBL8X967/JsD5pZsqYu6jPhArhlBOYCXUuYRzoO0jCbS64ZhE0+1SgHkz/rFrZ/08Z2099cSdDgnIMgQo5EfUSkHLYNchhwbNsn7FV0q+k4paBawAINMhpZxA7Qno=
Received: from MW4PR04CA0387.namprd04.prod.outlook.com (2603:10b6:303:81::32)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:23:22 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::c9) by MW4PR04CA0387.outlook.office365.com
 (2603:10b6:303:81::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 23:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:23:22 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:23:21 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 02/23] cxl/rch: Prepare for caching the MMIO mapped PCIe AER capability
Date:   Tue, 23 May 2023 18:21:53 -0500
Message-ID: <20230523232214.55282-3-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 480804b0-3f4a-4f29-f1c1-08db5be4b38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YwcJxux0rYZDPMbAUe+7h1eEzQQkmikwj6kJw3yLENwoLM8+bLkaXqtbAJsYwJeEOgvuQvYvOfOSgBxI3j0W5l9VCFPkLeuW8+FF5m4kJrcJ0bbjWVD1KpUCDWl8Itxhr/xiRKvdPURKJta7AylN/aaRS7rm1UGv1JIk6e+7Eq05XhZzLpAN5u1VAffbiEHqrUjFjqDG5guzRyGNc0myuLqSzx+3G6rWPI/wbGRcS08g8eTfLuZH2TBta43cyOxRTsyXbQntCgCdDzPGeQfNfsZOhDG/16JKiy9lD+qpEhO4jBv6AgMD8youeZ5RbzK9FlNcUZL+L6gtSrdyljgNIvflhPfDChGPcJcCFGDNgscmam6lqQucCAm4/Bqx9UaZRpuD/5EhOQPMoxnWs22VTbznzegf5WuA44ubwaNfX/UkHd6ABnvxpgIIUTtInFcaWjMN53FIIGStgRTr/hQGd2yqZEd9oEmaatbFX54HcTjBnLQr1DzcHHkiw1DBRAB7tftZJM38JrOgN6Y8/aDZP1kJhSZ/jfiz5/J8uBLIpEJ9mttM23skgIOr9eJaARMZjbD2AHn9HQb2pGtggzlMc2zPocYVt//06rOd21QK/9HbSILPNPFCfU69woRMQ0pzMPWAASUNP658mouVGwjDuw74Tk7XoHlve5UortzmmYifuN1EoEVc5tqhxk9LmQYmVDnYUSrZ/OOUz1SkdQnUl7A81ICST0mA0TXHneFk9FzSR0jQoP/Lz2BJeF7ClHrYBFrmRZXgNXIps7J+/N6V8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(70206006)(70586007)(2906002)(40480700001)(186003)(1076003)(44832011)(478600001)(4326008)(6666004)(7696005)(26005)(316002)(54906003)(5660300002)(110136005)(7416002)(8936002)(8676002)(36860700001)(40460700003)(16526019)(81166007)(356005)(36756003)(47076005)(2616005)(426003)(336012)(83380400001)(82310400005)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:23:22.4655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 480804b0-3f4a-4f29-f1c1-08db5be4b38e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
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
 drivers/cxl/core/port.c       |  7 ++++---
 drivers/cxl/core/regs.c       | 10 ++++++----
 drivers/cxl/cxl.h             | 19 ++++++++++++-------
 drivers/cxl/mem.c             | 16 +++++++++-------
 tools/testing/cxl/Kbuild      |  2 +-
 tools/testing/cxl/test/cxl.c  | 10 ++++++----
 tools/testing/cxl/test/mock.c | 12 ++++++------
 tools/testing/cxl/test/mock.h |  7 ++++---
 8 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1a3f8729a616..618865ca6a9f 100644
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
@@ -957,7 +958,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	dport->port_id = port_id;
 	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
-	dport->rcrb = rcrb;
+	dport->rcrb.base = rcrb;
 
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
index 519edd0eb196..7ecdaa7f9315 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -51,7 +51,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	struct cxl_port *parent_port = parent_dport->port;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint, *iter, *down;
-	resource_size_t component_reg_phys;
 	int rc;
 
 	/*
@@ -71,12 +70,15 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	 * host-bridge RCRB if they are not already mapped via the
 	 * typical register locator mechanism.
 	 */
-	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
-		component_reg_phys = cxl_rcrb_to_component(
-			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
-	else
-		component_reg_phys = cxlds->component_reg_phys;
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
+	if (parent_dport->rch &&
+	    cxlds->component_reg_phys == CXL_RESOURCE_NONE) {
+		cxlds->component_reg_phys =
+			cxl_probe_rcrb(&cxlmd->dev, parent_dport->rcrb.base,
+				       NULL, CXL_RCRB_UPSTREAM);
+	}
+
+	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
+				     cxlds->component_reg_phys,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
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

