Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37F16F696C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjEDLC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEDLCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:02:24 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE834EE6;
        Thu,  4 May 2023 04:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp2oSoKYeqt1DyiaO/G0QKr3e3lX8pdZ3G2i+5Bq5AeTtEoGbqa+YwD2D91hsklJp1PVM8drZovgObA0l4vr1RbH/62uyAGcDqrK/n7V1F10cJfFtd6pAsMyeLmy51F2e7ko1NnQVWnyNRRtzO4EsA0YAKWWaznCQiIhmPLkt2+YZGXXS8zRH546kvlF9WTz8IrUskQLbUIyvg+7wInlEafITrzfLXgw60jTDutl6Ysn7dU9mdPDfPjyQV0Uk78lA5StR9xmvnQaURqhF0ADHWmeNoBbCRJERj40UUJSRYSYW83+C8J0g4A6+wTIva1oHG81QldX8ydJ7eNwEgNxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNUremZhGNFau0Z/dmByHcwYr9QULwxNypLUIfRJm7I=;
 b=L8aY+5JKpcwqtiBym66jcmCv8tCOvO+lDh4yO0eAeS675tBvk7+jVZMZQrcPBMkMPIvFyyJ34YyqR/Xm01Uj9yt2qPWQVuhNVkacf40pvj2ChISlIYuMHD3EHnObtNmAZ2MzixVT2i86tIS5apId5dR8PtE6Dq6XD77qWNaAhByfXV6uxmea8ubRkL+UQr75i+AzonIK0jgGo/59q38knvgSfugVxNbpB+BR5CMMID8XLUrPLCjkbZS6xBOSBCqgofIZamJf4Z3jkSzKzeg+7g6DrzfRjLfEtmKf7guE0ZfVBmmI7epXBWakFwNkUgJOmxtb2e8Kf4WerTlLF+YFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNUremZhGNFau0Z/dmByHcwYr9QULwxNypLUIfRJm7I=;
 b=FRaEa7/PmM2/rahEZHoK6klfnscGR1sV7I7x77NiM+0JT3RE/RiVq37e+/JTpML0J+8cDDSMzAJHlY6DCLelAnOFUHCfgHoSKCJxiEp4LLYICoXpIiSmv+/6354aUrcHiHkejMHQMzI3ZZ7BIsnvmGDo5Brr4VY0D8LO0dENPtk=
Received: from BYAPR11CA0070.namprd11.prod.outlook.com (2603:10b6:a03:80::47)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 11:02:01 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:80:cafe::7a) by BYAPR11CA0070.outlook.office365.com
 (2603:10b6:a03:80::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26 via Frontend
 Transport; Thu, 4 May 2023 11:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.26 via Frontend Transport; Thu, 4 May 2023 11:02:01 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 4 May
 2023 06:01:29 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <namhyung@kernel.org>,
        <eranian@google.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@kernel.org>, <irogers@google.com>, <bp@alien8.de>,
        <kan.liang@linux.intel.com>, <adrian.hunter@intel.com>,
        <maddy@linux.ibm.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v4 2/4] perf/ibs: Fix interface via core pmu events
Date:   Thu, 4 May 2023 16:30:01 +0530
Message-ID: <20230504110003.2548-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504110003.2548-1-ravi.bangoria@amd.com>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: e91ea1b6-3655-427e-8358-08db4c8efcd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbR2nohzzQbxPtpGI7/+DDSdLFYg4WpHjylkBH1vsF9OA/AVFw+9W4fUxMMAo8mA/WU2CbojcE9eMshAVL97ovb3lqDeYjZdeqoTse0/VKmuPxXr8OhnAc5t5Tmb10LuuWTLaTeUxR9UWNGsUEM7mHcZnhyIlp1Iz1fXDdxZYPYnNGqF5tUp2jZrawpdT1GUbb1lo9oYrYCgBTOQN4B+zX1ZHJGpuPaeUrZD3aIrqthL8Z8Ot/myjp4Rzo+UcL6jqSDVo0Rtg930qJ8o/x9YRkvYaSw00/cvPqsI6bKnf0mv13M44Dzv1Df2D5seYPXxc+iwyddCqbkd0+6nLshZYsT8nhMNM5WsZWfZ3ZzD9EiNlIo58p+QXPfaKRUSaawScifhRI/xbcdP+vIDdwC1ynGBNxlsIXz4o3WoYox5qG1U1JsPmRoh9NQtsIORwk5F9f1F61sRokP51dQer3YYGj2In94Awzeh5+Rj06HvEPfT9nnBXXjIgOY1ggfpV6CNqxZRKuu8SPGfmYFiBdp1qVNo/tNyMGk7m7fuztd/l00mG+yHM02wGRRVSB37tlY7+nHLoI+8f52FC7XTjb52BkZ4BhgTyKThwaDYHq5So1QERrTCTpsdl5Wwn8CiK/sXJlo8jOyk2C0HSc5WWbFjjkQl0gpDQ8Z/ntEhT2i0+oZeUzx9GnobBxkPDGgM2uyZrAt84oZlpnikRn8uXx0IaxAAoroQq5dkp/swWtjO200=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(81166007)(478600001)(2906002)(40460700003)(316002)(70586007)(82310400005)(70206006)(4326008)(7696005)(6916009)(6666004)(36756003)(82740400003)(40480700001)(16526019)(356005)(41300700001)(26005)(1076003)(86362001)(2616005)(8936002)(83380400001)(47076005)(54906003)(36860700001)(7416002)(426003)(336012)(8676002)(186003)(44832011)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 11:02:01.3259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e91ea1b6-3655-427e-8358-08db4c8efcd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although, IBS pmus can be invoked via their own interface, indirect
IBS invocation via core pmu events is also supported with fixed set
of events: cpu-cycles:p, r076:p (same as cpu-cycles:p) and r0C1:p
(micro-ops) for user convenience.

This indirect IBS invocation is broken since commit 66d258c5b048
("perf/core: Optimize perf_init_event()"), which added RAW pmu under
'pmu_idr' list and thus if event_init() fails with RAW pmu, it started
returning error instead of trying other pmus.

Forward precise events from core pmu to IBS by overwriting 'type' and
'config' in the kernel copy of perf_event_attr. Overwriting will cause
perf_init_event() to retry with updated 'type' and 'config', which will
automatically forward event to IBS pmu.

Without patch:
  $ sudo ./perf record -C 0 -e r076:p -- sleep 1
  Error:
  The r076:p event is not supported.

With patch:
  $ sudo ./perf record -C 0 -e r076:p -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.341 MB perf.data (37 samples) ]

Fixes: 66d258c5b048 ("perf/core: Optimize perf_init_event()")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/core.c        |  2 +-
 arch/x86/events/amd/ibs.c         | 53 +++++++++++++++----------------
 arch/x86/include/asm/perf_event.h |  2 ++
 3 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index bccea57dee81..abadd5f23425 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -374,7 +374,7 @@ static int amd_pmu_hw_config(struct perf_event *event)
 
 	/* pass precise event sampling to ibs: */
 	if (event->attr.precise_ip && get_ibs_caps())
-		return -ENOENT;
+		return forward_event_to_ibs(event);
 
 	if (has_branch_stack(event) && !x86_pmu.lbr_nr)
 		return -EOPNOTSUPP;
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 64582954b5f6..371014802191 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -190,7 +190,7 @@ static struct perf_ibs *get_ibs_pmu(int type)
 }
 
 /*
- * Use IBS for precise event sampling:
+ * core pmu config -> IBS config
  *
  *  perf record -a -e cpu-cycles:p ...    # use ibs op counting cycle count
  *  perf record -a -e r076:p ...          # same as -e cpu-cycles:p
@@ -199,25 +199,9 @@ static struct perf_ibs *get_ibs_pmu(int type)
  * IbsOpCntCtl (bit 19) of IBS Execution Control Register (IbsOpCtl,
  * MSRC001_1033) is used to select either cycle or micro-ops counting
  * mode.
- *
- * The rip of IBS samples has skid 0. Thus, IBS supports precise
- * levels 1 and 2 and the PERF_EFLAGS_EXACT is set. In rare cases the
- * rip is invalid when IBS was not able to record the rip correctly.
- * We clear PERF_EFLAGS_EXACT and take the rip from pt_regs then.
- *
  */
-static int perf_ibs_precise_event(struct perf_event *event, u64 *config)
+static int core_pmu_ibs_config(struct perf_event *event, u64 *config)
 {
-	switch (event->attr.precise_ip) {
-	case 0:
-		return -ENOENT;
-	case 1:
-	case 2:
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
 	switch (event->attr.type) {
 	case PERF_TYPE_HARDWARE:
 		switch (event->attr.config) {
@@ -243,22 +227,37 @@ static int perf_ibs_precise_event(struct perf_event *event, u64 *config)
 	return -EOPNOTSUPP;
 }
 
+/*
+ * The rip of IBS samples has skid 0. Thus, IBS supports precise
+ * levels 1 and 2 and the PERF_EFLAGS_EXACT is set. In rare cases the
+ * rip is invalid when IBS was not able to record the rip correctly.
+ * We clear PERF_EFLAGS_EXACT and take the rip from pt_regs then.
+ */
+int forward_event_to_ibs(struct perf_event *event)
+{
+	u64 config = 0;
+
+	if (!event->attr.precise_ip || event->attr.precise_ip > 2)
+		return -EOPNOTSUPP;
+
+	if (!core_pmu_ibs_config(event, &config)) {
+		event->attr.type = perf_ibs_op.pmu.type;
+		event->attr.config = config;
+	}
+	return -ENOENT;
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs;
 	u64 max_cnt, config;
-	int ret;
 
 	perf_ibs = get_ibs_pmu(event->attr.type);
-	if (perf_ibs) {
-		config = event->attr.config;
-	} else {
-		perf_ibs = &perf_ibs_op;
-		ret = perf_ibs_precise_event(event, &config);
-		if (ret)
-			return ret;
-	}
+	if (!perf_ibs)
+		return -ENOENT;
+
+	config = event->attr.config;
 
 	if (event->pmu != &perf_ibs->pmu)
 		return -ENOENT;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8fc15ed5e60b..fc86248215e2 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -475,8 +475,10 @@ struct pebs_xmm {
 
 #ifdef CONFIG_X86_LOCAL_APIC
 extern u32 get_ibs_caps(void);
+extern int forward_event_to_ibs(struct perf_event *event);
 #else
 static inline u32 get_ibs_caps(void) { return 0; }
+static inline int forward_event_to_ibs(struct perf_event *event) { return -ENOENT; }
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
-- 
2.40.0

