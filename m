Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A5663D8B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiK3PCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiK3PCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:02:09 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5424199F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:02:07 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669820525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4QL5FnfIoD+swykCGdX15GCfYgfftAp4hvZwQtuSkRs=;
        b=vWLSx9074mbnrBHTUmW9JamzwmhVUUZXKo+tyPA6DAe9GLD0DrQ3jZuomBJllV3aljp0zB
        8j7C69mLBkAhvaTZnqfpGkdpxDs6+pH7Fh+TjzC5HAQWn2me69tnBS/BSOYEaQfwnBl9TY
        S9YgKQ6SY7LW4+9DDPgjWvroCOOgnnc=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>, David Gow <davidgow@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 mm] kasan: fail non-kasan KUnit tests on KASAN reports
Date:   Wed, 30 Nov 2022 16:02:03 +0100
Message-Id: <7be29a8ea967cee6b7e48d3d5a242d1d0bd96851.1669820505.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

After the recent changes done to KUnit-enabled KASAN tests, non-KASAN KUnit
tests stopped being failed when KASAN report is detected.

Recover that property by failing the currently running non-KASAN KUnit test
when KASAN detects and prints a report for a bad memory access.

Note that if the bad accesses happened in a kernel thread that doesn't
have a reference to the currently running KUnit-test available via
current->kunit_test, the test won't be failed. This is a limitation of
KUnit, which doesn't yet provide a thread-agnostic way to find the
reference to the currenly running test.

Fixes: 49d9977ac909 ("kasan: check CONFIG_KASAN_KUNIT_TEST instead of CONFIG_KUNIT")
Fixes: 7f29493ba529 ("kasan: switch kunit tests to console tracepoints")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Fix build with KASAN built as a module.
- Rename fail_nonkasan_kunit_test to fail_non_kasan_kunit_test.
- Fix inverted condition in fail_non_kasan_kunit_test.
- Mark kasan_kunit_test_suite_executing and fail_non_kasan_kunit_test
  as inline when the corresponding configs are not enabled.
---
 mm/kasan/kasan.h      | 12 ++++++++++
 mm/kasan/kasan_test.c |  4 ++++
 mm/kasan/report.c     | 53 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index a84491bc4867..ea8cf1310b1e 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -541,6 +541,18 @@ static inline bool kasan_arch_is_ready(void)	{ return true; }
 #error kasan_arch_is_ready only works in KASAN generic outline mode!
 #endif
 
+#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
+
+void kasan_kunit_test_suite_start(void);
+void kasan_kunit_test_suite_end(void);
+
+#else /* CONFIG_KASAN_KUNIT_TEST */
+
+static inline void kasan_kunit_test_suite_start(void) { }
+static inline void kasan_kunit_test_suite_end(void) { }
+
+#endif /* CONFIG_KASAN_KUNIT_TEST */
+
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST) || IS_ENABLED(CONFIG_KASAN_MODULE_TEST)
 
 bool kasan_save_enable_multi_shot(void);
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index e27591ef2777..9aa892e7b76c 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -76,6 +76,9 @@ static int kasan_suite_init(struct kunit_suite *suite)
 		return -1;
 	}
 
+	/* Stop failing KUnit tests on KASAN reports. */
+	kasan_kunit_test_suite_start();
+
 	/*
 	 * Temporarily enable multi-shot mode. Otherwise, KASAN would only
 	 * report the first detected bug and panic the kernel if panic_on_warn
@@ -94,6 +97,7 @@ static int kasan_suite_init(struct kunit_suite *suite)
 
 static void kasan_suite_exit(struct kunit_suite *suite)
 {
+	kasan_kunit_test_suite_end();
 	kasan_restore_multi_shot(multishot);
 	for_each_kernel_tracepoint(unregister_tracepoints, NULL);
 	tracepoint_synchronize_unregister();
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 31355851a5ec..f2db8605ee0f 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -9,6 +9,7 @@
  *        Andrey Konovalov <andreyknvl@gmail.com>
  */
 
+#include <kunit/test.h>
 #include <linux/bitops.h>
 #include <linux/ftrace.h>
 #include <linux/init.h>
@@ -112,10 +113,62 @@ EXPORT_SYMBOL_GPL(kasan_restore_multi_shot);
 
 #endif
 
+#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
+
+/*
+ * Whether the KASAN KUnit test suite is currently being executed.
+ * Updated in kasan_test.c.
+ */
+bool kasan_kunit_executing;
+
+void kasan_kunit_test_suite_start(void)
+{
+	WRITE_ONCE(kasan_kunit_executing, true);
+}
+EXPORT_SYMBOL_GPL(kasan_kunit_test_suite_start);
+
+void kasan_kunit_test_suite_end(void)
+{
+	WRITE_ONCE(kasan_kunit_executing, false);
+}
+EXPORT_SYMBOL_GPL(kasan_kunit_test_suite_end);
+
+static bool kasan_kunit_test_suite_executing(void)
+{
+	return READ_ONCE(kasan_kunit_executing);
+}
+
+#else /* CONFIG_KASAN_KUNIT_TEST */
+
+static inline bool kasan_kunit_test_suite_executing(void) { return false; }
+
+#endif /* CONFIG_KASAN_KUNIT_TEST */
+
+#if IS_ENABLED(CONFIG_KUNIT)
+
+static void fail_non_kasan_kunit_test(void)
+{
+	struct kunit *test;
+
+	if (kasan_kunit_test_suite_executing())
+		return;
+
+	test = current->kunit_test;
+	if (test)
+		kunit_set_failure(test);
+}
+
+#else /* CONFIG_KUNIT */
+
+static inline void fail_non_kasan_kunit_test(void) { }
+
+#endif /* CONFIG_KUNIT */
+
 static DEFINE_SPINLOCK(report_lock);
 
 static void start_report(unsigned long *flags, bool sync)
 {
+	fail_non_kasan_kunit_test();
 	/* Respect the /proc/sys/kernel/traceoff_on_warning interface. */
 	disable_trace_on_warning();
 	/* Do not allow LOCKDEP mangling KASAN reports. */
-- 
2.25.1

