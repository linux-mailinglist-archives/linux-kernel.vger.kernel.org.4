Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FD56E5FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjDRLg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjDRLg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:36:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C960A55AC;
        Tue, 18 Apr 2023 04:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7j80QvTpbCdzEWc1UH+ALqGlvCqJgcqeis5U2QORgcs6ajXdp2aOgjJO9gLTy+ny29b9ksKwDodINCm2kjHKtk4CvmULM188jVNGC2PHImv27oPeAlocVfoXAt8c+17VgnGLL+z3PEheuPvBuoNXRFv7f/3R5hfyqPStASurZxUbBWqvpl4AD/NAvaCJTBVonDWUnmiTk9B8k/JfqloS4DjDbk/RawCUEO1fO16zdRT1XM/0ay7ItpnRM/Jp0EPvrDkGa+BOj7hDX2ePE1ElBRnP4gi62sMMGyJs0Sb9CdYFK1APJBBFJRC9p0Ey0RkYx6o7qkZynbJ2rlKx2gqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ykCwYzo+l/9NAsygK+a1+QKJV6mGzFqPf5shfdBEvo=;
 b=GSniakyKnppGVKgdDYVXA2P73PuUBzlz9Q+WYSJjc3C7Fk6NOSUdFIcrLO5BBCTvqdguNmwec9B3GUDjWgFI9saqyJoej4AY9q8HXmpWeEwsseGF6zoGLaTxaZgx1lZS8nGk8ZO9MqvxsBCEbudFhu5t6uoGot0+C6ng8GEqdjeA1UQfOjp+ox1spznQTnEcXCfTcEmFmtBBMGq7nnWlTt/Nx6tqFL4dK4RQyEa2LBidoeInZKGUKZ0aGB3Fw+NGrx8Hbc0f0/bv6nbfyy20DiOBquze6qsfkGH88Hct+Rsur9pNf7XhBtCUxLBcOm6MeHKHdymB5eTuo7FX4SIw2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ykCwYzo+l/9NAsygK+a1+QKJV6mGzFqPf5shfdBEvo=;
 b=m7uMPR8dYCpUpuv8TP7jP/VHVRI+Eq2OGcnyMhsnEWx7RGXW684EjPqhFrnhqHdhDA74+UrGxi3emcmBcP2VEhE615fcaOC4/UNGdGb+CJ+vyFLi73mrGD+6WUgxkjKJ006BP76Xx6U5tvt9iTyNWOijSj4wnsvzhl6JHUzsBgfEz4tLWNy9T1v6/NbtqVf/DnPgCnPgWj0wDtyq1mmqrBZTUuQbua6F9Ue+rtFDbMjveoEzvRVa5ZeEAzG0fCg8j5dbpFwNSYYSd9A3LrVNvWQTnpp6oPJIq/8nKnXFf8Dwz9XnmUDqB11F9b3CxUZzsFG3vAXTz0iiXBYtSmO47A==
Received: from BN0PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:e5::7)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Tue, 18 Apr
 2023 11:36:09 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::1b) by BN0PR02CA0032.outlook.office365.com
 (2603:10b6:408:e5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Tue, 18 Apr 2023 11:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 11:36:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Apr 2023
 04:36:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 18 Apr 2023 04:35:59 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 18 Apr 2023 04:35:55 -0700
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
Subject: [Patch 4/6] cpufreq: CPPC: update sampling window for Tegra241
Date:   Tue, 18 Apr 2023 17:04:57 +0530
Message-ID: <20230418113459.12860-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418113459.12860-1-sumitg@nvidia.com>
References: <20230418113459.12860-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 54dba8fa-0b4a-42e6-60db-08db40011a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sWLzIF/dyzrTctyvfFqGYEVvgHqq+rU8VXEL/gvNkUDM1zYvB/K5q+WB1048aHyLxX/GFNgnL1jyv2UP1D5S1x86aK0FRWOiCRSYXUR1MSphhTW74Zdxu/PlRR8Z5TdqlwcXt0MBYGCvctR2cDLH3iM95u0jzPHtOWH2ynzk8YsQ0rqvBtLvhDpGuhhZV7K2zul1hKSIH/ZDMlbkrZQUGxThNjG2nSQ0t0Vixv3FuhI3OS3DsKurLSLK60AX++7GmeoIynlpoReE7KeFQf1283+e8Hfnt3Pvh6cyp811sEPFbbtxgVz+uFVFRtbqKT/jR44D5N4mICeoUFjgxfF32SxRwCIT+ZlL57krFthKdt/cFho56QJHlG3H7xu8P0oBpHosMDInAoTCc5xNVJlTzOyJvR1zwkW7DVZqKXwMP/LD5Lt/0oKeBZPb5TGm2QjZLyVv1uqCtt3Er93Ulj6Z8zYv6d/9OyspvBwnir+QocwDoLpP1bZ/A8UK1gvucD/MRh0AIGLfuP1z42AoqKrCUqzlJaNg92hVNXvzJugHw8yhP0ze/rH6wBqAEw1+TKGgg1DrcoUH7eS7YMJ5w+gVfn81v1054465mJCglw1TSXfN8Oaf53wDM9VYJ0kj+pRISJwmgvrb5+l909L+kVXjeiGMGsgOaPX2wC4qIKvqFmUNCMoOBRe6ooe8eH2lIyWwsu9WRIPRhgEhZfUR5DYqjp7oeqiRTEaLbtmqTEuauX3UCp/HXwrdvYB6QP7lrfAOGIEKGOtpTxcwoogSO3B4kHkHLmT/AUu9wEraRQ0i9Mk=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(36756003)(54906003)(110136005)(4326008)(316002)(70586007)(70206006)(478600001)(7696005)(40480700001)(82310400005)(8936002)(8676002)(5660300002)(41300700001)(2906002)(7416002)(82740400003)(34020700004)(356005)(86362001)(7636003)(426003)(336012)(2616005)(1076003)(26005)(107886003)(186003)(40460700003)(36860700001)(47076005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 11:36:08.6037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dba8fa-0b4a-42e6-60db-08db40011a93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Tegra241, the Activity Monitor Unit's (AMU) constant counter
(i.e. reference clock counter) increment happens in bursts and
not incremented in the steps of one. For example reference counter
may increment by '0x20' every '32' periods of ARM periphclk. This
quantization of the reference counter is a source of error when
reconstructing the frequency from the AMU counter data. To fix,
increase the observation time interval so the error percentage
becomes less.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 15c2cbb7a50e..5e6a132a525e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -43,12 +43,17 @@ static LIST_HEAD(cpu_data_list);
 
 static bool boost_supported;
 
+/* default 2usec delay between sampling */
+static unsigned int sampling_delay_us = 2;
+
 static void cppc_check_hisi_workaround(void);
+static void cppc_nvidia_workaround(void);
 
 struct cppc_workaround_oem_info {
 	char oem_id[ACPI_OEM_ID_SIZE + 1];
 	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
 	u32 oem_revision;
+	u32 smcc_soc_id;
 	void (*apply_wa_func)(void);
 };
 
@@ -63,6 +68,10 @@ static struct cppc_workaround_oem_info wa_info[] = {
 		.oem_table_id	= "HIP08   ",
 		.oem_revision	= 0,
 		.apply_wa_func	= cppc_check_hisi_workaround,
+	}, {
+		.oem_id         = "NVIDIA",
+		.smcc_soc_id	= 0x036b0241, /* JEP106 code for NVIDIA T241 chip (036b:0241) */
+		.apply_wa_func	= cppc_nvidia_workaround,
 	}
 };
 
@@ -856,7 +865,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	if (ret)
 		return ret;
 
-	udelay(2); /* 2usec delay between sampling */
+	udelay(sampling_delay_us);
 
 	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
 	if (ret)
@@ -942,6 +951,11 @@ static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
 	return cppc_cpufreq_perf_to_khz(cpu_data, desired_perf);
 }
 
+static void cppc_nvidia_workaround(void)
+{
+	sampling_delay_us = 25;
+}
+
 static void cppc_check_hisi_workaround(void)
 {
 	/* Overwrite the get() callback */
@@ -953,8 +967,21 @@ static void cppc_apply_workarounds(void)
 {
 	struct acpi_table_header *tbl;
 	acpi_status status = AE_OK;
+	s32 soc_id;
 	int i;
 
+#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
+	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
+		if (wa_info[i].smcc_soc_id) {
+			soc_id = arm_smccc_get_soc_id_version();
+			if (wa_info[i].smcc_soc_id == soc_id) {
+				wa_info[i].apply_wa_func();
+				return;
+			}
+		}
+	}
+#endif
+
 	status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
 	if (ACPI_FAILURE(status) || !tbl)
 		return;
-- 
2.17.1

