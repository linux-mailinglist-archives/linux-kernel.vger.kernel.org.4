Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C52965FB51
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjAFGQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjAFGQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:16:27 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781A26E0F8;
        Thu,  5 Jan 2023 22:16:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhzXzrzoRloJyhpyyA/76rR6HeKqsackz2ZXkihNLjvCoW6DLLk0gBc7J+tYa8jX4RdDSsfX2zw0vOd7SC2mNANjCublQ1nxnmX+mDp5a1JGnWyRTYJANlrBSqHMN6KdMzHugxrk12lbkzwnX9cuy2SuyaWmtRsm+6MM4DysQLJ9MToulEv3p217XK8D0KNEop+UPOCkKk0TqvmR4/767yP9xfb1sRCvvIz6kGJQFTw2xSvFVyHHCB+vTcposuERjb9BLuS29WMSlQ2797T8FbajrqghzdEARBr/zlpbqLQGrYsTNVSe8BvRZbGYDsM/Tu2hJonlpi5pRqzACw2Hig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj0Sw6ImPImF5dKyf7qz6SM78Z547bVC8FKFub9x/Xc=;
 b=HSvoQBtr9Uy/DE7PcD3FDN31oANT8V1k+ydnKOiEzXPvoJREUsBWhCvaB7bEKfV8VRYs9tZoJCxCLwH2ht3Y4rhQWMta5a8IFUZRwoaEckM6M3G2fMTFlwzjBmK/nqTCi1zWSY7iGfhqAwfviGURLQ7APKl9pgUl/27RMSHukiIMI4of/D9HJSmJG7S254DmNVDJZ13ycsVyN7bJHynu6JmCkxGZ90U43sloWCnI9u1dTqS+xgq19uZTBJd0ExF4FLjvZij7Nsgimmr+jB77walUCsTus2xkagYrqcK+0KcFoHYZlAM5tQq0ksKx/xFC/6YtJXYzDBGL5pUSOCTcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj0Sw6ImPImF5dKyf7qz6SM78Z547bVC8FKFub9x/Xc=;
 b=cWocRDu0oB50DylUlIAlAxi3eRQO4nxj9nzacfa/Q6oGM1LZYG2iSr5hpW4awOy0LtRiTfNz4XZfp07IJCap34dl8D7BGSrEs9KUVzd0o+K/cHHMMxJf3TCPWxfqcYBw7YakDaGYro8oaiqFm6sWbL3oJrAffB9oMzDju9U1KUM=
Received: from DS7PR07CA0020.namprd07.prod.outlook.com (2603:10b6:5:3af::12)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 06:16:23 +0000
Received: from DS1PEPF0000E633.namprd02.prod.outlook.com
 (2603:10b6:5:3af:cafe::d4) by DS7PR07CA0020.outlook.office365.com
 (2603:10b6:5:3af::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 06:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E633.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 06:16:23 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 00:15:44 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 10/12] Documentation: introduce amd pstate active mode kernel command line options
Date:   Fri, 6 Jan 2023 14:14:18 +0800
Message-ID: <20230106061420.95715-11-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106061420.95715-1-perry.yuan@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E633:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: d990c032-4419-499a-da54-08daefad88f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhieEse0D//WIdXPW6PqI2ih8cHE+Xd0cHlrKIRl60rZRdIuiVMGgH/QbI+BJa8/0nMEpogYkOQcrofwCFCEWOophqOA957+gQfqBJ68Z9tI5V3DigDj4W7BdHciVM7I/pegZWY/MQoLlbntcM4bQ9ZKFTVwpdpjcatOQLfUhehKEKIFgHvlIdbXFPSMpc0S6RngfrEKyL6GA126JcNvO/uA2WinmN04/DFLbMdtMy6N9apPT1/Dc5ZOO/Zx/mIB/cZaS6alh8POevF+2YRuZNLPIf8rXsMl+48AsJcyVcgDWRyed3CG+nf3Vj0U40rLItgXReagkLqeHkVlPTBTSNap+ik9GAuQFR1Ywx/GIhSOpHea9yFdKRhyX/v5rdq58K1528GuSjjR/0KxUROc1zYvJma5fxoEJp6WY7tQ0Qoe2Btie2OCCH80/4137FoTiBMpu1MTtAEtqO3+lXmgQOlrih/bO7h6MfFBoFZSHn/4lBfnlgivbcmGxskqAR37k5nb2nsSbbQmSQGYlhQDoKHKl89DxckTCFqHnmzkpL4GgpMRfTP3CALBciVHRhtkUxriWkGcQzPi8Bw8WLlzgDfvgU/w75mo/NtBfa7XgTvqjV0bnBNEp7sDbTw/6y2rWYJhBZVyCUKEupt/j9tsIK8EvFSFUpBOMwiw/0KP+YjLsE+ZoXneuAy1q2NX5maakXD6TkgUlEWFtVLgFCItDgS2kbQMtOYND+LDQZRTtl0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(6666004)(70206006)(26005)(1076003)(54906003)(70586007)(2616005)(110136005)(186003)(16526019)(4326008)(8936002)(426003)(5660300002)(47076005)(83380400001)(41300700001)(8676002)(44832011)(2906002)(478600001)(336012)(36860700001)(316002)(356005)(81166007)(40480700001)(7696005)(40460700003)(36756003)(86362001)(82740400003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 06:16:23.1890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d990c032-4419-499a-da54-08daefad88f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E633.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
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
In autonomous mode SMU firmware decides frequencies at runtime
based on workload utilization, usage in other IPs, infrastructure
limits such as power, thermals and so on.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
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

