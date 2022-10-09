Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF725F89EE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiJIHLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJIHLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:11:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5396E95BE;
        Sun,  9 Oct 2022 00:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUeDUjPFT8GvtmQtEBDXxa/1JHaKvniWIB7FN56zLIZ3pu2RLot5VWGE1ZjjYTd1MZGFZJwFruLf4GAgKUpTgm5FEenmo5AFjvpezmImuqd1VkxKHWKHeidfP1m4U3+oCZt7joN2VEXGJUUBrt5tzZYqMgm8e9nv8IcZek7qvixirUhsGJ/laLG2HRiMuW5wAqInqfZNSnSWklMjGTxBPmUi3iSMcPCO5xJM2MQGKsrTnvJ6PHK0K7lJj8Te5MU6IKyqdAAofZFxH6eXsiDXkv/iqRBh9A8Po8mSOmYlfPCPCxm+sJt/pp4QjZg9uO2Ka+ZPlCuRF226/BHYv7DYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqlCWw7oz/MsSLARugtCt+Q5U57P8YdPwEm8C2mIUVg=;
 b=Z7N8I4IaJHIR0hyw2nuZdQDzQomyhnWujGqB0+HYu49/v+9TYqO1nQg7uVbqdT1iXrbKahqEkVgSnlnyyl9NMntFbl3vmKWfPzvzQWf21rVWhia1YAY43Gr3at6mUgPLJOccZVZZEeYUVC8Xl4q1eUpeWg3fg0NV2J8ANPxMAFk/B77CV/A3JosOqD8m4ZCN55h/pVHNUyYixJ0xnOZjbnl1HD+kvNeHUkc4JOdrBusutO+BRln3g7PAGpiFkDrCtEPppY5tN+Ck4CjDZzWe4Z8wXiVdk5okWWl8rPcRod+QUEomlxTimxYxkJ8d5gRZfZbYxD0pBDX2JPPwblxaZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqlCWw7oz/MsSLARugtCt+Q5U57P8YdPwEm8C2mIUVg=;
 b=4c6rpB2jzKma9Ds1IsndDxi9BJZR71jA4zGFzzYsVavZ5ie/bQUhUEwqf76Hc2Se0S4QFznBw1Vbdb+wdDet9ns2w23wyTEfq5qk34IliLyUPJaiDzNk37Hq2/y8hte0GpG/FBtfAi9u+t2x3gkNf2I7ewpGap+VYiS5ZlFGOLU=
Received: from DM6PR03CA0077.namprd03.prod.outlook.com (2603:10b6:5:333::10)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sun, 9 Oct
 2022 07:11:25 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::8b) by DM6PR03CA0077.outlook.office365.com
 (2603:10b6:5:333::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Sun, 9 Oct 2022 07:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Sun, 9 Oct 2022 07:11:25 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 9 Oct 2022 02:11:07 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 1/9] ACPI: CPPC: Add AMD pstate energy performance preference cppc control
Date:   Sun, 9 Oct 2022 15:10:25 +0800
Message-ID: <20221009071033.21170-2-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221009071033.21170-1-Perry.Yuan@amd.com>
References: <20221009071033.21170-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b150c31-2339-4075-27ed-08daa9c57a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIqa5QQ67E08LspUkaY3A5y9nmvqNbgH2rmiPzQV5zcVtmpq4UMyqg2msRHlod3SpaJqIEoeQj53rsB44FBBnyoxLS21RjxBeB59jJJ9vPr6mg+kpox8heVWAEPgNuOpsi7xiB0tvqUobX1pUSpG0D12bQGqXn9NtYSwdP7gszm6Ton71wrWzqcbkCMMwkBiZ/F7U/m54BSc/se1wMPuqljU01SThaCswXBYwj3iAfzFLyYk/ULfEcB00sE0G8MsKXVIZSvGILiCC5Zshpe/OrtN2wg9mSxpckij5zIdCXTCyNyHCHEZsCfhp1Tcyb73xteMnaypK1cFFpxtqEIixR5jZllMh8DTuJ4ivFb1LAviBIAYFNn0KCwP2J7Amjc7R6gT7DEtGlwQIbZMEqrvKgytTZfdEshEreAf/p06Jv4j6aao5vgwmnAze8KjAMUZ9xv1WmmB0STB1PolYG0nK5ATIB9bxxpUMd8IccmNGTx2tqhmbn6ipZAWv8/Ifmj1XrCpjUnaVjGM1yjFEai1mfFXIBa+jg2wUI1ndodXk/1P7vrRF8hUHRcweytVmwTFPRwJq0ZDod9odShj7VAdtyXmMZyYyChoajghYsIb6PCsoObBDwsMo2fvsIEN2WOn/k8CigLeW7GDComMKLdcoOhqj8v1lmtVg67kqhj8zYZCXU2K3+yf/zzl5hh4gMdI6oczmkVf4I6NaIK3eAKpIgkMX3hnQQhBOmsb54dv+QfKjob8RCZCMAcyJOFE2fG7w25Y2rcUrSsHnLEJv02BrY48GLqmdO83oLbNhm8P/aqlrHn5x2lBpRCc/Lp0YkzU5w0l+0xWC/FcAP2cpb8lOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(86362001)(40460700003)(36756003)(356005)(82740400003)(110136005)(40480700001)(316002)(54906003)(81166007)(5660300002)(8936002)(8676002)(4326008)(16526019)(70586007)(70206006)(41300700001)(478600001)(2906002)(82310400005)(336012)(47076005)(426003)(83380400001)(7696005)(6666004)(186003)(1076003)(2616005)(26005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 07:11:25.1315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b150c31-2339-4075-27ed-08daa9c57a4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the EPP(Energy Performance Preference) support for the
AMD SoCs without the dedicated CPPC MSR, those SoCs need to add this
cppc acpi functions to update EPP values and desired perf value.

In order to get EPP worked, cppc_get_epp_caps() will query EPP preference
value and cppc_set_epp_perf() will set EPP new value.
Before the EPP works, pstate driver will use cppc_set_auto_epp() to
enable EPP function from firmware firstly.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 128 ++++++++++++++++++++++++++++++++++++++-
 include/acpi/cppc_acpi.h |  17 ++++++
 2 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 093675b1a1ff..b0e7817cb97f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1365,6 +1365,132 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
 
+/**
+ * cppc_get_epp_caps - Get the energy preference register value.
+ * @cpunum: CPU from which to get epp preference level.
+ * @perf_caps: Return address.
+ *
+ * Return: 0 for success, -EIO otherwise.
+ */
+int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
+	struct cpc_register_resource *energy_perf_reg;
+	u64 energy_perf;
+
+	if (!cpc_desc) {
+		pr_warn("No CPC descriptor for CPU:%d\n", cpunum);
+		return -ENODEV;
+	}
+
+	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
+
+	if (!CPC_SUPPORTED(energy_perf_reg))
+		pr_warn("energy perf reg update is unsupported!\n");
+
+	if (CPC_IN_PCC(energy_perf_reg)) {
+		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
+		struct cppc_pcc_data *pcc_ss_data = NULL;
+		int ret = 0;
+
+		if (pcc_ss_id < 0)
+			return -EIO;
+
+		pcc_ss_data = pcc_data[pcc_ss_id];
+
+		down_write(&pcc_ss_data->pcc_lock);
+
+		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0) {
+			cpc_read(cpunum, energy_perf_reg, &energy_perf);
+			perf_caps->energy_perf = energy_perf;
+		} else {
+			ret = -EIO;
+		}
+
+		up_write(&pcc_ss_data->pcc_lock);
+
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_get_epp_caps);
+
+int cppc_set_auto_epp(int cpu, bool enable)
+{
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cpc_register_resource *auto_sel_reg;
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret = -EINVAL;
+
+	if (!cpc_desc) {
+		pr_warn("No CPC descriptor for CPU:%d\n", cpu);
+		return -EINVAL;
+	}
+
+	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
+
+	if (CPC_IN_PCC(auto_sel_reg)) {
+		if (pcc_ss_id < 0)
+			return -EIO;
+
+		ret = cpc_write(cpu, auto_sel_reg, enable);
+		if (ret)
+			return ret;
+
+		pcc_ss_data = pcc_data[pcc_ss_id];
+
+		down_write(&pcc_ss_data->pcc_lock);
+		/* after writing CPC, transfer the ownership of PCC to platform */
+		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
+		up_write(&pcc_ss_data->pcc_lock);
+		return ret;
+	}
+
+	return cpc_write(cpu, auto_sel_reg, enable);
+}
+EXPORT_SYMBOL_GPL(cppc_set_auto_epp);
+
+/*
+ * Set Energy Performance Preference Register value through
+ * Performance Controls Interface
+ */
+int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cpc_register_resource *epp_set_reg;
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret = -EINVAL;
+
+	if (!cpc_desc) {
+		pr_warn("No CPC descriptor for CPU:%d\n", cpu);
+		return -EINVAL;
+	}
+
+	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
+
+	if (CPC_IN_PCC(epp_set_reg)) {
+		if (pcc_ss_id < 0)
+			return -EIO;
+
+		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
+		if (ret)
+			return ret;
+
+		pcc_ss_data = pcc_data[pcc_ss_id];
+
+		down_write(&pcc_ss_data->pcc_lock);
+		/* after writing CPC, transfer the ownership of PCC to platform */
+		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
+		up_write(&pcc_ss_data->pcc_lock);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
+
 /**
  * cppc_set_enable - Set to enable CPPC on the processor by writing the
  * Continuous Performance Control package EnableRegister field.
@@ -1400,7 +1526,7 @@ int cppc_set_enable(int cpu, bool enable)
 		pcc_ss_data = pcc_data[pcc_ss_id];
 
 		down_write(&pcc_ss_data->pcc_lock);
-		/* after writing CPC, transfer the ownership of PCC to platfrom */
+		/* after writing CPC, transfer the ownership of PCC to platform */
 		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
 		up_write(&pcc_ss_data->pcc_lock);
 		return ret;
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index c5614444031f..10d91aeedaca 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -108,12 +108,14 @@ struct cppc_perf_caps {
 	u32 lowest_nonlinear_perf;
 	u32 lowest_freq;
 	u32 nominal_freq;
+	u32 energy_perf;
 };
 
 struct cppc_perf_ctrls {
 	u32 max_perf;
 	u32 min_perf;
 	u32 desired_perf;
+	u32 energy_perf;
 };
 
 struct cppc_perf_fb_ctrs {
@@ -149,6 +151,9 @@ extern bool cpc_ffh_supported(void);
 extern bool cpc_supported_by_cpu(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
+extern int cppc_set_auto_epp(int cpu, bool enable);
+extern int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps);
+extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
@@ -202,6 +207,18 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 {
 	return -ENOTSUPP;
 }
+static inline int cppc_set_auto_epp(int cpu, bool enable)
+{
+	return -ENOTSUPP;
+}
+static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	return -ENOTSUPP;
+}
+static inline int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)
+{
+	return -ENOTSUPP;
+}
 #endif /* !CONFIG_ACPI_CPPC_LIB */
 
 #endif /* _CPPC_ACPI_H*/
-- 
2.34.1

