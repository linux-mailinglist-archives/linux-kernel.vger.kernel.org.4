Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FC86A9931
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjCCOO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjCCOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:14:46 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694AD17152
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:14:45 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id cf11-20020a0564020b8b00b0049ec3a108beso4159524edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677852884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NzrUAKqOf4lIqj2sXdyqoZ2Q8eXyDe5JYgJyXOtPsCY=;
        b=ZfSfmqBMuJ+vwMDxG5i4+5C+tNEglr4loWmKR6Z0RkZfjr+jAbJCKs+E8HdnY+/484
         U4Tnah/k4Gjd5sm2yqp/0nKmTL54cbtEXdkKAgXSe42PIyTbE0SRGadQQmam3JIAUfvC
         a5ouWadlWnMykwg3du4wr7YFd0UA4Nmn97zesSEosU4X3DChC2nSvSKQyOpTfHECBKv7
         gZXhfuN9a1gIdRxhqPU3dNXM0LfelTB/RT1xvfB+vRM3dNsvbeS0WfFdt8jqYekhXOzi
         337mBrnvoEXkOMuKAADUY1doomtGT8K8uQlYbbOdXMj9ai3/IQ/6zMJlcrmOBZHFmz/Z
         uWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677852884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzrUAKqOf4lIqj2sXdyqoZ2Q8eXyDe5JYgJyXOtPsCY=;
        b=BRe31E6W1tfSDDjtXdl1S6Bf/Un5oUtiqT/gSYCwC8Ldxv6lJ17MvfMwdmK6/sxoY8
         h8GHCanmiG4FJJNKK/k3WnT9rVruYDZJY80U2eE/l4W4EYiIx0E1vYQCtvm5ae6fYGMD
         AD8msGNgQOLFU/J1S4C7AEG0xWhA0yHcf3hIvZik5tXHKpWjM172lGF9Mucy5Efikgly
         U6QZR4rTxS2U7UpWz8XJTZQktDbGfvkJNWRCNPBTr0x5NONgxy1mND9gGkg5TrHpwPwR
         HIQh5OkHdRcr7/y3hYdKKdCikQnF8f83d4rX5iUsT590uIEXEQKAmDwXX6arcYV2tF/b
         6ghA==
X-Gm-Message-State: AO0yUKUy6ih5OraAX6o8+ohAfnroRzVrOfyYPUN9wWAbvU9YHACWlRrk
        fOItoNuWjNx64SFBlqtKys9YbWXd/08=
X-Google-Smtp-Source: AK7set/ri2KO3ck28J8157MsDMD6j/YADvayhd/o5Bx0+wq3TM1Izsb9bN9BvUkIU9PbDIbEffR6U3aO/6Q=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:f11e:2fac:5069:a04d])
 (user=glider job=sendgmr) by 2002:a17:906:d041:b0:8bf:e82a:2988 with SMTP id
 bo1-20020a170906d04100b008bfe82a2988mr938462ejb.4.1677852883928; Fri, 03 Mar
 2023 06:14:43 -0800 (PST)
Date:   Fri,  3 Mar 2023 15:14:31 +0100
In-Reply-To: <20230303141433.3422671-1-glider@google.com>
Mime-Version: 1.0
References: <20230303141433.3422671-1-glider@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230303141433.3422671-2-glider@google.com>
Subject: [PATCH 2/4] kmsan: another take at fixing memcpy tests
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        nathan@kernel.org, ndesaulniers@google.com,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 5478afc55a21 ("kmsan: fix memcpy tests") uses OPTIMIZER_HIDE_VAR()
to hide the uninitialized var from the compiler optimizations.

However OPTIMIZER_HIDE_VAR(uninit) enforces an immediate check of
@uninit, so memcpy tests did not actually check the behavior of memcpy(),
because they always contained a KMSAN report.

Replace OPTIMIZER_HIDE_VAR() with a file-local macro that just clobbers
the memory with a barrier(), and add a test case for memcpy() that does not
expect an error report.

Also reflow kmsan_test.c with clang-format.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 - replace inline assembly with a barrier(), update comments
---
 mm/kmsan/kmsan_test.c | 44 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 088e21a48dc4b..aeddfdd4f679f 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -407,6 +407,37 @@ static void test_printk(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+/*
+ * Prevent the compiler from optimizing @var away. Without this, Clang may
+ * notice that @var is uninitialized and drop memcpy() calls that use it.
+ *
+ * There is OPTIMIZER_HIDE_VAR() in linux/compier.h that we cannot use here,
+ * because it is implemented as inline assembly receiving @var as a parameter
+ * and will enforce a KMSAN check. Same is true for e.g. barrier_data(var).
+ */
+#define DO_NOT_OPTIMIZE(var) barrier()
+
+/*
+ * Test case: ensure that memcpy() correctly copies initialized values.
+ * Also serves as a regression test to ensure DO_NOT_OPTIMIZE() does not cause
+ * extra checks.
+ */
+static void test_init_memcpy(struct kunit *test)
+{
+	EXPECTATION_NO_REPORT(expect);
+	volatile int src;
+	volatile int dst = 0;
+
+	DO_NOT_OPTIMIZE(src);
+	src = 1;
+	kunit_info(
+		test,
+		"memcpy()ing aligned initialized src to aligned dst (no reports)\n");
+	memcpy((void *)&dst, (void *)&src, sizeof(src));
+	kmsan_check_memory((void *)&dst, sizeof(dst));
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
 /*
  * Test case: ensure that memcpy() correctly copies uninitialized values between
  * aligned `src` and `dst`.
@@ -420,7 +451,7 @@ static void test_memcpy_aligned_to_aligned(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to aligned dst (UMR report)\n");
-	OPTIMIZER_HIDE_VAR(uninit_src);
+	DO_NOT_OPTIMIZE(uninit_src);
 	memcpy((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
 	kmsan_check_memory((void *)&dst, sizeof(dst));
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
@@ -443,7 +474,7 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to unaligned dst (UMR report)\n");
-	OPTIMIZER_HIDE_VAR(uninit_src);
+	DO_NOT_OPTIMIZE(uninit_src);
 	memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
 	kmsan_check_memory((void *)dst, 4);
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
@@ -467,13 +498,14 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to unaligned dst - part 2 (UMR report)\n");
-	OPTIMIZER_HIDE_VAR(uninit_src);
+	DO_NOT_OPTIMIZE(uninit_src);
 	memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
 	kmsan_check_memory((void *)&dst[4], sizeof(uninit_src));
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
-static noinline void fibonacci(int *array, int size, int start) {
+static noinline void fibonacci(int *array, int size, int start)
+{
 	if (start < 2 || (start == size))
 		return;
 	array[start] = array[start - 1] + array[start - 2];
@@ -482,8 +514,7 @@ static noinline void fibonacci(int *array, int size, int start) {
 
 static void test_long_origin_chain(struct kunit *test)
 {
-	EXPECTATION_UNINIT_VALUE_FN(expect,
-				    "test_long_origin_chain");
+	EXPECTATION_UNINIT_VALUE_FN(expect, "test_long_origin_chain");
 	/* (KMSAN_MAX_ORIGIN_DEPTH * 2) recursive calls to fibonacci(). */
 	volatile int accum[KMSAN_MAX_ORIGIN_DEPTH * 2 + 2];
 	int last = ARRAY_SIZE(accum) - 1;
@@ -515,6 +546,7 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_uaf),
 	KUNIT_CASE(test_percpu_propagate),
 	KUNIT_CASE(test_printk),
+	KUNIT_CASE(test_init_memcpy),
 	KUNIT_CASE(test_memcpy_aligned_to_aligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

