Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5C0701838
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjEMQnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjEMQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 12:43:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319882D6D;
        Sat, 13 May 2023 09:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehc8Mdond8cNfH7DigX2HwKjKz/FGOHw8UPFQ+JNMCUWUL0DAFT1N8K4l3Rz8+wKQt3i1aTQy4aiauIMfxTHu31QfAoBOHBxEwP8d+49LW82OgZshruYFHdWWvRzt7cA4rHwRg88I7z6EuxOLh2YRS//QJapLJWDSYgzYdmeGxgssuFgS/BvqLGmSF5HGUZ0dLQ66vH2rtQCMBWU7EseRAv+tjGJHrD1VDMSMaUsPEvNljWQ5fI/Lvx+3SCS/KZyQJHDEWrR3XI9Tv3zeuV4qXQlbZdlOJ+2FIVbiXS9K/X8FmZhH69QPBH/Z6oMM9G9iXc0lGumKpkgEPRwi+AV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=048Ndm2tGTmLXOkAczJRzbwBpe4O6AicNYoyr+Mr6Y4=;
 b=me2b3vTN0OfyOQF813PV5k5bGVfwCEDEb6PegMlEdokyNPJaovlCbrRr1CXkoFYikHMiHHaqa0+XT7UHEG34VQRsX69IaLnCFKhyy4DCq5zcKzIdSE3rUGu5j04mmTpclm730TV85j/YWHMdm9v5M4IXRz1BPcNScjO9f5PzKwn6Bth/C7g5ro/WFX1AzaLWX2d1Qnbr2mh1afYd8jDZywWYslxVCn/BJ1hO4lvIKnV2yHQaP29oDOUgIy7QT3mwn9OAqZ3rV86ddA4KMrcybK0itFL6+vOU8EvbIoMEeVUHl/LrdcpCigvK2P9As+kG/1v2AnKV/jltP/w7mc/1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=048Ndm2tGTmLXOkAczJRzbwBpe4O6AicNYoyr+Mr6Y4=;
 b=eA4Zb2r/l/r7ik7ZS+IIJO10DgWv+rdrgeyUpURUH7Oif8Jx90ai+7R9vo7+Rt4PMKmox/hh/4rx0JHJGC+JefhESBTVU7TpOh+i4Dzjihd6SD3zQouwTXH09s+N1zBDsJrwuSXR56o5v6mt0Y+0dTQQFiByHzkUN1xMj2yk9aY=
Received: from DM6PR06CA0041.namprd06.prod.outlook.com (2603:10b6:5:54::18) by
 PH0PR12MB8151.namprd12.prod.outlook.com (2603:10b6:510:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.27; Sat, 13 May
 2023 16:43:48 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::fa) by DM6PR06CA0041.outlook.office365.com
 (2603:10b6:5:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29 via Frontend
 Transport; Sat, 13 May 2023 16:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Sat, 13 May 2023 16:43:47 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 13 May
 2023 11:43:46 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] platform/x86/amd/pmf: Fix CnQF and auto-mode after resume
Date:   Fri, 12 May 2023 20:14:08 -0500
Message-ID: <20230513011408.958-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ba1f08-4745-4b69-82ab-08db53d13926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98XUno7+RHwLbrR3tVA4wPvz9VizN7aQdR0e51LLtjbPqkxSLWvSLpWKO9TFMUcYjKdzwfx1rqhXRyiSckcXeTa7SDVc4qU33pwsdLhOct5EhRK7UejcKFMyH1Dmw5zEMDk8hop1zC+RF61cVepGJA2fTZa3bhisS2HSqg9mdS3Qq2KOSsvx5m9nkpz/82xLsBtQkdZ3woMa4c8JrKHdX0EPLsCqcKYoRQNBqIBG2PYnV8mQSlKOFxTloVJDV3OYBHdfJQVnyGwihf7X2ttKfGI/eDqf2L7lXK5tBXLCS27WC9B57mz43IjleCXd4LlKROMFZQjawvBl2nmTCO+Za0iVnZP8JPpOvBxbblNQLVbKgfE88DKlcf4jKGFdxpR2FoC5Nh/8g2JtUAwyNaVJyZWhdQPqTGpV+kECKYuIZaYXbCg/55+Xd35NL3b07HkwkpiTEbmJu+CmPaLS2SGUBe5P+zoMdyS74BzupdX430bsVGoYDY9RBj/L8/1JlbwnJlDhO8A7hwzpTGIpFI0ADexH3rmdDGv83gDsxC2zxhPtTij/UzBbi0ypDvgFNVTVf1TDbwFJd63nwhctN0PcqeVEYXe8T95X/B6+ys/pWDy6cjpMzU8iXSFfFSt0Bum2JHSjZ7Gs9nuVk2Z7ZWWgTTe5nxOzzrkvvYHRy04lS4cd7yPaWnAzbymnPxNbdWM/65QGHdqdUpGwYmt7qG13ZBDOv7oddv6M3mPu1dQNKKgxoLJ0ODLQbSTHHJocdbptPEZGhj2gqtR7XqVbbu7Fcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(86362001)(36756003)(316002)(110136005)(54906003)(70206006)(70586007)(4326008)(7696005)(478600001)(6666004)(8676002)(82310400005)(41300700001)(40480700001)(5660300002)(8936002)(2906002)(44832011)(356005)(82740400003)(81166007)(16526019)(186003)(2616005)(26005)(1076003)(36860700001)(336012)(426003)(83380400001)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 16:43:47.4527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ba1f08-4745-4b69-82ab-08db53d13926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After suspend/resume cycle there is an error message and auto-mode
or CnQF stops working.

[ 5741.447511] amd-pmf AMDI0100:00: SMU cmd failed. err: 0xff
[ 5741.447523] amd-pmf AMDI0100:00: AMD_PMF_REGISTER_RESPONSE:ff
[ 5741.447527] amd-pmf AMDI0100:00: AMD_PMF_REGISTER_ARGUMENT:7
[ 5741.447531] amd-pmf AMDI0100:00: AMD_PMF_REGISTER_MESSAGE:16
[ 5741.447540] amd-pmf AMDI0100:00: [AUTO_MODE] avg power: 0 mW mode: QUIET

This is because the DRAM address used for accessing metrics table
needs to be refreshed after a suspend resume cycle. Add a resume
callback to reset this again.

Fixes: 1a409b35c995 ("platform/x86/amd/pmf: Get performance metrics from PMFW")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmf/core.c | 32 ++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index d5bb775dadcf..ee5f124f78b6 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -245,24 +245,29 @@ static const struct pci_device_id pmf_pci_ids[] = {
 	{ }
 };
 
-int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev)
+static void amd_pmf_set_dram_addr(struct amd_pmf_dev *dev)
 {
 	u64 phys_addr;
 	u32 hi, low;
 
-	INIT_DELAYED_WORK(&dev->work_buffer, amd_pmf_get_metrics);
+	phys_addr = virt_to_phys(dev->buf);
+	hi = phys_addr >> 32;
+	low = phys_addr & GENMASK(31, 0);
+
+	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_HIGH, 0, hi, NULL);
+	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_LOW, 0, low, NULL);
+}
 
+int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev)
+{
 	/* Get Metrics Table Address */
 	dev->buf = kzalloc(sizeof(dev->m_table), GFP_KERNEL);
 	if (!dev->buf)
 		return -ENOMEM;
 
-	phys_addr = virt_to_phys(dev->buf);
-	hi = phys_addr >> 32;
-	low = phys_addr & GENMASK(31, 0);
+	INIT_DELAYED_WORK(&dev->work_buffer, amd_pmf_get_metrics);
 
-	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_HIGH, 0, hi, NULL);
-	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_LOW, 0, low, NULL);
+	amd_pmf_set_dram_addr(dev);
 
 	/*
 	 * Start collecting the metrics data after a small delay
@@ -273,6 +278,18 @@ int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev)
 	return 0;
 }
 
+static int amd_pmf_resume_handler(struct device *dev)
+{
+	struct amd_pmf_dev *pdev = dev_get_drvdata(dev);
+
+	if (pdev->buf)
+		amd_pmf_set_dram_addr(pdev);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(amd_pmf_pm, NULL, amd_pmf_resume_handler);
+
 static void amd_pmf_init_features(struct amd_pmf_dev *dev)
 {
 	int ret;
@@ -413,6 +430,7 @@ static struct platform_driver amd_pmf_driver = {
 		.name = "amd-pmf",
 		.acpi_match_table = amd_pmf_acpi_ids,
 		.dev_groups = amd_pmf_driver_groups,
+		.pm = pm_sleep_ptr(&amd_pmf_pm),
 	},
 	.probe = amd_pmf_probe,
 	.remove_new = amd_pmf_remove,
-- 
2.34.1

