Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B7B6823CB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjAaFX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjAaFXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:23:22 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2529AEC6E;
        Mon, 30 Jan 2023 21:23:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jv8W53d3hDq22aWcmQgYafAYpD5c7YkOLuYNZLCmZOWYxXDHGQ+YTywAwVqYei5o8H4Vq54SyI8cq+Ljoea4CHQwyeqAQRu3/7O/AlgTLb0Lpst6cKHWkk7iVLnC7pxj1AGkJL41qsDw4eGDOPbX7TFnci0BOG4I7WO7S5l1Rx1oJ3XAc2r3GxE7Vq1nRiljEJm27YnUWYzO8nDHFtm6+ek8MFywymXm6F83nSVQeVP9G/yPy3z66R2+18XKQubgsYm1Bm18GdDSxDahmG0EHHxzK7rd4PL6utrF3LNvsRgrXArM0FSzkRW7o/4ABlw06ImSLylD4VUR3t6V89XDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82aGwNYippQcfrJSwAkDqSbcGKrbCFCBCOh5PrQN9Dg=;
 b=DkyDCtCRkFG9CI6EqeSkCJ1OttNQjVZTEBZLLJZOQR+t4nz9OkNgUyDd2Y2vUKpbxEgNksfYvCSR3kx8JSEWFOXpmG47Xpk4syUl6fBknhbI3KFRvscX4MOyUUzgSQTq7hzMZbddq4g6gtRpFDj9IvpstBAABvYLcpDY22v09OeVKCuc/R3Oo5TYL1PmF+Jb6tSfR183BZUDQPV/2MTOkFYtOQv8pdzB/7NevV2WlhH/AF60KrEL/7ItRRacIM30wIc6LlxFEtrYhnHX+qpS8F7AxgzpD8Tl87RKb+ATxW0fSWM6DKqYefPN8Qi3eUl+lzm4YBTu29c0O1E5AxQc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82aGwNYippQcfrJSwAkDqSbcGKrbCFCBCOh5PrQN9Dg=;
 b=MGcxQO2vQKF0n+zd5yF/ivFGTana88NqdwnMLvMgAk9283rWakuTHA3+VOoUqfHHYAsISF5nzO7aDKcvu2hwJBSWmp/+1/O12PM0wytHKjvxTORrwTFU2J1iNw2oNMs0m4XtcWzhHdE8fJlmAuPg0jWnZkZbLybYk5YRgphLhho=
Received: from DS7PR07CA0001.namprd07.prod.outlook.com (2603:10b6:5:3af::10)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 05:23:09 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::10) by DS7PR07CA0001.outlook.office365.com
 (2603:10b6:5:3af::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 05:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.38 via Frontend Transport; Tue, 31 Jan 2023 05:23:08 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 23:23:03 -0600
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
Subject: [PATCH v4 2/6] acpi: cppc: Add auto select register read/write support
Date:   Tue, 31 Jan 2023 05:21:37 +0000
Message-ID: <20230131052141.96475-3-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131052141.96475-1-wyes.karny@amd.com>
References: <20230131052141.96475-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2921ee-1476-439f-9592-08db034b3d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5LDsw2hqUJnx2LnVLHRT0MayVbY5ObtcQ+TtPY0XHYdvbAD3hrcerogvta1ucyos+Qhops+0xhSEvXk8ieBfKAaVVOiVjDtDI1sBr/XkkNCwQNHYwdX/HADwxVLNk4REZsTEr7/tD6+4/SvT8SZlrHQsfvfQWdNeYuyH4M34XcCeOGq5Uw0hCw8/gpusgG7PbujUH4p52Z8chkqH5HVDfWnvY1eyFiBZNY6RkBhgaH9FXr36UvNyUbqZScWVejR2z9rqbWHVpMgMP/nfHBjHdCqRXd9lIXaPlnQGbWbp685fB9Nvn9U10t590fxuegZUvZS2g9EYvX7pel/NqO00JQlhIYPxNxP9rfKwfElUcmBWwfZc1zohNRDEs11l/qXOG/dMiwkKyIuGFM6pLS2RslTNfv/YpEpixww+I0gscCVptF0rk/86lgw2079GUw8VyIS85JNQhoCgPFS9K42NFlYaQYrruaUvJhed+grVxjStxsHDmUltAnjWKn32Yxg0BFrET8n6OjfJVUpmgk0fvI8Xhz81eMDRDX+s9+lIwX6035k2XUYXsg+aqAVymPST94CDdIhorwdE/c8EqQ9/iR/Mh8h87l1pLrsFi9TZhw4zgau5clZJR+E+aZFqus3Hrry2qs5a4GusiOGZdGHqmuXkL00GmSlQo0DyQhNPBNgRAgjnKnqd2IYjFCc4s+xQf8TTKpXiCcNwd6TF9Yugg9k6TmRd6yV6XPUZ6GBW5Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(86362001)(356005)(82310400005)(2906002)(36756003)(110136005)(7696005)(41300700001)(7416002)(6666004)(54906003)(478600001)(44832011)(40480700001)(8936002)(5660300002)(186003)(2616005)(70206006)(70586007)(316002)(40460700003)(81166007)(26005)(83380400001)(36860700001)(82740400003)(16526019)(1076003)(426003)(336012)(47076005)(8676002)(4326008)(6636002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 05:23:08.8133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2921ee-1476-439f-9592-08db034b3d4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936
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

