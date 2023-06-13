Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498C672DE61
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbjFMJ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240730AbjFMJ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:56:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D5B10D9;
        Tue, 13 Jun 2023 02:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BF3bVwj15IOOhWwRi97BMWvmjXPa7Vj2z5kTh+eyHXBWfcSx/DYDdFROFByjku3pc9CTciY5mhbeL4bLLcPovTCc/wBkvB06l9lXJtYENtZ4iYR5jwWseLGAJP+plYiVG5weq5SYMyBSxai56K92d2pUc5XJ+kqHlwq7ujUYNLq8YroYMjZKjo9slhTsgrrRs3dCchJDz15mXDmVDeOm8LfQHmZ4w9PaT6nmO3dfrZ49cojL1jltvEDQMo/cASR9a+UFbswFMgguAplucLdU9x/1EC7irOjJJl9iHnaxPCrXvEbleXYWm8eToQtrozoi04/0uILRo9vvx1MpydVhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQHopsDzWCqnOq4HBhUmxLqv5m4qZ09rS2zUXM3sZys=;
 b=MZCEiFnEZ2IIEdzAvkCe1yJei/b180u9Xn9YEYOl5aIYWYRxKxjcpZV7VYgAGS/9XuCHNmdsS7LtUasYLEbQUlf8hXBvqn1siHuu4mFWUm1v57oVzz25/SIswZ45WkGjaqnLW5mOoJML3T2hAwjOBErj2lLa50F+KfTmdNij2j7QFNGQMdCwoKJvAUvzpNpm+NpT9uS0P/HnZUGIiIcWO46ZjDTm8x31lZDXWzjGOw3jZafJteMm3IKI08OxIhNbEpqjhe1a95++Dp4bBEtAIck/kypPLTKTqTVI01J221BFUmI1xkUB+blvh075gRCXyc1x8ZvqLSoWN1v0MDBZbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQHopsDzWCqnOq4HBhUmxLqv5m4qZ09rS2zUXM3sZys=;
 b=Fzmw3b9fDI1pn1BfSKmYFa/oaTlgjJQ6A1GG7tFNcmPFUtjhHBiBS3JgM1mcSGM2OWKpcu9/oy/tAQUx3QE1gaXllKT/+u0tPO3+4fLqOCZyVhyiB328rxJrE3ml87odhq2jqVlHjqA/rGN1+uLtW4dKnJ0JvbGv7eB1gWqt7go=
Received: from SA1P222CA0087.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::20)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 09:56:10 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::80) by SA1P222CA0087.outlook.office365.com
 (2603:10b6:806:35e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 09:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 09:56:10 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 04:56:04 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <peterz@infradead.org>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <james.clark@arm.com>,
        <alisaidi@amazon.com>, <leo.yan@linaro.org>, <maddy@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH 2/4] perf tool x86: Consolidate is_amd check into single function
Date:   Tue, 13 Jun 2023 15:25:04 +0530
Message-ID: <20230613095506.547-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613095506.547-1-ravi.bangoria@amd.com>
References: <20230613095506.547-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: f87e1aab-62ad-4af8-df73-08db6bf46a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwDhSpxMCeAtqACY+wWXNNUDiNiiUMneC+yC8RzsR+TBp8SkL/GMjixCU7TOGoB9p6TOqWPTSxeW4sEYBXX2sHVyedr5WjVicAUdAtIlCipj9RpWlQML3xUpdYuJdt6ynbZ+sab1WU/NrUb4iNwD5r1NlJVFy1ElCcSAF07p9o2zKE5frPYVrxHshuneSxTcJaw/8GNRmZTfEUnH+k236HMRJXCY/xbAxb1zSgNVqAjTuLKOOJ5xi7jKIchM8H6MiEuQemr+6KchIZkd6YHIH1KLp6Wi3wLSgd8+U9+uj7Lsl04Jo56jAez1vzReBRK9LRkNmdb8FCG8kMjhUKs/4ymmMWlf20JM+QDRGjnRtCrmIVb3dP2K6GfNiHPr1v8jtJZMO3zzGS+qrtIlBXXYatAOvkRJYTlDWCQclqaMJ8u480XxMgyIX2eB/irqMuR4IQYr/FuPA+32QrsA1dwE0GQpboxe1wJGomaIy+NNjtvxB+9QmMxdPROFNqkrSQAaKL1o5bZWixPCyftCh1tymoB7SkY2krF5ZNeB7cTKP7mVjwQg/uuI+hZhyw8ISVyXAk5ILJGkhXp9fEyETauD0WUBygi45+S6eM1/eAdU7X+u28ZKZSVYn5bSQ2ozUf8EGvtfAykI7wUToHVH+7IV9GQwF1mKJUUt/Im3NDzqvmeemGU7nPoFg0VPTQoSEt1tHKbqbMYUsupgCFolmYzUGMqnEo2LCD8rGkNsNfxPfdZd3jhNO8ZNzW0JVidK+fiXZWjok27x+D19DtdmuiyqmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(478600001)(2616005)(41300700001)(5660300002)(8936002)(8676002)(7696005)(70586007)(316002)(6916009)(336012)(70206006)(4326008)(426003)(26005)(1076003)(44832011)(7416002)(16526019)(40460700003)(2906002)(186003)(40480700001)(81166007)(356005)(82740400003)(83380400001)(36756003)(36860700001)(47076005)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:56:10.2309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87e1aab-62ad-4af8-df73-08db6bf46a50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337
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

There are multiple places where x86 specific code determines AMD vs
Intel arch and acts based on that. Consolidate those checks into a
single function.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/util/Build        |  1 +
 tools/perf/arch/x86/util/env.c        | 19 +++++++++++++++++++
 tools/perf/arch/x86/util/env.h        |  7 +++++++
 tools/perf/arch/x86/util/evsel.c      | 16 ++--------------
 tools/perf/arch/x86/util/mem-events.c | 19 ++-----------------
 5 files changed, 31 insertions(+), 31 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/env.c
 create mode 100644 tools/perf/arch/x86/util/env.h

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 195ccfdef7aa..005907cb97d8 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -10,6 +10,7 @@ perf-y += evlist.o
 perf-y += mem-events.o
 perf-y += evsel.o
 perf-y += iostat.o
+perf-y += env.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/env.c b/tools/perf/arch/x86/util/env.c
new file mode 100644
index 000000000000..33b87f8ac1cc
--- /dev/null
+++ b/tools/perf/arch/x86/util/env.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "linux/string.h"
+#include "util/env.h"
+#include "env.h"
+
+bool x86__is_amd_cpu(void)
+{
+	struct perf_env env = { .total_mem = 0, };
+	static int is_amd; /* 0: Uninitialized, 1: Yes, -1: No */
+
+	if (is_amd)
+		goto ret;
+
+	perf_env__cpuid(&env);
+	is_amd = env.cpuid && strstarts(env.cpuid, "AuthenticAMD") ? 1 : -1;
+
+ret:
+	return is_amd >= 1 ? true : false;
+}
diff --git a/tools/perf/arch/x86/util/env.h b/tools/perf/arch/x86/util/env.h
new file mode 100644
index 000000000000..d78f080b6b3f
--- /dev/null
+++ b/tools/perf/arch/x86/util/env.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _X86_ENV_H
+#define _X86_ENV_H
+
+bool x86__is_amd_cpu(void);
+
+#endif /* _X86_ENV_H */
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 25da46c8cca9..512c2d885d24 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -8,6 +8,7 @@
 #include "linux/string.h"
 #include "evsel.h"
 #include "util/debug.h"
+#include "env.h"
 
 #define IBS_FETCH_L3MISSONLY   (1ULL << 59)
 #define IBS_OP_L3MISSONLY      (1ULL << 16)
@@ -78,23 +79,10 @@ void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
 {
 	struct perf_pmu *evsel_pmu, *ibs_fetch_pmu, *ibs_op_pmu;
 	static int warned_once;
-	/* 0: Uninitialized, 1: Yes, -1: No */
-	static int is_amd;
 
-	if (warned_once || is_amd == -1)
+	if (warned_once || !x86__is_amd_cpu())
 		return;
 
-	if (!is_amd) {
-		struct perf_env *env = evsel__env(evsel);
-
-		if (!perf_env__cpuid(env) || !env->cpuid ||
-		    !strstarts(env->cpuid, "AuthenticAMD")) {
-			is_amd = -1;
-			return;
-		}
-		is_amd = 1;
-	}
-
 	evsel_pmu = evsel__find_pmu(evsel);
 	if (!evsel_pmu)
 		return;
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index 32879d12a8d5..a8a782bcb121 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -5,6 +5,7 @@
 #include "map_symbol.h"
 #include "mem-events.h"
 #include "linux/string.h"
+#include "env.h"
 
 static char mem_loads_name[100];
 static bool mem_loads_name__init;
@@ -27,28 +28,12 @@ static struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
 	E("mem-ldst",	"ibs_op//",	"ibs_op"),
 };
 
-static int perf_mem_is_amd_cpu(void)
-{
-	struct perf_env env = { .total_mem = 0, };
-
-	perf_env__cpuid(&env);
-	if (env.cpuid && strstarts(env.cpuid, "AuthenticAMD"))
-		return 1;
-	return -1;
-}
-
 struct perf_mem_event *perf_mem_events__ptr(int i)
 {
-	/* 0: Uninitialized, 1: Yes, -1: No */
-	static int is_amd;
-
 	if (i >= PERF_MEM_EVENTS__MAX)
 		return NULL;
 
-	if (!is_amd)
-		is_amd = perf_mem_is_amd_cpu();
-
-	if (is_amd == 1)
+	if (x86__is_amd_cpu())
 		return &perf_mem_events_amd[i];
 
 	return &perf_mem_events_intel[i];
-- 
2.40.1

