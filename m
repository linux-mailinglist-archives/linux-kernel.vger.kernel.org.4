Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA935B35E6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiIIK7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiIIK7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:59:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D83E1B7BD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662721181; x=1694257181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=69FBMpVYFEUjFQCOfnxuvXYL4ONxLz7KIzDaR+QH+Wo=;
  b=cJKaP0a25Tkcls9EOcLZc1hJCHmjMt2UVQp5wczt6c2rMCynzcwX38Lq
   ek75vmUoqOjxCXt0UAattR8KJlKJCo4Ysbcr1+uWhA291cV7/XZu545RF
   JCI8Vf8wQTp1SJ+cPpfa6WgBfyf8cWEbk14aAwfUwU/CqxY4FnRE32NZg
   1+7BK6DWCLeBy9it+3q6jAkouQgWrSpBNK9qi1elkQDHh8wyAE29LqEls
   XN1VH4Sx1aR6rGGw33joeEKuBDhrS5Ekgrrl3JTDjHI5rBhtqA87rg+KO
   MDRNZ1SFJ6nD08U7G9/VTOcC6i3NNX1YVl+AL30MwPhMJitngUigNEKYe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="297449514"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="297449514"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:59:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="704370301"
Received: from clbarnes-mobl.amr.corp.intel.com (HELO paris.amr.corp.intel.com) ([10.254.42.92])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:59:37 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@redhat.com,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com
Subject: [PATCH v10 1/9] overflow: Allow mixed type arguments
Date:   Fri,  9 Sep 2022 19:59:05 +0900
Message-Id: <20220909105913.752049-2-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
References: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

When the check_[op]_overflow() helpers were introduced, all arguments were
required to be the same type to make the fallback macros simpler. However,
now that the fallback macros have been removed[1], it is fine to allow
mixed types, which makes using the helpers much more useful, as they
can be used to test for type-based overflows (e.g. adding two large ints
but storing into a u8), as would be handy in the drm core[2].

Remove the restriction, and add additional self-tests that exercise some
of the mixed-type overflow cases, and double-check for accidental macro
side-effects.

[1] https://git.kernel.org/linus/4eb6bd55cfb22ffc20652732340c4962f3ac9a91
[2] https://lore.kernel.org/lkml/20220824084514.2261614-2-gwan-gyeong.mun@intel.com

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h |  72 ++++++++++++++++------------
 lib/overflow_kunit.c     | 101 ++++++++++++++++++++++++++++-----------
 2 files changed, 113 insertions(+), 60 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 0eb3b192f07a..19dfdd74835e 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -51,40 +51,50 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	return unlikely(overflow);
 }
 
-/*
- * For simplicity and code hygiene, the fallback code below insists on
- * a, b and *d having the same type (similar to the min() and max()
- * macros), whereas gcc's type-generic overflow checkers accept
- * different types. Hence we don't just make check_add_overflow an
- * alias for __builtin_add_overflow, but add type checks similar to
- * below.
+/** check_add_overflow() - Calculate addition with overflow checking
+ *
+ * @a: first addend
+ * @b: second addend
+ * @d: pointer to store sum
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted addition, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * sum has overflowed or been truncated.
  */
-#define check_add_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_add_overflow(__a, __b, __d);	\
-}))
+#define check_add_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_add_overflow(a, b, d))
 
-#define check_sub_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_sub_overflow(__a, __b, __d);	\
-}))
+/** check_sub_overflow() - Calculate subtraction with overflow checking
+ *
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ * @d: pointer to store difference
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted subtraction, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * difference has underflowed or been truncated.
+ */
+#define check_sub_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_sub_overflow(a, b, d))
 
-#define check_mul_overflow(a, b, d) __must_check_overflow(({	\
-	typeof(a) __a = (a);			\
-	typeof(b) __b = (b);			\
-	typeof(d) __d = (d);			\
-	(void) (&__a == &__b);			\
-	(void) (&__a == __d);			\
-	__builtin_mul_overflow(__a, __b, __d);	\
-}))
+/** check_mul_overflow() - Calculate multiplication with overflow checking
+ *
+ * @a: first factor
+ * @b: second factor
+ * @d: pointer to store product
+ *
+ * Returns 0 on success.
+ *
+ * *@d holds the results of the attempted multiplication, but is not
+ * considered "safe for use" on a non-zero return value, which indicates
+ * that the product has overflowed or been truncated.
+ */
+#define check_mul_overflow(a, b, d)	\
+	__must_check_overflow(__builtin_mul_overflow(a, b, d))
 
 /** check_shl_overflow() - Calculate a left-shifted value and check overflow
  *
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 7e3e43679b73..0d98c9bc75da 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -16,12 +16,15 @@
 #include <linux/types.h>
 #include <linux/vmalloc.h>
 
-#define DEFINE_TEST_ARRAY(t)			\
-	static const struct test_ ## t {	\
-		t a, b;				\
-		t sum, diff, prod;		\
-		bool s_of, d_of, p_of;		\
-	} t ## _tests[]
+#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)			\
+	static const struct test_ ## t1 ## _ ## t2 ## __ ## t {	\
+		t1 a;						\
+		t2 b;						\
+		t sum, diff, prod;				\
+		bool s_of, d_of, p_of;				\
+	} t1 ## _ ## t2 ## __ ## t ## _tests[]
+
+#define DEFINE_TEST_ARRAY(t)	DEFINE_TEST_ARRAY_TYPED(t, t, t)
 
 DEFINE_TEST_ARRAY(u8) = {
 	{0, 0, 0, 0, 0, false, false, false},
@@ -222,21 +225,27 @@ DEFINE_TEST_ARRAY(s64) = {
 };
 #endif
 
-#define check_one_op(t, fmt, op, sym, a, b, r, of) do {		\
-	t _r;							\
-	bool _of;						\
-								\
-	_of = check_ ## op ## _overflow(a, b, &_r);		\
-	KUNIT_EXPECT_EQ_MSG(test, _of, of,			\
+#define check_one_op(t, fmt, op, sym, a, b, r, of) do {			\
+	int _a_orig = a, _a_bump = a + 1;				\
+	int _b_orig = b, _b_bump = b + 1;				\
+	bool _of;							\
+	t _r;								\
+									\
+	_of = check_ ## op ## _overflow(a, b, &_r);			\
+	KUNIT_EXPECT_EQ_MSG(test, _of, of,				\
 		"expected "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
-		a, b, of ? "" : " not", #t);			\
-	KUNIT_EXPECT_EQ_MSG(test, _r, r,			\
+		a, b, of ? "" : " not", #t);				\
+	KUNIT_EXPECT_EQ_MSG(test, _r, r,				\
 		"expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
-		a, b, r, _r, #t);				\
+		a, b, r, _r, #t);					\
+	/* Check for internal macro side-effects. */			\
+	_of = check_ ## op ## _overflow(_a_orig++, _b_orig++, &_r);	\
+	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump, "Unexpected " #op " macro side-effect!\n"); \
+	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump, "Unexpected " #op " macro side-effect!\n"); \
 } while (0)
 
-#define DEFINE_TEST_FUNC(t, fmt)					\
-static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
+#define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
+static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
 {							   		\
 	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
 	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
@@ -245,15 +254,18 @@ static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
 	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
 }									\
 									\
-static void t ## _overflow_test(struct kunit *test) {			\
+static void n ## _overflow_test(struct kunit *test) {			\
 	unsigned i;							\
 									\
-	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)			\
-		do_test_ ## t(test, &t ## _tests[i]);			\
+	for (i = 0; i < ARRAY_SIZE(n ## _tests); ++i)			\
+		do_test_ ## n(test, &n ## _tests[i]);			\
 	kunit_info(test, "%zu %s arithmetic tests finished\n",		\
-		ARRAY_SIZE(t ## _tests), #t);				\
+		ARRAY_SIZE(n ## _tests), #n);				\
 }
 
+#define DEFINE_TEST_FUNC(t, fmt)					\
+	DEFINE_TEST_FUNC_TYPED(t ## _ ## t ## __ ## t, t, fmt)
+
 DEFINE_TEST_FUNC(u8, "%d");
 DEFINE_TEST_FUNC(s8, "%d");
 DEFINE_TEST_FUNC(u16, "%d");
@@ -265,6 +277,33 @@ DEFINE_TEST_FUNC(u64, "%llu");
 DEFINE_TEST_FUNC(s64, "%lld");
 #endif
 
+DEFINE_TEST_ARRAY_TYPED(u32, u32, u8) = {
+	{0, 0, 0, 0, 0, false, false, false},
+	{U8_MAX, 2, 1, U8_MAX - 2, U8_MAX - 1, true, false, true},
+	{U8_MAX + 1, 0, 0, 0, 0, true, true, false},
+};
+DEFINE_TEST_FUNC_TYPED(u32_u32__u8, u8, "%d");
+
+DEFINE_TEST_ARRAY_TYPED(u32, u32, int) = {
+	{0, 0, 0, 0, 0, false, false, false},
+	{U32_MAX, 0, -1, -1, 0, true, true, false},
+};
+DEFINE_TEST_FUNC_TYPED(u32_u32__int, int, "%d");
+
+DEFINE_TEST_ARRAY_TYPED(u8, u8, int) = {
+	{0, 0, 0, 0, 0, false, false, false},
+	{U8_MAX, U8_MAX, 2 * U8_MAX, 0, U8_MAX * U8_MAX, false, false, false},
+	{1, 2, 3, -1, 2, false, false, false},
+};
+DEFINE_TEST_FUNC_TYPED(u8_u8__int, int, "%d");
+
+DEFINE_TEST_ARRAY_TYPED(int, int, u8) = {
+	{0, 0, 0, 0, 0, false, false, false},
+	{1, 2, 3, U8_MAX, 2, false, true, false},
+	{-1, 0, U8_MAX, U8_MAX, 0, true, true, false},
+};
+DEFINE_TEST_FUNC_TYPED(int_int__u8, u8, "%d");
+
 static void overflow_shift_test(struct kunit *test)
 {
 	int count = 0;
@@ -649,17 +688,21 @@ static void overflow_size_helpers_test(struct kunit *test)
 }
 
 static struct kunit_case overflow_test_cases[] = {
-	KUNIT_CASE(u8_overflow_test),
-	KUNIT_CASE(s8_overflow_test),
-	KUNIT_CASE(u16_overflow_test),
-	KUNIT_CASE(s16_overflow_test),
-	KUNIT_CASE(u32_overflow_test),
-	KUNIT_CASE(s32_overflow_test),
+	KUNIT_CASE(u8_u8__u8_overflow_test),
+	KUNIT_CASE(s8_s8__s8_overflow_test),
+	KUNIT_CASE(u16_u16__u16_overflow_test),
+	KUNIT_CASE(s16_s16__s16_overflow_test),
+	KUNIT_CASE(u32_u32__u32_overflow_test),
+	KUNIT_CASE(s32_s32__s32_overflow_test),
 /* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
 #if BITS_PER_LONG == 64
-	KUNIT_CASE(u64_overflow_test),
-	KUNIT_CASE(s64_overflow_test),
+	KUNIT_CASE(u64_u64__u64_overflow_test),
+	KUNIT_CASE(s64_s64__s64_overflow_test),
 #endif
+	KUNIT_CASE(u32_u32__u8_overflow_test),
+	KUNIT_CASE(u32_u32__int_overflow_test),
+	KUNIT_CASE(u8_u8__int_overflow_test),
+	KUNIT_CASE(int_int__u8_overflow_test),
 	KUNIT_CASE(overflow_shift_test),
 	KUNIT_CASE(overflow_allocation_test),
 	KUNIT_CASE(overflow_size_helpers_test),
-- 
2.37.1

