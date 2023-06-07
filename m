Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC0572718E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjFGWYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjFGWYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:24:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2EC19A4;
        Wed,  7 Jun 2023 15:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLrfwENaEjEVwLtqtp6yLCrgjCDla7/UTWJbVZEXsvpw4o4gCOK7cR1F2IqtnUYPdyvA1C8DsqSfFuJp1yWOQrZ5qmZBlYCvALny3xvh27mc0+WyuWlgsnV1nACive9cS2p/gHEPujJMiDZCCZJkkn1EQsyoYWX2IYX/86orShXGkxn0uS8RhD1Le3GjNH9sbKAx54ODOd7Qn+OCtCWywIyJwwsVF1eFE3NwbUF3qwCKXj40LRbUaBEcsgstnxaKGCCnsi6LMU1uyRmfjPYw4dRg62+N7wHwZsVHbuhz/pRKMiCsAy7uyxPl86pKuKpX6l/Q1AfAmZZqZp8BGo+qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eW0rSZk2znXT/WBE5oVCXLo7FkahCqO42ZyAEYPqjw=;
 b=Ns5YasLvhdChbYQyCmk2ZbPpSZHuIoI+CNn9uuZdRGIwmEwRW5ZTvuabw54OhAbXMTdjna8JEULikWHow/W+nAUA5G4vB/OU/0cc/8BLqrC2usxlOllRczPd8XB1jK6jBACvjwbxEtMavfqvDDbr7ylmXNGU/vibR3qNCHJNtWz8ZWxYIqoC4n+cEV/s34JDjFJxL/RQTnX/7twB60V2UleUzME5kznPkKidi1qBtrBeL9TVxEVQ5epRc/oTVPSverd8WQuoUU3/om3BDmzA3H7dY1pRXIQ8/RvpYd4sOBP/euHftIAB70Gan+ROfiMmLLIzSbiJWteMUAY9cPGmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eW0rSZk2znXT/WBE5oVCXLo7FkahCqO42ZyAEYPqjw=;
 b=v2S8jIYhWPqb/rSvdyRgAzTgBAv2uRYRWydFAit0zDH45ST8mbBKoo48sbGHsNs/yF1Smz7ZqaTlR39XLoSlPHtQjxsl7/DD59tHliuS+5yNIC9/g1ak7wApo5YgTUKMG2gsgUVs2KhwPJU8XE6zBJo2g+J2vZIV5VXVmKUKX1w=
Received: from DS7PR05CA0004.namprd05.prod.outlook.com (2603:10b6:5:3b9::9) by
 DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Wed, 7 Jun 2023 22:21:52 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::d4) by DS7PR05CA0004.outlook.office365.com
 (2603:10b6:5:3b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:21:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:21:52 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:21:51 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 26/26] PCI/AER: Unmask RCEC internal errors to enable RCH downstream port error handling
Date:   Wed, 7 Jun 2023 17:16:51 -0500
Message-ID: <20230607221651.2454764-27-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 289628fd-9e83-4405-b744-08db67a59809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRcNk6fGG87/i5QDnuacgNu2wUleutousK3usDyc7y63OZfOaxAPc+pZQjqjnof5aFIGMzxLO62+J8syyG7AXf0GWarqvKI4qMxyAeqM1xXWagkeih5S0odIId8Zd8Y3xolbwD8JjCs7+U6tRSWDzpOeeAS1juNp0ylNDT+3QBPLFqZyCqWziv7QuNUVwnDtvtGq7SfRKZO12WuW/QA9VrrZ1KpBZlkCrGtuw9aZfvKdrBihJOogKHq86LFq2fsVy2lWSqyxYa0Hcsu9MFPnxgk4UB9nIfRuLYKX1YzROxmf9NpkyN7+pLB00wiF5PU8yNOO+Q8gGMYcihJSQf0VjkWefQVBwhORn8qX3Xz+wBzlw8iWmNnfj03kQ43gyQpByDo0RmzSIjlMGcLFLTZin4dJoesgQsbuN+B7NO6tuPXnZkQSq96nA091FNwifJOq5fs6W2ewsCFabGgxwsXo8vkn9oWmMy0cV+L88MevZZcSW+FSqmLmv2hgFgnSvpCGlpN6bbu52DIyHnhXBBCJZ7HKFjcppBQL1gbLCjT6e3EWTMjlf9T5zqyDT0GymGL6Fcev36cpvFG2NK50N+8VDmKjF/Nb/3s7Ce5sx9GPGyXEdmpa+8JMMfZUaOiNdRBPU074vNdRXEpT30u0Sj6FtNpL8wlLx/4CkpcY3UI185I6VehKLGwU/8S7H5ziwn+5xaSZcTMVGZbvm4dROTnLZ4AoxmXz+9g9aVYEJpYpgMdAcOEZD1ak7kkmDy4pXkLPgnTjfHAvXD1NW8t6ZhtQN7T7hmNnC6ovZBOpfGBkjfU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(110136005)(40460700003)(478600001)(40480700001)(8936002)(5660300002)(44832011)(8676002)(2906002)(7416002)(36756003)(86362001)(70206006)(316002)(82740400003)(70586007)(81166007)(356005)(82310400005)(4326008)(7696005)(41300700001)(2616005)(1076003)(36860700001)(16526019)(47076005)(83380400001)(26005)(186003)(336012)(426003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:21:52.0001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289628fd-9e83-4405-b744-08db67a59809
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
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

