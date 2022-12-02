Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A7164015A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiLBHxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiLBHwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:52:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36392B2B43;
        Thu,  1 Dec 2022 23:52:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud1BO4BwfPNeReO9ydEp0c7w3Nb0jknMANxe70jTFYyEZodxZZh8ir21a7MYC+H1USp+5TBZ2qi/haRz0RCvvmEtMpj+R55OCMwJqCWXPlwdIdc/Dx6ui/r/bCbM2RtU0vGX7djHuiXlhBrauM8oc1gl2Mq4hjpUKnkyMbt9IA5y4bax76urTpnt7cXpZjjTGY9CkFmo0Jd8hEiFXV7REoG35EKmomnFr2SMfJXd6PDNbyFzKksFe/x99NC1Gn4ItERwxagdVrD17DuLwzlrEZdlFIxCUBYBl8kxlxNGErNaFApZpkqGox8qToRnY9khET1lEkMKrBfTX7BKmfl3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iLNwCDA2FPuXX0XbspH2ZQmIiCfHs2C+UB1BWc0KDM=;
 b=SBpL9JAj5aNMRV7IRRwFe7WR5V+KkxHyNTJprwBxNVSST+wEdg/S0jiCYQq1pjbBTSRTptuPULVTWVhWvj3RjSEIaIiVThjblj1BKv/zwCjJtTDHLo9wJIxOZtu3GzeptwYt/Sm/d7gD+OBiEZ0NtGCOBV3auBf82qVWAJffNyelX1LD3T4FBxk/beXBHqOs83nDbrKCy7/uULNu9KU1acIFMBtVsBEIVc/GtnmrkbwXXnLfT8VvyzVwnADjGmYwHgbnue1hHrnZLb3wnyzoh3ubw8Ci/YdOQFK/uRVr4ogZN5RoWBsUtAOuQy+cWQihedFkbfDd73C0IuAVpiQmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iLNwCDA2FPuXX0XbspH2ZQmIiCfHs2C+UB1BWc0KDM=;
 b=aVqe2IGYOCLMrx22KL/ojrNQaYwaFK8uqpkzxNQPpQmuh1KMB6zqFCMatyz9eGeRjrOgl86f+GD9Ltk6e/i7QQ9KF7b7BYTDzJdjNEJSPB5o4jZTwIBRiWtYCNlUktniTVOotUEVx+QXg3Yv48fYtd5jpNHm3uImvm56WZOumlk=
Received: from DS7PR06CA0047.namprd06.prod.outlook.com (2603:10b6:8:54::27) by
 CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8; Fri, 2 Dec 2022 07:52:05 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::d7) by DS7PR06CA0047.outlook.office365.com
 (2603:10b6:8:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 2 Dec 2022 07:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Fri, 2 Dec 2022 07:52:04 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 2 Dec 2022 01:52:00 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 09/11] Documentation: amd-pstate: add amd pstate driver mode introduction
Date:   Fri, 2 Dec 2022 15:47:17 +0800
Message-ID: <20221202074719.623673-10-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202074719.623673-1-perry.yuan@amd.com>
References: <20221202074719.623673-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|CO6PR12MB5411:EE_
X-MS-Office365-Filtering-Correlation-Id: d14fb8f8-30b8-4e7e-777d-08dad43a1a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SeQHYtGZhcaW42y8UOGHTVzDt0LtPJaWJbCGgmw+IJl1B+WnXANvtxK2VsZhBoIMTJUDJhxTWfR2wf0RFyY1/TSojplWxlav13YUpWaf8d+Sg1aEnxIuDNE+/Zr8sWEr6q9z0rnibaHEBp/fuNH5E/vPVp3Mxt3aafRvvp9WyqrEI5+9yZXiQ8ne81gyqlfyF+dUZiiQtU+YsPMvhOyJJrLk28SRbGW3uzXYPF9xNRSENMtuMVxD07wDWn9jzsrWyUoouCsswtaOfNRk5iEyfzbXbdZd0gSnzzwTsgFc4LAiLWK8C42Kniill/KsAK41Q+xiy9poEzcjtT+O/EdP0xmHTQGNtATxZRrpG02Rw7BziarhRc+msI3FQdQp5LAhS2flO7rHdppA8ykOwnwG9haX4MRuAfro2bHYHSYLgYqBU0ZalYjvO3RQWV5Iz65lqwMEq13IZAXbu57CF6PjrY087OMi8Gy6+5qvRbQ1RPecDo5d0Bhk1TZON+gRElazNXk4IjsqGr+RXktptP5P+lOZOT/BnIWSdwGOX4biU0yhTREFVKMDjChnKvCWTsgiTLa0E8RgbfuxEodEUa14PYRYJ7zVess5RpuzqpgtxZ/2OXK8AO/7rCASQSsYW5zGeBdREeO1j2yoXI/JLG/x6gW2odmtrrk6+B8gNFShicN3wYmlFDpwQ1zcoSC5Y9VLV1xLLl/lQbB2UEoIf7s4f8KSQZhgcd24CKmwIQudEJ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(81166007)(36756003)(86362001)(356005)(40460700003)(110136005)(316002)(44832011)(5660300002)(8936002)(70206006)(4326008)(70586007)(8676002)(41300700001)(478600001)(36860700001)(83380400001)(6666004)(82740400003)(2906002)(47076005)(26005)(7696005)(186003)(426003)(82310400005)(2616005)(16526019)(336012)(54906003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 07:52:04.4760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d14fb8f8-30b8-4e7e-777d-08dad43a1a95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
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

Introduce ``amd-pstate`` CPPC has two operation modes:
* CPPC Autonomous (active) mode
* CPPC non-autonomous (passive) mode.
active mode and passive mode can be chosen by different kernel parameters.

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

