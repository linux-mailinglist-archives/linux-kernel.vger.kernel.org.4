Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6334623085
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiKIQw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKIQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:52:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A02224F21
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668012739; x=1699548739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TuBz7tekTf1BWBxAT1QoET0tgEOR4TTS5pMFs+n0/Gc=;
  b=neux5ckaZSyKRfNrpmkqhXVxAt0qzML0WRwB/ACa4+f8Zyf6pdZ3WmbH
   a5Q9LZk1VIk1MxK3cZhcy6muRh8FsLgujGqSljaaLP/fIOwgVfUxd2iLv
   v3HZOuVSpED18rnLuhVLoR/jdggPwr9L5CqYtMTjs6VFMWOo8aKLs/Dog
   7Fx9mxipvvDVUIg2Q4IEodvIFDMbRbXAxV0rTTAC6zL5TuDXgjviWS4Pu
   cd5CMeOEwJMKopTr1rwVomtx3QfoSCXt7ot2ZT0VoOPdJaXsc9k8vXarQ
   GTwnnfXkUBryt2pt1TyvxX0uaodZXvkzjZYYAIxEGbpQV5A9huRrbi84h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="291419879"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="291419879"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:52:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="668053288"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="668053288"
Received: from dschramm-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.219.85])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:52:12 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DE8FE1094F5; Wed,  9 Nov 2022 19:52:00 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Weihong Zhang <weihong.zhang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv12 13/16] selftests/x86/lam: Add mmap and SYSCALL test cases for linear-address masking
Date:   Wed,  9 Nov 2022 19:51:37 +0300
Message-Id: <20221109165140.9137-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221109165140.9137-1-kirill.shutemov@linux.intel.com>
References: <20221109165140.9137-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weihong Zhang <weihong.zhang@intel.com>

Add mmap and SYSCALL test cases.

SYSCALL test cases:

 - LAM supports set metadata in high bits 62:57 (LAM_U57) of a user pointer, pass
   the pointer to SYSCALL, SYSCALL can dereference the pointer and return correct
   result.

 - Disable LAM, pass a pointer with metadata in high bits to SYSCALL,
   SYSCALL returns -1 (EFAULT).

MMAP test cases:

 - Enable LAM_U57, MMAP with low address (below bits 47), set metadata
   in high bits of the address, dereference the address should be
   allowed.

 - Enable LAM_U57, MMAP with high address (above bits 47), set metadata
   in high bits of the address, dereference the address should be
   allowed.

Signed-off-by: Weihong Zhang <weihong.zhang@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 tools/testing/selftests/x86/lam.c | 144 +++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 900a3a0fb709..cdc6e40e00e0 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -7,6 +7,7 @@
 #include <signal.h>
 #include <setjmp.h>
 #include <sys/mman.h>
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <inttypes.h>
 
@@ -29,11 +30,18 @@
 /* Specified test function bits */
 #define FUNC_MALLOC             0x1
 #define FUNC_BITS               0x2
+#define FUNC_MMAP               0x4
+#define FUNC_SYSCALL            0x8
 
-#define TEST_MASK               0x3
+#define TEST_MASK               0xf
+
+#define LOW_ADDR                (0x1UL << 30)
+#define HIGH_ADDR               (0x3UL << 48)
 
 #define MALLOC_LEN              32
 
+#define PAGE_SIZE               (4 << 10)
+
 struct testcases {
 	unsigned int later;
 	int expected; /* 2: SIGSEGV Error; 1: other errors */
@@ -49,6 +57,7 @@ jmp_buf segv_env;
 static void segv_handler(int sig)
 {
 	ksft_print_msg("Get segmentation fault(%d).", sig);
+
 	siglongjmp(segv_env, 1);
 }
 
@@ -61,6 +70,16 @@ static inline int cpu_has_lam(void)
 	return (cpuinfo[0] & (1 << 26));
 }
 
+/* Check 5-level page table feature in CPUID.(EAX=07H, ECX=00H):ECX.[bit 16] */
+static inline int cpu_has_la57(void)
+{
+	unsigned int cpuinfo[4];
+
+	__cpuid_count(0x7, 0, cpuinfo[0], cpuinfo[1], cpuinfo[2], cpuinfo[3]);
+
+	return (cpuinfo[2] & (1 << 16));
+}
+
 /*
  * Set tagged address and read back untag mask.
  * check if the untagged mask is expected.
@@ -213,6 +232,68 @@ static int handle_malloc(struct testcases *test)
 	return ret;
 }
 
+static int handle_mmap(struct testcases *test)
+{
+	void *ptr;
+	unsigned int flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED;
+	int ret = 0;
+
+	if (test->later == 0 && test->lam != 0)
+		if (set_lam(test->lam) != 0)
+			return 1;
+
+	ptr = mmap((void *)test->addr, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		   flags, -1, 0);
+	if (ptr == MAP_FAILED) {
+		if (test->addr == HIGH_ADDR)
+			if (!cpu_has_la57())
+				return 3; /* unsupport LA57 */
+		return 1;
+	}
+
+	if (test->later != 0 && test->lam != 0)
+		if (set_lam(test->lam) != 0)
+			ret = 1;
+
+	if (ret == 0) {
+		if (sigsetjmp(segv_env, 1) == 0) {
+			signal(SIGSEGV, segv_handler);
+			ret = handle_lam_test(ptr, test->lam);
+		} else {
+			ret = 2;
+		}
+	}
+
+	munmap(ptr, PAGE_SIZE);
+	return ret;
+}
+
+static int handle_syscall(struct testcases *test)
+{
+	struct utsname unme, *pu;
+	int ret = 0;
+
+	if (test->later == 0 && test->lam != 0)
+		if (set_lam(test->lam) != 0)
+			return 1;
+
+	if (sigsetjmp(segv_env, 1) == 0) {
+		signal(SIGSEGV, segv_handler);
+		pu = (struct utsname *)set_metadata((uint64_t)&unme, test->lam);
+		ret = uname(pu);
+		if (ret < 0)
+			ret = 1;
+	} else {
+		ret = 2;
+	}
+
+	if (test->later != 0 && test->lam != 0)
+		if (set_lam(test->lam) != -1 && ret == 0)
+			ret = 1;
+
+	return ret;
+}
+
 static int fork_test(struct testcases *test)
 {
 	int ret, child_ret;
@@ -241,13 +322,20 @@ static void run_test(struct testcases *test, int count)
 		struct testcases *t = test + i;
 
 		/* fork a process to run test case */
+		tests_cnt++;
 		ret = fork_test(t);
+
+		/* return 3 is not support LA57, the case should be skipped */
+		if (ret == 3) {
+			ksft_test_result_skip(t->msg);
+			continue;
+		}
+
 		if (ret != 0)
 			ret = (t->expected == ret);
 		else
 			ret = !(t->expected);
 
-		tests_cnt++;
 		ksft_test_result(ret, t->msg);
 	}
 }
@@ -268,7 +356,6 @@ static struct testcases malloc_cases[] = {
 	},
 };
 
-
 static struct testcases bits_cases[] = {
 	{
 		.test_func = handle_max_bits,
@@ -276,11 +363,54 @@ static struct testcases bits_cases[] = {
 	},
 };
 
+static struct testcases syscall_cases[] = {
+	{
+		.later = 0,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_syscall,
+		.msg = "SYSCALL: LAM_U57. syscall with metadata\n",
+	},
+	{
+		.later = 1,
+		.expected = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_syscall,
+		.msg = "SYSCALL:[Negative] Disable LAM. Dereferencing pointer with metadata.\n",
+	},
+};
+
+static struct testcases mmap_cases[] = {
+	{
+		.later = 1,
+		.expected = 0,
+		.lam = LAM_U57_BITS,
+		.addr = HIGH_ADDR,
+		.test_func = handle_mmap,
+		.msg = "MMAP: First mmap high address, then set LAM_U57.\n",
+	},
+	{
+		.later = 0,
+		.expected = 0,
+		.lam = LAM_U57_BITS,
+		.addr = HIGH_ADDR,
+		.test_func = handle_mmap,
+		.msg = "MMAP: First LAM_U57, then High address.\n",
+	},
+	{
+		.later = 0,
+		.expected = 0,
+		.lam = LAM_U57_BITS,
+		.addr = LOW_ADDR,
+		.test_func = handle_mmap,
+		.msg = "MMAP: First LAM_U57, then Low address.\n",
+	},
+};
+
 static void cmd_help(void)
 {
 	printf("usage: lam [-h] [-t test list]\n");
 	printf("\t-t test list: run tests specified in the test list, default:0x%x\n", TEST_MASK);
-	printf("\t\t0x1:malloc; 0x2:max_bits;\n");
+	printf("\t\t0x1:malloc; 0x2:max_bits; 0x4:mmap; 0x8:syscall.\n");
 	printf("\t-h: help\n");
 }
 
@@ -320,6 +450,12 @@ int main(int argc, char **argv)
 	if (tests & FUNC_BITS)
 		run_test(bits_cases, ARRAY_SIZE(bits_cases));
 
+	if (tests & FUNC_MMAP)
+		run_test(mmap_cases, ARRAY_SIZE(mmap_cases));
+
+	if (tests & FUNC_SYSCALL)
+		run_test(syscall_cases, ARRAY_SIZE(syscall_cases));
+
 	ksft_set_plan(tests_cnt);
 
 	return ksft_exit_pass();
-- 
2.38.0

