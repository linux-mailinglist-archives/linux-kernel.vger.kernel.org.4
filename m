Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5181667162B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjARI0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjARI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:26:04 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F75AB64;
        Tue, 17 Jan 2023 23:52:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgSontSLiH/G2WZhD3oC3Au9SDDc/UR4dFVrgW5fLEdkuSGF5EMPqM6u5dS9P9QcUuhs9BgFMd0Q//4SccHB5KrdToZ+6O2AWUkFigeeBnc5Tc8jrBBY8bQKTpbZL3Wqzd8FmkISS7KmEr7i+jOqbRIrPBapvMKEGYOon+RqjiOJCgID+KWkgnjW+8dGSJ8LC2gQOnvQNRB7nwcsYO0yeFElm0+6DkjOGrwvLd0+bfXVv0PcZnBPCs4WdApTM1NmPYQmTxDGYIfhDnPZnaUXeWVlk7Q5y8FtEqMjcqJ56jPPWUuIn8wNiYx7SqLkI0YB6pUSlWqaTlI2vplGlVvnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2kg3NyOxDpCcsc9p7SzAIbT3cisV55IEpKRJajCNT0=;
 b=nYqqPRMezX419ibe5kMZMFpePLhA19EKKlcYisnE3OEo9joyB3itZG9Tz7Y/FVRE++DmioloPkGdB2VyEags5RzSifNTd1bevoDzhsoU8KpOI4JoxPz7+jRwkUwFT7ffHufOUL9WqmskN/wen0Pr1n9W2BdywP8Rzm0SD9Bj3SL3pQnmuOcOxPKLX729b86bRp1bXxq/J9xbxsQWGMnLtw5HI1HiiBkA+cApcVQ//eHTYKL2FIXO4BBMdY+yjoWqmLXbdA06W++tVn3b9ol6hOGctsSD5w0q1jn2q5/eD7CnfI0zZAUGJEM3JhXFvbJ4aF2ZnkDdUmI5RfDAnJaK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2kg3NyOxDpCcsc9p7SzAIbT3cisV55IEpKRJajCNT0=;
 b=1nhH+li9KDgWXj5VbEnVKKyiD5gruhU4Vx+gVgL5kEeQHPhd+2YVAentuo6boTny2GVcdx5RscjwwyutIYGgUbwQ3x0Pb3BYnoaVK75wq+4RQWNK4w1oojTzYrctRzQ3LizlO95Z7mZKDtM46cJBfuFdpypgGfxqYM76QUQNHfM=
Received: from MW4PR04CA0262.namprd04.prod.outlook.com (2603:10b6:303:88::27)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 07:52:51 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::c4) by MW4PR04CA0262.outlook.office365.com
 (2603:10b6:303:88::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 07:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 07:52:50 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 01:52:46 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 01/11] ACPI: CPPC: Add AMD pstate energy performance preference cppc control
Date:   Wed, 18 Jan 2023 15:52:00 +0800
Message-ID: <20230118075210.447418-2-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118075210.447418-1-perry.yuan@amd.com>
References: <20230118075210.447418-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebb6237-10d1-4e63-1ce1-08daf928ff6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U18OPDA2v2uUoIgAD4jXjsXbnrRy1L1dpwjwKjLCmciM/TWlAAXB0vRXur1H1Z+eIprxVXDh5sgsGp7Ad6UiEhsPggbzcwX9oBLK/2z3+XhdhfjoQmNkZKY/TWFQBUJ7dBJJylJvWyEy+YGxZDhtBm6nO4xlDUcuXRi8Yqutr1bDQi1cTktTCehbTW7klrwVny44J2cNOOI55hj8i10AvCdNGXiaT3tomJctkIJQ9bSaAjgzCXu0okMcwcjVbyE/NeSx646tUlJ8X/7fmRaj9E6S3eG2ggFYrTyPzDMUHQU0DdT+ZA699eeypO2JoddawVSFUiVhYbbVkvpJgcfLSojx3EnhFznX5Gkaryyj8eQMEsJeG8XqeRVUG/Fd2jiidJDQ2NxYG1wYoZGnB3GZIdKZQ9SC9yhfGPL5lYc6LzIBlHUeanbUUTu7G+23XJ4LBz6QXTHzcPgwGiwz5tHuJ0k3Z10Vdk730mlyZFvn2EtO/0QDIp3WCCCj+l8KqeWSF+eTO17XJ+kyxP6SDQCxkHTVb1f4o/bh3ub4fil3nLcDtECLOZCDGImJD7I3mEgueFroUPpRamHxi3q8WL1uW7daNVxW6HwlF4TpB/y9RK3B1gEMmY5nWYt+HDzwBoy5fVUJ5d6R2fJ+NWZ3tuMc7oal/AEOet8vf76NZwPbe8YxwBShBcJiONfJLFN33xQvdoRsS4eJ80R3zWplPFuUx5BCbEtllMVtjqncufNPV7M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(8936002)(1076003)(36756003)(336012)(70206006)(110136005)(70586007)(2616005)(47076005)(426003)(54906003)(8676002)(83380400001)(4326008)(316002)(356005)(81166007)(82740400003)(82310400005)(86362001)(2906002)(44832011)(40460700003)(5660300002)(40480700001)(36860700001)(16526019)(478600001)(186003)(26005)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:52:50.3936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebb6237-10d1-4e63-1ce1-08daf928ff6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 67 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h | 12 +++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 0f17b1c32718..02d83c807271 100644
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

