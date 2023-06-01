Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C5771F6BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjFAXk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFAXkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:40:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2BB1B3;
        Thu,  1 Jun 2023 16:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8wa/9y9k5HyBo3eKb+ClH4IGyBlhf9hm1PPEsursZx89O6BE1NXDsHlGUTVXNTv9r/kkR8Fz9QukvXtTSmSbJux7wildJiigEue+L6UZ/BvQOULwCfL5034PQJC3mOtzRWLP6VAJZHxJFNNZA+tn4sO5Hwz5xG6C+Roe27U31rHNCR2b+m0cj/n9BZ/Lb7sIyULhHCWFlOvJydrFaNrQ835eSM8MB0oHuhG3X2TP5eTraea+ZlKQZMnoCF8BTEb95k9ft7H4pOlzseIHyAWKb7Khju1/iB0p++f585cJ4qS+ZEH/cMfX/zuyhK2fWoYtheAtFP41m0gmZ40kgNKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FlQmuYUXs4W4RNEKDPKPg0S0yah4Z/azBlIl+Lsesk=;
 b=nL9CitPlccr2oAnCmw5u8k/poIzL9dUCg6LXpMSrkHkYLSFj5iXvPCoe1Qa5QKNBYWngHr67OgdIYKUALNKGtRsYhzkjT1euoFrLVj6PNQbuT6ZJtxPvwQSkYJkgvGnOb/DdatxrJNLsjEHdKQ+0PKUuVeTohFjMgKLwbBdqn8jnjYzEmJs2yvFov7As5igxoI9CwnB0QuNyIJkhtffg+2Wt2WpVB2urPI3TsgPmaxBva4YmfDoekf0J6LUb6guz/M03gHPFzB5ibxczpXPyxeK41nE3iA30icnGcfh72zjQSniC9fQ9xMkI+Y0yFYGjezi0NL4NF6i9OVkZqBJuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FlQmuYUXs4W4RNEKDPKPg0S0yah4Z/azBlIl+Lsesk=;
 b=IQvvpsYAzFWEdWBs9Z/TUYztUTVfWpaR2cSDTPngHJCBKtym05vteAI6JGRwAqDfUin1N1oEybly/tturuxu6GPkX9r2cU8N8EH2+wkrOL1DpqnoCMEe4RdjznlQzKL2oSRNFreSDyUqbcmX2Z6f6RaOZoyTne+i6HkI7vpEz5k=
Received: from MW4P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::31)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Thu, 1 Jun
 2023 23:40:11 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::35) by MW4P221CA0026.outlook.office365.com
 (2603:10b6:303:8b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 23:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 23:40:10 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 18:40:09 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] ACPI: x86: Adjust Microsoft LPS0 _DSM handling sequence
Date:   Thu, 1 Jun 2023 18:39:53 -0500
Message-ID: <20230601233953.1332-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9df38c-c0af-4c03-23e6-08db62f98a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKLMJo9M6yUthMkD82scFRL3pmijReuaf0Y1qKoZxdRqI0u1vcSSRLy5R7PO2p4UQ+FJS7E0XHXETEYA5hlW3eNuX7UyFHIHQVlonBzAcAh+egpdU1NMEQYG/D2ipQ/3A0TWwzYJnlJZNLr656ZBeQvyiZOC3TvoJEfTnWbLFfwljAuxw1eC/94VorOmcOv7fErlSAJMAhbUEnt4VNiIHJrLCm5EZ/8WYOdSthfuTBiDn1FJFn66WB5wXOyyxndxIx6dlwV8/iI6N0aHXaYqvq3J3Ky9JiJNUqMvmKLpVEUIR/3DaAQl6V0M77OjZUuBT7YkNuQsb/5Nvo2SEd4/VUD8w3yVEv3w2FxngkAHi5QI/oYXiFuUGNcoX/rBFj/z0KkH7pWY8CvEH8UvTIfW1BCYh+nbSEqaaMZvCj+v94QAMW5Mnyvkym9bj8Ba5P3e+bX6Lvg5skC1WVYXgGjLc3Y+FeLpRzBe+49Pq0l2z11RqUwmfRls90NTNJaCc1+gSeZvSIICMz3ACTBSp45LK+0yHvgUA5pNvpbCSKVPWUJQjVXV6i1fk8muCEvkYTC+9xLr9phykahhou0Q0NbZ4uR12NUviUMgK3exFPbcS+pl4H+HqHpxr+Y7uysajnB7W/T5fdLiG4fMMA1SDNSK1ImDVqt2ox8i8yheoRlnDSr/UArQMJmudJchBr/MlPfP9/1VCKG2+dZ5MkF/LUUhJRJGKt5s/4vVL9O7FKKhgIP41vVbzupzzu9beWAfXBZx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(47530400004)(451199021)(46966006)(36840700001)(40470700004)(356005)(82310400005)(81166007)(82740400003)(40460700003)(86362001)(54906003)(478600001)(6916009)(70206006)(70586007)(45080400002)(36756003)(40480700001)(7696005)(6666004)(966005)(4326008)(16526019)(186003)(1076003)(26005)(2906002)(316002)(5660300002)(8676002)(44832011)(8936002)(2616005)(36860700001)(47076005)(52230400001)(41300700001)(83380400001)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 23:40:10.7292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9df38c-c0af-4c03-23e6-08db62f98a3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URI_TRY_3LD autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Windows the Microsoft _DSM doesn't call functions 3->5->7 for suspend
and 8->6->4 for resume like Linux currently does.

Rather it calls 3->7->5 for suspend and 6->8->4 for resume.
Align this calling order for Linux as well.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-states
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index e499c60c4579..7214197c15a0 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -485,11 +485,11 @@ int acpi_s2idle_prepare_late(void)
 					ACPI_LPS0_ENTRY,
 					lps0_dsm_func_mask, lps0_dsm_guid);
 	if (lps0_dsm_func_mask_microsoft > 0) {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
-				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 		/* modern standby entry */
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 	}
 
 	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
@@ -524,11 +524,6 @@ void acpi_s2idle_restore_early(void)
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
@@ -539,6 +534,11 @@ void acpi_s2idle_restore_early(void)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 
+	/* Modern standby exit */
+	if (lps0_dsm_func_mask_microsoft > 0)
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+
 	/* Screen on */
 	if (lps0_dsm_func_mask_microsoft > 0)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
-- 
2.34.1

