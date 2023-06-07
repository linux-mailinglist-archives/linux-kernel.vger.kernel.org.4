Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F4F727189
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjFGWXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFGWXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:23:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB55E2700;
        Wed,  7 Jun 2023 15:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+OWq/uVkKmguTeXgr9OcbZpUuHbM32DhJ360ndc9yDhWUjtWSiTIeYiXa2syzGkz0IvYEiUDKnnkrO9z4Rmz4KMaHkINvyHIfjUqVmmKX7MgCFl+x9+K05L7sIXBfkLQGvVHNCYD+QR/KHd4QU5Swx1xOObIXpUWPi9941PPtL+sxWXvXqUZKMX2WQuzkWXXlOdeWKylcX7tc0RN22/2I2dol1ND7mNuz6vpXIQ6CO6y0HWInfrv4EfV5XbWH9JeRjsxEIfM1H+wh2PQj60wIzfIEHsw1N9tFnxrBtGSJ8TekYlNF03kSor4z3HCHK8plZPWkCC7vIkckxa4E41Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU6cWP2XbK0xTPRpJLyvdpwxEFzI21OkWH+SXFrZPvU=;
 b=lefz5NFMVqhhwemNZfzYiLX4i1AL4Zg+y3FxdDXIAF72pz5ezc/p1c/C4Yv++A1um9qD0i+Ej4IlJErxjNGopE6N95oNSU3KDvpKZOw6FbGfftOBe/y17dlHNfkpp+l4SlRE90MxVj4pMyL+Buun2KgKABLBtFl+Vs7sTC74gkVGCZ2WbYHjU4fj05IVaauAYR4pOJiiNS7IGnhG5CbFcC4j+tmiwUFCp/fJnNhOfKL29RkuTiePMEpPcdi259zFlk2pyofpTW2VmAobD8S8Tbr98/bzKpDEeGgyd8BUTapswVmfU9BaN0RKXAy8/oEZaT9P1h9nhrj0pY6UdmNI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU6cWP2XbK0xTPRpJLyvdpwxEFzI21OkWH+SXFrZPvU=;
 b=pogga3BI+jIUx5UL7p0JmsRdeyRDjokVuT9fN7rlnl8DNQHcZT3N9jPYyl2dpffUxlTTKASh7cYW+ID8f2z2AgLpFtuN8yUFDTVbWRXpHPDrxbBmxvOMIsgFC471KML3VRXJYw1d0pxTVRj1uPYKAwtcCIYcBwb+8BycNevFh6k=
Received: from CY8PR10CA0022.namprd10.prod.outlook.com (2603:10b6:930:4f::23)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:20:57 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::b2) by CY8PR10CA0022.outlook.office365.com
 (2603:10b6:930:4f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:20:57 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:20:56 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 21/26] cxl/pci: Update CXL error logging to use RAS register address
Date:   Wed, 7 Jun 2023 17:16:46 -0500
Message-ID: <20230607221651.2454764-22-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b39b41-c6e2-4595-1101-08db67a57752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UP5Fvaq1O0/k5VaG8DbndPMpDiPk2ecLDAmy5GC4C2+Vjco8ssvHh6s8VemI+vo47riAIrI2G4BtQM6nHJKwTGb1nn+Jrwf2AkxxwxY5jmmKsR6kRhV2yljEth0CZlvfjjAJEcxa0f64xEfnoU/QO4RlCrBLy//X0JC0+7Nmf4fmV7GkUhTcCpw/lfbypYONIZ8I14XRMRmSMTChe2hgHMj7tMKdjqKE2DZa0Hn/OLZ2wBOCnrWyzrUuyaKLH+wsUvW/kJpAhkPfVurEv+PvQwuOFs0FjTKq7yE7sd7DjA2d2v0DoVVxaHWPl3mElvsAqEqzZE072MWeHB5tWiihTOa1mIuCggdO4iVKLubIKd8Sz+ZIQ1xWwD2EeQoam3etcts6+gEaI9VVspre5LBH4MgQJFsdRSt4AdzUt17xXMqpv7JnmuXCYDo51FAkFHSFFVkrMmDAbI8vM6e9FWVD1r1oDAyeOREDNUDBeIVcbFeODfNY/Tlzi6T5IfrvDquzQjriw/0dkYtGGUxXCXjOOKtuvWpVYdbLds565meFuVQTGM0gOvkHIm3FPLgWW5rNpEqaGRl9EOQDPeGoGWpVPbPMXtufFbKDPcuiZMRMBHEWKPbZu/92+JzJ/yzyzK7hnzi0ZpyQompPVgs3uI0VzBvwOVP9srVq8WGaoNXhvzjTLHeSjjfW/m0kbOVYrhVQ8I/RPM44YYbONXOYfyWRETadkCfH6EP45vbN7lnLVXx4OxXm3fJZYIfOW53Ny7Er9yGmHCTHqEOXn53EKwklVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(47076005)(83380400001)(40480700001)(86362001)(82310400005)(82740400003)(40460700003)(81166007)(478600001)(356005)(110136005)(41300700001)(7696005)(6666004)(54906003)(15650500001)(8676002)(44832011)(4326008)(70586007)(5660300002)(8936002)(316002)(2906002)(70206006)(7416002)(2616005)(26005)(336012)(1076003)(426003)(16526019)(36756003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:20:57.1251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b39b41-c6e2-4595-1101-08db67a57752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502
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

The CXL error handler currently only logs endpoint RAS status. The CXL
topology includes several components providing RAS details to be logged
during error handling.[1] Update the current handler's RAS logging to use a
RAS register address. This will allow for adding support to log other CXL
component's RAS details in the future.

[1] CXL3.0 Table 8-22 CXL_Capability_ID Assignment

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 67f4ab6daa34..def6ee5ab4f5 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -665,32 +665,36 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
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
 
+static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
+{
+	return __cxl_report_and_clear(cxlds, cxlds->regs.ras);
+}
+
+void cxl_cor_error_detected(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+
+	cxl_log_correctable_ras_endpoint(cxlds);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
+
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state)
 {
-- 
2.34.1

