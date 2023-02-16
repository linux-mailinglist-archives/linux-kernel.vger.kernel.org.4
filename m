Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721F6698E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjBPITE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjBPIS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:18:59 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547732686E;
        Thu, 16 Feb 2023 00:18:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSTE7UMM2i/ME4nZp9Q6Klq5L+fZ3cRaKXfO8spkzAp8LfU/IDgq/VqWp3iR1J3nmJyfBWjaSDKSyqYO12iGYFF/AJFjmGc/aqVlVhW0MeSo0dtM2VtX9zfA73HB/PeQwkS2FWTkmPx7oM93aSSMEU1ENJLEGrg7CQYO28JOIVgrOVD2RbiMuX0s8zRo6m9Yuhc3scUGudrtZjTzajEUk8zUg3UGVI/4OHS6TDWsxKR0p+0NhB2mQbu40Kp/ehkdSydB50kL+wBGFpT3Z9j/i8iO25sfnw/P7+95iIDQIAE3rT7ShUxx5qgn6N0lqUb6tzofQmBV6p7LZyPOwkQNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSKDBxUmRAcUM3PI9beHLou2ususF+MgwWY1hu7cSh0=;
 b=JCrN1zqkAHFYljFt/NyXJbqhYbcKiKwalqOYC84M6BQmBRR141VqRLu2jCVEs3jBVmup1FxoBBJPGDdaB5vYEL693NYFcjx4u1dA00YJdSqoXk62lqqZYSvOwKxzH80Vv68/owWB8XBlltwYOe+fHr+iqdMoIZbiAzQe87RgJuDIJT/3ZPYLTt08HOFGVAFHcrcb1IWCspZpAyausaB9QsBtRsM4jUd/0EPjpsQMP56fHMFbn4CE3vpBJ2EhW0/ne+iKqcrsGQG21UB0N1LlJGOvsLSWTyq1Hx46xDb8I0ThXEpDgWrTdqWsoBT5XxYJ96DycYM/SgIfgys2FShUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSKDBxUmRAcUM3PI9beHLou2ususF+MgwWY1hu7cSh0=;
 b=h6Z7Z1DCthnA4lAW6y5PTzNXlXk2M5i8WveI3gdVWG1YH502mDAJab7A5f1kQcGCy5M6fCv1AiiyE45f+T+3PalnMfQcQpRZDQE1ujI99Sb7+OL/qEj/KQwFeCX+mtITeTiZqCEk/EI7Ia6sUH5uFTXulioC4+YRFeCj4paIo7U=
Received: from BN9PR03CA0385.namprd03.prod.outlook.com (2603:10b6:408:f7::30)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 08:18:52 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::ea) by BN9PR03CA0385.outlook.office365.com
 (2603:10b6:408:f7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Thu, 16 Feb 2023 08:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Thu, 16 Feb 2023 08:18:51 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 02:18:46 -0600
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
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v7 1/6] acpi: cppc: Add min and max perf reg writing support
Date:   Thu, 16 Feb 2023 08:17:57 +0000
Message-ID: <20230216081802.38007-2-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216081802.38007-1-wyes.karny@amd.com>
References: <20230216081802.38007-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e771f6-107d-4e07-fac0-08db0ff66fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78KGImCB36weUKYvIIcUSoe6XsYiDcalnmBr4Tgx2MUEKhg0SjeYfP1M7dHSWld2hGEVohuUECaVzYyaHnzP3EuAFqYrB83w7tGCs5y77OwFIDpMlV/OrfcsCPHAvJuulcpBQ1ToWL+xCZQtlz+qbdZm5Tb/YmYqYOWjQdaETScEB6cYpl6jOVT/aua9S89wUhCy3nluFmyeJYjLBSXYXuTLXsTRJAvEF3U2i0JvlQA+3NtB6mfY+6hfrAi2ozAuhdVBg3lcWj+2juAfrh8KPV1+QzUe48piC/Pl/6D9zm3OlIwkhycwW04rSDaDuKjJfrFlS/OdJMlpTzUn453u1joKchbb3eYvooLVwSoy9YhSOB68fxKE0REe/3mg6A36nLAx4cwVRv8om6QWOsl0Rndv50cSHFigzRf9+WTzI9igV2zrtM3sIguevCZQ4EkIAYJGjsb7s0KU+E3v0md6AXgoWNwSxmegPcx9nLiVgVA9Pv1EvugBbGUYaBi5m4RpbtvGCHkMkf5P3q+rO+LvFtgnMQhOgp1s9wV3qYN89f9lAFnUC5dCq8HWC5HOqwJ1G2c7KXOyHcEsvszLa2w92m/uMSUsFEOUeiBO71ejHeBCmcgBFW/i0Od7kEqsGfa1z8OQv0WGxzofguTjjnyWLfEyl+hdXFr+4UDcDDozFd+4sZ4Gq2LyQeXXd3z3Gy6QaKWVWn+tRGe6EkbfGLGWMUJwWpkVWIuJjC9zwW4BpN4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(54906003)(44832011)(5660300002)(41300700001)(7416002)(8936002)(2906002)(70206006)(4326008)(8676002)(70586007)(110136005)(316002)(83380400001)(40480700001)(26005)(186003)(40460700003)(6666004)(7696005)(36756003)(6636002)(478600001)(2616005)(1076003)(16526019)(426003)(336012)(47076005)(36860700001)(81166007)(82740400003)(356005)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 08:18:51.6630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e771f6-107d-4e07-fac0-08db0ff66fea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270
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

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/acpi/cppc_acpi.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 09aa4c4f9bf5..ad19e4a91e4e 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1488,7 +1488,7 @@ EXPORT_SYMBOL_GPL(cppc_set_enable);
 int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
-	struct cpc_register_resource *desired_reg;
+	struct cpc_register_resource *desired_reg, *min_perf_reg, *max_perf_reg;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
 	int ret = 0;
@@ -1499,6 +1499,8 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	}
 
 	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
+	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
+	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
 
 	/*
 	 * This is Phase-I where we want to write to CPC registers
@@ -1507,7 +1509,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 * Since read_lock can be acquired by multiple CPUs simultaneously we
 	 * achieve that goal here
 	 */
-	if (CPC_IN_PCC(desired_reg)) {
+	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -1530,13 +1532,19 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
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
@@ -1584,7 +1592,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
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

