Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A02C62D3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbiKQHUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239241AbiKQHTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:19:54 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0334570190;
        Wed, 16 Nov 2022 23:19:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOJqiQIpvDZpCpmPX314C9v6EQ7lYIuwayh9v/9p1LFkmlxACa4Q3xpc3Q2McPUGVxTvEFzjHEouOlQBF/LZBxsNFyhmElO4Gu0RZCgmu4XTLJ3I+8opOxM9YSIKKEuNYpV+GbeYxObQodmc38+G/kkZJ287X24muxRccZwjAv5qB2QXLuJhG7vfXFaWbFIYmV2Nu88+0XN/GzDTf0DZESrqeu6jUk+BZuxtPQRQPFZSj+nSIgbUec5NGh78M4TbUJkywJaMbxu5BO9X6i16zANp7OINV5nP/ZkBmi6Sx7RAJH6oX6l4mXwP+uOtskb6713t7lucVZrM6ZbSCrStLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mzj+G/NDUgm12qniFY4iwEXGr4N39aX24gxB9mTyF2k=;
 b=W3Wdbncu/pVLTDp4MV3ODJ6TfGcE/9H8F1zLzwjTZ44fiV4s4t/m1hKhI67PyRiuDXShgYQ4dW+x0Ffojt1mpyYDSiCGR3ShDe6WGyn46jdq4a6fHbJziUw7EvAS2nUqQpStnPB8o+p/H1vdRmfynF0v5T0WQoFH6GLJ4GJ0dPwgJMQrPh9JQTJmtOJA2Z4qYJXUk/D9AB8EVI5DvLA2L7T8NqOSjN4hO+0aqjuFNniqgeXzg493/OwlI2YqzEWFnNZ+QnLLfPNDKwzWzYhQcVXev7Yv4FHWpjVARiMjt0TxPJig6h13ZrOds4/xcvCOAjKeMEyO7TAqgHcwvdSrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mzj+G/NDUgm12qniFY4iwEXGr4N39aX24gxB9mTyF2k=;
 b=1AS3IcZRkiOS2yMax/Xxxd6lkULZcJZ9204b1LK2ktQ9ra22+18MsVp89TWnjul+H/kS0ek9cleOrTC4sIG77Ac0MAvlrE8YXUpVoykYWnsjssp2GbWxkYTkxo5JozRLDXRN5ZuAUFUWWOv4Ef55sruUuVqwdHYwM7ZIlZY8R4k=
Received: from MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 07:19:46 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::18) by MW4PR04CA0302.outlook.office365.com
 (2603:10b6:303:82::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 07:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 07:19:45 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 17 Nov 2022 01:19:40 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 3/5] cpufreq: amd-pstate: add amd-pstate driver parameter for mode selection
Date:   Thu, 17 Nov 2022 15:19:08 +0800
Message-ID: <20221117071910.3347052-4-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117071910.3347052-1-Perry.Yuan@amd.com>
References: <20221117071910.3347052-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a04cd5-b4cf-4dc0-18cd-08dac86c1ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLV7zbbGYcw1s/Ldq3kgQBtpPSOlZzo8DgMug0rB+h//5psmzRQNzqITn2ql2BNK59G+7/lYKROJPzvONPQb7d3ZNY+uwuKJq9zO5Opnn35U17lixRT//u4mE6Oh0NbP9UvSD+u2Nf6rqtS9gH8yKekGjAnhD4Q8AkbyvrTASpHs2xSRENgLYmwRGkETXySpwP7ARpEfA4JKkh8clfFgQ9gIcB7Y8CG19m6+BGZM1x2Hmilh1ouCwf7vsT1W4c1wU4IpqpiDDJvbl7yLHOZYxY/lp6PICCUXphmnajG6NbpJe/okrwvYaU5XWjZ8fco2QRXS9gkhLzL+LbLOb8VOZZnSjNwCgN7TZ/QX85glsD0cRC0OYvr3a5i2zMvTvo7xMCqyU5qg7VEEm5XNRNQwwlQ5Uai4SVt11eEeSJavxZ6gA2cmqhTNNt4lFiPvU+JO65tAleKpEF4DhSu4Yk49WfkYA3g3QX+z+5mQIb+/onWRLGFewDK3GtgqUp9vnEFVzcALdLAaPeFIqLGCXal9/tN2DI27Wznf2muXepteK0pW/DXpkP1+e0YI8/z9qqwpbSzR4m5ljWGrvL3+oHAVkoqpOu5hdBM951Qn08ODT70yMva2y3C2coI3HxX23nAM+3MiTi6cO+kqKeW5+7iszU8vvoSCMW6ftej5BppYmr60qPKgiLmNi8iNBQCshus7VDN1V9nyHpjbOuUcMER3Ycivts7JZGpnGPg7xzjrL8mttC/kllrW2LAmgxsq0v1Z
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(26005)(186003)(86362001)(81166007)(36860700001)(356005)(82740400003)(82310400005)(83380400001)(2616005)(40460700003)(336012)(16526019)(1076003)(426003)(47076005)(110136005)(2906002)(5660300002)(7696005)(6666004)(8936002)(478600001)(41300700001)(40480700001)(6636002)(54906003)(70586007)(316002)(70206006)(4326008)(8676002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:19:45.4858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a04cd5-b4cf-4dc0-18cd-08dac86c1ab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617
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

