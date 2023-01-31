Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D8A6823C7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjAaFWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjAaFWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:22:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE08E06B;
        Mon, 30 Jan 2023 21:22:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOzt2dbtbmpzUP4W5B5AnnbNmnon8LOyqJU3TJ4bqxqURoSVcMI4Zi3xXQQMkCGkHxPlm7l7iTEgrLu4WOk6ZZlViLL24r6xanfeTn5NUDlvPBN//6pTa3dma81L3g9fw1ISCm2Wx+r0F76MQWjipZ60JkkQGNA8tkhEL/lUEQ7KRoYcTCMNZe5HUf8DPgOfZKPZhbNL/9/0o9mt60kwcGXLV1SeSfePVkbPPNg16DuuQmrW70VVVzoyJuX2AOp7AF0RghbGmpmjVwrdABYEiVyqdSv3kSU2j9Y4P2pILJ15hce85gNwuM3y+A/vcC/wzHGcrrWWsN8BndHaUauJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsiOFCzxXXHGF0WkBet0AUOBlPFFzUwh9PMsK4lNcwQ=;
 b=hf+ZCL0Q9gRcFmN4XI1xRNrQ4aWEpPn1+zw1GkQm9lrUXvFj264PjLsxOxl2Dbc7FeY8vKYvH0kDSq/89jQeEOInGED0jIhYidtabY/M+cfjfLaZcYOiAtLB9J4Tf1JLNa+8id1Yy8Z2K/e2xcRcklzPDXkeZ9/JLBmOFKG8pYwNpc3vpuFdryihY92T5pHJKBg11CQcbmogA9ulpzQLNLv7ZxZK7Jrwl5ufmSlcEEQgQkondHqoNWME4ferqddzJqMDOnOezpBJV+ovqDZkHOwqOQgw+j9T67TDsPHnTDnGB7n5m80+waDz8eRmKmYPF/8spJ7gon040tXH8kxgGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsiOFCzxXXHGF0WkBet0AUOBlPFFzUwh9PMsK4lNcwQ=;
 b=ob8fwsLJWal8W9GhpU8GeSqQ8jqzt8mc4DzN5xBBHAl89hVNDFjgPKCoc1FCddXDFxJGLHgcNZ67fNlHzdwKFC0JS2WhgMdERb1gpLkq6qTsLjkbaFaYdPTCUvDN4bm7EzwRiKVogbg7sZHB5OFzGk2VGkj6uiakMEo43en7+Q4=
Received: from DS7PR03CA0262.namprd03.prod.outlook.com (2603:10b6:5:3b3::27)
 by CY8PR12MB7416.namprd12.prod.outlook.com (2603:10b6:930:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 05:22:30 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::64) by DS7PR03CA0262.outlook.office365.com
 (2603:10b6:5:3b3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 05:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.31 via Frontend Transport; Tue, 31 Jan 2023 05:22:30 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 23:22:24 -0600
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
Subject: [PATCH v4 1/6] acpi: cppc: Add min and max perf reg writing support
Date:   Tue, 31 Jan 2023 05:21:36 +0000
Message-ID: <20230131052141.96475-2-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|CY8PR12MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: 8938f719-32a8-46cf-2dc1-08db034b263d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLOT0INK6iudCZ1qaaUzFt5/Gk6HInG4HEJdsPSLOq88jFBYauqZ69LXK870+qdCPugEWLQWRMktB4bUiWKFhKcnfPbQw47E94JRQOCG3pjZFXjeeoEpMW3US60BbuNXiGQaFPi3sp6S2vdwsWnP4ugIUQYQeValvWdeMS3z/fye+QCEdZ81KR9sCKFH4HJwwv3FqO6eokIy6lYhrNKdglf1/78Q5dZB7Axni+JJEzlYMkGUzRanBw9OM2j1Xzd27l7I4CNBap8m3TYrUGuVU9EQmKBJEfEHv3Pz4efDOMYNRXANxNbwt12SNs2QYnp5f4p+5KPnzV7NtJhJr9v6JsHo0knn5WG8ZdN1v1nxAo9Jqlcu8/6/5w/GnzSy+9rMtywWOZ1tybTZfYKZ0CrDJZihBAkqqFcPJwWDOd/MYaEQcpWru/8iEAxrhsvJV8FlsNwP//VxqzErtBeCOq00WACSOvYEwOgJ4up0V6gjphCzIVVjEv92bL4SXqA6CLu+BPHTKJGA05AOYVND1nNEhqCTLpnf0lJ62EP3ERe3HlBf805pl1uaFzwVJUznPXNaHbRtYzFVI7pL/0SoBcEw4IHLUGCJoWSM9cJMSQOGxiqGQZXnIww/cZ5rh73YEw1odT2M/ja+2Fqn/oGeRISHvkFAVXVaVmodG2slBga9wjA1m7UW2yFpQesK2WVJ6EcmjpwNoi1vWBndGddyfifQfVDPwWGE58U5Ci0W8Z+YPmc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199018)(36840700001)(46966006)(40470700004)(426003)(336012)(82310400005)(83380400001)(47076005)(40460700003)(86362001)(36756003)(70206006)(70586007)(8676002)(82740400003)(36860700001)(7416002)(2906002)(4326008)(44832011)(81166007)(356005)(40480700001)(41300700001)(7696005)(478600001)(316002)(110136005)(54906003)(6636002)(1076003)(6666004)(8936002)(5660300002)(2616005)(26005)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 05:22:30.1250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8938f719-32a8-46cf-2dc1-08db034b263d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7416
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

