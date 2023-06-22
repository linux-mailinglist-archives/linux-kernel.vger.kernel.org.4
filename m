Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BD373A9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjFVU4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjFVU42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:56:28 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027472100;
        Thu, 22 Jun 2023 13:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPfUa2K09qoZbBnQL1YIyqNZN4fsTPr4lcpGWgTT7CwznGYIMd9L1xHCXHWcgaxST88dF/a+DCo1PIdQx4tkQSNO/4HHARFS4rF3E3eIQCiVa0GFeaO3+0JRqI1xfusOu0fsJpQqvyABGf4pIqmninA9vFrTnM1L2Szx2ZzXEF2lGwHtDHZd8VUESda154Xoecixat86IXKvsinWh0QnVkbxR8OjaXttQytaIHreIqU6gZFZJb2Vy/0kbQ8PqqsWUmPeARJ62VKBFQO3BdIPBTeSzyEe15swbtlNNGMzNgZL7fV2sCcjHS0hJKRvb+TvdDb4EjHawDpYOSeuOIGSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=squadm/7eYRqnLrBdJ8N2aFkoLjZG4Ls+zCLhOc8tgU=;
 b=OYWIOY5UkRm9XncNTKEmzYWl4C9iKz1oy0Twv9UfzVn2PA3AfqDFE03w8hjehWRqb13yRfVPBe2t3IswZeyoKsL9Xuip7D6VO3BGgYyLuC0uKThHVKP94z4zlGV/cXQT3Lv5Y9HjI73hN1RrGgZ4ei/8U51pt2WYwzVgnUG77fFHv8klilVpKIlnkrrwvQAIgqCI0ou4o6b+cUoe6ePttFNPJyHKBXNGxMVr0vYfO1Nc1HN0Vv93cwVDCct9hGdokwOdcKLa/0XwloXYrtkvs6PDAxNw0zvRU4h8yXum8d6/NeOAREjXaCsV8GyREBWFQBECg6VX7YCzM3B5xA3VfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=squadm/7eYRqnLrBdJ8N2aFkoLjZG4Ls+zCLhOc8tgU=;
 b=KdcSH8Pj2cyCJcVYhUdnvSQs+B4K/oPA/oFhnA+qsQAXl8qnPvltUqtXult7k1Y5X2DRHYZtImUMgTIZ+wc4TxpfSGF2LRJAxPD4IpAkioeCwi7CdzHX+KkkXFcb8WALeynAG3J9XmXIKmEB3Ch5A9TwcBvcXW+lOEyqa7RBl2w=
Received: from SJ0PR03CA0336.namprd03.prod.outlook.com (2603:10b6:a03:39c::11)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:56:03 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::c4) by SJ0PR03CA0336.outlook.office365.com
 (2603:10b6:a03:39c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:56:03 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:56:02 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 03/27] cxl/rch: Prepare for caching the MMIO mapped PCIe AER capability
Date:   Thu, 22 Jun 2023 15:54:59 -0500
Message-ID: <20230622205523.85375-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 8571356a-9010-4bae-49ab-08db7363177c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4h9AFsZpO2ZQlMRu285he8Gbt4N4WghehsBfb3HB8xsFK4NYFaqPHZlL1MTN8t4GS1D6yP31Ka1o4I7KpAqnMVnyTCFGXazrhi5DMx+A6NjDSGwNxIn8Ra73iwT0cuEud6DrLoVTw3fjae2v4j2wjhRlmiForHoD97IGKFjIHmazWfYtQsA/Tom5VhjKbsGXJH7G+stknt/vBrD6pCCLcxnpQgUHg1yFgIZHzBUJcHhhfa0/N+4gU4ls5pIQ3rjQ/MsgZL7K9Dmxzq38ugZkx6ZmfWjPdBxHh4aETusEFAt2r7qzBp37h4XlWMFyb5JbtvzcrhSe35zKiLvMJ2FlTMPVNISsi1xaNUFI1p5Cb97qtOVIilhFMUUMDdMYAXEEGD8N+93M34aTuRd8FRytzJh5o9cePgLiBHC0wpwkYPSEs+Q69h4qfPeDHdVxftQBXlcErhuE4UjUFodSwpz73Jq0occdPxcS6X3pJYk8wKu0c7Pyi+4J6Mmmxb8+g5yLEyVTBWyb0wnV6ovhR6LidLCGcDfnal3WSSlSlzpIpZx7hb2YKQoszqlstn/uWwyXWzxJqlLw9R4qd3MkWsMahsDEZv3jqWMDSkjLFoKsScok4JQAnFuM9TW6xYlABci/ERN0bGbMwYaWA3NR/Dh93KfP0omZr2Gm2yuVDslb/H8J+QIxSrUx7Uz0nahmWYl9O+/W0jRoJzvU4v0na3RrjWPSP+5n17+1kfW572SoMo4/AFmfbfCUBnwfxjQpEdd1NSIz57oAoTyplcbqqGHDPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(86362001)(110136005)(54906003)(82310400005)(81166007)(356005)(82740400003)(2616005)(36860700001)(336012)(83380400001)(426003)(16526019)(186003)(26005)(40460700003)(47076005)(8676002)(1076003)(478600001)(44832011)(6666004)(4326008)(7696005)(40480700001)(70206006)(70586007)(316002)(8936002)(41300700001)(5660300002)(2906002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:56:03.4316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8571356a-9010-4bae-49ab-08db7363177c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
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
Co-developed-by: Robert Richter <rrichter@amd.com>
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

