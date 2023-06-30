Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7961474451E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjF3XTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjF3XTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:19:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924D14481;
        Fri, 30 Jun 2023 16:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h58qamrVhjxQn48OkVdd7rv45z4nipeo/53kld28i7BEYSPpWED/0Y3DaBS1ZIWpJ32yUj6sUs5gBaRFM/zSRATcUjqkrZo3xFhDAKsgJ+tYGxJRRJ/73lWbzY5j4cZamOjGTdbV4azXswKcdiEDMJCGszCxC9s7w3ZeR0vfGJ6D3eRNcQ/yq56zmqFIHRqT7Zv2T0Nm3/1PRMKJiRzt+Fs93WIks+umQ1EnE65lIJ44anH7Yi3PzyctIiBAVw/7i5HIgL2GPyZuOPMm2ZqLXTj0O1zkYUrIixA1oqyeup2bUsOSBKhsV2rcQtQkeqnnluMeeAncJzPmVZOUS4mbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdkeZNvPc3j4XjGaPvDKt4cGD4c97qZFxGq5V/vHyeo=;
 b=Lw4HIFx2lGHl2Y3P6iQTNOe5SWQatsIDAniCx+sRtk4zz/RjeYfH1du/S8VdEljVqLvgFDY9u4rz7BhfrHhzLLg/ad3GPKwuRQNRZpBAeByx2Zbg0zjcgvIjm3jrlI+49u2frLe7Kc/wZWdDtKv7siQEL+xs/UaabaA9cfJUo1wYG9OSmK3u2PTpxhWUUGaSDdnswjmlA/g8Y73MIPoa9QXUUa3OPj8lIPKToYlRYU5KfxoLgahEfQZDl9ygYB6W5XOH4sXImmI586XQkyazA0VmbAZML9gaQuJF14XaonvJ0gRwHjrJlZxBAR+Ic1doJIc7eJny94IBo+7F3o4nTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdkeZNvPc3j4XjGaPvDKt4cGD4c97qZFxGq5V/vHyeo=;
 b=Q6oDAGSr0O3Mugc+HUqzHMT4SWiZ6Sg02l+Y3FmlqndacVy040Yil3KUAYZMl/+feCYTd6iYS3GQ+S+X5xGbDNUlzAtwDSOZ/KCTXV97JBAz6Ha2XJFIPkSe59p3kuqr8mf+xNBtBoUOWY7T5zhAEWJIkhozEscPaC0oFVff7gg=
Received: from BYAPR01CA0008.prod.exchangelabs.com (2603:10b6:a02:80::21) by
 SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.44; Fri, 30 Jun
 2023 23:18:19 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:80:cafe::77) by BYAPR01CA0008.outlook.office365.com
 (2603:10b6:a02:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 23:18:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.51 via Frontend Transport; Fri, 30 Jun 2023 23:18:18 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 18:18:17 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v8 08/14] cxl/pci: Update CXL error logging to use RAS register address
Date:   Fri, 30 Jun 2023 18:16:29 -0500
Message-ID: <20230630231635.3132638-9-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 39cd356a-feb8-41fa-305c-08db79c049d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbLWO8h50fiHDX+u0JiDDdrt4rgAOMo75qP0KEgGgYY6VHWuXcgsInCBLo5Dc1W0mErf24NoGBlA4eeDL2CSugXqBemkDkRuDxbSVqUB5bRXH1cDWRmMNmxdMtlwDHqpOFpKzcC3TGBkKVVtvfMgRv5axvvnI5CbBi9G2honx5zD5jVifjQpTOWA+FF6R25aQtjc6MhDt9gtZ7M5XubQeuioDK94rWANQ3eXDocqh6QvvqR+Rwgy+/a8Dssso1TrEN/G0dkmIWN0GadBrhkRjrP0koLz/Mg1x0zNvm8qa+rYJp14+kcIOpPBX/KQJjR+f6oQ/VTimPEOA/0Ccja+Dq0mfCD3VCeyz8cFj1m7zkaVDXGvsrbmyzmbB6Xf9cFxUjAnpiKD0lpM4vdVIMQiXAH9RcjdaMCIfJgsoRcWapmLee15TTyK8AWkL2T5iBmPRo3mmLkNEzQwAbpuMN2HsL/QWY0HNQs+GtIt1w7zgyXT/Cvc1iJVPVAxXS9ujwEuBF5KVeA9y9U2Uueeftzu6ew6c6tgKpVmJvqY+gACi3+3B14RjMs58eo964cjCTYa2OCL/4Zo/lcn7GOHrWXI2RdMbnsKzHGHbTMqyy+MrJeaSh2hfu4CtwmEJLiq2haA5sDfAELMkeBG+lu0ep6ABPSsk76693cY2wlEEgG9OV38/245kdcliO1IQiPahnZXVZS+drl44tp7yaOUKRhqwe9S4AG5kma/8/KopHQDromdDr6Sock09HNV3U+zN5igunATACPVdCeba4IgCfBg6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(26005)(2906002)(86362001)(356005)(6666004)(82310400005)(7696005)(186003)(82740400003)(83380400001)(2616005)(81166007)(336012)(426003)(16526019)(47076005)(40460700003)(54906003)(110136005)(41300700001)(36860700001)(40480700001)(4326008)(478600001)(36756003)(70586007)(316002)(15650500001)(70206006)(1076003)(5660300002)(44832011)(8936002)(8676002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 23:18:18.1862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cd356a-feb8-41fa-305c-08db79c049d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CXL error handler currently only logs endpoint RAS status. The CXL
topology includes several components providing RAS details to be logged
during error handling.[1] Update the current handler's RAS logging to use a
RAS register address. Also, update the error handler function names to be
consistent with correctable and uncorrectable RAS. This will allow for
adding support to log other CXL component's RAS details in the future.

[1] CXL3.0 Table 8-22 CXL_Capability_ID Assignment

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c | 44 +++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c7a7887ebdcf..edfee8035820 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -646,32 +646,36 @@ void read_cdat_data(struct cxl_port *port)
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
@@ -685,17 +689,18 @@ static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
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
@@ -703,7 +708,7 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
 		void __iomem *rcc_addr =
-			cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
+			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
 
 		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
 				   readl(rcc_addr)));
@@ -711,13 +716,26 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
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
@@ -732,7 +750,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	 * chance the situation is recoverable dump the status of the RAS
 	 * capability registers and bounce the active state of the memdev.
 	 */
-	ue = cxl_report_and_clear(cxlds);
+	ue = cxl_handle_endpoint_ras(cxlds);
 
 	switch (state) {
 	case pci_channel_io_normal:
-- 
2.34.1

