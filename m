Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B513961960B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiKDMSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiKDMSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:18:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31171B1D2;
        Fri,  4 Nov 2022 05:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667564311; x=1699100311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nkb1aoerxeuYEOdE+BsMw78xrCR9ITNnBZN8jPViLk4=;
  b=CD6Z6h/Ly83Bg9Ymn5uAUs8888CE4mB2YMwVBvRqAV3GE1j0phRiXgaT
   BRPno56+4/+ayJ7Egc12Ck4ie0umPGb203Pwf4JVluDJyJ8wQyADdWQwa
   C3ld4POLt7DRAuTpB1G2ePDT6818LWmOGYsDAHvYfw26ySJjoCWp0GY/h
   PXiVC02lzGBCwd91Ke1KMEnY6OYcVJHVDQybJi/ckjtqzteAr2sh1h0G/
   vmbQnASEFze305kpakADnNfgMx4hEzQxOIspAiqkMaWWVML5ML6PCIpva
   z/GTLGrXdvW5jWhnJXi/C6qXE6dVnaynmfvQWrhtISp0xslr+VNyJLkUK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="290341731"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="290341731"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 05:18:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="760309132"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="760309132"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.118])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 05:18:29 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf: intel-pt: Add hybrid CPU compatibility test
Date:   Fri,  4 Nov 2022 14:18:05 +0200
Message-Id: <20221104121805.5264-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104121805.5264-1-adrian.hunter@intel.com>
References: <20221104121805.5264-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel driver assumes hybrid CPUs will have Intel PT capabilities
that are compatible with the boot CPU. Add a test to check that is the
case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/include/arch-tests.h  |   1 +
 tools/perf/arch/x86/tests/arch-tests.c    |   3 +-
 tools/perf/arch/x86/tests/intel-pt-test.c | 154 ++++++++++++++++++++++
 3 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index 6a1a1b3c0827..902e9ea9b99e 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -8,6 +8,7 @@ struct test_suite;
 int test__rdpmc(struct test_suite *test, int subtest);
 int test__insn_x86(struct test_suite *test, int subtest);
 int test__intel_pt_pkt_decoder(struct test_suite *test, int subtest);
+int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
 int test__bp_modify(struct test_suite *test, int subtest);
 int test__x86_sample_parsing(struct test_suite *test, int subtest);
 
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index 8d5e4a0831d5..aae6ea0fe52b 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -8,11 +8,12 @@ DEFINE_SUITE("x86 instruction decoder - new instructions", insn_x86);
 
 static struct test_case intel_pt_tests[] = {
 	TEST_CASE("Intel PT packet decoder", intel_pt_pkt_decoder),
+	TEST_CASE("Intel PT hybrid CPU compatibility", intel_pt_hybrid_compat),
 	{ .name = NULL, }
 };
 
 struct test_suite suite__intel_pt = {
-	.desc = "Intel PT packet decoder",
+	.desc = "Intel PT",
 	.test_cases = intel_pt_tests,
 };
 
diff --git a/tools/perf/arch/x86/tests/intel-pt-test.c b/tools/perf/arch/x86/tests/intel-pt-test.c
index 42237656f453..70b7f79396b1 100644
--- a/tools/perf/arch/x86/tests/intel-pt-test.c
+++ b/tools/perf/arch/x86/tests/intel-pt-test.c
@@ -1,12 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/compiler.h>
+#include <linux/bits.h>
 #include <string.h>
+#include <cpuid.h>
+#include <sched.h>
 
 #include "intel-pt-decoder/intel-pt-pkt-decoder.h"
 
 #include "debug.h"
 #include "tests/tests.h"
 #include "arch-tests.h"
+#include "cpumap.h"
 
 /**
  * struct test_data - Test data.
@@ -313,3 +318,152 @@ int test__intel_pt_pkt_decoder(struct test_suite *test __maybe_unused, int subte
 
 	return TEST_OK;
 }
+
+static int setaffinity(int cpu)
+{
+	cpu_set_t cpu_set;
+
+	CPU_ZERO(&cpu_set);
+	CPU_SET(cpu, &cpu_set);
+	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
+		pr_debug("sched_setaffinity() failed for CPU %d\n", cpu);
+		return -1;
+	}
+	return 0;
+}
+
+#define INTEL_PT_ADDR_FILT_CNT_MASK	GENMASK(2, 0)
+#define INTEL_PT_SUBLEAF_CNT		2
+#define CPUID_REG_CNT			4
+
+struct cpuid_result {
+	union {
+		struct {
+			unsigned int eax;
+			unsigned int ebx;
+			unsigned int ecx;
+			unsigned int edx;
+		};
+		unsigned int reg[CPUID_REG_CNT];
+	};
+};
+
+struct pt_caps {
+	struct cpuid_result subleaf[INTEL_PT_SUBLEAF_CNT];
+};
+
+static int get_pt_caps(int cpu, struct pt_caps *caps)
+{
+	struct cpuid_result r;
+	int i;
+
+	if (setaffinity(cpu))
+		return -1;
+
+	memset(caps, 0, sizeof(*caps));
+
+	for (i = 0; i < INTEL_PT_SUBLEAF_CNT; i++) {
+		__get_cpuid_count(20, i, &r.eax, &r.ebx, &r.ecx, &r.edx);
+		pr_debug("CPU %d CPUID leaf 20 subleaf %d\n", cpu, i);
+		pr_debug("eax = 0x%08x\n", r.eax);
+		pr_debug("ebx = 0x%08x\n", r.ebx);
+		pr_debug("ecx = 0x%08x\n", r.ecx);
+		pr_debug("edx = 0x%08x\n", r.edx);
+		caps->subleaf[i] = r;
+	}
+
+	return 0;
+}
+
+static bool is_hydrid(void)
+{
+	unsigned int eax, ebx, ecx, edx = 0;
+	bool result;
+
+	__get_cpuid_count(7, 0, &eax, &ebx, &ecx, &edx);
+	result = edx & BIT(15);
+	pr_debug("Is %shybrid : CPUID leaf 7 subleaf 0 edx %#x (bit-15 indicates hybrid)\n",
+		 result ? "" : "not ", edx);
+	return result;
+}
+
+static int compare_caps(int cpu, struct pt_caps *caps, struct pt_caps *caps0)
+{
+	struct pt_caps mask = { /* Mask of bits to check*/
+		.subleaf = {
+			[0] = {
+				.ebx = GENMASK(8, 0),
+				.ecx = GENMASK(3, 0),
+			},
+			[1] = {
+				.eax = GENMASK(31, 16),
+				.ebx = GENMASK(31, 0),
+			}
+		}
+	};
+	unsigned int m, reg, reg0;
+	int ret = 0;
+	int i, j;
+
+	for (i = 0; i < INTEL_PT_SUBLEAF_CNT; i++) {
+		for (j = 0; j < CPUID_REG_CNT; j++) {
+			m = mask.subleaf[i].reg[j];
+			reg = m & caps->subleaf[i].reg[j];
+			reg0 = m & caps0->subleaf[i].reg[j];
+			if ((reg & reg0) != reg0) {
+				pr_debug("CPU %d subleaf %d reg %d FAIL %#x vs %#x\n",
+					 cpu, i, j, reg, reg0);
+				ret = -1;
+			}
+		}
+	}
+
+	m = INTEL_PT_ADDR_FILT_CNT_MASK;
+	reg = m & caps->subleaf[1].eax;
+	reg0 = m & caps0->subleaf[1].eax;
+	if (reg < reg0) {
+		pr_debug("CPU %d subleaf 1 reg 0 FAIL address filter count %#x vs %#x\n",
+			 cpu, reg, reg0);
+		ret = -1;
+	}
+
+	if (!ret)
+		pr_debug("CPU %d OK\n", cpu);
+
+	return ret;
+}
+
+int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest)
+{
+	int max_cpu = cpu__max_cpu().cpu;
+	struct pt_caps last_caps;
+	struct pt_caps caps0;
+	int ret = TEST_OK;
+	int cpu;
+
+	if (!is_hydrid()) {
+		test->test_cases[subtest].skip_reason = "not hybrid";
+		return TEST_SKIP;
+	}
+
+	if (get_pt_caps(0, &caps0))
+		return TEST_FAIL;
+
+	for (cpu = 1, last_caps = caps0; cpu < max_cpu; cpu++) {
+		struct pt_caps caps;
+
+		if (get_pt_caps(cpu, &caps)) {
+			pr_debug("CPU %d not found\n", cpu);
+			continue;
+		}
+		if (!memcmp(&caps, &last_caps, sizeof(caps))) {
+			pr_debug("CPU %d same caps as previous CPU\n", cpu);
+			continue;
+		}
+		if (compare_caps(cpu, &caps, &caps0))
+			ret = TEST_FAIL;
+		last_caps = caps;
+	}
+
+	return ret;
+}
-- 
2.34.1

