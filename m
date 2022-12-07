Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5CE645DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiLGPsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLGPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:48:11 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD819EE2B;
        Wed,  7 Dec 2022 07:48:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+xkajY2OwzUlfLsX6rKtUwxctYOEZh2pgxV/1xuWTbUFJmJuT3ZH0E3yh9uEqWbmtPubjB70HnvViO0rTEj8eqMe8HkJla8dmKqhsX4K1MNxuobe4L1IQGOTTTWHiWWiMF9oMkBmlxNJRMLAR6pBkPGD733vMgVV8SfsEuvNrKD6tS3Y0xSCX40GJ0xVMvNNJau9jDwvvAXgJhbpx895jq7YNZoAffl0tJWyvC1eYbe0eh0KnacotFBQWlv95aFmoCp+oj3jbQC+aeM/jvspc0P2AQ3ot3B/IAphaDqTYXYJMttuGl7zI/5bUAFci8SRxYLu36h76zenU5g87HXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZWt16zS7ZLt5Ossyk+ffd6aaDDEXhtOhIs4OjbDz4Y=;
 b=YD3NpgcJY57C+9ZrABhnyZG1fZ4KOO9SD7Qt9VHDFf+Dh8QQISRaQ/FU53fgPurBsq0KQfVYBpV/cSFTzIHD2eAZrsyS+ImPTtWCuhV2cPPM2pRJe/f62COuk57o9SMYtX3cbZszx5g9w5WAbu5oWK6fBqF2Bmge+qj1sPE+ALe9e5GZzLRlECbJaQtXcszbkkAb8EE9RrjyK65od5XYP4QumzumIQ/GPeZ1S2pXQUoBXO1CI6quef1rYjGc/IsMA+XKexHIS4EAbEo2JC4zLT3Gn6ykKDhOaKeps3cj0chkldYIr/M72wk9l2ubRi7ykyP4wGj/P26HNWHMGvuXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZWt16zS7ZLt5Ossyk+ffd6aaDDEXhtOhIs4OjbDz4Y=;
 b=nRqM9lHI9zz437fh52ExRQtDpPDmVd2xCE5kOd91E83tEf/KGBWPa2hmcdLlQA8RE7kPXDObfNza4Lkg+hmloP/PFhk7+AtVM/63xId59CLEnn5KDoNmdDdN6OsCL/yActRP6yNqRyUlBxp4wemKu8Nl5gpX+q5ZT7utx+YpNwc=
Received: from BN9PR03CA0275.namprd03.prod.outlook.com (2603:10b6:408:f5::10)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 15:48:07 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::4a) by BN9PR03CA0275.outlook.office365.com
 (2603:10b6:408:f5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 15:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.15 via Frontend Transport; Wed, 7 Dec 2022 15:48:07 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 09:48:03 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>, Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 1/4] cpufreq: amd_pstate: Add guided autonomous mode
Date:   Wed, 7 Dec 2022 15:46:45 +0000
Message-ID: <20221207154648.233759-2-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207154648.233759-1-wyes.karny@amd.com>
References: <20221207154648.233759-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 55df4688-9673-4cd9-0bc0-08dad86a6f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xX2noqq4W/nG67WvL+E/u/JdDpThN9zv3vYeNairPTCkBuPRUxVhEj749wjCkAZxRDfNhFNXwabHbpbQMhaJVDtnYwX5VP5S7sCE4mDY4Y7qGnMCYqVpwjxbNu3WSnU7Oj4Zrfnndg1P9NtemhcAluxFuMqyEp0cMfi3rmEIes6bUaHyb96PfhEByNd8MNPp6cl16m4rogoUoKoL0iZJt8TPcNagEehbePmLYq7/iEEXXsasKEoTFkCkV1lLDLh/nDw0dWUuhoylIkOZenNnLEHY9pWeCcKpaLW3fJdojVgGqTF3W2FfRjx1huK1hGiYVn0WtuhvbrbeTSaQ7vAS9ZE84bg5w3SYCnjTwZ3ZBMzunEp8ENOyncBKFNrxYukPHasTv0tHNKtLYXPm9A1ouKyg2qBHmmE4pjYZMw7geVGREyXo8DfCwAS1DxjyYOiK5TRrf7OJ1rBk966rgTyfH9NvAhUzWSnjodeRdxPIkKAxad2/q7/jiJ0rPcTXwJBug7LYQ4GLNseQFbL4JaFwZVcY2nJn8oOeCaLK4+y1liau/IkupRgU5qylE7o63UffD06cTyOQMil+01kCTPQAwuXDF/v8a+Qh2jZwyeiXDgfHe6SuTXeplnZTkVIM26GnDSZ/nOmj2iS3bVh419zbB6s+J7NDs9BtSe9Y4vDVOWWsB3g+EA+glybk8Wy8Gpkzxsqs/TgaoCLEg609xdgSa7ZvFQYpRBm0jolkJI9u6Jo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(83380400001)(81166007)(356005)(82740400003)(86362001)(44832011)(2906002)(5660300002)(40460700003)(4326008)(41300700001)(8936002)(82310400005)(8676002)(6666004)(40480700001)(47076005)(26005)(7696005)(426003)(186003)(16526019)(336012)(2616005)(1076003)(110136005)(70586007)(54906003)(316002)(70206006)(478600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 15:48:07.3166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55df4688-9673-4cd9-0bc0-08dad86a6f69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From ACPI spec below 3 modes for CPPC can be defined:
1. Non autonomous: OS scaling governor specifies operating frequency/
   performance level through `Desired Performance` register and PMFW
follows that.
2. Guided autonomous: OS scaling governor specifies min and max
   frequencies/ performance levels through `Minimum Performance` and
`Maximum Performance` register, and PMFW can autonomously select an
operating frequency in this range.
3. Fully autonomous: OS only hints (via EPP) to PMFW for the required
   energy performance preference for the workload and PMFW autonomously
scales the frequency.

Currently (1) is supported by amd_pstate as passive mode, and (3) is
implemented by EPP support. This change is to support (2).

In guided autonomous mode the min_perf is based on the input from the
scaling governor. For example, in case of schedutil this value depends
on the current utilization. And max_perf is set to max capacity.

To activate guided auto mode ``amd_pstate=guided`` command line
parameter has to be passed in the kernel.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 ++
 drivers/cpufreq/amd-pstate.c                  | 60 +++++++++++++++----
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42af9ca0127e..75e57afba77e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6970,3 +6970,7 @@
 			  management firmware translates the requests into actual
 			  hardware states (core frequency, data fabric and memory
 			  clocks etc.)
+			guided
+			  Activate guided autonomous mode. Driver requests minimum
+			  performance and maximum performance and the PMFW autonomously
+			  selects frequencies in this range.
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 204e39006dda..05e4003a77ee 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -50,6 +50,20 @@
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
 
+enum amd_pstate_mode {
+	CPPC_DISABLE = 0,
+	CPPC_PASSIVE,
+	CPPC_GUIDED,
+	CPPC_MODE_MAX,
+};
+
+static const char * const amd_pstate_mode_string[] = {
+	[CPPC_DISABLE]     = "disable",
+	[CPPC_PASSIVE]     = "passive",
+	[CPPC_GUIDED]      = "guided",
+	NULL,
+};
+
 /*
  * TODO: We need more time to fine tune processors with shared memory solution
  * with community together.
@@ -60,7 +74,18 @@
  * module parameter to be able to enable it manually for debugging.
  */
 static struct cpufreq_driver amd_pstate_driver;
-static int cppc_load __initdata;
+static int cppc_state = CPPC_DISABLE;
+
+static inline int get_mode_idx_from_str(const char *str, size_t size)
+{
+	int i = 0;
+
+	for (; i < CPPC_MODE_MAX; ++i) {
+		if (!strncmp(str, amd_pstate_mode_string[i], size))
+			return i;
+	}
+	return -EINVAL;
+}
 
 static inline int pstate_enable(bool enable)
 {
@@ -212,12 +237,18 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 }
 
 static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
-			      u32 des_perf, u32 max_perf, bool fast_switch)
+			      u32 des_perf, u32 max_perf, bool fast_switch, int flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
 
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
+
+	if (cppc_state == CPPC_GUIDED && flags & CPUFREQ_GOV_DYNAMIC_SWITCHING) {
+		min_perf = des_perf;
+		des_perf = 0;
+	}
+
 	value &= ~AMD_CPPC_MIN_PERF(~0L);
 	value |= AMD_CPPC_MIN_PERF(min_perf);
 
@@ -272,7 +303,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 
 	cpufreq_freq_transition_begin(policy, &freqs);
 	amd_pstate_update(cpudata, min_perf, des_perf,
-			  max_perf, false);
+			  max_perf, false, policy->governor->flags);
 	cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
@@ -306,7 +337,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
-	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
+	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
+			policy->governor->flags);
 }
 
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
@@ -627,7 +659,7 @@ static int __init amd_pstate_init(void)
 	 * enable the amd_pstate passive mode driver explicitly
 	 * with amd_pstate=passive in kernel command line
 	 */
-	if (!cppc_load) {
+	if (cppc_state == CPPC_DISABLE) {
 		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");
 		return -ENODEV;
 	}
@@ -670,16 +702,22 @@ device_initcall(amd_pstate_init);
 
 static int __init amd_pstate_param(char *str)
 {
+	int size, mode_idx;
+
 	if (!str)
 		return -EINVAL;
 
-	if (!strcmp(str, "disable")) {
-		cppc_load = 0;
-		pr_info("driver is explicitly disabled\n");
-	} else if (!strcmp(str, "passive"))
-		cppc_load = 1;
+	size = strlen(str);
+	mode_idx = get_mode_idx_from_str(str, size);
 
-	return 0;
+	if (mode_idx >= CPPC_DISABLE && mode_idx < CPPC_MODE_MAX) {
+		cppc_state = mode_idx;
+		if (cppc_state == CPPC_DISABLE)
+			pr_info("driver is explicitly disabled\n");
+		return 0;
+	}
+
+	return -EINVAL;
 }
 early_param("amd_pstate", amd_pstate_param);
 
-- 
2.34.1

