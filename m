Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52CC64015C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiLBHx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiLBHwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:52:54 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B24B0B7E;
        Thu,  1 Dec 2022 23:52:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wxi1s2sYLhyjFWk4cCt6Wiqpmulhy7cmngJRaDf1ECnxJMZd2HOp6cf/Yibtb3SKBIRFsydWdcfgAAoKw9jMQntp+gosvxz+0lMtf9znmXNyIATI/oXMlCYaZw0Kiex521mIIdXNcC8K3Bgswf1X2o5viNllSegcMs0XIxKTIyNM035NHE/UGIwufWGOgkoRGPkugOlY8R36xKPx0nwPcTD68xAazIxltfCPtGo31t1245ozYlz1PT32ja5yKqvc5Hegyt28QjOyrhXcGSQw1TlPmUzitcrF5EyzyLk7vAsN73TftD0UCEwF4rI0pwRSGLBArnSQIfmHWbqAnZgKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7HUaZF2RWtW75YfO1ls7LGL9pKvYziwGx2Mp2RHCeg=;
 b=B1y7KY9YJuDDYxwH1MziBrfuBA0OSzcCIQG1lwnJNcGAyd6r0UxgmM543PI5XZg0OMkG2A+6OqDIaavDJEQCoKOK1CaLw+SP2pIbiIWZHZoRlh9xGuAG9ybYVnBNP3s0XLN0CTniIjuK3/1Ems6sZbcqIiLuVK2CPGJmPJb6HRqvA5zl743EhnGEMDhJNXdFa4QkURg3a29DXsHvDJvMbFokLo/rlhVpIXTJhRFwBhU+RKZbg+j+65bj7uLu8B2MfyBR7BPTlI4CEMDH7h3WLDWHbOc9kCy0wNUja0z8Z7rv/p9kbaQHLZBpUwZrDkjbGCrnhf4uMMfU834mcv2SQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7HUaZF2RWtW75YfO1ls7LGL9pKvYziwGx2Mp2RHCeg=;
 b=MgydiQWntnahDcmrjXnO1nYffSuS9mI0Qgrcx9QEQ8XW4xkNtSSvOhlzJNm6sjxCJet2jvj6/Tv0qM8nwhsx8n0zDudv3RfBmZpiXymsdoDdlpz/XONjhsUQTSfEjIgRNJ7Vaa+phKt0rXiNmKPxN6VHRgbS5QjVmnJ98w1HANs=
Received: from DS7PR03CA0319.namprd03.prod.outlook.com (2603:10b6:8:2b::27) by
 MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Fri, 2 Dec 2022 07:52:08 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::cd) by DS7PR03CA0319.outlook.office365.com
 (2603:10b6:8:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 2 Dec 2022 07:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.10 via Frontend Transport; Fri, 2 Dec 2022 07:52:08 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 2 Dec 2022 01:52:04 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 10/11] Documentation: introduce amd pstate active mode kernel command line options
Date:   Fri, 2 Dec 2022 15:47:18 +0800
Message-ID: <20221202074719.623673-11-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: 579428e6-ddfa-4135-95f6-08dad43a1cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBYX4z5Odcct4mJP/ETsaZcsDf0PzgXPp8cX4dZJj454v6rgrWchNozJil1EzmU/1c47yFZQVMuY4IVm7vltL1xtDDJt719MGHfNNOiiArRtO87PLJQMf2vojOUwTx9x13x7mEY8JKepyoappGv0X6r/i5vIIBfiy5T1+la+jAxqJKy9M8ASwhf9H7Irx7Ks5vY5jAJq70KiPe0RGgS+C/iMl8GFV9IOtZvv6Z1bVtviSjO0tlIOPtQYQ4rF85ZwPdeQYF+4eCOBfRpMfB5V8AldDJCIJi4PFCCgFwL0hhKP2ndwjs3fNxobRMYFTobme7Euf/vKwGyvE/43tohB0i900G5p1jY4dLfYJIgl39biI2popvW+ymxpEuc5PR6CinuXTX10oReAty3J34/uNv+sTHm40cUsXEfV4dZ2z2XLwSceIlIRU/i8XfKAF7qa7caEl6VpHux4OZ7DNKMCijuv6qKrhRgSkMaYeGUUx0ltPVgHIvXbTRPGI9I+KrgH9AfTkMnbSGpu9MNF/u8w9d/O9G1Uqdm7bP4q49rq0mWpuyEpzwVtwnwlU2CJPzwSWJUffotl4a+6r/+gLYlmJ1/AG8YQH5meh0eSRViP8ZZo8Ep6ekuwOjPQKKaBNDZxCCaZMFrOGdEZ7CfxCeJEliqL1M6zAC3eF3ieTD+fkPLJH2HbJ/EoI2SRJ4aI7ZVCqyT8CagHKnxIkEizJbqJMzPZgk13RnbI0ZwPylgoCzg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(16526019)(1076003)(5660300002)(82740400003)(86362001)(7696005)(336012)(186003)(36756003)(8936002)(4326008)(41300700001)(70586007)(2616005)(70206006)(8676002)(110136005)(54906003)(83380400001)(478600001)(426003)(47076005)(2906002)(26005)(40480700001)(316002)(44832011)(356005)(81166007)(40460700003)(6666004)(82310400005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 07:52:08.0197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 579428e6-ddfa-4135-95f6-08dad43a1cb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Pstate driver support another firmware based autonomous mode
with "amd_pstate=active" added to the kernel command line.
In autonomous mode SMU firmware decides frequencies at 1 ms timescale
based on workload utilization, usage in other IPs, infrastructure
limits such as power, thermals and so on.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42af9ca0127e..73a02816f6f8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6970,3 +6970,10 @@
 			  management firmware translates the requests into actual
 			  hardware states (core frequency, data fabric and memory
 			  clocks etc.)
+			active
+			  Use amd_pstate_epp driver instance as the scaling driver,
+			  driver provides a hint to the hardware if software wants
+			  to bias toward performance (0x0) or energy efficiency (0xff)
+			  to the CPPC firmware. then CPPC power algorithm will
+			  calculate the runtime workload and adjust the realtime cores
+			  frequency.
-- 
2.34.1

