Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812FA686026
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjBAHAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjBAHAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:00:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3775B5A2;
        Tue, 31 Jan 2023 22:59:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flhVzV5Ri0jM5biTCKQz+3rejFNUPSGKaHLn5j2DCmbYURFV7o9Z8ikNxiWKohP21ynBBWWxnWKzQpP6uEFhQo8NrdxDBHE/C3m+l3ElvtilcOmMHOZdQQ+soBSvbdm4tsgKicbOoIEhyConVH2/7VvdeJ4pTG/xEvk52itSb1aGo1WS0RO9GEr+XK8dzi5loOQy8pM3SYuAapzKu8Y7Kx1ac24E99QA6o6ytac3V5G8HiA0+AA8PuscVxfvIor2xdZ1W5AjbLlBySb1LaQSmT+vl1HSaAxn+6MztRpeqGDmcyEedRXS/pI48psWWD59lXhqFfXWznh1/9G3m7822A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82aGwNYippQcfrJSwAkDqSbcGKrbCFCBCOh5PrQN9Dg=;
 b=fdb/xQEtJrrYsDCa32NuxGu+a5Wk9HmHwmv91S6wB7qjM2PL6QrTMcRKd8BCTXIo1buBEldV3+/Kcz/2Z9jVsDYUOZnoUjoX0Y8HSDk4ICP9nRpbKQXGlwkHswrUZzsZzXOZa8o9bHmBlDhZk+IzSOXF/9j60tCWk7l3uRvSkEMZvWfM7aNbvzyPxEuLrkIxiyKaTa+xPGuX+xi8AqHgNFGjFv2hcwEbMaa134v8tWaOKbp7Vxmiz1XeSpJkvdFK/pa7xWIofUp6t5thSPSnDAhTqZGNIGJTo/Uz5A3MQrZhYUxFOQRFcUmXFoN3R4K09VfEJiH/mMLaWOjWJzFKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82aGwNYippQcfrJSwAkDqSbcGKrbCFCBCOh5PrQN9Dg=;
 b=HzjQlBO9e31uS5Vx8QRA8m7odNssQxpI9D70KbDNCZ0w/BxoiXgy2S+qOQwYTXNluJ7ninPerAvusA1EPHVgMR6QVkEBCqalR8mO1iRzFPAiTNWC0sBeFOdUurUcW+VdI3tlcVzLNpNRMxXLWfEXR2tA/+gUDNnablsznhG2q/Q=
Received: from DM6PR11CA0012.namprd11.prod.outlook.com (2603:10b6:5:190::25)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 06:59:47 +0000
Received: from DS1PEPF0000E659.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::d6) by DM6PR11CA0012.outlook.office365.com
 (2603:10b6:5:190::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Wed, 1 Feb 2023 06:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E659.mail.protection.outlook.com (10.167.18.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Wed, 1 Feb 2023 06:59:47 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Feb
 2023 00:59:41 -0600
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
Subject: [PATCH v5 2/6] acpi: cppc: Add auto select register read/write support
Date:   Wed, 1 Feb 2023 06:58:19 +0000
Message-ID: <20230201065823.189828-3-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201065823.189828-1-wyes.karny@amd.com>
References: <20230201065823.189828-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E659:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2cdb46-1e35-4acd-9c66-08db0421e7ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2L5A+Va3vHi3yL81e+VhLOLRY0Wa3DpzUrBwd7v4EbTv4QR3AMU/pM80dAuhGwzkVEQrOMOUdzqIMvH/BtUUXP1CoWVWd8DhmM3/sKTKL0Ym87G+ZRLtMfoUcDgtBmTV/XekfjJVlxXMuxT729nCbapBflWbgtKaLoUa+yrHkn8L8BStbhHI6TBH0o0cFHQ+r+cC5CL1oUVzVzc1atH+3gdWjkhyfhO62l3QoZ1MNGE3fbadlRxtsL3C7YrxlyHJKJjFjGsffxWSp5o28qq0CVwlOPhG09V//RwAHWE2pOj8/eUM71Gry9fwDwTHdErRROfLY5BZ38Tx+MdMNjJEamxOgYf0DlTolVfJMuYcm68TCB72Ysd+W4xXUGVBt/c4rXcqeOi9OMWFcDzaOgA7WM+3qjUfbuDmxIBKa4fvEjewJPopIPt5IS6/uPp7eEOkHyk/BCezpx0kMnZ40bq8rIzuxXcARI6oc3KNNQOgxGug0oGaMObFmFykLMAjeU4dAVzGccQaJBeYXZ13+ukBiMI9wYoFhX8qEiUzsy07QsYZ/Cs0+43IZ1J2YpgymRYpWkDclfFMjaRYGbaPZ02xQtyU5vV/HebgDazaWW5+cqImLKmn1rpCVylprkCNi5gQn6bM2kUqDsxuS9hULZU4R1wLdoWcWuE6WGNQECtn8M/1I1+mE/D2EyIExN6tsmNMDCU7Q6r9ZlJC0jA4nhETfBW2lficdJvRAI2UewdBbg8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199018)(40470700004)(36840700001)(46966006)(316002)(110136005)(6636002)(356005)(426003)(54906003)(41300700001)(44832011)(2906002)(36860700001)(36756003)(5660300002)(81166007)(40480700001)(7416002)(8936002)(47076005)(83380400001)(82740400003)(40460700003)(8676002)(4326008)(70586007)(6666004)(70206006)(2616005)(478600001)(186003)(26005)(86362001)(16526019)(1076003)(82310400005)(336012)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:59:47.0474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2cdb46-1e35-4acd-9c66-08db0421e7ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E659.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
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

