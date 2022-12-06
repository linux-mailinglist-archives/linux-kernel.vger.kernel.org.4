Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92969643C4C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 05:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiLFEdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 23:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiLFEdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 23:33:40 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE4F13DED;
        Mon,  5 Dec 2022 20:33:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXJnfL5ol07KD4aajWBdXJBiwyYGGTpvGXxXRPx0sDoTcMaEO54ICByoBDbgdCihdHrOIUQW/7feqfVdWu9qAKCKMLmNBGQAd3YopNagN4RzyUGRhWT8RP9m1XYg4Lx/gqOGqS9lcaIwGyJ6+ZMSXaPSUjhCRfVfAd0Nbt2+B4TO4hmqh1/plZ5jf3b+wgHTur2j89y2ft3cZrMm7YKAqZWlbVwHD63E4EZR2jEtrm3EN8CPaKED5JMj9q7vl14lZUtEDJsw331Za5upTCsEstNnXN0N6hzlvWEMGB1hBNBhXic65ycbbEPV2ttqcZbkrzDR7+op+Zan3GJFv1Drgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RilhmHvqRNFXbKJzM+NokHXPn4Dey1DigzncIeCw9MM=;
 b=fF1ph3FC5R2cLPH3qznGzncsORQu4s1Z4PU9kRF6zyusnwt3sksINtXfTmHmrxt486G5vLfAvFhb3MAB/HSofdVUd7tvBfx9VlsZVDq56Ka2kdNAXS7d840uTVuI857JIBENh4BxXySq98U+Wkb5m6ZWJgdn1zTfgvCPJkV9i5Zq6/nvMopW4lsDDouzLuuAK6QP4qim2moEr+PmqCif1DoZkYR/VLo7UULrGAREXUZfXTm33ez+IDx99FbwcJBWUjj3EQ1cbj707v2EInYm+guTxYxoGVCWwARhBYjYZD0RFUYqltMTtxXSWhm3ZCKZHQnYDsrU3J/K55QmQoBjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RilhmHvqRNFXbKJzM+NokHXPn4Dey1DigzncIeCw9MM=;
 b=P63sTJN3sz2YrHe2PRLGt9pWmQE4Y+wYEUD/xi4m6JoaoqLw4WtAD7Ilqw7jvcGpKw7R7m6g/vbQGXmySXfJ/vOQUB62kCG/b3BO2N5I2/vjtyDcFD8OA9YvybfvktCrIkHJS9G92dEWcV3X0s1SVtb/KG/+0BNOfVFcQ3+/VSk=
Received: from DS7PR07CA0020.namprd07.prod.outlook.com (2603:10b6:5:3af::12)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 04:33:30 +0000
Received: from DS1PEPF0000E658.namprd02.prod.outlook.com
 (2603:10b6:5:3af:cafe::65) by DS7PR07CA0020.outlook.office365.com
 (2603:10b6:5:3af::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 04:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E658.mail.protection.outlook.com (10.167.18.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Tue, 6 Dec 2022 04:33:30 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 22:33:24 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <kan.liang@linux.intel.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>,
        <adrian.hunter@intel.com>, <alexander.shishkin@linux.intel.com>,
        <carsten.haitzler@arm.com>, <leo.yan@linaro.org>,
        <maddy@linux.ibm.com>, <kjain@linux.ibm.com>,
        <atrajeev@linux.vnet.ibm.com>, <tmricht@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 2/2] perf test: Add event group test
Date:   Tue, 6 Dec 2022 10:02:37 +0530
Message-ID: <20221206043237.12159-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221206043237.12159-1-ravi.bangoria@amd.com>
References: <20221206043237.12159-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E658:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: a8714af8-6a23-4ab3-dcc0-08dad74306dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRAUmRvIWCv/cwJvf4YYy5HS8eSLnLzjHLKyb0aeJZp4kZqkqLY6IraMKI+Z3wf+WkGgRISb7JEj6LQG3jhSCJt9wlN9me8uSPMOqP0FKIYzJK3UjoBeKjKqtBtMTboglMbUUYAFbk7D3II3RCyzGE376PO586O+be2gRDgaukQfFMTCMrD6esBd2+Dw8s20f7jUONRb6BjFBSpxqqa1doDYqJh1pbGRctogwHifK5/JLHgNv0PjOr/p/0fhjjd8QoOcwBdHnPP+MWm/eb0IAGTvzvOCNRkVNgmd500Pq/viSNkVtw7hoPULayMA6r26/Qv60GN6dfvkQ6fWb5OJvit96YG0bYz3uYlVwhMOYdc4l81iL8J1NYv6Qh1aICJNiECVgjX8QnFI3OCM0R6a23S3qMs1jY2lZYSKZQC13WQNbc7we6B7mooIepKitozD2P01778UEy1NVzOzQSzlXFrLo81msxEJX2xpRjCRQ+H6xGTRJPSEIOCo+YvV4wezpqSzsuZ7QGQaqXns0yJQP+nX6gKH9bJK9rRdwpzOvRo1nuGy+oxRi+LjWj7900P+SfD+FfQuC1/W5wUcglzpnFEBtwP5TV0Bf6SHBINzO5IzBuADR+dd7umw1DYs9RDsJmgD4PFAjnPqeqL083XnjNF8CRZprE4sRcnh3FrxU6ffRLVhCXq7ALfv7ctGekwbPZ4pgtf0gjILLML22dXjAhq273o+jM/Bco0X6aBYYWs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(356005)(478600001)(8936002)(82740400003)(8676002)(5660300002)(41300700001)(44832011)(4326008)(70586007)(54906003)(7416002)(2906002)(40460700003)(36756003)(86362001)(81166007)(6916009)(316002)(82310400005)(70206006)(186003)(2616005)(426003)(1076003)(336012)(47076005)(36860700001)(83380400001)(40480700001)(16526019)(6666004)(26005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 04:33:30.3483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8714af8-6a23-4ab3-dcc0-08dad74306dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E658.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697
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
there are some limitations to it. One of the limitation is, perf
doesn't allow creating a group of events from different hw pmus.
Write a simple test to create various combinations of hw, sw and
uncore pmu events and verify group creation succeeds or fails as
expected.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/event_groups.c | 127 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 130 insertions(+)
 create mode 100644 tools/perf/tests/event_groups.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 11b69023011b..658b5052c24d 100644
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
index 4c6ae59a4dfd..ddd8262bfa26 100644
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
index 000000000000..612c0444aaa8
--- /dev/null
+++ b/tools/perf/tests/event_groups.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include "linux/perf_event.h"
+#include "tests.h"
+#include "debug.h"
+#include "pmu.h"
+#include "pmus.h"
+#include "header.h"
+#include "../perf-sys.h"
+
+/* hw: cycles, sw: context-switch, uncore: [arch dependent] */
+static int types[] = {0, 1, -1};
+static unsigned long configs[] = {0, 3, 0};
+
+#define NR_UNCORE_PMUS 5
+
+/* Uncore pmus that support more than 3 counters */
+static struct uncore_pmus {
+	const char *name;
+	__u64 config;
+} uncore_pmus[NR_UNCORE_PMUS] = {
+	{ "amd_l3", 0x0 },
+	{ "amd_df", 0x0 },
+	{ "uncore_imc_0", 0x1 },         /* Intel */
+	{ "core_imc", 0x318 },           /* PowerPC: core_imc/CPM_STCX_FIN/ */
+	{ "hv_24x7", 0x22000000003 },    /* PowerPC: hv_24x7/CPM_STCX_FIN/ */
+};
+
+static int event_open(int type, unsigned long config, int group_fd)
+{
+	struct perf_event_attr attr;
+
+	memset(&attr, 0, sizeof(struct perf_event_attr));
+	attr.type = type;
+	attr.size = sizeof(struct perf_event_attr);
+	attr.config = config;
+	/*
+	 * When creating an event group, typically the group leader is
+	 * initialized with disabled set to 1 and any child events are
+	 * initialized with disabled set to 0. Despite disabled being 0,
+	 * the child events will not start until the group leader is
+	 * enabled.
+	 */
+	attr.disabled = group_fd == -1 ? 1 : 0;
+
+	return sys_perf_event_open(&attr, -1, 0, group_fd, 0);
+}
+
+static int setup_uncore_event(void)
+{
+	struct perf_pmu *pmu;
+	int i;
+
+	if (list_empty(&pmus))
+		perf_pmu__scan(NULL);
+
+	perf_pmus__for_each_pmu(pmu) {
+		for (i = 0; i < NR_UNCORE_PMUS; i++) {
+			if (!strcmp(uncore_pmus[i].name, pmu->name)) {
+				pr_debug("Using %s for uncore pmu event\n", pmu->name);
+				types[2] = pmu->type;
+				configs[2] = uncore_pmus[i].config;
+				return 0;
+			}
+		}
+	}
+	return -1;
+}
+
+static int run_test(int i, int j, int k)
+{
+	int erroneous = ((((1 << i) | (1 << j) | (1 << k)) & 5) == 5);
+	int group_fd, sibling_fd1, sibling_fd2;
+
+	group_fd = event_open(types[i], configs[i], -1);
+	if (group_fd == -1)
+		return -1;
+
+	sibling_fd1 = event_open(types[j], configs[j], group_fd);
+	if (sibling_fd1 == -1) {
+		close(group_fd);
+		return erroneous ? 0 : -1;
+	}
+
+	sibling_fd2 = event_open(types[k], configs[k], group_fd);
+	if (sibling_fd2 == -1) {
+		close(sibling_fd1);
+		close(group_fd);
+		return erroneous ? 0 : -1;
+	}
+
+	close(sibling_fd2);
+	close(sibling_fd1);
+	close(group_fd);
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
+	if (ret || types[2] == -1)
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
+					 types[i], configs[i], types[j], configs[j],
+					 types[k], configs[k], r ? "Fail" : "Pass");
+			}
+		}
+	}
+	return ret;
+}
+
+DEFINE_SUITE("Event groups", event_groups);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index e15f24cfc909..fb4b5ad4dd0f 100644
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

