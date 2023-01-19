Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4960667376A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjASLvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjASLvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:51:18 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5A646086;
        Thu, 19 Jan 2023 03:51:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er7t9wN9bYry+DRqpqPOSmRBNHkwUQfQch08BH5L9IB9PaS+JywmuQ3ZNW2gzdSxBQAwegr4NkaCk7ta5Yh2Y9Zmt9EfPfFgdAtKfVVrbvBB3pIi4CdAh3/lUNHbH1i9uaVvzs9q0FCGrjEd1SYyCargg16ONHwOdthK5xmYqegpfTZaB5csTX2W2bcUwWdStGCqTAHLGL6kdwSByNpHX8ThAsljgg1kxKQMeDHrziwMX2i3d1pbQqq7kiAhfu6IXLYYsgP81YoQtyN188hurAgD0s/SCVPQdUAYyGIYLGH1S8EgSe61Gga7XcDr/8qfeL3O+JXXWYduBpbz25pfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAmu7Y2MS+O8fjWpELf1F2AX3fR9gUXskyFwpXcHx9Y=;
 b=N1/iP3SKi01lVvneAcZalvSEqwhy5vKdq8hGR4njeew+Yxa5BfPA/A3SH6YAeTifmxIdr9LLdosaoCJsOgf9SJqjZ2cZsSHUuMtztJnjd7mVCbk0HGQxYtD8ajLhTyvwqO8G4lIRs/Ru0xQGJN1vtSm2on0SBd7FvggXiw9kdk/vh5X2HFki7mgbFAq8PDI1cnzG0wOOlpdxLIEuVql4k9UDVthLjK32WkQXdIqZjzhiDf6I048bXlqdfiDL2hCEWpD33hoCJOG/esXZRZWMwSTl+ComOuIJRg2y3ZNu59SRjv/QyKwmSR6f5YjsVc+HFaEsHuw0DNr55U23HTLxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAmu7Y2MS+O8fjWpELf1F2AX3fR9gUXskyFwpXcHx9Y=;
 b=CTOAPsnRDDvLeeSGRCKFUa4cUVOGIU4+2TgSPruj5clPW40NHEBJDJe8VAzukAP9gQhVBX1MAocjQ3koyQpW+xA7V6uURLQoUzbF0bQWx765O0fdm+1ci3t8WqIKEKg/BVnd/LWPLTRmGYb6rNE7ni2OdQ0hEtvDjDNgZgfuuMg=
Received: from DM5PR08CA0026.namprd08.prod.outlook.com (2603:10b6:4:60::15) by
 CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.24; Thu, 19 Jan 2023 11:51:07 +0000
Received: from DS1PEPF0000B074.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::fc) by DM5PR08CA0026.outlook.office365.com
 (2603:10b6:4:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 11:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B074.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Thu, 19 Jan 2023 11:51:07 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 05:51:01 -0600
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
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@suse.de>, Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 1/6] acpi: cppc: Add min and max perf reg writing support
Date:   Thu, 19 Jan 2023 11:50:12 +0000
Message-ID: <20230119115017.10188-2-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119115017.10188-1-wyes.karny@amd.com>
References: <20230119115017.10188-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B074:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d22499-4cbd-41e6-afd8-08dafa137350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNyRYn5DH410EwtGE16jrcYqQ7szWWExEenDiTCAi6be9089W46u/9cc6HSAhgnVQUO7Wp7uW3JOOXv898dBg8fThboJuGKWTOcGAn2uluNCLre4p0fBu1aqPufYuPybwBMjg9TMHquVZ2pl1D3HPdbHN3QGqB4Dg59YxnTbfOGbwQH/ppuFa6AwgK9OghsQElXZkUFcGNFIOZitXHhgtNxltQ2czG73mXJ5J2L8MP876MsrauTBkEfKdTnMK+mewToyDXYX6+nV6bE8g3P/bVmHnKuhUQEH/bjWB3MkfjZssAEgAM6zVXBoCAngw7tNmo9RMro9JmS6gcTw/8MNlJMnEVSAHyIK2UStZzfJb7rncQTvYq434SrSa3tKcGpqORagKXyDkHPE3qw/nKZWNMHHp5ueY5JIKDgSWSS4d6HCp0tpAoeTdWqn3Q8W0SjTgDUyjihzkayqxGLpr9R0MFtiy+KgQUPTsZd2JXsTLjQQXXTf1T5Q+kCwkMhMD91n+BuR267eaIxpjSIE4ghWZ426roWdj/RvZUqiJyIWwjkvtUkf9bd5Qw4VLXe7SZouwTus1rKQU+iWE+vpJpP54u270q5mZvw+0aX1wWWulp3n9BA3qDTANF1Y08R01bh5gwS3WWP8a2chO8ki4lrz1Rj/TujSFeyocgVHOM/RFOCSnqBHkXnZdn7vhERh2kVg0EMDX0OsQXppY8bSA464qq6N1Yp4IQwngMq+RCx/i98=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(44832011)(16526019)(186003)(26005)(2616005)(478600001)(6666004)(1076003)(6636002)(110136005)(7696005)(336012)(54906003)(70206006)(70586007)(8676002)(4326008)(426003)(83380400001)(316002)(41300700001)(47076005)(7416002)(8936002)(5660300002)(2906002)(36860700001)(82310400005)(40460700003)(356005)(40480700001)(86362001)(82740400003)(81166007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 11:51:07.1555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d22499-4cbd-41e6-afd8-08dafa137350
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B074.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/acpi/cppc_acpi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 02d83c807271..c936ff503965 100644
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
@@ -1529,13 +1531,11 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 		cpc_desc->write_cmd_status = 0;
 	}
 
-	/*
-	 * Skip writing MIN/MAX until Linux knows how to come up with
-	 * useful values.
-	 */
 	cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+	cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
+	cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
 
-	if (CPC_IN_PCC(desired_reg))
+	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg))
 		up_read(&pcc_ss_data->pcc_lock);	/* END Phase-I */
 	/*
 	 * This is Phase-II where we transfer the ownership of PCC to Platform
@@ -1583,7 +1583,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
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

