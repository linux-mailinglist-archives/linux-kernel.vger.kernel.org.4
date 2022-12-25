Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54388655DA9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiLYQfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiLYQfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:35:09 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF65060CE;
        Sun, 25 Dec 2022 08:35:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCssbWRzkMGxnQtsYGNMCt8zcWPi0YahcQkIVR1mFPKVVfqzP9vTkKmmvXLCwvsVgE/FO4CvNcQMhPdEp/FgecEW/DsJjmHhVW3gJ/wDhZksNdeqsV12mcVhmZBeOk+0uzd9wDGQ4szaksDB2brYq0wxORmdvXAv6xdekprNWZXfQ5vwpP7TsyFyn/y3Bzv7yBlhUt7X3jt8Mdu1zpDefP9ntmRfaZ/gfN1qDDrpCXC/PqpaQ1kLkUau3TmzeUXX3F8d5HySkrqV2gwIgJ7Jt8aM8LNhvFZ8XLNRxOJWVQeHuvbFfJe0gYSCSiiUc2tCLccI2kV6QYtHKeEB8qwJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afDfwXcCFEv9Mx/n9ckRoywz+YnGkue90BUqP9OfSVI=;
 b=bKva3iR+URcJd4OS6FMvBQDTcZfihM3IKpb4R4qFGk8SAYNW3IYTDejVkid2K8BAWxQ2qo+Su/LFz86fohpxfCxQKrWCoFuS2gWB3XcmH8RSdIRy2YUbHECp06zK3nHoqzpWasdFKp3ho7nM0VNsL014jgCv5cjfwqi1BwLCgf7W4lnfpaQfgNBB4Bx8lcwHCTpPaPfnnc81Ixv/P5bbai89Bu4cZvecEwP4ViyCfscPeklv0TYRhhoZceL709HWU8/5XQo1ZE8cqaW4R8HvXwInQeNYU1+Zy1Ytrg9hprhgx9Ei5YsjQ+aNJAg6kaHfjLSsPY3TEkexzTVe691ACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afDfwXcCFEv9Mx/n9ckRoywz+YnGkue90BUqP9OfSVI=;
 b=wUpAtXt9fOo33bQPqmZ8/DU+tViAU0S74oH1XGM8xeaDhoV3VtmBndxQx0PsjEmQfC7jgcTimWX5yTDJIyMgZotgd/vyFh0Gx7CDA2sAm6UqZ+XuuqEnvgxk1EBOyqJ39ufg+gXD02sZPPy8tQyfQmPjWN42yEtDRi7ozebo8ZQ=
Received: from MW4PR04CA0303.namprd04.prod.outlook.com (2603:10b6:303:82::8)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Sun, 25 Dec
 2022 16:35:04 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::37) by MW4PR04CA0303.outlook.office365.com
 (2603:10b6:303:82::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16 via Frontend
 Transport; Sun, 25 Dec 2022 16:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.16 via Frontend Transport; Sun, 25 Dec 2022 16:35:04 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 25 Dec 2022 10:35:00 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 01/13] ACPI: CPPC: Add AMD pstate energy performance preference cppc control
Date:   Mon, 26 Dec 2022 00:34:30 +0800
Message-ID: <20221225163442.2205660-2-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225163442.2205660-1-perry.yuan@amd.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: c76a7c19-bf5d-4389-750c-08dae695f9ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMbr7AyTQC2uazF1cw6OsF0ahLCYCX3OT21LiduUS8safdnd855NxTgIwz2WkNiphe3av4NoGnddkcTKf7HkwVsbpbtPVjfdZsZPX3H1E3RhnBBMd4lL6BBNQVT0/h1YMFgWrpkCD/rMnasQURWX49qqwWji8qq9td+44GwvYONj7tz4e9znu2+Kp7avdUc2wgiO3b0yD/aLkiF6fD9ApRv4ic/mncl5RJrY4AKz216OWRXcrue9sep6jpIF6MBVcZiiJtUInPoyMYS8WUM5a033V9vU3bEr4YeQsIUwze/nFfUbM3dSh/R1p3+5jIH0KCxdpXIJbb/AX4JggULwS3C0rNU1tTq7cufc5rvro+xnlOnv8bQ17QJDhQyBSWd3Il5uDG1vB4fGCqrvfXGFWYxH9RlivPI/1SQM2caNKE1fyetAlxg3jRsAMFcqSTp7kxmsgjRuXHVnxK4XqgW3lmHP6d+VxfKaX9H8jgsUDWCzGOeTw3K9Hz3EV17RmOce93p9XFp38Ls70lxqYaVIxf59EqS7rYPxFrRJgRumpaast4ZWLiXeEqAf7+wdbqvu/lgVDcnbQqTzd/rjfXnTSwkLZMdJ0nP8gqyWx55oy1IdeLor9yOxtZddwlGEFmx8IOtQhwfKAF4tvwFeAFfca+Xr2m4HPIw0ZEeoK8M3lALIAzXlPA6MvlGUthL4ruF376wMUsbSixq14kfZiP/gDh/GbEnS+5ZoKu/Oh8iEVig=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(478600001)(6666004)(2906002)(54906003)(110136005)(316002)(36756003)(36860700001)(82310400005)(83380400001)(81166007)(82740400003)(356005)(40460700003)(1076003)(2616005)(26005)(336012)(186003)(7696005)(16526019)(40480700001)(47076005)(86362001)(426003)(4326008)(8936002)(8676002)(44832011)(70586007)(70206006)(5660300002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 16:35:04.2322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c76a7c19-bf5d-4389-750c-08dae695f9ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623
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
and use these values.

Downstream drivers that want to use the new symbols cppc_get_epp_caps
and cppc_set_epp_perf for querying and setting EPP preferences will need
to call cppc_set_epp_perf to enable the EPP function firstly.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 67 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h | 12 +++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 093675b1a1ff..0ce6c55a76ca 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1153,6 +1153,19 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
 	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
 }
 
+/**
+ * cppc_get_epp_perf - Get the epp register value.
+ * @cpunum: CPU from which to get epp preference value.
+ * @epp_perf: Return address.
+ *
+ * Return: 0 for success, -EIO otherwise.
+ */
+int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
+{
+	return cppc_get_perf(cpunum, ENERGY_PERF, epp_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
+
 /**
  * cppc_get_perf_caps - Get a CPU's performance capabilities.
  * @cpunum: CPU from which to get capabilities info.
@@ -1365,6 +1378,60 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
 
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
+	int ret;
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
+			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
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
index c5614444031f..6b487a5bd638 100644
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
+extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
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
+static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
+{
+	return -ENOTSUPP;
+}
 #endif /* !CONFIG_ACPI_CPPC_LIB */
 
 #endif /* _CPPC_ACPI_H*/
-- 
2.34.1

