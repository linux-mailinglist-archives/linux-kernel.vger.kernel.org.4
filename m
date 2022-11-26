Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6B26397A1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 19:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKZSXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 13:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKZSXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 13:23:07 -0500
X-Greylist: delayed 466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Nov 2022 10:23:05 PST
Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D9D1A05D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:23:05 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669486515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JDvTtFdWl1YXSMfasI4Saz9+J3V+bsk5xm78bG3AgR8=;
        b=DCYD0KPcyxtjNJVYy6HnI9aIp9UN1NOZmB15RRNNisl/+JIlP8nH+T8va/C39F3R2CskX+
        JSvgWTHhm22MPGPI2B9fKoSlBT5WPofQE1mTwt+0rHXb5mJDPbFng957Bwzc/+u30VmA5O
        fTlC0571r0ej+/Nz6ILpPn6w+ZqN1T4=
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
Subject: [PATCH mm] kasan: fail non-kasan KUnit tests on KASAN reports
Date:   Sat, 26 Nov 2022 19:15:11 +0100
Message-Id: <655fd7e303b852809d3a8167d28091429f969c73.1669486407.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 mm/kasan/kasan.h      |  6 ++++++
 mm/kasan/kasan_test.c | 11 +++++++++++
 mm/kasan/report.c     | 22 ++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index a84491bc4867..08a83a7ef77f 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -548,6 +548,12 @@ void kasan_restore_multi_shot(bool enabled);
 
 #endif
 
+#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
+bool kasan_kunit_test_suite_executing(void);
+#else
+static bool kasan_kunit_test_suite_executing(void) { return false; }
+#endif
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declared here to avoid warnings about missing declarations.
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index e27591ef2777..c9a615e892ed 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -32,6 +32,9 @@
 
 #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_GRANULE_SIZE)
 
+/* Whether the KASAN KUnit test suite is currently being executed. */
+static bool executing;
+
 static bool multishot;
 
 /* Fields set based on lines observed in the console. */
@@ -47,6 +50,11 @@ static struct {
 void *kasan_ptr_result;
 int kasan_int_result;
 
+bool kasan_kunit_test_suite_executing(void)
+{
+	return READ_ONCE(executing);
+}
+
 /* Probe for console output: obtains test_status lines of interest. */
 static void probe_console(void *ignore, const char *buf, size_t len)
 {
@@ -76,6 +84,8 @@ static int kasan_suite_init(struct kunit_suite *suite)
 		return -1;
 	}
 
+	WRITE_ONCE(executing, true);
+
 	/*
 	 * Temporarily enable multi-shot mode. Otherwise, KASAN would only
 	 * report the first detected bug and panic the kernel if panic_on_warn
@@ -94,6 +104,7 @@ static int kasan_suite_init(struct kunit_suite *suite)
 
 static void kasan_suite_exit(struct kunit_suite *suite)
 {
+	WRITE_ONCE(executing, false);
 	kasan_restore_multi_shot(multishot);
 	for_each_kernel_tracepoint(unregister_tracepoints, NULL);
 	tracepoint_synchronize_unregister();
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 31355851a5ec..e718c997ecae 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -9,6 +9,7 @@
  *        Andrey Konovalov <andreyknvl@gmail.com>
  */
 
+#include <kunit/test.h>
 #include <linux/bitops.h>
 #include <linux/ftrace.h>
 #include <linux/init.h>
@@ -112,10 +113,31 @@ EXPORT_SYMBOL_GPL(kasan_restore_multi_shot);
 
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT)
+
+static void fail_nonkasan_kunit_test(void)
+{
+	struct kunit *test;
+
+	if (!kasan_kunit_test_suite_executing())
+		return;
+
+	test = current->kunit_test;
+	if (test)
+		kunit_set_failure(test);
+}
+
+#else /* CONFIG_KUNIT */
+
+static void fail_nonkasan_kunit_test(void) { }
+
+#endif /* CONFIG_KUNIT */
+
 static DEFINE_SPINLOCK(report_lock);
 
 static void start_report(unsigned long *flags, bool sync)
 {
+	fail_nonkasan_kunit_test();
 	/* Respect the /proc/sys/kernel/traceoff_on_warning interface. */
 	disable_trace_on_warning();
 	/* Do not allow LOCKDEP mangling KASAN reports. */
-- 
2.25.1

