Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C132570B526
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjEVGfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjEVGe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:34:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8077A100;
        Sun, 21 May 2023 23:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+AeCToKAsHpJw5xgcI1ZxgdVTTeF0PVlWVsATZ/EaGBWfz+4aMmlLEV+MJa6mQpKPiews5D8fFgjBX8wLWyLUKB2ud8OPl1uQ5C/ktw8re3UZMdEPVjx3I2DnZQ4yltx2EF/8GZAamXXm4l/Ow+4lttq06+NyDAf7/T+wgrAL7wTHYeuNsGvLH7P/9PgU8Qkw8oicV8r18w0RacpTq6/hqm+VMTinoUVSXF/HjYKSlZaaI3y4ZDsXaC0R8zmN3iI3nnfOEedwAhBE2SinyLunEbRLh377RVW9WM/cqUEZ6RHlU6SZYeF2hVYw3WxSoQD4+F6cJ6SAd448rgzbYkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Xg35igyWNgfDVnR5+tz3cYnO04kl0on1TCUxf+82h8=;
 b=dp9ruphiZIc4qjIgi8SchG810CFjvIMFjb+A9dTUnVWxHdXcsKLeNxcm/qoiwZkggi/6pUk6eGkVNcXfDnbcwzXuXwnWoP10erOHGNrcSXjFnppgoxPOQ2fecPMOstAWm2jxcpS8JaoPEXSRx1s7VQNeK6rMMN5F4806N+9AiYuJ/FwsNAnRhsyb6FRDkqc2ndnP+gjL7nhQQishL7XsphwjRW7HDXkqXgbAcLMqdLdKiRAABmLJqeI6OQDTmBIo4YAAHuuhUHvjixNk41v7qwaC9knAVsHIYT4eBiKwPF2iGDm4Y8TQLfcY8Nsi4ogM0phwQvNEkD6tbsnlzq8/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Xg35igyWNgfDVnR5+tz3cYnO04kl0on1TCUxf+82h8=;
 b=rDUKO7TIHgTiZ/NYlNHKGuwNXQAK59jn1BVvEW94MKU9DqaKl/ExZcHItUxh3Ol3FjVkJ5tGWdHH1R0Nj3auHZzwlNhfvpi8CNRUDMJuj/ssuTxGjOxo0kW9iU+r81eM5NgTV7Fqh+smbw/XMMWMfpzcgdjH9RUEMOJaadqOe5k=
Received: from SJ0PR05CA0084.namprd05.prod.outlook.com (2603:10b6:a03:332::29)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 06:34:49 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:332:cafe::c9) by SJ0PR05CA0084.outlook.office365.com
 (2603:10b6:a03:332::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.13 via Frontend
 Transport; Mon, 22 May 2023 06:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 06:34:48 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 01:34:42 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <Mario.Limonciello@amd.com>, <Jinzhou.Su@amd.com>,
        <Perry.Yuan@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 2/2] cpufreq/amd-pstate: Remove unnecessary active state checks
Date:   Mon, 22 May 2023 06:33:25 +0000
Message-ID: <20230522063325.80193-3-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522063325.80193-1-wyes.karny@amd.com>
References: <20230522063325.80193-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: aeaec74e-9a38-40be-06b1-08db5a8ea3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8NFVwWD9/Q4IoHGIX0XL9Ts5Y7tagMo/EwqrCJhvGOYNhQ4nkYTVqoJCwcCPgl+KlLwyB7VFKrL4BjbMoa7ZmoCWwGj7HzKSIVrapKy4vN1QcC4BhqXzxVerOLV2Yan9vb1YU52IU1fXOeIRd1shrgMcofgIIqLqTeHwlcCbWcU+rpzf9GO6okUWo3Q0/ayNA455J3aNDWmacon3LiYNZfr/eVCicNpo5Ix6x0QAoKVkGeeYoLYPswI6HAXgQtL1+R6pkSMmO69EIul1pO0IVITv4S5gMV0Wb/j+27PokxsAMZnW17Cdi2vvp+QSaigyURyeGJSCNzgzkOYDeqLQ30RiJYtGLzdbCGvO5mYru386wj8Ll4C6Zb/vAoifnSZ5j4nXJFALX8Q3cZkKy5Kxi3bHDFMTCOugetOjVOIuQtwBzkgb31opyk2b7vI41Z0eNu3tKYZmAGQ7fny3fwt3zS96p1WV3MEoJ34xtEfGyqe4tmT8zJb58GDBtE8KMqbj2dFPxDozO97aWv66rzCKuWUk8zyj4xzD9Cu1bRSbNXrdtaCaHAA871XYofzRjhiuhB+r/0HdDytZzryB9dRr+SwJYHhA7AG4TD2O6bpRTX+zBYbQO5M9IZRcBKZCjs8nbxDZCR/ROD7QjFNi5CsGdaS6fY7yAiM6tvpUGuVKTAJWxNeheYzuN+48ygDVZSQRrn/CtOVl131GlHjxihce+FNf6NGQQbSeZHZ8HQGE5e80e8RiuC0Sz6G3oxhPMys6oEMRMFeRq4WwBf4+rsb1CZVtNvgNo1kpPpmHiJMLM0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(44832011)(5660300002)(40460700003)(8936002)(8676002)(36860700001)(47076005)(83380400001)(2906002)(16526019)(186003)(36756003)(426003)(336012)(2616005)(356005)(82740400003)(81166007)(86362001)(82310400005)(40480700001)(1076003)(26005)(110136005)(54906003)(316002)(6666004)(478600001)(4326008)(70586007)(70206006)(7696005)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 06:34:48.3656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaec74e-9a38-40be-06b1-08db5a8ea3e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions are only specific to amd_pstate active mode driver.  This
functions cannot be called from passive/guided mode paths, therefore
remove these unnecessary checks.

Fixes: d4da12f8033a ("cpufreq: amd-pstate: implement amd pstate cpu online and offline callback")
Fixes: 50ddd2f78269 ("cpufreq: amd-pstate: implement suspend and resume callbacks")

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8c72f95ac315..fda66a206d26 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1209,10 +1209,8 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 
 	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
 
-	if (cppc_state == AMD_PSTATE_ACTIVE) {
-		amd_pstate_epp_reenable(policy->cpu, cpudata);
-		cpudata->suspended = false;
-	}
+	amd_pstate_epp_reenable(policy->cpu, cpudata);
+	cpudata->suspended = false;
 
 	return 0;
 }
@@ -1255,8 +1253,7 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	if (cpudata->suspended)
 		return 0;
 
-	if (cppc_state == AMD_PSTATE_ACTIVE)
-		amd_pstate_epp_offline(policy);
+	amd_pstate_epp_offline(policy);
 
 	return 0;
 }
@@ -1273,10 +1270,6 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 	int ret;
 
-	/* avoid suspending when EPP is not enabled */
-	if (cppc_state != AMD_PSTATE_ACTIVE)
-		return 0;
-
 	/* set this flag to avoid setting core offline*/
 	cpudata->suspended = true;
 
-- 
2.34.1

