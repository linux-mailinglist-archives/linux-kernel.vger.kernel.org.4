Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001096DB433
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjDGT14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjDGT1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:27:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33606C165
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:27:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24059dcdd90so140188a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680895644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbRUNtQREL0DnI77lki5y+qi2N6+jLmYqH388JdhlwY=;
        b=FAoUtZ0IZEcsn04MhKwxFE63a6uQgiN8u8sEyytJFvZOkPTBTyAZapmS7BeOaptvI4
         MSJ8t8Z4rx218WiQZnnghN1vBOuMYSy8orkJcuGTiqnbDgzi05q5GMxN0azPtCaPfTGG
         eGoC2vG4lKQLguk5JzWLG/h7g0gB/BBM4SmhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680895644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbRUNtQREL0DnI77lki5y+qi2N6+jLmYqH388JdhlwY=;
        b=qTNJN0zX7Xcp+q29TV2Xx4clfLCxwxSVxJGqPCeRp9IvyowxUGtdaxXIWO0udf/bcP
         afqtZhicXmeia9m99ltvnjBOrUq0iUTL1dNi02/npgELvrBY0J8DToStkOdASq62wvoV
         FYp9+3G2gXFGYhrsPKYIWmgIih2AU2W6QhHf57hYmRw4lM1o+Fbc/G475DpgbxiMvc6I
         zVG9qf4tBCgkAaXxCVMDEmejUfHohZdIYYpCtMGI0t7PZCBaCReDD05pUxBza+H2wtro
         Y7JWXMlwmWOGD8lSOgl6hlX/4OdC0DJNGwAuUdCBnpCh4AQsPBYB+o7W/xXJ4fHeBWpC
         I+yw==
X-Gm-Message-State: AAQBX9fp2ilCYJsN8Iv9zbTzP8rUmrhTm/564zXawfGBse2/UzhJM7XH
        mBABwC6uGrLA8IK+TsEpXRqwcw==
X-Google-Smtp-Source: AKy350ZOUEKqvviQTvqjvKcxzhWJPmNjbSKiiq3vBUlMbVln49YVqFo+nfvBonYMd8B9mouoprO3lg==
X-Received: by 2002:aa7:9489:0:b0:625:c048:2f81 with SMTP id z9-20020aa79489000000b00625c0482f81mr3829161pfk.32.1680895644532;
        Fri, 07 Apr 2023 12:27:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v3-20020a654603000000b004fb3e5681cesm3021477pgq.20.2023.04.07.12.27.20
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
Subject: [PATCH v2 10/10] fortify: Improve buffer overflow reporting
Date:   Fri,  7 Apr 2023 12:27:16 -0700
Message-Id: <20230407192717.636137-10-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407191904.gonna.522-kees@kernel.org>
References: <20230407191904.gonna.522-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11869; h=from:subject; bh=bpA1jsos8ihAGMBPbjj09ClSgIt8BDsSB6LmWIMM3eA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkMG6US5JDkRy/aBh8U7DiQHZBij17I90SlAMF25rf 8EgZM8yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZDBulAAKCRCJcvTf3G3AJuqlEA CgneoPbDTP3hoDMQ23AZmFarDboVoqlpZDMw7uGB9IzfSDNOQvJoiydTt7CA4FLc47zPXUQH5rTVZx 5Rz1Tb1jl0z9Hnkn8TzJr2hwSye+RgTnBsf0TWQdv2x9Fkc5K76aHENZRr7Jlo9aZrbGmIFoMUSgAN 1qJ8DJELMi3mwtohjEBq9utH8M1zemeXVn/NN03pDMZTWENrEeNgRgPvacbRosUz2tgjSZfH707Lw3 KllW0S3P3IEa/JcwofX69VG/bZK1rpmNx5zI2LWc9Qs8tgHnkZkBI4i2g4QDMArK8WGv0kC3bBTbiX 6EHiGE2nHiE6YsMIwvldLg+TiYReDQwqTQVoTZM9xO6li2I7xZa+4uEjmcPUbSB6RakJ1szLv1slZf 2Ahn0dhrnFl3jS6xDfOdjryZqMBgzxuV0BQiCgtBtvjlFcopV8nnnbtKkGBSFpWwLqim7WAz+bpf1Q hg9tRiXEfHulw9lxvi9HhKaUYGfy/LN9xx+gZJUIehuM1sTWY6bQTLfskIhG6e0LxGx83WLx5uaHAB PElOBRwzuTVNbSXvtIIOfCaGbkU9mM5dSvIEOz2GQn8E70fTwFeWuGBV8Q6x2Yu+zH02htgPCR82cs WOVAyWpkyqU19043PLPPcFNZjNY+MkV10D4gq8+O/dXUvZlvla5zIRf35t0g==
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

Improve the reporting of buffer overflows under CONFIG_FORTIFY_SOURCE to
help accelerate debugging efforts. The calculations are all just sitting
in registers anyway, so pass them along to the function to be reported.

For example, before:

  detected buffer overflow in memcpy

and after:

  memcpy: detected buffer overflow: 4096 byte read from buffer of size 1

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/misc.c |  2 +-
 arch/x86/boot/compressed/misc.c |  2 +-
 include/linux/fortify-string.h  | 61 ++++++++++++++++++---------------
 lib/fortify_kunit.c             |  4 +--
 lib/string_helpers.c            |  9 ++---
 5 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index f31e2c949089..5487f64d8c3d 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -160,7 +160,7 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 		putstr(" done, booting the kernel.\n");
 }
 
-void __fortify_panic(const u8 reason)
+void __fortify_panic(const u8 reason, size_t avail, size_t size)
 {
 	error("detected buffer overflow");
 }
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index aa45e7529a40..c1dc12abd6d9 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -470,7 +470,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	return output + entry_offset;
 }
 
-void __fortify_panic(const u8 reason)
+void __fortify_panic(const u8 reason, size_t avail, size_t size)
 {
 	error("detected buffer overflow");
 }
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 5d04c0e95854..a0002740d2a7 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -18,8 +18,8 @@
 #ifdef FORTIFY_KUNIT_OVERRIDE
 # define fortify_panic kunit_fortify_panic
 #else
-# define fortify_panic(func, write, retfail)	\
-	__fortify_panic(FORTIFY_REASON(func, write))
+# define fortify_panic(func, write, avail, size, retfail)	\
+	__fortify_panic(FORTIFY_REASON(func, write), avail, size)
 #endif
 
 #define FORTIFY_READ		 0
@@ -51,8 +51,8 @@ enum fortify_func {
 	EACH_FORTIFY_FUNC(MAKE_FORTIFY_FUNC)
 };
 
-void __fortify_report(const u8 reason);
-void __fortify_panic(const u8 reason) __cold __noreturn;
+void __fortify_report(const u8 reason, const size_t avail, const size_t size);
+void __fortify_panic(const u8 reason, const size_t avail, const size_t size) __cold __noreturn;
 void __read_overflow(void) __compiletime_error("detected read beyond size of object (1st parameter)");
 void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
 void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("detected read beyond size of field (2nd parameter); maybe use struct_group()?");
@@ -190,7 +190,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE, p);
+		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE, p_size, size, p);
 	return __underlying_strncpy(p, q, size);
 }
 
@@ -221,7 +221,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	/* Do not check characters beyond the end of p. */
 	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
-		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ, ret);
+		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ, p_size, ret + 1, ret);
 	return ret;
 }
 
@@ -257,7 +257,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 		return __underlying_strlen(p);
 	ret = strnlen(p, p_size);
 	if (p_size <= ret)
-		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, ret);
+		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, p_size, ret + 1, ret);
 	return ret;
 }
 
@@ -298,8 +298,8 @@ __FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, si
 			__write_overflow();
 	}
 	if (size) {
-		if (len >= p_size)
-			fortify_panic(FORTIFY_FUNC_strlcpy, FORTIFY_WRITE, q_len);
+		if (p_size <= len)
+			fortify_panic(FORTIFY_FUNC_strlcpy, FORTIFY_WRITE, p_size, len + 1, q_len);
 		__underlying_memcpy(p, q, len);
 		p[len] = '\0';
 	}
@@ -376,8 +376,8 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	 * Generate a runtime write overflow error if len is greater than
 	 * p_size.
 	 */
-	if (len > p_size)
-		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE, -E2BIG);
+	if (p_size < len)
+		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE, p_size, len, -E2BIG);
 
 	/*
 	 * We can now safely call vanilla strscpy because we are protected from:
@@ -435,7 +435,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if string is already overflowed. */
 	if (p_size <= p_len)
-		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ, wanted);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ, p_size, p_len + 1, wanted);
 
 	if (actual >= avail) {
 		copy_len = avail - p_len - 1;
@@ -444,7 +444,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if copy will overflow. */
 	if (p_size <= actual)
-		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE, wanted);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE, p_size, actual + 1, wanted);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[actual] = '\0';
 
@@ -471,9 +471,11 @@ __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
 char *strcat(char * const POS p, const char *q)
 {
 	const size_t p_size = __member_size(p);
+	size_t wanted;
 
-	if (strlcat(p, q, p_size) >= p_size)
-		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE, p);
+	wanted = strlcat(p, q, p_size);
+	if (p_size <= wanted)
+		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE, p_size, wanted + 1, p);
 	return p;
 }
 
@@ -502,14 +504,15 @@ char *strncat(char * const POS p, const char * const POS q, __kernel_size_t coun
 {
 	const size_t p_size = __member_size(p);
 	const size_t q_size = __member_size(q);
-	size_t p_len, copy_len;
+	size_t p_len, copy_len, total;
 
 	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
 		return __underlying_strncat(p, q, count);
 	p_len = strlen(p);
 	copy_len = strnlen(q, count);
-	if (p_size < p_len + copy_len + 1)
-		fortify_panic(FORTIFY_FUNC_strncat, FORTIFY_WRITE, p);
+	total = p_len + copy_len + 1;
+	if (p_size < total)
+		fortify_panic(FORTIFY_FUNC_strncat, FORTIFY_WRITE, p_size, total, p);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[p_len + copy_len] = '\0';
 	return p;
@@ -550,7 +553,7 @@ __FORTIFY_INLINE bool fortify_memset_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE, true);
+		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE, p_size, size, true);
 	return false;
 }
 
@@ -650,9 +653,9 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic(func, FORTIFY_WRITE, true);
+		fortify_panic(func, FORTIFY_WRITE, p_size, size, true);
 	else if (q_size != SIZE_MAX && q_size < size)
-		fortify_panic(func, FORTIFY_READ, true);
+		fortify_panic(func, FORTIFY_READ, p_size, size, true);
 
 	/*
 	 * Warn when writing beyond destination field size.
@@ -752,7 +755,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ, NULL);
+		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ, p_size, size, NULL);
 	return __real_memscan(p, c, size);
 }
 
@@ -768,8 +771,10 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 		if (__compiletime_lessthan(q_size, size))
 			__read_overflow2();
 	}
-	if (p_size < size || q_size < size)
-		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, INT_MIN);
+	if (p_size < size)
+		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, p_size, size, INT_MIN);
+	else if (q_size < size)
+		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, q_size, size, INT_MIN);
 	return __underlying_memcmp(p, q, size);
 }
 
@@ -781,7 +786,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ, NULL);
+		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ, p_size, size, NULL);
 	return __underlying_memchr(p, c, size);
 }
 
@@ -793,7 +798,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ, NULL);
+		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ, p_size, size, NULL);
 	return __real_memchr_inv(p, c, size);
 }
 
@@ -806,7 +811,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, NULL);
+		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, p_size, size, NULL);
 	return __real_kmemdup(p, size, gfp);
 }
 
@@ -843,7 +848,7 @@ char *strcpy(char * const POS p, const char * const POS q)
 		__write_overflow();
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE, p);
+		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE, p_size, size, p);
 	__underlying_memcpy(p, q, size);
 	return p;
 }
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 3206fe723110..6aac58eb6eb6 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -18,9 +18,9 @@
 /* Call kunit_fortify_panic() instead of fortify_panic() */
 #define FORTIFY_KUNIT_OVERRIDE
 void fortify_add_kunit_error(int write);
-#define kunit_fortify_panic(func, write, retfail)			\
+#define kunit_fortify_panic(func, write, avail, size, retfail)		\
 	do {								\
-		__fortify_report(FORTIFY_REASON(func, write));		\
+		__fortify_report(FORTIFY_REASON(func, write), avail, size); \
 		fortify_add_kunit_error(write);				\
 		return (retfail);					\
 	} while (0)
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 38edde20e61b..9a8167535e1f 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -1029,20 +1029,21 @@ static const char * const fortify_func_name[] = {
 	EACH_FORTIFY_FUNC(MAKE_FORTIFY_FUNC_NAME)
 };
 
-void __fortify_report(const u8 reason)
+void __fortify_report(const u8 reason, const size_t avail, const size_t size)
 {
 	const u8 func = FORTIFY_REASON_FUNC(reason);
 	const bool write = FORTIFY_REASON_DIR(reason);
 	const char *name;
 
 	name = fortify_func_name[min_t(u8, func, FORTIFY_FUNC_UNKNOWN)];
-	WARN(1, "%s: detected buffer %s overflow\n", name, str_read_write(!write));
+	WARN(1, "%s: detected buffer overflow: %zu byte %s buffer of size %zu\n",
+		 name, size, str_read_write(!write), avail);
 }
 EXPORT_SYMBOL(__fortify_report);
 
-void __fortify_panic(const u8 reason)
+void __fortify_panic(const u8 reason, const size_t avail, const size_t size)
 {
-	__fortify_report(reason);
+	__fortify_report(reason, avail, size);
 	BUG();
 }
 EXPORT_SYMBOL(__fortify_panic);
-- 
2.34.1

