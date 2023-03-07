Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09456ADD58
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjCGLaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjCGL3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:29:47 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9178952F62;
        Tue,  7 Mar 2023 03:29:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPJPSS51lt4mS0Hc9St3osuglShfxtJ2Yr1O732pXJtfiHPvR9XzIJ4egdhZa3zCCx2WtSLWLCcu4Lyr9Cnnh9iER1UB89ZbrvfyVd0ovi/kJhBgq8PjR6JZGbFcg4s3yis8btewDqLS/vm0Fv0Zpoywe8NRS5nUyio9ctckiCm+no0TqqcGIN89FRhLHs8/Q97PgzKJ+smR0/Rr1c+wALrnyTUowUSJLM3ins3tzw0yIEOFgXE/F/Hx5Y3vOOOn2ArJpijWci5+dNDaSvlqB9ej6LJsFrjACsdnqaAQ97NlNGDFJZ9x9POjOy1rGnzizMtHwJpBxtHsYWk5nxE5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSAa14i57gl9dPrA+j7A0e2pRxhBX9sWQf13LNpTdqc=;
 b=nJyNAdfIUjtovu/YjvRj9TWCjTiDg5VZlDnH4QZUrEiTIInztxFXN4xz84aEX65deVoQL7p3t4HNp9Zbcoew3AsB3gtXiq2qe7dnKMfEURPbDYjmbC6DZeJ8Yo3ywKafgUCT5Wl4/TxDvGNtq3s20oCYJZodAtuqszKLGX2A8xQl9QsRKybDYBylTabjDsabA/NYmiaiS6ituOM5KNzjGthoTSkkqLcHqxBLLDd2Z3sYW27MaObAfplIdR2exdXOWyea9QGoxE7yp2rknroZEk+Y48pwtaMM0vtFqjFk2JCG4XURUUZkimQTqn/WR++Hmm2+3U11SAtErvVZJZEC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSAa14i57gl9dPrA+j7A0e2pRxhBX9sWQf13LNpTdqc=;
 b=E5uCQPHhzXHvfZ8IabO8Mv9IiN3H4ktN663bU3zsMK3KFDbge+YiNVf9/rM+xELrD+x+L2oMW2PaNG7h/i029yxcQiiUs94N/f5WxZNOSY5YGRVIdOxrYcxBYcfAndcbnearCY1m0Kkvp/GgMx5XAJlb+MOBq80pcokBSq+Dtz8=
Received: from MW4PR03CA0158.namprd03.prod.outlook.com (2603:10b6:303:8d::13)
 by CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:85::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 11:29:13 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::93) by MW4PR03CA0158.outlook.office365.com
 (2603:10b6:303:8d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 11:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 11:29:12 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 05:29:06 -0600
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
        Russell Haley <yumpusamongus@gmail.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH v8 2/6] acpi: cppc: Add auto select register read/write support
Date:   Tue, 7 Mar 2023 11:27:36 +0000
Message-ID: <20230307112740.132338-3-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307112740.132338-1-wyes.karny@amd.com>
References: <20230307112740.132338-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|CY8PR12MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 05108c1a-85c8-4427-2498-08db1eff2d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1eYyMRSXz17B7gQ+//c9Gwu7VXP3SKCuEEiGPcsLycU0NsC9BDQO0JndYpzcn4IvSm/9pwNbMPdxxR3YvLGF8RYncyzoK3tXhgPpjzdSZIUW2GCfCFGC+Ousw+5/32endtlmdaosC7PYfCaJyQp8Rv6FtJ0cftNTam1MJ+gaQkPizbJYBIyMh13Ex71lafKvlJYSvu3KW38zPCM4H/skxtArQwNb+GiUxH5QOYYI0huU58xQlyZFW+42mflZdxfwx9u3najDiIal5tq2wWs+KyX/Wz/p5aQTCJmJVh9uf9aH0iI5e+Ed5jbquMMk63yPoD2pn7zJY+q75Y4UWlf4ukYZqtU/jlGxFkXcXf9wv+lm6EOzYRqDEBi1DRRFdwY0UYZ8HZyHaHLulSe5ZaTpJRblXp+U6S29Vd/9aBvl9QmcPP3yzWUI1wwO+LF76ig3LUDvUneYcgOwgIzWtn5GjX7rAip10kaF8E6V/jybYGX0ws3DIVnsOclH+bOGA7Hk4FNDbt/mwuOo09cDLKcDXNIcuxZXeq5BoVWamFqNE5jfkJE6g0PXf+RaWwyn3Q3GltBR4rxTNjQvRgTJS6vXG+1xBnunzjCNJeC8JzLpWY8nI1IEizMV4TOGsBq+/78gQYLAzwpSVjudZYGSJtJYziAZkdAa9rs84wQKjkkk4yTIz/7g+Kd/FGG+XjtjKFllG4D4swJFtfsrBKQkxg6V2/yCuiI0SlqVOesbLrh5H9Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(4326008)(36756003)(70206006)(70586007)(41300700001)(7416002)(8676002)(8936002)(44832011)(1076003)(2906002)(5660300002)(82740400003)(81166007)(356005)(86362001)(36860700001)(40480700001)(7696005)(6636002)(6666004)(110136005)(54906003)(478600001)(316002)(47076005)(82310400005)(40460700003)(83380400001)(426003)(336012)(186003)(2616005)(26005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 11:29:12.7871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05108c1a-85c8-4427-2498-08db1eff2d5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some AMD shared memory based systems, the autonomous selection bit
needed to be set explicitly. Add autonomous selection register related
APIs to acpi driver, which amd_pstate driver uses later.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/acpi/cppc_acpi.c | 97 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h | 11 +++++
 2 files changed, 108 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 4fea6b8a26cd..02a4bfb54967 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1433,6 +1433,103 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
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
+ * @cpu    : CPU to which to write register.
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

