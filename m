Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139946D8B5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjDFACe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjDFACV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:02:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBB67683
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:02:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f22so31833624plr.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 17:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680739338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fe5ivn1TRo1YQZGpjtcwb12k/6+IjegXd9dcvsAQqpo=;
        b=Eieac6hsjf/ZtZ6plrcl1dl/HZP04XmleXkBFTI8obqP7vSWmG64v4kacbMCs8dpWt
         go4DkRkXiLIgYWKgo9aqhUljI7kk5PM9t65E4/tHOpurAAv4no0mFm6pa3zp6QANyXKf
         Ua3KKUxFXnPibYqx9V1JXt7QQvw0ItwgQNNB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fe5ivn1TRo1YQZGpjtcwb12k/6+IjegXd9dcvsAQqpo=;
        b=kngLNoq1snSHFWdhn7iVhjc9AhfI4JYKmnZnsuvpCnIUd2icP+CT7WACnTlE64TTSX
         NUqJ3CUMpEdtzeAJRnjG4AyC+t2qcMSBfE1Zt1Y64kHSsZ5k9KW03YJsrmxzyc7dFXXP
         AEvZSAYkAlNaBxnyP4Z5FGmETXS04kujaZxt77jJFDdEAbWKjuie3KMPQXczYaSTNEju
         PDCBt5R1l2kfozS7aFlU+MQ1MjrPJJjjfpU9f46w6IHZ+8SL8LBOSMNn8RqzwmbWWAAU
         QH1rgnpZPrnu8/uHhgaaBwlEGv07Ic8FZDVPKI4CV7CSTTmP0o9LHwWnPHdimkB9D5k0
         vkJg==
X-Gm-Message-State: AAQBX9dFXYfqBDogsivKZve4xc2EMoyc4Lw1nRmweiEVM8j7m0N3q3xC
        lnuE3yCjUUx5Xn9KoPG6ytDiMA==
X-Google-Smtp-Source: AKy350aomOqDqvXhNunTGZYDcgBayMXIVPMHGOPLs/CQ7Cm2Nz82I5oLxglulGszlyVNWhM7GqGS0w==
X-Received: by 2002:a17:903:2306:b0:1a0:4046:23f2 with SMTP id d6-20020a170903230600b001a0404623f2mr9242650plh.56.1680739338311;
        Wed, 05 Apr 2023 17:02:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902b59200b0019f1264c7d7sm94897pls.103.2023.04.05.17.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 17:02:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Kees Cook <kees@outflux.net>,
        Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH 7/9] fortify: Provide KUnit counters for failure testing
Date:   Wed,  5 Apr 2023 17:02:06 -0700
Message-Id: <20230406000212.3442647-7-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405235832.never.487-kees@kernel.org>
References: <20230405235832.never.487-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10804; i=keescook@chromium.org;
 h=from:subject; bh=sfFlPo/mYV5VxdWixlpvcwAc+CtRK0pyQL7GL4KflJE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkLgv/qRZxzYzlqXt/wBRNW5IQR7wBwCY6ToiHUJ3z
 CNBFVL+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZC4L/wAKCRCJcvTf3G3AJrLzEA
 CzZ2FJuTA4dSd+rwj+KZD5cCIco6tJp5KYGB1dXhNiIWkEElDOF1wuQdwEiexK9jwUJZoD6YmdRSU8
 TMtyStxj/IF6hySQyYpNkxeNyRDZjdWxWj7ABcr+5FfY3xQxPBuKizXW13+QGrBLDju6jSAay/CleP
 fvXvsDLWKCGgN/Hwy1D6va8eSbDV1I4w9hkKOyOLXp8OyxSQ0RZPVijwC2eCr+EV5oeLKWKq8IL1mq
 eQq9nCvh1wx3IEBpSilz2776YQ7iAe1TiAWUID4L0xxgh02Nx4aakR6YAh4vq+7/5KmW5UVMJ3BvBI
 WB3RTHOeMpwNGAgHkAlLRN7SsQ13raE7svGvgWDAOvEkXvtIYx/BSib6r/5SmsaRg2gPB6SGluJS94
 6lYilIjUMchmfbcFQqqbX4ze2LFzE4fsm/mxTNkyfu2z3EjbRjJp5xsdUpgl9YM6FxvL6/P6oU8JVF
 tV10AlH83wkqVa3N54CRjBmIKZrMxNtmNpN4I83Lgh0buZDlYs85JGDsyDKiPxUasoVSedJxIpcZ5u
 1Qvq3JQMetSjq+GFrMr/L+ax8uG8rmcl6Ro39BPGplzrR+/2oTIE8/cBeyPLLgOqZDFI1nJYytd89j
 RP74yoh1iJxniMF6OM0iAqm73tnaArMMeuFt61Nf2lHa5jOeFcIp5l0enxFg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <kees@outflux.net>

The standard C string APIs were not designed to have a failure mode;
they were expected to always succeed without memory safety issues.
Normally, CONFIG_FORTIFY_SOURCE will use fortify_panic() to stop
processing, as truncating a read or write may provide an even worse
system state. However, this creates a problem for testing under things
like KUnit, which needs a way to survive failures.

When building with CONFIG_KUNIT, provide a failure path for all users
for fortify_panic, and track whether the failure was a read overflow or
a write overflow, for KUnit tests to examine. Inspired by similar logic
in the slab tests.

Signed-off-by: Kees Cook <kees@outflux.net>
---
 include/linux/fortify-string.h | 45 +++++++++++++++++---------------
 lib/fortify_kunit.c            | 47 ++++++++++++++++++++++++++++++++++
 lib/string_helpers.c           |  3 +++
 3 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 6db4052db459..2bbee7b28e71 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -11,8 +11,12 @@
 
 #define fortify_reason(func, write)	(((func) << 1) | !!(write))
 
-#define fortify_panic(func, write)	\
+#ifdef FORTIFY_KUNIT_OVERRIDE
+# define fortify_panic kunit_fortify_panic
+#else
+# define fortify_panic(func, write, retfail)	\
 	__fortify_panic(fortify_reason(func, write))
+#endif
 
 #define FORTIFY_READ		 0
 #define FORTIFY_WRITE		 1
@@ -174,7 +178,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE, p);
 	return __underlying_strncpy(p, q, size);
 }
 
@@ -205,7 +209,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	/* Do not check characters beyond the end of p. */
 	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
-		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ, ret);
 	return ret;
 }
 
@@ -241,7 +245,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 		return __underlying_strlen(p);
 	ret = strnlen(p, p_size);
 	if (p_size <= ret)
-		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, ret);
 	return ret;
 }
 
@@ -283,7 +287,7 @@ __FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, si
 	}
 	if (size) {
 		if (len >= p_size)
-			fortify_panic(FORTIFY_FUNC_strlcpy, FORTIFY_WRITE);
+			fortify_panic(FORTIFY_FUNC_strlcpy, FORTIFY_WRITE, q_len);
 		__underlying_memcpy(p, q, len);
 		p[len] = '\0';
 	}
@@ -361,7 +365,7 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	 * p_size.
 	 */
 	if (len > p_size)
-		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE, -E2BIG);
 
 	/*
 	 * We can now safely call vanilla strscpy because we are protected from:
@@ -419,7 +423,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if string is already overflowed. */
 	if (p_size <= p_len)
-		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ, wanted);
 
 	if (actual >= avail) {
 		copy_len = avail - p_len - 1;
@@ -428,7 +432,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if copy will overflow. */
 	if (p_size <= actual)
-		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE, wanted);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[actual] = '\0';
 
@@ -457,7 +461,7 @@ char *strcat(char * const POS p, const char *q)
 	size_t p_size = __member_size(p);
 
 	if (strlcat(p, q, p_size) >= p_size)
-		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE, p);
 	return p;
 }
 
@@ -493,13 +497,13 @@ char *strncat(char * const POS p, const char * const POS q, __kernel_size_t coun
 	p_len = strlen(p);
 	copy_len = strnlen(q, count);
 	if (p_size < p_len + copy_len + 1)
-		fortify_panic(FORTIFY_FUNC_strncat, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strncat, FORTIFY_WRITE, p);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[p_len + copy_len] = '\0';
 	return p;
 }
 
-__FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
+__FORTIFY_INLINE bool fortify_memset_chk(__kernel_size_t size,
 					 const size_t p_size,
 					 const size_t p_size_field)
 {
@@ -534,7 +538,8 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE, true);
+	return false;
 }
 
 #define __fortify_memset_chk(p, c, size, p_size, p_size_field) ({	\
@@ -633,9 +638,9 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic(func, FORTIFY_WRITE);
+		fortify_panic(func, FORTIFY_WRITE, true);
 	else if (q_size != SIZE_MAX && q_size < size)
-		fortify_panic(func, FORTIFY_READ);
+		fortify_panic(func, FORTIFY_READ, true);
 
 	/*
 	 * Warn when writing beyond destination field size.
@@ -735,7 +740,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ, NULL);
 	return __real_memscan(p, c, size);
 }
 
@@ -752,7 +757,7 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 			__read_overflow2();
 	}
 	if (p_size < size || q_size < size)
-		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, INT_MIN);
 	return __underlying_memcmp(p, q, size);
 }
 
@@ -764,7 +769,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ, NULL);
 	return __underlying_memchr(p, c, size);
 }
 
@@ -776,7 +781,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ, NULL);
 	return __real_memchr_inv(p, c, size);
 }
 
@@ -789,7 +794,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, NULL);
 	return __real_kmemdup(p, size, gfp);
 }
 
@@ -826,7 +831,7 @@ char *strcpy(char * const POS p, const char * const POS q)
 		__write_overflow();
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE, p);
 	__underlying_memcpy(p, q, size);
 	return p;
 }
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index d054fc20a7d5..f7523c25d341 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -15,12 +15,28 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+/* Call kunit_fortify_panic() instead of fortify_panic() */
+#define FORTIFY_KUNIT_OVERRIDE
+void fortify_add_kunit_error(int write);
+#define kunit_fortify_panic(func, write, retfail)			\
+	do {								\
+		__fortify_report(fortify_reason(func, write));		\
+		fortify_add_kunit_error(write);				\
+		return (retfail);					\
+	} while (0)
+
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 
+static struct kunit_resource read_resource;
+static struct kunit_resource write_resource;
+static int fortify_read_overflows;
+static int fortify_write_overflows;
+
 static const char array_of_10[] = "this is 10";
 static const char *ptr_of_11 = "this is 11!";
 static char array_unknown[] = "compiler thinks I might change";
@@ -36,6 +52,25 @@ do {				\
 		kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=y"); \
 } while (0)
 
+void fortify_add_kunit_error(int write)
+{
+	struct kunit_resource *resource;
+	struct kunit *current_test;
+
+	current_test = kunit_get_current_test();
+	if (!current_test)
+		return;
+
+	resource = kunit_find_named_resource(current_test,
+			write ? "fortify_write_overflows"
+			      : "fortify_read_overflows");
+	if (!resource)
+		return;
+
+	(*(int *)resource->data)++;
+	kunit_put_resource(resource);
+}
+
 static void known_sizes_test(struct kunit *test)
 {
 	skip_without_fortify();
@@ -322,6 +357,17 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 
+static int fortify_test_init(struct kunit *test)
+{
+	kunit_add_named_resource(test, NULL, NULL, &read_resource,
+				 "fortify_read_overflows",
+				 &fortify_read_overflows);
+	kunit_add_named_resource(test, NULL, NULL, &write_resource,
+				 "fortify_write_overflows",
+				 &fortify_write_overflows);
+	return 0;
+}
+
 static struct kunit_case fortify_test_cases[] = {
 	KUNIT_CASE(known_sizes_test),
 	KUNIT_CASE(control_flow_split_test),
@@ -338,6 +384,7 @@ static struct kunit_case fortify_test_cases[] = {
 
 static struct kunit_suite fortify_test_suite = {
 	.name = "fortify",
+	.init = fortify_test_init,
 	.test_cases = fortify_test_cases,
 };
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 631c50657096..5bb65f623e40 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -18,6 +18,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/string_helpers.h>
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
 
 /**
  * string_get_size - get the size in the specified units
@@ -1091,4 +1093,5 @@ void __fortify_panic(const u8 reason)
 	BUG();
 }
 EXPORT_SYMBOL(__fortify_panic);
+
 #endif /* CONFIG_FORTIFY_SOURCE */
-- 
2.34.1

