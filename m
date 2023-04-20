Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517506E993B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjDTQJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjDTQJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:09:42 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C2F1FE3;
        Thu, 20 Apr 2023 09:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK5JT7I0gzQtbl1doPVqw06JOx2vfvc1JB8WmZ3UQUtow+XEDw0TcmRdGL9zaknOY/aO9R9xAXW6krgbhIPC2nCexB+sCZgqMJeSAnVBmnXxKXJtaz9JZYricnccuQbMBuKQh9ZKawp9vwyS5e5ijdka8aqEilRuDCV1mYqBxVyLOpRDVJ2eB1GtERpINui25myuuVakKW1UNmdw+HEkJ6vxrl5WjhCV2CkGMe6FIhbLz0UPo2BsbBRvLpTHwFrHl8xB3Jkyy1P200EwLyUF+hr+YBX1Hf/nuG1nErCHvcp65uABYROtqZrteTT0wQ+XCbDEyPomQHMoRomaZ65pRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTXgIaNngcAwMOszYsNX76rLqGFHrwP2kk7EkBlSVEU=;
 b=MNTdRL4rJhwpTEBwxTRukov4IZUNUq+h8Trm56QGt8D+a1nJRXAlRUO73z/rRmnHx9wwtfgfwW4t+RIvudlkb0X/GslSdlOygVp0UyzX7mxd+tGIcBzyvIz4ztTNKPs3b13gCyWwcFMcwklowWDr+ih9BjaDdx/z+0QvQXc1qHvkR5ZjoDxERZGL4Pg7+1xZ9Q0XhPEWpj2RDn+cH2jiyOKM9kdE/V3cnuEG6cApuBA4cZ0Od3LHvlSe0ylksgyPyST7uOGe2j5C2QoqZYTUAzvnuCtoL7jKXBLpEkyVQNXgtVKqcw8g0I9f9sAtbI2JcVqEGGao12Z7jkO1dFwmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTXgIaNngcAwMOszYsNX76rLqGFHrwP2kk7EkBlSVEU=;
 b=ENCWfFBcikZflK1ze0QGyk7Sf0q5jJnEbGN8PQTGtBqxQpjLkizEzhyM5fkJHK91YJLbwnaUieR9dHL7OqKAkw/g1MDRuxowZXlamZC3YYdKOaOzzKsoQ/R724U/153+ZGNHAEP5zFgpz3LkywqafMjoN6Xbkp0odKiy6V1oofY=
Received: from MW4PR04CA0345.namprd04.prod.outlook.com (2603:10b6:303:8a::20)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Thu, 20 Apr
 2023 16:09:38 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::61) by MW4PR04CA0345.outlook.office365.com
 (2603:10b6:303:8a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.23 via Frontend
 Transport; Thu, 20 Apr 2023 16:09:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 16:09:38 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 11:09:36 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH] ACPI: x86: Separate out the Microsoft _DSM function calls
Date:   Thu, 20 Apr 2023 11:09:23 -0500
Message-ID: <20230420160923.14127-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: ec947bcf-fc6a-417e-879a-08db41b9a445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pxM2e8JlF4ZSZqyJCghBaCfYTxgQQcLH04ICwegbP5Ofg7NyKVnuODqVnzgmIIhFCiUtK3zx5H0CjM/i4G2tk2riKLFab2g9pyq6tnYw7cSH26BjKvtG+/wevAMyKOtJtpsuIpBkU/EGYX1zuKsj3bQOgfeh+2NRM2u0FK88KbunJXI34KmpYSnO/q25IsW8euxDSntiI30+fFepnP1bT9mdLboSPfAKagRGlEGa+pX6+3OwCVx0+PeWaZrSlXlPiMw62rXVjUeOQaqeDp71o0SY0ETINY9w0OT0pWA9LWkKq9+gVEBw9ZOIyDIYh/Hd9dwOc8MMt9iv9eiEEtl8JLoJX2hGDAFkpNseS1NiNPwqhbEx835yyWV3Ux3Vp++dUCv4GL5b8/gP7pFU/6z98/Yr1QT0FBXlONF7QNggVheetung4/5mOUOUQce2Z7skrh1c1DMzbGQrMmh8dxnd9UhrzagAlHbdHSEpTrFt18n85DUwCRURtXWqBC2aiVilpEQpAhsVFlpc58PN0aRBGMw7woPqfg+z2IT/Tmg2pXMpxuP49g5n3EiZ1giVKX3qiAvn4wcqIH+Jnn5pM/Kyzxzvo84ajB0lp/NGJZTO459Zt+ruw036qs6AcBFsDuP4l/mRV1kwO22FCgZZMpbOK8m2+ClsWPhxX7gvvYFp4Hm+0DhIO1VxEzDoEUShx0jM9X1eov6Bd41wYgJfa3ibNr1RNeQX1jE2/a3l93NefI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(47530400004)(451199021)(40470700004)(46966006)(36840700001)(36756003)(186003)(70586007)(4326008)(110136005)(54906003)(316002)(70206006)(45080400002)(478600001)(7696005)(6666004)(8936002)(82310400005)(8676002)(5660300002)(41300700001)(44832011)(82740400003)(356005)(86362001)(40480700001)(2906002)(81166007)(336012)(52230400001)(426003)(2616005)(36860700001)(26005)(1076003)(16526019)(40460700003)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 16:09:38.2426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec947bcf-fc6a-417e-879a-08db41b9a445
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When utilizing the Microsoft _DSM there are six calls which correspond
to the following states:

1) Idle (Screen on)
2) Idle (Screen off)
3) Low Power
4) Modern Standby

Currently Linux compresses these and treats this as two states:

1) Awake
2) s2idle

That is when the system has woken from s2idle from a pure ACPI event
the _DSM state is still Modern Standby at this time, and so some
firmware will not run other code that communicates with the EC.

To fix this, track the active state in the s2idle code and ensure that
"Modern Standby enter" is called after the ACPI SCI has been processed
from `acpi_s2idle_wake` and every time that the system is woken up call
"Modern Standby exit".

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 85 +++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index e499c60c4579..1772d981c5e9 100644
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
+		};
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
@@ -331,13 +370,13 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, g
 					rev_id, func, NULL);
 	ACPI_FREE(out_obj);
 
-	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
-			  func, out_obj ? "successful" : "failed");
-}
-
-static bool acpi_s2idle_vendor_amd(void)
-{
-	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
+	lps0_dsm_state = func;
+	if (pm_debug_messages_on) {
+		acpi_handle_info(lps0_device_handle,
+				"%s transitioned to state %s\n",
+				 out_obj ? "Successfully" : "Failed to",
+				 acpi_sleep_dsm_state_to_str(lps0_dsm_state));
+	}
 }
 
 static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *dsm_guid)
@@ -487,9 +526,6 @@ int acpi_s2idle_prepare_late(void)
 	if (lps0_dsm_func_mask_microsoft > 0) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-		/* modern standby entry */
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 	}
 
 	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
@@ -513,6 +549,28 @@ void acpi_s2idle_check(void)
 	}
 }
 
+bool lps0_s2idle_wake(void)
+{
+	if (!lps0_device_handle || sleep_no_lps0)
+		goto out;
+
+	/* avoid running on the first go through the s2idle loop */
+	if (lps0_dsm_func_mask_microsoft > 0) {
+		int target;
+
+		if (lps0_dsm_state == ACPI_LPS0_ENTRY ||
+		    lps0_dsm_state == ACPI_LPS0_MS_EXIT)
+			target = ACPI_LPS0_MS_ENTRY;
+		else
+			target = ACPI_LPS0_MS_EXIT;
+		acpi_sleep_run_lps0_dsm(target,
+					lps0_dsm_func_mask_microsoft,
+					lps0_dsm_guid_microsoft);
+	}
+out:
+	return acpi_s2idle_wake();
+}
+
 void acpi_s2idle_restore_early(void)
 {
 	struct acpi_s2idle_dev_ops *handler;
@@ -524,11 +582,6 @@ void acpi_s2idle_restore_early(void)
 		if (handler->restore)
 			handler->restore();
 
-	/* Modern standby exit */
-	if (lps0_dsm_func_mask_microsoft > 0)
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-
 	/* LPS0 exit */
 	if (lps0_dsm_func_mask > 0)
 		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
@@ -555,7 +608,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.prepare = acpi_s2idle_prepare,
 	.prepare_late = acpi_s2idle_prepare_late,
 	.check = acpi_s2idle_check,
-	.wake = acpi_s2idle_wake,
+	.wake = lps0_s2idle_wake,
 	.restore_early = acpi_s2idle_restore_early,
 	.restore = acpi_s2idle_restore,
 	.end = acpi_s2idle_end,

base-commit: 7124d7671af0facf115d70f9d1fadde0d768d325
-- 
2.34.1

