Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFD668B40
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjAMFZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjAMFY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:24:28 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1852B6218A;
        Thu, 12 Jan 2023 21:24:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0vcQrBXB8/uUDxD2wmhIGHozAY+ljTiKvMFQ6Smkrrgw+IfHmLXUIqREIOH+n/aj9xT1lNOxEo9VuxpkdoM49imRL8IZuB0p9+xfOT9Vzw2C2DcgtfLC3cMt8jn9vlBbZptiq2jmy8J67CGFMMnGYVNQZFAt5NUFjV+ZcvkFVoBYRb8pknldrM5uw/ouI6HVieo/1wMfCLNZguULXWLarLkut5ap4ssSUhv12PotNawNKC2yA2o9zmHvuYxlOb2vz1Y3U1/AWqIEDSAlkydHojxpV+Ng777sd2LtjCKkYupy4ReoBAYGJ/uW1shJFgpiEiIwfmHaewPH3H2+L5Frg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8o7pOTB7rr581e9f3WW+ovZQfdcnvY07pEUymHiYvPI=;
 b=jXW91T9Qh56jbYd/Rd1L1p5Ftxc9237ttizPf8zMUBAfzkEePqEuf6oZYJGcc+j0eGAtiD5823xeNKqK3GNO2SoGFefyUMEVHZE7zEtdwY6kuxlETnSHUNPRJAUz6u1TZ9DRc/1LQ9sa/jo0YEZ8G69NtwyLKAadjppQtyZLVoEm/vLG7qajLd4cnveE+1JZx49pRnTtp53m+gEbILcbBod5BO8hRN9Owu1/C+WLqqDt+cYNow9rVObw4q5CCnHxC6Z6AOlBBAb2LnlN/l+KNDYkB7crM7ixqsZ+Oat38R3lAqbXa2zEsHHlDzFAxmErruJ8uF1BTtHEed9hAEitPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o7pOTB7rr581e9f3WW+ovZQfdcnvY07pEUymHiYvPI=;
 b=uLqgVCNftlK5RDH9rSBuNjj0e7nCobrjtBi/dzkbXDyRpsydTXGSQ7Z8Qw5U3Nfw/YUB2d6z/dQdUENIutZ6Mt9py1FYAwpkqN6SATsj9si2eKVsF6nir5974jiceyGoptsWEppIaaxdEID1XtIKGbehse3sBLgzMZd2POqxRao=
Received: from DS7PR03CA0143.namprd03.prod.outlook.com (2603:10b6:5:3b4::28)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 05:24:23 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::66) by DS7PR03CA0143.outlook.office365.com
 (2603:10b6:5:3b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Fri, 13 Jan 2023 05:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 05:24:23 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 23:24:18 -0600
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
        <santosh.shukla@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v2 4/6] Documentation: amd_pstate: Move amd_pstate param to alphabetical order
Date:   Fri, 13 Jan 2023 05:21:39 +0000
Message-ID: <20230113052141.2874296-5-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113052141.2874296-1-wyes.karny@amd.com>
References: <20230113052141.2874296-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: de3870ec-6d9f-4924-7453-08daf5266e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuSgGLbT7FB0NfKZ6IfQjEIBuzR6ffk3jibqhR/qPjKfHMZgT8k9K19YJsXvzSj56wOysvyULGoy72xeU6pfQjSkGNmzzQ0k8nO0Op+TMQuNHiUuTSG2svLppFqRWMtGPpk5UfbMb/i6Dg1v+Q2ZYedMqzPq1iq5Skb7AcYZDP0C+u7HNt8I0CVfdmtPliyr8lXDofpkPPxqXA7Qb/Bpo4ulsze3un/rtRNYnJ3d9KSH2+7IUv3R8P4Gli9rVbgUW1mLLHeRwFoQQU6DCfooIYFLMYBcXHojqkIgzCXYdx0ih6IUtBkj+AElTi6la19a3szay9HDtEeIyw/e3hzRqmMqZIfXbLYwJGNk0FTS7qYRhVbc2T/bvA2Gf9zd5PyAiMWZpee14ahULsiun/3bCOfRifIb+TIRyBZXx/eqCC0y9ikGh/6XSdmPqnisPxpTpOpsSZrb768xm7PT/F4X3qTjVCgL7/h9R1zaHupq36ZvJUKJXaOP4rVg7lzpxoptUEInB+bWofrKFd9UA++gXcwVOcQtb3ojoqXXfbAHkdhkVobUd7pFLEtTyooRbzACeRxjALHsJygXnUpYbmvi8aak8jtyEmBdk3Eqf7WdMRkNTO+u6ewN5MewvzC6XHL2WYW1WxEy1SmP4e6WJIqtQxVzsyCI8dEr5NByinK3zZedFR6KBSrlZzTrmC3pXxgqKgQN9DfgsYN/cVBQDbLtjYdL8CLfAzpa+FbpUkvhG88=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(6666004)(2906002)(70206006)(16526019)(36756003)(5660300002)(83380400001)(8936002)(44832011)(4326008)(8676002)(47076005)(478600001)(82740400003)(81166007)(356005)(41300700001)(426003)(26005)(336012)(70586007)(40480700001)(7696005)(82310400005)(186003)(1076003)(86362001)(40460700003)(2616005)(316002)(110136005)(54906003)(6636002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 05:24:23.1469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de3870ec-6d9f-4924-7453-08daf5266e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637
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

