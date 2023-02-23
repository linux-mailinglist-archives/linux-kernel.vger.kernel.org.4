Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0F66A1132
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjBWU1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBWU0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:26:52 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A6C5D45C;
        Thu, 23 Feb 2023 12:26:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqZrCeIL4rVRGiyAXCV5LQtVp+iugdmWWb1hI4gLISP0DKSSR75S974+b+VI2HKAI/Aipl5mccA3CbMlvHtr8gk+16+v4SX/1BFHnUeQHZ6VVCL9KKtHIxcn5C4H7sa/paACUon2qSdb/vGsSd5J3BTgrpnQx1NIbpHYY/KtbnrnTguH3HLYGGAuiGO8hWHr6D5Y412RRklYnu95B16M4VYIAJ6kuPQYIhpTzyBR9SNfUFSKobC2eZgVVfWerHhxa7ulqNPqiDUS5rtIM/ody5H3FYC3HxJdb+JYs3w/7Mg5wsPMlcOUdcFLucwQokQkAs67iIGSdVi5daPYZMbShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++Tx6XDo542TxPIx86HEKgSWB2TIKFDWJqXu686uuCw=;
 b=OkOVNFMJT7D2vOu1WH4/+ahs+UTzq+pXCHmeuwvpwLuiWPh53KMG9D/gGMJExpnQutmRw3Dc3lz0t8Cn0Ij2myGSB0Nyc1qjoz6No5yzqcN78tsa4KOiFviW9S4q86hpMgSSEtqWh4KmDKKMy4lZi+E2oKs1uCD2E6FQ7tOCsxjV7po7zWOseJaaLcRDkJzz2HcGqnYok46Ytr1Syuq8p3h5W9lxf5fw9b5XxAosnxbRCxVzJqax0Uk+XsVF7nOe0HPUu5mjCj6UEbp8ItggXtzGwzx8nDsWF1QDuatTz6AYbvKl6wICWBrkTkij7eqw52K3AH2t5LhPr4397s/3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++Tx6XDo542TxPIx86HEKgSWB2TIKFDWJqXu686uuCw=;
 b=Mi0pOpwOuBianAotsRk5JWfxdaev7ox90JkHl+2m51e9ps96VJo1EHxDmTi7b29A29FDQEUY6fPogETaWZuWMwbhZbj1aZ7IMJSwj8CZDsdv/iJ1L/3q/e+WwaOwylXz/1kIdZ6lFZsJ5ky63poxvAGwJxJCRYZRr037Fc7XN+s=
Received: from DM6PR07CA0087.namprd07.prod.outlook.com (2603:10b6:5:337::20)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 20:26:49 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::7a) by DM6PR07CA0087.outlook.office365.com
 (2603:10b6:5:337::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Thu, 23 Feb 2023 20:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.21 via Frontend Transport; Thu, 23 Feb 2023 20:26:49 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Feb
 2023 14:26:48 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anson.tsao@amd.com>, Kalle Valo <kvalo@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 1/1] ACPI: x86: Drop quirk for HP Elitebook
Date:   Thu, 23 Feb 2023 14:26:22 -0600
Message-ID: <20230223202622.9023-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230223202622.9023-1-mario.limonciello@amd.com>
References: <20230223202622.9023-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 87eaf565-426b-4590-783c-08db15dc4aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I85Svrj1hOYJs5tvhVuPgHCbiVKPWsWgWZtPdb83dvzevs2VqIkw0mKu5N/4jav896FXjwjfXcJK5c4V7TuvrRcZvhtIytqWRaYJyIeArHz7JNLByoq/R3asWstjxLwvxQBYUWaQXQDVQ5PcQ7mQ8XbwgGvPcwLn5+XGSnmlWh+0+fwKR3IK5MRRs/W3qATftAuAgfQIVIqPe4qY+NvWrGo2Xcz02DEf1qgy0yuTjsM5V59swgLMRVNo4UGh2/Gx3f+5zww9W5bIHqFC12I5IXcnOqSkOB3YTnn1pVkPlBnTKBz/ogtIzUFAVgToAdUTkEVf2kR2LygXKjrvprVd5yIKmWo1biStUs6U1x3yqiqLOLvO9Gnycw0ZiUhHTEzklQCyUsiRZZXTwsnejSX7IqycdGOVG/QtsLxz5kB3/Giuj6ReBAiQrUWBDDaJfNp4M4Dsrmqwf+OsWUkz/5tlkrN2HCxCL7ZuxR9fqoc8ybFx1HddCt/7fVxbGL0WIPT9qDga7WKu4FATIatlsU7PqVPzlkINdbKabuxZ1UqS/1+wMA17Ce7rLWNl76xaUHbA27gwfdRh3T+vlNbZjfHZQvXhjSqwXoWHwzlZgX0MTNNuRfHBTYlv39lmCJzBMEjm+Ih7KUiXn2QHi7rYT5FnLqCoYayC/P2fh2C6qlVCvErAmmBvmK2PJ1WwEIxxYOSbWjQ26PsY+U9S6AcsnMi5Tl2BkuzdDIiMR24fcvbOwMY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199018)(36840700001)(46966006)(40470700004)(81166007)(44832011)(5660300002)(36860700001)(41300700001)(8936002)(356005)(82310400005)(36756003)(86362001)(40480700001)(2906002)(82740400003)(26005)(426003)(966005)(2616005)(40460700003)(47076005)(478600001)(45080400002)(7696005)(336012)(186003)(16526019)(6666004)(1076003)(70586007)(70206006)(8676002)(54906003)(316002)(110136005)(4326008)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 20:26:49.2081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87eaf565-426b-4590-783c-08db15dc4aac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a quirk in `acpi/x86/s2idle.c` for an HP Elitebook G9
platforms to force AMD GUID codepath instead of Microsoft codepath.

This was due to a bug with WCN6855 WLAN firmware interaction with
the system.

This bug is fixed by WCN6855 firmware:
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Remove the quirk as it's no longer necessary with this firmware.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=c7a57ef688f7d99d8338a5d8edddc8836ff0e6de
Tested-by: Anson Tsao <anson.tsao@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index c7afce465a07..e499c60c4579 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -384,29 +384,6 @@ static const struct acpi_device_id amd_hid_ids[] = {
 	{}
 };
 
-static int lps0_prefer_amd(const struct dmi_system_id *id)
-{
-	pr_debug("Using AMD GUID w/ _REV 2.\n");
-	rev_id = 2;
-	return 0;
-}
-static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
-	{
-		/*
-		 * AMD Rembrandt based HP EliteBook 835/845/865 G9
-		 * Contains specialized AML in AMD/_REV 2 path to avoid
-		 * triggering a bug in Qualcomm WLAN firmware. This may be
-		 * removed in the future if that firmware is fixed.
-		 */
-		.callback = lps0_prefer_amd,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
-			DMI_MATCH(DMI_BOARD_NAME, "8990"),
-		},
-	},
-	{}
-};
-
 static int lps0_device_attach(struct acpi_device *adev,
 			      const struct acpi_device_id *not_used)
 {
@@ -586,7 +563,6 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 
 void __init acpi_s2idle_setup(void)
 {
-	dmi_check_system(s2idle_dmi_table);
 	acpi_scan_add_handler(&lps0_handler);
 	s2idle_set_ops(&acpi_s2idle_ops_lps0);
 }
-- 
2.34.1

