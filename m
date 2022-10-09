Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260745F89F0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJIHL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJIHLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:11:34 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4632A40E;
        Sun,  9 Oct 2022 00:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIF60k7cMuuWuEAAH+7MQCZrhDjxb0evQBl2P/fGq/88tYyHlv53b+OAtanuZdllrCcm3AE0rNIlcwiT+vENPvbQmZF4P9vzrn835F1A4VaJXfNMTTUBxWjxpItX/z3Uk0Vl2qlxcLM+sMmr5/6V/nCyidr0+0CSokoZmrphsIZz0BO4Y7SjbNAMhiYvuDCsvAEMrAUXGCO8MlkhtkZnV4zjShwfsiCCp7ZFrxTeNpeC57q6owPzA8+TfvJkJnDdbmDMG7+B+woq8MQPvVI2Q2ov6/HcTCBRdp7IrY9rcc6hmw3FdrV59leSQEOpEOjTVwoKuohuQahIigi+maICSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLR/RPd285R7HOJk/OaThtOEmnZVKOLfnoo2UfZm8zc=;
 b=Wxg/g2Vv8EySs5hJ0nsLv/Jz2gsAYEDdOepzxz441s+x7T0eihxeZmmZhZF8z4de1Lvu9bkldgKlQCD/nZeryAbjaRyfttC1y5penoTSgGnK8l8BG4P79fqnMDHO2sLt6mYMJLoIjdE1yusHQm06TP9QvVjd5YnWqc4Brn5xC28ZZUmEIK+UbiUGdimsD0yARx+A3ywRvI0gm3M8ngaKVmUK3N6GGZf3iUCs0OUojCZxeT2mRNfM9SUpBfcgjTVn1EHPhFRX/AGmCgNavbyZCWB6FXTEc1mHMyYRyUW1k781aTCSpIZ/cl/bSON/YDp6CjQ0rOeRbxr8WsAfJMMjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLR/RPd285R7HOJk/OaThtOEmnZVKOLfnoo2UfZm8zc=;
 b=HPLvyXvyJWt+9O3al0lIZNA7CSRY+ff8lhVqAx6mjsCtsSI5yVR0O5cemKf/xWrqBKJEpWrcwyzvnMF8UNkeoZklsyInvVpNzqhab6Zlkggs9JFWVPXshc//KTFHPDQB5SRoTlSLYHLUVWvXoOsNhGvka+eECRVk+QABX92pVvU=
Received: from DM6PR03CA0077.namprd03.prod.outlook.com (2603:10b6:5:333::10)
 by DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sun, 9 Oct
 2022 07:11:29 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::76) by DM6PR03CA0077.outlook.office365.com
 (2603:10b6:5:333::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Sun, 9 Oct 2022 07:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Sun, 9 Oct 2022 07:11:29 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 9 Oct 2022 02:11:24 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 6/9] cpufreq: amd_pstate: add AMD pstate EPP support for shared memory type processor
Date:   Sun, 9 Oct 2022 15:10:30 +0800
Message-ID: <20221009071033.21170-7-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221009071033.21170-1-Perry.Yuan@amd.com>
References: <20221009071033.21170-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|DM4PR12MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: b16be755-30c9-4a4b-ac41-08daa9c57d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sc4c7eXqIo0lHHmzDcDbjoOj5iVk9iqLpI5BAL2xbs+b/WLta/PL0Lnt4sZkBr07xId25vUwKzoDC03PNYdx5o59NcZlMZvIg0/DGPDwuQu3R2sF4PqvjMSWZXi4S0ZwUU1gg0eC9C/7dkFCQS9bz5oGN5KTnPmxkSLI1RgfLwcGi7t+btNlQ484f66WmN0B/tJs3Nraril04Dd6nDjRYpB01nkkITY2FgD4WIkLIV6BDgfoyPM2PMfCcmNCOAIbb6XBrJhh97bZyJDX0jMNkYeTCB8mlMwOj/YUpgB5amofbt4TkrVWdKTw+qqlLsojPDED5qIRCKHKYPltxPtQP7DnyiiQ/IG0b7vm5wpx992P5YWDAe9vm86oTWZcQ7s/uLCp1AQhEf4rhnT5E+vA0oHBii78Qa/BVum2q51VHOb/Tdk5hPDIuTNxzRqtnyLga4e+zSDyh/3ME1ft2p9e95HXizMJpY/2Dg/ohUimJCp+UcGdAm6H9ezU58+TptKQxaFz8sT9aLaGBOD/iRUhwKI6YAda+LNMCKaxXD77zj8oWZmrP1y7623YT7t3PaibQDdgo9QYPzrve2jI4QRGhXPM66db/gZtxXDZNTuWEWdgAzCa+Yg2Rx+Cxkc5tsaDa9YgSPnEh2gyfY69J89jJ9n+aqtszwbkGUELBhCivqImva8pNtOMbWpsFGCrN9/rXsyXxaPGKfeZBkYNng33CBfbsPJEnuuPofZOEDNGmgh8VTbWSnWBZNHa9If5B9UawH8g2qzSth9Yskek1ixcigB5CBSFQ2Z8JHqQVfqNlXIG5Ic4U3/foVY79i+bD5yJF7x8t4pnF3kD3mdBWbzEbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(8676002)(316002)(36860700001)(4326008)(70206006)(70586007)(54906003)(110136005)(41300700001)(6666004)(478600001)(36756003)(5660300002)(82310400005)(86362001)(47076005)(7696005)(8936002)(16526019)(1076003)(426003)(336012)(2616005)(82740400003)(186003)(356005)(81166007)(26005)(40480700001)(40460700003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 07:11:29.6937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b16be755-30c9-4a4b-ac41-08daa9c57d08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Energy Performance Preference support for AMD SOCs which do not
contain a designated MSR for CPPC support. A shared memory interface
is used for CPPC on these SOCs and the ACPI PCC channel is used to
enable EPP and reset the desired performance.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 14a275c22aff..4c24fe391a55 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -135,12 +135,25 @@ static inline int pstate_enable(bool enable)
 
 static int cppc_enable(bool enable)
 {
+	struct cppc_perf_ctrls perf_ctrls;
 	int cpu, ret = 0;
 
 	for_each_present_cpu(cpu) {
 		ret = cppc_set_enable(cpu, enable);
 		if (ret)
 			return ret;
+		if (epp_enabled) {
+			/* Enable autonomous mode for EPP */
+			ret = cppc_set_auto_epp(cpu, enable);
+			if (ret)
+				return ret;
+
+			/* Set desired perf as zero to allow EPP firmware control */
+			perf_ctrls.desired_perf = 0;
+			ret = cppc_set_perf(cpu, &perf_ctrls);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return ret;
-- 
2.34.1

