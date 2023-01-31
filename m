Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC0268282D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjAaJF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjAaJFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:05:23 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9306510C4;
        Tue, 31 Jan 2023 01:01:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBMhvxxm8BfrzFykJ+nu4nF0Y3PPZ5e2csmfz7MhDPtCeOgPa3tGjeoflXPOCVvZ/43q2SGz35xTZKQUEqs812+ETyEa8KQ9YaCDNj1ltCC8EZyugyzzatk0Paixa3xFxHHwMG6akdd5/Aabx2n4YgGIfqCE8OatotuV+ZFIfr9NqzIuG1oJy/n0y7eYJ/incCmiZJnnZhS+bejr68+e8Z3Uf3jWDyKtbmZwInhYSrf+wDr7KtjQO7eqm3qhzisOv18ojDPbExn3DXn6vIdzdJeCkCPo5u0sD+LYXvGVsEVkxNW/zkkm48c4qaY6/rNeN49z7KUs7htBXDA0FqqkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyOpI1A31sBbiW86PCnSi346nGCq0fCrhlK2GZy2w7g=;
 b=WnXulQBIYEoeV9CkzZaSgJ+kZ0Hz0zG2f0fENxTED2EctXQdy9DfmyY8FYcc7r5Wluu+oALssu6Z/6jBF7rt/o4pHuJI97aRJ0NMHPUJtLjkFYfYyignJqzY3ufh+jFWodwR9Zn5bIq4wu45AlwBr6X6QHVtcqW0TnyqdqIrvnZWk6KPm1LG7J5qGAu9FQp9JGW4Zb4AJnkxDIv0AmRzj4Y8XLz+2p0WBQACcXLnNIGqLDRskoQnjDXTqPlpJD1n4EVwKSQ/ofrYkagprWAGrw6hqEkigd2pxbYP/Wl0WK6yyDhSk7R7nt/PsqMv2AYNBpYmh7sFAWXcZWuYVEKJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyOpI1A31sBbiW86PCnSi346nGCq0fCrhlK2GZy2w7g=;
 b=lOqT+02RQ2aWDdm3nnv+kdxOUwpx0VNzbVj7e1O8aJ6EfHlwCe3AIBLV7e76jV9Lx0037Re7G12Lm/JXNsdBwH9pGbqkSVYtI3wmc2Akbq7GUg0v6EdX4gsyQ+SMcUQMIUQwHGjk9SAwEa214LdDDPqOLL1keZbHhp8lN5dWlKg=
Received: from MW4PR03CA0261.namprd03.prod.outlook.com (2603:10b6:303:b4::26)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 09:01:12 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::1b) by MW4PR03CA0261.outlook.office365.com
 (2603:10b6:303:b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 09:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.23 via Frontend Transport; Tue, 31 Jan 2023 09:01:12 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 03:01:08 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 08/11] Documentation: amd-pstate: add amd pstate driver mode introduction
Date:   Tue, 31 Jan 2023 17:00:13 +0800
Message-ID: <20230131090016.3970625-9-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131090016.3970625-1-perry.yuan@amd.com>
References: <20230131090016.3970625-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 2159cf00-2342-4488-0bc8-08db0369b3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zKoVk1jgUpt46dHhd5ME9Nhen2+E9D5olaCyT40onzv/Tp2SsGZnKBoP7uUpmMiC6SZLLnVnxbf70a6nODRmDX+x5qEo9LR1gkFZ1ibn9Xl8FvTMz4FQ9ckYXvkpevn+a9Oc3fqx53gRazCEYI+0Hsht9p7UwF2I1NjtmeD7tfF6VAP3bHRweZEu/AvbkvaKTH5S8Tk+3eYWNkviJmLlniBUNKYwLMd1Z32Fwop4YxthkyuIbc+DUBwUh/A7r9Q6xMzzwZTIBG6HMgCwFoHbAgiZShHlWljDKY6dbB2q+xKeCXau2LeWnJWAJCd0P1OxBtxgPh7svUviDZqK3H6GY9qcOf809TWUb6NrFKA8hKbaCs0MJKJ99LAgJVJAvsMibZUpjo6SnHNFQWgCIjbu0U6itnuLtAIV0LZs6JPGBzRFepB2C5/EMJdSIldDrJ/rmly4ZegtuwVn31zFmYYHSTdK8qaD4UWgxDeyJ7Op0kp2z7h4vy6Zb3SR7A3RnzV+N2HIH8Rx9qCLQYyAXo9/6PH6JDFtp7KUqhYIUtWg3pzDNXz6jwbK3dPpxUIWhv7WkNRrFzHqgI8oVTsiYArS2JfLkfE1otl+M5VF3+dEZ0BkoLC/VsA+lquTNBUQkS85h9FlDjWXx/WQ5PNcO8qhZMkwqhXosbOHDPVNRJUjR3hUTzWFAHKaXE66CjVnkFxLCZkSg5eKKA13Sh5zRio0HD8EbCcc6VtXJtiugzshvg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(4326008)(8676002)(70206006)(70586007)(8936002)(316002)(54906003)(110136005)(44832011)(5660300002)(41300700001)(2906002)(1076003)(7696005)(478600001)(6666004)(356005)(186003)(2616005)(26005)(336012)(16526019)(36756003)(40460700003)(83380400001)(426003)(47076005)(36860700001)(82310400005)(82740400003)(86362001)(40480700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:01:12.3888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2159cf00-2342-4488-0bc8-08db0369b3c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 26 +++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 98a2bb44f80c..b6aee69f564f 100644
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

