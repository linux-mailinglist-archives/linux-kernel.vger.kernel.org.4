Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2895368C485
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjBFRXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjBFRXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:23:01 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2A359C7;
        Mon,  6 Feb 2023 09:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhy4F2jh9Ymk6a1RwRGvK9VsXyIhgqBO+ELbNzdh3WvyxryrYSTn2bGZuSUGbmh7P2y+cH0aR+hQ26UcEf5sq9FLY3HxpzcvgUubSVcJEJzOUDSIG6d/cZem+prZ1uTUjLzghBD60R2zvZZ0TtU0tTe80PMV9GkU33jZInR6u+V9PARVvknLg44FP6VIRfv0pHOcJ+PMtNNqJJTwo+M9R4C0cNsr0h3lorRD/LAuQK+Rjn+b4BZ51s01aiBmXcA8BXEdE5K5c7I6wW+MrdUZIcPWv3lm43qrQAr9BpFqrwyHFA/u4H40qz0qTOBFprhHvKeglstt0a43LfjeAlFIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsiOFCzxXXHGF0WkBet0AUOBlPFFzUwh9PMsK4lNcwQ=;
 b=gQNXvkQJuQ8VZN/vJudHKu0dIbASn/kyGQVdCEoogZ/a4D7b8mdR3OnZcUc+41LC6cdkd0a5upfyMZ+nNJQb8i5L8COM7VR4BJIgnxhw96eCZotlAfVlG+8MLlind3JAzDHGtWZ0O2Lz0nQAEIorO/AeQBo+bQtXLnBH6BviJqaaoGjVUtei0XkzdB9ik3hGt94EvvU3n4b2T6bjXWLzwxMNGLOwHDVxs1vWD/kgGmhfCFBDKm1ZVFTHTk9dkr3XPYdDG6ov3jrO7VRgXRmGv3cbR63r2bC9FjSsYcfp6H/3dwtQty+l0oLRZeHPv7Br9EeWcmq3ubGWzkm/BLHmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsiOFCzxXXHGF0WkBet0AUOBlPFFzUwh9PMsK4lNcwQ=;
 b=Gc9EmVwn7476vbQDJlUk2p7Jbd2j9nzB+sd8in1TAVzfuCtJANUwzUdSPTzLivbtcv8KymHwXjQmQ6lUQ9xyPpauS5BdwuoOvmY4bHrMCgP2CevO+zlwUIZYk6yTDtm2CQBwMEdihSLb/D9Z9yLaNpJre95Lr55Wbw72ylE7m3g=
Received: from DM5PR07CA0061.namprd07.prod.outlook.com (2603:10b6:4:ad::26) by
 DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Mon, 6 Feb 2023 17:22:44 +0000
Received: from DS1PEPF0000B074.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::a6) by DM5PR07CA0061.outlook.office365.com
 (2603:10b6:4:ad::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Mon, 6 Feb 2023 17:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B074.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Mon, 6 Feb 2023 17:22:44 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 11:22:39 -0600
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
Subject: [PATCH v6 1/6] acpi: cppc: Add min and max perf reg writing support
Date:   Mon, 6 Feb 2023 17:21:52 +0000
Message-ID: <20230206172157.49887-2-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B074:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 524a6c09-0c94-4c02-d225-08db0866c285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RzAwhfcRs5zzjbB6cyPFAw0HKSRc2WPVhy53MN2t739sDPaWgtIBwkHRVRqNoQToTId8DpkKpANWY3UT70zEOCplZGyJrLmhwdR3+mr53Pk8ub9ISLdN0e2n6z5txuxclowtQ00zcxkfErlwDymN8nK6GTjLRgA35pZ9ndInnQfD6SGq7pVpdbIkNMRAaTJMclGH2g7paa5GErzAJL588ki4db34FSUjgvkRT3z/QDF5G/e2O6MAUetDaOxbEJtMNL4at3TuHgmir8FgPqShWfqwEM7ywgHvS6FVYYnAsuDmLv84Fwu4NH4YZ7IV8Kzug0lo6IOBA2acm7ZW9CtqhNQICKTTarYeKWdUu/EgmLBFx6PFxbRMACeFSw/MzO3BxvuAJIrQNopgiSPKqiBlDMOSWIp2dK1yeaoSNT4GXOKVegJpLKtQWQ4agJYRW2tm6793zxs2zX9HMt7pVJoguOlDI/7YFrBAm4aoI8+3tQjjnoRtrO7c7SC+w4lCH6rsjZwD2pcziesBFSvTHTIPm3GIucf0ZHOjPSkO0pZfJ5G7e46YkM1dCSp7d/ZMyBjTkGTbtHT1lxEh9M2D944AUG8mHFoGQLoEpVEkqqRhCQDfmOqfzMAKAjKwtqXUBR6uXgLzGhpiqPQF13IKVd+tj3WMTKIrTw3EmRBVDudQt9bkbWUETpNYgfgefPL6JiX2jCMkdN23WRnRabrlxX4Yh+BDHU8capUThxfHi+ZHX0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(40470700004)(36840700001)(46966006)(16526019)(40460700003)(82740400003)(83380400001)(81166007)(356005)(70586007)(8676002)(5660300002)(70206006)(41300700001)(4326008)(2906002)(44832011)(7416002)(36860700001)(6666004)(8936002)(2616005)(1076003)(478600001)(186003)(26005)(86362001)(316002)(110136005)(6636002)(54906003)(47076005)(426003)(7696005)(336012)(82310400005)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:22:44.5512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 524a6c09-0c94-4c02-d225-08db0866c285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B074.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607
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

