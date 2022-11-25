Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C636382AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKYDVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKYDVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:21:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F86C1EEC7;
        Thu, 24 Nov 2022 19:21:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCU2vt8CEFu4zEP8/uUBDGd5V3tS0r3GKjRzg5Phm87IRxF1amQlPvxFOebPWmWoDjMLz4m3kuDPIOK/cWpu0Uc1eCEvtG0VGVGrCJRwmzsWWPfQJ0rNeauf8vd8xPMF5KszbUgGKvTinAmK6QftxlHTR6eIUjH1NOfdJH7bqxMsn05/VZx/kq9bfZCk8yvIKHVZqD6hFjnrHgnzlONXcD4WLAXCgqcB2MAre9nz9RzzVuKMRaPcpWlV0fYlv7TivpYHNd7oelFyNO4oGKOOEhJbBHZ81ClzoWnag5d3QeokLlELrQ+vXSmFnD7E7H9gL8NXe+ZLxY4xubJoUxLYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXQFDEu+bVT50dcHOEUiySFOSid8CK2fwcu3JhCyli4=;
 b=AkSwMVC2hM74smw6z8jvnRa3Xuj4SGZIeIpSzoQXL9T5AA+nUIL9z5gce9wMyBE6L7c49bp2D0gkB5Ew4UySA0NXlxlM2IhbKgeT1qRLnN7kI6ApCG7puO2TszY15v5kJur3qi30OJZu6sgoEoCHXeFbTf3bLKOIdub51LIHDTQfB1cXEMrCEJ5HtwOH5ZiJk2g18VTHNuQurqtSdTpp8y6JLh+WouT8GuUtPAc+UaYJ/bL0siuYt6nhR9nfOmC3+HM8dCwhvytrKGzvdDtYKI/JYPEu/gVkEo9HTtFy7oH5vLfGkbhuc7piDh9myCFrdEh7mo9XkyjZElaziStCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXQFDEu+bVT50dcHOEUiySFOSid8CK2fwcu3JhCyli4=;
 b=VYy0iNWvermcXlYtLHWnR/R4xLNnirZ4gAIONc4p4PX5mDC+6jBcOf+Q12jPh+l2sFtMllleqVEtIJOv7YRzAskt4fVWE7Ubo+DPdIcqbJBrzDMA6907EFVpJMr8ThpVomlY67fFwd0eX4lA7zh71EDysiJH9MXXzIBkEzZW+jQ=
Received: from DM6PR13CA0033.namprd13.prod.outlook.com (2603:10b6:5:bc::46) by
 SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.19; Fri, 25 Nov 2022 03:21:07 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::60) by DM6PR13CA0033.outlook.office365.com
 (2603:10b6:5:bc::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Fri, 25 Nov 2022 03:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 25 Nov 2022 03:21:07 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 21:20:39 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@redhat.com>, <namhyung@kernel.org>,
        <irogers@google.com>, <peterz@infradead.org>,
        <mark.rutland@arm.com>, <kan.liang@linux.intel.com>,
        <adrian.hunter@intel.com>, <alexander.shishkin@linux.intel.com>,
        <carsten.haitzler@arm.com>, <leo.yan@linaro.org>,
        <maddy@linux.ibm.com>, <kjain@linux.ibm.com>,
        <atrajeev@linux.vnet.ibm.com>, <tmricht@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH] perf test: Add event group test
Date:   Fri, 25 Nov 2022 08:50:18 +0530
Message-ID: <20221125032018.962-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|SJ0PR12MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: bf23b3ea-41b9-4cd1-23a2-08dace941780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xdBBGOLcztDQwVCj7v0VtaYJ2WwWD2ewP8vVgZ1YTXRJ+YxQLg3tabyQ0qAg9hYY6YZMlTZgDqf1tKfTqyl2k4Wj51U8dYkIaybA1eoht57Y7KqPgVwhlH2KHFPWLTKnqmrVCb7Ukx90D2CyIhtBDfU5WT8IvOJrLCn80Rt2JkbkNT6ihEZR6YvW+crAzILMDi2vYj1+PthIIe4w8EosQyCa9vr/V46dfYASifOS6MsuP7CxussxnoRo127vva0qPpo23DXh7UVZQhq9KI/vakXn7XA4nGEq8nncJmO9NVboVe3cCOBM1NoXcSAU/WN3AjjVK5QImT2tJHtdsvETUPSntrFBBcy4xyqpH+lqX7GfsTDdhk89QbxhjPLRFLdQHojBzS1RWpqyeKIgD+A/TFUHO7LbjhexUR46JERYaqHAn+mHLbRQtp3OWBkdp1l0uXMfb/QyBpOo49UhTmWqPh5AaFhm0p3b4c8CVCq7+tSWTGNCuN14lkga5ciiR6QveNO9Puse0ZXytgDPohPmroocOyI5Ad6GZLqIVqbUcPG63rm/M2oQ6cctaKTf6LiW1EEjZEteAHwtuHAuQrvwEISkR4F3XV9PzMq4krbxoudyEXvh9GEhg7Cl8jcTt4TcwE/KqdlhHVSVZ9wk5OQiTS/VkbCuRgIBbeNY1xXl08Z2q4ns+8FydQ7CLuXYXYRk4qwopI1FUqLAWc2XDYuMV7GnoI+RJwkrPJmfO2gDYW6G6QSoHLBDLpXL1hcJxVviFUOD62S5ow5uunikBMiLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(2906002)(356005)(40480700001)(81166007)(83380400001)(26005)(41300700001)(7696005)(7416002)(6666004)(6916009)(54906003)(316002)(86362001)(1076003)(186003)(426003)(16526019)(2616005)(47076005)(336012)(44832011)(36756003)(5660300002)(82310400005)(70586007)(70206006)(36860700001)(478600001)(8936002)(8676002)(4326008)(40460700003)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 03:21:07.0320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf23b3ea-41b9-4cd1-23a2-08dace941780
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple events in a group can belong to one or more pmus, however
there are some limitations to it. Basically, perf doesn't allow
creating a group of events from different hw pmus. Write a simple
test to create various combinations of hw, sw and uncore pmu events
and verify group creation succeeds or fails as expected.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
Note: Uncore pmu event detail for Intel, Arm, PowerPC and s390 needs
to be verified/fixed. These are marked as XXX in the patch.

 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/event_groups.c | 126 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 129 insertions(+)
 create mode 100644 tools/perf/tests/event_groups.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 2064a640facb..9a59d451ca44 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -67,6 +67,7 @@ perf-y += expand-cgroup.o
 perf-y += perf-time-to-tsc.o
 perf-y += dlfilter-test.o
 perf-y += sigtrap.o
+perf-y += event_groups.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7122eae1d98d..48cd0c809cb1 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -110,6 +110,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__perf_time_to_tsc,
 	&suite__dlfilter,
 	&suite__sigtrap,
+	&suite__event_groups,
 	NULL,
 };
 
diff --git a/tools/perf/tests/event_groups.c b/tools/perf/tests/event_groups.c
new file mode 100644
index 000000000000..92486b68cadb
--- /dev/null
+++ b/tools/perf/tests/event_groups.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include "linux/perf_event.h"
+#include "tests.h"
+#include "debug.h"
+#include "pmu.h"
+#include "header.h"
+#include "../perf-sys.h"
+
+static int event_open(int type, unsigned long config, int g_fd)
+{
+	struct perf_event_attr attr;
+
+	memset(&attr, 0, sizeof(struct perf_event_attr));
+	attr.type = type;
+	attr.size = sizeof(struct perf_event_attr);
+	attr.config = config;
+	attr.disabled = g_fd == -1 ? 1 : 0;
+
+	return sys_perf_event_open(&attr, -1, 0, g_fd, 0);
+}
+
+/* hw: cycles, sw: context-switch, uncore: [arch dependent] */
+int type[] = {0, 1, -1};
+unsigned long config[] = {0, 3, -1};
+
+static int setup_uncore_event(void)
+{
+	char pmu_name[25] = {0};
+	struct perf_pmu *pmu;
+
+#if defined(__x86_64__) || defined(__i386__)
+{
+	char buf[128] = {0};
+
+	if (get_cpuid(buf, sizeof(buf)))
+		return -1;
+	if (strstr(buf, "Intel")) {
+		strcpy(pmu_name, "uncore_imc_0"); /* XXX */
+		config[2] = 0xff04;
+	} else {
+		strcpy(pmu_name, "amd_l3");
+		config[2] = 0xff04; /* l3_cache_accesses */
+	}
+}
+#elif defined(__arm__) || defined(__aarch64__)
+	strcpy(pmu_name, "l2c_220"); /* XXX */
+	config[2] = 0x0;
+#elif defined(__powerpc__)
+	strcpy(pmu_name, "hv_24x7"); /* XXX */
+	config[2] = 0x0;
+#elif defined(__s390x__)
+	strcpy(pmu_name, "pai_crypto"); /* XXX */
+	config[2] = 0x0;
+#else
+	pr_debug("No uncore pmu event found\n");
+	return -1;
+#endif
+
+	pmu = perf_pmu__find(pmu_name);
+	if (!pmu) {
+		pr_debug("Can not find uncore pmu\n");
+		return -1;
+	}
+	type[2] = pmu->type;
+	return 0;
+}
+
+static int run_test(int i, int j, int k)
+{
+	int erroneous = ((((1 << i) | (1 << j) | (1 << k)) & 5) == 5);
+	int fd1, fd2, fd3;
+
+	fd1 = event_open(type[i], config[i], -1);
+	if (fd1 == -1)
+		return -1;
+
+	fd2 = event_open(type[j], config[j], fd1);
+	if (fd2 == -1) {
+		close(fd1);
+		return erroneous ? 0 : -1;
+	}
+
+	fd3 = event_open(type[k], config[k], fd1);
+	if (fd3 == -1) {
+		close(fd1);
+		close(fd2);
+		return erroneous ? 0 : -1;
+	}
+
+	close(fd1);
+	close(fd2);
+	close(fd3);
+	return erroneous ? -1 : 0;
+}
+
+static int test__event_groups(struct test_suite *text __maybe_unused, int subtest __maybe_unused)
+{
+	int i, j, k;
+	int ret;
+	int r;
+
+	ret = setup_uncore_event();
+	if (ret || type[2] == -1)
+		return TEST_SKIP;
+
+	ret = TEST_OK;
+	for (i = 0; i < 3; i++) {
+		for (j = 0; j < 3; j++) {
+			for (k = 0; k < 3; k++) {
+				r = run_test(i, j, k);
+				if (r)
+					ret = TEST_FAIL;
+
+				pr_debug("0x%x 0x%lx, 0x%x 0x%lx, 0x%x 0x%lx: %s\n",
+					 type[i], config[i], type[j], config[j],
+					 type[k], config[k], r ? "Fail" : "Pass");
+			}
+		}
+	}
+	return ret;
+}
+
+DEFINE_SUITE("Event groups", event_groups);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 5bbb8f6a48fc..08570b5505d7 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -147,6 +147,7 @@ DECLARE_SUITE(expand_cgroup_events);
 DECLARE_SUITE(perf_time_to_tsc);
 DECLARE_SUITE(dlfilter);
 DECLARE_SUITE(sigtrap);
+DECLARE_SUITE(event_groups);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
-- 
2.38.1

