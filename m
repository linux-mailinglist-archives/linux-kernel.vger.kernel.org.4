Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC217744525
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjF3XUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjF3XT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:19:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A329344A7;
        Fri, 30 Jun 2023 16:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCR6w8nR0cDRx4JMZyqGT407fTDROiwHVs3x4wfdREcpiBTyYKXGAXa1cOWeT1XXXpOpZF17xEz3mCFX5KQPtoIta5KoBMgxLMIfxwnL9fiBpDs6vqq/Ej28lSQfT+dhxoAShjSasVPq6G8FTdzAwv/rGVnyY5nASlqAD6+yHcBQVxYZ+Y2yWXCI5Pt+N9NLBEjAoa/BlfOaoAaaDnUn93KSvccXk85iTdhFwu08f1NxjfQ6tNLQ1x41U6WLRxTnAbSe1C6pcKmwwfnzklnjSJFmS0Oars3/kZM5R2GUNKhRMP7s6EDohkSHuU1yZVGBlB9Zahh3gPhfMnzuyG6C1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omEvIhe6j83LbuOyZ/SUqwoTimOun3G14ApcXP+8OxY=;
 b=EwKAXbYODeovh3QiH77VHouHGyj/mN39zy7Xwm0jfyGurO7z5NEpoidgFPBpZWEtZuiQms9S71WiuYnO1s8BOpH5itAvwXIWYj13mgm3RvNAgQ8cHsJZQhOyWwyWnsLf1gTTI/9IZJeRrEwFu5AW3/jLo2WHpZhocPf2arrlWnLxXdRlUBhSvPs4io/dvEbMUDtTmC1rdFuW3TDWx21n4WQwgQxzJDaaYCxDJ2vr+FvMss8knThTT+06203CUfYLzZNqcMysoUR5MC+7rtrcXMufR2auJ17XT7qGHGW5y7IIgHV4FcIBYJYFei2NjqdKtWjm0H9LO973gZfYmGyOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omEvIhe6j83LbuOyZ/SUqwoTimOun3G14ApcXP+8OxY=;
 b=sknsCILfndoTxqPgRgm8ag48aWq5cvZhUmdNfLlw8QYDyIA5wS/BYV0w2olaWmQg6xSBYiim7B8FubcI3wCe1zCAxu8jU6nkEuKjlWCMfC9kpMOWZ9WcTuX9xFteGQGg19SivKs4r1UqoU8g3HNh0aKABzbK8nbHyU2MFEUJXwI=
Received: from DS7P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::10) by
 BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 23:19:14 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::e8) by DS7P222CA0030.outlook.office365.com
 (2603:10b6:8:2e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 23:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.51 via Frontend Transport; Fri, 30 Jun 2023 23:19:14 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 18:19:12 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v8 13/14] PCI/AER: Unmask RCEC internal errors to enable RCH downstream port error handling
Date:   Fri, 30 Jun 2023 18:16:34 -0500
Message-ID: <20230630231635.3132638-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630231635.3132638-1-terry.bowman@amd.com>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|BL1PR12MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b92e7c3-fd3c-4191-9712-08db79c06b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zoj3ccTqll3UVJPGvhPeJ/b3TWtj5tk6LM45NWELwrHGsSLZ8QbEwyd4xRTHthLRdyMD4XlR4gOA8qALovb6CoaoXZN3xbHpQxViAgjVQw6nCcrjJr9cNjZcRV7f41vUZFv87z51eNgAehmpro0BJJOVXXrInEXjylFuseVraarPLBIkJFllql4/t1fpERvkxbsmZrrfD8ILo3k1snAVad8hQJbh1hN1REnTKMCszkAFhq7/Cg/R5FRCjUS4Evpz/jqdkEgVPGY83ghajkzLdF+hE3HVWZZlEw3fTagjIHtaFEjmzwHtYgBYux8T1i082gq0p1QwHuhjF7HoHrQ23qoX+XD+IpetgKFkh1QpkxMsPnqMITHjNlqo0dURyN5m/AzHDYW9YIEe5A72tWxISP/MejTO3hz6caUy1X41mEfJwbfGjf63s4sDefwNEDnpFQl1zRWlh53ufJa25d2cuOc5Pb5QMftGyPZhaS8NEXu4bQAcr23Qx8Wpv6r17noMQCBKhyEV+m3yRh8g8nTgE3hfpiljPQ/I5kizY9JM+h0cD4UrZBbYo5+JLKfQXBl731h5HwS2N9XV+iQkd0SaKIVpedMHAgiLAlD4XVDr/pB+2KFib/fMKiEs443ExD3SMCEPZXag0XASSk5Cw/W55ivUXTcNysRMF2b50uJ2SwrlTn8wQ/e71NX0108eLUfVOkFTTmzh6OchzSWqxKhIBqBuZwkvSBDIMLbDn+5T46JnLg64ZnpkG/Ozu7Rf/00CJyfN1dSyoSm/qbRibGR5Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(336012)(426003)(47076005)(40460700003)(83380400001)(2616005)(2906002)(81166007)(356005)(82740400003)(36860700001)(40480700001)(36756003)(8936002)(8676002)(82310400005)(110136005)(5660300002)(86362001)(54906003)(41300700001)(4326008)(70206006)(70586007)(6666004)(316002)(7696005)(478600001)(16526019)(186003)(44832011)(1076003)(7416002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 23:19:14.2614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b92e7c3-fd3c-4191-9712-08db79c06b44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/pcie/aer.c | 57 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c354ca5e8f2b..916fbca95e53 100644
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
+	bool *handles_cxl = data;
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
+	bool handles_cxl = false;
+
+	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
+	    pcie_aer_is_native(rcec))
+		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+
+	return handles_cxl;
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

