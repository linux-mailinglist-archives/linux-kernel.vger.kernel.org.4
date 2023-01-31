Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6AA6823DE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjAaF0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjAaF0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:26:09 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563EB3646B;
        Mon, 30 Jan 2023 21:26:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nK5EIGsfdsh2E/L4qPIqK0FwP+AKFjSE6a5N0bSFoNMTomtvWfI+d0mAGmhIZcId9Zp4LMu+UG20TzqoRtF0lNvs69SWyKhpYpAeag9kvsf+duRM1q9Jw63xTe/dOz4PerJ6L5ZwE1lDvSe2DAEX6cTnLQ1QPbGlzFz28BXtNgTsm+XtVLSA6SRTI87ekPdS6gEt7eZbHuB8qAcWJso7M8VlE2bjcsQAKujmmyfTuRbTHpCVwRKbeWwZ8XVSGZX1zXMW8eVX7mN7/WWzKsAfBC8+dz3jjVsQZSLmpSC+zaJt259OQEurX3LWU7YabGBlz5n3EjUTiw6u3Uw5AzeloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soJKWscNntUtGILPE7LnMJipVFI6FVSiNDMc4q/beTk=;
 b=Nr+dM1J2sGaP+soFWNtzp+/yo9wEZxTWDj/IfT03wExXOMM88aOLTpc0dxPiZk6nAiuRbZuWFBf6HeERxfEajjJcJI9GK8tUR3WIxejL1NBPD9t5HMQ/ke+QrvzKasArNMPpgZxdSH6ipoTNTHT6rScDFKeVE0p4Lr8ByisCK5C+oXOanKyPkfVJJZ6B+LT3aBPnVT3pwMXyI2dEt+MBtr8OIOwnybXcCzvnWrsLkXeX8e7sZ1ndQ4io1s2U/STyDhMcS4ebzhvvqBREzoqesSWPNDRF3G3s2SMs7z8fR/qzQhpQbCMYoPM64r2w3IWzIENG2I2m6QuyApg/NCTHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soJKWscNntUtGILPE7LnMJipVFI6FVSiNDMc4q/beTk=;
 b=j53OdXrPQgldr6GIr+AzYAUtm+j6frDuC/at9+LIKKeHRJ2cyWm9i9m4v9gsk4H8WKSFaAOYG9123pGpDJhr1c3vCq6DFHD9PGJmyvFpLq8azgrZi9d/SWLGMJhBsy3OlcYx2NsiZ0zQy+0ql6Rtu1cLPc9ZMa6BVmDBJ3uLI1I=
Received: from DM6PR02CA0123.namprd02.prod.outlook.com (2603:10b6:5:1b4::25)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 05:26:06 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::2d) by DM6PR02CA0123.outlook.office365.com
 (2603:10b6:5:1b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 05:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.30 via Frontend Transport; Tue, 31 Jan 2023 05:26:05 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 23:25:09 -0600
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
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v4 6/6] Documentation: amd_pstate: Update amd_pstate status sysfs for guided
Date:   Tue, 31 Jan 2023 05:21:41 +0000
Message-ID: <20230131052141.96475-7-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 42be5acc-4bb2-4d0e-890a-08db034ba6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4tIpauU7JZZJbRukX/39viEJ7tFsP+7ss7cL37FJKVV19EDIw5nt2vz/knoY+kuln3EhI6891W9JVt8NWIcsev4Bz8SF3VsiFs7bIKxmf5aFZ6FZR66Ggct1HKGScsvuceBqQaNGVQ8zWVo+xy2YSWQxyS+a/RLBUNXScuyYxUQ/FwUxmKUGEnQcIQnyZVz6mhH+FFl9mzBJsqcTgk4TFBJ/EEQtaNIaBE1osQY5mxAEbqbaenJWLhhIqfPzDZveGPafbU1kp4X9LCZ6QEIaxyApO8Fk98nMk9Km74cxxQopDf450py9+ObMNGGKyGBs/O52iKxxPMMuQrKfRgc2j/4cAR9m0KOxHy+BdE4U+xBKdoszpgwAFtFGOt84xqL6GetQv0w1YxnuMWhLwTCPT9i+H9xLIgCq0X7b6CTqIT45Ob2jfRBREtiElf8uH8wKvgmgDlLyJdADBlNxaygWVkDP3ikNuTHgZd7jtR+HZcBSzn8yJEqyAUM8ctmdbg9eqyM5epPYg/GQCvfT5dF+QbfRCn5spxcl9m7l0U2WpgzIshMD9Dfp2A8QNgmWLFp/msxL0jxhXLUVGVyTHXT4YBPKEOOgYXWG5cigJibDOUTzwps/EkoaFc/pzr9+/bqxlS3VZ+hcCjvsyFWTUpIjNY2Cp8RN9pZnZJYEkgf6Sk8hfjXLHkIXljfjO1ogw/qLzpzCpjyFtPB0syzuLJxtZgh9SFtcU5XYJ2M41m7SpI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(40460700003)(316002)(110136005)(54906003)(83380400001)(70586007)(8936002)(41300700001)(70206006)(4326008)(47076005)(1076003)(6666004)(8676002)(478600001)(186003)(336012)(26005)(16526019)(2616005)(7696005)(356005)(6636002)(426003)(82310400005)(81166007)(40480700001)(36860700001)(5660300002)(7416002)(36756003)(15650500001)(44832011)(2906002)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 05:26:05.6490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42be5acc-4bb2-4d0e-890a-08db034ba6b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update amd_pstate status sysfs for guided mode.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 31 ++++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 5304adf2fc2f..56a3d11f51a5 100644
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
 
+        "guided"
+                The driver is functional and in the ``guided mode``
+
 	"disable"
 		The driver is unregistered and not functional now.
 
-- 
2.34.1

