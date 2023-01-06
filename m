Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAEF65FB40
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjAFGPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjAFGPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:15:01 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228156E0DC;
        Thu,  5 Jan 2023 22:14:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfS4Cq9m1iL6wp82cfsbeJ0NC75HOG2qQ120V54sxacNsIPc+FM+RhM2dncuDYnG2MfoLT9EaBh25KmGZ0MERIDLJYjvJpDFYgjZDMaWLQb7ouMf4XUOAqwXBk9P0zup6g2Xcfq+VxzX5P9MwKsj2KCmTH/3LhZuZEhuso61hv99acvSyOpOVtmMIj/E0pZkz4JQxlaAsXnEY0wVN0Jx3P/87Tv+ijIlFr2X4OSDqITvvtWgKDwlQY4lK4rd0w2V8zPwk/pHW3RZJuC3QPolPlkGXKrvNQngTd6DX6DjkF3LfXpU21oCGwVZ5AVzOqA3trMx6reaJvN/S477qlD2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2Sht6uI7OzKHznD+Gq4DXDlzXnrn8gqQWBt5fDbDM8=;
 b=YKCkhviD3YlRa6ZYU6MgoW0i/E6ip1eAyIZ5OxdiArUClutTIZY207gf/uOJIHm4VtM62dnkd9vtm7MwHDllCx+kk1QUoRaCyP/GgQP+BIuQWAk/PnHxC3Qnn6yYsBeDfGWfZRIbd5HyJlkTLoQWUDa8+2eEXvRWzbGqxIbHeeYislUHpuWH25iYdV8Nxz0IidG5MDtQLUSLUroiOIhmpmZBeK66ZD9aGmGZ9mhRF/58ZvXzjc3ji8AQnl52cUK+lxxKQzEsxMXw0hf5wjlc6vOKmtWyG9FOntbQ2NTUGQFH6pnye08uNRDUrl2U2ImsffbsOhIqfTCb9wThIql5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2Sht6uI7OzKHznD+Gq4DXDlzXnrn8gqQWBt5fDbDM8=;
 b=to5PY2lkFAKnHWnnfe6DMheyZ4hm5Fz6BOkcAyS1QVchN9/O0lE65b3cwufHHdczJL1mMflHZPi7gFNr+XTOFfbe6KfQeB2Ysel72ugZU0FS334xbl5Mp3svv1BC2iGYG0Cn87enzUq0N5WBnKMdaARdYZSwxf2I73ObV5gaE08=
Received: from DM6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:5:1f4::16)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 6 Jan
 2023 06:14:49 +0000
Received: from DS1PEPF0000E633.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::2d) by DM6PR02CA0075.outlook.office365.com
 (2603:10b6:5:1f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 06:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E633.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 06:14:49 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 00:14:44 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 03/12] cpufreq: intel_pstate: use common macro definition for Energy Preference Performance(EPP)
Date:   Fri, 6 Jan 2023 14:14:11 +0800
Message-ID: <20230106061420.95715-4-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E633:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 2565088e-1056-4d5d-e1b1-08daefad5118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvrg2e9ZtjNpZASKwXlmV/iGwcPzHQ/Mde193civ7t1S6aIU7Y1606PhZkWvHfBWhvwj+drHYBcXihNs3pV98YPAiy9PKWilheLBRYs0nhPgYo6GeNV5sF+8ktgfPCAH/RiylwG1gVnvS//6fNEmX2wCm4lOSejaeA4a/iga/52eSiqWr09gJsOtCrN/1RMjDV8/8vdklsArJFHr0JEHPkFJoxBqqXlE84KkRAloC+xnzwYtZe2nFDD6BJNO/k591cCWhaO+S9DOX0Exc7vPaThdUIWtw0v3gB+IseonphTVTJbRXl8SRJNXyEaRkqxQ4alwR7b4kfvt+AojNZhqu6v/c8JCLK76boUT168ONEoMUZU422F5vEB6c7+x2EyTI9W320XpzXLKMIheD4zOwn6j3/twayO3359fJcCH7es6oCzaf1fD7WGyTR2+QkFglvg5dUXSN6J4RGeJjhDuar7EBiNEyaxYOSf8igMjd94cH88htos4Gu468t3tgiOZUEZ+02ZO+VZvePThkpy5/Kv02+KYdGuSbX7EM8SqHvNprEeC25LeIawmVpbwO2IgN3kFjfne7tfgkpbTltXxvDdqfE6P8EI4fkHWMriqm2VQzJEVxWSvc5VFaYaZEQpKonxs4FCiHQyC3aHbItVecL7UdQQnWvgW9W4N8EVx+DmgJoBR4pdpa80xz3o1032N7IV3lSZqM/axMpgvsNFbwHj/ryxo+Z0+m28XsbGA0o0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(7696005)(186003)(40460700003)(26005)(40480700001)(36756003)(478600001)(16526019)(86362001)(41300700001)(316002)(336012)(81166007)(82740400003)(426003)(36860700001)(356005)(5660300002)(2906002)(44832011)(47076005)(110136005)(83380400001)(8936002)(8676002)(54906003)(1076003)(2616005)(82310400005)(70586007)(4326008)(70206006)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 06:14:49.4531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2565088e-1056-4d5d-e1b1-08daefad5118
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E633.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make the energy preference performance strings and profiles using one
common header for intel_pstate driver, then the amd_pstate epp driver can
use the common header as well. This will simpify the intel_pstate and
amd_pstate driver.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c       | 29 +++++++++++++++++++++++++++
 drivers/cpufreq/intel_pstate.c | 36 ----------------------------------
 include/acpi/cppc_acpi.h       | 10 ++++++++++
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 0ce6c55a76ca..c7aa190ec2d2 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -42,6 +42,35 @@
 
 #include <acpi/cppc_acpi.h>
 
+/*
+ * EPP/EPB display strings corresponding to EPP index in the
+ * energy_perf_strings[]
+ *	index		String
+ *-------------------------------------
+ *	0		default
+ *	1		performance
+ *	2		balance_performance
+ *	3		balance_power
+ *	4		power
+ */
+
+const char * const energy_perf_strings[] = {
+	[EPP_INDEX_DEFAULT] = "default",
+	[EPP_INDEX_PERFORMANCE] = "performance",
+	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
+	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
+	[EPP_INDEX_POWERSAVE] = "power",
+	NULL
+};
+
+unsigned int epp_values[] = {
+	[EPP_INDEX_DEFAULT] = 0, /* Unused index */
+	[EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
+	[EPP_INDEX_BALANCE_PERFORMANCE] = HWP_EPP_BALANCE_PERFORMANCE,
+	[EPP_INDEX_BALANCE_POWERSAVE] = HWP_EPP_BALANCE_POWERSAVE,
+	[EPP_INDEX_POWERSAVE] = HWP_EPP_POWERSAVE,
+};
+
 struct cppc_pcc_data {
 	struct pcc_mbox_chan *pcc_channel;
 	void __iomem *pcc_comm_addr;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ad9be31753b6..01431e279be6 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -628,42 +628,6 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
 	return 0;
 }
 
-/*
- * EPP/EPB display strings corresponding to EPP index in the
- * energy_perf_strings[]
- *	index		String
- *-------------------------------------
- *	0		default
- *	1		performance
- *	2		balance_performance
- *	3		balance_power
- *	4		power
- */
-
-enum energy_perf_value_index {
-	EPP_INDEX_DEFAULT = 0,
-	EPP_INDEX_PERFORMANCE,
-	EPP_INDEX_BALANCE_PERFORMANCE,
-	EPP_INDEX_BALANCE_POWERSAVE,
-	EPP_INDEX_POWERSAVE,
-};
-
-static const char * const energy_perf_strings[] = {
-	[EPP_INDEX_DEFAULT] = "default",
-	[EPP_INDEX_PERFORMANCE] = "performance",
-	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
-	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
-	[EPP_INDEX_POWERSAVE] = "power",
-	NULL
-};
-static unsigned int epp_values[] = {
-	[EPP_INDEX_DEFAULT] = 0, /* Unused index */
-	[EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
-	[EPP_INDEX_BALANCE_PERFORMANCE] = HWP_EPP_BALANCE_PERFORMANCE,
-	[EPP_INDEX_BALANCE_POWERSAVE] = HWP_EPP_BALANCE_POWERSAVE,
-	[EPP_INDEX_POWERSAVE] = HWP_EPP_POWERSAVE,
-};
-
 static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data, int *raw_epp)
 {
 	s16 epp;
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 6b487a5bd638..891e5add0e49 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -135,6 +135,16 @@ struct cppc_cpudata {
 	cpumask_var_t shared_cpu_map;
 };
 
+enum energy_perf_value_index {
+	EPP_INDEX_DEFAULT = 0,
+	EPP_INDEX_PERFORMANCE,
+	EPP_INDEX_BALANCE_PERFORMANCE,
+	EPP_INDEX_BALANCE_POWERSAVE,
+	EPP_INDEX_POWERSAVE,
+};
+extern const char * const energy_perf_strings[];
+extern unsigned int epp_values[];
+
 #ifdef CONFIG_ACPI_CPPC_LIB
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
-- 
2.34.1

