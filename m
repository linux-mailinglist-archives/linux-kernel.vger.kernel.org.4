Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B4565FB4B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjAFGQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjAFGPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:15:41 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA66CFE1;
        Thu,  5 Jan 2023 22:15:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv8EOK9OpFZ7RCXSxYOKH7w5H9Uf2hEbcfJvzD+6lPzHzQljcTOhHLGI1jkMOY4qsRAFSiXOrRHrI1CJLlnZimo68u1Wl1grK+ZeU88EUh+rL0By+syU3ZzIkRSSr9j4DnCg3SklRA6QDkQkJkfS7j9hof355OKzZC/2IhUMSdvuuNg1Mh45AjvY41ZhfahqEpLf+l/SPNCgAu3qqPwcy6uPaebuhepsaR2fcWr+tteQaaYuDPyFT/aqIshN2dlK9MyB5dpCp8qzaSUbcy4854Q0pg+aT8Mef9UQeVQPx1rSaFtSAnkAH0VukQjTZwbRd5MeWDPYIK+U87AJUlU2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWHzZo1k7Xr7a2fSGPTrkNawJbB5mgMtPeJ4wN9r7hY=;
 b=LyHwz7/3bcS93paVQZAnZorZVT6RzfFM17MQpC/1lk4MuxjGv3B/U8Vqp+k1fwTkYXrtkLKFOo6vGy4XRiBBb/GKVvgCpxKL8l5soGJpG9c5lyRFOfljfXaYd9lmbKqTnvXtCb3fL/RyD2vOD2t772x01ua5nOSYz8DfYlUmiiZdaO27pVVFFdfsgWoIUWOkKUAKrMn2ASwaKWzXqVswSvX3Pl1+Z3xmCYo37s2PYof5Gs1mOSCLc9XA3PCml1NzyGtNOlf16AF5bwDY8x29rqRBO7ZX8H+5tIuDhN+tiLsh4VBPrpLsOVxI46lLnNLNLKgtcCbwMJjTz6kc00lFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWHzZo1k7Xr7a2fSGPTrkNawJbB5mgMtPeJ4wN9r7hY=;
 b=Yu2cfheS9ogkxyby4QIc4swC5zqfHmuBEN61eA/0AM6r9F57EOoILyhRrX1ZUbYsLrzkCc7YYx5MaAPHNByYzZ7CAfN6RQtsi0vF5MRSCi+z6LNfaRLoA66OBb6uCrumF3aW8i4xpXmPs0dKbfG0RAN9C91QkdroFQXweMTgh5U=
Received: from DM6PR08CA0012.namprd08.prod.outlook.com (2603:10b6:5:80::25) by
 DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Fri, 6 Jan 2023 06:15:36 +0000
Received: from DS1PEPF0000E631.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::43) by DM6PR08CA0012.outlook.office365.com
 (2603:10b6:5:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 06:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E631.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 06:15:36 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 00:15:33 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 07/12] cpufreq: amd-pstate: implement suspend and resume callbacks
Date:   Fri, 6 Jan 2023 14:14:15 +0800
Message-ID: <20230106061420.95715-8-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E631:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b0c2c2-61c1-4187-fb16-08daefad6d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +OwZ1jj15MBfqpcr8AwNrP550RLcnkFAAp8EAmD+aOa2qDUNMrrccrV5Kx/1SaLZBF3ncXb2JLsoP6UccchMe5M8fC3eIJRkUF58lzXGs1YXmIILwgLZcSBh4c0ExjbQ8fVeW+tQKm85QzbjnemXpbQ8b+QlKSeeXn8BOXYux04AvVq7cNeQoVOF7yDII9opIsl4/SPxLme11ZyOvu82gwUcDub+WmskEDJ7397X8D2aAVB7x/D1rxcmxxD9RAqFSU0/K1l3mevGRR1AtEXM0rvv+Qz6q02cLjuzEKQVSTphisFG0RSoxczZpVS4zG4uPsZdQPjZiul2bQ8mmqoIA9S9rfl8QQMKWcxE7wKE8FVn7h7qKCgobNFnBNt7bA8ZIK8cK4Xt8QSTRRytLhmaHHpUFOptBGJQ1qQZIEbj6keD4a9FneVSpuJwo04WEPmCnvdtEYy2h/6V6UauK8r3QnWKDsDnFWfllPK0kvBx+qedN8pz/tBi6yD2iJS0xs32tvgK/PVIYYV128xvpDMC6+6QgIwWsN4RBRJOpbZpI38ryCGHfrZ6AX8heXAZDODdH3JPju0SW88Rgrb14EmxKy57SN4I3oHwBn29xhATAR7xUQtT8Vo5ITiiix9DTDzw59PnuJO6I0Bt2COxM960UaYqd8DxEytmUBb0J50lCr/FhfldC2MBS/PMVU7qJNx431v8uRmWQ/iDAKDvu3Fu+MjuOSnEcpPtoWvZrq9Q32c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(2616005)(83380400001)(1076003)(336012)(47076005)(40460700003)(426003)(36860700001)(86362001)(40480700001)(82310400005)(82740400003)(356005)(36756003)(316002)(81166007)(8936002)(15650500001)(70206006)(6666004)(16526019)(54906003)(4326008)(7696005)(70586007)(5660300002)(110136005)(8676002)(44832011)(2906002)(41300700001)(186003)(26005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 06:15:36.7183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b0c2c2-61c1-4187-fb16-08daefad6d44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E631.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
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

add suspend and resume support for the AMD processors by amd_pstate_epp
driver instance.

When the CPPC is suspended, EPP driver will set EPP profile to 'power'
profile and set max/min perf to lowest perf value.
When resume happens, it will restore the MSR registers with
previous cached value.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ae6d2bf18e16..2c8b126cec5a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1040,6 +1040,44 @@ static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
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
@@ -1061,6 +1099,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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

