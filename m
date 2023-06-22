Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DE1739607
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjFVD6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjFVD6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:58:14 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2EC1FD8;
        Wed, 21 Jun 2023 20:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKm48FhNtlpxfuPtru1qHL6Yx4CQ7Xs3jCCkDcANvPDacY0w8N8Wj+htpZDTQP+OjMO9vmxAGRD0cgmrsPwpl5JIWTuROv5tTe6lvWP9elHk+TlI6jWS+a4zXvYOWydm+/dpdc/y4qtCa+tpQBRqzITcLudIL9vxEgvqE3PVt08nnsoh+shWKe6DFDHgmSY2HZ5jPTI6aPaWocb3sEbg2FE1Py8t5Rbr6QJKeXE9PWaUh0ogoz+ZK/djL0Km7NxN/Awncb8SxTQoSKC+dxqJuUwyXDi//qFWbDUt6otOzfqd4nC86OOmapOORNxka1PWbaINcskuWBqJKDiSZYCUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJGb8iVAmjFWLMxEIW//gmwKAZ4/XIlDRXWXqsX637M=;
 b=dfIKlsVZxEa26Fhq9MPH0A/KIJ663MJEYAk+k/Y5+A6ztCR6M5A6hle+A74XKyDTyKn6BQYt4fRrzaiSrHd5hVs8rNZ0QEb38HPCyN4/VPCsqGTyZgdq29EYAm/+jASkmROmfVoPSY6nMMD2ZxeYuA9f6zysoQDxubBsXTCufGvcmHePoLbBvnSOV34tldtjsewQUjlwxen6KQP0owplrN7+yF6ZkGo5ry6crcaUs9kBK5r0o8PlczxZNpgghCBRqGv+k8hoabSpHc6wnUuAUYS19QgMHEBBPkixRKHlFgtUYIkGrZvuKaT39yZUKvhjdFtEVuOo4qaDS1fuxRHdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJGb8iVAmjFWLMxEIW//gmwKAZ4/XIlDRXWXqsX637M=;
 b=e2kotyawY+jC3MYvsNPYOTT6r/qLHmyemlJZlaB/AQ94SC+cY4+ftX2Q5aEJ47BlMweODv+0ghvAbHF+HN4ESM6MVx9dCcGpX+zNEKwAmMwJsoTNzb4LKc0I/BaNwS4I8asz7obtT8U4Yi0nHp9TNmAEtw+tOyV/uxHInsQLcrY=
Received: from BN9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::9)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 03:56:45 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::4f) by BN9P221CA0002.outlook.office365.com
 (2603:10b6:408:10a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 03:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 03:56:44 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:56:43 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 22/27] cxl/pci: Update CXL error logging to use RAS register address
Date:   Wed, 21 Jun 2023 22:51:21 -0500
Message-ID: <20230622035126.4130151-23-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3a3cb6-96dc-47c1-d399-08db72d4b1f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qeKlBMlJjQ4JRIKsVNmeRFt9pCBQzvz+OI18sd09BLgTTpZoAskC2d4a5AVDvgheuZuHqWhT4pb0tKcZ6NjfKoItgasg4mPaMJ00njgslMHPHmb4t7jlRw0bmNFu1NopcE0KyyHUANerkGdNjo1mvyEKOS4psF89dyDoEoYdnt8aHLSe0Hj7Jh7CfHpXRKUAqKnKz6dL1CaAvE/M0DL0VcJXyJehcLQFqOxdKIZIDUTOqY0J7wz4WH+zhRbetOjdIB3M2j/G20BBAsjXoigY5BF3+R3ZnoNJtuKUNLJ0zGMoTHRxi1Ve0opCuCD+Cn/We1uSQIigPyNXx/dPpigCxQ6QBf/cBNF6O5xRIVhsfDx0tl1eDL8oHH9C86sQRgWg7J00iKeaoAbMVoDWsHVGINKY8YSsH44HSNhtJx/txMO2DRIle8moj/l/7kDPpDDSZgh3U/v4QYgbze0BjVwUl+nYZsLXs1rAFO2m7O3SKWnpWf6hTWUSrfbFJ/xl+serOmVqMV8v8ZXx8bb3dka0sp8P2ahbvopsc3PaVbQXfxANE0BvkyTbJaSTJtQvwNTjP0gvEaVwwVnQlIacvv/oajSLsYFAbi2zIIG8HuT1XHUxlSrhHM4Xju7suRR79UmPqRPrfg7YgrF7kYjZLGtgnpOdS3F/1gqRYWv5zP2gqpl1mDof4nDJMtNCCjtgYD9s1TIx9s+Ftyl8gHuJUSkbzqm1vMP4fok7ndnC8aONHB/1JmIp4kBnEL/RVW1yA7u61ICrtP78R65ARen8cAvLJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(356005)(81166007)(82740400003)(7416002)(44832011)(2906002)(40480700001)(15650500001)(83380400001)(47076005)(426003)(36860700001)(36756003)(86362001)(8936002)(2616005)(1076003)(82310400005)(16526019)(26005)(186003)(40460700003)(336012)(6666004)(478600001)(110136005)(54906003)(7696005)(70586007)(70206006)(316002)(5660300002)(41300700001)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:56:44.7030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3a3cb6-96dc-47c1-d399-08db72d4b1f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CXL error handler currently only logs endpoint RAS status. The CXL
topology includes several components providing RAS details to be logged
during error handling.[1] Update the current handler's RAS logging to use a
RAS register address. Also, update the error handler function names to be
consistent with correctable and uncorrecable RAS. This will allow for
adding support to log other CXL component's RAS details in the future.

[1] CXL3.0 Table 8-22 CXL_Capability_ID Assignment

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 44 +++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 375f01c6cad6..9cb39835e154 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -665,32 +665,36 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
+static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+				 void __iomem *ras_base)
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
+static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
+{
+	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
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
@@ -704,17 +708,18 @@ static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
+static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
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
@@ -722,7 +727,7 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
 		void __iomem *rcc_addr =
-			cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
+			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
 
 		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
 				   readl(rcc_addr)));
@@ -730,13 +735,26 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 		fe = status;
 	}
 
-	header_log_copy(cxlds, hl);
+	header_log_copy(ras_base, hl);
 	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
 }
 
+static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
+{
+	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
+}
+
+void cxl_cor_error_detected(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+
+	cxl_handle_endpoint_cor_ras(cxlds);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
+
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state)
 {
@@ -751,7 +769,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	 * chance the situation is recoverable dump the status of the RAS
 	 * capability registers and bounce the active state of the memdev.
 	 */
-	ue = cxl_report_and_clear(cxlds);
+	ue = cxl_handle_endpoint_ras(cxlds);
 
 	switch (state) {
 	case pci_channel_io_normal:
-- 
2.34.1

