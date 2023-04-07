Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0294C6DB431
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjDGT1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDGT1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:27:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A72AD02
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:27:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id r21-20020a17090aa09500b0024663a79050so1200792pjp.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680895643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtXr5RoVmaQryzufWycfOD9IzG3R0AifqNWgNZdzp4U=;
        b=XVmu2Rcn3iTKoVxTQJIsHMhe8djtMAh8NZJjDrpP8Vb1i0P8WAILZIaTBH8DqTGo9o
         hcEltXOA2HGqONgkX+3oP4XYCMAi3SPD/C25tkpTbF2N2D0XF4Gay/TFB3L+gDq4zwKF
         8rMD6UcbsMlk0maeGlA0TztvOjGTyUk91a90I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680895643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtXr5RoVmaQryzufWycfOD9IzG3R0AifqNWgNZdzp4U=;
        b=QIJySfaDcKn/OiHcYPWSWZb3faY8j97mzZXafZ25dBbyUat2+xIHFzYFhpzqVpmLp2
         nCCyWegdLljqs1w0AYp7c+4/SqTY0pZo6hMD32i1QGtZPO4DelW/Lmb0B9M5aNSoTkPO
         WanNbL4YNM/2c558GSKXVctfSX6T1fzXnFdsawtF+nano7hKveIsub9tVusRJzFRtUPq
         2ha9fydtj60/3kXrzmcB3xcrQnw1D6oxCUJ9qbuR1T0i9etH5RmtQ3D1Yj1eUKTjdA5L
         CYMR3I1MlBQHlDrDapLrcS+u2t8LAeXldAU9/xAiJ0VqseQ5JhrSlrkU/xRo4dryAJ0C
         MSng==
X-Gm-Message-State: AAQBX9dcF+k3kP/v4JxvxnzYytCtyYiUAap7hPlKho6USq4me1qqURkx
        1vOealZwh3rW8bDk8LfLb+oTcg==
X-Google-Smtp-Source: AKy350ZBiixre91sg/E7cmT1bwyyfRTGhvMePIXsvIpn6XNzI9LnAoQ0jjYjRTd7jZv0LvAahLD60w==
X-Received: by 2002:a17:90b:1e02:b0:23f:680e:78be with SMTP id pg2-20020a17090b1e0200b0023f680e78bemr3184365pjb.48.1680895642717;
        Fri, 07 Apr 2023 12:27:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090adac500b0023af8a3cf6esm5079479pjx.48.2023.04.07.12.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:27:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Andy Shevchenko" <andy@kernel.org>,
        "Cezary Rojewski" <cezary.rojewski@intel.com>,
        "Puyou Lu" <puyou.lu@gmail.com>, "Mark Brown" <broonie@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Brendan Higgins" <brendan.higgins@linux.dev>,
        "David Gow" <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Alexander Potapenko" <glider@google.com>,
        "Zhaoyang Huang" <zhaoyang.huang@unisoc.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Liam Howlett" <liam.howlett@oracle.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Yury Norov" <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Sander Vanheule" <sander@svanheule.net>,
        "Eric Biggers" <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Daniel Latypov" <dlatypov@google.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH v2 08/10] fortify: Provide KUnit counters for failure testing
Date:   Fri,  7 Apr 2023 12:27:14 -0700
Message-Id: <20230407192717.636137-8-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407191904.gonna.522-kees@kernel.org>
References: <20230407191904.gonna.522-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10499; h=from:subject; bh=HDkfKLZGYb4y6Gt1HP3WKO7W1wPBmVIa6+/k24ttCH0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkMG6TNfYywyhtqW2LcR0LneffaDquIBeTlMjpGadx 0zM/q7+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZDBukwAKCRCJcvTf3G3AJoNrEA CKgpbKDLWyn5CI6HVQrDnugMonKDm9XQ5Svz+EUgPoVEYM17r55MxTn6/cywJC6cfMnL7K5426HXZL 5BDwCtsHctmhrduJP7qtn5nu7yw5NAzmofy7FRI5SgPPSRDu7s227g6fr2qgpExDHzKIyXt5ajVGcJ 3H0xbFLZlLSscvH+R785t6M7lqFr8LjYdMTgevbxL7G8lvgHke/j4erxcXCb5JmPx2S0adgyGXifxf UzbIHBCIjcWVE9otKu0SLoWKfcYk5SjlLfcwY/9V0w9BYXXR+2Dqgz6ZfdGs7B/srBiplHp+1VtOa2 3Bct3EcFo+PR8AbUg+QCDzebXdOXL8YRFu8oYnScpgzmSTqoKbY1Iw6bqD4ZKKMaiwo39fKx1Htt7Y uolRIQjB7TueQW4OU+nHY7GdASfnZBN11NBWu5uZvY+rZyx0P+1F38k2vSOJ29CSMXyDI4EllysGAz SO98kotSp9mHoT72/5DR4d2JAXJniCfmpwvXTK2sk9BIfM08G/Fz1w/zwUMsHWZy3cEyxnlB6K1Ec5 UyYBozChKdBvQB3B53G2RTqGqjX6P5bj5c9q+NdHRtYQkycU3oMJieFyD//lUmRYWjZiSPNh/Cp/Yu zgTLlbtYjACaK77LHiZf65feNiJThh99mQ8ynMedhliw6dxfUjt5CC8XrD/g==
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

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 45 +++++++++++++++++++---------------
 lib/fortify_kunit.c            | 44 +++++++++++++++++++++++++++++++++
 lib/string_helpers.c           |  2 ++
 3 files changed, 71 insertions(+), 20 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 19906b45fb98..5d04c0e95854 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -15,8 +15,12 @@
 #define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
 					 FIELD_PREP(GENMASK(7, 1), func))
 
-#define fortify_panic(func, write)	\
+#ifdef FORTIFY_KUNIT_OVERRIDE
+# define fortify_panic kunit_fortify_panic
+#else
+# define fortify_panic(func, write, retfail)	\
 	__fortify_panic(FORTIFY_REASON(func, write))
+#endif
 
 #define FORTIFY_READ		 0
 #define FORTIFY_WRITE		 1
@@ -186,7 +190,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE, p);
 	return __underlying_strncpy(p, q, size);
 }
 
@@ -217,7 +221,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	/* Do not check characters beyond the end of p. */
 	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
-		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ, ret);
 	return ret;
 }
 
@@ -253,7 +257,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 		return __underlying_strlen(p);
 	ret = strnlen(p, p_size);
 	if (p_size <= ret)
-		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, ret);
 	return ret;
 }
 
@@ -295,7 +299,7 @@ __FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, si
 	}
 	if (size) {
 		if (len >= p_size)
-			fortify_panic(FORTIFY_FUNC_strlcpy, FORTIFY_WRITE);
+			fortify_panic(FORTIFY_FUNC_strlcpy, FORTIFY_WRITE, q_len);
 		__underlying_memcpy(p, q, len);
 		p[len] = '\0';
 	}
@@ -373,7 +377,7 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	 * p_size.
 	 */
 	if (len > p_size)
-		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE, -E2BIG);
 
 	/*
 	 * We can now safely call vanilla strscpy because we are protected from:
@@ -431,7 +435,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if string is already overflowed. */
 	if (p_size <= p_len)
-		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ, wanted);
 
 	if (actual >= avail) {
 		copy_len = avail - p_len - 1;
@@ -440,7 +444,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if copy will overflow. */
 	if (p_size <= actual)
-		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE, wanted);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[actual] = '\0';
 
@@ -469,7 +473,7 @@ char *strcat(char * const POS p, const char *q)
 	const size_t p_size = __member_size(p);
 
 	if (strlcat(p, q, p_size) >= p_size)
-		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE, p);
 	return p;
 }
 
@@ -505,13 +509,13 @@ char *strncat(char * const POS p, const char * const POS q, __kernel_size_t coun
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
@@ -546,7 +550,8 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE, true);
+	return false;
 }
 
 #define __fortify_memset_chk(p, c, size, p_size, p_size_field) ({	\
@@ -645,9 +650,9 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
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
@@ -747,7 +752,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ, NULL);
 	return __real_memscan(p, c, size);
 }
 
@@ -764,7 +769,7 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 			__read_overflow2();
 	}
 	if (p_size < size || q_size < size)
-		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, INT_MIN);
 	return __underlying_memcmp(p, q, size);
 }
 
@@ -776,7 +781,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ, NULL);
 	return __underlying_memchr(p, c, size);
 }
 
@@ -788,7 +793,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ, NULL);
 	return __real_memchr_inv(p, c, size);
 }
 
@@ -801,7 +806,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ);
+		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, NULL);
 	return __real_kmemdup(p, size, gfp);
 }
 
@@ -838,7 +843,7 @@ char *strcpy(char * const POS p, const char * const POS q)
 		__write_overflow();
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE);
+		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE, p);
 	__underlying_memcpy(p, q, size);
 	return p;
 }
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 524132f33cf0..ea2b39f279c2 100644
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
+		__fortify_report(FORTIFY_REASON(func, write));		\
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
@@ -30,6 +46,25 @@ static char array_unknown[] = "compiler thinks I might change";
 # define __compiletime_strlen __builtin_strlen
 #endif
 
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
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen("88888888"), 8);
@@ -317,6 +352,15 @@ static int fortify_test_init(struct kunit *test)
 	if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
 		kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=y");
 
+	fortify_read_overflows = 0;
+	kunit_add_named_resource(test, NULL, NULL, &read_resource,
+				 "fortify_read_overflows",
+				 &fortify_read_overflows);
+	fortify_write_overflows = 0;
+	kunit_add_named_resource(test, NULL, NULL, &write_resource,
+				 "fortify_write_overflows",
+				 &fortify_write_overflows);
+
 	return 0;
 }
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 96d502e1e578..38edde20e61b 100644
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
-- 
2.34.1

