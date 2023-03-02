Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D886A8C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCBW6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCBW6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:58:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D2023316
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:58:14 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id oj5so681661pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677797894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AT3F6PV/Pggg/CkzuWX5Xy+4BGT/l5C7re8M8RI6STk=;
        b=WcYaiUHogtvvYNPobepGTcABFaUKwYqs7PtuA3O0s99eVhoxKw+e6yPMb4lrUJQAQ2
         h3/8t+pP9XcgOfHM/ziGuo279IBul1oBHEwELjRlsyDFCSNpq6+4why3TWgZUcUt4p13
         FuAT8rb8fZFFnsF79+g91Ebhr05fbM++SWPMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677797894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AT3F6PV/Pggg/CkzuWX5Xy+4BGT/l5C7re8M8RI6STk=;
        b=P0JbEB8F11vlbkyJzwLgYSiUFZ9MqI5NDBFmd0y5UEV8PmWnwtOjBdw7Dcpgb2h8O4
         Iebg8fpftNuuGkGsM3/iuE001kMo5eEZ3XuIm3rrQ36HhVw7djYeSRtC2V8mJrj+PM6E
         c/gDukDvqqyUqXZbUGksTEGe4xqxvmvM4hHQ1cXn/e6vPAXCapPOz9YkqBoQ5RV1Szkt
         PD3bguKMqAkkkFyhuGX/d69gq4V3BmDPJ2QuXSe0ivW9D3nUjtUVHkgaQVockTuK3xuU
         9e+A3uUlXybOO6xAQaRbA4TmO8yRLKpKcihJxXU0C0PzscKMH83sdCThzi9CwgFEdfHx
         O74g==
X-Gm-Message-State: AO0yUKV/x4mWtuudgZABWe/pRVQQlpKj1LDMs4ipYHgxSiNgRoDkOpoo
        whoyXrci5466feiEE1VURSym9Q==
X-Google-Smtp-Source: AK7set+eZzBYjjLeJPRnnkBXL5zbbETqP1VL9/a5unevM1Y9ZpbPpDmtatFRsBuU+7GAcLy4ypSe8w==
X-Received: by 2002:a17:902:ab49:b0:19c:e440:924c with SMTP id ij9-20020a170902ab4900b0019ce440924cmr10982581plb.47.1677797894289;
        Thu, 02 Mar 2023 14:58:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ko4-20020a17090307c400b00186b7443082sm177869plb.195.2023.03.02.14.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:58:13 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Mark Brown <broonie@kernel.org>, Puyou Lu <puyou.lu@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] fortify: Improve buffer overflow reporting
Date:   Thu,  2 Mar 2023 14:58:12 -0800
Message-Id: <20230302225808.never.375-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8334; h=from:subject:message-id; bh=IGVxzF1sZURWAfeApQZ2Laffmf7md9cyyVm0jLNidck=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkASoEr1QDrSuZfP6wqZbNYxKDUWf4T4Z4ri/YeJX4 7doK2laJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZAEqBAAKCRCJcvTf3G3AJoMmD/ 96RcvDf478voeYk90+LxlC4QOu/rbWL40dpEjejqKezaHWFCYeqgf1cOGWFwNH4zrIBJGIaYCne0oc gZFyca/p2WyixlCUtRVm/1+sj8kRMWz3XcgBWJm8YrmWChzZ6F3yR4vHmlskREPNbQV5fvgKDsTrI+ ppKxiZkWk/5SLG99RZQTMD4zoMr8mJTPSjgHuejVJ1I5UUCehyH+dKGofdyjT9gGsJz8kuQhu0LrsM lwX4Dnazls6QfuqZ6KqRqfWgquOjzzSdIWbgTM7xOJ56fRUuQ1sAaTTnFNtYwmU6ceK7fuzqwvjSq2 /zUS7TVJ/PqGZDLgVHgPdjj5tWzFH/V7YnoolQEBJfDKlnmsuwlfbaF3tNpyV6RTosVpgL5gUdtSlz OosGQXu5Njl2vgRFxH8w2Vyo8ksotXcxyHJiCvwMYfKubi5Nh110Kw7BcDJuEasBllnXCtQKRz2ZcL +j5pFPv/2Mi6TGZW/8s4U3UVjV996E11/8Ru7IsGVLGEbBmasLev9myu7tAVG7p5V0yshQAfyEI+KO Jao+Lh21UkzhSoDqTqlqR/1WB9kHHWU25uUhBESMzLa75j9QszwAGQaT1uq9oQTbtljXMnJX5aDUb6 3oOzgW6eNmkEz15kLb2kRELTQ2xiZBkkL7poS2T6NQ3Itn6zW2qVnpPNiB2g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Tom Rix <trix@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Puyou Lu <puyou.lu@gmail.com>
Cc: linux-hardening@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 51 +++++++++++++++++++---------------
 lib/string_helpers.c           |  5 ++--
 2 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index c9de1f59ee80..981e2838f99a 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -9,7 +9,7 @@
 #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
 #define __RENAME(x) __asm__(#x)
 
-void fortify_panic(const char *name) __noreturn __cold;
+void fortify_panic(const char *name, bool dest, size_t avail, size_t len) __noreturn __cold;
 void __read_overflow(void) __compiletime_error("detected read beyond size of object (1st parameter)");
 void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
 void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("detected read beyond size of field (2nd parameter); maybe use struct_group()?");
@@ -147,7 +147,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, 1, p_size, size);
 	return __underlying_strncpy(p, q, size);
 }
 
@@ -170,11 +170,13 @@ __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
 char *strcat(char * const POS p, const char *q)
 {
 	size_t p_size = __member_size(p);
+	size_t size;
 
 	if (p_size == SIZE_MAX)
 		return __underlying_strcat(p, q);
-	if (strlcat(p, q, p_size) >= p_size)
-		fortify_panic(__func__);
+	size = strlcat(p, q, p_size);
+	if (p_size < size)
+		fortify_panic(__func__, 1, p_size, size);
 	return p;
 }
 
@@ -205,7 +207,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	/* Do not check characters beyond the end of p. */
 	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
-		fortify_panic(__func__);
+		fortify_panic(__func__, 1, p_size, ret);
 	return ret;
 }
 
@@ -241,7 +243,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 		return __underlying_strlen(p);
 	ret = strnlen(p, p_size);
 	if (p_size <= ret)
-		fortify_panic(__func__);
+		fortify_panic(__func__, 1, p_size, ret);
 	return ret;
 }
 
@@ -282,8 +284,8 @@ __FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, si
 			__write_overflow();
 	}
 	if (size) {
-		if (len >= p_size)
-			fortify_panic(__func__);
+		if (p_size < len)
+			fortify_panic(__func__, 1, p_size, len);
 		__underlying_memcpy(p, q, len);
 		p[len] = '\0';
 	}
@@ -361,7 +363,7 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	 * p_size.
 	 */
 	if (len > p_size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, 1, p_size, len);
 
 	/*
 	 * We can now safely call vanilla strscpy because we are protected from:
@@ -397,13 +399,15 @@ char *strncat(char * const POS p, const char * const POS q, __kernel_size_t coun
 	size_t p_len, copy_len;
 	size_t p_size = __member_size(p);
 	size_t q_size = __member_size(q);
+	size_t size;
 
 	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
 		return __underlying_strncat(p, q, count);
 	p_len = strlen(p);
 	copy_len = strnlen(q, count);
-	if (p_size < p_len + copy_len + 1)
-		fortify_panic(__func__);
+	size = p_len + copy_len + 1;
+	if (p_size < size)
+		fortify_panic(__func__, 1, p_size, size);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[p_len + copy_len] = '\0';
 	return p;
@@ -444,7 +448,7 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic("memset");
+		fortify_panic("memset", 1, p_size, size);
 }
 
 #define __fortify_memset_chk(p, c, size, p_size, p_size_field) ({	\
@@ -542,9 +546,10 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 * (The SIZE_MAX test is to optimize away checks where the buffer
 	 * lengths are unknown.)
 	 */
-	if ((p_size != SIZE_MAX && p_size < size) ||
-	    (q_size != SIZE_MAX && q_size < size))
-		fortify_panic(func);
+	if (p_size != SIZE_MAX && p_size < size)
+		fortify_panic(func, 1, p_size, size);
+	if (q_size != SIZE_MAX && q_size < size)
+		fortify_panic(func, 0, q_size, size);
 
 	/*
 	 * Warn when writing beyond destination field size.
@@ -644,7 +649,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, 1, p_size, size);
 	return __real_memscan(p, c, size);
 }
 
@@ -660,8 +665,10 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 		if (__compiletime_lessthan(q_size, size))
 			__read_overflow2();
 	}
-	if (p_size < size || q_size < size)
-		fortify_panic(__func__);
+	if (p_size < size)
+		fortify_panic(__func__, 1, p_size, size);
+	if (q_size < size)
+		fortify_panic(__func__, 0, q_size, size);
 	return __underlying_memcmp(p, q, size);
 }
 
@@ -673,7 +680,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, 1, p_size, size);
 	return __underlying_memchr(p, c, size);
 }
 
@@ -685,7 +692,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, 1, p_size, size);
 	return __real_memchr_inv(p, c, size);
 }
 
@@ -698,7 +705,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, 1, p_size, size);
 	return __real_kmemdup(p, size, gfp);
 }
 
@@ -735,7 +742,7 @@ char *strcpy(char * const POS p, const char * const POS q)
 		__write_overflow();
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, 1, p_size, size);
 	__underlying_memcpy(p, q, size);
 	return p;
 }
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 230020a2e076..b2d3e1d3931e 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -1021,9 +1021,10 @@ EXPORT_SYMBOL(__read_overflow2_field);
 void __write_overflow_field(size_t avail, size_t wanted) { }
 EXPORT_SYMBOL(__write_overflow_field);
 
-void fortify_panic(const char *name)
+void fortify_panic(const char *name, bool dest, size_t avail, size_t len)
 {
-	pr_emerg("detected buffer overflow in %s\n", name);
+	pr_emerg("%s: detected buffer overflow: %zu byte %s buffer of size %zu\n",
+		 name, len, dest ? "write to" : "read from", avail);
 	BUG();
 }
 EXPORT_SYMBOL(fortify_panic);
-- 
2.34.1

