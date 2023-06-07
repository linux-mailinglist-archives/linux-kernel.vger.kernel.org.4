Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D44172718D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjFGWYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjFGWYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:24:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC5B26AD;
        Wed,  7 Jun 2023 15:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVM2sq3DTCtgTtC+Q1Tn6lqvayjY4E11nkV6v3tt+qYjw5uosoQTb0hEulSQeE4IL9cMTB7+WcAjxBAc+63IswVZ10oF995cJV4evR5+Tpp41owJe4XU9WuntvBxSyViL1fn5jYNlI23w1kgQB/zbZbuOMz2NzVxwLnw5L4F9fMGQl5HM0LdI0wsEwqI2GIOeP/cwRGWC0+6Bo1IsoQIrfChlVzxvDuL5SP4NTzxLKUUE3sYlJA6zyIUFYMt3NcuIB3ghHLvgyA8i2qibcQBVfYf4y3jdw6fO4spQBROtoKLxmfn6bmGxAb0KuK4pp3UD73TmtDp/WQTNg8QLOiXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0GGONdaLsu2nFxungWWLlOfpYL6mBJEx3VzvXIdB78=;
 b=ML6YNfZkIaYbF6l9YGGxkBnFcKxcvg7JzCe1UDX1T1sJzEVE1rIYM5gPNPC4HXs9LRQj5l9DrzIImEC7mm2qpbuB6Z9sLgKFUAMNS268frVEODW/Od7JrJxIMsJWD3OFvuhWWJtUl4QHnQzAKJdevbZHiiqxV3MdHWXIm175WvAyL7BcBJwmMvOhyyJ7lblsURAnssBGafyv5g5RjM/d5ckjRarjIh+tDJSDKMJHu8xa1f19/+PX3izQZxKWh2V5LgnZa6plq8jsaNMss4u4TZM7HyN0tR+XlOYr1DnSfGymmE2RPhP99m7yPpGPon2EGkGQALhGDNrcdMDdhkMIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0GGONdaLsu2nFxungWWLlOfpYL6mBJEx3VzvXIdB78=;
 b=tkgqYn1faNF76UrjX7n4ekz6Gm9HnhNVBLMiNjhwz6e3QNTssaEc0RFV670nFUWtnMSg90kh09nDajXq9sYtQ7VBBijiwcVNwGUKDF4bnP/KJKSdzqeckqnGxoPN9flHQxoyvNTZSiDOSXygIh1bvWUmgHrMIflDPMsEmmBCi0Y=
Received: from DS7PR05CA0101.namprd05.prod.outlook.com (2603:10b6:8:56::21) by
 CH0PR12MB5169.namprd12.prod.outlook.com (2603:10b6:610:b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 22:21:30 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::9a) by DS7PR05CA0101.outlook.office365.com
 (2603:10b6:8:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:21:30 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:21:29 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 24/26] cxl/pci: Add RCH downstream port error logging
Date:   Wed, 7 Jun 2023 17:16:49 -0500
Message-ID: <20230607221651.2454764-25-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CH0PR12MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: 876ec96e-e5ef-4eb3-f448-08db67a58af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQIjLMXgHXriepW2WrJiLxH5rrsxIAdTsyhL2U5kfIfS8TuaQALsVf8IXbC9/9B0SQkTEgOQm6fsPES7x/OgANWa2Nv53xNsl8gEENO44SAsQxiXf4ITPP8leJCabGK58h27eceLsgl67NaKTqg7QU3s9iDdEyGdrpa5MQLA29xNrzVH7ZvhYzbdDZKBaudIIk//zt3OHsJP0k+VhKrbWYBcKRDzgfvR+xTGQbdqGBrmxJVN1YP+ND/eZemZYiExM9lr4U67cCqKyKS6A7jW3QVwOlkHkX4btxyTKL1guw9WcpOzWTtPAG6v5woOiim4K+trsQ2WqzNoWU7IfJkKzTWLuv7SD24pLMWABz8av712OPFPPuC2Tcr5Qw6EG9e1hhZhGcmXMqVIEoVIhqPg7Fh9C3jW/AGs2HD2m/u1krQbW2EwjwrYBJSR2jgKdFxkZj3Kv74UAQkqabkrPAu+lJw2CnhetCoqB7RfWG/H7f2Xj9VJpUorQg6ys1E07V7BgKum6Izgf8JZ+VqODqME663N+wmGHz95Pzt3uz1u9eUTvLOfBGsWe/zz4jCY2WUbTZIYb55g5P3Ui5vCpSAHggILXoi2DFqiTFHfDNGhreIHyCu1w53aum7M+x825QjDYBOIjJcAoe5rs+Xx91V9ffokjUusaenwiYyo4ysv8yxQczACco0lxhcqGEG7kto65CkBp7qu7pb7vNasJrcBtsubw1eU85rVvKW124IFZqBRZHd5gpAhR9iO2SEc9U5zfnStPR6Dn+JfLbBwR+XmJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(336012)(2906002)(1076003)(356005)(82740400003)(26005)(40460700003)(86362001)(186003)(81166007)(83380400001)(426003)(47076005)(36860700001)(2616005)(16526019)(82310400005)(5660300002)(7416002)(44832011)(36756003)(110136005)(478600001)(6666004)(54906003)(7696005)(40480700001)(41300700001)(70586007)(8936002)(8676002)(70206006)(316002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:21:30.0668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 876ec96e-e5ef-4eb3-f448-08db67a58af6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5169
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCH downstream port error logging is missing in the current CXL driver. The
missing AER and RAS error logging is needed for communicating driver error
details to userspace. Update the driver to include PCIe AER and CXL RAS
error logging.

Add RCH downstream port error handling into the existing RCiEP handler.
The downstream port error handler is added to the RCiEP error handler
because the downstream port is implemented in a RCRB, is not PCI
enumerable, and as a result is not directly accessible to the PCI AER
root port driver. The AER root port driver calls the RCiEP handler for
handling RCD errors and RCH downstream port protocol errors.

Update existing RCiEP correctable and uncorrectable handlers to also call
the RCH handler. The RCH handler will read the RCH AER registers, check for
error severity, and if an error exists will log using an existing kernel
AER trace routine. The RCH handler will also log downstream port RAS errors
if they exist.

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 98 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index def6ee5ab4f5..97886aacc64a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -5,6 +5,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <linux/aer.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -747,10 +748,105 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 	return __cxl_report_and_clear(cxlds, cxlds->regs.ras);
 }
 
+#ifdef CONFIG_PCIEAER_CXL
+
+static void cxl_log_correctable_ras_dport(struct cxl_dev_state *cxlds,
+					  struct cxl_dport *dport)
+{
+	return __cxl_log_correctable_ras(cxlds, dport->regs.ras);
+}
+
+static bool cxl_report_and_clear_dport(struct cxl_dev_state *cxlds,
+				       struct cxl_dport *dport)
+{
+	return __cxl_report_and_clear(cxlds, dport->regs.ras);
+}
+
+/*
+ * Copy the AER capability registers using 32 bit read accesses.
+ * This is necessary because RCRB AER capability is MMIO mapped. Clear the
+ * status after copying.
+ *
+ * @aer_base: base address of AER capability block in RCRB
+ * @aer_regs: destination for copying AER capability
+ */
+static bool cxl_rch_get_aer_info(void __iomem *aer_base,
+				 struct aer_capability_regs *aer_regs)
+{
+	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
+	u32 *aer_regs_buf = (u32 *)aer_regs;
+	int n;
+
+	if (!aer_base)
+		return false;
+
+	/* Use readl() to guarantee 32-bit accesses */
+	for (n = 0; n < read_cnt; n++)
+		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
+
+	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
+	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
+
+	return true;
+}
+
+/* Get AER severity. Return false if there is no error. */
+static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
+				     int *severity)
+{
+	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
+		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
+			*severity = AER_FATAL;
+		else
+			*severity = AER_NONFATAL;
+		return true;
+	}
+
+	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
+		*severity = AER_CORRECTABLE;
+		return true;
+	}
+
+	return false;
+}
+
+static void cxl_handle_rch_dport_errors(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct aer_capability_regs aer_regs;
+	struct cxl_dport *dport;
+	int severity;
+
+	if (!cxlds->rcd)
+		return;
+
+	if (!cxl_pci_find_port(pdev, &dport) || !dport->rch)
+		return;
+
+	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
+		return;
+
+	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
+		return;
+
+	pci_print_aer(pdev, severity, &aer_regs);
+
+	if (severity == AER_CORRECTABLE)
+		cxl_log_correctable_ras_dport(cxlds, dport);
+	else
+		cxl_report_and_clear_dport(cxlds, dport);
+}
+
+#else
+static void cxl_handle_rch_dport_errors(struct cxl_dev_state *cxlds) { }
+#endif
+
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 
+	cxl_handle_rch_dport_errors(cxlds);
+
 	cxl_log_correctable_ras_endpoint(cxlds);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
@@ -763,6 +859,8 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	struct device *dev = &cxlmd->dev;
 	bool ue;
 
+	cxl_handle_rch_dport_errors(cxlds);
+
 	/*
 	 * A frozen channel indicates an impending reset which is fatal to
 	 * CXL.mem operation, and will likely crash the system. On the off
-- 
2.34.1

