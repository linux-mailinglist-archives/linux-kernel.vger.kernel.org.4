Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15316507B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiLSGnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiLSGme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:42:34 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD5F26DD;
        Sun, 18 Dec 2022 22:41:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjCIGo06MKgXH4MYbmiBpfD3WPs4QqFQLJwWA2AF3OtpGm5LIpTMIAZMQJ34/6rDkmXbeIqgOXmdFQyjtN8hBrRyHKf8wgr3biB8OwQUaTiyPtqtWvBw+HIk3tkaqh7S0HvCkQqd57VawthumpChCk/tEftd+8XYWHGUS5N90xURYdbHcUQNDjN+iQeFXIwrbmR+D84DHp4sv3ITcW1St3Lu374MV6E9qb6vw+12hnsqyZY0TDrGuNFkdsPY7hWbXf31paub5mIxc6vxy4ugVshDRTuZLYAl4CYotmhIMbB9OXaSJRJOeT6Rn+/9Ly2LnXAgytNX0dgcYUuV9tWSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iLNwCDA2FPuXX0XbspH2ZQmIiCfHs2C+UB1BWc0KDM=;
 b=dVJ3A4/Bwf91GOJMFAlfPoBSo+N4uQZNaS1H7G3H0fNMOx49kT4HjM87bAYv2dcsDHdtBERW+0icySspUXdAXmxlbxIGCJDkBJgpkoa2VHeeFzLvNgp8SSTn126e282eqeaP0AkenLdY1/La8iuIrj5ikf4KPMkArvO4thydmXix9yp2OV66NF/w+8fyooVcBMVaZdX3ZDYjRyz0AXRIsDnVda0N6oT97+CkEw/lrJHcysOvVKPJG8vCiH5fDTVFcLUf08f+RSLDd6da0fPOdsY/l9Op3WYPvh5w8ogPYv2LHxkdvuMF+RRz234PS2nd10XVR4HhwhDy/Hfz0y7m3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iLNwCDA2FPuXX0XbspH2ZQmIiCfHs2C+UB1BWc0KDM=;
 b=d0rVuGUPGPBLZgADwSjO2PzPGu/iEJVvpYOOaZYIBp9BGO4ql1u8A4/JnJTnGQnkpLFpr+JjEhSIhKRKR2ny/bDS7Xm7JbkpfWgTlPUgmKSlqw+6fGG6hZAw50wT4h+/13zhhqe0aTdQTDEZPs0/nbDaiUjhHqPKm7PSsR9vFFQ=
Received: from DM6PR02CA0081.namprd02.prod.outlook.com (2603:10b6:5:1f4::22)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 06:41:55 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::fc) by DM6PR02CA0081.outlook.office365.com
 (2603:10b6:5:1f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.20 via Frontend
 Transport; Mon, 19 Dec 2022 06:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Mon, 19 Dec 2022 06:41:54 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 00:41:51 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 10/13] Documentation: amd-pstate: add amd pstate driver mode introduction
Date:   Mon, 19 Dec 2022 14:40:39 +0800
Message-ID: <20221219064042.661122-11-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219064042.661122-1-perry.yuan@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|BL0PR12MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a865751-2e29-451c-ac6e-08dae18c1e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oOQkoWr3DSE/n2Pr2VqXhC70P0WWOvqoSAvekShiCNMy2HyUWEQP1rhKFHnjuharSSVPVfHi5PPl7Iy1y2tpCyuw7RqOAWiv1ADmLskvhvArlPvrnketFBJ1PFNHzGVEzb10bemP3IFIn7lDrsxBGnffb3bTFZht9G7Vm4SwzOF6ottRhwAPvBx9gRohM1rqwAbxbU7qMR00lotQ6YF/hqciFZIVckMvsd5oFez3UOmBpyLMd6GXc2WrKjuiT2SMVv23BdDJYa2SnlTzuKXvRAMi3NmhfyjnrEfb8WW0SAl10vm4jgqDcjSwqlY+btxCTiUqSNs4QxBAYzyCwawQlvLD3hjhsYq12qJeQkDbbKqevMAcpISVLcFIow9VM3/Um6SL0b015oIk9M+IJSJPCMAuMwM8T7vtKBtTztQ3/CMX4stydxnmEd8GupKRM4Nw/L1b38y6MBYANxtj7H9Ly0KTvXvNwYiVq7r8kgxQi6q7QiYfPQPCj1o1s7SmXlZX4CUAMb9bz2N01oOpi2yJlBgwhpBPYD9WP9RCVmsXbq6k81sKbjIknCqKFLAYYnFdeila9qJWkiIltMohaYvZ0CS7NZHWfWmZWPc5uTbP0DAuSXxdmsAslPvRWixUZHPL1UXCXxKcRfrDzUKg48RZg2u+Gx7pU/lW1QOmBZDs5heJ5dIRYN6fBelvy/TO+tKtYwRFTJHK1fWBVzyH+8kfN9jg77rlvmeUtcPCZCnYWVs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(8676002)(40480700001)(2906002)(86362001)(336012)(4326008)(70206006)(186003)(26005)(41300700001)(16526019)(1076003)(478600001)(2616005)(40460700003)(7696005)(54906003)(110136005)(316002)(36860700001)(6666004)(81166007)(356005)(82740400003)(5660300002)(426003)(83380400001)(47076005)(44832011)(8936002)(82310400005)(36756003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 06:41:54.8960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a865751-2e29-451c-ac6e-08dae18c1e82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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

