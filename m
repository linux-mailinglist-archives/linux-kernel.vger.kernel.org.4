Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E667086DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjERR2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjERR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:28:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A101BF;
        Thu, 18 May 2023 10:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nt1bZWEQvNx+JjdFATPYz2QRz025zZR/o5BiAOZfnE5EmE1XpxQFiGtTGH298rnQtrWi6+AK1rOhYPNuIc9223ADbJPP4peHfG5SbjZMqgOaVwEK1YBCDev6RZkBGub2WIP+l9LGDrT5iwkUgcG3Wh5/mHM8OHkiGVvlQCr7k7aPhS2usBhgOpVDNZAFKtF5CjZ3bcZeY80qbwoU1Gu28funZ9Ck/8l0evF0gtISVbTxR774Srlb24JLBOHcl2aY4tXQRVt3UbQAPPphWtgkuoNZfItqGoPJcU7lL+yH+UqLc3si4ei1uZBe60ad2vzznbSE3P7tscY0aP2HWkHvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHSKk++w/2Ftufz4szWBCDoHpwAuc4YNMEZJMvN5vZ4=;
 b=PFQ7zPGKimGpAT9wjxdpbkoYJCKGuqnlVjjwSyEy6SK7gGj/1VezHkxO5eWEsdcSx8L1fwvAag+Fql2rXcHBSptGP3gG+TjwjVH/sI+zxNUh1EXQjbzlOcR3KHKZSBg/4e9HlK3eBNZWq160K/GD/JSTOrsDDMd4CG60dHIXWXa9q5pcWJvBMh33YHJwXNs4aUzLT4S4HuVXHyszXpq1/oLXxzhK14JW+T1iwqGgdFRtabHNRUfefV+U/+JigxgzcnR10uV5UHJdwk89B3fAzuNodabLacIAkq2DYqdfbwDY/XgEZMt4G+g9DWZQVvgJ406nPM1doktXPk7uhul4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHSKk++w/2Ftufz4szWBCDoHpwAuc4YNMEZJMvN5vZ4=;
 b=Wo061sksYY495BwaXHPqPJAs2HdqvhojrxCJVtGtMYlowT8Rqwnv4MsE4FPe2wCpGilFHVmiDGRHmCQ98yi3HZfSTtnaOQkWqwTPWOdC44FIDQL+b8TiMteJm3ZmeB5szzawTU7DcgzOUclZCrPIIk5mMM8n0lwJEKq0CKLb34Y=
Received: from MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 17:28:39 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::e) by MW4PR03CA0022.outlook.office365.com
 (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Thu, 18 May 2023 17:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Thu, 18 May 2023 17:28:39 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 12:28:36 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Shyam-sundar.S-k@amd.com>, <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/4] ACPI: x86: Add pm_debug_messages for LPS0 _DSM state tracking
Date:   Thu, 18 May 2023 12:27:50 -0500
Message-ID: <20230518172752.93322-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518172752.93322-1-mario.limonciello@amd.com>
References: <20230518172752.93322-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 282b8681-343b-46c3-235e-08db57c5519d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIw/Y70QexdbCxOqDtgifPi8nV+Uo1BB9vTBsq/EeORVq3gENST+cCuWD4ga2MBgoZOYVJqS/VhCyliaoO2z1JoXlB3IW+KXMvM4hfCzStNAXrEf/8RoSVPLU697K1rjJFS92pOXfw5RIxW2W7J+GZQ2g+61NJEd1FqQn25o7U7zhz6DFlbEXodNphTcBGhdxfbi/msFTy8H1FTUWIFtRKEfDSQHaLXhgeMU7rDARIA75RTkX4U79buWRFOSrkDA2u4QWvFmQwTREx2keLo4Spbb3DTYfHpIjcpUX/3aZndGFi0xoho4qymqt6SAZsZresCeAxiDcP1cnC9idt5hp/2x2KSJIfHazEuYnjv9JXSxDjGNBlJEoaVch9mjjCY0eVogccb9ja6ezKXah1rYoXcnJ5aykMvHapUsVOORTVCSq5AjQSmaGkkInyRJNxFa5oP7WxH48L9uwrMec7XBZm9cHN7nVSOn4Cn85/3etq5gUBiOK1x36S/LxRF2AB06i8vu4TK4WjJt8eLQXbB4B5KlkcCDzXbiZ7nmamhi5X74XQY21jLVcN43heb7iCbBAeWGMHwGviSKbAkkmrwxegq+vON9c0YuHnObpB85ia/U65wpP0+e4gwwGr+QigOoyfpo3iBYgXAiSqy65yW2nFf298ztPj0j7I/4qfB4Dq/ckqnB9jMqprZo4rSmB2d6qy6QDzZASM5Ldo1zaRxrUv7eb/X3ds1MqO1fmFTt0IYXKRija+dBTjFS8cf10nkOEB4qYs/3lrz8H3lqEFXEJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(8936002)(45080400002)(70586007)(70206006)(4326008)(316002)(86362001)(8676002)(2906002)(110136005)(478600001)(54906003)(7696005)(41300700001)(44832011)(5660300002)(6666004)(40460700003)(26005)(1076003)(356005)(16526019)(82740400003)(186003)(36756003)(36860700001)(40480700001)(2616005)(83380400001)(47076005)(336012)(426003)(82310400005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 17:28:39.1077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 282b8681-343b-46c3-235e-08db57c5519d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
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
index e499c60c4579..94f4f31ff1ce 100644
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

