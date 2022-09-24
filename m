Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319685E8F5B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiIXSci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 14:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiIXScc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 14:32:32 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0CD3A49A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 11:32:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664044349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LPWNXNjTpdk69QTCVlET8VJ/JJ9a2GtSBbDdH4cFLZE=;
        b=ZQl61kJNoa+w+Vet0tQXVzqUsD2lRfDAedEpkaIIGtBI2g2ogIVUya9kjKDXW5cehD3bF/
        PzBShzZy3TapPP8At/wmFgW9Bg7oBI75iTnF0bdkl2Ln4TpMb+w7AmCZObLBxQ5g9WBesr
        x4D7l20BvoAUFljRQWB/xl4NMOJuHNY=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 1/3] kasan: switch kunit tests to console tracepoints
Date:   Sat, 24 Sep 2022 20:31:51 +0200
Message-Id: <653d43e9a6d9aad2ae148a941dab048cb8e765a8.1664044241.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Switch KUnit-compatible KASAN tests from using per-task KUnit resources
to console tracepoints.

This allows for two things:

1. Migrating tests that trigger a KASAN report in the context of a task
   other than current to KUnit framework.
   This is implemented in the patches that follow.

2. Parsing and matching the contents of KASAN reports.
   This is not yet implemented.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/Kconfig.kasan     |  2 +-
 mm/kasan/kasan_test.c | 85 +++++++++++++++++++++++++++++++------------
 mm/kasan/report.c     | 31 ----------------
 3 files changed, 63 insertions(+), 55 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index ca09b1cf8ee9..ba5b27962c34 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -181,7 +181,7 @@ config KASAN_VMALLOC
 
 config KASAN_KUNIT_TEST
 	tristate "KUnit-compatible tests of KASAN bug detection capabilities" if !KUNIT_ALL_TESTS
-	depends on KASAN && KUNIT
+	depends on KASAN && KUNIT && TRACEPOINTS
 	default KUNIT_ALL_TESTS
 	help
 	  A KUnit-based KASAN test suite. Triggers different kinds of
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index f25692def781..3a2886f85e69 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -5,8 +5,12 @@
  * Author: Andrey Ryabinin <a.ryabinin@samsung.com>
  */
 
+#define pr_fmt(fmt) "kasan_test: " fmt
+
+#include <kunit/test.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -14,21 +18,28 @@
 #include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/random.h>
+#include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/tracepoint.h>
 #include <linux/uaccess.h>
-#include <linux/io.h>
 #include <linux/vmalloc.h>
-#include <linux/set_memory.h>
+#include <trace/events/printk.h>
 
 #include <asm/page.h>
 
-#include <kunit/test.h>
-
 #include "kasan.h"
 
 #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_GRANULE_SIZE)
 
+static bool multishot;
+
+/* Fields set based on lines observed in the console. */
+static struct {
+	bool report_found;
+	bool async_fault;
+} test_status;
+
 /*
  * Some tests use these global variables to store return values from function
  * calls that could otherwise be eliminated by the compiler as dead code.
@@ -36,35 +47,61 @@
 void *kasan_ptr_result;
 int kasan_int_result;
 
-static struct kunit_resource resource;
-static struct kunit_kasan_status test_status;
-static bool multishot;
+/* Probe for console output: obtains test_status lines of interest. */
+static void probe_console(void *ignore, const char *buf, size_t len)
+{
+	if (strnstr(buf, "BUG: KASAN: ", len))
+		WRITE_ONCE(test_status.report_found, true);
+	else if (strnstr(buf, "Asynchronous fault: ", len))
+		WRITE_ONCE(test_status.async_fault, true);
+}
 
-/*
- * Temporarily enable multi-shot mode. Otherwise, KASAN would only report the
- * first detected bug and panic the kernel if panic_on_warn is enabled. For
- * hardware tag-based KASAN also allow tag checking to be reenabled for each
- * test, see the comment for KUNIT_EXPECT_KASAN_FAIL().
- */
-static int kasan_test_init(struct kunit *test)
+static void register_tracepoints(struct tracepoint *tp, void *ignore)
+{
+	check_trace_callback_type_console(probe_console);
+	if (!strcmp(tp->name, "console"))
+		WARN_ON(tracepoint_probe_register(tp, probe_console, NULL));
+}
+
+static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
+{
+	if (!strcmp(tp->name, "console"))
+		tracepoint_probe_unregister(tp, probe_console, NULL);
+}
+
+static int kasan_suite_init(struct kunit_suite *suite)
 {
 	if (!kasan_enabled()) {
-		kunit_err(test, "can't run KASAN tests with KASAN disabled");
+		pr_err("Can't run KASAN tests with KASAN disabled");
 		return -1;
 	}
 
+	/*
+	 * Temporarily enable multi-shot mode. Otherwise, KASAN would only
+	 * report the first detected bug and panic the kernel if panic_on_warn
+	 * is enabled.
+	 */
 	multishot = kasan_save_enable_multi_shot();
-	test_status.report_found = false;
-	test_status.sync_fault = false;
-	kunit_add_named_resource(test, NULL, NULL, &resource,
-					"kasan_status", &test_status);
+
+	/*
+	 * Because we want to be able to build the test as a module, we need to
+	 * iterate through all known tracepoints, since the static registration
+	 * won't work here.
+	 */
+	for_each_kernel_tracepoint(register_tracepoints, NULL);
 	return 0;
 }
 
-static void kasan_test_exit(struct kunit *test)
+static void kasan_suite_exit(struct kunit_suite *suite)
 {
 	kasan_restore_multi_shot(multishot);
-	KUNIT_EXPECT_FALSE(test, test_status.report_found);
+	for_each_kernel_tracepoint(unregister_tracepoints, NULL);
+	tracepoint_synchronize_unregister();
+}
+
+static void kasan_test_exit(struct kunit *test)
+{
+	KUNIT_EXPECT_FALSE(test, READ_ONCE(test_status.report_found));
 }
 
 /**
@@ -106,11 +143,12 @@ static void kasan_test_exit(struct kunit *test)
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&				\
 	    kasan_sync_fault_possible()) {				\
 		if (READ_ONCE(test_status.report_found) &&		\
-		    READ_ONCE(test_status.sync_fault))			\
+		    !READ_ONCE(test_status.async_fault))		\
 			kasan_enable_tagging();				\
 		migrate_enable();					\
 	}								\
 	WRITE_ONCE(test_status.report_found, false);			\
+	WRITE_ONCE(test_status.async_fault, false);			\
 } while (0)
 
 #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {			\
@@ -1440,9 +1478,10 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 
 static struct kunit_suite kasan_kunit_test_suite = {
 	.name = "kasan",
-	.init = kasan_test_init,
 	.test_cases = kasan_kunit_test_cases,
 	.exit = kasan_test_exit,
+	.suite_init = kasan_suite_init,
+	.suite_exit = kasan_suite_exit,
 };
 
 kunit_test_suite(kasan_kunit_test_suite);
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 39e8e5a80b82..f23d51a27414 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -30,8 +30,6 @@
 
 #include <asm/sections.h>
 
-#include <kunit/test.h>
-
 #include "kasan.h"
 #include "../slab.h"
 
@@ -114,41 +112,12 @@ EXPORT_SYMBOL_GPL(kasan_restore_multi_shot);
 
 #endif
 
-#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
-static void update_kunit_status(bool sync)
-{
-	struct kunit *test;
-	struct kunit_resource *resource;
-	struct kunit_kasan_status *status;
-
-	test = current->kunit_test;
-	if (!test)
-		return;
-
-	resource = kunit_find_named_resource(test, "kasan_status");
-	if (!resource) {
-		kunit_set_failure(test);
-		return;
-	}
-
-	status = (struct kunit_kasan_status *)resource->data;
-	WRITE_ONCE(status->report_found, true);
-	WRITE_ONCE(status->sync_fault, sync);
-
-	kunit_put_resource(resource);
-}
-#else
-static void update_kunit_status(bool sync) { }
-#endif
-
 static DEFINE_SPINLOCK(report_lock);
 
 static void start_report(unsigned long *flags, bool sync)
 {
 	/* Respect the /proc/sys/kernel/traceoff_on_warning interface. */
 	disable_trace_on_warning();
-	/* Update status of the currently running KASAN test. */
-	update_kunit_status(sync);
 	/* Do not allow LOCKDEP mangling KASAN reports. */
 	lockdep_off();
 	/* Make sure we don't end up in loop. */
-- 
2.25.1

