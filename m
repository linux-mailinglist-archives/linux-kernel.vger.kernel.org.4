Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142716B20FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCIKM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjCIKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:12:43 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A326E6809;
        Thu,  9 Mar 2023 02:12:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMXVcQLKRlczZ0AN0aAw9sFaI6jFu4mlIzW7fRXXos7oBui3THhI7VVpiQt3DNyBELvcKe/vkDWpXxyieTAT7vHqFyDtvFvNJVrXvw85y+K6KbGB6BxDRSvtK6GcE26oWuL9yqSZtQajgVXArzqWohbhgCh/th8RGiFJyqhzWBlG749FofLSsKJo5IGD5xqdAOKsho8kNFho8xZIo7n+6s4cho4yZ5tFZWqwyOyo1Q5B/CPTsnJ/iQFhglwudoWdjlAvA9HoDgFAjmRwyLX/WKogRRe5KxjeFTLE1rQe8qR+PodtT5Jvg0mHA0ngOjaKtZU4QS3trdyfON/bX2Jbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YFGamy51KwjAnD1EwQNXRknuXM19EugsdsE//yNK7E=;
 b=S5cLOOJXZm1rt/V4YGaFnWOinWMfviNYajdlE7VmV90OzFY8L8VvFQz2HGwbbgrskLrMoWSHMAEBPMr5+tyI19e5MebmN6oSJYj2+liQyX7472atwU6ga3LAcoexA8VYS2cjs6bzPF/FZEbQMN4Brd8sRmFcrFzDzAnd53pBJkB1+7Guk6xCsHAJ68oIF3hM2WFQHOuZn5ZbCXHWSFg0NfGbuWf+ov4LI/OxUyZB4UFizarvOCr2gBLR6yRWr874yrrdAaTuBXIWw6JN+cnZ2OcqKN/TXouMDyKKOkfX7473DzR/B2Ndz0s71FfUhqE7gWYjS75hiNP/usxAXGfdAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YFGamy51KwjAnD1EwQNXRknuXM19EugsdsE//yNK7E=;
 b=GkluZA77yQl3uU0pzATrnlScvBpofDDchx9ux06oOadAI8IcM++mSBQLiVe31lOI6Eal3FhbJ6DztFE9C3Tey1h6asvWq1K7Xe+bg1Em+WXJgNegDEFmZ97OaPsjy8TD3I2sV5tv6TRGm6M/L8VOXOxMjWuqzR55xICr+qbSZBM=
Received: from DS7PR03CA0170.namprd03.prod.outlook.com (2603:10b6:5:3b2::25)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 10:12:32 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::13) by DS7PR03CA0170.outlook.office365.com
 (2603:10b6:5:3b2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.19 via Frontend Transport; Thu, 9 Mar 2023 10:12:32 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Mar
 2023 04:12:25 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <namhyung@kernel.org>,
        <eranian@google.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@kernel.org>, <irogers@google.com>, <bp@alien8.de>,
        <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 3/3] perf test: Add selftest to test IBS invocation via core pmu events
Date:   Thu, 9 Mar 2023 15:41:11 +0530
Message-ID: <20230309101111.444-4-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 9853715b-d2c4-483b-4323-08db2086cbff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CP6MpImZle+NiLDqfPc56DvreMjx57jK25NYEoB/IgwwU7IrABRdvXlFoU7iu9J2FfgMZVoxgXPVRfxsSm8zDCttWYgQnpW9YEebKL4qJOJ2J8w2kbzzsbqkjuLoS0g01Oalla1P3ZGSpmUZvIeF5WJYx8RN/fFSDstjs5iE8MH5hMcZE20GSXUF4mWzE4XCPj0Fy3zj5thGB+D90uzxu88IYB4skECwzzH7PU7EozwCUOdRu9gxIZPIXyrTBPxj+VqWCVu28C9K8qBTfbBisR0X6CsKKIf0oAVU3FzJMWcOJhYAAt/I3ATVAZqXfeFoTARo37+wzEPHfhQCwWh0Et4ooirdYwd0UXbtk426b+FmOHSmgjBIi9rDIK/b9mOUBNSat5Fxye0qhQWznbTe1qpqQKmpVOh5Fqs8UiOvPZ/KhK1vHaNp+dkAfjvuwuByMs9vCyAkGqvQ14lW+OYOi94uVSYkBfVMn5+PZyp0XmKj5NlKDtfGGixVnpeplcS3rb9p2hm0M2aNjIUshkgiDbYGgy+C8kjtcoypJey9sJ6ska/yb9CvA/BqlP73r3kAdw1EKqoXsn4/p2dhH2inQtFQzeFfOnUgcc/Zc0kGUEU69r/V4opCBITE63nUUJcXq+rgkLq67NMH4txmbBdFDbQFibP0UrL8L5ehR0jevLlGThsqJkZGa3BzxJxQ+WM/95vs3ZGsuR4+mk4qY0g6p6DqioUJv+2j/pJcklpJDh4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(356005)(54906003)(7696005)(7416002)(5660300002)(316002)(8936002)(70586007)(2906002)(8676002)(70206006)(4326008)(6916009)(6666004)(41300700001)(44832011)(186003)(36860700001)(86362001)(81166007)(478600001)(40480700001)(26005)(82740400003)(2616005)(16526019)(1076003)(83380400001)(82310400005)(336012)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:12:32.2486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9853715b-d2c4-483b-4323-08db2086cbff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS pmu can be invoked via fixed set of core pmu events. Add a simple
event open test for all these events.

Without kernel fix:
  $ sudo ./perf test -vv 76
   76: IBS via core pmu                                                :
  --- start ---
  test child forked, pid 6553
  Using CPUID AuthenticAMD-25-1-1
  type: 0x0, config: 0x0, fd: 3  -  Pass
  type: 0x0, config: 0x1, fd: -1  -  Pass
  type: 0x4, config: 0x76, fd: -1  -  Fail
  type: 0x4, config: 0xc1, fd: -1  -  Fail
  type: 0x4, config: 0x12, fd: -1  -  Pass
  test child finished with -1
  ---- end ----
  IBS via core pmu: FAILED!

With kernel fix:
  $ sudo ./perf test -vv 76
   76: IBS via core pmu                                                :
  --- start ---
  test child forked, pid 7526
  Using CPUID AuthenticAMD-25-1-1
  type: 0x0, config: 0x0, fd: 3  -  Pass
  type: 0x0, config: 0x1, fd: -1  -  Pass
  type: 0x4, config: 0x76, fd: 3  -  Pass
  type: 0x4, config: 0xc1, fd: 3  -  Pass
  type: 0x4, config: 0x12, fd: -1  -  Pass
  test child finished with 0
  ---- end ----
  IBS via core pmu: Ok

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/tests/Build              |  1 +
 tools/perf/tests/builtin-test.c     |  1 +
 tools/perf/tests/ibs-via-core-pmu.c | 70 +++++++++++++++++++++++++++++
 tools/perf/tests/tests.h            |  1 +
 4 files changed, 73 insertions(+)
 create mode 100644 tools/perf/tests/ibs-via-core-pmu.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index fb9ac5dc4079..1a232cf13c33 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -69,6 +69,7 @@ perf-y += dlfilter-test.o
 perf-y += sigtrap.o
 perf-y += event_groups.o
 perf-y += symbols.o
+perf-y += ibs-via-core-pmu.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 35cc3807cc9e..aed887234500 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -119,6 +119,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__sigtrap,
 	&suite__event_groups,
 	&suite__symbols,
+	&suite__ibs_via_core_pmu,
 	NULL,
 };
 
diff --git a/tools/perf/tests/ibs-via-core-pmu.c b/tools/perf/tests/ibs-via-core-pmu.c
new file mode 100644
index 000000000000..6ac539509791
--- /dev/null
+++ b/tools/perf/tests/ibs-via-core-pmu.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "linux/perf_event.h"
+#include "tests.h"
+#include "pmu.h"
+#include "pmus.h"
+#include "../perf-sys.h"
+#include "debug.h"
+
+#define NR_SUB_TESTS 5
+
+static struct sub_tests {
+	int type;
+	unsigned long config;
+	bool valid;
+} sub_tests[NR_SUB_TESTS] = {
+	{ PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES, true },
+	{ PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS, false },
+	{ PERF_TYPE_RAW, 0x076, true },
+	{ PERF_TYPE_RAW, 0x0C1, true },
+	{ PERF_TYPE_RAW, 0x012, false },
+};
+
+static int event_open(int type, unsigned long config)
+{
+	struct perf_event_attr attr;
+
+	memset(&attr, 0, sizeof(struct perf_event_attr));
+	attr.type = type;
+	attr.size = sizeof(struct perf_event_attr);
+	attr.config = config;
+	attr.disabled = 1;
+	attr.precise_ip = 1;
+	attr.sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_TID;
+	attr.sample_period = 100000;
+
+	return sys_perf_event_open(&attr, -1, 0, -1, 0);
+}
+
+static int test__ibs_via_core_pmu(struct test_suite *text __maybe_unused,
+				  int subtest __maybe_unused)
+{
+	struct perf_pmu *ibs_pmu;
+	int ret = TEST_OK;
+	int fd, i;
+
+	if (list_empty(&pmus))
+		perf_pmu__scan(NULL);
+
+	ibs_pmu = perf_pmu__find("ibs_op");
+	if (!ibs_pmu)
+		return TEST_SKIP;
+
+	for (i = 0; i < NR_SUB_TESTS; i++) {
+		fd = event_open(sub_tests[i].type, sub_tests[i].config);
+		pr_debug("type: 0x%x, config: 0x%lx, fd: %d  -  ", sub_tests[i].type,
+			 sub_tests[i].config, fd);
+		if ((sub_tests[i].valid && fd == -1) ||
+		    (!sub_tests[i].valid && fd > 0)) {
+			pr_debug("Fail\n");
+			ret = TEST_FAIL;
+		} else {
+			pr_debug("Pass\n");
+			close(fd);
+		}
+	}
+
+	return ret;
+}
+
+DEFINE_SUITE("IBS via core pmu", ibs_via_core_pmu);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9a0f3904e53d..36339fdf9c36 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -149,6 +149,7 @@ DECLARE_SUITE(dlfilter);
 DECLARE_SUITE(sigtrap);
 DECLARE_SUITE(event_groups);
 DECLARE_SUITE(symbols);
+DECLARE_SUITE(ibs_via_core_pmu);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
-- 
2.39.2

