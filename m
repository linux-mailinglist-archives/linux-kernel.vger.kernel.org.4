Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FDD7395F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjFVDxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFVDxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:53:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC961BE1;
        Wed, 21 Jun 2023 20:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCgqH0etcoI3roI/9G4fsj/eqWLziQyiJHQpYA0Ju6+WG6FB7f6QG3VGvbU+8Z0otbgVmDxTZgwteJuYnZW3LF91hYubEOIi5pOoXHvNjBxK3cL6xa348hUSaUy5TfzOAF6oZNDcxLgb7c4yu6Ung9TURrt0X0WWTTn0Wv4SLO7r8xR0201dq/mUunVFWpS0fnArM07Prsql7UQ9iqNAFIF2g8b3PogzxxsPgHHsXCQpGRwwfBYVU2ZHRxcy/F+83fwRwk217Sl13J9TJD38XermhJVKkMrN+rqJcmhWWeGwDlz6wzxg8U3w51o80SCJKac7h21hnjIinNs0OygiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfQMGml3MxX15dLvaWY6JcTZG/4JYvkuhNTjSQe/fbA=;
 b=JZICYSd8GgY0se9kQs3SBZRJFWMofZPjyt+IFyRla+ZqZZRyyzq56Bsq6bMC6qupEsTDnYthbpeeFTLbFx/eNpgSW064PlH/S8y1VW7bT41oFe6C61FtCLzL3c+2Pavi30qa/R8/QYUiKtjvttte0BV3VWifKYS/h8BRZccBnleVEzWgV051U1CQX26PMzW/hCUqhS27qgAIyRSvnY1NmxHMWSQdXF/ELAsijH1gBuBf9UYz20SjT+0tq4/vvAymuw5h+ArAmdtq7BLlOUzpyqyNmSq39WCAqCUXIDooPeM6FfJuRAj38OkHDPnhvqTaYvLLZIZ5RLVfMGDV4dyaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfQMGml3MxX15dLvaWY6JcTZG/4JYvkuhNTjSQe/fbA=;
 b=fZ332koo6kS6kGUJ6uq9ZDJIIHklJRHT/ZyS6iLIuzCC5f0PgV6yfQTeKufHKhWSGQyvWs8h7mXx9w6S36g+JVLW0YpycRkrlcF2uUawVpRHZWCd7sEa3t/MCRQj91MzBDGVTbov15oDWNP8hJB0B7yHFuFMvfyc4OKpEnoCkP4=
Received: from MW4PR03CA0119.namprd03.prod.outlook.com (2603:10b6:303:b7::34)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 03:53:05 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::b7) by MW4PR03CA0119.outlook.office365.com
 (2603:10b6:303:b7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 03:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Thu, 22 Jun 2023 03:53:05 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:53:03 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 04/27] cxl/rch: Prepare for caching the MMIO mapped PCIe AER capability
Date:   Wed, 21 Jun 2023 22:51:03 -0500
Message-ID: <20230622035126.4130151-5-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df6b97b-d539-4d9e-a096-08db72d42f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yyq781pFL748YxuyP0YRWRX5IYYz/9q/o1VvwlgfiqryRwJegdR5JP2tgJxHC/+4aKR63VJE6V3wXP/o/k1gWoKn8frpZQbuwBldlzu2QbDUOah8qeluLwh4zatwZJpHmDLgT5pe8vseZkAg7Wq5dFFCYrhBAeGDcFhQXMKDJzBgasQWPWkpKnWgWM/TB2XCTcKpDax2ONpF/kuYGiqow256bsvYVqzJR6rtD1uDZSkXq9qWQGRIEgVXB/1F4qnCxuOi/Q1nzQ1WUrFszPipDo7Qz7iQ81T25exqb0jFfewD+8eKAWJ79o7jHKPt0IOGyXnTqx7IomnDKQr274nv34GOZTmhzjnac7uQ/cFGyQ7njg4p8CinAA6JKVXUthXBmYI2Gi7I74PJwCUSI4XOniehuRZgsoe41oGd+vsB4nFTPMxCVukq7+BWKyukMXm4nkXtaXP7Ddl1cOTfUwnPGMqj9GnISAUSnEg7VoNYw0P5pzmAOX0O+j/OPdHN4DPZMIgywH7Mch8k7blpeEm+SHlQnmHA6Q9SMxXHstQFMDI8eLA2B1PDQc/M4DAkDYZ63nmEcLxjP/+RYd2DGKHiZtPGatkd12G+KA2VYrRl+vSd127r3rLqS42qdiToEbzNlfXutQni/6AJsuOXDP0tQDkES0Ris/GN/A6X7n+iYaiZJ+pGti6ViqjqRhv8iKn+/edsVi925tsxSKw4an/VwEA0mxGddGcyqfk6I1MmY4gdsPBMesVDSq2tzMYoi1sKs0f2WCRTSmxBCmhde3j7fQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(7696005)(4326008)(70586007)(70206006)(478600001)(36756003)(316002)(54906003)(40460700003)(110136005)(86362001)(83380400001)(426003)(26005)(1076003)(47076005)(336012)(16526019)(186003)(2616005)(82740400003)(356005)(5660300002)(81166007)(2906002)(41300700001)(8676002)(8936002)(7416002)(36860700001)(44832011)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:53:05.0966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df6b97b-d539-4d9e-a096-08db72d42f25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h       | 4 +++-
 drivers/cxl/core/port.c       | 4 ++--
 drivers/cxl/core/regs.c       | 5 +++--
 drivers/cxl/cxl.h             | 9 +++++++--
 tools/testing/cxl/test/mock.c | 4 +++-
 5 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bd0a5788c696..b001669a5133 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -68,7 +68,9 @@ enum cxl_rcrb {
 	CXL_RCRB_DOWNSTREAM,
 	CXL_RCRB_UPSTREAM,
 };
-resource_size_t __rcrb_to_component(struct device *dev, resource_size_t rcrb,
+struct cxl_rcrb_info;
+resource_size_t __rcrb_to_component(struct device *dev,
+				    struct cxl_rcrb_info *ri,
 				    enum cxl_rcrb which);
 
 extern struct rw_semaphore cxl_dpa_rwsem;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 45f5299af7a6..76888c75dae4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -939,7 +939,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		return ERR_PTR(-ENOMEM);
 
 	if (rcrb != CXL_RESOURCE_NONE) {
-		component_reg_phys = __rcrb_to_component(dport_dev, rcrb,
+		dport->rcrb.base = rcrb;
+		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
 							 CXL_RCRB_DOWNSTREAM);
 		if (component_reg_phys == CXL_RESOURCE_NONE) {
 			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
@@ -957,7 +958,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	dport->port_id = port_id;
 	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
-	dport->rcrb = rcrb;
 
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 564dd430258a..6c4b33133918 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -332,10 +332,11 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
 
-resource_size_t __rcrb_to_component(struct device *dev, resource_size_t rcrb,
+resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
 				    enum cxl_rcrb which)
 {
 	resource_size_t component_reg_phys;
+	resource_size_t rcrb = ri->base;
 	void __iomem *addr;
 	u32 bar0, bar1;
 	u16 cmd;
@@ -400,6 +401,6 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 {
 	if (!dport->rch)
 		return CXL_RESOURCE_NONE;
-	return __rcrb_to_component(dev, dport->rcrb, CXL_RCRB_UPSTREAM);
+	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 28888bb0c088..7c8674079f1a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -582,12 +582,17 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
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
  * @port_id: unique hardware identifier for dport in decoder target list
  * @component_reg_phys: downstream port component registers
- * @rcrb: base address for the Root Complex Register Block
+ * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
  */
@@ -595,7 +600,7 @@ struct cxl_dport {
 	struct device *dport;
 	int port_id;
 	resource_size_t component_reg_phys;
-	resource_size_t rcrb;
+	struct cxl_rcrb_info rcrb;
 	bool rch;
 	struct cxl_port *port;
 };
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 30119a16ae85..dbeef5c6f606 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -271,8 +271,10 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 	if (ops && ops->is_mock_port(dport_dev)) {
 		dport = devm_cxl_add_dport(port, dport_dev, port_id,
 					   CXL_RESOURCE_NONE);
-		if (!IS_ERR(dport))
+		if (!IS_ERR(dport)) {
+			dport->rcrb.base = rcrb;
 			dport->rch = true;
+		}
 	} else
 		dport = devm_cxl_add_rch_dport(port, dport_dev, port_id, rcrb);
 	put_cxl_mock_ops(index);
-- 
2.34.1

