Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D166A6E9B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCAOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjCAOjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:39:41 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7688CB479
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:39:40 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id cf11-20020a0564020b8b00b0049ec3a108beso19362796edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvEmc+TQ/70wBv4c0+3F8h651+3YM9ltVwHdaJENm+0=;
        b=TZbcESbsWwNX7ITUi/aZMlklXQLIxXSFS8qC4CBgfWLzgdWV4sw7TnmemklpH6W7Bc
         A7y93ECEz75USteW8FD3Y1XqRtJk5z3dpdOjwx44G2Jjuz+Z4hitvfk4TnGhEpzcwscE
         ecg0YS6TcupDfdmQ4FiWgzFt1XEr6a7zKBTWdlnNhV5j7eNaBRDBF61cN2PiP+iE5mTh
         91+plLrvqvm2QV627pn0K767iy62E8FL4Syt1zWC06tG2/CxQdIgC4GhP+p/aeN6q3xd
         8FPlln8dfQ68QkVsu4QnH0TBtMDPHUtGDPr6mhY3CY6Efu84yLWgr+mHbxwvH+VHgIa6
         MHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvEmc+TQ/70wBv4c0+3F8h651+3YM9ltVwHdaJENm+0=;
        b=lU8YQNB72+bQx63FO2imjXTNGIHfZSNxtcsI8Gu5KCiOabTvqBYpV1gzrrrLM6A3bT
         1qX/TcELFo6yyKdhIiiLN45UzfyGQuB6i3EJMcKxfBkrkXVGo9GZW/5VK+eRAWLWGWvb
         VQuhyxWXcMF1reAk/Y0Gic7XAjc1uDwL85XRbRfzzCtze8yEXxuO7i6GRODGWMqXOFfU
         HNMkfrO3UJIcfYdxDHE50yKLNXLcPurslZ/Hr0FSzl0ImQ4WzU6d2G5b8oLbW0hWSKYf
         MQ+GA0oUWSYUGiLMDo58zFbFJVs01HbP3cW3hBkY263vVpfbfmSU4XlhdRAc84Wftc9E
         DYJw==
X-Gm-Message-State: AO0yUKUb4EXzN4W1FE37Ae2GAv5+0UZkdt43cygsFgVLd3g37i/F7xg9
        gzdQHxFFspqiPtUNYbKVqb/UniwYm3Y=
X-Google-Smtp-Source: AK7set+/E1TqZIMkRHLQhUF/c0Crs4CPmSPBSgdNL2StGzl+To/OODmTIOi2hun6qk3SVyMlWubpsRLL6g8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:3c31:b0cf:1498:e916])
 (user=glider job=sendgmr) by 2002:a50:d6db:0:b0:4aa:a4df:23fc with SMTP id
 l27-20020a50d6db000000b004aaa4df23fcmr4014799edj.1.1677681579977; Wed, 01 Mar
 2023 06:39:39 -0800 (PST)
Date:   Wed,  1 Mar 2023 15:39:31 +0100
In-Reply-To: <20230301143933.2374658-1-glider@google.com>
Mime-Version: 1.0
References: <20230301143933.2374658-1-glider@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230301143933.2374658-2-glider@google.com>
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

5478afc55a21 ("kmsan: fix memcpy tests") uses OPTIMIZER_HIDE_VAR() to
hide the uninitialized var from the compiler optimizations.

However OPTIMIZER_HIDE_VAR(uninit) enforces an immediate check of
@uninit, so memcpy tests did not actually check the behavior of memcpy(),
because they always contained a KMSAN report.

Replace OPTIMIZER_HIDE_VAR() with a file-local asm macro that just
clobbers the memory, and add a test case for memcpy() that does not
expect an error report.

Also reflow kmsan_test.c with clang-format.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/kmsan_test.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 088e21a48dc4b..cc98a3f4e0899 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -407,6 +407,36 @@ static void test_printk(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+/*
+ * Prevent the compiler from optimizing @var away. Without this, Clang may
+ * notice that @var is uninitialized and drop memcpy() calls that use it.
+ *
+ * There is OPTIMIZER_HIDE_VAR() in linux/compier.h that we cannot use here,
+ * because it is implemented as inline assembly receiving @var as a parameter
+ * and will enforce a KMSAN check.
+ */
+#define DO_NOT_OPTIMIZE(var) asm("" ::: "memory")
+
+/*
+ * Test case: ensure that memcpy() correctly copies initialized values.
+ */
+static void test_init_memcpy(struct kunit *test)
+{
+	EXPECTATION_NO_REPORT(expect);
+	volatile int src;
+	volatile int dst = 0;
+
+	// Ensure DO_NOT_OPTIMIZE() does not cause extra checks.
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
@@ -420,7 +450,7 @@ static void test_memcpy_aligned_to_aligned(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to aligned dst (UMR report)\n");
-	OPTIMIZER_HIDE_VAR(uninit_src);
+	DO_NOT_OPTIMIZE(uninit_src);
 	memcpy((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
 	kmsan_check_memory((void *)&dst, sizeof(dst));
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
@@ -443,7 +473,7 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to unaligned dst (UMR report)\n");
-	OPTIMIZER_HIDE_VAR(uninit_src);
+	DO_NOT_OPTIMIZE(uninit_src);
 	memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
 	kmsan_check_memory((void *)dst, 4);
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
@@ -467,13 +497,14 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
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
@@ -482,8 +513,7 @@ static noinline void fibonacci(int *array, int size, int start) {
 
 static void test_long_origin_chain(struct kunit *test)
 {
-	EXPECTATION_UNINIT_VALUE_FN(expect,
-				    "test_long_origin_chain");
+	EXPECTATION_UNINIT_VALUE_FN(expect, "test_long_origin_chain");
 	/* (KMSAN_MAX_ORIGIN_DEPTH * 2) recursive calls to fibonacci(). */
 	volatile int accum[KMSAN_MAX_ORIGIN_DEPTH * 2 + 2];
 	int last = ARRAY_SIZE(accum) - 1;
@@ -515,6 +545,7 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_uaf),
 	KUNIT_CASE(test_percpu_propagate),
 	KUNIT_CASE(test_printk),
+	KUNIT_CASE(test_init_memcpy),
 	KUNIT_CASE(test_memcpy_aligned_to_aligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
-- 
2.39.2.722.g9855ee24e9-goog

