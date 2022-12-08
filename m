Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC8E646E42
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLHLTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiLHLTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:19:18 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D58848419;
        Thu,  8 Dec 2022 03:19:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAdVP5VQz/lHd4Io3cUi+1a9mgzocDFqwHonfqb5ONToRZx7oTjGpHqFmO+vaSbpMJcCfs8KrczTI3L4xtyPiB66bv4CyViXAqFnPWzLgOZie1/1S16XeFw7bT1sRYkrqDmXOpR5Vy28HbGhn6yCXwVpo2jAFNBIxnvnwq/JCB1SYqzkpyxuXtRdaerFce8eqWfubLaYKyi0pCjvs+2hlWPxuOKScGRDc6a2tHhrG8TwsNXm3jX5V6eYuxMtvuaWCpUYv4YMbmgu8mtd+tzhwNMpbB1OWd393i6YMF00DO0IheRvPgGgyLffWiu7XrlJ2t5nrc/VjjVN3k4Yc2No0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMaMqujGg/ZWCEQWl3lRYrDw2txqmH8EZFKrR4sMAiA=;
 b=P0jVbCF8PR8JM5nGxjFnQVBCfgWPlPgP4tgCH81GUUor750+YAOCbHLMa467D+QZvAXV2gDRfRA/8j0Hj5HOQrFtvbPMq9KFXUtAFJJu00lbITMRUa6SMaP2jtntzzNcpB39LosHsSkTkqQmKHzaKtrZAw60guJCwpBuqnlqKOa9Ukvrlap0KRZoxSbSP4XzMrF8kS4TBymwYrb0fl5Bq9/r5d4xzrFJZIowDpLG17ldlg1rn8OXsd+dGbymqTpnXNCYq47T9FJR9xXGjrLzpngHu1I+scKxaV9wDZHCvHKHvKK3A1wxzNrXxksEllAZTzDTfLoFaqnjFtwuX+0A2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMaMqujGg/ZWCEQWl3lRYrDw2txqmH8EZFKrR4sMAiA=;
 b=pR3zvu76BkMffqRl8iVRQV6lS4PpyAhpX3+ooRdfMi5h4+n7RSs19RUnCt7azVMYj6oT3q4iTAFJPIhtSo3p1uu57dSJDZEd1cusxRxms0bBT9W2R82ypv/g2oSF10bMnBACL7HmtGavdUMWaW5nlcZhVkk9gxeAqKWgsc23aTw=
Received: from DM6PR06CA0027.namprd06.prod.outlook.com (2603:10b6:5:120::40)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 11:19:14 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::d9) by DM6PR06CA0027.outlook.office365.com
 (2603:10b6:5:120::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 11:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 11:19:14 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 05:19:10 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 01/13] ACPI: CPPC: Add AMD pstate energy performance preference cppc control
Date:   Thu, 8 Dec 2022 19:18:40 +0800
Message-ID: <20221208111852.386731-2-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208111852.386731-1-perry.yuan@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 185e505e-ef63-45b8-0fdc-08dad90e09ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzVfe2E32pLfdy+FioQdUHIsEaBzXsr9emSQsqV2hMnhvJ4+vyJETnhNGjdVgYhFt1ErQ1dAVQ9RXSgZ8z3rjQ5Ay/cHq+Ot9XB/mbGrxKHCZAZ/U9J1tDX/l3dgme8uaeZbvqdO0CAE8QUOiR4eNMFhtDG+c3OCn2TKRC3UL6JUaNLBKQWVpYu0VFXudzAM3UIItLY8E/tactuM4c1oR1HlXyp6XRY8YXAJIuVs6ois6KvIst0UUuVg0WexXSbKFLm5DiAkM7TyZTXUT4ezaXtd1V4MxW3Fe245ZsmhsJHmPK+nkaYd4FYbNieEeOtvudjjbs+1T9Op50MVAbzxw9iNGMjpTzSMbgrLXRgowDFYOWzZ7jzkwYoJ05thTnAkXYDUu+sxZFAEV9blp7rAIoy4z/DAH2qUP4L913rrLyf5/+OrEuFTIHDFvsApcBgdyqXdM+5fxvSNQNw081MXN1v8Al1CpHG6PWUSKePG4FEcaCbs9njXr0rrN/lrZLzOLdHqFK6MZycKW1X/6cBktdexj7enKbmDXoUcDMNxsfI5DzcnpPm/yh/3ZuN7jUupTzZzNczfuBoF+rZddpWO17BDJQQ0yqoO3FinHBaapAYAL38ReuQpVpbdl1tyS9AJALPbuWGlG96BhsYLjY23IDyHkJlIbiBIy+mD6vumv4OM9HVt+btmE7HDedsTQUqp2kEDFY3SAXkyBK6AkvYlqxOnl30C/6pHkhIkNzpOpOM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(8936002)(70586007)(70206006)(5660300002)(44832011)(8676002)(4326008)(41300700001)(110136005)(478600001)(356005)(81166007)(36756003)(40460700003)(54906003)(316002)(2906002)(86362001)(40480700001)(2616005)(7696005)(1076003)(6666004)(16526019)(336012)(186003)(26005)(83380400001)(82740400003)(426003)(47076005)(82310400005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:19:14.4800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 185e505e-ef63-45b8-0fdc-08dad90e09ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
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

Add support for setting and querying EPP preferences to the generic
CPPC driver.  This enables downstream drivers such as amd-pstate to discover
and use these values

Downstream drivers that want to use the new symbols cppc_get_epp_caps
and cppc_set_epp_perf for querying and setting EPP preferences will need
to call cppc_set_auto_epp to enable the EPP function first.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 114 +++++++++++++++++++++++++++++++++++++--
 include/acpi/cppc_acpi.h |  12 +++++
 2 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 093675b1a1ff..37fa75f25f62 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1093,6 +1093,9 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *reg;
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret = -EINVAL;
 
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
@@ -1102,10 +1105,6 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
 	if (CPC_IN_PCC(reg)) {
-		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
-		struct cppc_pcc_data *pcc_ss_data = NULL;
-		int ret = 0;
-
 		if (pcc_ss_id < 0)
 			return -EIO;
 
@@ -1125,7 +1124,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 
 	cpc_read(cpunum, reg, perf);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -1365,6 +1364,111 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
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
+		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
+		return -ENODEV;
+	}
+
+	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
+
+	if (!CPC_SUPPORTED(energy_perf_reg))
+		pr_warn_once("energy perf reg update is unsupported!\n");
+
+	if (CPC_IN_PCC(energy_perf_reg)) {
+		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
+		struct cppc_pcc_data *pcc_ss_data = NULL;
+		int ret = 0;
+
+		if (pcc_ss_id < 0)
+			return -ENODEV;
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
+/*
+ * Set Energy Performance Preference Register value through
+ * Performance Controls Interface
+ */
+int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
+{
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cpc_register_resource *epp_set_reg;
+	struct cpc_register_resource *auto_sel_reg;
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret = -EINVAL;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -ENODEV;
+	}
+
+	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
+	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
+
+	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
+		if (pcc_ss_id < 0) {
+			pr_debug("Invalid pcc_ss_id\n");
+			return -ENODEV;
+		}
+
+		if (CPC_SUPPORTED(auto_sel_reg)) {
+			ret = cpc_write(cpu, auto_sel_reg, enable);
+			if (ret)
+				return ret;
+		}
+
+		if (CPC_SUPPORTED(epp_set_reg)) {
+			ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
+			if (ret)
+				return ret;
+		}
+
+		pcc_ss_data = pcc_data[pcc_ss_id];
+
+		down_write(&pcc_ss_data->pcc_lock);
+		/* after writing CPC, transfer the ownership of PCC to platform */
+		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
+		up_write(&pcc_ss_data->pcc_lock);
+	} else {
+		ret = -ENOTSUPP;
+		pr_debug("_CPC in PCC is not supported\n");
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
+
 /**
  * cppc_set_enable - Set to enable CPPC on the processor by writing the
  * Continuous Performance Control package EnableRegister field.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index c5614444031f..a45bb876a19c 100644
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
@@ -149,6 +151,8 @@ extern bool cpc_ffh_supported(void);
 extern bool cpc_supported_by_cpu(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
+extern int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps);
+extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
@@ -202,6 +206,14 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 {
 	return -ENOTSUPP;
 }
+static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
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

