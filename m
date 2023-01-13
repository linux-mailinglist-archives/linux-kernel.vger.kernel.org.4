Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE4668B30
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjAMFXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjAMFXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:23:05 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE7062192;
        Thu, 12 Jan 2023 21:22:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGJFltBmgtttup+kK9BGXYUKFWOxMUnuB2+Er+yK5xIJxVSyDtdT7bFvDSYyL6POf+8wpFn3k7Lpmw14+5D6bZgQ50gGlAIOQyMgg5RJ7YHVRCoofJKuh6gD8vYq3/QghuMGqq8hzyuiTu+cyHBevByxnytO5ckccRcrrxyD4EuGP0PBriDh+w6bRKx1QEt9dVKQl0RdGqg/s9koS9PEP1TqCvDg3Kp5GXyzRmUffAmCR72OjDRK/JtJCrTDeodfReBd9JolC8VrImNfIk3911XcSlxd6bPZz+f6sW/tJzNDwoZwszm/MMHl6wMve++Pm6s1o4nh6x6gn87dMLuqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm7ZDxu1XcY+5FrrYTlJeRqScBH0gJ8tZ0zxYBMBFUI=;
 b=DOD/rf/K5Mnx32mAOXPO5P1zSUsVlG6Li0E8jS+mjTdNzKZl/qgXo3vD7QRAWsOB6GmEClzUNucuY5fbXoBvCmrv1V+0NFmppcme4amkT+1DddaayFowHn47+c299Mah7SuXf/CCIf12FudGVYqP+rRSH1/v2fL6xYYrx72LOPtzQ2MtXm/bEj9qWA7jAimm5VBJixKIpVfg4a6PH3/MInTCvAYE1qj96w9FubpXcFDSoiT9Y2mibDGz/9JJy7/AE1NEKnOwDny+D38mjqiL8mHL/542l9fMeMlSzfsXD1gegTVtqYrJalBQmM2yZgd1Vp4axd4BJazV9lSVYMDYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm7ZDxu1XcY+5FrrYTlJeRqScBH0gJ8tZ0zxYBMBFUI=;
 b=HAj207yz+WNOc3LAFvTTn7XXcAmRgKo3QfUGEVafM7W/ZQ3ENBf8Zix1KyVYlh1BfLm2XwSpGjuiL3qnukq2BdWSS9Y5PGPAbV/hSf3yfNM/LanHgqdhosdXemrXL/auA4gukqEgxdpGWxx+oo9oKpBdNHAu3eYqSjQhqWSXKO0=
Received: from DS7PR03CA0181.namprd03.prod.outlook.com (2603:10b6:5:3b6::6) by
 CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Fri, 13 Jan 2023 05:22:55 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::bf) by DS7PR03CA0181.outlook.office365.com
 (2603:10b6:5:3b6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Fri, 13 Jan 2023 05:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 05:22:54 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 23:22:49 -0600
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
Subject: [PATCH v2 1/6] acpi: cppc: Add min and max perf reg writing support
Date:   Fri, 13 Jan 2023 05:21:36 +0000
Message-ID: <20230113052141.2874296-2-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: ec807ae7-6ba5-4ee3-bcd3-08daf5263976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPqXb4dLILolb3FNRUtYCrSoZc9jnXHBvjBdh9NbTy2LspmLXN6D8AHEwvHAaPB1l1bd2zPcdlGkWFQLVeTza+RAe3sAiaS7V1UpCT2xHP+3XhGiJ4SqirJGIlAKY18BGC9ah9uTpya5cj2YeK/d7f7mzRPndIfc80S3dh/1A47Y2/YvoEXf9sygEow9eypCoo0R5G9PfE49q/aeEMlEtuRnz0QJMVU0zemDVOiBeNrwOyjsuB1KqG40/Tt9HtBSvzJLYMl0TPbmlzjzz79jp3ddlIUsgbI1zYT3J45bnQB36C87f46cEeilT4cY4EmGwfCuugEr0M4bxajwuXRopPtqdyq99ZD2yJPUJ7twHTOy/n274lnCowq8hgr1/B1IQEFKrgivqg+HziCS3geJkSlDbwXTFLZkHvwjPAI7rJ90nah77h9+aEiH1SM9k4iH4yg4tKuUrOdRf8d02J95fr37kdFVa9ZqF4Hvx9S5VhCVKW34SMs6WYxesGzIwGFam4BTDD0Kkdp/4N1nzprfP8Pm8977wK0dXWJ1yXcCNmue17dHTulU01YcwyvsORzHdwwTcSM4hfVOl4mEoXlWq5KpcTvCJjhUvo9hcZ19EZJ4VimoHaFB6aahOfREAcCzsxHV6wnbjFdTllCRsL2ZRydA8I6E2TN6Z3jWsV0GVebhclKqNX99OPv3iVNJS9RKRVsWqrBmUVXlr8l+xAOttVHNUplq9JInjxJaUoZsTmE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(47076005)(8936002)(26005)(81166007)(2906002)(5660300002)(41300700001)(426003)(7696005)(4326008)(8676002)(316002)(70586007)(110136005)(356005)(54906003)(6636002)(70206006)(82740400003)(16526019)(40480700001)(2616005)(336012)(86362001)(44832011)(40460700003)(186003)(1076003)(36860700001)(83380400001)(36756003)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 05:22:54.7210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec807ae7-6ba5-4ee3-bcd3-08daf5263976
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently writing of min and max perf register is deferred in
cppc_set_perf function. In CPPC guided mode, these registers needed to
be written to guide PMFW about min and max perf levels. Add this support
to make guided mode work properly on shared memory systems.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
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

