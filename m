Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE777209E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjFBTdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjFBTc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:32:57 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFE7198;
        Fri,  2 Jun 2023 12:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhJyb9gPtVOQafF0vbT+mH1Xiy3yBHQOVxs/ETlWPRr0dgdipjfZ6M19Mf75QyONtx6u9kiJlCJ6rOKe7G2vJindjlc62r0QcRc+bjTt+lBSkw52HK34sZ03sD1RaaGDoQxgNnkkZJ3NW3S3GreG5qMgUN2uY+xP4H31dd1AxB/jzuvgtEoYVHAryAW00TGXlpYx5Fy0sOhpvYuWpFX8eF+phNwzWFIp38WXxa0fYUs2QnULxmSWVpojNRa0k3TeRRxInYNlMb2r3lLbDfhXG77r0iecXLzerc0Z1+4PyoxxLW9csXxqd3a5UQX0/qPslFLClaw2tk9C56IL5EM8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIGYex2gmnwg9s/SxVexBqG3eOxNY8IcDlv1varSqJM=;
 b=lCMchnAJE8OmzvoT1472mtg0Te4YCB3z8xOMJ10bkmv4q+2/Cnftn1uxINEXiwOn52wsXNeriIOy/481nu5up20RjJOVfjDVKHyanFgNxsuWZSTFh4aBllA1nSU91AQkz8oLlBz2Z0SF4vbeTryL9DTJwIxWw2XRBjoSFqgU0U4Q8krrc/yT+XRwZ4AUtgfLGwRQYYDBA5wwxxEssXXOzpLOYfVgUfhnJ8P7C1kUL9qjBK10bJ3Vw2ykr7Lt4quPzV0DvaASbYCuZ8F8p63533py0Iqn2iZVN1+3Z1EHBuMut147NQWN0eV3ctQj6xLLAvg/YLgIVRSBH2CT/itBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIGYex2gmnwg9s/SxVexBqG3eOxNY8IcDlv1varSqJM=;
 b=0JHACOrErqNxZmu22Y/CJO+SpnpfXeff6naSd64KeXtNVV0XxvRhMZG1WOLzqidglmfZgXXplSYYMedO0BKfx8u0aaWOx++DNdNN2BT6kBg28Fv5R62IdYdiydEG6NTmUeIPgHqxeohOWPVB+IGwmljUNM8LzDaJuGbkdu7MtSw=
Received: from MW4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:303:16d::21)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 19:32:54 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::8d) by MW4PR02CA0001.outlook.office365.com
 (2603:10b6:303:16d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 19:32:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 19:32:52 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 14:32:50 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rafael Wysocki <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 2/4] ACPI: x86: Add pm_debug_messages for LPS0 _DSM state tracking
Date:   Fri, 2 Jun 2023 02:30:23 -0500
Message-ID: <20230602073025.22884-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602073025.22884-1-mario.limonciello@amd.com>
References: <20230602073025.22884-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 8942d042-21e6-4bc7-1f89-08db63a0286e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zq2pulCN3UNFQ+AfttmfJDrBiUaibh+ALtxIWsOa1jyWt8GuWshk1x+BvXslqH5HL0vSAKUY/9kfITkVh6a11oRgy0I2Vss9klsr8+GZEemoqbwAp8MxXba34SR+TIMWQWpFiagjACALySxw21q7UIzLaPeZeePnjnJuv+oa2qaDhNSTnPvz4wTIa44UeS6IhUVpC9Ix9b5nbY2GIm7PXi6tnOsQm+kvqoIZafSib8omfCNLU7vvk58N+PRAY1RTRnHlHmuxqvkdCXMMdjjVK875DR0qbT39qkOVMLqSvw9xmU0it7zOSTF3sZdsdTC+V0x9cGSDy8PurpiByCMH9l1/5mqa1fr4J4MMI0OY31uVuN/ri3ecjVbkSHQ8Pa9cQFB+ViUZWBr/zvOdgCW3fCuXW2uGQvyNC+epTs5nqEMQIC8fMKd3iOrQL53JK/lP1wns4zgdvwcFFHKoUr/62yRdSrcmEQ/6oOBpHwK3XInKIuXulh88HCB1Qzp6JKirDXJO8MeDRskFhYSB0aWjYmJAeDPchfLOSD92VDrN2hpnZfsdBI51w1KgngP+7LNnAgOlNOebnAEvzfKD9xhX3MAxC8YytkFf3j03BtGns7Bnc4K7DY3eUW3F6OrncOC722z4POLVFFbgFf85cckfn4SGoO0FQ2OtGcQkuBJWOQ2etnUZpkYg0UFlDoXrmSI3XmEgjLQuGrc9CQdt4G8Lpqty5khZBurrQg1AA+hLkKAgAbQmM5MtspzrnQzPhj7ECq4twFvB1TXBy8a/ATv2Bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(45080400002)(478600001)(70586007)(7696005)(40460700003)(70206006)(4326008)(6666004)(36756003)(54906003)(316002)(86362001)(110136005)(26005)(83380400001)(40480700001)(336012)(1076003)(16526019)(2616005)(186003)(81166007)(426003)(356005)(82740400003)(5660300002)(41300700001)(2906002)(8936002)(8676002)(44832011)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 19:32:52.1342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8942d042-21e6-4bc7-1f89-08db63a0286e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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

