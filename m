Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5610E6A7D96
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCBJXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCBJWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:22:55 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2331E1EB;
        Thu,  2 Mar 2023 01:22:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cljCeroKoGIYQyllTIABmhzCNe+eki7dYiUZpOsbo82iD2Ct+NmKThpzz9lyxYh/6Jwthc4cBFFm5o0t7n8u2hr6Nb3U5fuYPXPigm34sauEwM8Z3twR1XNGxoW8/nsJOYuuMW0abYnMemnuDYrJ9sqIfqafsXWstBxky4wsnuFxVfsOTkoJGaKwGakAxcf4StDyPwDvCI1tys5wYJFqKcRmgZPCgLg9pRyZErFaFndSFBukP810OwTTSf8tJcMSQkj9+uqmLu/0ZFN9uGC1+3x9noZJOLb5wJUbHtM3GL+9pcdIItDZQUcoGI2XBScw8JHc6Py/xIWlvRZyXBEs3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmajsnfBk/Ykai2lpT2fZ5iT7ZwF6jhoHAJ5AlTlOTk=;
 b=c5asQgXAQ7EDVLFJwCGYB3jFm7s3LqR1i8crzygWX/eY5NRCvOGU8b7i+j7WnjmcunnLib/UzUh3EsNrnBqgxCv4GQOWg6K3HH8IQKp8eT+fzyMKBr9xnOH+S/Y9IijFtwEVaqgf48y0o/W5nKDi+hh22EzJMs07eT2ywjfh+HtwrKC0TctlVG7Q/j83IxU1bj98WqDRqXfFe9bp7tI619ZDw/y8UV5fxUEUZXgUwVVuYVEv7UOOb0zM8vBvsawECi2ZHyUhpaUPmcHT2tB2gIMb4brfnqlALaF/mZeMOcu1vTseTUIeB4Prb/BemmtAmbjkceCEIqiKZHWGC4bZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmajsnfBk/Ykai2lpT2fZ5iT7ZwF6jhoHAJ5AlTlOTk=;
 b=HbPpq482RNCyY7v1PTmAXfK0uCvUoxKvfLhzBFFHXiY8kPogV9LS/f564YQhjUJs5pmcRhObrg9iSen05YFKzXUGBmGvUcZQwCb1h9ynPU1vZV9tiq1zknQUdRL2U0pK+7V2v6sspwVOK708dmSppnTjL+WZTf1QTwrPG36Th/I=
Received: from BN0PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:143::24)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 09:22:23 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::5c) by BN0PR10CA0021.outlook.office365.com
 (2603:10b6:408:143::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 09:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 09:22:22 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 03:22:16 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <eranian@google.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <irogers@google.com>, <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH 2/2] perf test: Add selftest to test IBS invocation via core pmu events
Date:   Thu, 2 Mar 2023 14:51:09 +0530
Message-ID: <20230302092109.367-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302092109.367-1-ravi.bangoria@amd.com>
References: <20230302092109.367-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a377498-e0b7-4430-6cb6-08db1affa10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBDmpgSxYu2SzYWl+VNcpvLKZwY9x1SfwbzJOWxKohUh5z7H+ArLEDPwQ0jxXxgn/l8GFf/4SkyNTixyhjhjJi3D0Brmzdm/dQQFWkD3frji/CWr1CQX2sO7sz8nVt5zlKJEFI9mCytRorP7Pyqrvk2qCpg5BJbjZZc49fAq2rgbu/6ewV1rzDEG0goLRxiSNlC/O0lQEnmlrJqG1r1LMEVVShVEBV1EeBknR84J0a8O4d4MQ12BV733G0waKI0tHXuUzug10ioKUoehh20V9xEhUU68CYU1v6HiBOr9yjeR8y7j5MN6Wn0ibnJLxoZ4DLHNBMOO+kiE2ysThL2nJm6Sj+WYAt3R374N0c9Dwh6RS9zd7xPQaGIm7H6FWq4yKbA67g6+0rYllk7XagqeGzp/F5xB/Mj8kwNUm4fjz6cMADqruemB12cqUJsoHCafgzoJCon8KH0EW+hQNC2ECRZmjaI+jTIpu6D1MgKQYagnEMudWkC8A2hy1VDzSRR9ufCCTJl5cyZFZRs1Htajr6GrWRLW9bXzGm+6SZP7wZXkEYhfiX7NTJzUdi5HQzQVHM6OucWbFqiW2Gpu2rhJygUwzsX8aSpx4ErCI60qGRO/YdY6jKiafqGpw0ocfidffYxdlLFSk5pSKThpTbPMQdnDYRINW0s7dlPSIpMvK8HH3f+SMInaKRV/jUCMQ/j5er3jd3cUNffdpzNSik0THc0JOH1KowVHeK58E+cwjxg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(36860700001)(47076005)(426003)(6666004)(36756003)(40460700003)(5660300002)(81166007)(82740400003)(7416002)(478600001)(8936002)(356005)(86362001)(40480700001)(82310400005)(16526019)(186003)(26005)(2616005)(1076003)(336012)(7696005)(2906002)(6916009)(8676002)(70206006)(44832011)(70586007)(4326008)(316002)(41300700001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 09:22:22.3517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a377498-e0b7-4430-6cb6-08db1affa10c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS pmu can be invoked via fixed set of core pmu events. Add simple
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

