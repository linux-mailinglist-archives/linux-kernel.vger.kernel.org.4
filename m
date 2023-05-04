Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465BB6F696E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjEDLCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjEDLC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:02:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275FA55AC;
        Thu,  4 May 2023 04:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIpYIrFHOnH1FVqmuA8gx5C01P+EC1Ljy+/lSzuVLQhaXtO3V1N9vXcVG/waERxrHehhP/xw3sl2uJkcB0rFA/Ojj5a8Q73x/acpVwuNoXMhztcUiIJj4QjBz3Aq8wwpvGP0jUtRIjjjdzim1uuVXyxr1pG0PuG2KVc9mxdsSqQpyF4KWlU1EfvSxnmYGmyiH7A6Aro9DHfQcagsby/5fYWCP65wB3XDL/KPH+iXIQtrjvm5zsD5CBSBCxpycfDoXPO5fh7qMf1ABNALoTyBkshFsVirQ4hhJ5y5tCZ7P2sWBRhyHRdPVu6FY0oMl1y7uV8Fmc8SRy2xX3TZzzqzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOdJ7nTDjmZQZ3SGE1wJAME/2JpPiVEqYIjC/KOzfOM=;
 b=a5rUBeSJtTVjx21qK/Rl8TL5ZEtO20b18LqMXBzVINuRCh4hReLiTFIjSta9hvVD3wo63WULOrvTqUS3uo/s84i5vX40bzSpaRKldZzyPM4XbqrOuH+WYpuMGiAibnoy3dnVdCaIUA8Yqd8R/3XlITq+mrr7FJlP4RgiE5xUqF4o/v9ZT8VUsqjJyWSfZSDtxIK+AQR09bpzT1qOc5N3D4PmN7/ZdULZuGy+EL90oaHZ/TcJzN8Tb0lezrx7pG/SJOk18sY8AEPYLD3ji893IDM3c5g8emRT0gyjUZnZmjhRc67M4fuExjuAd44MrwNQyz1wFQ0t6k0O0IdzLOnNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOdJ7nTDjmZQZ3SGE1wJAME/2JpPiVEqYIjC/KOzfOM=;
 b=koAa9dTO0iu3uEgPXEvX85luvoNJ/vi+6tVN1YvaSNkyAQmV3k4XImy90z+p7BOlN0Uc2QAd/084OHwI0shEwkaI5u6gh7qpp7w5ODOs5WrF1iztrr6xkWTuFrFgFCK6ei0HWJI2CkSMKbdwn/ySQFFqhURKtXdaQAnXDZsbeac=
Received: from BYAPR07CA0043.namprd07.prod.outlook.com (2603:10b6:a03:60::20)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 11:02:13 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::37) by BYAPR07CA0043.outlook.office365.com
 (2603:10b6:a03:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26 via Frontend
 Transport; Thu, 4 May 2023 11:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.26 via Frontend Transport; Thu, 4 May 2023 11:02:12 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 4 May
 2023 06:02:05 -0500
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
Subject: [PATCH v4 4/4] perf test: Add selftest to test IBS invocation via core pmu events
Date:   Thu, 4 May 2023 16:30:03 +0530
Message-ID: <20230504110003.2548-5-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: b26d038f-26c7-4558-eb2e-08db4c8f0345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztBrKU972wZgouYdGXP/k9n8Ome4c09i3AZqZt2VbOdkpYnCsHw2DGVMppEBghg0hXbKoHt/yKw1Ej/YP5veajNT6SgpY+6yqTWXvsLI8LfoOA+lyrAJMj7o/QtNjtuFgv4TfXPEm/TVDfNt9Jpm9+WR0oSboejO5D6gHvipQal/bJ3AaQo+M3oYbBqJfgka3yQO7epYELhGtrD4N7p0C3uiaxjRj0DExP61PYyCY+e7Ayx2HlwYhSMRlx2mmeFOX474lQ9f/k07LyzvFQbjqcN+FEoKEGMFYFCkMA9lPv4Z319RaDOcpwXGU4EWP41etmuzIAI2uT6ynBB1fZAPANDJN7TelJUYibliaXwG7IHqZo6oMlyJVNnSTIoswzr2CNG3zyiqn2cyRDjRtlZRzV6n416AS3aE7gWWl3FsZphIxOj8Isn3CZryjFDZrJj0PVKeIcG7Q0XLpy3RgPi9302pQ00sw3BFNzHVICebcHOtKVlJ6AKtQ0WpdZ1NXAYK5eR63CrMRgFQ4HwK3HxFeW24VDlTuCH9hwJVAzF4g0X1gFEM8yjwzuymj3GMeynAw90f2fP/7JnVymYvxbVF4XsU3LBXZcmkCKwC3D3Xt8cLWCB/lCEekc983t3U7guyVwnKZ4LrlDW3UFh/LEpZflBjnef/1SkU78Ig4UkW0Zu8E9aixOw4Pmb+/x7Kr1CL7sFBMBNn/1ChfwMsLzYFONRXPcKRCWN7edx1kEbS0qg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(54906003)(36756003)(7696005)(70586007)(70206006)(6916009)(4326008)(316002)(82740400003)(41300700001)(5660300002)(1076003)(44832011)(8936002)(8676002)(7416002)(81166007)(82310400005)(40480700001)(86362001)(26005)(186003)(16526019)(356005)(2906002)(336012)(47076005)(2616005)(426003)(36860700001)(40460700003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 11:02:12.1224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b26d038f-26c7-4558-eb2e-08db4c8f0345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
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
 tools/perf/arch/x86/include/arch-tests.h      |  1 +
 tools/perf/arch/x86/tests/Build               |  1 +
 .../arch/x86/tests/amd-ibs-via-core-pmu.c     | 71 +++++++++++++++++++
 tools/perf/arch/x86/tests/arch-tests.c        |  2 +
 4 files changed, 75 insertions(+)
 create mode 100644 tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index 902e9ea9b99e..93d3b8877baa 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -11,6 +11,7 @@ int test__intel_pt_pkt_decoder(struct test_suite *test, int subtest);
 int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
 int test__bp_modify(struct test_suite *test, int subtest);
 int test__x86_sample_parsing(struct test_suite *test, int subtest);
+int test__amd_ibs_via_core_pmu(struct test_suite *test, int subtest);
 
 extern struct test_suite *arch_tests[];
 
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 6f4e8636c3bf..fd02d8181718 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -5,3 +5,4 @@ perf-y += arch-tests.o
 perf-y += sample-parsing.o
 perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-test.o
 perf-$(CONFIG_X86_64) += bp-modify.o
+perf-y += amd-ibs-via-core-pmu.o
diff --git a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
new file mode 100644
index 000000000000..2902798ca5c1
--- /dev/null
+++ b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arch-tests.h"
+#include "linux/perf_event.h"
+#include "tests/tests.h"
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
+int test__amd_ibs_via_core_pmu(struct test_suite *test __maybe_unused,
+			       int subtest __maybe_unused)
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
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index aae6ea0fe52b..b5c85ab8d92e 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -22,6 +22,7 @@ struct test_suite suite__intel_pt = {
 DEFINE_SUITE("x86 bp modify", bp_modify);
 #endif
 DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
+DEFINE_SUITE("AMD IBS via core pmu", amd_ibs_via_core_pmu);
 
 struct test_suite *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
@@ -35,5 +36,6 @@ struct test_suite *arch_tests[] = {
 	&suite__bp_modify,
 #endif
 	&suite__x86_sample_parsing,
+	&suite__amd_ibs_via_core_pmu,
 	NULL,
 };
-- 
2.40.0

