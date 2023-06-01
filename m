Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747FC71F6A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjFAXaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjFAX3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:29:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7B4F2;
        Thu,  1 Jun 2023 16:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpH+uCrjOsMVZWQ5wRNmxSlrwXEIopQjemwbYSH9iKEjXuXUu22PVFKYMV7Rlb9yTyxCAOky8jqJXskOjeXu+PIM3xe5dzm/QCkDaOupOcxSItq7xnl+Bbb+ZzeixKkuTk++mzHH0bcPmFEKbax7N0KZqYsZaafNmks9qwzo6Ac/BURijFomiWIuDLUwKfDCdDRI+m/Fx+UqNKf2DzDj3qn8w2pWDHBTgDDbfgn7L06OykR+Us8f88G0YQ4wJ3the8n1JSCd1OaCvgMEKGqTbu5wuol9v+GNPYJvUF1OkW1win98is6jUblBaSwHvloWJG1XsWF2ynNaWNdUnmfJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIGYex2gmnwg9s/SxVexBqG3eOxNY8IcDlv1varSqJM=;
 b=krnV1rYHVR5k/N/STagDDcCvmLVO8RDJNfC4RM/62S+RlVKrR4bODPBIX9q0ol70weCv4soYvQC345wkEJIKE3YD81A1TTjfuuEd1wYvVhhtMkDmx6No8opE3PPQOCmnXTSrpcqKKyoMeapmwCMJLf7pKl4Z/Aht8H2Nh0h8Pf/fVY3ExtDemZr31/rZJlx7noRcxgv6ZTrS++M5s3x4OoPwOZLHWwv6pvjYNyEMMhZhtfdOEtaw/24PYeaXblmtdkxYDYn6ROIWxF2gLOkRxalAUk8pm4m20jjZ3Nxj0Dni92sx+cy5N5HOgYCzsqe1oyKWMCTorgstX3+DihCzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIGYex2gmnwg9s/SxVexBqG3eOxNY8IcDlv1varSqJM=;
 b=DsMnM2OIyWoklNeF8vIqFes2IqstMCSg3zBnR3NbMJ0y50m/LpAuP+KJ1UGcz696gFzqlJCh/dU4vv43Uz3Bmn7ucn2qr+5+WebKVQwfg6bCuBDjBUBcrgWdMLELzL2iRrX+dHNZKOn6oTgfET/xCDiytW2EKSd5txBhTnoa8/Y=
Received: from DM6PR21CA0017.namprd21.prod.outlook.com (2603:10b6:5:174::27)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Thu, 1 Jun
 2023 23:29:42 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::c1) by DM6PR21CA0017.outlook.office365.com
 (2603:10b6:5:174::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.9 via Frontend
 Transport; Thu, 1 Jun 2023 23:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 23:29:42 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 18:29:41 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rafael Wysocki <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 2/4] ACPI: x86: Add pm_debug_messages for LPS0 _DSM state tracking
Date:   Thu, 1 Jun 2023 18:29:21 -0500
Message-ID: <20230601232923.1248-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601232923.1248-1-mario.limonciello@amd.com>
References: <20230601232923.1248-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 43636962-3cae-4cfc-11fa-08db62f813d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jVo+aK7RPjTAGF4SpCX9Nd5F6z6o2p3wasZ0JCgyU0nUcPK0oiSekaDfYVfFi03cuUka6MgK4fpsurYAPgev1q+M9hHJJO6XVs73xSpuL7NR8c7n7mNdSuZLhL+Y3OD4iU0s3Esv+DyHcfa97BeY8h7XOYc5Fy4XNiiWX2VyFFOst6ldEzoRH+c/ml1/YD1hhBBc58SF9Kdz72eghKIRrqKo3BmlrPPU2VdZTuYwaRnXtu36fnDYAHtABIIWgCxd9Utac1Ex7n0JWsGTT34pEhti7mwj/s5lXVoFQOdpyHSXbMjv67V6AGKlMGe3dQo/kTV708OIKDZqN3oPMYtPZEKiGHSiOVkb87CGk4KPeMH5DFcQ7zu3CRsyDdlqeb2Gcfq0uMjbYlky1mnjQp7M5zOJpBChEApEahp6YJsuv8g/G3yHkvE0Z9ILswmLUxxKNnR/tHDXYVyZGMLk9c6xgG/7wA8QaLBt0xhMNl3fazWzfO4fXPOam2DKJR+i5m50GzqJzlK3KH3caa+8GnPyihHsyogey/5kGBozTPqnxeKDbb2y+ActNRv7/hh2k5JeUpH1ZRbRBqAU0cW6dmgLfwpKEe81JxGPNgR+pJAXipQ5C4usG5jjpavAJRymQY/nb+oSCPgdcbumlhoWqB4Lv50aipId59pwzptIKl9smKvo/B05LkW9KK/9j02Vgnb2RBQBazrhd3WxvbVzu2La2tB2BIild1gyplfVGRu57Pjxd8N4CJGXqWl6ke33mXtQLX4LgErO5HjDZe2t7ra+NA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(356005)(82740400003)(8676002)(8936002)(2906002)(16526019)(41300700001)(86362001)(82310400005)(81166007)(7696005)(186003)(2616005)(316002)(110136005)(54906003)(1076003)(26005)(478600001)(6666004)(336012)(426003)(83380400001)(5660300002)(36756003)(4326008)(47076005)(45080400002)(70206006)(70586007)(40460700003)(44832011)(36860700001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 23:29:42.6614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43636962-3cae-4cfc-11fa-08db62f813d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling debugging messages for the state requires turning on dynamic
debugging for the file. To make it more accessible, use
`pm_debug_messages` and clearer strings for what is happening.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 52 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index e499c60c4579..7681f6ecab67 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -59,6 +59,7 @@ static int lps0_dsm_func_mask;
 
 static guid_t lps0_dsm_guid_microsoft;
 static int lps0_dsm_func_mask_microsoft;
+static int lps0_dsm_state;
 
 /* Device constraint entry structure */
 struct lpi_device_info {
@@ -320,6 +321,44 @@ static void lpi_check_constraints(void)
 	}
 }
 
+static bool acpi_s2idle_vendor_amd(void)
+{
+	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
+}
+
+static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
+{
+	if (lps0_dsm_func_mask_microsoft || !acpi_s2idle_vendor_amd()) {
+		switch (state) {
+		case ACPI_LPS0_SCREEN_OFF:
+			return "screen off";
+		case ACPI_LPS0_SCREEN_ON:
+			return "screen on";
+		case ACPI_LPS0_ENTRY:
+			return "lps0 entry";
+		case ACPI_LPS0_EXIT:
+			return "lps0 exit";
+		case ACPI_LPS0_MS_ENTRY:
+			return "lps0 ms entry";
+		case ACPI_LPS0_MS_EXIT:
+			return "lps0 ms exit";
+		}
+	} else {
+		switch (state) {
+		case ACPI_LPS0_SCREEN_ON_AMD:
+			return "screen on";
+		case ACPI_LPS0_SCREEN_OFF_AMD:
+			return "screen off";
+		case ACPI_LPS0_ENTRY_AMD:
+			return "lps0 entry";
+		case ACPI_LPS0_EXIT_AMD:
+			return "lps0 exit";
+		}
+	}
+
+	return "unknown";
+}
+
 static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, guid_t dsm_guid)
 {
 	union acpi_object *out_obj;
@@ -331,14 +370,15 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, g
 					rev_id, func, NULL);
 	ACPI_FREE(out_obj);
 
-	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
-			  func, out_obj ? "successful" : "failed");
+	lps0_dsm_state = func;
+	if (pm_debug_messages_on) {
+		acpi_handle_info(lps0_device_handle,
+				"%s transitioned to state %s\n",
+				 out_obj ? "Successfully" : "Failed to",
+				 acpi_sleep_dsm_state_to_str(lps0_dsm_state));
+	}
 }
 
-static bool acpi_s2idle_vendor_amd(void)
-{
-	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
-}
 
 static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *dsm_guid)
 {
-- 
2.34.1

