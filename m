Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528116EE3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbjDYOXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjDYOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:23:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692B14453;
        Tue, 25 Apr 2023 07:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwa1yvCC/CC+z46ZHfWu/BaNt8/9zCmaPCir+5SrfBkiXgoP/u7VOM5huovA/ybll5kGY7q7lZGAg3lQZTd4gZ5Ya9NsTZ9x5iMhdCf6jqQwH7hektIUHzuuDUsQPzMbTLclPgDZ1XRZkTTWmKMgLuInhQ8E62QKlzInXB6WL+lyhDaNIrdB5B+154aX2Sn0q0lsNeQvR9cPFSVB/Fy+ot0NtlkseXdWH/476VycUHTLXFaSpbyTFnwckxPnULOh/0p2XIszOzfkfzCJvojTS4yOBhmut/RkdFUjFKCmOJ+pcj/mAF30K4A/bZFR1fWod0Pg/w1Bo/hfDOf+t8oJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01m5TXD/3TzUCJMYjvWCM+NfHpOUV06iujo9Rz8WRrs=;
 b=EQfC/QeAimpq6iLSrawudxZWRwbtHDFB2TYMnsF0YlpDOCxhAiBvUWhZ5Drw/RTQ+Mg1X5Tb6lrD7IBrIRV2sXNUOR7YTPS0VNYMmKPi+0kuKAprBQ358nHMnKwjxNuY8PVV/HWDh3XEreqwnOdWkJyr11eJV7wyHGrMWq8cPJbtEX+0JaaYFidBqon269Bc3alA2DzllySX7QeEM/RZaNVH4nOk+98ejgdbYskwEezlj2ilFO1tfTrxI7/JES3vXm8evemn20G0jub+JsC+2TLu3N0PpYqusC7BwI+bR0gsKRClmCFCgYbrWc/HF6vTl+pS32gM04gcOY6baCcf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01m5TXD/3TzUCJMYjvWCM+NfHpOUV06iujo9Rz8WRrs=;
 b=1kL3hpaeKyabN860mjwnPxkqVB2XL5qCSNUZYBY1YVoGB2TAxa8A/39XyWhWdCbBcCi7clW14hxjojtM/GMQLAm1cMv1ObEFgGff6aj0IMSDU2bFpDQJrVwnpDKONhGqTm5x5YZQut+9M2WUHvQfv5XV7cVtROqoVfM9PylFrdI=
Received: from BN9PR03CA0556.namprd03.prod.outlook.com (2603:10b6:408:138::21)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Tue, 25 Apr
 2023 14:23:02 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::d7) by BN9PR03CA0556.outlook.office365.com
 (2603:10b6:408:138::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 14:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 14:23:01 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 09:22:53 -0500
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
Subject: [PATCH v3 3/3] perf test: Add selftest to test IBS invocation via core pmu events
Date:   Tue, 25 Apr 2023 19:52:05 +0530
Message-ID: <20230425142205.762-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425142205.762-1-ravi.bangoria@amd.com>
References: <20230425142205.762-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT090:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: ca78b9e4-87d1-49a2-0038-08db459893cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6LOPy2JJr2QrBuBCSZQNRcYLg2UF9MPSTMDX9n9I5hYwcrJGkEp/OysP3OnPF2fac+tRoxRMnfMW+7rXEW+6zMq8JB99KZIhfOCdNoOiX5487YRHrFu4gBDQm88ma7afjfykECB4cQgXA7NYIBdOGEn7e1ahczvcUY4PXF3914Ze86pCYHz2vKPC0LBtTEr0wo4HN4+qI50LJG1XPD4mVJm5nSUh7On3hhEaSy8T94f603bpUxQKZfEk4tfr1aovLB4Sd2PQ4jLb11r9oib2SPywm576bMfonY+SACyB6nO+cFmdlnrvBnb3HbtYEHoJnqPnmN2BA8iXVmH44bpD6CoobtoPGRcWpNnJNPjnLB8cVFoi/3QpTZSSVT2dOhi06zD20LwDkdovhRg8Dh6oPk3yZ2WevjPD/rair9K1PkHGeVUqmEL9atHqlLZN9l+TgV/xhO0Unyg4sAC73qFkXISrxjaBGm/HA0W/7cztATxEpFc2O1+mJg/pYSCbNVgfAGJOjpTxpo23a+iYOFnPXeK7/icgven5QCS4XTHz9GDd9VaD7Y3i6Un+3J9Ieq+qzMqONe2ivh+XR3SHnwzss3lZ1rc0Z78RBT8xwRa3fzuXJVP0ueJ8xzz3lSxpNRYZ0dZEdp0GeX26pscfPXSPPfHaS7eBGSZEyxbAnl8jcgL2/cE0j8rEC/hL9+hQ+gnbmIEffy+4qrpgg2qmUu/dquGixQUVoLd4J2S1Nfxtfc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(36860700001)(83380400001)(47076005)(2616005)(478600001)(40480700001)(7696005)(1076003)(26005)(6666004)(316002)(6916009)(70586007)(70206006)(4326008)(82740400003)(186003)(16526019)(336012)(426003)(81166007)(356005)(7416002)(5660300002)(44832011)(40460700003)(8676002)(8936002)(2906002)(41300700001)(86362001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:23:01.9750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca78b9e4-87d1-49a2-0038-08db459893cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
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

IBS pmu can be invoked via fixed set of core pmu events with 'precise_ip'
set to 1. Add a simple event open test for all these events.

Without kernel fix:
  $ sudo ./perf test -vv 76
   76: AMD IBS via core pmu                                      :
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
  AMD IBS via core pmu: FAILED!

With kernel fix:
  $ sudo ./perf test -vv 76
   76: AMD IBS via core pmu                                      :
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
  AMD IBS via core pmu: Ok

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/tests/Build                  |  1 +
 tools/perf/tests/amd-ibs-via-core-pmu.c | 72 +++++++++++++++++++++++++
 tools/perf/tests/builtin-test.c         |  1 +
 tools/perf/tests/tests.h                |  1 +
 4 files changed, 75 insertions(+)
 create mode 100644 tools/perf/tests/amd-ibs-via-core-pmu.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index fb9ac5dc4079..ff7234653503 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -69,6 +69,7 @@ perf-y += dlfilter-test.o
 perf-y += sigtrap.o
 perf-y += event_groups.o
 perf-y += symbols.o
+perf-y += amd-ibs-via-core-pmu.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/amd-ibs-via-core-pmu.c b/tools/perf/tests/amd-ibs-via-core-pmu.c
new file mode 100644
index 000000000000..6f6eb2d84fde
--- /dev/null
+++ b/tools/perf/tests/amd-ibs-via-core-pmu.c
@@ -0,0 +1,72 @@
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
+static int test__amd_ibs_via_core_pmu(struct test_suite *text __maybe_unused,
+				      int subtest __maybe_unused)
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
+		}
+
+		if (fd > 0)
+			close(fd);
+	}
+
+	return ret;
+}
+
+DEFINE_SUITE("AMD IBS via core pmu", amd_ibs_via_core_pmu);
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 35cc3807cc9e..1805a4fae762 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -119,6 +119,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__sigtrap,
 	&suite__event_groups,
 	&suite__symbols,
+	&suite__amd_ibs_via_core_pmu,
 	NULL,
 };
 
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9a0f3904e53d..65589d40638d 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -149,6 +149,7 @@ DECLARE_SUITE(dlfilter);
 DECLARE_SUITE(sigtrap);
 DECLARE_SUITE(event_groups);
 DECLARE_SUITE(symbols);
+DECLARE_SUITE(amd_ibs_via_core_pmu);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
-- 
2.40.0

