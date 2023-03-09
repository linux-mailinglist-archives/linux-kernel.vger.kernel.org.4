Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD156B20F6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCIKM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCIKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:12:23 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D26E4DBE;
        Thu,  9 Mar 2023 02:12:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDqwFY7L1ovbQzee9cE5SoMddGDFJdJDMkF5sdJqWwFICxUGy8w5rYrThtWL213I6OosnPLxdNYx5TNvgNOdEybuU3oLuIT1icV+TP08OOj+m0ac0mk/7PURp7HzXuwzNB2BHgMLD2VZ7z1lh15zdgTeRQ0lcDe30y/1uOZqxPQJh93tqnzskhV9ZeYp8q439r5eDe7/FxRItES/CG5vzGRZfsTDRjGq69+1sfmbJEUgVFLAIi0uaLweZpF1tIJdi6xD3e154xVioSvUp1zkRyzXCnbSMkmvf5jKW+VcB5IPicCPoz4GuSGYncCnY1naURIF569FzParWfZkV5bpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXugKCKESUudTWx1tbmZHaLHdUPVJN7tl1Sbgv0cXo0=;
 b=MohGFtqS/NCPYllQN6jtelJmSpFvhX8R0Bz/z8i+0d+Xjls1wmGA80wjDee9KBs9UGBFjBlRXyDwhShGugxs+JsgO3VUVOsLHk5dtk23KPNGIynJ9PpbSGjnakF4TBFhjxc7d7aCZJt92qVG5korgIlTgl1Jda95mI2Brsd7dfpMtTSQy65wfV/2nUxE0Ph8rRZh9PuMAEKAk8ltpIcoxgZAXO94Z3xCuu0+KhS8VSGaRA/CEf2dZHcTaFJvLozCnL7T/b+jySDHugA1ScjhDDgsYbNDR7DgjO9gHWk9oTMWc2wuHPzO9FkYir4ac0kfkeryh6vbDU9WDcxQq/y0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXugKCKESUudTWx1tbmZHaLHdUPVJN7tl1Sbgv0cXo0=;
 b=g6kPbJttiWqpV+Hb1OuDLk2yeeATQ5mu2QSTClNArHKDtHCPJaJQkq9L/5WXmvZcgvOgUsKNNfxlrBTW/2xFZex4fbeBGCLvLRhd7M6ZkzN9rRzWuOIRyV/286qCRchVWjwNWU/i3pGtzYnc1yzx+YpdT9F5k7kwPKR4nFrfGzw=
Received: from DS7PR05CA0063.namprd05.prod.outlook.com (2603:10b6:8:57::19) by
 BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Thu, 9 Mar 2023 10:12:19 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::c6) by DS7PR05CA0063.outlook.office365.com
 (2603:10b6:8:57::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.18 via Frontend Transport; Thu, 9 Mar 2023 10:12:19 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Mar
 2023 04:12:13 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <namhyung@kernel.org>,
        <eranian@google.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@kernel.org>, <irogers@google.com>, <bp@alien8.de>,
        <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 1/3] perf/ibs: Introduce ibs_core_pmu_event()
Date:   Thu, 9 Mar 2023 15:41:09 +0530
Message-ID: <20230309101111.444-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309101111.444-1-ravi.bangoria@amd.com>
References: <20230309101111.444-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|BN9PR12MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b5d358-ab1e-40dc-9394-08db2086c44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvX16gSzZ/b6zQESUryK7dMv7MYvKb7TTdiYsF+Se5UoSpi1wcHqjXUMuMayBnWan0HnnlSQ/GoxgILYrwX5TrLgsKNfiadLNROX1ufNDd+9KZ8zdeq8n0UAKAo+nv0W9ill/DE0JQsdA9ICkPDL2nRLPTV+X964+7iAM6OSS0p9BrdLdMC7TQzzd+Ps83xnb4UrRTDPsszMMdj+WP39G7eMAhYj1w7BdGmHxc04Tc8GtsifSysmjDa/z9/iwM5vNWZil1igKUR0TTxKkL0iS0hxY8cx6C1I9x3cxp3dq0g9JlivIWEwxrKmWdGye1tv7LYGOW+FUR1/pOCGy/RpW01e2eyWgEMo8ynICTh7Dd6v3cvL0WiXuuyPGLWRaOC64rfsw41L1O6A5Ynzmg93FF2h6Y5H0V/JruoFuq78bsWIG+QP9rM7evTbO/jFSZ1aLEc3ZiuZ1TcI2uvC2rq7lzCk2CfeixDVRY1m9Qm4/l/B5n/YM163qMRUQ8R0IDA5LyVX69U0JIpYRkxtlxqnP4wgAC/SKAhJVAHZDErjcCMqj1OX/QEiPsoCLLxoWn7pIlusmcn36sxijk5pjCorEYDOd03r3NgDBJu8Zs4G2htkAoV7qwO8zAOxGI5Y8Sh7MghUzLLJ6k/vENHkCdzq4RTLznbesNDV5LGtsgbH5WIoO/Ai6H3H+3P077dUeAQMOROzf2g3sXqUMthUFxgPitZ6iM4ypJvFmWxci53eURE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(8936002)(36756003)(26005)(7416002)(5660300002)(1076003)(8676002)(82740400003)(36860700001)(6666004)(81166007)(47076005)(82310400005)(83380400001)(426003)(336012)(16526019)(186003)(2616005)(40480700001)(54906003)(86362001)(316002)(41300700001)(70206006)(4326008)(40460700003)(6916009)(70586007)(356005)(7696005)(478600001)(2906002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:12:19.3204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b5d358-ab1e-40dc-9394-08db2086c44a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split core pmu event comparing code from perf_ibs_precise_event() into
a separate function ibs_core_pmu_event().

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c         | 52 +++++++++++++++++--------------
 arch/x86/include/asm/perf_event.h |  2 ++
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 64582954b5f6..67eb5b7564e8 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -218,29 +218,7 @@ static int perf_ibs_precise_event(struct perf_event *event, u64 *config)
 		return -EOPNOTSUPP;
 	}
 
-	switch (event->attr.type) {
-	case PERF_TYPE_HARDWARE:
-		switch (event->attr.config) {
-		case PERF_COUNT_HW_CPU_CYCLES:
-			*config = 0;
-			return 0;
-		}
-		break;
-	case PERF_TYPE_RAW:
-		switch (event->attr.config) {
-		case 0x0076:
-			*config = 0;
-			return 0;
-		case 0x00C1:
-			*config = IBS_OP_CNT_CTL;
-			return 0;
-		}
-		break;
-	default:
-		return -ENOENT;
-	}
-
-	return -EOPNOTSUPP;
+	return ibs_core_pmu_event(event, config);
 }
 
 static int perf_ibs_init(struct perf_event *event)
@@ -1296,6 +1274,34 @@ u32 get_ibs_caps(void)
 
 EXPORT_SYMBOL(get_ibs_caps);
 
+/* Convert core pmu event into IBS event */
+int ibs_core_pmu_event(struct perf_event *event, u64 *config)
+{
+	switch (event->attr.type) {
+	case PERF_TYPE_HARDWARE:
+		switch (event->attr.config) {
+		case PERF_COUNT_HW_CPU_CYCLES:
+			*config = 0;
+			return 0;
+		}
+		break;
+	case PERF_TYPE_RAW:
+		switch (event->attr.config) {
+		case 0x0076:
+			*config = 0;
+			return 0;
+		case 0x00C1:
+			*config = IBS_OP_CNT_CTL;
+			return 0;
+		}
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static inline int get_eilvt(int offset)
 {
 	return !setup_APIC_eilvt(offset, 0, APIC_EILVT_MSG_NMI, 1);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc15ed5e60b..1ad9d504ae71 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -475,8 +475,10 @@ struct pebs_xmm {
 
 #ifdef CONFIG_X86_LOCAL_APIC
 extern u32 get_ibs_caps(void);
+extern int ibs_core_pmu_event(struct perf_event *event, u64 *config);
 #else
 static inline u32 get_ibs_caps(void) { return 0; }
+static inline int ibs_core_pmu_event(struct perf_event *event, u64 *config) { return -ENOENT; }
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
-- 
2.39.2

