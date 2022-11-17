Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477F962D437
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbiKQHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbiKQHgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:36:32 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F2A701BC;
        Wed, 16 Nov 2022 23:36:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+Glq64u3s+C+PwJk9nw1y3YgLEb7n8FQCNAjD8RO8sEX4cONIF4Ujoz1tzMZLO6xmseDzeEKuf9KXHkCE35+MuOtsuXRrSRD8OqkscygJMv+HVKcDnav4dMpN5d/qMhaXbK7xrEHgMwST/32Q6IJ+aAcuNALswW3p9Ypt3ntKDPwJJK5i0pQjPF693Qt7slBwrG/WVgPnS/pnghmhflJRM3UcLd+ujL3xE4d7Nye76DBao3UnU6osllk8RkYpjB5Bb/WsmdIMI5OhehbrFPDe7h7wUBN0vflea8nMC0RgfL3ie3dmLbIfBf72ISJp2VC9bJYMwM/6aetX41n6oSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWoabDqgACvi+G0NzdgD0eqnnjqxtqiaKGCwnYaNA3U=;
 b=JCCt0sGLMnQ51d037TBxLhyuPNv3Csew/MzAFvaXWCeRNRkzeqXL2J1YsFOUBVWjC5ifEPTFAaZ0nCL43qp4FCCTAGkG8l4z47wYgpsuoXzcUzcepIbkCUThfdD3GwnfiZkXjthX3A/hsQZrJtMdxFDo+SWDjMaqjNx8OaPQ1o+iuQaySbBd/edmRHliVJ67xDuWOesK6aRO1zXxaTqqEvIjJDv4rGhIXsz5yfI4Y4NKTZYy8Zjwa7Kkce5agTYSipWjPi2c71why4bC6qoPg/Kgr0LlmII+GHDgv1V0AJZYCzFLete+bl7h6jOMgzqCwrCgk4ZPkhMp8nSxbNthqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWoabDqgACvi+G0NzdgD0eqnnjqxtqiaKGCwnYaNA3U=;
 b=NoBFqgLlIy1QfppzqCYe63/70odYiS5yJ4BiWMQUaJyRc1wn9aaBgzqmM/dHt0ihuxx8pK6jHKtrrfVqp/ve6tbC2QB5N14mBw92KOkeaWnEnSKOMNlKI20tWynde6o0sCB9IL7ZmpVrp8HkIE0elYwi3cMK9SnubZs453V0ZIs=
Received: from MW4PR04CA0231.namprd04.prod.outlook.com (2603:10b6:303:87::26)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 07:36:22 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::6a) by MW4PR04CA0231.outlook.office365.com
 (2603:10b6:303:87::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 07:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 07:36:21 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 17 Nov 2022 01:36:17 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 3/5] cpufreq: amd-pstate: add amd-pstate driver parameter for mode selection
Date:   Thu, 17 Nov 2022 15:35:39 +0800
Message-ID: <20221117073541.3350600-4-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117073541.3350600-1-Perry.Yuan@amd.com>
References: <20221117073541.3350600-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|BN9PR12MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b9e77c-ade1-428b-9bbc-08dac86e6c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqKqwaKQjtbb7WNqYbvy15IDAQm/wiWyBsd/r2kStzK6nfON6Fr/ENeMe3EHXofLICt+CyxH7b9wa1EAlGlhrmqlbH7zns5rPK5EsNOr/kUJzQbJXCP0WN+lCJVHKihBt+gHhDYpkESFf/rPHr6TDsorPuaD06vUixzFdHb/8b80p+I+UxgtiBNS+jUwcHWgISmI6lI13Ur53n2pxxKPx9+Xu9h1PY6mmfJwRibZGI4Z63PXsxR/HmDHDE310KmP3/0yTdy5iiQCchkhtyVwrdbwGdab3Ry+DlaHFK4Ap8AlSurWiovWqKuabgipP2LY4pkoQ2O1l6Nc9lTuEFbYJV/ObXGfnoz1F3UHQAbAOKUWT+5dCz97hbD93zOMvD2N0SwWqAxgMsNIQfrPcsNbQjfjioFW7wJUOwR90Jpd41AkhsSyDvqxIAgp9BarLQw51T2Q5BXZSG61nsYkjESngfzwmsukb93gHbsGmGjLl3ilxoVuW2ECxpCA8cQcIBGh0NBdN/rsT4Xgyk26nshDDnRpJtLos4Le6JNShk9EK2pFdcq2rKe+NFUSx3/Evx0T969tO7cX0xcTsFQfn1WUC09VL2MawFB4m2c4vT1wUDRr99WJKDotcBMyhkxN1EW0bZPbav4YNWS2ezq6QXAbsjEs/iCTE19oslq/DeXCOhQmWcNWp1qj8/BWbTuv+ZvWJCdzgdRX+CVPE4PQ1DpjmuSuMksZqASZAFlLzXe3EvF5FBB84WG7fYOt+v7l7AV5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(82740400003)(36756003)(40460700003)(86362001)(316002)(4326008)(70586007)(8676002)(110136005)(70206006)(54906003)(41300700001)(5660300002)(2616005)(6636002)(8936002)(40480700001)(2906002)(356005)(7696005)(6666004)(83380400001)(26005)(36860700001)(81166007)(478600001)(426003)(336012)(1076003)(16526019)(186003)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:36:21.7190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b9e77c-ade1-428b-9bbc-08dac86e6c86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the amd_pstate driver is built-in users still need a method to be
able enable or disable it depending upon their circumstance.
Add support for an early parameter to do this.

There is some performance degradation on a number of ASICs in the
passive mode. This performance issue was originally discovered in
shared memory systems but it has been proven that certain workloads
on MSR systems also suffer performance issues.
Set the amd-pstate driver as disabled by default to temporarily
mitigate the performance problem.

1) with `amd_pstate=disable`, pstate driver will be disabled to load at
kernel booting.

2) with `amd_pstate=passive`, pstate driver will be enabled and loaded as
non-autonomous working mode supported in the low-level power management
firmware.

3) If neither parameter is specified, the driver will be disabled by
default to avoid triggering performance regressions in certain ASICs

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 701f49d6d240..204e39006dda 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -59,12 +59,8 @@
  * we disable it by default to go acpi-cpufreq on these processors and add a
  * module parameter to be able to enable it manually for debugging.
  */
-static bool shared_mem = false;
-module_param(shared_mem, bool, 0444);
-MODULE_PARM_DESC(shared_mem,
-		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
-
 static struct cpufreq_driver amd_pstate_driver;
+static int cppc_load __initdata;
 
 static inline int pstate_enable(bool enable)
 {
@@ -626,6 +622,15 @@ static int __init amd_pstate_init(void)
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return -ENODEV;
+	/*
+	 * by default the pstate driver is disabled to load
+	 * enable the amd_pstate passive mode driver explicitly
+	 * with amd_pstate=passive in kernel command line
+	 */
+	if (!cppc_load) {
+		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");
+		return -ENODEV;
+	}
 
 	if (!acpi_cpc_valid()) {
 		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
@@ -640,13 +645,11 @@ static int __init amd_pstate_init(void)
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
 		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
-	} else if (shared_mem) {
+	} else {
+		pr_debug("AMD CPPC shared memory based functionality is supported\n");
 		static_call_update(amd_pstate_enable, cppc_enable);
 		static_call_update(amd_pstate_init_perf, cppc_init_perf);
 		static_call_update(amd_pstate_update_perf, cppc_update_perf);
-	} else {
-		pr_info("This processor supports shared memory solution, you can enable it with amd_pstate.shared_mem=1\n");
-		return -ENODEV;
 	}
 
 	/* enable amd pstate feature */
@@ -665,6 +668,21 @@ static int __init amd_pstate_init(void)
 }
 device_initcall(amd_pstate_init);
 
+static int __init amd_pstate_param(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "disable")) {
+		cppc_load = 0;
+		pr_info("driver is explicitly disabled\n");
+	} else if (!strcmp(str, "passive"))
+		cppc_load = 1;
+
+	return 0;
+}
+early_param("amd_pstate", amd_pstate_param);
+
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1

