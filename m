Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0016C726B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjCWVjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjCWVjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:39:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5BFDBDB;
        Thu, 23 Mar 2023 14:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8JMqTopIN7bpxCcTpofB4QGqyHZ5jMtP2UfnqPfRz9eIQ9t3amdjI/LLQ9EZRrHs1eMzD30/JRaoXWkvWlIT4CDVjWwn/8sAeMEIedCsRrhG4Q9pPdPE60OolN1PNZ0F0btVn1/aAz0f/HHpSZYAT06A5VcWZijcPOAdPjkpy0jgTFC5qsps2gJL/XpQEdUtrf5UWRrwyp3rXfj3zQKskpyx+9vSKBGh0GpXhpgsWgqO/QNJD7+8vCjeziTknXd1YIEfopxSKc6cj2hifTrWtV0NcLbcfi0s+w6lud/FKW3lRmKHfLBiUR+SMuOTR13Z2DOztfUIw8HXhGWkbq9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5481EnOiCBVcELKPUfx5r0/5APSo3wdR1+fK/wWsUk=;
 b=ai0I8g+iQiiEFtLccoGCwSdwbVzBFe9DaKTPgM5Jg+oGnsxC9My5f3fftKThnvQPfBox5JyEbdxnY7Qz2cN7VKx9F32MGSF5ZtwCy6W3K18IbefU1Vse5ec5YM76GUWS8XojHQF7AWeLKmkEWHbY6713+namnEJzUhadqgyCLaUC74M7rLxZsthWRBPU0yCP3efQorjZXm0I9WzC9mOdCOKVGhqB5ywjDfSYNkCoAD2WRaVAVt1Pi5hwtYvAsDz18REZYnZa+HmIl9WvwdU0jwOHoeInkg2NqWLX2NBxiA1/T6wlOkb8Nc7kU+J4ovWtkJ5hpDPRi5dRRG63/9qTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5481EnOiCBVcELKPUfx5r0/5APSo3wdR1+fK/wWsUk=;
 b=wFmvKq9sFko+Ris7iS15KVQ+SkgvPVBqLaAN+hF3r/lmk2bM/GfgeHW6bvfjjq5yOgR7y26Pz/wm7Sk9XoxtiSet0VI4JakJS2pn4IqRE+U1ByQX2999HJpePqSmPKSeW9zeJ91uhROMrgLJHJ2uWz2bqVE0926KoDl6mv9qoSY=
Received: from DS7PR03CA0168.namprd03.prod.outlook.com (2603:10b6:5:3b2::23)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 21:39:11 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::40) by DS7PR03CA0168.outlook.office365.com
 (2603:10b6:5:3b2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Thu, 23 Mar 2023 21:39:10 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:39:09 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v2 5/5] cxl/pci: Add RCH downstream port error logging
Date:   Thu, 23 Mar 2023 16:38:08 -0500
Message-ID: <20230323213808.398039-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323213808.398039-1-terry.bowman@amd.com>
References: <20230323213808.398039-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c5df4c-62d0-48a3-d3b6-08db2be709e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rO6ZwjnSsm0Y2k5Ha0VBYSogOO8ycfydf5hoLjG35ddYDh5Boji1ZTpluzxNUeacAGYSbhz4esrW+vrxKnjqzrDF5daUtT4SgoQnI2aqPUN2rpz9nho533rSTvMsGQvhYl1+XIyh9BnZxYPoAzibPbq16DXu/3fOgh324YthmGd8JONip7rV91LraLLlFV+WiVOBuWq4yYUb01+DeQ055Bz+B8q1skaFCvBduxCmje7pKQASxE+S0giCDWp46WvMI9Ji14IWUKKhzodaii0EzURL9cjYSaGuSHqBaeXtiGIa3pzBadKAHC1APUYMpr2huYLv3j5imRcwrf8bDKXGDiEodktfzwhR5lWAtuHMWxjqX8eq+wDZ5q9jFH3XekZo6SHpM3Dsg32QY+d0s4XIJW4496k/pTZ8gryKPJxKPrQiq0baCvb5S3M22+xgTjMUjU5ocr3xIlDYQSSMIvIx5XZzIAvzegtVq4aprfCNN30oSBpgmHl9nuhhZGjX5a56/xTyLaBgfx7EA4GPcklP2jfSv/iJ5H8hHM28s6Vqd1IrfvT/JGhwAHkcbmk69uWJEXVZ7APqcygEID+LOE7SoAZsCzvL8fifgPvBiWuHkduvpdmRRmMTLqQp1OxizvtN7V3GrXg74wfwqa2h/PMtfJ2Bi1vbsqTfmIRn1OhE82x2k1BSXdqkt4ZTNQ0I21IEf5NzZVIhdruHs8VS4mycd7F9KtNrjFkehMM/82LM3cSGckyxomGes9DYwumNj1cz
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(8676002)(70206006)(54906003)(4326008)(110136005)(36860700001)(70586007)(6636002)(44832011)(41300700001)(81166007)(7416002)(5660300002)(82740400003)(426003)(8936002)(47076005)(316002)(30864003)(26005)(1076003)(16526019)(186003)(478600001)(83380400001)(2616005)(336012)(7696005)(86362001)(82310400005)(40480700001)(356005)(2906002)(921005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:39:10.5510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c5df4c-62d0-48a3-d3b6-08db2be709e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
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

Update the cxl_mem driver to map the RCH RAS and AER register discovered
earlier. The RAS and AER registers will be used in the RCH error handlers.

Disable RCH downstream port's root port cmd interrupts. Enable RCEC AER
CIE/UIE reporting because they are disabled by default.[1]

Update existing RCiEP correctable and uncorrectable handlers to also call
the RCH handler. The RCH handler will read the downstream port AER
registers, check for error severity, and if an error exists will log
using an existing kernel AER trace routine. The RCH handler will also
reuse the existing RAS logging routine to log downstream port RAS
errors if they exist.

[1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c  | 126 +++++++++++++++++++++++++++++++++----
 drivers/cxl/core/regs.c |   1 +
 drivers/cxl/cxl.h       |  13 ++++
 drivers/cxl/mem.c       | 134 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 262 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 7328a2552411..6e36471969ba 100644
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
@@ -605,32 +606,88 @@ void read_cdat_data(struct cxl_port *port)
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
@@ -644,17 +701,18 @@ static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
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
@@ -662,7 +720,7 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
 		void __iomem *rcc_addr =
-			cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
+			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
 
 		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
 				   readl(rcc_addr)));
@@ -670,13 +728,54 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
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
@@ -685,6 +784,9 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	struct device *dev = &cxlmd->dev;
 	bool ue;
 
+	if (cxlds->rcd)
+		cxl_rch_log_error(cxlds);
+
 	/*
 	 * A frozen channel indicates an impending reset which is fatal to
 	 * CXL.mem operation, and will likely crash the system. On the off
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 108a349d8101..7130f35891da 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
 
 int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
 			   struct cxl_register_map *map, unsigned long map_mask)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9fd7df48ce99..7036e34354bc 100644
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
index 12e8e8ebaac0..e217c44ed749 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/aer.h>
 
 #include "cxlmem.h"
 #include "cxlpci.h"
@@ -45,6 +46,132 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
+static int rcec_enable_aer_ints(struct pci_dev *pdev)
+{
+	struct pci_dev *rcec = pdev->rcec;
+	int aer, rc;
+	u32 mask;
+
+	if (!rcec)
+		return -ENODEV;
+
+	/*
+	 * Internal errors are masked by default, unmask RCEC's here
+	 * PCI6.0 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h)
+	 * PCI6.0 7.8.4.6 Correctable Error Mask Register (Offset 14h)
+	 */
+	aer = rcec->aer_cap;
+	rc = pci_read_config_dword(rcec, aer + PCI_ERR_UNCOR_MASK, &mask);
+	if (rc)
+		return rc;
+	mask &= ~PCI_ERR_UNC_INTN;
+	rc = pci_write_config_dword(rcec, aer + PCI_ERR_UNCOR_MASK, mask);
+	if (rc)
+		return rc;
+
+	rc = pci_read_config_dword(rcec, aer + PCI_ERR_COR_MASK, &mask);
+	if (rc)
+		return rc;
+	mask &= ~PCI_ERR_COR_INTERNAL;
+	rc = pci_write_config_dword(rcec, aer + PCI_ERR_COR_MASK, mask);
+
+	return rc;
+}
+
+static void disable_aer(void *_pdev)
+{
+	struct pci_dev *pdev = (struct pci_dev *)_pdev;
+
+	pci_disable_pcie_error_reporting(pdev);
+
+	/*
+	 * Keep the RCEC's internal AER enabled. There
+	 * could be other RCiEPs using this RCEC.
+	 */
+}
+
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
+static int cxl_ras_setup_interrupts(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int rc;
+
+	if (cxlds->rcd) {
+		rch_disable_root_ints(cxlds->regs.aer);
+
+		rc = rcec_enable_aer_ints(pdev);
+		if (rc)
+			return rc;
+	}
+
+	rc = pci_enable_pcie_error_reporting(pdev);
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
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
+	return cxl_ras_setup_interrupts(cxlds);
+}
+
 static void cxl_rcrb_setup(struct cxl_dev_state *cxlds,
 			   struct cxl_dport *parent_dport)
 {
@@ -93,6 +220,13 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 
 	cxl_rcrb_setup(cxlds, parent_dport);
 
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

