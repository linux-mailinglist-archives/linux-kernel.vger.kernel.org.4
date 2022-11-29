Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21563BEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiK2LUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiK2LU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:20:27 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B8C53EF9;
        Tue, 29 Nov 2022 03:20:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3keBq9b78rk7c/bR5v1a0xfidOqMNWMzCRkcX1rbqkkTNGQ7pgK/O5a5oh5/xJA0lDRiTrlLL3aCPUJ5elZyFSHXhco7zQljuYYIxwSMz55FNpZSbLQu6Q3hzcuZqKi7enVgvW5m9j6Zb1/adWVvmO1diWx9STBg+wdVpzoy/qC/lCKeGIjtSkvxCUA6ylJR2VpwRFAXEEHNr9QWg3gNDSen/iSd2D2bw9NhKICFn2UjxEVOXntc3ESn2APV3Hv7Sm5AUzkgg2qn/jvk+b+zYwYuoHWJ7G6SWFkqhjQ4d0CpOcJj6dqsTL35NXzv8XwCc0vnBbxDPTG37AWvesFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgwE1RM+9KanyCYitgE8ZPA0WkniF1/I3G4Enee3how=;
 b=FE7Q/exqMwIdXwzc8ll3yOIjrVFCWiUeSBUaUqvX3vN7vnYWlf5+E3uzVujTItTt0PxHn2nGyYxiecYUJb3zlAAC2MVhtDatNCucrcwldn/A1E7RaOzCUo/SrziLZ1nk01RSFRSatq5v4lXhzrVb4nMABNz2A3RSdV+NDONI9BIHqK70TJNJiMkFx5dvymx/oedACcKc6uXfPpeh22tT2zrpOjgUUA4WEqTc+oGa5N/s8w1p5AwjVytR4+zdnx4y9XkQoIJ4MuaHriedAFPMadO/E+yOq0hPeztqiUpqy5/LVOluEpspVhlFP6ZrGygqkKtdiYjOGiDuUArREvwyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgwE1RM+9KanyCYitgE8ZPA0WkniF1/I3G4Enee3how=;
 b=ReRVEOJjGWeJEnf18p93AIoVxGSvV7DTdxXxYkrWyQndZDXrjHZbjEHmA53vpaMPVQpuJzNNv/cD/jhRJVOPAoR94+DrmqiNa65O2e3Vg6uIZBll1lUuQywEyQK1ZaJLjHgnjigU6hlGZBpz8rlO53qyu5Q2mZA8bhs6S5Lx0bM=
Received: from DM6PR08CA0061.namprd08.prod.outlook.com (2603:10b6:5:1e0::35)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 11:20:23 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::48) by DM6PR08CA0061.outlook.office365.com
 (2603:10b6:5:1e0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 11:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 29 Nov 2022 11:20:23 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 29 Nov
 2022 05:20:17 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <mark.rutland@arm.com>, <kan.liang@linux.intel.com>,
        <adrian.hunter@intel.com>, <alexander.shishkin@linux.intel.com>,
        <carsten.haitzler@arm.com>, <leo.yan@linaro.org>,
        <maddy@linux.ibm.com>, <kjain@linux.ibm.com>,
        <atrajeev@linux.vnet.ibm.com>, <tmricht@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v2 2/2] perf test: Add event group test
Date:   Tue, 29 Nov 2022 16:49:46 +0530
Message-ID: <20221129111946.409-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129111946.409-1-ravi.bangoria@amd.com>
References: <20221129111946.409-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0cc858-d268-4845-ef6c-08dad1fbb566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SwlXejpjYf03xVG7oOXGzqoh14GrIviRyRKmwAIy6+qQNvcDa1NgJ8WbAwQHONEKkQaGxVBmDsx1IW/Zjwfwh0ZwZpPpBDG59R69XnLTdflvjHjB+NZTVxaz4oHiuAL/Te61Eey2hLf6MNiKt3/ZJpLgNZ+KTCsCUzbnO853I1RDnkrWdfBDKrcViANhGnkPiye/0BZNOzo4ZpePWmhS+TJDxg7H70u2z5QSPYMTt7r/tQs2LkdtUIjyUu8XMAFP/uTdELgKyRaKbzwUnFpt+ve3ggAMEiWAzUA8V3w06Jy7Eenra7pZGBNZJM9nYuIqxiOot++nOt7zzuqg2EThpZthE0+/Hpgsb92LOXynpaH1hVDLTmH8JyaSBNIVHksCi4dNASLoE72/YTDqvUw21dqiCyALnTKREmBXBZkEyAAL0il8cUEruUrgPrgpONuLXvCGCG7a6UjRffsjsSuOW/jw545c1A1yyZKnJO9K/lhNnw+ilu0uPJ7QUXUsHKY3LVXDU8uhOKXMvPGVZrJ0Ya82jxkQwvgmlwveST7XmqdQ6+JAyS60BBuNVVrq1QX5IX8TA7DnzZMyuLocs6pKl0pYLd01nIZMDhQtClFVW2m1Yjv65duVjHqpCqIr4wJXPrts4zhir58raIsI48Mi675VhBFupRsl3UGwVdH3z8UyeYmNNm6mKWhwa81rNz9fjD3d9vS4fGDqToqj8ujgbtKN74xbfFsB34EZZt+lb1k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(47076005)(426003)(336012)(83380400001)(26005)(6666004)(54906003)(7696005)(36756003)(81166007)(356005)(86362001)(40480700001)(2616005)(82740400003)(186003)(40460700003)(36860700001)(1076003)(44832011)(16526019)(41300700001)(82310400005)(8936002)(7416002)(316002)(478600001)(5660300002)(6916009)(4326008)(2906002)(70206006)(70586007)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 11:20:23.5983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0cc858-d268-4845-ef6c-08dad1fbb566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
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
 tools/perf/tests/event_groups.c | 109 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 112 insertions(+)
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
index 000000000000..4002b467cc8f
--- /dev/null
+++ b/tools/perf/tests/event_groups.c
@@ -0,0 +1,109 @@
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
+/* hw: cycles, sw: context-switch, uncore: [arch dependent] */
+static int type[] = {0, 1, -1};
+static unsigned long config[] = {0, 3, 0};
+
+static int setup_uncore_event(void)
+{
+	struct perf_pmu *pmu;
+
+	if (list_empty(&pmus))
+		perf_pmu__scan(NULL);
+
+	perf_pmus__for_each_pmu(pmu) {
+		if (pmu->is_uncore) {
+			pr_debug("Using %s for uncore pmu event\n", pmu->name);
+			type[2] = pmu->type;
+			return 0;
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
+	group_fd = event_open(type[i], config[i], -1);
+	if (group_fd == -1)
+		return -1;
+
+	sibling_fd1 = event_open(type[j], config[j], group_fd);
+	if (sibling_fd1 == -1) {
+		close(group_fd);
+		return erroneous ? 0 : -1;
+	}
+
+	sibling_fd2 = event_open(type[k], config[k], group_fd);
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

