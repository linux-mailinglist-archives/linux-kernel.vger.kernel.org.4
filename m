Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A2A6ADD41
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjCGL2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCGL2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:28:43 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE1430283;
        Tue,  7 Mar 2023 03:28:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCpB9axGZVChc42IdlFv/WVx4Yvx9v/g2jLJ3bsH/bduFgd2iWWaYmB5qCBWgIcWWCmHDP9fto0lKFVnuN+MZwmo0OmZe3Odl/YGFbNk8mIfTw/7Z4qshjhVrdVoleRcpQccPPlfwtaDR98hhqafaUg2t1xt68LROvDIMypXx1hyR1BG598f6C1JRyfa496syg6z2JYd6UdKptA5eu+PWEBrSs+QTP08ZpKpduf4jfyPmo9DYSEyO/A3noEYc52gAvBKmmwLgYxqOO3LcojTCupF/kOgU/z6wrFZCRaZNzp2Qd/PM5kXzYBVQpDFuyJYJliYwMsaqtPhYUpYfVBdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SrTyn5JzOOvna1mFPcfW0xvZh2iUlGl5TCSd8BQiNA=;
 b=GOcAhIpEjLRwL61B017gmDOdhLmxCimX1zf4mDiLqUQPTho4yhQyT/AoLk8tcvLuQCeo33t/G05d6kWPnAZ+WwGUD9sCAOBHdgK3bd0PGrLzO4B+Pf1iDNrhPU7QIsAX2mzctKuoLDZkE38PtldZyX2uztUDXxpkK6B08YBgYxRdPor+rKiNkq0ia71RzfzJy37DF4mx1ioYq0r1cZBF8Ngy5Gr2ucBeyLtxDTF74xBWv1x/mj+5o1fsHMywIkQh56ItQe6vH53KDKCzGDzldx+oP6b9KG3c1HF8HVdC2L7/mGrlY0nPA1m9pzK2R1pT6A0AAT1aYhpxJqIMsY3tMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SrTyn5JzOOvna1mFPcfW0xvZh2iUlGl5TCSd8BQiNA=;
 b=o4Fotm8um0EUG36EHEmOrPJKHUyhs+Gibldi2Nq8ej80azalR6X7JZMAZtz07HLX9wKpm8BwyiDQd6zuBMw3OAhfOb4v/lw3ITKb0Yjosz/GYF/O+ObdX74xj3FyYnejF6Muk3qGWDrovtbw6pNc7pSSHjy/ZBlJ8H1aDW8IAxk=
Received: from MW4PR04CA0299.namprd04.prod.outlook.com (2603:10b6:303:89::34)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 11:28:39 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::13) by MW4PR04CA0299.outlook.office365.com
 (2603:10b6:303:89::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 11:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 11:28:39 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 05:28:24 -0600
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
Subject: [PATCH v8 1/6] acpi: cppc: Add min and max perf reg writing support
Date:   Tue, 7 Mar 2023 11:27:35 +0000
Message-ID: <20230307112740.132338-2-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b194c00-0492-41e5-285a-08db1eff1944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xD7VXBQtkKz9xwnXhG0J/Hlwl5xuv+Krlg9r129zl5WH+Rq2SpprUrxQHav3YA5PBwk/ADre1sT+u1hHKVwkoQ04ZnEkBNXOlBude8oUPW7xsGLSGB4OYjGZSIXtAv+PBZEz7oXkVIoVXkCqT6MqYrb+SUZcMRmr1ZNwNCtJXXk2iLOIoKnPUu22IJWkmQ9puVAKjxCTSYTzZZFvRYs22hlvtV/kO72hbKBoDWNL1dL7gAE8plnA0B+9R4oJnjRKASlkzd17TDnH1F33QBpe4CU5U5VOIKg88nmea3MTPidjhKwqDyNOh5agtupG4bZ40grdQ/rLPVL/gvJWoI9j7/faTx4nhQ2XwovSn9gwll1t/KwRdrhAEVYTaqpB4NFeWcBgB6KgxxLV74sbMza8bGZPg38xElmcGOepJNOuOCLMFaiPtvep8dGpPFovf8AjxyJO/lIK6CaUohUOgqQgg2yLRom+Qwy5eoJ45k+WLCF7dH6yDGOktoZBNMuzRKH3ZLeZ9OA8zwoPfTzpDjZTdfjtS5PMFqSo/BRFS1mNfdktMK9vnyZvwJnb84D5vdsevmZRBJlUaaz9+ORfw2j6hJc+HXjAHz14xe7eq1+eR09HDN9EaDuqdCU1wNGvta8dh4a+GUhr1sil9EcUHsTOm28p+JYus0NUE5WJ14219ByvcarOV8MOThHzM/uAN80CTdLB1BlO7L/ATG6Y79juD2i5WN46SkPYGdsM6GD7YkE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(36860700001)(81166007)(86362001)(356005)(82740400003)(36756003)(6666004)(2906002)(44832011)(7416002)(5660300002)(40480700001)(70586007)(70206006)(4326008)(41300700001)(8936002)(8676002)(82310400005)(16526019)(336012)(186003)(47076005)(426003)(83380400001)(1076003)(26005)(2616005)(40460700003)(6636002)(110136005)(54906003)(478600001)(316002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 11:28:39.0885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b194c00-0492-41e5-285a-08db1eff1944
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/acpi/cppc_acpi.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c51d3ccb4cca..4fea6b8a26cd 100644
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

