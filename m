Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC9B5FA1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJJQXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJJQXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:23:20 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FE974E24;
        Mon, 10 Oct 2022 09:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlcb0gMyY1Ru3RsR1MWb3paK4aT0UvwJnlhKZZ3D8wHvONy3rV1iPqrVNYVSH6hK6hEPH7CkxHs3wHKcO52ZQeq7x4hmu34mLxa6vXMzaQIyGXKEcwx2lAoU0I7M7fb5kMcexrYQ90S0cLJZdsSdnNOSu4Lalg/IfBIdTu3/YBIfBV2fVyvZFZYMgVRzomLZr26awOgQTHfDMdspZJliWyMSGZ31DkFReFPU6ssaXhAKjcea5X2ydZGn43aG8GoZM1nPiwcCvg2xR1hg5ncZvX6r9o9adb8UwqNkTspi+MMmciOdBNLdIAUOUgWM7gpox75OwBEucv1Hqc4ZgZMAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqlCWw7oz/MsSLARugtCt+Q5U57P8YdPwEm8C2mIUVg=;
 b=mETGVc5DQ5ZiOCYnWFkV/iiNH7COUdBtxWvS5N5iPMbyr2T2lv2wqkX7NtTSd/z/SRC4f7GfDhP+7PX/8qBMMs9S+UrqYNuwtFbBzFIH0sNo5BojN0nwOBS/wP6AVAKhy3GpS1lisE8EQSa1IF1wa5egX3RHqjXxmVqa0erteMeu588lqRgqhVe3njBuM7V5UGAiL9SNcFWv0qfT1ydJuOlBLcBq61E7ZqN3+6WopY5Ph7fH8/f2GOFqhPh7P9kHh8gL1/1Pox2XNh7GxEnNo7eQCHpdxxI6hj3Dxlinxc5QmPisB2CNd7cmO80o0CCgvJTNN0zhmXfJkxNHuiCYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqlCWw7oz/MsSLARugtCt+Q5U57P8YdPwEm8C2mIUVg=;
 b=SabXo6KD6zZXMQ99XEoGaExBlhJmaGMvl9oufBgXAeT5mB5W9KQfPR+pXdD4xM2lYtXBunakXWXfjaHLwnbqqK6/ywKzRQhXh+dwbkc02VAzVAjdh//qbjOtTR41F2Zjv10kmMGuBHnN+eJy1+c0YD50BjjvhjX08AuA9qMN6K0=
Received: from DS7PR03CA0285.namprd03.prod.outlook.com (2603:10b6:5:3ad::20)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 16:23:15 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::d1) by DS7PR03CA0285.outlook.office365.com
 (2603:10b6:5:3ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 16:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 16:23:14 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 10 Oct 2022 11:23:11 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [RESEND PATCH V2 1/9] ACPI: CPPC: Add AMD pstate energy performance preference cppc control
Date:   Tue, 11 Oct 2022 00:22:40 +0800
Message-ID: <20221010162248.348141-2-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010162248.348141-1-Perry.Yuan@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: a2824a51-e343-45ec-82fd-08daaadbbbb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZQVGtP+S+BPdGcgIVO7hwYAXpwIFHE0eyoMb8RYe0hdt2ltm7fHg4PjOr8LXQ/FkFpxFoRZNA7+aP+lcdHwXHmK8zMlGr9WuUtXC1Xpni1Tn1tF4WeAH1vPwxfX2eXw9+m7GGpruXNxDrwEtXMtvPwzbsPWaE/1yFx+q3FjvZ90c1xhtGDboNEzc4AC4XKR1R5A1PwDlqXpqcPaXtHuHPdhZWRwBUvm0g65Js3H2FmSx9k50dG1WFUGFUOdtCVngWU0x8AaATXlfKTkXHYIhtuldoJ+yXT5v+PIQh8GEH/0OzO9zLYIo4SYXeNZoetYEimXw/+uNw+YsBaCSAvp80r2/xObrmVMpVq0gu/hbCk51D6HwNHwOVhtT9oIaFn4j00WysCTF1tRXebDy53CbYQPINDrQLd/5ZECcK12mx5o5EIEAPrL8g2Sk8vlVtWTV/UDqsV5UCf2RdO8e9DAzrro+TeHhKg9nWlbah13wxwnVamRqFJ2ZRHTVIgTwqXJz2Y3tZPGTAp6YcEjsF5fyINioLD5MFFKSN+LhkBx7QCeWH1LDsQ/zNlJFGrG0juEPLfNfcd38NRdBYJ8eIoYAk7n//gyAat5zh9sJwxr5BbdkgM2RTzG+Q0JKiWPZAHLb9bFLP1yNPQXQMwpTjUX11tEMMxBYRkjxrukB6auZky4F891aL0R9PKw7R3MMR/45yD5L3OJGrv42RBlzuCahxBQS8TvRGLA1pNh8eeVH3qdRdHyS6TMqu9H1BeYY0e/fPgzpMz7c2ch6NaqdStwa1DCkWbyNNRbUFGT/hLJdTsFSMifNJ7l276OYNZDYM3Q0r4JPdm3ODSImu2PV7JK2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(356005)(36756003)(40460700003)(81166007)(40480700001)(82740400003)(4326008)(70206006)(70586007)(316002)(86362001)(8676002)(336012)(54906003)(2906002)(41300700001)(8936002)(5660300002)(426003)(110136005)(47076005)(186003)(83380400001)(1076003)(16526019)(2616005)(6666004)(478600001)(82310400005)(7696005)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 16:23:14.9581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2824a51-e343-45ec-82fd-08daaadbbbb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
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

