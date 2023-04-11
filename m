Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1336DE375
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDKSFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDKSFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:05:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D3D7684;
        Tue, 11 Apr 2023 11:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0N5+CehIIaHIi42c26eKqgJsQXXriAZRJukJ3pb/hexa5xonFKlgMK4thOHwB/LFAVss0PJB+Z0fYZPAMa98vRZlz5ZODxo9PMIVKolij1qHR6gpDRvoSI9zboWHjPQnEe9bcic7gc52c8Ui71h65GLDbetSh3WpUDzlCJuhDjg/Doovfab2aCrvr88YDJkxzaH+aR/JlPNkG4GOvWaD5dKGsjlhc1Lgv1hGNod0IcsVMsw7y3e48XLU7BoGGxrP8sHLS2BBCR7wxwtMnM1FjO0DTo6lm+Eyaw0cYdCVfFQZxUWJwnxiTSYeoMrOK0QDRW3bNHp6Ww9hCnNq4Jfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HNEpXsg4Vtf2TLjMwcMF50f0xfm/vpo555pR2k8lXk=;
 b=mwtG1xQH+sniPDj5YBAUC8+jl+fxwueqYlUsAkJFAQDCCn+xneTjq2ktSwHKIy+QOEG9UYcQh3CfmuZXcCwAhOAZZB63EQM6H2CyIONhLuwgoGGRyHLDjO2zoycEVVvark04j81+qvTFYNPlc/9EUaxXnslDH3u0mdeqWq8mUcQiFKjACQfXXZp18Ey2mFM8XuQiUH5OlkNkBQIoB5kqI/gl4z8k/NfGDrk3naYWUMYQXrE8KYmrrSP+nGu6x+6wGQpcAPWJszqLwqGv55/Fqpa4iA8WeiEfFVPr10QUnlZES0aiglCh5y8ZgegT68+9ZxHkJFRBcVGh3G9hFdLC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HNEpXsg4Vtf2TLjMwcMF50f0xfm/vpo555pR2k8lXk=;
 b=LqNBbxNoRPoPxzIn9m9yL2a8TsUSjoiEPET5Q7Qa4BHNsye3HuCc0pYArOpiNvQ8bWOb9BU/hlaqSeSgc8Og8OTTRux6TIbEllJkEfeu9lQ5l4L8/KYi9cDKxgD7SFThgjZeB/bmeIGhneMEEfCctcO+E1136bgV4sZjuFvMmRo=
Received: from BN9PR03CA0158.namprd03.prod.outlook.com (2603:10b6:408:f4::13)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 18:04:16 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::8) by BN9PR03CA0158.outlook.office365.com
 (2603:10b6:408:f4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Tue, 11 Apr 2023 18:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 18:04:16 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 13:04:15 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v3 4/6] cxl/pci: Add RCH downstream port error logging
Date:   Tue, 11 Apr 2023 13:03:00 -0500
Message-ID: <20230411180302.2678736-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411180302.2678736-1-terry.bowman@amd.com>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f7c8db-ed4e-4a2b-3a56-08db3ab72a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h3ORJ36bD2zMhLj9KyNfnogWptBCoN7eT6i/f7qkoehkgPlSNyedEsjQuvPot1CaxeMB9CTJzOHgo+ACxQUSF1fg57bL0vfax1c0S7Ga69XwfBOcdcQtaPOt+lOscSOQ4X5+xAqikB/Wb9Cd7B4fXjYfQJscu6x8cFzGAyFzCKwBuTQ5EVV4B8PntqW6ND7+m4NZ5Htcp7DbYeuQ+mx411rGpU3jH49Cd/kkEJy8OoGnnG8bTIMdXOL+OEV7UZ1Z1Z7IV1apJsDlA9+fwAWokJ9SijdOAhgOTItQag+NFe+ZDpe6X6G14MxyCguAoOxeD4FHIbu09PaHTeTjiI3sn32Kq5v6XFEdujXxq4fsRMLX5NHczFb4fhsC+In9Hruu+E2Kux3o/q8hSOZmOrS3g21ZhtCQWuO8jAyDFb79hvKf9Ovni8k//ODzaoz9PYYAlu7RU+z8gnDHkDO4iIGDvzuoUDTPC2jIMpZRjLpn/QjXXMuUglt+esIxgyuAwYXZ156K8rP9FySpkuYyTFk4wkGJbaUsmJCyEcZ+CIUH9qCkMu9C+pv9dKizh/BTu7TeUl2qcvTLH193wEM6nQ+By7jkqLEbIWX6R+Is6XenYQp3/f48EzMn0DKzCIXRwr2Djs2OzxZSiOC+T6Q8PQKJ95cOYkiGrFQ4BBqiVJ/JGmgxMaHYl5I0AOlrw8xaPjVtiF+rV73C2XLcRT6WQAVwfwJ739+MeOODrIkjR+BCXgw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(7696005)(316002)(1076003)(110136005)(26005)(54906003)(186003)(16526019)(5660300002)(6666004)(30864003)(2906002)(44832011)(70206006)(70586007)(4326008)(7416002)(41300700001)(8676002)(8936002)(82310400005)(356005)(81166007)(82740400003)(40460700003)(40480700001)(47076005)(83380400001)(36756003)(2616005)(336012)(36860700001)(426003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 18:04:16.1917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f7c8db-ed4e-4a2b-3a56-08db3ab72a13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Update mem.c to include RAS and AER setup. This includes AER and RAS
capability discovery and mapping for later use in the error handler.

Disable RCH downstream port's root port cmd interrupts.[1]

Update existing RCiEP correctable and uncorrectable handlers to also call
the RCH handler. The RCH handler will read the RCH AER registers, check for
error severity, and if an error exists will log using an existing kernel
AER trace routine. The RCH handler will also log downstream port RAS errors
if they exist.

[1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c  | 126 ++++++++++++++++++++++++++++++++++++----
 drivers/cxl/core/regs.c |   1 +
 drivers/cxl/cxl.h       |  13 +++++
 drivers/cxl/mem.c       |  73 +++++++++++++++++++++++
 4 files changed, 201 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 523d5b9fd7fc..d435ed2ff8b6 100644
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
@@ -613,32 +614,88 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
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
+/*
+ * Copy the AER capability registers to a buffer. This is necessary
+ * because RCRB AER capability is MMIO mapped. Clear the status
+ * after copying.
+ *
+ * @aer_base: base address of AER capability block in RCRB
+ * @aer_regs: destination for copying AER capability
+ */
+static bool cxl_rch_get_aer_info(void __iomem *aer_base,
+				 struct aer_capability_regs *aer_regs)
+{
+	int read_cnt = PCI_AER_CAPABILITY_LENGTH / sizeof(u32);
+	u32 *aer_regs_buf = (u32 *)aer_regs;
+	int n;
+
+	if (!aer_base)
+		return false;
+
+	for (n = 0; n < read_cnt; n++)
+		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
+
+	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
+	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
+
+	return true;
+}
+
+static void __cxl_log_correctable_ras(struct cxl_dev_state *cxlds,
+				      void __iomem *ras_base)
 {
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	void __iomem *addr;
 	u32 status;
 
-	if (!cxlds->regs.ras)
+	if (!ras_base)
 		return;
 
-	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
+	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
 		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
 	}
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
+
+static void cxl_log_correctable_ras_endpoint(struct cxl_dev_state *cxlds)
+{
+	return __cxl_log_correctable_ras(cxlds, cxlds->regs.ras);
+}
+
+static void cxl_log_correctable_ras_dport(struct cxl_dev_state *cxlds)
+{
+	return __cxl_log_correctable_ras(cxlds, cxlds->regs.dport_ras);
+}
 
 /* CXL spec rev3.0 8.2.4.16.1 */
-static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
+static void header_log_copy(void __iomem *ras_base, u32 *log)
 {
 	void __iomem *addr;
 	u32 *log_addr;
 	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
 
-	addr = cxlds->regs.ras + CXL_RAS_HEADER_LOG_OFFSET;
+	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
 	log_addr = log;
 
 	for (i = 0; i < log_u32_size; i++) {
@@ -652,17 +709,18 @@ static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
+static bool __cxl_report_and_clear(struct cxl_dev_state *cxlds,
+				  void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
 	u32 status;
 	u32 fe;
 
-	if (!cxlds->regs.ras)
+	if (!ras_base)
 		return false;
 
-	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
+	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
 		return false;
@@ -670,7 +728,7 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
 		void __iomem *rcc_addr =
-			cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
+			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
 
 		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
 				   readl(rcc_addr)));
@@ -678,13 +736,54 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 		fe = status;
 	}
 
-	header_log_copy(cxlds, hl);
+	header_log_copy(ras_base, hl);
 	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
 }
 
+static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
+{
+	return __cxl_report_and_clear(cxlds, cxlds->regs.ras);
+}
+
+static bool cxl_report_and_clear_dport(struct cxl_dev_state *cxlds)
+{
+	return __cxl_report_and_clear(cxlds, cxlds->regs.dport_ras);
+}
+
+static void cxl_rch_log_error(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct aer_capability_regs aer_regs;
+	int severity;
+
+	if (!cxl_rch_get_aer_info(cxlds->regs.aer, &aer_regs))
+		return;
+
+	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
+		return;
+
+	cper_print_aer(pdev, severity, &aer_regs);
+
+	if (severity == AER_CORRECTABLE)
+		cxl_log_correctable_ras_dport(cxlds);
+	else
+		cxl_report_and_clear_dport(cxlds);
+}
+
+void cxl_cor_error_detected(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+
+	if (cxlds->rcd)
+		cxl_rch_log_error(cxlds);
+
+	cxl_log_correctable_ras_endpoint(cxlds);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
+
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state)
 {
@@ -693,6 +792,9 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	struct device *dev = &cxlmd->dev;
 	bool ue;
 
+	if (cxlds->rcd)
+		cxl_rch_log_error(cxlds);
+
 	/*
 	 * A frozen channel indicates an impending reset which is fatal to
 	 * CXL.mem operation, and will likely crash the system. On the off
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index bde1fffab09e..dfa6fcfc428a 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
 
 int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
 			   struct cxl_register_map *map, unsigned long map_mask)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index df64c402e6e6..dae3f141ffcb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -66,6 +66,8 @@
 #define CXL_DECODER_MIN_GRANULARITY 256
 #define CXL_DECODER_MAX_ENCODED_IG 6
 
+#define PCI_AER_CAPABILITY_LENGTH 56
+
 static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 {
 	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
@@ -209,6 +211,15 @@ struct cxl_regs {
 	struct_group_tagged(cxl_device_regs, device_regs,
 		void __iomem *status, *mbox, *memdev;
 	);
+
+	/*
+	 * Pointer to RCH cxl_dport AER. (only for RCH/RCD mode)
+	 * @dport_aer: CXL 2.0 12.2.11 RCH Downstream Port-detected Errors
+	 */
+	struct_group_tagged(cxl_rch_regs, rch_regs,
+		void __iomem *aer;
+		void __iomem *dport_ras;
+	);
 };
 
 struct cxl_reg_map {
@@ -249,6 +260,8 @@ struct cxl_register_map {
 	};
 };
 
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 014295ab6bc6..dd5ae0a4560c 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/aer.h>
 
 #include "cxlmem.h"
 #include "cxlpci.h"
@@ -45,6 +46,71 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
+static void rch_disable_root_ints(void __iomem *aer_base)
+{
+	u32 aer_cmd_mask, aer_cmd;
+
+	/*
+	 * Disable RCH root port command interrupts.
+	 * CXL3.0 12.2.1.1 - RCH Downstream Port-detected Errors
+	 */
+	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
+			PCI_ERR_ROOT_CMD_NONFATAL_EN |
+			PCI_ERR_ROOT_CMD_FATAL_EN);
+	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
+	aer_cmd &= ~aer_cmd_mask;
+	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
+}
+
+static int cxl_rch_map_ras(struct cxl_dev_state *cxlds,
+			   struct cxl_dport *parent_dport)
+{
+	struct device *dev = parent_dport->dport;
+	resource_size_t aer_phys, ras_phys;
+	void __iomem *aer, *dport_ras;
+
+	if (!parent_dport->rch)
+		return 0;
+
+	if (!parent_dport->aer_cap || !parent_dport->ras_cap ||
+	    parent_dport->component_reg_phys == CXL_RESOURCE_NONE)
+		return -ENODEV;
+
+	aer_phys = parent_dport->aer_cap + parent_dport->rcrb;
+	aer = devm_cxl_iomap_block(dev, aer_phys,
+				   PCI_AER_CAPABILITY_LENGTH);
+
+	if (!aer)
+		return -ENOMEM;
+
+	ras_phys = parent_dport->ras_cap + parent_dport->component_reg_phys;
+	dport_ras = devm_cxl_iomap_block(dev, ras_phys,
+					 CXL_RAS_CAPABILITY_LENGTH);
+
+	if (!dport_ras)
+		return -ENOMEM;
+
+	cxlds->regs.aer = aer;
+	cxlds->regs.dport_ras = dport_ras;
+
+	return 0;
+}
+
+static int cxl_setup_ras(struct cxl_dev_state *cxlds,
+			 struct cxl_dport *parent_dport)
+{
+	int rc;
+
+	rc = cxl_rch_map_ras(cxlds, parent_dport);
+	if (rc)
+		return rc;
+
+	if (cxlds->rcd)
+		rch_disable_root_ints(cxlds->regs.aer);
+
+	return rc;
+}
+
 static void cxl_setup_rcrb(struct cxl_dev_state *cxlds,
 			   struct cxl_dport *parent_dport)
 {
@@ -91,6 +157,13 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 
 	cxl_setup_rcrb(cxlds, parent_dport);
 
+	rc = cxl_setup_ras(cxlds, parent_dport);
+	/* Continue with RAS setup errors */
+	if (rc)
+		dev_warn(&cxlmd->dev, "CXL RAS setup failed: %d\n", rc);
+	else
+		dev_info(&cxlmd->dev, "CXL error handling enabled\n");
+
 	endpoint = devm_cxl_add_port(host, &cxlmd->dev, cxlds->component_reg_phys,
 				     parent_dport);
 	if (IS_ERR(endpoint))
-- 
2.34.1

