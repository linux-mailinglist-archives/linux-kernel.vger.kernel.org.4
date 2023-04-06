Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9831A6D8B5F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDFACv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjDFACX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:02:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D87C76BD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:02:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so41183687pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 17:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680739339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMkBWw2BkDKd0w5gBkiKI3BqJHl3IJqXN2BQevcFbNE=;
        b=fFL2rtSqkSU6Bt+5odQRtTqVNA9TuWc9jO+VTD4Yl8/W8fT4IdqxL+4K74Hwv+5XqE
         rz0aomwvMjXdOe6kM+YcxrMO2Md7V+uVUFwwpbRoB39+t5Hxtqg2T0GZDYD2qot0e48t
         JiZkOttLyLyYjk791fN7F3Pe6ZTRSLSGhHaR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMkBWw2BkDKd0w5gBkiKI3BqJHl3IJqXN2BQevcFbNE=;
        b=r2A3yAmb9DLSpH8YpNveJX9/v0T22+z0lt2U1+w/HXKE8c9lVl3i20NwARQWC2JkCW
         hGoVwnms4r/dVoQBR1ToVacDebwg1rPXxjbXnyVjURDe/+cl6KWV2c79V/Dl1+K07rP7
         xoZEb2OmjXEtSyV6+7VV9koQk/7XRt9YWSEa1KZ2aRKiUJHxZrhu/QFJZDx8PCxfej0g
         8PS584w6WI0vUVPtOmdtp3uYA31ENJH5+I5QnLenJrj5xie+PuGccFoA2WW/2O7T9M7s
         RcKSfugLqFfJKNnCMabCJVk2iYLShGVxvkyWe1H2inKQ0rPEDcsl9QIxTAc9nopbcHo8
         oi7A==
X-Gm-Message-State: AAQBX9e1peoVa9lmxWTCkzOxyirYZO4ZtavMmRsidaFLSwgqZxs+jJdG
        NrSvtDUsdoXwXfK6U3MAH44plQ==
X-Google-Smtp-Source: AKy350YqaHGkpTFSAl5wJB7/y7MxIVBsC8pLSIGq4AAJ2gq+A3ctEZj3LVvMlzkHp8A0Eaa1T/1csg==
X-Received: by 2002:a17:902:d2c9:b0:19d:7a4:4063 with SMTP id n9-20020a170902d2c900b0019d07a44063mr10558907plc.46.1680739339380;
        Wed, 05 Apr 2023 17:02:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902b7c300b001a240f053aasm82939plz.180.2023.04.05.17.02.16
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
Subject: [PATCH 9/9] fortify: Improve buffer overflow reporting
Date:   Wed,  5 Apr 2023 17:02:08 -0700
Message-Id: <20230406000212.3442647-9-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405235832.never.487-kees@kernel.org>
References: <20230405235832.never.487-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10763; i=keescook@chromium.org;
 h=from:subject; bh=sUo3OusVEyTd1TzMe089/10RvDWd1ECiLD0iA7jbIMo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkLgv/K75AFXHO/hOzjfREHpqcERlLV3XfGhVps4a5
 3V4CDYyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZC4L/wAKCRCJcvTf3G3AJmK6D/
 9gmGPNETiVsquqPmXbjRCt8fY5qeKhaICBkEOkHuWRQ/LJ+rMGE6UpqebohA5cRkOzG8G1yT0Zzyta
 y1uChVwx8YTE627K52ry9bJRzyeDiCx/JxElBaqBeYo870Osw66SI+uL0CpEfCCyp328woQHGN/PeC
 AQ7sn3YG8R8jSkMaBy5jeskTNErnZjw+cc67ltaYlYLh6qA1fN+h7NzjEEGH2VIGVE2JBV+Uap6Cse
 xUoDTRiAchaiSlEhp+CReYFqsEXgQNezLntzmsGkjYSRowJhTOlYZzHsJTGp0yna5vpW4To1w7nQEl
 aXDoYn86ZH538WKLkX/lxmpPnTSS9ERMAatG8B3BtLpZgYpQu7InTzfwIjYypT7f3baF8M2m13pVhi
 CEw3cDwUmHb/nyRc+xBCC6YtT16dHfH+kJ05PEHRXXkgTSCSf7fJEyr98MOraI+M/lCoP28BYBeoDE
 h2bhM2bjKCUJcyJ0Y6lyCiNbcwe4TF/Vus9/2cvmvMwlr77AaoFvPei2PXoOobkr1nfCX5qBemSJDP
 CMbvgY524ktnbIrz7bcvVCTVyEESAMjaVGftjndxhF7eUVbvhS0PHiQcLhXJ98AGWOAL1TUjdkCKiw
 cfK3c11il/LI7k00NfS0hPI/oLPvPiPBPRoAOMngD9FgUwTp/EGUyyH2ZeoQ==
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

Improve the reporting of buffer overflows under CONFIG_FORTIFY_SOURCE to
help accelerate debugging efforts. The calculations are all just sitting
in registers anyway, so pass them along to the function to be reported.

For example, before:

  detected buffer overflow in memcpy

and after:

  memcpy: detected buffer overflow: 4096 byte read from buffer of size 1

Signed-off-by: Kees Cook <kees@outflux.net>
---
 include/linux/fortify-string.h | 60 +++++++++++++++++++---------------
 lib/fortify_kunit.c            |  4 +--
 lib/string_helpers.c           |  9 ++---
 3 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 2bbee7b28e71..d37f4597cf68 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -14,8 +14,8 @@
 #ifdef FORTIFY_KUNIT_OVERRIDE
 # define fortify_panic kunit_fortify_panic
 #else
-# define fortify_panic(func, write, retfail)	\
-	__fortify_panic(fortify_reason(func, write))
+# define fortify_panic(func, write, avail, size, retfail)	\
+	__fortify_panic(fortify_reason(func, write), avail, size)
 #endif
 
 #define FORTIFY_READ		 0
@@ -39,8 +39,8 @@
 #define FORTIFY_FUNC_kmemdup	15
 #define FORTIFY_FUNC_strcpy	16
 
-void __fortify_report(u8 reason);
-void __fortify_panic(u8 reason) __cold __noreturn;
+void __fortify_report(const u8 reason, const size_t avail, const size_t size);
+void __fortify_panic(const u8 reason, const size_t avail, const size_t size) __cold __noreturn;
 void __read_overflow(void) __compiletime_error("detected read beyond size of object (1st parameter)");
 void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
 void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("detected read beyond size of field (2nd parameter); maybe use struct_group()?");
@@ -178,7 +178,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE, p);
+		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE, p_size, size, p);
 	return __underlying_strncpy(p, q, size);
 }
 
@@ -209,7 +209,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	/* Do not check characters beyond the end of p. */
 	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
-		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ, ret);
+		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ, p_size, ret + 1, ret);
 	return ret;
 }
 
@@ -245,7 +245,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 		return __underlying_strlen(p);
 	ret = strnlen(p, p_size);
 	if (p_size <= ret)
-		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, ret);
+		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, p_size, ret + 1, ret);
 	return ret;
 }
 
@@ -286,8 +286,8 @@ __FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, si
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
@@ -364,8 +364,8 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	 * Generate a runtime write overflow error if len is greater than
 	 * p_size.
 	 */
-	if (len > p_size)
-		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE, -E2BIG);
+	if (p_size < len)
+		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE, p_size, len, -E2BIG);
 
 	/*
 	 * We can now safely call vanilla strscpy because we are protected from:
@@ -423,7 +423,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if string is already overflowed. */
 	if (p_size <= p_len)
-		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ, wanted);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ, p_size, p_len + 1, wanted);
 
 	if (actual >= avail) {
 		copy_len = avail - p_len - 1;
@@ -432,7 +432,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if copy will overflow. */
 	if (p_size <= actual)
-		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE, wanted);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE, p_size, actual + 1, wanted);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[actual] = '\0';
 
@@ -459,9 +459,11 @@ __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
 char *strcat(char * const POS p, const char *q)
 {
 	size_t p_size = __member_size(p);
+	size_t wanted;
 
-	if (strlcat(p, q, p_size) >= p_size)
-		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE, p);
+	wanted = strlcat(p, q, p_size);
+	if (p_size <= wanted)
+		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE, p_size, wanted + 1, p);
 	return p;
 }
 
@@ -491,13 +493,15 @@ char *strncat(char * const POS p, const char * const POS q, __kernel_size_t coun
 	size_t p_len, copy_len;
 	size_t p_size = __member_size(p);
 	size_t q_size = __member_size(q);
+	size_t total;
 
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
@@ -538,7 +542,7 @@ __FORTIFY_INLINE bool fortify_memset_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE, true);
+		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE, p_size, size, true);
 	return false;
 }
 
@@ -638,9 +642,9 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
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
@@ -740,7 +744,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ, NULL);
+		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ, p_size, size, NULL);
 	return __real_memscan(p, c, size);
 }
 
@@ -756,8 +760,10 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
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
 
@@ -769,7 +775,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ, NULL);
+		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ, p_size, size, NULL);
 	return __underlying_memchr(p, c, size);
 }
 
@@ -781,7 +787,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ, NULL);
+		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ, p_size, size, NULL);
 	return __real_memchr_inv(p, c, size);
 }
 
@@ -794,7 +800,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, NULL);
+		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, p_size, size, NULL);
 	return __real_kmemdup(p, size, gfp);
 }
 
@@ -831,7 +837,7 @@ char *strcpy(char * const POS p, const char * const POS q)
 		__write_overflow();
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE, p);
+		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE, p_size, size, p);
 	__underlying_memcpy(p, q, size);
 	return p;
 }
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index b7c884037629..b022797c9fe6 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -18,9 +18,9 @@
 /* Call kunit_fortify_panic() instead of fortify_panic() */
 #define FORTIFY_KUNIT_OVERRIDE
 void fortify_add_kunit_error(int write);
-#define kunit_fortify_panic(func, write, retfail)			\
+#define kunit_fortify_panic(func, write, avail, size, retfail)		\
 	do {								\
-		__fortify_report(fortify_reason(func, write));		\
+		__fortify_report(fortify_reason(func, write), avail, size); \
 		fortify_add_kunit_error(write);				\
 		return (retfail);					\
 	} while (0)
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 5bb65f623e40..cc15a25556fb 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -1023,7 +1023,7 @@ EXPORT_SYMBOL(__read_overflow2_field);
 void __write_overflow_field(size_t avail, size_t wanted) { }
 EXPORT_SYMBOL(__write_overflow_field);
 
-void __fortify_report(u8 reason)
+void __fortify_report(const u8 reason, const size_t avail, const size_t size)
 {
 	const char *name;
 	const bool write = !!(reason & 0x1);
@@ -1083,13 +1083,14 @@ void __fortify_report(u8 reason)
 	default:
 		name = "unknown";
 	}
-	WARN(1, "%s: detected buffer %s overflow\n", name, write ? "write" : "read");
+	WARN(1, "%s: detected buffer overflow: %zu byte %s buffer of size %zu\n",
+		 name, size, write ? "write to" : "read from", avail);
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

