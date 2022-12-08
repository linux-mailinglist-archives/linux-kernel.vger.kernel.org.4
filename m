Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1DE646E57
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiLHLVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiLHLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:20:36 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E05563D54;
        Thu,  8 Dec 2022 03:20:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dlfm5sYzBvtqhLUzAcIHETim0Ynrr8eT4mWbRoMp1q2IvFY/DQs50CD7u5EYFux/1G9gxMT7n7hTJBI65wqwEvI4GZmaEyVUMciXgqPkkLh5ctuts9YFsc1cOfrOTDPU60BczXI8+B1/jC1n//W1ElDPMsNhWn8Rg7kIpJts+P48wjG3/5oqcY8YpbRVfRbjKmibnaXLqt3iCspwHP8yrXBhPHOsBgBxHVPnSC5/0Y0HrBqejsvKpOrb+CC4UxC+4eZkDGD9WHaQPOg0u2gl3km8PUviNcb6XpFhniozyI5U9c4dVVqsFjtjVddqitgp+YRwlcxpjalKNrnUBhNN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04025qQKMJl6SSlMj/7r3MYk863ZKjiPYbB7e2Ml6xY=;
 b=hNN1SBqwp8rWkbHQJrHicH7EVnSdlAwwHCCqxrKWyTyva1vT2rK/qisoVubYQvloa/87LjIQrnJS94v1ycAEHK3kVohBiuw53IgvceQt6qsNdHWVopv+TVNvJYwlSuMFPTgvT0vXI6E3YTowufamKJYpZ0aY7keLy4+2XN/z6mUvf/IZ8RSz6zRt07XWWCAh0ujF72rRXyOZUOXGvfDiCV2jszt3Ax0JbaqmfyDLNmBNJPNgvvVzKU76UwQ6uBJHz/dFNVZDI+1oYqy9b9t/6rRN/IdPM9mYAFLw1JjXJXbxMyfN8eBl6o6ZzLZQ2gjLmn1WpgA9Ki4gEjZfLjvvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04025qQKMJl6SSlMj/7r3MYk863ZKjiPYbB7e2Ml6xY=;
 b=XqQBM1zLFnsk8pyqWqlYJmKlcQlDGXpk1idm2HmGDzB8468vjItRWchImGiiUWkL0ZCdcAKycmGr5515vTCHPx6yCnBRvZDVYOYb4AvGGqGfUjZ1U5Fpv6bRe1HTSJdXWJPoEVCIE3PiBN29wxEsTMF+FJFHzXQZzBolMA5CuVc=
Received: from DS7PR03CA0076.namprd03.prod.outlook.com (2603:10b6:5:3bb::21)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Thu, 8 Dec 2022 11:20:33 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::5d) by DS7PR03CA0076.outlook.office365.com
 (2603:10b6:5:3bb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 11:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 11:20:33 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 05:20:16 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 12/13] cpufreq: amd-pstate: convert sprintf with sysfs_emit()
Date:   Thu, 8 Dec 2022 19:18:51 +0800
Message-ID: <20221208111852.386731-13-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208111852.386731-1-perry.yuan@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 52570dbc-819d-4aac-ba9d-08dad90e3914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFKWaZB3kgPLO3Lu2WFNCJxmvBkN5pn/U5z5USxX4V8LUln25imPf718NgSjGvJZYgQFxYA9ph3H1/yrIXbEcIuT1lMRQoCoi5pGn86OD4oWLOBS2UBc0pY/z5VTABKsMYPpgKa6YiSFQ1f0+iglKjzohCX9ZcjdDfP53AlmjFycJmNapq2rgKShqHo8iECFsZmqRFBozXwkPt+e0JFub2ROEa7eq3kUIj8j373eTo5GyrZ0HpgpVxyFx9SwbIbdLTbb/lhDY6hWaJkkMDbnzoZx6+698O1rNoFgY6JP7REW8W6376SxO7xs7ETR/XRYcSybSlaDHzMYTBqtWAQ3ZTHsAM0q4omelhzx2vOoGMGSaLaiVzRDkVx7tl9khhzsRWMDdOPjz5Akp36vB9YFfG7/qNTBSuDlo4bB3NvvngjvC1buxQaym1Ti8cZ9B26eI+AxK9hkopAh1laKE7X5AZVCeV6ggB7ST69fPSt8aQY/ejCbAG3bdaEJba1VD4G64BdbyMGEidB7SC0Rz1T6xXQXOwpoFxOZSFzIKciePi86z3sv8gcN0KX5FVJYRPoRmX6XIgQ5rN6TxJSQjCHHVDXMFMqWRP80F/YR2Xsj2x4JqsDlTAkCODueKSmqkjYrV9CVWKhzQdD4l+Y8HdYpxykYahjs+4gzJmNSI8JQG2yHKKrtA6+n0LvVWgVYQ5OZGVclzAnVKG2lO+JF7B27fiVNi0PyxIFfgohN/fiFbSs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(40480700001)(36756003)(47076005)(26005)(2616005)(1076003)(426003)(478600001)(186003)(6666004)(16526019)(7696005)(336012)(82740400003)(36860700001)(81166007)(356005)(83380400001)(40460700003)(86362001)(41300700001)(5660300002)(8676002)(70586007)(316002)(4326008)(70206006)(54906003)(110136005)(44832011)(2906002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:20:33.5994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52570dbc-819d-4aac-ba9d-08dad90e3914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace the sprintf with a more generic sysfs_emit function

No potential function impact

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c90aee3ee42d..f40a312ad56c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -694,7 +694,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 	if (max_freq < 0)
 		return max_freq;
 
-	return sprintf(&buf[0], "%u\n", max_freq);
+	return sysfs_emit(buf, "%u\n", max_freq);
 }
 
 static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
@@ -707,7 +707,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 	if (freq < 0)
 		return freq;
 
-	return sprintf(&buf[0], "%u\n", freq);
+	return sysfs_emit(buf, "%u\n", freq);
 }
 
 /*
@@ -722,7 +722,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 
 	perf = READ_ONCE(cpudata->highest_perf);
 
-	return sprintf(&buf[0], "%u\n", perf);
+	return sysfs_emit(buf, "%u\n", perf);
 }
 
 static ssize_t show_energy_performance_available_preferences(
-- 
2.34.1

