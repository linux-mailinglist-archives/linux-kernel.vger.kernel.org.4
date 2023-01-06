Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C4865FB3C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjAFGOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjAFGOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:14:40 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395E46A0D0;
        Thu,  5 Jan 2023 22:14:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYVseyiEeM7ZstJrSu7KYMxBNmhpCZVWjAje4xju71yt8y8e1TH9FbGIoh1Bz4URhtwqQ4MciGxCh5mtfgNFbDb7ngvzuMHSFXsmEYxoWjMws0GTIM9UXVQB1AMokupGkM9Gu7aTlk8ostF0sdYOhAsqqJld2aEz5gWF0NdZ+mwmU6M9ued0Yy3Oa8/sOS8sHvkM2XmePPPTrpaRSR6gyukVkkKbS9welcms/QJykMRNKvyz9FiqPuTqppvSMkLsa/baGc3nc3+eNHjXCmMOZduTlEAczXkZWgGmvx5BK7EF9RIMxev9ldMtJsh81d8nuqlOT7f79OWNLZ3VFNKmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFqCQXHa+FKYUQN4KG+5XKTdILz5eAT2mxbJgfvn1Wg=;
 b=ogR0fR/QYdBl6feWM1XmZq15SWEOKOHQWYK+LGgYlJ8PnGOeEnZIcm140Hu3WK+MLKV4NYXeDn/fSwujTQsXwykKNfnVjRSQk4Yui4OjZ3yrW6Ozjedj4+pxkX+1wxgHqlVQa9XKkqmQsnH1N5EyiF/H3xXzpcfFtKR+mEcvFzzDt6Jcg5aFCID+wtMdTj2D0IWp05mMlWN4b5O63JmfgcYmrfn27dofCxO2sFCdD87Wt5y180ZPoUK2TjSNeIpsvR9Jsy8mVzXSEiFuD/zX/qQqR53JaktTwh0Vqcs7nRDVrAydp3F509wIS58trca9p8PbkDBQhzUp7DY3AC9Sww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFqCQXHa+FKYUQN4KG+5XKTdILz5eAT2mxbJgfvn1Wg=;
 b=FpxdcgE4kPw9RRiSVDBI9qBJAkscfZPFfEdf3JFsjvGzAwkxe/GP8WT7Q/cGPMAJP5vjD39wP6grQRcSfVrzego7189bi+pZOT27BeYdxS5hciiyWs2WEkOZbYc6n3KOTSnmn6jNKFJk9rHOUjWIhag66yN76csaa/sD9AlYi+w=
Received: from DM6PR08CA0029.namprd08.prod.outlook.com (2603:10b6:5:80::42) by
 CH2PR12MB4955.namprd12.prod.outlook.com (2603:10b6:610:68::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Fri, 6 Jan 2023 06:14:37 +0000
Received: from DS1PEPF0000E634.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::9) by DM6PR08CA0029.outlook.office365.com
 (2603:10b6:5:80::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 06:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E634.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 06:14:35 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 00:14:31 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 01/12] ACPI: CPPC: Add AMD pstate energy performance preference cppc control
Date:   Fri, 6 Jan 2023 14:14:09 +0800
Message-ID: <20230106061420.95715-2-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106061420.95715-1-perry.yuan@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E634:EE_|CH2PR12MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 0189644b-3274-49b1-82b7-08daefad48ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAOXlSKnHobI4XBSWDaEcjRYB/ediBtdLuL6CwjruyWxOVIktUnKot/jxCaLVWN7KftgCZgPeyPD4ld+88ldqe9qxeGnOnGzeqI3ppuKmleqetYuygE+XBt2RSxaSzUTci0YH8leKOAZ3dULcrwaxxsW00Xdjr102jKsZfJjkejnQfbckULfQsmU8nI/5/clxy1l1Dl3nwDpdNyxVLCMJvHeZrouoUpyFu/ezba7SFyB0H2FxYMpYESxcaPhFl0RFMWytoEc7m5kPvPuIkFfJR5KtR5WOUcZJEtuAOPBUdRGhkqIg2SCNmXnXq0xur978Ic+1U/fW2FabOqNNkCUzl9f/RQOub46to0Dwv7Bdyp1vKQHRIC4wPyGAwhRUJFObYpL8YyxT+Fja/0SQUzJDpjPab+aS7+9u5AjKCVRvf5GRK+QARzTXTrjUE0XsScGOnRiUruyxJNYQskZlCBgCU4pBZuVFpUqJsMY3oCpYxcv0WPDPTXEVgoaFkDlE5IG/6ThDfiW9S4KMWifS3rr5V8+JmIYciWfEOZiPS0tDehAfkpdXWZoIzKa8yFXsK0j9gAe72v3RzBeZ10FtlU8T49khRODrwQxwMJMYwAZw3+uEoA73h1HbA0Z3D4Ja/LP+kwgghS55N9mkvXOYxpt13LUwo4Yfbe1kGqLdy1N+A4RRNQsDdk6W1iOLkt295pjxwYJ56GyBnVR46N5aOj0uKbDTVTUIsthfV1lcitQGcA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(47076005)(426003)(336012)(16526019)(186003)(2616005)(82310400005)(1076003)(26005)(7696005)(6666004)(83380400001)(40480700001)(86362001)(40460700003)(36756003)(36860700001)(356005)(82740400003)(81166007)(41300700001)(2906002)(8676002)(8936002)(70586007)(4326008)(5660300002)(44832011)(110136005)(478600001)(70206006)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 06:14:35.7405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0189644b-3274-49b1-82b7-08daefad48ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E634.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4955
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
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
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

