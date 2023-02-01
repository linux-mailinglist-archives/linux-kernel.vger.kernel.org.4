Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFA6686022
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjBAG7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjBAG7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:59:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30B04ED2B;
        Tue, 31 Jan 2023 22:59:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msEzLFnk3625uHVTWTtNft2meg67+SM/mryAqKRkePCE60plxohpyoJ6T2nVFh/UU3RxT4RUt5xYdinSWlO+w22Qm+S505S4cMZ/Zz7NRlTwm+zR35FzV0HEy/uEUX+LButHqmqJTdWO8B4k1V2bShf3RzvzDBmM6iE5EgYa5Q0uJSF1MO9g+vUkQgaKX8tTI1J9pmAglq7zHvYp/gYpe+lA+dusz8A19NVTXcLLoOXGjs2mC8zRyk6UQd6Ywec83eoIE9LLXVP2eW97OQEQfVWxTr2sbMJUSS1sCYMB0b534l236XQLl7+15y+7Ar7n9W+LAzdGgliZghqHeVEExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsiOFCzxXXHGF0WkBet0AUOBlPFFzUwh9PMsK4lNcwQ=;
 b=WCOT7k0hDwrxYWRjd8QEzcVJ/I9pz5mHqk58dw7sRyVqIPivrqW+LiKgWNJVplVPyuBP/h9TqWn8sOrktYgabdRCRCEz0MgjVbMCglzKzXbGHTmZqrpaJuagaUk0s7vob4HImTxvFosZJwbEQiWOu+xpAOunuydG+gBTFN8Iu6XP9pQrhLJCQ322MQb0a6QqU/xgjUJui6M5/3ZVqEDhUmIwceph7TFL8IHDYMrvaS3+VZy97hnBFEGOvrHjx3bkA+LSHW8d3LgAEwxMbknb+0uLqUB638FPd+bofgBGkZ1xR7iq2+2HlV1B90a4gKh3O4I17LMorRS6bLvBbWX53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsiOFCzxXXHGF0WkBet0AUOBlPFFzUwh9PMsK4lNcwQ=;
 b=S2AfdBfyMJhpPbGEefwNZIycOMDOYEnQDoGLQH/k3KZOZabXJu8tS+DI2gFcptDkaf5msDPTqzqkwu+E6WZN5f5Uei1teHno8Q96+MxeVW0jxbFohzzyr2L9rfgJZ17VEFp1DgAbd7Awi/upAECNngcGPFCGuxC7QcApnQkZ4Gc=
Received: from DM6PR08CA0065.namprd08.prod.outlook.com (2603:10b6:5:1e0::39)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:59:19 +0000
Received: from DS1PEPF0000E658.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::33) by DM6PR08CA0065.outlook.office365.com
 (2603:10b6:5:1e0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Wed, 1 Feb 2023 06:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E658.mail.protection.outlook.com (10.167.18.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.21 via Frontend Transport; Wed, 1 Feb 2023 06:59:19 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Feb
 2023 00:59:13 -0600
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
Subject: [PATCH v5 1/6] acpi: cppc: Add min and max perf reg writing support
Date:   Wed, 1 Feb 2023 06:58:18 +0000
Message-ID: <20230201065823.189828-2-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E658:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: e4934e3a-0a43-4b7a-2854-08db0421d72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+/tmFji4dU1AcLyWStnJA11O748gOf9xBdhwZmH+f95oA8rDat3bv/yYtwo6dx8Ig1VbxtT890uoZs4i5lBjVOIPD4zCmhXNbPckpdYG+Au573qR2fniFklQDQwHFbHYQ2koFS7qRi0AnAh2Ol2UwxGalN3J+ukahdjSDBGEtbeX0GDrAPqvavVDQ5B5tQrwxjJdW8Vx45b0pslyvWuVv6fB9BZNZnO+VsSYv9BG0XBhzAX8o8h/53E1u6+mHz2UjstH8eYfImP6LKS69x9LxRsdyuV+F5mIFcvlopKDzptE5YDrY1UhNvayJvWVd+HOaZ6tJVoWKCCwh+0vpJe6IOhdcJn1PrvGT6k5kCYqNNLqjlrHVO8vsi9xU7WWd0f+Vg/XFEkPqg2z67vl4Dl2ixfhOaIbVKwyauQYaXbGY2rbaINRxeJiLPSijV1dd/ZZNiu4n9Dqyv4coOMohxR+Cecc/LEfi56sj9HaQi/vbHluxtDtqw6EI0yr/vJFDwFZ8eN/wa1/A7m/AyPH8P66XzmzdHBVKx6cZIj8K+mdAXuuRZD9dw0wSWABtwAQiZJSYniiOSKp9ik0hKCqrIAGeqp/dUaRqVjs+dE6XJ4d/LIES06VVKkM4KE+qQVZqtvVAE7zFtdIoX43UzFxaYGBduVBgn7aJgoxquHFqrERRyst3YqhpibGwJYYxqBaS7pTDkFpecQ8EUOhQ1GM2zGiYTdlbMwyl0qjX6A9bEPKxI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(36840700001)(40470700004)(46966006)(36860700001)(426003)(83380400001)(82310400005)(336012)(47076005)(40460700003)(86362001)(70206006)(36756003)(6636002)(316002)(70586007)(8676002)(41300700001)(82740400003)(7416002)(81166007)(40480700001)(356005)(44832011)(2906002)(4326008)(7696005)(54906003)(5660300002)(1076003)(478600001)(110136005)(26005)(8936002)(16526019)(186003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:59:19.2924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4934e3a-0a43-4b7a-2854-08db0421d72d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E658.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently writing of min and max perf register is deferred in
cppc_set_perf function. In CPPC guided mode, these registers needed to
be written to guide the platform about min and max perf levels. Add this support
to make guided mode work properly on AMD shared memory systems.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/cppc_acpi.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 02d83c807271..91f9ef75f7de 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1487,7 +1487,7 @@ EXPORT_SYMBOL_GPL(cppc_set_enable);
 int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
-	struct cpc_register_resource *desired_reg;
+	struct cpc_register_resource *desired_reg, *min_perf_reg, *max_perf_reg;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
 	int ret = 0;
@@ -1498,6 +1498,8 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	}
 
 	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
+	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
+	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
 
 	/*
 	 * This is Phase-I where we want to write to CPC registers
@@ -1506,7 +1508,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 * Since read_lock can be acquired by multiple CPUs simultaneously we
 	 * achieve that goal here
 	 */
-	if (CPC_IN_PCC(desired_reg)) {
+	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -1529,13 +1531,19 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 		cpc_desc->write_cmd_status = 0;
 	}
 
-	/*
-	 * Skip writing MIN/MAX until Linux knows how to come up with
-	 * useful values.
-	 */
 	cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
 
-	if (CPC_IN_PCC(desired_reg))
+	/**
+	 * Only write if min_perf and max_perf not zero. Some drivers pass zero
+	 * value to min and max perf, but they don't mean to set the zero value,
+	 * they just don't want to write to those registers.
+	 */
+	if (perf_ctrls->min_perf)
+		cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
+	if (perf_ctrls->max_perf)
+		cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
+
+	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg))
 		up_read(&pcc_ss_data->pcc_lock);	/* END Phase-I */
 	/*
 	 * This is Phase-II where we transfer the ownership of PCC to Platform
@@ -1583,7 +1591,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 * case during a CMD_READ and if there are pending writes it delivers
 	 * the write command before servicing the read command
 	 */
-	if (CPC_IN_PCC(desired_reg)) {
+	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg)) {
 		if (down_write_trylock(&pcc_ss_data->pcc_lock)) {/* BEGIN Phase-II */
 			/* Update only if there are pending write commands */
 			if (pcc_ss_data->pending_pcc_write_cmd)
-- 
2.34.1

