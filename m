Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341C268C48A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBFRXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjBFRXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:23:16 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C266A2BEE6;
        Mon,  6 Feb 2023 09:23:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAFc2X7dcvtiY+Lekw5bVAtHPUZTHzJC0O8pS6pB0G5aYZtsLBeegxkC/GBDSNvomAeGL2K+qtotvcN+Lb+r2TTO7KuV4AsiIs3TcQ/CapHjV6nrYSk7XW8f49qVP0UHckeYnrM8+d1OuiqBNwZYSJmhb5cc75pz2rfSu6qNz4H1P8R76d2b0VJIRLyyfHBDR7nAadDGRXS8Qm5oGL54qhGDfglPitk3e5Zf47TW5yEuWJju3jfWReDTtbSB6YYmT+sHeEqljTzU0dwcS4H5aQ1fcSOPUKuOOIJo3gmJWIyb26uvFofmifx0/ihs452rPH4ng4sYugxdJe6PikiKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82aGwNYippQcfrJSwAkDqSbcGKrbCFCBCOh5PrQN9Dg=;
 b=Kj1IMGsXcYEPZb/HzRiyOWjQyXljXzqrb2VtF6E+rJN28RduGLbEQmc+0AKGocAEC9k8vKiYpszeRVtN4f5WIDxkFUypTZ+S54W3OMSsfekDmGRJvmE9/hOmuoY86uXXovr0E0HfNXMAd+uZu+TS3hI8KoeyvH5By2wam4W/9FygvLV4QgmB5ssX8aWb2kKIRn29wA/zx64DElVpmR5pwwGXVLmXm2hNWEXILfXKJeJ7T2usehDJ//9CWIvIhp0iS+W26/dXojrL5rtvSnspXEGqIdPCIlGQ+GquOZyN+GYJ5A9tX/fn/9EYrVY6NqLfDhFuA+mH0oYifkJ2RLV9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82aGwNYippQcfrJSwAkDqSbcGKrbCFCBCOh5PrQN9Dg=;
 b=ou6EFsiNHe4pUyR8DkvGOPbcejK2kSyI7earj3+UeUl08s41FDlpEXtvjplfuQsFpIWAG6SXqWRb8dYSpUik4v/NIBwMLixoSnzKG1cpozp6IzC3oAktmyqFPgQnFjojfw5e3N8VTIObRNOGd9ANN/2ntYKRdSH0eXmFP4t9Ddg=
Received: from DM6PR12CA0025.namprd12.prod.outlook.com (2603:10b6:5:1c0::38)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 17:23:10 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::21) by DM6PR12CA0025.outlook.office365.com
 (2603:10b6:5:1c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 17:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Mon, 6 Feb 2023 17:23:10 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 11:23:04 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Tor Vic <torvic9@mailbox.org>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v6 2/6] acpi: cppc: Add auto select register read/write support
Date:   Mon, 6 Feb 2023 17:21:53 +0000
Message-ID: <20230206172157.49887-3-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206172157.49887-1-wyes.karny@amd.com>
References: <20230206172157.49887-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|BL1PR12MB5286:EE_
X-MS-Office365-Filtering-Correlation-Id: 48493ca8-e662-4d4e-5967-08db0866d1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPgfxVnyGmzB2emdYjzgIEMsAFDcuqe7InTHke+Xp+gTKug3cSgcpABjyhsgavaSP7Srp+pA/9GI8+9h0MRNlX2xF1ze6Xf+GKb62O7IgrjM+bGbP7gT1HKj04fLPYOPE6VooKw0uVa6QsWjKxcKGiZlVYv8dFA/Hv/9o3ynUkluqmf1zZtktiYdauvcKZ+kLdwYsM60J1XgAgZ5zWUtvyB7Ln/b4kqjG5Xl1Pfsgmxqs5x9/JKEARLAdBY0Ifxyij+2nEjitkZhuoetyL26NTnG2359L6klvaGq6IwkRnnwlFymboPu0Z+3IrdRz1pEjie//drk12rxNzWhommfpSxvCFxCLzBG4/nRfdjr7SgeDPaete2CpL+tFASWgB4sRTnEDBGctCJIE5gt3LzbP9hjmNpMpokT+qVt0RRfr/YcWPUFRPjypGkkZ0vGlgx/9VAW3YDDhzvsE5SNpiLoGbAaEHiHl7MC/p+NBVsDkF3w4pZ4nDbDMQ9KeqWGMUitj5RAcofzvGxF525GfoU6F3CCVNPrT2Wxh1EgVm86w7t9uCZsMD8F09vuwGo46SfjT9G4hKBKk3S0s33xpPSYi0xO64I03DFJiYktKX7VDp7Mg9wBIS8FwbXmUB5zVjxsFI9LjRsD3PAngg9H2L0CM98lpesla5i6uTM9IEITfNGbqDg5ytKeJeaZdUaYkfA4ZqVUhw0fCHeif9VLsDMJFd0gk00v+zDz1ZvY5X00M5w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(40460700003)(36860700001)(70586007)(82740400003)(81166007)(356005)(83380400001)(70206006)(8676002)(5660300002)(478600001)(4326008)(41300700001)(7416002)(2906002)(8936002)(44832011)(6666004)(1076003)(2616005)(16526019)(186003)(86362001)(26005)(316002)(6636002)(110136005)(54906003)(82310400005)(7696005)(36756003)(426003)(336012)(40480700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:23:10.2185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48493ca8-e662-4d4e-5967-08db0866d1d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some AMD shared memory based systems, the autonomous selection bit
needed to be set explicitly. Add autonomous selection register related
APIs to acpi driver, which amd_pstate driver uses later.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/cppc_acpi.c | 97 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h | 11 +++++
 2 files changed, 108 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 91f9ef75f7de..1806006a51af 100644
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

