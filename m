Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C6E615519
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiKAWeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiKAWd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:33:28 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B1B2DDF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:33:25 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 78so14646108pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgD6VkoidY1K6fgTV3eaPZ8+VeXqzeB8ij/KEzvrtPE=;
        b=Zw+jdonF3srm2oOPHvE/wciZkC1yJTpG3TlH5S3YyHIINs0uHGKyoAYf5vGGcyPEjk
         Yhw+0mU8iighIYZhu/NhquSMkNwGmNcRshoLuOHe0mxCTR+CYWlIgtW9rrBMmmmXlpk+
         C8NLcj1NWzw+ZnaBV55BWXOspaUdrT2J2AQG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgD6VkoidY1K6fgTV3eaPZ8+VeXqzeB8ij/KEzvrtPE=;
        b=i/4Lxwj4LxLeP3WUK0bpcz+WWVNtecIpTFUAkmJuKtUVAbcFaNTIiPkPqgUqNoTXo7
         hputs6jeTwcYuh3V2MjvqaqPkJ1MSX5irltFeSJWRbOQB3Quen1cVqBaOvXq0GmU42xp
         UfkGJBy4V4vqzC8zuMxZM8I+grrafjyUbHD23IWBTM8h3AbEzhJiUSRvgAWwky2sGmZM
         lDyWUZSsYxQCQqI4LHbuo/N24/R2gUZZ/PrqdSsCZQD7gVJktaBNY90JK2cNU+3uf8tB
         Dg5mamth2x3/XF1zi9BD5EthNuAlb9txiMLzel6jxFDmdqZyJ5oyL5fqB1ZtLNdOqv+d
         0DGw==
X-Gm-Message-State: ACrzQf2ZGl9wrzr6wbZ2Iw35+d8pmJHi1mqAa6fM88pqscp8IrW8NTcZ
        a/fkiTQBApn5DvXV+LhHW4jmIw==
X-Google-Smtp-Source: AMsMyM7pxv2Lvo5vKR9F8rfeCTRMS0FxQ0HTHdi2PJZNgWTfKuMPs74vyBlEnyTTOhIdTXzsE6uwaA==
X-Received: by 2002:a63:dc4a:0:b0:470:5e7:6bba with SMTP id f10-20020a63dc4a000000b0047005e76bbamr1285044pgj.143.1667342004961;
        Tue, 01 Nov 2022 15:33:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b001708c4ebbaesm6735258plk.309.2022.11.01.15.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:33:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>,
        linux-hardening@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev
Subject: [PATCH 6/6] kunit/fortify: Validate __alloc_size attribute results
Date:   Tue,  1 Nov 2022 15:33:14 -0700
Message-Id: <20221101223321.1326815-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101222520.never.109-kees@kernel.org>
References: <20221101222520.never.109-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13607; h=from:subject; bh=wSAVvLhC49WrEsey+rzI3Mf2kVppLeoS2Xvz7/CIGX8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjYZ6qOpdEK8ymLzEQRofKPXlon+ENY5S/tTJEZj6i spotAHaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2GeqgAKCRCJcvTf3G3AJmAFD/ 90tYxqc7iT6OunNqTOrQkbn9mc7bapmfR+YkkyhSnAZKeDuHwRfN4p2kwOVaCGcHxgJwS9QQc9wsyJ MyEFyMTdlVu81h3ztDGPI/9oI7qLp0lVbh6hg573DsWPmYrVu0HvzMQA0mp3xtUtrWR5BdcCWkAgsr 8HhVuNTwFSTjLM8DGRnQtIq0FZ6EZ7/6gmcrfVAQ5HsSsYHxVZMp5t+6A5Op4Vf4EqOqSe0TGIAgSw s50gIlJL4hzs0PgV++sohnEJZuskR9o+Y7Rs7qjBsdY4l8BG2N4WB8CSwEtLSWSouiyXbt6aXW/49r 1gAVCV0/uf/LsQ3sMtXkYVEQb+zhut27bgLVDyppx/NJBPUBZLUMbi5vQFTedUG6cVAu/n5RIurbCz 9tVvHM1Q2SEqILXvxOTHjR4bjOIihBxNIV/hfitfkOn5+zMLAid9WcWqkZve2lxVeN+7zL5Wa5HICx J5U9cOj/rwWX1SabXm4vjCRGNjwL+qmd4TIDEDFunxhJU9lmqyA6eDMLFs7u+zz2Pw6T60dy9a3S90 7xUr0yQeXkNdEu2OKNWWbCK74B+jGqtFR9HIRbIFxPI4j8mFBiPUtM6hxahuJNWL/m4XOno+Y4/KKf +N4+iSiPB57uHYauGeWNsoToUSZlEtHpOVent5FYkbsQMY166Avk8ph3mWAA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validate the effect of the __alloc_size attribute on allocators. If the
compiler doesn't support __builtin_dynamic_object_size(), skip the
associated tests.

(For GCC, just remove the "--make_options" line below...)

$ ./tools/testing/kunit/kunit.py run --arch x86_64 \
        --kconfig_add CONFIG_FORTIFY_SOURCE=y \
	--make_options LLVM=1
        fortify
...
[15:16:30] ================== fortify (10 subtests) ===================
[15:16:30] [PASSED] known_sizes_test
[15:16:30] [PASSED] control_flow_split_test
[15:16:30] [PASSED] alloc_size_kmalloc_const_test
[15:16:30] [PASSED] alloc_size_kmalloc_dynamic_test
[15:16:30] [PASSED] alloc_size_vmalloc_const_test
[15:16:30] [PASSED] alloc_size_vmalloc_dynamic_test
[15:16:30] [PASSED] alloc_size_kvmalloc_const_test
[15:16:30] [PASSED] alloc_size_kvmalloc_dynamic_test
[15:16:30] [PASSED] alloc_size_devm_kmalloc_const_test
[15:16:30] [PASSED] alloc_size_devm_kmalloc_dynamic_test
[15:16:30] ===================== [PASSED] fortify =====================
[15:16:30] ============================================================
[15:16:30] Testing complete. Ran 10 tests: passed: 10
[15:16:31] Elapsed time: 8.348s total, 0.002s configuring, 6.923s building, 1.075s running

For earlier GCC prior to version 12, the dynamic tests will be skipped:

[15:18:59] ================== fortify (10 subtests) ===================
[15:18:59] [PASSED] known_sizes_test
[15:18:59] [PASSED] control_flow_split_test
[15:18:59] [PASSED] alloc_size_kmalloc_const_test
[15:18:59] [SKIPPED] alloc_size_kmalloc_dynamic_test
[15:18:59] [PASSED] alloc_size_vmalloc_const_test
[15:18:59] [SKIPPED] alloc_size_vmalloc_dynamic_test
[15:18:59] [PASSED] alloc_size_kvmalloc_const_test
[15:18:59] [SKIPPED] alloc_size_kvmalloc_dynamic_test
[15:18:59] [PASSED] alloc_size_devm_kmalloc_const_test
[15:18:59] [SKIPPED] alloc_size_devm_kmalloc_dynamic_test
[15:18:59] ===================== [PASSED] fortify =====================
[15:18:59] ============================================================
[15:18:59] Testing complete. Ran 10 tests: passed: 6, skipped: 4
[15:18:59] Elapsed time: 11.965s total, 0.002s configuring, 10.540s building, 1.068s running

Cc: David Gow <davidgow@google.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Makefile        |   1 +
 lib/fortify_kunit.c | 255 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 256 insertions(+)

diff --git a/lib/Makefile b/lib/Makefile
index 77c7951c8cf0..d197079ef22a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -377,6 +377,7 @@ obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
 obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
 CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
 obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
+CFLAGS_fortify_kunit.o += $(call cc-disable-warning, unsequenced)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 409af07f340a..78acfdbda835 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -16,7 +16,10 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <kunit/test.h>
+#include <linux/device.h>
+#include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/vmalloc.h>
 
 static const char array_of_10[] = "this is 10";
 static const char *ptr_of_11 = "this is 11!";
@@ -60,9 +63,261 @@ static void control_flow_split_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, want_minus_one(pick), SIZE_MAX);
 }
 
+#define KUNIT_EXPECT_BOS(test, p, expected, name)			\
+	KUNIT_EXPECT_EQ_MSG(test, __builtin_object_size(p, 1),		\
+		expected,						\
+		"__alloc_size() not working with __bos on " name "\n")
+
+#if !__has_builtin(__builtin_dynamic_object_size)
+#define KUNIT_EXPECT_BDOS(test, p, expected, name)			\
+	/* Silence "unused variable 'expected'" warning. */		\
+	KUNIT_EXPECT_EQ(test, expected, expected)
+#else
+#define KUNIT_EXPECT_BDOS(test, p, expected, name)			\
+	KUNIT_EXPECT_EQ_MSG(test, __builtin_dynamic_object_size(p, 1),	\
+		expected,						\
+		"__alloc_size() not working with __bdos on " name "\n")
+#endif
+
+/* If the execpted size is a constant value, __bos can see it. */
+#define check_const(_expected, alloc, free)		do {		\
+	size_t expected = (_expected);					\
+	void *p = alloc;						\
+	KUNIT_EXPECT_TRUE_MSG(test, p != NULL, #alloc " failed?!\n");	\
+	KUNIT_EXPECT_BOS(test, p, expected, #alloc);			\
+	KUNIT_EXPECT_BDOS(test, p, expected, #alloc);			\
+	free;								\
+} while (0)
+
+/* If the execpted size is NOT a constant value, __bos CANNOT see it. */
+#define check_dynamic(_expected, alloc, free)		do {		\
+	size_t expected = (_expected);					\
+	void *p = alloc;						\
+	KUNIT_EXPECT_TRUE_MSG(test, p != NULL, #alloc " failed?!\n");	\
+	KUNIT_EXPECT_BOS(test, p, SIZE_MAX, #alloc);			\
+	KUNIT_EXPECT_BDOS(test, p, expected, #alloc);			\
+	free;								\
+} while (0)
+
+/* Assortment of constant-value kinda-edge cases. */
+#define CONST_TEST_BODY(TEST_alloc)	do {				\
+	/* Special-case vmalloc()-family to skip 0-sized allocs. */	\
+	if (strcmp(#TEST_alloc, "TEST_vmalloc") != 0)			\
+		TEST_alloc(check_const, 0, 0);				\
+	TEST_alloc(check_const, 1, 1);					\
+	TEST_alloc(check_const, 128, 128);				\
+	TEST_alloc(check_const, 1023, 1023);				\
+	TEST_alloc(check_const, 1025, 1025);				\
+	TEST_alloc(check_const, 4096, 4096);				\
+	TEST_alloc(check_const, 4097, 4097);				\
+} while (0)
+
+static volatile size_t zero_size;
+static volatile size_t unknown_size = 50;
+
+#if !__has_builtin(__builtin_dynamic_object_size)
+#define DYNAMIC_TEST_BODY(TEST_alloc)					\
+	kunit_skip(test, "Compiler is missing __builtin_dynamic_object_size() support\n")
+#else
+#define DYNAMIC_TEST_BODY(TEST_alloc)	do {				\
+	size_t size = unknown_size;					\
+									\
+	/*								\
+	 * Expected size is "size" in each test, before it is then	\
+	 * internally incremented in each test.	Requires we disable	\
+	 * -Wunsequenced.						\
+	 */								\
+	TEST_alloc(check_dynamic, size, size++);			\
+	/* Make sure incrementing actually happened. */			\
+	KUNIT_EXPECT_NE(test, size, unknown_size);			\
+} while (0)
+#endif
+
+#define DEFINE_ALLOC_SIZE_TEST_PAIR(allocator)				\
+static void alloc_size_##allocator##_const_test(struct kunit *test)	\
+{									\
+	CONST_TEST_BODY(TEST_##allocator);				\
+}									\
+static void alloc_size_##allocator##_dynamic_test(struct kunit *test)	\
+{									\
+	DYNAMIC_TEST_BODY(TEST_##allocator);				\
+}
+
+#define TEST_kmalloc(checker, expected_size, alloc_size)	do {	\
+	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;				\
+	void *orig;							\
+	size_t len;							\
+									\
+	checker(expected_size, kmalloc(alloc_size, gfp),		\
+		kfree(p));						\
+	checker(expected_size,						\
+		kmalloc_node(alloc_size, gfp, NUMA_NO_NODE),		\
+		kfree(p));						\
+	checker(expected_size, kzalloc(alloc_size, gfp),		\
+		kfree(p));						\
+	checker(expected_size,						\
+		kzalloc_node(alloc_size, gfp, NUMA_NO_NODE),		\
+		kfree(p));						\
+	checker(expected_size, kcalloc(1, alloc_size, gfp),		\
+		kfree(p));						\
+	checker(expected_size, kcalloc(alloc_size, 1, gfp),		\
+		kfree(p));						\
+	checker(expected_size,						\
+		kcalloc_node(1, alloc_size, gfp, NUMA_NO_NODE),		\
+		kfree(p));						\
+	checker(expected_size,						\
+		kcalloc_node(alloc_size, 1, gfp, NUMA_NO_NODE),		\
+		kfree(p));						\
+	checker(expected_size, kmalloc_array(1, alloc_size, gfp),	\
+		kfree(p));						\
+	checker(expected_size, kmalloc_array(alloc_size, 1, gfp),	\
+		kfree(p));						\
+	checker(expected_size,						\
+		kmalloc_array_node(1, alloc_size, gfp, NUMA_NO_NODE),	\
+		kfree(p));						\
+	checker(expected_size,						\
+		kmalloc_array_node(alloc_size, 1, gfp, NUMA_NO_NODE),	\
+		kfree(p));						\
+	checker(expected_size, __kmalloc(alloc_size, gfp),		\
+		kfree(p));						\
+	checker(expected_size,						\
+		__kmalloc_node(alloc_size, gfp, NUMA_NO_NODE),		\
+		kfree(p));						\
+									\
+	orig = kmalloc(alloc_size, gfp);				\
+	KUNIT_EXPECT_TRUE(test, orig != NULL);				\
+	checker((expected_size) * 2,					\
+		krealloc(orig, (alloc_size) * 2, gfp),			\
+		kfree(p));						\
+	orig = kmalloc(alloc_size, gfp);				\
+	KUNIT_EXPECT_TRUE(test, orig != NULL);				\
+	checker((expected_size) * 2,					\
+		krealloc_array(orig, 1, (alloc_size) * 2, gfp),		\
+		kfree(p));						\
+	orig = kmalloc(alloc_size, gfp);				\
+	KUNIT_EXPECT_TRUE(test, orig != NULL);				\
+	checker((expected_size) * 2,					\
+		krealloc_array(orig, (alloc_size) * 2, 1, gfp),		\
+		kfree(p));						\
+									\
+	len = 11;							\
+	/* Using memdup() with fixed size, so force unknown length. */	\
+	if (!__builtin_constant_p(expected_size))			\
+		len += zero_size;					\
+	checker(len, kmemdup("hello there", len, gfp), kfree(p));	\
+} while (0)
+DEFINE_ALLOC_SIZE_TEST_PAIR(kmalloc)
+
+/* Sizes are in pages, not bytes. */
+#define TEST_vmalloc(checker, expected_pages, alloc_pages)	do {	\
+	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;				\
+	checker((expected_pages) * PAGE_SIZE,				\
+		vmalloc((alloc_pages) * PAGE_SIZE),	   vfree(p));	\
+	checker((expected_pages) * PAGE_SIZE,				\
+		vzalloc((alloc_pages) * PAGE_SIZE),	   vfree(p));	\
+	checker((expected_pages) * PAGE_SIZE,				\
+		__vmalloc((alloc_pages) * PAGE_SIZE, gfp), vfree(p));	\
+} while (0)
+DEFINE_ALLOC_SIZE_TEST_PAIR(vmalloc)
+
+/* Sizes are in pages (and open-coded for side-effects), not bytes. */
+#define TEST_kvmalloc(checker, expected_pages, alloc_pages)	do {	\
+	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;				\
+	size_t prev_size;						\
+	void *orig;							\
+									\
+	checker((expected_pages) * PAGE_SIZE,				\
+		kvmalloc((alloc_pages) * PAGE_SIZE, gfp),		\
+		vfree(p));						\
+	checker((expected_pages) * PAGE_SIZE,				\
+		kvmalloc_node((alloc_pages) * PAGE_SIZE, gfp, NUMA_NO_NODE), \
+		vfree(p));						\
+	checker((expected_pages) * PAGE_SIZE,				\
+		kvzalloc((alloc_pages) * PAGE_SIZE, gfp),		\
+		vfree(p));						\
+	checker((expected_pages) * PAGE_SIZE,				\
+		kvzalloc_node((alloc_pages) * PAGE_SIZE, gfp, NUMA_NO_NODE), \
+		vfree(p));						\
+	checker((expected_pages) * PAGE_SIZE,				\
+		kvcalloc(1, (alloc_pages) * PAGE_SIZE, gfp),		\
+		vfree(p));						\
+	checker((expected_pages) * PAGE_SIZE,				\
+		kvcalloc((alloc_pages) * PAGE_SIZE, 1, gfp),		\
+		vfree(p));						\
+	checker((expected_pages) * PAGE_SIZE,				\
+		kvmalloc_array(1, (alloc_pages) * PAGE_SIZE, gfp),	\
+		vfree(p));						\
+	checker((expected_pages) * PAGE_SIZE,				\
+		kvmalloc_array((alloc_pages) * PAGE_SIZE, 1, gfp),	\
+		vfree(p));						\
+									\
+	prev_size = (expected_pages) * PAGE_SIZE;			\
+	orig = kvmalloc(prev_size, gfp);				\
+	KUNIT_EXPECT_TRUE(test, orig != NULL);				\
+	checker(((expected_pages) * PAGE_SIZE) * 2,			\
+		kvrealloc(orig, prev_size,				\
+			  ((alloc_pages) * PAGE_SIZE) * 2, gfp),	\
+		kvfree(p));						\
+} while (0)
+DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
+
+#define TEST_devm_kmalloc(checker, expected_size, alloc_size)	do {	\
+	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;				\
+	const char const dev_name[] = "fortify-test";			\
+	struct device *dev;						\
+	void *orig;							\
+	size_t len;							\
+									\
+	/* Create dummy device for devm_kmalloc()-family tests. */	\
+	dev = root_device_register(dev_name);				\
+	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),			\
+			       "Cannot register test device\n");	\
+									\
+	checker(expected_size, devm_kmalloc(dev, alloc_size, gfp),	\
+		devm_kfree(dev, p));					\
+	checker(expected_size, devm_kzalloc(dev, alloc_size, gfp),	\
+		devm_kfree(dev, p));					\
+	checker(expected_size,						\
+		devm_kmalloc_array(dev, 1, alloc_size, gfp),		\
+		devm_kfree(dev, p));					\
+	checker(expected_size,						\
+		devm_kmalloc_array(dev, alloc_size, 1, gfp),		\
+		devm_kfree(dev, p));					\
+	checker(expected_size,						\
+		devm_kcalloc(dev, 1, alloc_size, gfp),			\
+		devm_kfree(dev, p));					\
+	checker(expected_size,						\
+		devm_kcalloc(dev, alloc_size, 1, gfp),			\
+		devm_kfree(dev, p));					\
+									\
+	orig = devm_kmalloc(dev, alloc_size, gfp);			\
+	KUNIT_EXPECT_TRUE(test, orig != NULL);				\
+	checker((expected_size) * 2,					\
+		devm_krealloc(dev, orig, (alloc_size) * 2, gfp),	\
+		devm_kfree(dev, p));					\
+									\
+	len = 4;							\
+	/* Using memdup() with fixed size, so force unknown length. */	\
+	if (!__builtin_constant_p(expected_size))			\
+		len += zero_size;					\
+	checker(len, devm_kmemdup(dev, "Ohai", len, gfp),		\
+		devm_kfree(dev, p));					\
+									\
+	device_unregister(dev);						\
+} while (0)
+DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
+
 static struct kunit_case fortify_test_cases[] = {
 	KUNIT_CASE(known_sizes_test),
 	KUNIT_CASE(control_flow_split_test),
+	KUNIT_CASE(alloc_size_kmalloc_const_test),
+	KUNIT_CASE(alloc_size_kmalloc_dynamic_test),
+	KUNIT_CASE(alloc_size_vmalloc_const_test),
+	KUNIT_CASE(alloc_size_vmalloc_dynamic_test),
+	KUNIT_CASE(alloc_size_kvmalloc_const_test),
+	KUNIT_CASE(alloc_size_kvmalloc_dynamic_test),
+	KUNIT_CASE(alloc_size_devm_kmalloc_const_test),
+	KUNIT_CASE(alloc_size_devm_kmalloc_dynamic_test),
 	{}
 };
 
-- 
2.34.1

