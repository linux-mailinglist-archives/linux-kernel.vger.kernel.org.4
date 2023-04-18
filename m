Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529DE6E6000
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjDRLgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjDRLgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:36:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0B49DB;
        Tue, 18 Apr 2023 04:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGqeI3Tkak1vucWq3OxDxA+OJSoKJq4oxzbybBP+RWW+8OYBCOeelD6zhHiOKSZikRHhemJpgCZQEQUPID6Vz4Dxc4RTbGPMI+3rbbG+fzr/CNV4IgTEgz/b4RlzpUPq/hCl7AEGfn/uAOWA0X36BiZjvXZEAt4s/goHkoy9LcSqvBGIGwBwQgyGgF5/e+jbfmzJkxqCkXy9Z414VosMPaOmdnsozMa7+d+tF+tfQQ281YE7zA+e4sme4PhQPcL4WZteuW2HggS++jyN0uwTLS7uWoCU5gAHiAbb/zmxtwArPPq7HEBk36Dc/mcZzadDpqyV8HPCyO9QgAOxaaL3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUt+6/5XC1OaGh7iuH+Z/LJrw1UWkzVE+H6FlLwW0qM=;
 b=d6ophGo0qBZMOGTjZ4HN8e+oPTATAbKEFkCagPHNsNlkEPRhc9wDjdLTHrW7UNe/h5utnf9eBB0fJ7wIWgPcZm2l68dfSoJkthUGYZcok9OZ/UB/r5OCSW3iSVf4/A+RZ1EUVZZzOLX/ww2ezK/hxEMFLs3uxTeiQeIJevuF/2soDSk+87FaQ1ppgErcMi/Lq15YtJemhiaHvGLitCokRezrR27LmUZWX/nsyi0fp8sggy484NQ+2RrskC5xK2FBH9E/anzxnp1tlKooeBsFHHXxp8BoF7/UlPK9HmVo26siBf28dNpenauUseGxdb5HUVofO1GSCeDjyelBWy1UIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUt+6/5XC1OaGh7iuH+Z/LJrw1UWkzVE+H6FlLwW0qM=;
 b=fMSo8o/B7PGSC5yo1eNmmxCIFHq+8gtfxJno1y7HGw9oWw8pEeXoYkLrBdIBVG93f3I3TJG2ZfiYMHjXOZYY21nSz3+f7Fbs2kZRcxLB8J/FQDo3V1oBWjmkGI4o47pFMoA7jMNC5dAA1XlGGl8pXE3ObR26JmKWh7S8OKcuGT3KANl2mZvvmqNzxqhV5eMDgquOqH9XrUTZ7q8NJZ8LqnDgoeFKUThaJZnu7MeR/gmr8gmukMAhPIhdGucI8lBgGZ3GYPiOWI5vdd96ENIo20/5GwbXGMGnozIfPX/WnuEf68xFQ1VjIl0CA+GezClPi8EqXeuHnaGrXGgKMVQAnw==
Received: from DM5PR07CA0101.namprd07.prod.outlook.com (2603:10b6:4:ae::30) by
 DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20; Tue, 18 Apr 2023 11:36:23 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::58) by DM5PR07CA0101.outlook.office365.com
 (2603:10b6:4:ae::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Tue, 18 Apr 2023 11:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 11:36:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Apr 2023
 04:36:18 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 18 Apr 2023 04:36:18 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 18 Apr 2023 04:36:13 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <mark.rutland@arm.com>,
        <sudeep.holla@arm.com>, <lpieralisi@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <sdonthineni@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 6/6] cpufreq: CPPC: use wq to read amu counters on target cpu
Date:   Tue, 18 Apr 2023 17:04:59 +0530
Message-ID: <20230418113459.12860-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418113459.12860-1-sumitg@nvidia.com>
References: <20230418113459.12860-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 9409800e-d1b8-4413-9990-08db4001233d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/J4rRkBFY9ugXe3zIplEb2pH+4QT+tdN/F+xAZ75WLxCTJGcl1e3cB7QDMMCXifetWXg5TDltKry2WxECRubPP/GqZ73FpnDefL8WS30AfrDDSHcUcEpIv3LWAwDUyd9+hK3UMcsdWn1kzcOYpaUkq+DcKnreGHJ8I+YWEAr4UGV20XuyWd7tmfqyj267QbL3zgG69UDveeOejK3cDiER5t2cSuyzw92BG70mVap3QvuwAmWq4GGaV8nVxAz9bL2CsdkvX7aXyGy5y8zryw507hu4TJTvgDb/3LO7yHN5od7kv3EowZWofymOhDhiRhwciMS0YvaJyHw8cNhdDKWoCV/IKqx6Q4wNG7VI7EtJZlMETn3QUCNfjEfxbpaIb4AQ82tnktz+5UZLjLTI2WybB3uIzvTj3uVqIanOlw1er4BlMOsB/ASPBcC3uY2gFM+fX46OT0sCuChIi4QtSYBW6Ss6dPwYvqXvdoq4Wv9qyf9P5nQmVJFI1lXimD7yzZYeATmmLZf27vFx5GqgCO22S874tmSm3ltBp7PH8ssVkPiZ3+Lo3h3D4pbFFFIEe/K+EnuG9D9ETEPPstyTjvx4ESfsMeKvz0FV8Phgs5fRcE2mf9LUMfl4W1R247dm5wScBPY9+jAeJ4/wPAoJzBRYMxN+R3T77WFQ5IzM2u4H+YrIPHAAcSivcrmBg8GveyjwlP43w1O7daInQnuGs/hzMagpKYCjwHQWSqG7WTZdV7UOyI897nqgRQ/H052oJ0iOkHWRYBVZ5AAJv7deLZRdZHIEP+ZT5/AM6UnUVv7A4=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(34020700004)(2616005)(36860700001)(40460700003)(478600001)(6666004)(86362001)(82310400005)(26005)(1076003)(107886003)(7696005)(186003)(36756003)(40480700001)(426003)(336012)(41300700001)(82740400003)(356005)(7636003)(54906003)(8936002)(8676002)(47076005)(110136005)(316002)(70586007)(70206006)(83380400001)(4326008)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 11:36:23.2191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9409800e-d1b8-4413-9990-08db4001233d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM cores which implement the Activity Monitor Unit (AMU)
use Functional Fixed Hardware (FFH) to map AMU counters to
Delivered_Counter and Reference_Counter registers. Each
sysreg is read separately with a smp_call_function_single
call. So, total four IPI's are used, one per register.
Due to this, the AMU's core counter and constant counter
sampling can happen at a non-consistent time interval if
an IPI is handled late. This results in unstable frequency
value from "cpuinfo_cur_req" node sometimes. To fix, queue
work on target CPU to read all counters synchronously in
sequence. This helps to remove the inter-IPI latency and
make sure that both the counters are sampled at a close
time interval.
Without this change we observed that the re-generated value
of CPU Frequency from AMU counters sometimes deviates by
~25% as the counters are read at non-determenistic time.
Currently, kept the change specific to Tegra241. It can be
applied to other SoC's having AMU if same issue is observed.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 53 +++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 5e6a132a525e..52b93ac6225e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -46,6 +46,8 @@ static bool boost_supported;
 /* default 2usec delay between sampling */
 static unsigned int sampling_delay_us = 2;
 
+static bool get_rate_use_wq;
+
 static void cppc_check_hisi_workaround(void);
 static void cppc_nvidia_workaround(void);
 
@@ -99,6 +101,12 @@ struct cppc_freq_invariance {
 static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
 static struct kthread_worker *kworker_fie;
 
+struct feedback_ctrs {
+	u32 cpu;
+	struct cppc_perf_fb_ctrs fb_ctrs_t0;
+	struct cppc_perf_fb_ctrs fb_ctrs_t1;
+};
+
 static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
 static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
@@ -851,28 +859,44 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 	return (reference_perf * delta_delivered) / delta_reference;
 }
 
+static int cppc_get_perf_ctrs_sync(void *fb_ctrs)
+{
+	struct feedback_ctrs *ctrs = fb_ctrs;
+	int ret;
+
+	ret = cppc_get_perf_ctrs(ctrs->cpu, &(ctrs->fb_ctrs_t0));
+	if (ret)
+		return ret;
+
+	udelay(sampling_delay_us);
+
+	ret = cppc_get_perf_ctrs(ctrs->cpu, &(ctrs->fb_ctrs_t1));
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
 static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct feedback_ctrs fb_ctrs = {0};
 	u64 delivered_perf;
 	int ret;
 
 	cpufreq_cpu_put(policy);
+	fb_ctrs.cpu = cpu;
 
-	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
-	if (ret)
-		return ret;
-
-	udelay(sampling_delay_us);
-
-	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
+	if (get_rate_use_wq)
+		ret = smp_call_on_cpu(cpu, cppc_get_perf_ctrs_sync, &fb_ctrs, false);
+	else
+		ret = cppc_get_perf_ctrs_sync(&fb_ctrs);
 	if (ret)
 		return ret;
 
-	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
-					       &fb_ctrs_t1);
+	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &(fb_ctrs.fb_ctrs_t0),
+					       &(fb_ctrs.fb_ctrs_t1));
 
 	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
 }
@@ -953,7 +977,16 @@ static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
 
 static void cppc_nvidia_workaround(void)
 {
+	int cpu;
+
 	sampling_delay_us = 25;
+
+#ifdef CONFIG_ARM64_AMU_EXTN
+	cpu = get_cpu_with_amu_feat();
+
+	if (cpu < nr_cpu_ids)
+		get_rate_use_wq = true;
+#endif
 }
 
 static void cppc_check_hisi_workaround(void)
-- 
2.17.1

