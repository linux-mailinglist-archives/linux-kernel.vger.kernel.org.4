Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DD763AE75
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiK1RHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiK1RHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:07:39 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9016419031;
        Mon, 28 Nov 2022 09:07:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnF7LJQzs9yMUBieObck5vIkdeyxaQX2HykWP4LKKgm/ZzaGb6sorzo2IU/CUG+W2shw5GL1yySnqDluoC4va+Zspm/ESdJ2PILi4GRVLiE7FUzN9TOtaSgWs6lJeWao45MMdk95rh5/L55bQviTdsdO+KE/URcjoG6Mn2VqT1DFqgarW2WSKu3p+bvEFIAs4Brr+Q2q8j3uzeDFbsfziASBKPzNrqIi+lhfA0xwwk+Dj+ulMDao8oFi/xMba/89CzuwsHRmJQ6y4LQ/Gc5ep/JYrXVetsBR8vRmj+TmyNWj8FT07wOj1KddJ28aiaXRJXmfs84vNzhkWpOHiUtY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvIyw8HFbFtq2U25prPTcw1zbk3kblDPX9Aa4Dr99F4=;
 b=QWrwoY7LwyPWNqF6Z/hpI+h7RZP2uefLdCxPP6pSeeHuYVU0fbjiLmXFGSBMKypT39ChPDAkPfZw0cGVsTe8D4M2ocL5NY+7+CcZu8jYNRNUnHtc7Ts6h6isgQRUmP0p4vZ6o4c3pK3qKftXrmzXyKBxyzik2/TAK2uZ90D1frU+Ig1xM3AnP0LPUgVozP/HmKCJ5RiwtEiJRyYH9StvWd1pyvhEbHcFqHlTtDMuh2qU5pERtLLx+M2TWXNP1AfyQHzeeCpaB11YIiBTk+NApoKUrQtFDKAOD7s8DPVXhSWjFxjT08jjtkdv94mwEMu9DMAAAfalhVAr/df6lR5PaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvIyw8HFbFtq2U25prPTcw1zbk3kblDPX9Aa4Dr99F4=;
 b=x99OxAeo7Rg7yRhCB13wOluNaj/+wobMMvtwjzDHre+SBdSWlNNnsdtjNxDB60O/M0MSiyGM2EDg41tiplx65Ylv3fhBntp3N1I0q9hVTRq9dr79o6ZmsJ4Qbqf3LvYSQDiffhPRhlAmtpUprNxpcIahHDVlEfbNwoLww11R5O8=
Received: from BN1PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:e0::25)
 by BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 17:07:24 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::cb) by BN1PR10CA0020.outlook.office365.com
 (2603:10b6:408:e0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22 via Frontend
 Transport; Mon, 28 Nov 2022 17:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.22 via Frontend Transport; Mon, 28 Nov 2022 17:07:24 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 28 Nov 2022 11:06:47 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/9] ACPI: CPPC: Add AMD pstate energy performance preference cppc control
Date:   Tue, 29 Nov 2022 01:03:06 +0800
Message-ID: <20221128170314.2276636-2-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128170314.2276636-1-perry.yuan@amd.com>
References: <20221128170314.2276636-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|BY5PR12MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ea0f78-bc71-4bfd-8baf-08dad163053d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnvfKRryO5i8bQDgqVE7QWLU1W+iTaGYXFw9H5vydnsWEjNysBZNliXcAGWiu11HaF/Uw1j07cv7O00OOgcM01LTwqbSSz9ys9FAfz8xYEprPsGFCjzrreQHy3XrUCb5FCxeiwkmXgwlgikfBfYA7SuUfDQzQynTyerrke5ylNGQTOpqEiTNsdtSIN+Vske1CGAMqI0Lx7vkm+nRPmeLQcBzvUS88k2fokSI4LmVvzRzTEmbIf8NedUoEkAflw+sdvBEHY5IWr/ffnSgWr3wATBaZeCWKmmwe5P9T+qe2SiDpzEMv7JhpM4uGRs43oKlPFx/4WqjaAQRFxqCaRYBBli7q54SaLDSf6rJ1+xUCDdpwfj5EbM5gs3ehGFmp/TqHNXyKeyaXkMgxRVy+x2OGKldFfTcmxjiMK/SqJy7PXVUhPVgI26YZv1AJWW0HCtiV5OKFAmh40jZXYsFuVWevS6PubrSNGbVdddxG1Tb1X7Hagz5dqmfh0dgVI0IQ9Ca9A9J827KC/AZgupmNkSbxY6TQ/1QlTiRQA6xnZbZgc9iXnEvMJfLYu9l1x9hw/owimVEU9kVbKKsuiaEi9wREEuXYNWHLRlbgequ90tnNsPYm7VtyVpPxZFUh9+IIGVq/cZqyAcr171op3HgztwzkuQBsQ/rQ5Jg1HGJQKPValX7RjG/dY6Lau2WOtsLTO9EGy6pnRYvOvQgE6y371cgXQrWTbzB99WqPRKue/UZj+k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(36756003)(26005)(186003)(8676002)(336012)(41300700001)(8936002)(70206006)(16526019)(70586007)(4326008)(478600001)(7696005)(6666004)(2616005)(40460700003)(316002)(81166007)(356005)(86362001)(40480700001)(83380400001)(5660300002)(2906002)(47076005)(426003)(1076003)(36860700001)(110136005)(54906003)(44832011)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 17:07:24.5608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ea0f78-bc71-4bfd-8baf-08dad163053d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
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

In order to get EPP worked, cppc_get_epp_caps() will query EPP preference
value and cppc_set_epp_perf() will set EPP new value.
Before the EPP works, pstate driver will use cppc_set_auto_epp() to
enable EPP function from firmware firstly.

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

