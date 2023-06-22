Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497B473AB26
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjFVVFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjFVVE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:04:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816A21BD0;
        Thu, 22 Jun 2023 14:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHgxvonPnC4J+If54e0y7llAYjcJX2WxwHc3ghSlQk38AIJQzPnUkd05kH2cehm3ceOFWApH4xi8+dtgHHqdPQiWFRB6nwvNSMDuu+/9hlg2KS8NJPmFfFs48mATGk/thMSoN/jef8xZlP/dfcj9Ht+nLJwupT33B6GCzS6eUk7isR5IUSGqjLGx4FELcsC9Muu/gJ8h3oISaXlojCLyibOwghlLPtmuzHDR2hFWqgePo0NqsmDdVltP4feV69kcsA46r3g3xZnEmXMOneQQKBZfWWYmZWCt05RsOWbGx6dJF9Gxl7uBet46GT8kfGy4HJz1n2M8u3TT+vvWR3NKYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5w+KTJK/mUjsbjCPqYvp9WeEjYQwl+zUkuyYGrrKKg=;
 b=dM8e8hivcRGza/rQj6uOUGI6ZihC0zK4BRZURgial774CD8zNPOoHbeux681u7oW7vcwgfYyqra7ql6eaSfUdlU+71oneGgfzMShcoicgjB8JBRQEwGMAmlwZjnlXarQcYDIktBfIh2TjreH+EIik7Uftu2gD+l5p9xP2mqTu/AlGeDYONK6OdslqYWYegOTIxb+vnyPxLcDF1EvDLYFhYZhYBsuzvd8AJi1RpVuTV494TKtWeGGga0D+3zxwUsZpoa+zidH7/hfIFPZJvLMo4aQWP+2SdiPy9xP9v/J9LyK38QPFssQtzoOyO8FdKjXKh6thVjQcvJYLkkBav9+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5w+KTJK/mUjsbjCPqYvp9WeEjYQwl+zUkuyYGrrKKg=;
 b=uJRD00aVnQ0He1zV0fex8AUGUvnq/rCX3/k1RaqyinlqKPxcKkTQF1YteD9yBbkeCsnLHr+pzp/kzUACRjSnQGSuJDwi8FmR5e9XUA0HcQcfHSY9zAKk9RbpWpY4Ww9gc3Kus3oa5h4LzQvG9GKaiB0T//FphwxocbkvlcnkZvI=
Received: from CY8PR12CA0021.namprd12.prod.outlook.com (2603:10b6:930:4e::21)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 21:00:19 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::e9) by CY8PR12CA0021.outlook.office365.com
 (2603:10b6:930:4e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.25 via Frontend
 Transport; Thu, 22 Jun 2023 21:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 21:00:19 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:00:18 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 26/27] PCI/AER: Unmask RCEC internal errors to enable RCH downstream port error handling
Date:   Thu, 22 Jun 2023 15:55:22 -0500
Message-ID: <20230622205523.85375-27-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e663455-ee60-4b1f-6dde-08db7363afd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnVm7ffa9mkbejNaIVTwHJQzYukviZZYV4XipFa/LCyExJ23C+ruhq/b9r2sIrPU4Al/15nGD6rqUuMYDhrPi9VMrmJ7QQxbW0yuLEkRZ1xKMARBVGv3qGgfKMtspgqvgvtDNB4W6ItaZvMZ0i8F+i7H7OwW7i/38G2RWWxf1m9RiaY9d+e/lyHh50YIAujGgC/LXf9XrmR8iqxnVU7Ght4TtZWf4IVgEp/gz2GcRKzly/MC1ZhGcsMQVt32INqMUpHOSQjHUT/a6FPHItJXgdJhvEmm9fHOecKLGRsf0ILbOpuH+Afvk/7yKgvgcV7A1laRJxN8SXCuTOOI+8OdXAo1mGYa5WWX1zjfNx/2Wie7XKH68UzOkn04Wq7WJaFG95gZRtKjpHAcBBCeUw81gAKbv2+QR7fWARlRIJJXke8tOzhbqA70qXXWGHSJKi8Ztn6nLv9q+eYNmMoWrRAEeT3J9ynfn9qy3yQvHbhjg7Jc4D1bLDJ1XBLkuOFCt4Ftw9r7DgFFVnwRNd9St4a7odqZeQrZKk7nqqpgtkrRXs6Fw4GZjrCyYfMMIrCCUipx3mkWDxhQNuELnGMFa3gaoYnTGhWW3i8lV4IHIUXPuA2xIINykXTlp5ItdbnfpRRjNMm/6v0zmnhgM+efeE8i3T8e/LtiKJnEO5eg9roZ2nFaptHFhstfqbo3JOiKfL4uLBmxDkaWMY78icPYEGyUmmFQPAm526rpPkeFq4fAnHULOQWjLAwsJSEB91A6/7+HjeOA68OHl5Lu0mvRpwzcyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(316002)(8936002)(5660300002)(8676002)(41300700001)(4326008)(54906003)(7416002)(2906002)(110136005)(70206006)(70586007)(44832011)(478600001)(7696005)(40460700003)(6666004)(81166007)(356005)(40480700001)(83380400001)(16526019)(1076003)(186003)(26005)(426003)(47076005)(336012)(36860700001)(2616005)(82740400003)(36756003)(82310400005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:00:19.1051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e663455-ee60-4b1f-6dde-08db7363afd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

