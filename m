Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE77655DBB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiLYQgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiLYQgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:36:01 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11E76364;
        Sun, 25 Dec 2022 08:35:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8hyYRH9etO+CH5gWr+a5cqOcyrXpWKmPAtdHeoZ49m1+iv+2qhtTXb09XTev+HRKcuh+ZYoOwPu42WCmsK9fp+AUo1yfpHNq1LngopoO9B0IVrMwxmTFXJLTsZd/PpPoYP5QZg3I+eFCzZbxr92PojyCDvRg1d0TmFCltqne3nGq/qZ3rEmiOvTrgdX8MCf/77DVBqRF2M+XV6cpWFoTJsH+kYbtzQ/okw4y7kXi8I4IVIwaJMKkITcCphKGOfOhh/nE2mdDNP+BaG/BP6768U+k0A62ZnhX2DdzkeX1eCs2G/qbFbKObgL9ht+kMzFC2wP/BBDeuDbzZ18eb+uHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iII+df8dnkVuEFvhtq5qZL88U36fP4G+zC7Ke47Rcp0=;
 b=n7+IiPtzwLcEE+X2g85IQyEbWai9F9nWgyb+JiRGRMbilhd8bKSW94ZlJg9K33RVZRgZqCSRqfvwFiLk16T3a2wKySvxLnTECTS4pHlAyohPIDxonDNo90BaoLcConEJ4PvU0+bv+85kPpN2NhhznL7FvW56mXK7mtxijvQ7PQ1k/bRFsB/DDb9Smt887vY6g+c7hawiZQtMDIW1dWVTAeU2n+T2uL6URKh9NLxhaRMkB3LLIbhWFsY6KMsY/GxUBexTnCZQU7Mhkir2ZHO1xvrpUup9+MUxZFHUoH7gbwCbv1LTV/W9s5vNX7DdaZ2fV2+n0lTWQA5QFivO4RsfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iII+df8dnkVuEFvhtq5qZL88U36fP4G+zC7Ke47Rcp0=;
 b=ICWWJlMIXEq5fKt413C9pl6ZeDLFDd5++4UFwWs9rRxz9EXaXRh/9epKJW8qo2tItdBBveXAuKY9J9CT0Uk9IUKWHJ9mz8SU7bQPMkTRJTX1shn6cSQB0JijwW/ds1BwtPVnwPkkTLis41Gu3Jq4dDjevMgeK/CVQ+en2wnUM64=
Received: from MW4PR04CA0387.namprd04.prod.outlook.com (2603:10b6:303:81::32)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Sun, 25 Dec
 2022 16:35:34 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::4b) by MW4PR04CA0387.outlook.office365.com
 (2603:10b6:303:81::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16 via Frontend
 Transport; Sun, 25 Dec 2022 16:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.16 via Frontend Transport; Sun, 25 Dec 2022 16:35:34 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 25 Dec 2022 10:35:30 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 10/13] Documentation: amd-pstate: add amd pstate driver mode introduction
Date:   Mon, 26 Dec 2022 00:34:39 +0800
Message-ID: <20221225163442.2205660-11-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225163442.2205660-1-perry.yuan@amd.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 522e8515-0ef8-41e7-4a1e-08dae6960bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SF2DwV0ng094H/mcwzyjnDnoBmIKni7Dley1ai/zMaUbq7sbqxPKcsqBzwnWFCDmzbPxNfClwP/RXAuD8zRDkO2T/yddOdy9hFm9HyzBgJ3ZudrVj3tvz5W8o1agKQPSWag6r68+fx2wQ2uTw3sxKMwQ0m4p2yPp7ZUJzhooEVUDea6CNyxaztCHip2k0kGDtNP46qY87jm2odnPIQxgQ4MaCpREKnkX7D7rL4gjSNKUe0Zr3pJhjuG+TSt/rME8DIISmxoggNAuEwdPjIGCaszh89So2D56TNKZBNzTxsXlaOn40Tq4b682SSh5YTwUlt0u6OUbSoaXji4PdWd6BWN1QMHpGEvRLyhLUPURi3IUJqc3rZioQ6cPamtJaKwRaVVW5LMXte/C6xruQMblv9Po2uOlcZpbte6Tx6coPtz+OCpky3FUWVWKAMRrVmdTwThxmnqshkbYOQmz8/CJN+a9bdeXlBUZEVha9FteD54KLxae4BrGqknjJcA+ApUf26M2MpMQqTSi4YPEMUd3AneM2muDRoTBX2SjneTxxufxCvXObCrBr3SWlJbAMRipC5j8Nwt+FhCtS5aATk6sdjbh7i6BBv+bCdFeaucJmuKEKDpea4bbdur4xbRhRJbxuAiwzjG+SeiDbDwb8m5rqOGXNWX2syacsJg1r2XtZB5fZ0VmS3z5p4wJ4M3ZovpEO0LZT8pt1DOCvtHKs4o9fkNk1OzuaIPa+auduOFisw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(44832011)(186003)(8936002)(70206006)(70586007)(4326008)(8676002)(41300700001)(110136005)(316002)(54906003)(26005)(478600001)(82310400005)(16526019)(356005)(7696005)(40480700001)(336012)(47076005)(426003)(2616005)(83380400001)(36756003)(1076003)(82740400003)(81166007)(5660300002)(40460700003)(86362001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 16:35:34.5153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 522e8515-0ef8-41e7-4a1e-08dae6960bf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <Perry.Yuan@amd.com>

The amd-pstate driver has two operation modes supported:
* CPPC Autonomous (active) mode
* CPPC non-autonomous (passive) mode.
active mode and passive mode can be chosen by different kernel parameters.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 26 +++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 33ab8ec8fc2f..62744dae3c5f 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -299,8 +299,30 @@ module which supports the new AMD P-States mechanism on most of the future AMD
 platforms. The AMD P-States mechanism is the more performance and energy
 efficiency frequency management method on AMD processors.
 
-Kernel Module Options for ``amd-pstate``
-=========================================
+
+AMD Pstate Driver Operation Modes
+=================================
+
+``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
+CPPC non-autonomous(passive) mode.
+active mode and passive mode can be chosen by different kernel parameters.
+When in Autonomous mode, CPPC ignores requests done in the Desired Performance
+Target register and takes into account only the values set to the Minimum requested
+performance, Maximum requested performance, and Energy Performance Preference
+registers. When Autonomous is disabled, it only considers the Desired Performance Target.
+
+Active Mode
+------------
+
+``amd_pstate=active``
+
+This is the low-level firmware control mode which is implemented by ``amd_pstate_epp``
+driver with ``amd_pstate=active`` passed to the kernel in the command line.
+In this mode, ``amd_pstate_epp`` driver provides a hint to the hardware if software
+wants to bias toward performance (0x0) or energy efficiency (0xff) to the CPPC firmware.
+then CPPC power algorithm will calculate the runtime workload and adjust the realtime
+cores frequency according to the power supply and thermal, core voltage and some other
+hardware conditions.
 
 Passive Mode
 ------------
-- 
2.34.1

