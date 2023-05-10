Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AB96FDEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbjEJNdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbjEJNdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:33:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9337A6593;
        Wed, 10 May 2023 06:33:42 -0700 (PDT)
Date:   Wed, 10 May 2023 13:33:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683725621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BAxoZCeSd5zG1NNfEIA4xb3uYzvJHnExt1jxq4Xhiu4=;
        b=NQHpe4hMNaOIXnbSYiH7zmUiAa+tyAR286Fsv7TOuiu7cDJ0WQ7PLO0fFTkON7j2V1wxJq
        ukDvftpGMxgdI0ju3FDFfSAAgNizaHNEiog+ycFMIa/irsGC68VxM9UAMzDg2IYbLvgkA6
        wg0QXeHW4cCCV3OkMoV2q38PIa1g9iucoMC40luOylbbIT4Cr3KO5+Im3lzl+uRvBxRys1
        qFzBXVdtpkXG9L/oXK8zxcCloye8lOugLXPU0FB0LSIFuOrsD2814hfNwXJWuu87rRqfOj
        WSEp/Gd3UyKp5JuPWSGGQT3pJc9Ma6CIuauPaNxrhMZK9P8ij0GdoVHRnnmwfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683725621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BAxoZCeSd5zG1NNfEIA4xb3uYzvJHnExt1jxq4Xhiu4=;
        b=O4wto+1ZiEqwdT7/L6PSlwB0mnq6+HK7kDQ5AI3QBaJ0ZNSWHJXpEfptyCjZxmduEq0yxl
        +2XMyDy8j0390YDw==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf test: Add selftest to test IBS invocation via
 core pmu events
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230504110003.2548-5-ravi.bangoria@amd.com>
References: <20230504110003.2548-5-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <168372562075.404.10852387134590654382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     78075d947534013b4575687d19ebcbbb6d3addcd
Gitweb:        https://git.kernel.org/tip/78075d947534013b4575687d19ebcbbb6d3addcd
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Thu, 04 May 2023 16:30:03 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:31 +02:00

perf test: Add selftest to test IBS invocation via core pmu events

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230504110003.2548-5-ravi.bangoria@amd.com
---
 tools/perf/arch/x86/include/arch-tests.h         |  1 +-
 tools/perf/arch/x86/tests/Build                  |  1 +-
 tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c | 71 +++++++++++++++-
 tools/perf/arch/x86/tests/arch-tests.c           |  2 +-
 4 files changed, 75 insertions(+)
 create mode 100644 tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index 902e9ea..93d3b88 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -11,6 +11,7 @@ int test__intel_pt_pkt_decoder(struct test_suite *test, int subtest);
 int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
 int test__bp_modify(struct test_suite *test, int subtest);
 int test__x86_sample_parsing(struct test_suite *test, int subtest);
+int test__amd_ibs_via_core_pmu(struct test_suite *test, int subtest);
 
 extern struct test_suite *arch_tests[];
 
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 6f4e863..fd02d81 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -5,3 +5,4 @@ perf-y += arch-tests.o
 perf-y += sample-parsing.o
 perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-test.o
 perf-$(CONFIG_X86_64) += bp-modify.o
+perf-y += amd-ibs-via-core-pmu.o
diff --git a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
new file mode 100644
index 0000000..2902798
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
index aae6ea0..b5c85ab 100644
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
