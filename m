Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313F170E988
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbjEWX1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjEWX1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:27:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA05E53;
        Tue, 23 May 2023 16:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKKsBEQ0uFgg2nFBiSBqjy/aU+psMhrRd4TNZjSmnUF+NyXZBWK1QPTFChUZG42YDoEuDk3NO8VPaVqGKCnrTDB4QzhbLKHP1bq2o2kFkkReUdhtxNOGGRMl6Dq2NV7FYnkCeVerAVfhGtmlMuxK+K+WeBPc877+W+Fm2wg+h1ghFEyWJfNZaSluL1iswoqw/u2Tv4nxKlyhC/RTVdfTXzorA2wnDW/WvApyBRpDOkmAQAfazSHH8efucWuj5iucxF83LCAo3Y7iF48GM5k/R2lpk3TEQXGZGeDwJq3q/ErHg0vM5nre/i1nasA8cMcUIPimRigGJV8G07BfZl+Xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKMM2M96bjur82uovdQnO9JYdUwZ8brAhS32zYO5mkw=;
 b=OxPlxzW7iFox2Yv8jp9OI6QcU29ESB67DLcskpG3PHOO7ByRwZnh2H+ZG/0pJcWBBv0m0BgcwWViLxYxwg+OY2wOtubIMb5Ed28i6PDk9S1sJrMcJoppo8ztID2n6BR11GCOMw2m7Q7NP/aj7YmUR6ZecoG3y2plLEoouBB6FEk42woyiOKnSeCH4o9ysq/EVmwJFuu7x9AznQAWRLOOPC0xHN4L7Cjogj22/j0p6puVNJ67vZ1blXKYcT0uNyGO+HwE6RVmlKw1bqiIoyey+KG6Egkjts3abQfE/QNeqXql63nzqldupWOEfxsdtVzJkCO+q0bi2k6T2leO+hrWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKMM2M96bjur82uovdQnO9JYdUwZ8brAhS32zYO5mkw=;
 b=fLKqPP23uFZEhhb/PRw2FEA6HNAD6uveyDl+prhdsdsvJH84ssKh7aZVJvRUUslyUVJcT7i7KJ3CazOLg82kR1y06N6wYXGf/oF1O0lsivEXXN5SNSMyCmwGg6bGhPx7rGM8K2qqiPw6gDuImt7gdxeVd/inpDVWwt5hWe5ueNk=
Received: from MW4PR03CA0245.namprd03.prod.outlook.com (2603:10b6:303:b4::10)
 by SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Tue, 23 May
 2023 23:26:29 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::ec) by MW4PR03CA0245.outlook.office365.com
 (2603:10b6:303:b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 23:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 23:26:29 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:26:28 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 19/23] cxl/pci: Update CXL error logging to use RAS register address
Date:   Tue, 23 May 2023 18:22:10 -0500
Message-ID: <20230523232214.55282-20-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523232214.55282-1-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|SN7PR12MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f98c121-765d-40a4-9bf5-08db5be5231a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTGydbdNqmjodR4t4jEbSvUzQc3ZJEKmbdHxhtUe36N0n0+2Glct3GkgAJjj/hU3hXGLUunLZiPsS763pT0PTc/Mx57W9fi7tpxzRohXrdu7ma+1OBbg2oTysSUOIdxZGarb5BS2VfGz6/kikS/hRMU91skp3OhcYKEXUwF13c3YqOYmvCqMmK9EULEYh8pQ16pCZWHw0XURNWYcU5FpUTPCfnCKrrNJqMmBEhByN6FqEVIBqOmg03Cw8ML9Snf8I2Q4kavIfTCR4Vy9s3918RvLnCwkjPNiLc++350n+ZLNG/JqJZ/Likl/8X+qYE0Za4CG6S+m1aiDprUe4rBsj3yU4k316if0Anuc/Mjtx2rGW9JzeqSMxNgzM3XiF0aXZusfICMWF/us5vCvkp5GxCC9bju3Qh2wtYsjb8kiFji5oejM/WW6CB4qQxr6y3T6SXgYr3KYUXjR9qtveuUKpZxIimE3+Bd5BCgmth+UfqKjTOgUU4wWWa5UjQQFTCk7JqtvkjVbp9LVA4CzQu9lWpCvQm7BgC99wK+/lmWEIuA5r3gJbrCNTscEXEf5OTfsZqkt+uXqSaKjdvsJ6QgOPiH3rKCPfVcJTC1+dUrB+CjB2hWm49ZCVxOuHtkeexXSwNkVYrk46cFd0BDFyl+MFQxUCQ41gR6Jw6/hpxdPTUY+zlQYxSXrX90hrs33QwLe2brJ7kPC+3sYSLAR6l398RFuzPLK1Bgz5kWsLS8Vtp7tnzc4XvIuu3hkdCL064xvazjTVInQV3Ui93+tfQEnHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(40460700003)(16526019)(81166007)(26005)(356005)(1076003)(186003)(7416002)(44832011)(15650500001)(2616005)(36860700001)(47076005)(36756003)(83380400001)(426003)(2906002)(336012)(40480700001)(41300700001)(7696005)(316002)(110136005)(6666004)(54906003)(82310400005)(478600001)(70586007)(70206006)(4326008)(86362001)(8936002)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:26:29.6235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f98c121-765d-40a4-9bf5-08db5be5231a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671
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
RAS register address. This will allow for adding support to log other CXL
component's RAS details in the future.

[1] CXL3.0 Table 8-22 CXL_Capability_ID Assignment

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
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

