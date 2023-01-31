Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147B26823D4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjAaFY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjAaFYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:24:48 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1F3B3F9;
        Mon, 30 Jan 2023 21:24:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF1itaDT1tWJpMXtSngtoiHu0GkXjg/OmeglBQbd7uJzuLewaxCOzyfDNNEGlfdtnTA1NNadvR47Vk168QmpC804Cv5a+bTVG0k7e9wX8Uu9E+Sw2TQZ7jITSTmmkzBCW+MwwcK2+a/puuPMqLua83vMNltVCKHx6r3ydai3AUrVjBkg0PAvLX+uugxZ8+rzwYtyboCZkrMqFVbZIRxZABzCmaw+SAoqejYu4X74iiR8Voh6d9fHzzHZeSTPSPWd+SImsipXY+dsodzbWJqK2gbPaLItwN6kfqhrWLYYWqaCJ0/CBrFdfNDRODXnT2OtT3r5tXgBYuBZDTrB6W5wVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSCb9E7hlwVFlUz5E0Q0t2Sq3suv8GG6PLWOYj7pyfw=;
 b=lunItLAoj6khvCHnECJe6+1pgpEO10VtlhO4FJeQMcfLVJq368EU95r7HAlOSU9WLOx1YW7j2AYIKdJPO4ipUXBIh3ZF1r9TcAJWGZQIkIlO0lG2kCGeqGueEpIge0TRopm/C1HVjhs7NM1X0WmOT2mB8TP8eAqj1vj7bkdgIhlvrNsu5+vUgBs3D7cyMX0tSOVTLlmUGWQW0YgrGusH/Zd6yo66KF2WlVIw9005uX+XODfa4Yb5yf8iJptJMQde1ocIRGUyro+QBlR7DjZpUIW67ZFIBU8b6oT6cun/8iHX5yt+8YBec/yQK3qLjTedroJ2pEi1CvzVXMKtyyNHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSCb9E7hlwVFlUz5E0Q0t2Sq3suv8GG6PLWOYj7pyfw=;
 b=t2JSJhZh+hWKyxGalZFCc06LjpdQj66hSzp3Jg+MaDlf15YK5v5ISe98UzUi7sSOpz2gcj+D/0kUghCzdhSItgOJloA9cv9Q7zpvNWRbL1LzmPgx6YIyVDk82aPkRmNXwV2JJhfunw2/504IW/XNPqFDoJbbXJDRTF6fWifkpB4=
Received: from DM6PR21CA0018.namprd21.prod.outlook.com (2603:10b6:5:174::28)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 05:24:24 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::66) by DM6PR21CA0018.outlook.office365.com
 (2603:10b6:5:174::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.4 via Frontend
 Transport; Tue, 31 Jan 2023 05:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Tue, 31 Jan 2023 05:24:24 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 23:24:18 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Tor Vic <torvic9@mailbox.org>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 4/6] Documentation: amd_pstate: Move amd_pstate param to alphabetical order
Date:   Tue, 31 Jan 2023 05:21:39 +0000
Message-ID: <20230131052141.96475-5-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131052141.96475-1-wyes.karny@amd.com>
References: <20230131052141.96475-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 71010477-6942-45e4-3c7e-08db034b6a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4Eq8Fay4llq20Wtvq5XhJgAvasmjuaRU+smYZWJxwa4MJEW3hvstoGcmfKLxe6UY1J5taINs7GB6W3FhnGm1bx2HLMQRY11qg+A73qnsUvFucdrqnar1AngX3y5Hd0/3e8IRtIZWSpBaeBFbELYOUuCYHtwIf1CbMH4KohNH76W7eDyAB7w6CF/zLJvVdQbP0jY14K+lLt+9H4wFbBLPO8h+pvzWjW8AzuazRI+/7aZes3PynU3ov1PkPENZTCeOzDbriusnzQgEOdHkiqBkoHLPJblUH1OzOq+3nJhiXFZEFLRFlnMsyiLJnRmbn8H0EI37lEuJfLc3HcPWdVcqxKaYUM/5xYnp7goZBP6pIojA6/ZcRowHBCWsgceeFt6hNJMAkzfcEPEWLwwWdfUDV7Y8BYgp9ErdP2J+5MaD1uR+EszRaZeFMEGvBQ5egRRuCweKdQI9BVETWOsLyUkUPUgq7+0OeEemYh5YGiaBdmTOJZA3uVlRBakFbzhYBsUAKFSJxoYo+1g30i94BXJi7VEWbp/Q/eVoxDZPmeS1meDk0uG0Cr2Gx6tw1uqAAOVzkEN5wOcare52eDn5wBsd266O0CDYSK9xSB2kdxv3JlsH4iwW6OO9Cd3LrednAAQydALReMHp3RTQGvyuyJjdwWN3arJWgRkri/V2vYEcabh91PSlT/qqENW3JtJ06i9XMAV6wLGtQ+9EFNE9H+lcM88y48uTUMtZ1/yFe2GCy0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199018)(40470700004)(46966006)(36840700001)(47076005)(7696005)(8676002)(70206006)(4326008)(36860700001)(41300700001)(70586007)(8936002)(336012)(83380400001)(426003)(478600001)(86362001)(2906002)(316002)(6666004)(40480700001)(82740400003)(82310400005)(1076003)(81166007)(6636002)(5660300002)(16526019)(186003)(44832011)(356005)(26005)(7416002)(36756003)(110136005)(40460700003)(54906003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 05:24:24.2497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71010477-6942-45e4-3c7e-08db034b6a43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move amd_pstate command line param description to correct alphabetical
order.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../admin-guide/kernel-parameters.txt         | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0d8486325c9a..5f6a3a34251e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -339,6 +339,29 @@
 			             This mode requires kvm-amd.avic=1.
 			             (Default when IOMMU HW support is present.)
 
+	amd_pstate=	[X86]
+			disable
+			  Do not enable amd_pstate as the default
+			  scaling driver for the supported processors
+			passive
+			  Use amd_pstate with passive mode as a scaling driver.
+			  In this mode autonomous selection is disabled.
+			  Driver requests a desired performance level and platform
+			  tires to match the same performance level (if it is
+			  satisfied by guaranteed performance level).
+			active
+			  Use amd_pstate_epp driver instance as the scaling driver,
+			  driver provides a hint to the hardware if software wants
+			  to bias toward performance (0x0) or energy efficiency (0xff)
+			  to the CPPC firmware. then CPPC power algorithm will
+			  calculate the runtime workload and adjust the realtime cores
+			  frequency.
+			guided
+			  Activate guided autonomous mode. Driver requests minimum and
+			  maximum performance level and the platform autonomously
+			  selects a performance level in this range and appropriate
+			  to the current workload.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
@@ -7009,26 +7032,3 @@
 				memory, and other data can't be written using
 				xmon commands.
 			off	xmon is disabled.
-
-	amd_pstate=	[X86]
-			disable
-			  Do not enable amd_pstate as the default
-			  scaling driver for the supported processors
-			passive
-			  Use amd_pstate with passive mode as a scaling driver.
-			  In this mode autonomous selection is disabled.
-			  Driver requests a desired performance level and platform
-			  tires to match the same performance level (if it is
-			  satisfied by guaranteed performance level).
-			active
-			  Use amd_pstate_epp driver instance as the scaling driver,
-			  driver provides a hint to the hardware if software wants
-			  to bias toward performance (0x0) or energy efficiency (0xff)
-			  to the CPPC firmware. then CPPC power algorithm will
-			  calculate the runtime workload and adjust the realtime cores
-			  frequency.
-			guided
-			  Activate guided autonomous mode. Driver requests minimum and
-			  maximum performance level and the platform autonomously
-			  selects a performance level in this range and appropriate
-			  to the current workload.
-- 
2.34.1

