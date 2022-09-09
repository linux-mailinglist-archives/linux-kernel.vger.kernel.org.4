Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C775B3D43
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiIIQrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiIIQrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:47:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2F7145FEF;
        Fri,  9 Sep 2022 09:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsOFzW5B832/f1eMVJwWEi/tKu+LroHg53HpbGZ7lVaXd0AoGC7EBYh6akCElRMnm6bbI322dbWZ9+1q+GCTb7Dv5gJXkZAUNDIyXbkQg+mLybD7zoASC09lhJtfPnz2n7K47wZ/XyIDzXScWgzjOZInjRYTlIny2V0WACVH+xGTIQEC6oGsm281FC+i73fPYTB0GV1bt4RL9exhr5K4D4hqReQK6u2UUmKOeufN5rh2dTiOHJSCFB6pg077KHsdGAPCW+vzKEpc1iBdSh95O39RfmPzL/fqiMMrFwERgTwDS8AVAUpvadRCsJMEeSwhKcOSRig3RKDDdtpvLOxrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuOLbx/hyncCq1TM4w4qKynsnhntnNBmb3U9htFskMs=;
 b=HGWBhcPyaxo+hVcZpdG8O7cw9v5n6TZ1l/Mt7Pm2UHTMi1MeAUkdIhyGjMMw+4+ikLG3LC/MNpXUVcDGO9/7HpjNwQUbv7ScSkvJTncYxmBzLncb991Olw0YFKUer4ZxVnUQFW055LicrhZNNXtpzAla3wVKLERNOPCDbWBhLzYaxY/B36KIL9Mc99m8FyX+AO2KCb7UkhzrjpIJCSCPMktoid4B8dsJAWlyiD467iMhw/HYPuAzBzqXqp5YFlMqLmKRyDBjxD5jFH1Yn+xp+T2mv/GwaLwg4+mGP0UudscjnOL3Z5tncjaboyhG7MW5/dau/YK3umbib7BWnALCxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuOLbx/hyncCq1TM4w4qKynsnhntnNBmb3U9htFskMs=;
 b=NtV2/LscV1xXr1DwXDAIqrGKONiyFrg9PCm10dPFg5SQZnQMq00noRF64ZEtx0h6RvShPbYXroHNdTuHSe5af2pc/e1qP2HHUDFdmR8TT5/F+r/gFbztOmZjnQNlnxcHUk97MWnr5kUrARcqkVy3bfwIJ4Zkr7vOIJorxenC+ak=
Received: from BN9PR03CA0535.namprd03.prod.outlook.com (2603:10b6:408:131::30)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 16:47:00 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::c1) by BN9PR03CA0535.outlook.office365.com
 (2603:10b6:408:131::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 16:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:47:00 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 9 Sep 2022 11:46:56 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 1/7] ACPI: CPPC: Add AMD pstate energy performance preference cppc control
Date:   Sat, 10 Sep 2022 00:45:28 +0800
Message-ID: <20220909164534.71864-2-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909164534.71864-1-Perry.Yuan@amd.com>
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad5222c-3817-4164-3938-08da9282ea71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcUkdGvus8k6FXbJ09HQjnhOo7vY8xzqHnloSXkKZpE465IFw5YJLYjdXd0rM5WVqN2RB66EndTSLDiHgMaaoEu8onehJWIg+pFRlfzr+3DdNxILVVnmRPtoBFge0qzEOxZRTJ1m+QN5X/luVkEvhRXaPoCP/zwO8cjQk0ReRyKoZtmilWIm2JKR9uaylu9L7LR4snRAw19Z5o9Lkb6bgnVf/Eik3UbuIgO+u/CM3RCMizd//xKB+Q/B4aLkwMddVtTOzWP/tRR/uTiZcO/GYsHFb3w5PrDDtbVhNkPT3P3X8DTcO91Vc+4CSwX4KHNI1Nfzv+BhIlz2FseLuNXBbOY51JpuOXVSozXlpIsOqOpyYoouhmGHJciOYJREuE0Jcp+AE3w65HU+KUpHFueZyV0ZzcIU2bloG7trFvsbq5QLHpqYHS7pLfb2kORetgD24EKorbrW7JvOyG3EugZqjJ0etnWYm6DB6uempXijciW1aDnFLaRfwFoScMIe3QmKrZhwOFlOHaKud7MMtB/CctA6daPhmcpibObWR2YZHZrE+q8InhhawCZuplW7ly2IknpuDZ1iR+2x4l/vzexDlRdVFPFYiKlQcnh50Kc8yj60KPZsaoTQy7gDvbrGZnCCo7MYQ6aTNkqz7pjBjrzTD6HryIEB82tiwBTlfO3IxaeZjAuHKngRk0932C6eJYJr2flFVhSTBRgy2t3tGQ124LtmEoHVXLfq27HJT6wdyua9i6r2tW/08GgoiBt7v3UikCJ+zNBJhgHFK9yTdgFm+cInuHLq4axfn98ueEjlHA26adWRLUQV3G6pm6ue2TmzZn9SiCDPvBcIMw3P5NkLoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(39860400002)(346002)(40470700004)(46966006)(36840700001)(316002)(54906003)(36860700001)(356005)(2906002)(86362001)(82310400005)(40460700003)(70206006)(110136005)(8936002)(40480700001)(82740400003)(81166007)(70586007)(5660300002)(36756003)(4326008)(8676002)(2616005)(1076003)(478600001)(426003)(83380400001)(336012)(16526019)(47076005)(186003)(6666004)(41300700001)(7696005)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:47:00.2414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad5222c-3817-4164-3938-08da9282ea71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 59c0e3410f97..6ebedb40589d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1329,6 +1329,132 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
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
+       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+       struct cpc_register_resource *auto_sel_reg;
+       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+       struct cppc_pcc_data *pcc_ss_data = NULL;
+       int ret = -EINVAL;
+
+       if (!cpc_desc) {
+               pr_warn("No CPC descriptor for CPU:%d\n", cpu);
+               return -EINVAL;
+       }
+
+       auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
+
+       if (CPC_IN_PCC(auto_sel_reg)) {
+               if (pcc_ss_id < 0)
+                       return -EIO;
+
+               ret = cpc_write(cpu, auto_sel_reg, enable);
+               if (ret)
+                       return ret;
+
+               pcc_ss_data = pcc_data[pcc_ss_id];
+
+               down_write(&pcc_ss_data->pcc_lock);
+               /* after writing CPC, transfer the ownership of PCC to platform */
+               ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
+               up_write(&pcc_ss_data->pcc_lock);
+               return ret;
+       }
+
+       return cpc_write(cpu, auto_sel_reg, enable);
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
@@ -1364,7 +1490,7 @@ int cppc_set_enable(int cpu, bool enable)
 		pcc_ss_data = pcc_data[pcc_ss_id];
 
 		down_write(&pcc_ss_data->pcc_lock);
-		/* after writing CPC, transfer the ownership of PCC to platfrom */
+		/* after writing CPC, transfer the ownership of PCC to platform */
 		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
 		up_write(&pcc_ss_data->pcc_lock);
 		return ret;
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index d389bab54241..b9f6b11ef072 100644
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
@@ -148,6 +150,9 @@ extern bool cpc_ffh_supported(void);
 extern bool cpc_supported_by_cpu(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
+extern int cppc_set_auto_epp(int cpu, bool enable);
+extern int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps);
+extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
@@ -197,6 +202,18 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
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

