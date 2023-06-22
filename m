Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEA47395F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjFVDxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjFVDxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:53:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312FD1FD8;
        Wed, 21 Jun 2023 20:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bf5FWZ5G+EeehMvKSOm5RiLKV+LS7g3cJkdPxJNCT9J25M/HIUU/ztiELB/MSsygf+UiYvcH3gr2l/G73hU0/ju6ItgvsHsqTPlJgO4eIaNwfYxvtXkTY0r+brn+hVAhZm8NdIW6YG4gNBF3Ze+3hwfDqFRm6Ca2xkXy/0Dw3vLBTuwyThk2D8bYgH6I8yfIFQC5Gad+qFKh/MxWWnxDuEx4K5ybkjUeTwjR/pEVlpwQTRrQd7/pB7+YDoTIOVvpBhcozxbsBo6aX16uL76ENZktuIEiWSVHvhhTsNyL8dPl0p4WLTSOjfLj74j4ACTqxJvuvOJOFwd/NRKCzlguAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE7UKIqt17UltAmUdPIFngXl5ezI54ZthO8oxdvH+fY=;
 b=IbTfHKLLmX5RBQdJ89zSJ3LfoYwD+nWd6BAYEJ3lhXb32c4jXNhIz3g10maEZFQECTbZb17nFdhVkpe1lEl8fgr2kQM6YADDHsQRp6BLL8PuZTTiwmRznG1km3cVryZaSr/EgaTLRemMENnKajKPkr3OKugP4wgZ2STHCJ/WKNMTXDXKUOp54XjQyFRLOt9TGujU3YG+hrOYihtbO43dtdusVIvWU254Tv//BtG1eMs5i3hZbO+rPaq26hK/MpawCVaaEXGp+VXYcNPuieSeobFuxWHSFbs7zF7ukr73kUbRVfW3hwOPH3Aj9+D+AigXMvGjo1qMjV0bJXH9Wsmw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE7UKIqt17UltAmUdPIFngXl5ezI54ZthO8oxdvH+fY=;
 b=HbEHLFmvVmcXTlHOThJR6UCQQFiRkzB0wx/P0Ts5vSNcb2bV0bqoXRcYyGFvsKuStRvHC5DV6Td3VE+v2VnnruPexnlKWymNJ/HZcbNk5RcjLiKSyYcBLJcNvhs+1/6ycvAa4kX8NVjYtpc+xtHtfqBvm+aiI+nQ3O4oIS5xFqg=
Received: from SJ0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:33a::16)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 03:52:54 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::aa) by SJ0PR03CA0011.outlook.office365.com
 (2603:10b6:a03:33a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 03:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 03:52:54 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:52:52 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 03/27] cxl: Updates for CXL Test to work with RCH
Date:   Wed, 21 Jun 2023 22:51:02 -0500
Message-ID: <20230622035126.4130151-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: c7daf13a-93c9-4f42-7e1b-08db72d4288c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXYXCXa0bH4FuaBgEVjcHnrVSvxfhrato30NcXoDzaY4Vu/IdgkwMZKqqLwBx7c5CAVEYnnNui6cXSWG9Y2ES8HB1ox85GVlQwEAsyP2zSC+CwA5HH0PlO+Kwf3tsaM2/9Qa1iD9QtcDFADqGCesjJN3bIQFdib9NBS1n8biVdGFj9qllNN6BW7HZZgU4hb0WsYvktaM1J69V8Syd48Y68gAQb3VUzJPHqB/4Dgv4PM/8vRlFdJGqa20GJ3KrPd2hctoc0Wy6g6ADw+zSq+sVkrOinWRJHXXH0OmwGxSOAq/X8YtbrAORNWC8HC34qlNKLVJ6IXcEsnxaCraCWA9zkfhOG7qyv+/k4mmmklpJrx2NH1pVd0HqN5obEkeoWy+mkAkpcxWHb+oH2wcnRAbhHdzNaTA8jgKwL8lzbe7Xp+Q72W2tVc20tO2F8CXHEwFmG22lF9C5BpyIsbYOYWGhEusOsyxSURwAOY7N0obZmmJjD583LqoVxCJ5Ci/JTl88LF8eevahH+jjhCLz2RsUOlTcYucS9/NOduz9IRQdCcKOFGhNLk8ZinrdlzovDablQ9HsAVAJB7/i8mnX3Uisgk4iniPTpQsJG+VPUvHmid4Cn2Z+mbyyMt+RjhbM/pkkfMGHCWritYK5fZRzHi7VrWUSAzFw6scM74LA5dMYsiaLKEPwYFCVgb5be4vd4/dEPHW6ahue/tWVbMBp5d2YgJhg7WA1+USC4NUGo3ZiocQSSjB/La0f9gSXHodDKpyjy5fYcIzINQScWNMUdrEMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(7696005)(478600001)(54906003)(70586007)(70206006)(6666004)(110136005)(186003)(1076003)(26005)(2906002)(82310400005)(16526019)(8936002)(4326008)(5660300002)(8676002)(7416002)(41300700001)(44832011)(316002)(356005)(81166007)(82740400003)(40460700003)(86362001)(426003)(40480700001)(36860700001)(47076005)(83380400001)(2616005)(36756003)(336012)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:52:54.0423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7daf13a-93c9-4f42-7e1b-08db72d4288c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
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

CXL test needs to be updated to work with latest RCH changes.
Add CXL test support for devm_cxl_add_rch_dport and
cxl_rcd_component_reg_phys functions.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/core.h       |  8 ++++++++
 drivers/cxl/core/port.c       |  4 ++--
 drivers/cxl/core/regs.c       | 15 +++++++++++----
 drivers/cxl/cxl.h             | 11 +++--------
 drivers/cxl/mem.c             |  4 ++--
 tools/testing/cxl/Kbuild      |  3 ++-
 tools/testing/cxl/test/cxl.c  | 10 ----------
 tools/testing/cxl/test/mock.c | 34 +++++++++++++++++++++++++++-------
 tools/testing/cxl/test/mock.h |  3 ---
 9 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 27f0968449de..bd0a5788c696 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -63,6 +63,14 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
+
+enum cxl_rcrb {
+	CXL_RCRB_DOWNSTREAM,
+	CXL_RCRB_UPSTREAM,
+};
+resource_size_t __rcrb_to_component(struct device *dev, resource_size_t rcrb,
+				    enum cxl_rcrb which);
+
 extern struct rw_semaphore cxl_dpa_rwsem;
 
 int cxl_memdev_init(void);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1a3f8729a616..45f5299af7a6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -939,8 +939,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		return ERR_PTR(-ENOMEM);
 
 	if (rcrb != CXL_RESOURCE_NONE) {
-		component_reg_phys = cxl_rcrb_to_component(dport_dev,
-						rcrb, CXL_RCRB_DOWNSTREAM);
+		component_reg_phys = __rcrb_to_component(dport_dev, rcrb,
+							 CXL_RCRB_DOWNSTREAM);
 		if (component_reg_phys == CXL_RESOURCE_NONE) {
 			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
 			return ERR_PTR(-ENXIO);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 1476a0299c9b..564dd430258a 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -332,9 +332,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
 
-resource_size_t cxl_rcrb_to_component(struct device *dev,
-				      resource_size_t rcrb,
-				      enum cxl_rcrb which)
+resource_size_t __rcrb_to_component(struct device *dev, resource_size_t rcrb,
+				    enum cxl_rcrb which)
 {
 	resource_size_t component_reg_phys;
 	void __iomem *addr;
@@ -395,4 +394,12 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 
 	return component_reg_phys;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);
+
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport)
+{
+	if (!dport->rch)
+		return CXL_RESOURCE_NONE;
+	return __rcrb_to_component(dev, dport->rcrb, CXL_RCRB_UPSTREAM);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a5cd661face2..28888bb0c088 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -262,14 +262,9 @@ int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
 enum cxl_regloc_type;
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
-
-enum cxl_rcrb {
-	CXL_RCRB_DOWNSTREAM,
-	CXL_RCRB_UPSTREAM,
-};
-resource_size_t cxl_rcrb_to_component(struct device *dev,
-				      resource_size_t rcrb,
-				      enum cxl_rcrb which);
+struct cxl_dport;
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 519edd0eb196..45d4c32d78b0 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -72,8 +72,8 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	 * typical register locator mechanism.
 	 */
 	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
-		component_reg_phys = cxl_rcrb_to_component(
-			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
+		component_reg_phys =
+			cxl_rcd_component_reg_phys(&cxlmd->dev, parent_dport);
 	else
 		component_reg_phys = cxlds->component_reg_phys;
 	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6f9347ade82c..8a87d7d5f7f8 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -12,7 +12,8 @@ ldflags-y += --wrap=devm_cxl_enumerate_decoders
 ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_hdm_decode_init
 ldflags-y += --wrap=cxl_dvsec_rr_decode
-ldflags-y += --wrap=cxl_rcrb_to_component
+ldflags-y += --wrap=devm_cxl_add_rch_dport
+ldflags-y += --wrap=cxl_rcd_component_reg_phys
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index bf00dc52fe96..f5c04787bcc8 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -971,15 +971,6 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 	return 0;
 }
 
-resource_size_t mock_cxl_rcrb_to_component(struct device *dev,
-					   resource_size_t rcrb,
-					   enum cxl_rcrb which)
-{
-	dev_dbg(dev, "rcrb: %pa which: %d\n", &rcrb, which);
-
-	return (resource_size_t) which + 1;
-}
-
 static struct cxl_mock_ops cxl_mock_ops = {
 	.is_mock_adev = is_mock_adev,
 	.is_mock_bridge = is_mock_bridge,
@@ -988,7 +979,6 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.is_mock_dev = is_mock_dev,
 	.acpi_table_parse_cedt = mock_acpi_table_parse_cedt,
 	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
-	.cxl_rcrb_to_component = mock_cxl_rcrb_to_component,
 	.acpi_pci_find_root = mock_acpi_pci_find_root,
 	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
 	.devm_cxl_setup_hdm = mock_cxl_setup_hdm,
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 284416527644..30119a16ae85 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -259,24 +259,44 @@ int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dvsec_rr_decode, CXL);
 
-resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
-					     resource_size_t rcrb,
-					     enum cxl_rcrb which)
+struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
+						struct device *dport_dev,
+						int port_id,
+						resource_size_t rcrb)
+{
+	int index;
+	struct cxl_dport *dport;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_port(dport_dev)) {
+		dport = devm_cxl_add_dport(port, dport_dev, port_id,
+					   CXL_RESOURCE_NONE);
+		if (!IS_ERR(dport))
+			dport->rch = true;
+	} else
+		dport = devm_cxl_add_rch_dport(port, dport_dev, port_id, rcrb);
+	put_cxl_mock_ops(index);
+
+	return dport;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, CXL);
+
+resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
+						  struct cxl_dport *dport)
 {
 	int index;
 	resource_size_t component_reg_phys;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (ops && ops->is_mock_port(dev))
-		component_reg_phys =
-			ops->cxl_rcrb_to_component(dev, rcrb, which);
+		component_reg_phys = CXL_RESOURCE_NONE;
 	else
-		component_reg_phys = cxl_rcrb_to_component(dev, rcrb, which);
+		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
 	put_cxl_mock_ops(index);
 
 	return component_reg_phys;
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcrb_to_component, CXL);
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, CXL);
 
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(ACPI);
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index bef8817b01f2..a94223750346 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -15,9 +15,6 @@ struct cxl_mock_ops {
 					     acpi_string pathname,
 					     struct acpi_object_list *arguments,
 					     unsigned long long *data);
-	resource_size_t (*cxl_rcrb_to_component)(struct device *dev,
-						 resource_size_t rcrb,
-						 enum cxl_rcrb which);
 	struct acpi_pci_root *(*acpi_pci_find_root)(acpi_handle handle);
 	bool (*is_mock_bus)(struct pci_bus *bus);
 	bool (*is_mock_port)(struct device *dev);
-- 
2.34.1

