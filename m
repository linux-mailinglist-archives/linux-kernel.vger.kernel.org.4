Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A152D6ADD70
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCGLcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjCGLcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:32:03 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C784843475;
        Tue,  7 Mar 2023 03:31:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diujgsvmhBVoHCCWnBRwkiQCAc+800K8j1d2KwrMOxx29ZwU2PdNc9Bj9dxVuFbGU5Shwo40QtvLDtmZDq/SXFN9kKuKvIRphaVybdx6GD68DJvkvlu4q9iXu7Ow+oO1Ia9jwb3bKnY0FXS5MmIbDOv7j4ulAOheTNFi/kyxwMNXNJ0YesN9QeUZ/HWuS3JA8ayfz5G1abQ2SElszPm0bl9ftTX1NJl331uAPcT3zHnqexXSMmTH67FSo+jjIqSdiHJzL2c/UZBSrr+u3AdrfSJvCYJJA7DC0sWLpgf2KTwlfiBb2/QO4I+j0TId002dtcV3G4clPPiIjlhnmNOu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqrccLHy/K9iCZa7u8ey+Sxd+xqfVbX3jNE54cX1UI0=;
 b=mE3dhRmEFwOSCUhPUHFk8opibbmNrsMBRUW7HVSD37red+C87IcAgFplS8pJH7q5U375QZhaFmdye1fdcwIZL5dKGlpGoIQwL7KarNxh7ThXQs7o1YIihT/wnU1nrD5DVCZ+REK6BA98lX3vZ4LSt3IAEFY88VXtwJDFsN/R3ciuKMja+rI3VwUlwe/bgIDOOi+Mcb/megXl1fOkuN53siWwAztvxlwoRz9HRTdm0M4PxOhO86SK4uNNpCkKFI3zpnPyWK8fvfIMr6HFTVyNU3etKkmg+ZDcCkcd6EW/l5Td+kFoB84zrJwDmRsCXevbB0gex0Oq92waZldLaAeZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqrccLHy/K9iCZa7u8ey+Sxd+xqfVbX3jNE54cX1UI0=;
 b=KJuRE4125cBYBbeyr30LE1GKwAgLza94azU66UI7zcag/cnaEEXJ0IEmLaljgJtMJamLvVlbOp8NjVtbOzrktCJ0AU5YR92lPKc9tthqKWwDXscvj1uwbDaFhHHEAshQvSsL7raNBr3pf+7IbdXlH8BPeuH5ppLYCs8E5s/4zls=
Received: from DS7P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::19) by
 DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.23; Tue, 7 Mar 2023 11:31:14 +0000
Received: from DS1PEPF0000B078.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::a1) by DS7P222CA0003.outlook.office365.com
 (2603:10b6:8:2e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 11:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B078.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 11:31:14 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 05:31:08 -0600
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
        Russell Haley <yumpusamongus@gmail.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH v8 6/6] Documentation: cpufreq: amd-pstate: Update amd_pstate status sysfs for guided
Date:   Tue, 7 Mar 2023 11:27:40 +0000
Message-ID: <20230307112740.132338-7-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307112740.132338-1-wyes.karny@amd.com>
References: <20230307112740.132338-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B078:EE_|DM4PR12MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 651aabe1-ae6f-485b-8560-08db1eff75b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4nJyLVBaZwV3BgL+ogLwUt+cPAU2BfrOROLEooVGL/xMLNdflGo+mz3gAaveYa9au3ANfy1X80Sd59aNSpNjFVfXxuQUh/Tt6NC33/QJ4isWTti8IXF0QJ//P649FyFV7cWfR999Sn2Ebqki8ajQi4kpZUPy9O6uXOlPj/KHluTG+ih+21IPv50NbFDgNJ8fHfJ+vFu0c0oDVaV9H8aLz3DfqvBgcPA4jz7UNKUbvkKHAC7oHCR5OquKhDf1VBwBBo64m8CWB/c7LrV43eMiVGGkQelwWpS2qb3FjQ1w0IJ5s7D2vk25oEnPnheQavMLH+5Ajf9MmaZqBqf4lbtnCLRRMc3F7GcZAPczwFGRVkRjNbrveJ8306/De+vZ0ceEMJu7J26B2Sy02Ji5wfOYxD6WRYkIHT512SUCe79O7TplhBgulIlgSYNlGC7zmcuDSrasKD8ajXP5qVm2FdBvdWUhzxH06uyC7RlJaAGrkuxcK9uhLY4qnMTDH0KX3A3Krq6M8cegbyxmrwe2VNKOeTyHU49oP8/V14tOorfJDy1nw2wkBHzZXq3VED/TIkl1SFgdgxiKkBsOBo+82xWd+EC22hhodxv1e1RgOIHpYG7Oiqdh55xDmpQA2+VBbmj8/cV8i0n7KKQW95fwM8JjC+UmWrWzZ4y35fM6s+WBgj5Xj0e+z66zzyKEEFtkcMMKxOTu3Rn25N7baZuiZzOJ6+EJcMO6ygO6/JBRMTYPGc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(82740400003)(6666004)(47076005)(36860700001)(83380400001)(36756003)(478600001)(6636002)(81166007)(316002)(356005)(110136005)(7696005)(336012)(16526019)(5660300002)(41300700001)(1076003)(54906003)(40460700003)(26005)(15650500001)(426003)(70586007)(7416002)(186003)(44832011)(8676002)(2616005)(8936002)(2906002)(40480700001)(70206006)(4326008)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 11:31:14.2600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 651aabe1-ae6f-485b-8560-08db1eff75b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B078.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update amd_pstate status sysfs for guided mode.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 31 ++++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 6e5298b521b1..1cf40f69278c 100644
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
 
 User Space Interface in ``sysfs`` - General
 ===========================================
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

