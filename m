Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5073961C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 06:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjFVEBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 00:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFVD7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:59:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69890271E;
        Wed, 21 Jun 2023 20:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgOi+Vz96tug7fsXIzfkL2opPNzONanhMdplmCkYaSu5GcCHBTB8X8ByIf4SqB7X4OD53BRVHldODYOQeqQ2eI/BBpGNczYAOxIXFJD1+PdYjdyx2JtsPTt/0ZUXcUPI1nEicgZGY5Dv5UI3OETCDQOZQJJ+S8e6Ax/bb247MNAHKahedpjJU4IiwYnz8ozEQBQnq6PQbVYq3zlF4+4CsOSUMzoZjYtPkBaiGejJJaGdxaE02r1AjlYOUBUD4LD6ERExHFgAwz0PXDvI9gRmNObcEDa2fFFBvFJnByx0MJb/ZpOi0Ms8M1cNF4iUIxA+jvmu3rUOzMdm17tw6ySLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeGQ5wxvm+T/vHtnY2fziI7cVswcjWO6ScDOOc443ck=;
 b=WVnsVpT7U6dvhJEe3eLrrEwBL5Dt4fsaWaAmLeoFVhRJSqg4pKnppTos5JKV2LQUopzIbaYOCuvDuSJf1azqKeJNaFTFl5nvGeJo1IxNbC35ShLNbDPcitsLPj951CytwtCgq+cwrCsNS5bhARlYZu3jMnsCBMzey/bLeZtc+mhlGPlPiKEvRszU80Mm2njoJt/OfV8yJXWliRMeOsE0GO7jo3eK9d2QZAFOvCJkLPcGiQ8XKtuXwUH6HXTf+ucS6yFfhEhcr3N6mQDj0KHzp2KAPH95+nKmu4zYn7jri/JKMf449F1hz8OCtg8Lt9whjUrRXuLVrQ8p2ymbliHAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeGQ5wxvm+T/vHtnY2fziI7cVswcjWO6ScDOOc443ck=;
 b=5fyvimfIdP3j7xkzgebVkEoxsVEN+Fj2SgbhkjgoILly/trf61aHX+4TZgvOzSXSEF6AOKX5lYIaBrqbgsJZsr3ppGgN1XWBbvgqVrmohVSNaU9Hlk+vkFmk6/sYvJwy9MYCHeccR0J75Eb46Tv9uM0EifIhPHCLGRUvn9Y/M8A=
Received: from BN8PR03CA0009.namprd03.prod.outlook.com (2603:10b6:408:94::22)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 03:57:57 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::3a) by BN8PR03CA0009.outlook.office365.com
 (2603:10b6:408:94::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Thu, 22 Jun 2023 03:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 03:57:56 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:57:55 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 27/27] PCI/AER: Unmask RCEC internal errors to enable RCH downstream port error handling
Date:   Wed, 21 Jun 2023 22:51:26 -0500
Message-ID: <20230622035126.4130151-28-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cce9866-004a-46c7-bb1b-08db72d4dcce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvIk4vYyRb9pi8o3Z1/D+/o8dykExecaFobbYBJHRwGPX5FCSRSP/k09og1MVBHGLhN7Nfb8kPDTSxot68wFPWdWEN1w8HXAXMG6bSsKGK/stL9iScMpH+fRz+a6dq5WdnbfZImNfuewemiYWspF2PHFotDVOlUr2KiS7SZ6cAKddvNpBWqjVe4sndeyLoZ/Vbmk1cKotuKaRTx2520Y2ZjS+iTh+aofyHxGIEonnY2B05YjKirnAYuf+p/hIo01mprgrDqc399LCYLDL8o/ujHJCMciaqFKu2rgxx8jAWPkcaEb1JidgQ/eVhYoEfdj+ZbgHm3BMUzu5Z6YgV66/mDcF3nwk4GvCgYzd9+BfVyVUTK2znZmgczZttx4cJYVzCCcA13YTCDbf2rpm7cqNYBXPEviwl84NeuZpu61OB6bDui7/q9ZXANcPOzCFQ1CjP0b1JqASZ9o6e5PEsAY9c60D0yPgvYZq4g/bZBXYkgkfdhvl9dBcZWjnUokbNnx0c5P424eTetXjK8xQNkroOMCkj66BxbnzTYofwfKPfWBK89rietns24JHfbfCIEH6YX3LoLD55UHV0P4/lcar5ES82QOH+xeemnkF9GRy3JlYDgsIQfY3W/OWcETa5Qfr0KTjU5eciG4DoIbbPJBw4QQOQTJSK+Ej+iz8VcweE4tnT/L7Ys9TZXRxQNz3gDSvGLlRPFmIwU71qRorcTXirrlelyMMuGDdILofutTUIGiMCNyfyq4tpLWZJ33EQv88foafI+rLVp5jeTu56VPnLNiOoaEmW3jISu/4XsBTWU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(7416002)(5660300002)(4326008)(70206006)(70586007)(36756003)(478600001)(44832011)(316002)(40480700001)(8676002)(8936002)(110136005)(2906002)(40460700003)(36860700001)(54906003)(41300700001)(86362001)(7696005)(82310400005)(1076003)(426003)(16526019)(26005)(336012)(47076005)(186003)(82740400003)(6666004)(81166007)(356005)(83380400001)(2616005)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:57:56.5757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cce9866-004a-46c7-bb1b-08db72d4dcce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

AER corrected and uncorrectable internal errors (CIE/UIE) are masked
in their corresponding mask registers per default once in power-up
state. [1][2] Enable internal errors for RCECs to receive CXL
downstream port errors of Restricted CXL Hosts (RCHs).

[1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
[2] PCIe Base Spec r6.0, 7.8.4.3 Uncorrectable Error Mask Register,
    7.8.4.6 Correctable Error Mask Register

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 57 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c354ca5e8f2b..4f9203e27c62 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -948,6 +948,30 @@ static bool find_source_device(struct pci_dev *parent,
 
 #ifdef CONFIG_PCIEAER_CXL
 
+/**
+ * pci_aer_unmask_internal_errors - unmask internal errors
+ * @dev: pointer to the pcie_dev data structure
+ *
+ * Unmasks internal errors in the Uncorrectable and Correctable Error
+ * Mask registers.
+ *
+ * Note: AER must be enabled and supported by the device which must be
+ * checked in advance, e.g. with pcie_aer_is_native().
+ */
+static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+	u32 mask;
+
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
+	mask &= ~PCI_ERR_UNC_INTN;
+	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
+
+	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
+	mask &= ~PCI_ERR_COR_INTERNAL;
+	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
+}
+
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
 	/*
@@ -1027,7 +1051,39 @@ static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
 }
 
+static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
+{
+	int *handles_cxl = data;
+
+	if (!*handles_cxl)
+		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
+
+	/* Non-zero terminates iteration */
+	return *handles_cxl;
+}
+
+static bool handles_cxl_errors(struct pci_dev *rcec)
+{
+	int handles_cxl = 0;
+
+	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
+	    pcie_aer_is_native(rcec))
+		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+
+	return !!handles_cxl;
+}
+
+static void cxl_rch_enable_rcec(struct pci_dev *rcec)
+{
+	if (!handles_cxl_errors(rcec))
+		return;
+
+	pci_aer_unmask_internal_errors(rcec);
+	pci_info(rcec, "CXL: Internal errors unmasked");
+}
+
 #else
+static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
 static inline void cxl_rch_handle_error(struct pci_dev *dev,
 					struct aer_err_info *info) { }
 #endif
@@ -1428,6 +1484,7 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
+	cxl_rch_enable_rcec(port);
 	aer_enable_rootport(rpc);
 	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
-- 
2.34.1

