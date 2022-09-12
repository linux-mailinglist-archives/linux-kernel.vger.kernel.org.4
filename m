Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B097D5B5909
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiILLLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiILLKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:10:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D69B1D32B;
        Mon, 12 Sep 2022 04:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeaxmZe3/K/hOW7sN3ifx+JXfUp2soDrgFx2BvFkIZzaNHFK6LiyjGdHYUoHDF6nntrbGWhZFmpJ2kJr3YrEHQiyO8rLilS5v3/ZcD9gCPlBYZFp3EyRYspsV0da3xptgcFiPKr+sbjaDg5bTiZvuBtwkvIgPzIqLq+k/psxy1nmLU8By1cz9Wjkiw+UuZpG6j86AE97tds/sO1HiuVSVoHbkFRPMIzmCfOrVpqIbWjFJwmzhOsp1urQrXzOmhHJToWJUtEb7GkThnEUBVRODMCL1FPrlIBzwVzdcOabzSt7o+3I236QucRZ6Rq3Bav+NeCiE6hcnSEm6HbHhE4YIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWa2vPEzLh2kW88xuxtm5UIn1QcLwPlHoEh4R0Osqz4=;
 b=XMZhHStFhMhdvmn4T1xiIH68pN0NPmJ8Z+qAnEF0ONYkNx+bEIOKKRCNbcy+kHcxzvQo33NKw6O9KqMbC468vfqtpUwgcItogk9wMjDBA5iMwveIc+r6D6o46biKA5d9vrRl/xUITWJPiP4Ymc78XJvHeOYvYOYkNNBJDP/I5dx0YCrVS8NUXpR0fSLFHAzlU0hlS0cvUXfrO7VcisK5Pvlz9semgDrF4zAOdrug3wcsdhiBx+vREqHCe4IjcPqtuF5H5+Zt4Zu0fZmBiq2InyHlPhH1bUZ3UuW+60XQKxn3wS/9bO3LntoUQI53usy2JlBJXPKjh1Cb/2Tyo5F+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWa2vPEzLh2kW88xuxtm5UIn1QcLwPlHoEh4R0Osqz4=;
 b=woBpAZWgheMpfe4adLnlAiApKzpzY26N39Q6Wpum0ZcmBNv+PwjRpqwf47LU+MRjKT2BUVUDaqvdhowZ3fl2a6qwO3zbFhfKScwVtIocDmluZ+xzBgjd7+sxDvKZgm97Or0J7GiZBfZDQGNOZvbosRkY2lowhPa2fB8T29MZ210=
Received: from MN2PR10CA0006.namprd10.prod.outlook.com (2603:10b6:208:120::19)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Mon, 12 Sep
 2022 11:10:49 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:208:120:cafe::65) by MN2PR10CA0006.outlook.office365.com
 (2603:10b6:208:120::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Mon, 12 Sep 2022 11:10:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Mon, 12 Sep 2022 11:10:49 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 06:10:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 04:10:40 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 12 Sep 2022 06:10:37 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <michal.simek@amd.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <siva.durga.prasad.paladugu@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 1/2] usb: dwc3: xilinx: add power management ops support
Date:   Mon, 12 Sep 2022 16:40:16 +0530
Message-ID: <20220912111017.901321-2-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912111017.901321-1-piyush.mehta@amd.com>
References: <20220912111017.901321-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8b103b-ff2f-4afe-b748-08da94af72f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYVreg7ZAuYb4YQRMGYWsc06l1wnuOeVqdCv2a7DYH2EUBLqjw38holhnUKHsPIRW0LqpOS71cBdbgFUUiXpxtAYIj8WYDMnXd01rY04EQgo3ZPkH0n/cFrzkfYZ9+mdz5geiq/CMsI9+vokPb9bWo+ItIg1ol8UR7DAWOt+xsW2ylXoyOqpwioEfkyFybRwYF5cGtvVV8zfVoMffduJGDn2YXvkvftdfQ0G9h09spS+jLEFwFlP5am6G7B94FaF35eA2CLouG0IPGdAzQrbJNClTCMnHkQVin6b1/D+B7oIkOJuBoOXVJBpQ8C5TN/fFpmM/RupON83pSh2Zk0Dw1ip7V1M26qq/0sorChR1JdE58OhYzBmS2E+evnGy9kbiWATgYTLKLc1h3CF7h783HT9xPUZjDFCJv9t3uJdUH6MgQkB99CFpMjDOatBXPp0ulOssGYbt74iaJ++4FHCRMQVXQUw/KWgqyRgicG9OtQQf8/ONAqhZPgCAOCknwwN3opCoNkkQUlhX8cV7AmAkq7EZ1gMzQC24u86F89jVu3DO05H0om9M65u2NulhRAV5oMyb1FzNZ5eP4lB5y4BChPF68CbEI2EtrJ/Ms5BNPspvwyH9rWlTD7iulWJyYHLQLAkDQPmfwzdVMHZ+ZXj8kQ1RUF6KucQ1IZfz6RYX4I4xbzbm2j4EfsKPey0QcsQ1RpKs70AYW+7E/rGPHp3LkT1PQ4MlL2JdNa0b0Mo3JREyPQ/8+P23s3j47QTJ7ndCsfn7LEZ9EkIAkDgSTRAP7+4HO7YfZGF9DQxurNMNAhjlSebeHQcbxQnWYItl4EVm1pTSBPs6t434RTJiKbPjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(40470700004)(478600001)(41300700001)(356005)(6666004)(54906003)(40460700003)(81166007)(86362001)(40480700001)(110136005)(316002)(26005)(336012)(186003)(1076003)(426003)(36756003)(82740400003)(82310400005)(2616005)(83380400001)(36860700001)(47076005)(5660300002)(8936002)(44832011)(8676002)(70206006)(4326008)(70586007)(2906002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 11:10:49.4549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8b103b-ff2f-4afe-b748-08da94af72f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added system sleep and run-time power management ops support for
dwc3-xilinx glue layer and update function name.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 67b237c7a76a..a0d0280a045e 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -322,7 +322,7 @@ static int dwc3_xlnx_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused dwc3_xlnx_suspend_common(struct device *dev)
+static int __maybe_unused dwc3_xlnx_runtime_suspend(struct device *dev)
 {
 	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
 
@@ -331,7 +331,7 @@ static int __maybe_unused dwc3_xlnx_suspend_common(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused dwc3_xlnx_resume_common(struct device *dev)
+static int __maybe_unused dwc3_xlnx_runtime_resume(struct device *dev)
 {
 	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
 
@@ -346,8 +346,33 @@ static int __maybe_unused dwc3_xlnx_runtime_idle(struct device *dev)
 	return 0;
 }
 
-static UNIVERSAL_DEV_PM_OPS(dwc3_xlnx_dev_pm_ops, dwc3_xlnx_suspend_common,
-			    dwc3_xlnx_resume_common, dwc3_xlnx_runtime_idle);
+static int __maybe_unused dwc3_xlnx_suspend(struct device *dev)
+{
+	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
+
+	/* Disable the clocks */
+	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
+
+	return 0;
+}
+
+static int __maybe_unused dwc3_xlnx_resume(struct device *dev)
+{
+	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct dev_pm_ops dwc3_xlnx_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_xlnx_suspend, dwc3_xlnx_resume)
+	SET_RUNTIME_PM_OPS(dwc3_xlnx_runtime_suspend,
+			   dwc3_xlnx_runtime_resume, dwc3_xlnx_runtime_idle)
+};
 
 static struct platform_driver dwc3_xlnx_driver = {
 	.probe		= dwc3_xlnx_probe,
-- 
2.25.1

