Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B636A6F07
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCAPIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCAPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:08:50 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9019A168B4;
        Wed,  1 Mar 2023 07:08:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j60C2TstxA7fxw3V0BZhXNxTQkR/9Fy4JMg0GegRHrLKFtVKEYqDVz6+y40/92V1cIfsL6SCvdU1lmyggTxi+6Ynqs1VaFOeNdmqtrQ3SuzB+yib9mRYDIgGcZM2bNivb4COthEL9VoCMmbJAGmDLN2q35a+WwD2k/Re/bAfDQkGHsJYg0kE88PfnZmcBzBxBDXnnxruwPXotlGUDxyGoJHBs0Llork7sPpUuQRSWko8gk+LzAMoR+S1xz2A+BMDFYXe+ZRkq+KofXTHq52qNP6br0+k0nhAMxXDO3zM7tE2+Ce+rx3BVSEh+7AblvXaljDcZ19rzT0xN32DkjgQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyChYzAj1PU+zDXFWwfVAQfDJ4ydpKYXFktNc3AgHLQ=;
 b=VwGKX6iSp98czzObjtslWRuaOWSAu44DhjnOmod3HrR9HvneimW+jU/FqW0VI3MUW9WaUxujfR9SNTJY2DiUEJHuy+acmizDDunikH9DRc/gD4AVkBE7UIFKM5CQbRHHKAT6xlt+ZwaiTuGC/GIrIWtzvOcFPDPqhhBS6cybwfD/c3XHnvo9Gx9wKMIKQ3sI6gMFL/3ky/zKEhbqjPItBOcNCdIwlfHovaFIvkXfwNerrx3n9LCsDx9s4m7ETIzfO4p9t7i8cUleL3lBuIiNW/SmkIcru8WP6gAOdQ0tQRXk06xUyR6IGbGBiTasxzTpFSk7LW8gWJz38zpwwZ5nXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyChYzAj1PU+zDXFWwfVAQfDJ4ydpKYXFktNc3AgHLQ=;
 b=a7zdXqQ0wJ047EBXQwuRimbKDCc0FYsYRhonVqKbYJFL5pZkkySf7LFaHFYqsiZkQA+4gtybA6FNTCS4xATc/Q5R4Ry2obaFyu+iy0l34zMM9YQFVp6aUOtzEGVvr7Xlg6p8uMnMV7shbO1jTO0rRi8tZakR1xrW2UKXrTFJ4EI=
Received: from BN9PR03CA0064.namprd03.prod.outlook.com (2603:10b6:408:fc::9)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Wed, 1 Mar
 2023 15:08:43 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::7e) by BN9PR03CA0064.outlook.office365.com
 (2603:10b6:408:fc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Wed, 1 Mar 2023 15:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 15:08:43 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 09:08:42 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for checking minimum SMU version
Date:   Wed, 1 Mar 2023 09:08:19 -0600
Message-ID: <20230301150821.9791-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f717cc-e8fd-4a06-c4d3-08db1a66d941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 263gbtQdiciq831UUANV8Df1/w6fknQ6F/j4hLUJjsfIUX7ez9MIt0ocTFQAskY+/XlrcfdgWkoTtPQRLCU4uky/HZSA/l0J/Q0mJhaajJcF0dWr2hwAR2ML0pG3hhrloL38snampxfXn42QfgAlwHyw5P9LLS24tsovxL/y75ZEhaSbI8O22yFjSDQAziRpJuS/JFRBR08AM1EJayWnLxDuzb/9CQbiRE1WJ1sme+7XHExadgJiuIornanaoTR3OOdU0KIdhFGJqX6Vj86A244VSeDaBmd2hP1HyQaejrW0KcE2ntH6bgkwMfGAfx8TxbX24mR2odHuT07JfYLoNHjja7rcwNIsHbqciSOqFJgPcZJQDWvZJ+CoB20Z5yFYkK/q9lZ5yVjrJquaGEstMDPKfAyV7w46twYgs9IUzgFDl8v6uTX9cx4xVxds749aDg194+x3LS75Lhpx91k0Il5STk3s65znviy58BExrfVDEf3OAi93kCJEN+9BFWTO5WOepbanKyuFUGYwE0kAJahKXDd6851cXRirAlCv0+YAvRX/TATRiVMlEfkSG6HngK8NoEV7nWhdnB/yyTFia3p8BQFn8sT3mZ0HNSL976C9I6mpxxxb4Kx9xk21piJXyp3wjxaqrkFWXODSa+lzaRHyHhfeSSADKMcihGtTBZwOTOyY92lJjiUv2uaiQ7uawIQAb/N2sLGS0c7eujtJZe+KfPYh9+eWvBP4m4XOcxE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(36860700001)(40460700003)(16526019)(186003)(82740400003)(83380400001)(2906002)(81166007)(356005)(41300700001)(4326008)(8936002)(6862004)(8676002)(426003)(47076005)(44832011)(70586007)(5660300002)(6666004)(70206006)(7696005)(40480700001)(336012)(26005)(478600001)(1076003)(2616005)(316002)(6636002)(82310400005)(86362001)(36756003)(54906003)(37006003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 15:08:43.6540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f717cc-e8fd-4a06-c4d3-08db1a66d941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a few locations there is some boilerplate code for checking
minimum SMU version.  Switch this to a helper for this check.

No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 49 +++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 2edaae04a691..c42fa47381c3 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -418,6 +418,22 @@ static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
 	return 0;
 }
 
+static bool amd_pmc_verify_min_version(struct amd_pmc_dev *pdev, int major, int minor)
+{
+	if (!pdev->major) {
+		int rc = amd_pmc_get_smu_version(pdev);
+
+		if (rc) {
+			dev_warn(pdev->dev, "failed to read SMU version: %d\n", rc);
+			return false;
+		}
+	}
+	if (pdev->major > major)
+		return true;
+
+	return pdev->major == major && pdev->minor >= minor;
+}
+
 static ssize_t smu_fw_version_show(struct device *d, struct device_attribute *attr,
 				   char *buf)
 {
@@ -526,14 +542,7 @@ static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
 	struct amd_pmc_dev *dev = s->private;
 	int rc;
 
-	/* we haven't yet read SMU version */
-	if (!dev->major) {
-		rc = amd_pmc_get_smu_version(dev);
-		if (rc)
-			return rc;
-	}
-
-	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
+	if (amd_pmc_verify_min_version(dev, 55, 37)) {
 		rc = amd_pmc_idlemask_read(dev, NULL, s);
 		if (rc)
 			return rc;
@@ -686,15 +695,8 @@ static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
 static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
 {
 	struct device *d;
-	int rc;
 
-	if (!pdev->major) {
-		rc = amd_pmc_get_smu_version(pdev);
-		if (rc)
-			return rc;
-	}
-
-	if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
+	if (amd_pmc_verify_min_version(pdev, 64, 66))
 		return 0;
 
 	d = bus_find_device_by_name(&serio_bus, NULL, "serio0");
@@ -718,14 +720,10 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 	struct rtc_time tm;
 	int rc;
 
-	/* we haven't yet read SMU version */
-	if (!pdev->major) {
-		rc = amd_pmc_get_smu_version(pdev);
-		if (rc)
-			return rc;
-	}
+	if (disable_workarounds)
+		return 0;
 
-	if (pdev->major < 64 || (pdev->major == 64 && pdev->minor < 53))
+	if (!amd_pmc_verify_min_version(pdev, 64, 53))
 		return 0;
 
 	rtc_device = rtc_class_open("rtc0");
@@ -772,13 +770,14 @@ static void amd_pmc_s2idle_prepare(void)
 	/* Reset and Start SMU logging - to monitor the s0i3 stats */
 	amd_pmc_setup_smu_logging(pdev);
 
-	/* Activate CZN specific platform bug workarounds */
-	if (pdev->cpu_id == AMD_CPU_ID_CZN && !disable_workarounds) {
+	switch (pdev->cpu_id) {
+	case AMD_CPU_ID_CZN:
 		rc = amd_pmc_verify_czn_rtc(pdev, &arg);
 		if (rc) {
 			dev_err(pdev->dev, "failed to set RTC: %d\n", rc);
 			return;
 		}
+		break;
 	}
 
 	msg = amd_pmc_get_os_hint(pdev);
-- 
2.34.1

