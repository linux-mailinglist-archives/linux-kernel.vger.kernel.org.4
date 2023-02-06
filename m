Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4907568C4A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjBFR02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjBFR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:26:26 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954222C674;
        Mon,  6 Feb 2023 09:25:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipjD9UHr23JqREv3jljYr13KhQXFOPzaUwL4wQZaI6fGEl1HsplHl2UZg+ftY6F42PpLC5TNrifCVP2lGxg7DG25VtQhSPh52j0X6c83InoWV2DBloGYhwl6YYCZWkED4O4pEnft/LDva7zBarHwS4gvQQvAvDSXY2FUXUT2j3rI6Ez/Ou3uVXfHnjfoE/AzaqWBArbMl/TwKtd2Xj0yqn86ma9L4kN7cEUEQIfIQLnRIyQxmNR2ZdkCzfE4opdesZHRSqag0P1ttO77DMQW11Ttlj5mBe9zQUrQvYwBjOoZJuGM49Dn+OfA7TR446qjgiP4tP5ZN230gP7V050w6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dg0Vkj3D9j46jkTDW3/wPndEHLKjgqWxLF5vzaqN5d0=;
 b=YM2LceXX4XvbaKnBGnnE8AYuNPepWWo4Bsg4Qqg8BVfQFeqLyr0+i/6MGRWx+lb7T/1m2ENWCQ+S9DGawfd00aSr3Z6ztB81KUGqTXwKsNMPDeKO1WdPGgwgSt1ufuyGoUsIW+N5wq5AhU4U+BxfIGdO6k3q+xRdFiZYdhM/US9X6/BzdjK5Nq3y6wMO9hLfo/UKWyF1lr+AOXjnrJABp089uioE36JnWYracsCuvLCgPIpWJB/cfDpIBFj0c7/Y6jTpq/ZR+97BlwmL0ECfM5bzsP9YABL5syh5+y6Lv/qyQPjK+DsBQiHOizbo3kwZ374kcAV0UcLGD2L6WVf8Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg0Vkj3D9j46jkTDW3/wPndEHLKjgqWxLF5vzaqN5d0=;
 b=Hzm8RGUEuMl5EWzut3+yn8G6j49aFatrWu5ytlPKTltDKH8IX7ZBZxhZ81VpyDdzg+jV0C3ule8+2WcWez+0ZDLRAZ6271mr1zb6bK4CYV8vVGgJDcxe4jx/4UXkREVOy/NeowbN7MTAhJ6YbPPdXIIRsr42HMkP628QMaMOkKk=
Received: from DS7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::28) by
 MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Mon, 6 Feb 2023 17:25:24 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::43) by DS7P222CA0029.outlook.office365.com
 (2603:10b6:8:2e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 17:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Mon, 6 Feb 2023 17:25:23 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 11:25:18 -0600
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
Subject: [PATCH v6 6/6] Documentation: amd_pstate: Update amd_pstate status sysfs for guided
Date:   Mon, 6 Feb 2023 17:21:57 +0000
Message-ID: <20230206172157.49887-7-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206172157.49887-1-wyes.karny@amd.com>
References: <20230206172157.49887-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0f0b86-059e-45e1-1634-08db08672172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWOVmcgtTqjzDnwY66ecicQvxnBhdpkMSIkzUtDoq4upkHzhutnLLHKG1q9bd6kz4+zxPCy64QKwKPMCJo3rhTb8a6PcUU/VzVvzT0iefSL5BseTyRlAtgKzdpm27CerIRLU0wbzsDBfnIdAiIk1Sc3O0yesOSGdTmJh6Pxq0Air1t9x3+lDUwwhqQF2UIfKrrKjhz3ZLTMvchGm8Vo/YFvZ/Shk8WFhlj7V2ZxJ2+2tvWoRi0Wze/wXuJ8dPI6rwkGJVcIumVHPw3O6B1j8cpI7lDPrHK3nGqCDTGi5pS9hmbt7DKZJCykZi03162qgy2ha8TUHy3kFbr25oEIGNAR/wLv24VMm1NxVIrPFonjJr6tyoR7AnKo4Ppl0L0aiS5wQmQoc8q1uv1JZ0PHcYDw6WlUflqQZ0YnSjpgy9beRs0ruNZSeG5c9c7hYIT+EWrbmwN/dLCQtGukVUJwGtPBhjnCJ/t8Jn1H2vM8mNePDcfRi4QF+se1I7rr/WVNd3WauZPPjHETdqYtPuP9J5UfpWh59+JKScD5kS0ihDm4MXIxm0rxgG7OskFId35ctuREpeXcsKATZmaQe05DqGtpPveQUkogmrVc/b3U6MY0OC5vXv8oTV8VmgRR7VOlSXZ/g/dZI1sADLgSEtLosm5ggfZxCgTO6BCmvxjMHutu1bxQQvjMhE/i40O5qnaX9TBmT/o/dNPzk1fM4Z21s0vDxp4G24tUD8f+mwsGwebQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(36756003)(7696005)(6636002)(54906003)(316002)(7416002)(110136005)(70586007)(1076003)(8676002)(5660300002)(2906002)(44832011)(15650500001)(41300700001)(8936002)(4326008)(70206006)(478600001)(6666004)(82740400003)(26005)(36860700001)(356005)(86362001)(40480700001)(16526019)(336012)(83380400001)(426003)(186003)(2616005)(81166007)(82310400005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:25:23.6960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0f0b86-059e-45e1-1634-08db08672172
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update amd_pstate status sysfs for guided mode.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 31 ++++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 5304adf2fc2f..95d2d0a803fe 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -303,13 +303,18 @@ efficiency frequency management method on AMD processors.
 AMD Pstate Driver Operation Modes
 =================================
 
-``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
-CPPC non-autonomous(passive) mode.
-active mode and passive mode can be chosen by different kernel parameters.
-When in Autonomous mode, CPPC ignores requests done in the Desired Performance
-Target register and takes into account only the values set to the Minimum requested
-performance, Maximum requested performance, and Energy Performance Preference
-registers. When Autonomous is disabled, it only considers the Desired Performance Target.
+``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode,
+non-autonomous (passive) mode and guided autonomous (guided) mode.
+Active/passive/guided mode can be chosen by different kernel parameters.
+
+- In autonomous mode, platform ignores the desired performance level request
+  and takes into account only the values set to the minimum, maximum and energy
+  performance preference registers.
+- In non-autonomous mode, platform gets desired performance level
+  from OS directly through Desired Performance Register.
+- In guided-autonomous mode, platform sets operating performance level
+  autonomously according to the current workload and within the limits set by
+  OS through min and max performance registers.
 
 Active Mode
 ------------
@@ -338,6 +343,15 @@ to the Performance Reduction Tolerance register. Above the nominal performance l
 processor must provide at least nominal performance requested and go higher if current
 operating conditions allow.
 
+Guided Mode
+-----------
+
+``amd_pstate=guided``
+
+If ``amd_pstate=guided`` is passed to kernel command line option then this mode
+is activated.  In this mode, driver requests minimum and maximum performance
+level and the platform autonomously selects a performance level in this range
+and appropriate to the current workload.
 
 User Space Interface in ``sysfs``
 =================================
@@ -358,6 +372,9 @@ control its functionality at the system level.  They are located in the
 	"passive"
 		The driver is functional and in the ``passive mode``
 
+	"guided"
+		The driver is functional and in the ``guided mode``
+
 	"disable"
 		The driver is unregistered and not functional now.
 
-- 
2.34.1

