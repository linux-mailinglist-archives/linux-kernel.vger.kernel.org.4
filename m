Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4C67377B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjASLxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjASLxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:53:23 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFC169233;
        Thu, 19 Jan 2023 03:53:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLavcqkf4xKVln22w0q5PPx2APTKw0sbuu90XpZdiFJdLzEX/E8nCyLQk4F0Rv+wZrvv5gcd+aFJlSqS31D78Rqw7W2thyRo0Yxp55c0fPAJsnU0k0CjG698ynLKZubSo25JIZTmMOScko8zjeEIb61raOjF9F4wFtkO5dyPmr0xwm5rKa4Y/MjHn7xx6oyc4x5P/V4hJfONR9WzlPRvg0WWdVxX/Ih8Y+NWL+PnTxrrBXKKww/qnhqNpHosUccYHWov/YgCP5yIDPvaDOEFyZfaeE1k27yc9ElGKKutR3r5gdrd9qmNxT38O30u3Iz+tJevE++nXnlI41vhUnzm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSCb9E7hlwVFlUz5E0Q0t2Sq3suv8GG6PLWOYj7pyfw=;
 b=Ynf8GHvb3MBfFXFDbCMzwvUYHcIZnDusj5cTNMHSZLFUu8OyesjdSllNk2K6KDYZ4Pcgh6TXWNK/y/u+x+lRp5tvhRhE/jFu9mb+kuJSKulzcwxJEjvHv8Rfmh8V82dt801jWBC2uLa1QlkTZvYVVwxCv7l79Re218EWTX3QKwEL2EYGmiFk0WpIeuFp4xMyuX5/ngNmvunFnQ/J00xc2c3E6RRgd685hIe+r2+j30oETqKb2HWxCj5LXqkS2ADuYgkpMguQ9eMT+tyb8pD6YxivjrNXXHhabyo4MD3rkFvSe0awZfSJUoMIv9knxxhTacTcmYMu4E7EDAmFaD5ZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSCb9E7hlwVFlUz5E0Q0t2Sq3suv8GG6PLWOYj7pyfw=;
 b=aDP4KhLQqPl7eIPctZzNg9msYqF7adX/pLBVcXDBenGvSByvIAdqVR9OzYtbb1TX+28zqEQEICtRV6n5A+5f9O3jEB+8Ji8V5+tuQHKWezt4C6hMI3QUoZ/0lcbvgzaXTihrhFmGjgtsMOvIufkyCL+i8N5R22P4xTaz0SBk3Go=
Received: from DS7PR06CA0007.namprd06.prod.outlook.com (2603:10b6:8:2a::25) by
 SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 11:53:05 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::bf) by DS7PR06CA0007.outlook.office365.com
 (2603:10b6:8:2a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26 via Frontend
 Transport; Thu, 19 Jan 2023 11:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 19 Jan 2023 11:53:05 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 05:52:59 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@suse.de>, Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 4/6] Documentation: amd_pstate: Move amd_pstate param to alphabetical order
Date:   Thu, 19 Jan 2023 11:50:15 +0000
Message-ID: <20230119115017.10188-5-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119115017.10188-1-wyes.karny@amd.com>
References: <20230119115017.10188-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc8ad86-81f1-4fdf-68be-08dafa13b9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Td4LXZlssfxy76raut38FMI+1GmPObV455NuVPjXhn9AtoZWlM3uXpdkqk3rX8ZaQPp5WvnKpw0vKXsV0lmQv3+WFrX2PBxu5TmNZCskiBllCz9a/aU1mqgjbirK4gfjOM2XiizGNCqmOFdDWTRT+vFixZL5JLtnru/nhrCHKXZNaXf6zn1VqIwdpcILCog7RKW9yTkkML1xiHaN6GI2uCdobXWO8+m8TlWvSkt8ogym9ijqZD4E2HM6Ke9EYkJaaAB+1ffF4ilSUMw1W83nhmIiBsKFLutp4c6oJ7pdC9UWrNa36R/F9F/jEzih6XaZ2HnGK+f4nK4GlPZlRF/m6YRc0cZuDNaF52k3UCqa5wX3ZSNLl4kXNLX4BiTaTb2EBG8UZvYTKLOnU3kWf9lnNqq7TvDTopOKbJcBPjXbGIa1YHjDqXwSJSSX0IJMHCH0rxsnRUG6mpqAriHfOoSRpW2JSFN5JNqRG3Zx9mU0hFiFknRpfizq8pWrSxbW4Qh2WF0rD6HoZqpC8+zLMMlTxg8ZnPXbSqfPuLPvIVcG9nCtlUCkwbvPvwlw7bHUXFdwFKZTdV3Y/2b2pdhq2OzQlEBETIzVQVgatEi3e/3F0cEKXs2XvZ/weF4cW3iAiixHtl5dH9Yr8J+DpsYwTxHsGeREhSKI2K6Zp1tZcWqiQErJePvvgrT4S7G9VKqwLpGriIge0olUW2Hb3j3nbouLHXkDiilnq/GltU4MZxbSNzE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(36756003)(426003)(47076005)(8676002)(41300700001)(70586007)(70206006)(7416002)(44832011)(8936002)(26005)(478600001)(16526019)(186003)(4326008)(83380400001)(1076003)(336012)(316002)(110136005)(82310400005)(2616005)(54906003)(7696005)(6636002)(6666004)(5660300002)(356005)(86362001)(36860700001)(2906002)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 11:53:05.4134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc8ad86-81f1-4fdf-68be-08dafa13b9cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

