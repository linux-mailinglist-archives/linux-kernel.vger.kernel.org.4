Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6E4682837
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjAaJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjAaJHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:07:13 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E11CC03;
        Tue, 31 Jan 2023 01:03:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoareV3TXhvbSBXUlni4EyAWh2k4hk7UeK4ROG717lO4+VHJX5ifwELf5XaW5tawltiGUvxzELvuAffyGirA1/flhEzSU7Wv4ivQUIMzJH9gpi8YqMI99w0eVPSWt2drlcTneq+kbKXg92tUVZK6nIcHT/JZWPidljeFVxP02mSFIEUI50ThkF5pXYlcApBgk8OwPUqvnGTqcqFuQSWNXNqXlWPQahUZ+fGZ5ZV+barc8xoRRNruWSlW+qKaX8Ztx7RT3h18PYY6ABwQEE0W7qeW/I6ZwcUthr7k1Cwc7k6hX/BoFC5Cl81bwiRi8KbNY2C0aRwvp/pjciiVUC/XFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcbUc6IAtvTyWVReg6UMJgf00bmnItIu7njYa8UIkIA=;
 b=a3UWcUz2quLo7AVjerttfBPfihWeZCXOBLqeW3EnznfL+EyPZMQ627OUvpUcwlIkVHyh7aE5yBuEyRFbTc2Mtaog2cBgLtzs/A4nM3nPAhjAYO/1wwIPYKVijCjLgtYc65n716O+gfMvuznfg3MOPhl6lKAWyw3NcwbYl8pfAgswdQJ32dkGhCUJu5wI0iHIRSFhLy0e3olNtiXdeI7d1kc0xHqKGtE25XWjprPyOkbCrfbgNo1jBTYWEUkBm+IT3rrRkgq5RZA/IJwqmB+f5pW9s+x98s/lB5cvigEHcCApBvU/O5NAbhq96rs+K7MnhRueyqTOW0HqoGFRXzm02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcbUc6IAtvTyWVReg6UMJgf00bmnItIu7njYa8UIkIA=;
 b=qV2uy3NBLcY0BN/OYmwyVePROQ7cgTpyyGqxPSllyb3YCxrN2esQdF/NdIyw17IluYuRdgvBrY2hQjISZxJhlhd0zVjtbF4P1C9rc+H3zMngEolR0NfAQp66DUKV9EHYg6zAcAh3GJGlFtdlsCYoAMd2fEPuxz0UbfgtKMntslo=
Received: from MW4PR03CA0203.namprd03.prod.outlook.com (2603:10b6:303:b8::28)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 09:01:07 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::67) by MW4PR03CA0203.outlook.office365.com
 (2603:10b6:303:b8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Tue, 31 Jan 2023 09:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Tue, 31 Jan 2023 09:01:06 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 03:01:01 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 06/11] cpufreq: amd-pstate: implement suspend and resume callbacks
Date:   Tue, 31 Jan 2023 17:00:11 +0800
Message-ID: <20230131090016.3970625-7-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e3b278-0779-48f9-00ff-08db0369b060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFbhA9ycqyaeb9G9FeQVUfcr8Q26lQmQwMFH7UPNZKVB2INAjdN1cRNC8SvQ4EBlNdiS7Lnswd3oEvteEcgZ1f0Tu2UIlFHpV44H7aeA0XyxXcxVKAa92Tl2TvpsGJgB5GBvPMFS/bdqxx30mt5E4Fgcc3kMuDJVQ4QeVjHyJJko1oheP68pm6zfc1Nk8iQ4/HdVIAGzI67YkTFsgaSRHfvA3u7YiPkeL0KJpTSZxforBQVfE62hZG+BJTp/LDBcFuH0UGgrOkPlzLOSormnM08Frr2WmaMkaqDp3F7VW00d3Z75tLidVSCxdE+YTZKvUTG1bVk1yqkFlXOdJ7hgVlKldRVg4FkBqGkFNRmqxqyz8X2natuhja7gmth5qLUcfNlzmNrnPUweMbMnT2NirowzXUmfIXiGzZoXB+1xBi0H8O9bpZnOVx8ZcfCxUVz6Fn4vQrv3BNXUVnd41YVYZWojANulZSvfEwrvvBDhFZgx3YSxASX1ATrs3R/fl+WqP+mxQdQtaQKkTBPRQzdzIdvwxRHBCM9Cjn5zp7pNpv7lQyVDZKSvQC8L3Ym3U+PxGuBF5JHp7LujS6qZMIReV0Pt1yA+EovwKY/2KzzOG4IdCoXOwrbfWiZj+L9RUrj7+7hx6n5EpJuFDktkpIo0y67nHUP/YuijQ5BBwzV/Oz+2f4HoKlMzRRdbhsF2GfnEIk1mmGaNdh/O+orK6JX4rqs6fA87sOWadYuvZCh95rk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(8936002)(81166007)(40460700003)(356005)(41300700001)(86362001)(44832011)(5660300002)(83380400001)(426003)(47076005)(336012)(36860700001)(110136005)(54906003)(4326008)(2616005)(82740400003)(16526019)(70206006)(8676002)(70586007)(40480700001)(316002)(6666004)(186003)(7696005)(1076003)(36756003)(26005)(478600001)(82310400005)(15650500001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:01:06.6400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e3b278-0779-48f9-00ff-08db0369b060
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
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

add suspend and resume support for the AMD processors by amd_pstate_epp
driver instance.

When the CPPC is suspended, EPP driver will set EPP profile to 'power'
profile and set max/min perf to lowest perf value.
When resume happens, it will restore the MSR registers with
previous cached value.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 26f6ac83d87e..4e3770e0d4d3 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1087,6 +1087,44 @@ static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
+static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
+
+	/* avoid suspending when EPP is not enabled */
+	if (cppc_state != AMD_PSTATE_ACTIVE)
+		return 0;
+
+	/* set this flag to avoid setting core offline*/
+	cpudata->suspended = true;
+
+	/* disable CPPC in lowlevel firmware */
+	ret = amd_pstate_enable(false);
+	if (ret)
+		pr_err("failed to suspend, return %d\n", ret);
+
+	return 0;
+}
+
+static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (cpudata->suspended) {
+		mutex_lock(&amd_pstate_limits_lock);
+
+		/* enable amd pstate from suspend state*/
+		amd_pstate_epp_reenable(cpudata);
+
+		mutex_unlock(&amd_pstate_limits_lock);
+
+		cpudata->suspended = false;
+	}
+
+	return 0;
+}
+
 static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
@@ -1108,6 +1146,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.exit		= amd_pstate_epp_cpu_exit,
 	.offline	= amd_pstate_epp_cpu_offline,
 	.online		= amd_pstate_epp_cpu_online,
+	.suspend	= amd_pstate_epp_suspend,
+	.resume		= amd_pstate_epp_resume,
 	.name		= "amd_pstate_epp",
 	.attr		= amd_pstate_epp_attr,
 };
-- 
2.34.1

