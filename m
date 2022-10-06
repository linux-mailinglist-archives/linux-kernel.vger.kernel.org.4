Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33835F717B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiJFXAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiJFXAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:00:25 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9FAA1B1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:00:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h13so1953891pfr.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Pn8fcUlKY0mYD9k9yXJJA4/wPvgxmMVXtOKhuvaDv08=;
        b=X0/oSN+NgcBE9LzK/xFfsNZg9g1Rx0vWlrIcwfj2oCW5GUiDTWoqGSDNB/5dHNuJj1
         sFoZCnvc87wzVXiYR+syjJ+tLMFeBXfNVZNfxye1tOeElsXM/o1mcdWFhVfSd9e1UOYS
         41VjDTqiMRon+kJj1sV7DZI3cGWS6Mi/o7/xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Pn8fcUlKY0mYD9k9yXJJA4/wPvgxmMVXtOKhuvaDv08=;
        b=uh8s0zT91ne+IVp++vRVkswyTfMiC4l6Og915cVW5Lj7QNpZGii0dSxwp0GnIbcvgX
         UMEe65nRKq43ajt6EXNvk3bRYftCFKlx/ZAcBu4tECQ8JonOazFrT0iDoHnDZfwcFYTg
         7UltL77eb7Q1c0KYosPAN7p3k7htUMub2lb4oE5J3B88s3F7k8u5wxyvQUVkSnwVtl/2
         Bve9YfZ0KH0TkhTT9n85Oxd1xMR0LXF7hI0aOs+LdrJk51j+jFYw4ddbvwcFOmPEHvKB
         ScAjSTsStNoDeqNidHQU0RIyqXJsLob7wtuyoXwiAWFR2vl5mYXOllwppo0uPK1rjfhX
         J9fQ==
X-Gm-Message-State: ACrzQf2un3WZByJZ2U2m/lylOyCRUsAz+E3eOlTGm5E7UFE2nPzdsZTg
        TEv4+FconkDApRs0vfAVx01sWA==
X-Google-Smtp-Source: AMsMyM4Ckf5cj04XnOcnSqGJpTFhoYdbvGQpwjY9d/nzsMIDyoUMaVibbqp4SWiQ+1Jwh1O0zAxZsQ==
X-Received: by 2002:a05:6a00:f0f:b0:562:3169:eba1 with SMTP id cr15-20020a056a000f0f00b005623169eba1mr1975042pfb.59.1665097223233;
        Thu, 06 Oct 2022 16:00:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q27-20020aa7983b000000b005625d5ae760sm172534pfl.11.2022.10.06.16.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:00:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        llvm@lists.linux.dev, Vitor Massaru Iha <vitor@massaru.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] overflow: Refactor test skips for Clang-specific issues
Date:   Thu,  6 Oct 2022 16:00:17 -0700
Message-Id: <20221006230017.1833458-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6247; h=from:subject; bh=j/3CMmy55Kdm3/X782SP6kTirnk/8cojn34Zi1xcMKs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjP14AcEaP52jAhjBzmN95Tg9NNgDVNYSdf19Loaxq qnzI5jaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYz9eAAAKCRCJcvTf3G3AJh3fD/ 4n4TxICbE9hSAohxcs9hLF/IkcxjBIPcVy8GnJ/FTJlYL6h9p7F0Lq/3IIVqXU02BptNhqcfoMIHKv +ehFrpslUvXHPYIO+VbD3GlJYQPvNLMcGOUN9tre6WVHQ1rcYCEd9D0KhESlIldEUMYybT4yrno/Fh 5fqnEKJR5qWjd9paYp/VREtLFlx4d7knNFaLgYLEeF0uERNkIdVLUXJPl3nCmcoiZrBj3KLsccVdhv H+IuVqIYEsoEvtJNlMpXin1K91h5QjWt3a75DmD6u/vKBxTbn+NOu4rbPFq2ogwCXrpjl/GBYZFi/+ InTdXGeresTM7+EWW919kwaX3OT1mpiwWJcAk+tO48NOPUClBMEymH3yNKd448vsLF9Dv5NRvY4I46 lAJHF9laNPhSqbQQNEAKnU0SnAXL0C+3FWdWZlHmI8X52tMynWTq1Yk3bJ77Aqhor5CGtPhab1qtiO Wjovi21uSQAEz+7Gu2agZin46hANSs7/O8SMh1lM3HBnf7ScMdQC5Qe8jdbZTbinPZuFdDN+Msizle 0vO8eFdUGhgdj4iXyNLAb2F7a/rjxuOoYoFvCcKRN4ezyM0LtC1DYiwFJgKlyxhgMXTvQ2Eyum7XtL N4yO0gLjT0aW3jNRKbXl6GrXsL1WKYXTO5K0tmGyMbOBxUdc48m+dA7Ef5jQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert test exclusion into test skipping. This brings the logic for
why a test is being skipped into the test itself, instead of having to
spread ifdefs around the code. This will make cleanup easier as minimum
tests get raised. Drop __maybe_unused so missed tests will be noticed
again and clean up whitespace.

For example, clang-11 on i386:

[15:52:32] ================== overflow (18 subtests) ==================
[15:52:32] [PASSED] u8_u8__u8_overflow_test
[15:52:32] [PASSED] s8_s8__s8_overflow_test
[15:52:32] [PASSED] u16_u16__u16_overflow_test
[15:52:32] [PASSED] s16_s16__s16_overflow_test
[15:52:32] [PASSED] u32_u32__u32_overflow_test
[15:52:32] [PASSED] s32_s32__s32_overflow_test
[15:52:32] [SKIPPED] u64_u64__u64_overflow_test
[15:52:32] [SKIPPED] s64_s64__s64_overflow_test
[15:52:32] [SKIPPED] u32_u32__int_overflow_test
[15:52:32] [PASSED] u32_u32__u8_overflow_test
[15:52:32] [PASSED] u8_u8__int_overflow_test
[15:52:32] [PASSED] int_int__u8_overflow_test
[15:52:32] [PASSED] shift_sane_test
[15:52:32] [PASSED] shift_overflow_test
[15:52:32] [PASSED] shift_truncate_test
[15:52:32] [PASSED] shift_nonsense_test
[15:52:32] [PASSED] overflow_allocation_test
[15:52:32] [PASSED] overflow_size_helpers_test
[15:52:32] ==================== [PASSED] overflow =====================
[15:52:32] ============================================================
[15:52:32] Testing complete. Ran 18 tests: passed: 15, skipped: 3

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Cc: Daniel Latypov <dlatypov@google.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/overflow_kunit.c | 52 +++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 2914c9d36b0f..3062b33e4bb1 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -16,6 +16,34 @@
 #include <linux/types.h>
 #include <linux/vmalloc.h>
 
+#define SKIP(cond, reason)		do {			\
+	if (cond) {						\
+		kunit_skip(test, reason);			\
+		return;						\
+	}							\
+} while (0)
+
+/*
+ * Clang 11 and earlier generate unwanted libcalls for signed output
+ * on unsigned input.
+ */
+#if defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 11
+# define SKIP_SIGN_MISMATCH(t)	SKIP(t, "Clang 11 unwanted libcalls")
+#else
+# define SKIP_SIGN_MISMATCH(t)	do { } while (0)
+#endif
+
+/*
+ * Clang 13 and earlier generate unwanted libcalls for 64-bit tests on
+ * 32-bit hosts.
+ */
+#if defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 13 &&	\
+    BITS_PER_LONG != 64
+# define SKIP_64_ON_32(t)	SKIP(t, "Clang 13 unwanted libcalls")
+#else
+# define SKIP_64_ON_32(t)	do { } while (0)
+#endif
+
 #define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)			\
 	static const struct test_ ## t1 ## _ ## t2 ## __ ## t {	\
 		t1 a;						\
@@ -94,7 +122,6 @@ DEFINE_TEST_ARRAY(u32) = {
 	{-4U, 5U, 1U, -9U, -20U, true, false, true},
 };
 
-#if BITS_PER_LONG == 64
 DEFINE_TEST_ARRAY(u64) = {
 	{0, 0, 0, 0, 0, false, false, false},
 	{1, 1, 2, 0, 1, false, false, false},
@@ -118,7 +145,6 @@ DEFINE_TEST_ARRAY(u64) = {
 	 false, true, false},
 	{-15ULL, 10ULL, -5ULL, -25ULL, -150ULL, false, false, true},
 };
-#endif
 
 DEFINE_TEST_ARRAY(s8) = {
 	{0, 0, 0, 0, 0, false, false, false},
@@ -194,7 +220,6 @@ DEFINE_TEST_ARRAY(s32) = {
 	{S32_MAX, S32_MAX, -2, 0, 1, true, false, true},
 };
 
-#if BITS_PER_LONG == 64
 DEFINE_TEST_ARRAY(s64) = {
 	{0, 0, 0, 0, 0, false, false, false},
 
@@ -223,7 +248,6 @@ DEFINE_TEST_ARRAY(s64) = {
 	{-128, -1, -129, -127, 128, false, false, false},
 	{0, -S64_MAX, -S64_MAX, S64_MAX, 0, false, false, false},
 };
-#endif
 
 #define check_one_op(t, fmt, op, sym, a, b, r, of) do {			\
 	int _a_orig = a, _a_bump = a + 1;				\
@@ -246,7 +270,7 @@ DEFINE_TEST_ARRAY(s64) = {
 
 #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
 static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
-{							   		\
+{									\
 	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
 	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
 	check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);	\
@@ -254,10 +278,15 @@ static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
 	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
 }									\
 									\
-__maybe_unused								\
 static void n ## _overflow_test(struct kunit *test) {			\
 	unsigned i;							\
 									\
+	SKIP_64_ON_32(__same_type(t, u64));				\
+	SKIP_64_ON_32(__same_type(t, s64));				\
+	SKIP_SIGN_MISMATCH(__same_type(n ## _tests[0].a, u32) &&	\
+			   __same_type(n ## _tests[0].b, u32) &&	\
+			   __same_type(n ## _tests[0].sum, int));	\
+									\
 	for (i = 0; i < ARRAY_SIZE(n ## _tests); ++i)			\
 		do_test_ ## n(test, &n ## _tests[i]);			\
 	kunit_info(test, "%zu %s arithmetic tests finished\n",		\
@@ -273,10 +302,8 @@ DEFINE_TEST_FUNC(u16, "%d");
 DEFINE_TEST_FUNC(s16, "%d");
 DEFINE_TEST_FUNC(u32, "%u");
 DEFINE_TEST_FUNC(s32, "%d");
-#if BITS_PER_LONG == 64
 DEFINE_TEST_FUNC(u64, "%llu");
 DEFINE_TEST_FUNC(s64, "%lld");
-#endif
 
 DEFINE_TEST_ARRAY_TYPED(u32, u32, u8) = {
 	{0, 0, 0, 0, 0, false, false, false},
@@ -716,18 +743,9 @@ static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(s16_s16__s16_overflow_test),
 	KUNIT_CASE(u32_u32__u32_overflow_test),
 	KUNIT_CASE(s32_s32__s32_overflow_test),
-/* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
-#if BITS_PER_LONG == 64
 	KUNIT_CASE(u64_u64__u64_overflow_test),
 	KUNIT_CASE(s64_s64__s64_overflow_test),
-#endif
-/*
- * Clang 11 and earlier generate unwanted libcalls for signed output, unsigned
- * input.
- */
-#if !(defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 11)
 	KUNIT_CASE(u32_u32__int_overflow_test),
-#endif
 	KUNIT_CASE(u32_u32__u8_overflow_test),
 	KUNIT_CASE(u8_u8__int_overflow_test),
 	KUNIT_CASE(int_int__u8_overflow_test),
-- 
2.34.1

