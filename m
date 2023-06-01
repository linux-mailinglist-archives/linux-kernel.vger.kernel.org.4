Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB68871F6A3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjFAXaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjFAX3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:29:50 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560CCF2;
        Thu,  1 Jun 2023 16:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luHQpck6Emh/JtA6vkjzzwoZyYI1pQizy7/1Se/dWHMbdi4d1ENHDFvmVk/9h0C+dqVj3vkWVw/4SAm4eQiD8F8HDwJz8lyN9mNxJaafKXhwGdzaphyQwsulsVAdpwLFzBoDICr/r3I28y6gi5iwjvJLtsgglcu66nbtS7D2BWEcuY2A+3NcAejcnhjibOVJ4iqsR9CrWTjvSVwdzqm+cR5ozIGDGf7ROVxEaNgxhCrzoMl6KfSZjzAzkA894i8VW02vV50HVeSMWOm2eNKkePetmeJPDe+PSp1Yp1v3FoFwCMhG88GdvOfHI/oOyn2fbzE5EwwnOEIt6wvIguFyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrHATCoFhmN6yg/azbKKFkcA0h9V7q/tjG0BF8LbZ5Q=;
 b=j/qNntrcnl4R7RxbqsmigFjvKKaRvp8/7hL+kRKnyy90kThNHE6pWstJBXqwm3PTCMO/UHnDnBDGA5IkrMNuklllbL1buHeZ4v2HfXjmy/cmlI6q2P7bs5Wjdq3a+airKBajqvsMWK1UGZecNl/+xKosfJuOSTYpgMgkJvHYE1Evjd6JPfvAzU6b3ssy1ngIGyW4BUAtfkCPydvR/3UVBRtDmhdJqi2Jr1te2J16FHX0GlEmfK7i8HrPIyk0stqHYRzrJN2l44pOu5+ooMUfkH6kO1zoTWTQDpK1Tp16jON8qnk5rsiR1XRQ/uuWDZwnAJeoVzWqg5TYt7Py182kpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrHATCoFhmN6yg/azbKKFkcA0h9V7q/tjG0BF8LbZ5Q=;
 b=XZGcsTcjgIS6mVtNGkHNL3EAMHcWOlGdIxmiYhAc162vqgGEry47FIY+FbDrzR1hbN2qf9Wtis4jXU6TxOGJo20gfHeF4yrqnLJ88z19E4U9NUw8c4P6621f6BdQ2359PcYUMdPCcgsv2EqTI5qTA/ezXMnado4fRTlCPgIFSD4=
Received: from DM6PR21CA0005.namprd21.prod.outlook.com (2603:10b6:5:174::15)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 23:29:44 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::14) by DM6PR21CA0005.outlook.office365.com
 (2603:10b6:5:174::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.9 via Frontend
 Transport; Thu, 1 Jun 2023 23:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 23:29:43 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 18:29:42 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rafael Wysocki <rafael@kernel.org>, <hdegoede@redhat.com>,
        <linus.walleij@linaro.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 4/4] platform/x86/amd: pmc: Use pm_pr_dbg() for suspend related messages
Date:   Thu, 1 Jun 2023 18:29:23 -0500
Message-ID: <20230601232923.1248-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: caffb3d7-43cf-4025-038c-08db62f81490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fa1/CyFJGEav/EEXKkEqhLs5D4Y/KTG/TfqWQTC/yxiiPA1iw05FOHT0FbdbitRNgkzWpEg0VVasERLBGWmc6nwdRoMTNWX4FRSwf/EKSScfis3ge9dHptqvHcY1pesnoIDEUucgGtscggUz7m6ml4VpyFcFAtmC+pcaN9adwAKJ4AeWfmYTIC3U3V3sEyCtLNEORm9eBZeKONst48F8jn1yR/QLrqcpxrZjX9xUOdEYxc5bzg/Ua4wP2E4eHqyHbmxzvVcK6HKUT21yayQbK0nAGc4RyZNklKhH4AmaImAaUnXL5J6jxy4Laq5AaahF2385Qx4qfyXFnHhD1n7tu2oPxgacn7o8XWSxudoNTa0adD/ZPlPLSep+E1TT0mF0s154QDY4udR6+abLPhKJUNSs58qU4Rn7kK49t3vwEZcsR9YRdWvOj0dQ59Xql5wCo0M0avB7HyfgTEmoyFBdxg0bPKhgBOu8lNhi7bATQ449TO8xOgcMeL4YzwP1aTjTaGwupNbkVV47kksLn/mUtDdRy8wkfgLY1GQloyBm7gL0zDrYiv/lTTL15oDMzb34E56F28mynDjYGDxZT4ucxZGxAqzf7B0FMFPrwuugux0EDkTEJ/Z4ZuGABj0FtV6U1l7UHGElYGc6n4k4mehnyWd4F8ygwL5+sNJwFbVc8/qErjABpL0rTPLOSPQCiWb1Ekv4zXvb9PHKkeOXDFjiqV3qqgfQ8p0B7Vacm2bqlfShampY4MCYDfx5oZuxtJuiV8VGA4C24hB3vkKRnPteOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(7696005)(6666004)(36860700001)(86362001)(426003)(36756003)(336012)(83380400001)(2616005)(47076005)(82310400005)(356005)(81166007)(1076003)(40480700001)(82740400003)(26005)(186003)(16526019)(15650500001)(70586007)(2906002)(70206006)(4326008)(54906003)(110136005)(8936002)(8676002)(44832011)(5660300002)(41300700001)(478600001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 23:29:43.8669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caffb3d7-43cf-4025-038c-08db62f81490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using pm_pr_dbg() allows users to toggle `/sys/power/pm_debug_messages`
as a single knob to turn on messages that amd-pmc can emit to aid in
any s2idle debugging.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 427905714f79..1304cd6f13f6 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -543,7 +543,7 @@ static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
 	}
 
 	if (dev)
-		dev_dbg(pdev->dev, "SMU idlemask s0i3: 0x%x\n", val);
+		pm_pr_dbg("SMU idlemask s0i3: 0x%x\n", val);
 
 	if (s)
 		seq_printf(s, "SMU idlemask : 0x%x\n", val);
@@ -769,7 +769,7 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 
 	*arg |= (duration << 16);
 	rc = rtc_alarm_irq_enable(rtc_device, 0);
-	dev_dbg(pdev->dev, "wakeup timer programmed for %lld seconds\n", duration);
+	pm_pr_dbg("wakeup timer programmed for %lld seconds\n", duration);
 
 	return rc;
 }
-- 
2.34.1

