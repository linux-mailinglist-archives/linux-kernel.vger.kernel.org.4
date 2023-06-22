Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F3573A9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjFVU4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjFVU4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:56:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C7F1FF2;
        Thu, 22 Jun 2023 13:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlRBHjg5Xl0akeE2cVpUL3m/cz4jIrIPBv/LCgHvou7JOCOKvhYlAzE7QK5gLDhUd8WQ5xFPfk06jGMQMhotCSq+e7gPAOtr03vibL7OUos3YFfWk0MqiyTPzm3kiBWY8lihUtnFzejw+pQv1j7glyZlG+MLfT11Yy6m/z1h5uDkwDVn0y5JtG6pGvscxbxsiF6wP6rVmEKjJZz0canlAY8Kpl+24TpGEzgU5578xKxiJJ+Zm4vU/nUiunPjSQu+Pwu+NvTVfBaNVi6+oWm6sT48MRLvmckY65eJt8v5X/VI/ZRQqY0MPrFQRm6+DYP3eluRJIfZ82GWU9e+Ez6JqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhUT+4TTdka7ns8uewSB3n9C201wxxhbmNRUgjFAfrE=;
 b=GKgJ7pSmrmkk1ZweQoiMqgjBnckjK+7jk4SwJTKVPqJkEw2WO3d0O0Y3g37TCktdm//QZgULe1K2UZsuxkHoTKHUDxRnMnFDODukYqa+YVhdxMnu/yYnaS2lnbDuw1OzWct7Q8XD+VgplkXeAGKC9o0C+QyI+kJgS92KrU1YkRUdMiZQuS7RIcmJQaQwKJFxKqmKEe5I/4raQ7QRMhprhdswD3eTqiQ3Y09O7HBPneu+KQivV8fDE6JAjn5C3KvCE3G3Nd+3xh2XXDwfes8KB/Y3POkS3lWkcXeHHBrFWGg0PGi92WJ2CIjCFGovTiPz0kRI/toJPG+1jL102sXOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhUT+4TTdka7ns8uewSB3n9C201wxxhbmNRUgjFAfrE=;
 b=jRkjzcIKLI8OVVICwX+qEE9Q9SjZR8vxeKFgZwVmkaNvp1VTVFnz9wlDh+/byDwcJS6xaSEzWRtUxhUJAbcZtKnvwbET89rJnM+/ZNFBTEGuWKO6KFSUNB6oqReTDL2TW5bMlP11ZR4qJeJgWgXLtZplZath29JEMz96yBW0GJc=
Received: from MW4PR03CA0239.namprd03.prod.outlook.com (2603:10b6:303:b9::34)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:55:53 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::42) by MW4PR03CA0239.outlook.office365.com
 (2603:10b6:303:b9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:55:52 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:55:51 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 02/27] cxl: Updates for CXL Test to work with RCH
Date:   Thu, 22 Jun 2023 15:54:58 -0500
Message-ID: <20230622205523.85375-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622205523.85375-1-terry.bowman@amd.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: c776575d-4269-4f27-d264-08db736310e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZtzjG9GIy7R542Zg3Di7VZ618KSiD5/eJbmNvjxlcjTrAdYxbMtQtk8Gfp4HAgnfJ2VENOdNnbSa9RrcSCYjI/ge1BwNi42cuM+JNc2G4EdfPNBLovbjPW3cI3z6AZDf7ZzEcBX8HqwQZ4Wjp6cNO15nvdX0B3huIc7LANMNhSsJzCVPPRomratKPxzGkz4vA9PS+MVsoHBBPDorcIcvKu7A+4z8zI5avZ2RJnGetZTYeFtzIJqJRqBVl6//4x5boXOVECs9SNXHCduyDccXpxTArDfyWymdvMlvZNmfdg5iW7ssZ+00U76d+fVh2cKXHude4tDYsN1W7COOV57xUOXVGsVks73D16V+8ocgCFfwoBNovIoqP2onmho43oFq7Q2b/mYhcDjaos7YXJBQTOh2O9Lyt9xx3H0B0bNLnHe69mIH8GwR6CW08HfmhzTEwXzakPnUg3XhOSYHApeBnE1x73PCsSASZT/uv2klCWGjgM0aVxy48fRtw16YOnqBdzkaNbIt5GohZN7aasfeA+IKSjldhSxy87h97fnVEPuwO6gTkGo4+ayd+4yfx5K8tfo0lo3j0SZFxfg0kwUuNUJ0q2eubkXVSqQ3K6toDVuVHs0nGxOsDAvn3BTdrEEDJlbaEjPX9oow9LFSF2+lFAOaEgO7Ne0y49uQMhYNDHEkOk4WXbGirPQDeHHGcT29At0jY4UhXzz6yuv4qq7FrvUhABL7f/5q+yWMPOcU5VFrcQAj1+ULocgOLMs0CIkhxvon61j9Cjsba66YZgs2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(186003)(1076003)(26005)(44832011)(5660300002)(8936002)(86362001)(7696005)(15650500001)(8676002)(16526019)(7416002)(2906002)(478600001)(40460700003)(110136005)(54906003)(36756003)(36860700001)(4326008)(83380400001)(47076005)(41300700001)(82740400003)(81166007)(356005)(2616005)(336012)(40480700001)(70206006)(426003)(70586007)(316002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:55:52.4079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c776575d-4269-4f27-d264-08db736310e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
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

