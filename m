Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52156668B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjAMFYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbjAMFXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:23:48 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F8A6144B;
        Thu, 12 Jan 2023 21:23:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IypwchJig65LvplN6TD6peODRJvR2uLJY1lgoh3qrXkNPLYGMSDnVfr6ryqHxrGdDaTHItJNtLeoUYsafCoRXf3+oZLDImhGCq9OsownDXkFfxlNORg+jrxwU33AWe5nVSDDo70X32vdHpfSia0u7rwGSWDxEi3dPtP7eH2Rg4YDkyJCqgMzB8cWk4QR56uubA5vyMuESWIklBJXlgPmZrLk/oDBVMu5sOrpQClV7pkev92520wzmKRn+eA2T2HJoODMZEyVKaFjPwKGypZbkIx9pWhf7bwVI8738kWI2zUZFtFtrVKpyJgKYzDUjwLPyeUYZVrNwkG7hUe2rocwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHzrhqw0mZ+P9ayAqWvmbIHNuheEyALcVjg21ZwF1is=;
 b=WGPPV0B5nD5f8Yp59jpox5pz+l/VuITwELs4sECwAOZ1fGXzDBxeGqM0NuhI9IhuzOeRpDS8lF7xoHgpdJnlK41/U41tleiZFUjerW+FIBiQLBqAO01Az4pVFTco6sf4fY2z7pVhPbw3g2NzFhmbIkwQXftN6rP92CpoJW7y+QndrMbXS/fCXmmaCxQNYRUoUqswrhocAgv44XFMQXUK80oWOdrbBjLF4SJeNGYr8HPP1XJIT7JgwmspsaF3WMOpvfVHgZBqOMHGtbpiYEUArktk+7dLTK5kceje+3Q8/n5Zco77jnycJoK0Xpit3b/XSmoxYO9C8lswWJTHJiDwUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHzrhqw0mZ+P9ayAqWvmbIHNuheEyALcVjg21ZwF1is=;
 b=SFrcmtOH4irnoaHNhSGMzTnjE3/iofyYj+lAlFouO9vjrqZrWECil1qSsggGl6gKCcMhIX6+uBJTTqgxLfP4uoXMt6aztLx7q+8sWwBlljJDasxc+rQKS7EunjuSf8C/kPoxDgZaauyp8toGGW+eyTcyzms5qmlg234Dib2a+Qc=
Received: from DS7PR03CA0332.namprd03.prod.outlook.com (2603:10b6:8:55::19) by
 DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Fri, 13 Jan 2023 05:23:33 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::48) by DS7PR03CA0332.outlook.office365.com
 (2603:10b6:8:55::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 05:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 05:23:32 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 23:23:27 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v2 2/6] acpi: cppc: Add auto select register read/write support
Date:   Fri, 13 Jan 2023 05:21:37 +0000
Message-ID: <20230113052141.2874296-3-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113052141.2874296-1-wyes.karny@amd.com>
References: <20230113052141.2874296-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4c24d5-c9e0-4f74-c9f5-08daf526502f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXMKHIXbKzY+aaxqg7w6be7qaaH3/asQeCc8lSSKxOi/eX0atapumxtAAyH3d7uO7YU/SRbl0iDmnA3iqXmIqGFyhYLz0OYkhAvvkmrIaJxAhkW++mrDGC9zmHZlSS5Vo0u0UueCTvGrc49cL6K68Hc3eFLwGddA60uxuV/+oTEwBFqkh2HKKGAj95wBbWwwJ3N7UdNujHYLvKqVVfNd7kvesWPq2FCnJp9EmhMtALhTgQqk68Wjj+lLsUWzc5Y+dWUAC/R9k91kh0hcjilMUoufqYw8DvPF7LVMjLr1n6F2DbgIC21bYsLIpKHRTqcYwv2Qt5c/GvSxGWSk3vQQRKLUcdqVzXloIW1JwLhIV4/H8inr5hT7HwB0UIzp82SnsfSGCOhC6X1BE4+nSwaasOK3giXl7oGet7ydBKkvs7EjmUaAGdK1OhHATNQznYMlv3UXVX1zOirzFJUy0oaob30wepDVPlrfCez4IGRYCR7ZpfB7a/clerQ3NWS0jw3i4d7ltWcqiNDFwrfrIZcqwEF5oFwbgJyOeQ+fPn1VnmhtBizWi3pK//iUrEbsFQdeUZwse3qW/5OsCECY3ESFbbMd2HN2geWp8infmWMTy/wseUzvCHpYh2PjWK9F2CJwd1vIs6bJgdIRV0xntcFwoLAVG/HLP+2SS4aDaRaTDxk0aGElrGpOmtjoxV0Iu1lG4vYajYAmHWTyzKyAqb77AiDYXrejWESPnvsd90kmv5c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(81166007)(36860700001)(356005)(82740400003)(70206006)(86362001)(40460700003)(6636002)(4326008)(70586007)(110136005)(54906003)(8676002)(41300700001)(47076005)(8936002)(40480700001)(83380400001)(5660300002)(16526019)(336012)(2616005)(44832011)(2906002)(426003)(1076003)(82310400005)(316002)(186003)(6666004)(26005)(478600001)(7696005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 05:23:32.8436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4c24d5-c9e0-4f74-c9f5-08daf526502f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some shared memory based systems, the autonomous selection bit
needed to be set explicitly. Add autonomous selection register related
APIs to acpi driver, which amd_pstate driver uses later.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/acpi/cppc_acpi.c | 97 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h | 11 +++++
 2 files changed, 108 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c936ff503965..e47b2cfe022e 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1432,6 +1432,103 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 }
 EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
 
+/*
+ * cppc_get_auto_sel_caps - Read autonomous selection register.
+ * @cpunum : CPU from which to read register.
+ * @perf_caps : struct where autonomous selection register value is updated.
+ */
+int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
+	struct cpc_register_resource *auto_sel_reg;
+	u64  auto_sel;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
+		return -ENODEV;
+	}
+
+	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
+
+	if (!CPC_SUPPORTED(auto_sel_reg))
+		pr_warn_once("Autonomous mode is not unsupported!\n");
+
+	if (CPC_IN_PCC(auto_sel_reg)) {
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
+			cpc_read(cpunum, auto_sel_reg, &auto_sel);
+			perf_caps->auto_sel = (bool)auto_sel;
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
+EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
+
+/*
+ * cppc_set_auto_sel - Write autonomous selection register.
+ * @cpunum : CPU to which to write register.
+ * @enable : the desired value of autonomous selection resiter to be updated.
+ */
+int cppc_set_auto_sel(int cpu, bool enable)
+{
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
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
+
+	if (CPC_IN_PCC(auto_sel_reg)) {
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
+EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
+
+
 /**
  * cppc_set_enable - Set to enable CPPC on the processor by writing the
  * Continuous Performance Control package EnableRegister field.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 6b487a5bd638..6126c977ece0 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -109,6 +109,7 @@ struct cppc_perf_caps {
 	u32 lowest_freq;
 	u32 nominal_freq;
 	u32 energy_perf;
+	bool auto_sel;
 };
 
 struct cppc_perf_ctrls {
@@ -153,6 +154,8 @@ extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
+extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
+extern int cppc_set_auto_sel(int cpu, bool enable);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
@@ -214,6 +217,14 @@ static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
 {
 	return -ENOTSUPP;
 }
+static inline int cppc_set_auto_sel(int cpu, bool enable)
+{
+	return -ENOTSUPP;
+}
+static inline int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
+{
+	return -ENOTSUPP;
+}
 #endif /* !CONFIG_ACPI_CPPC_LIB */
 
 #endif /* _CPPC_ACPI_H*/
-- 
2.34.1

