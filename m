Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444BF6D8B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjDFACi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDFACV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:02:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F467684
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:02:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id kc4so35936855plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 17:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680739339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVeZITSFOSVosu4yNU0kSm2zQr6awWpiVL1awBqfF1Y=;
        b=B/TOjH/gJOJvYf37Vu/+Cs/gN7vffw64dSKGAky15XutUioGX5f8rLUB9TzZ4m3Ufj
         XexxluTFeBPrRAqfB7h5gMNZIl95Kgy77dUpp5Yk913Cx8biwmbNpK95u1Xufd4OlsLU
         +cxukVTpxvXiAZJx8YEOP64dJ5NbP/bw2zVcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVeZITSFOSVosu4yNU0kSm2zQr6awWpiVL1awBqfF1Y=;
        b=K8ZHfLECl2wCY68PFaTT1jG5VsT2uQtl3bNUQ02/ApY+/Ig4lTY5bfGonNWuW2iRRL
         LsoG5xC4z1CWAr375MTAwIWvuaWDjHaeImCXPSLtpRkCfaW/nskoNFFwaXzCJM3LpKOs
         Qinu/e9EVpF2ZmiIA1i1xPDpKLhYK4PiGgLxK8wv0foMMTJFl7AbSPTsB57UdE37QbT6
         tb/8D/kWqKYG104Vs9Y0+QRRJWD7iXGPGtfu4bufpLWtE9B14rfTu/w22WUO9vHmOtVo
         P6wNpIVVjJn58qsr7OFo44fq/zHKKxLMMnaj1a8DfldPlLJNx9FzncGjksrOdatM49pM
         Ubbg==
X-Gm-Message-State: AAQBX9fDsOnbXZQpPkAuFw8sKB0oU6vnuQfKJCHZKtJk3bj0OGEQaE0G
        sKngiP3xBb3cyBfvOXiqVdyGIw==
X-Google-Smtp-Source: AKy350Zu4aYpBrViFItjynucrhtslV0Npr6rpnlclbLBmZBOoQobu3mUEtgBTTXVCYiPsCQfgeXZIg==
X-Received: by 2002:a17:902:f544:b0:1a1:b8cc:59da with SMTP id h4-20020a170902f54400b001a1b8cc59damr9433799plf.33.1680739338883;
        Wed, 05 Apr 2023 17:02:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y4-20020a1709027c8400b001a04d37a4acsm106056pll.9.2023.04.05.17.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 17:02:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
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
Subject: [PATCH 6/9] fortify: Split reporting and avoid passing string pointer
Date:   Wed,  5 Apr 2023 17:02:05 -0700
Message-Id: <20230406000212.3442647-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405235832.never.487-kees@kernel.org>
References: <20230405235832.never.487-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11820; h=from:subject; bh=unK9/F7S4FUxqEzGNDbeCYLXq18RsKeeVFU9xRkUXsI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkLgv/Wwi9CD4BEpJoI75TveBPXRcut2QdfsP7sq0t vflFcsmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZC4L/wAKCRCJcvTf3G3AJhDAD/ 9+VFjHhYUtmkAtvm/ml4DQSaa6P/0Y+N6+4FhTbbGHVKigx+qRFJV4RRq6kasXh3ZzA8EHhUq7fbTp Iec2D1Nlyex5HIwNr+118srvlS2SZUOnEQxpyu9IBzmPdX7fMiwJ38qypqUkcuRNwapFb7Ppy4nCyX 0o+0bqQRv3cX5txcZXrJL0lNw6xn4Ci142qhSQNAhJ8Fuu3ITrrXSVtxDc53J42BoBpEYGEz4f9klT s4kjKEbhdcefB3fkY1S6s/b7pfcbGDzQYoWyERPI7u3dMGVW7Tw7qn/yeDbX0uJPpXAztjQdFlKwln wm2twRnu5aSFU082MWwjMvy+5Ld7f8ZJmsUfYGTTSbft17ac4Qi+Gqy0gyOkktm57sNpZ/tlGauNzG TkFSzIFmnpQyyM4aRjRHpPF7LgCdoC6shVaF1JkTuqUhJrJMjYtKPAB2QcDm86lXypAl9TWjyj8/tO 8r8a9Ob782ODDAiOlGHlrHzQV0/UxbDRz1hlOpiwsqew89XDt2D6w0eEdd1Bq5MHXBWWjBnc7n7roV v+aD1CE5viiZHAWgjCsRQYHTFDvkxBRblO5zW7VcsnkimaRSd8/g8f9kSqUXnm/ScbKAS6RVcPzhRG R81/JwTKZanUtzfC5kSl/oR43vWw9l9GoMc9K5LmNzgGs4FM2hVXxrcTbV8w==
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

In preparation for KUnit testing and further improvements in fortify
failure reporting, split out the report and encode the function and
access failure (read or write overflow) into a single int argument. This
mainly ends up saving some space in the data segment. For a defconfig
with FORTIFY_SOURCE enabled:

$ size gcc/vmlinux.before gcc/vmlinux.after
   text  	  data     bss     dec    	    hex filename
26132309        9760658 2195460 38088427        2452eeb gcc/vmlinux.before
26132386        9748382 2195460 38076228        244ff44 gcc/vmlinux.after

Cc: Andy Shevchenko <andy@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Puyou Lu <puyou.lu@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 72 +++++++++++++++++++++++-----------
 lib/string_helpers.c           | 70 +++++++++++++++++++++++++++++++--
 tools/objtool/check.c          |  2 +-
 3 files changed, 118 insertions(+), 26 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 41dbd641f55c..6db4052db459 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -9,7 +9,34 @@
 #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
 #define __RENAME(x) __asm__(#x)
 
-void fortify_panic(const char *name) __noreturn __cold;
+#define fortify_reason(func, write)	(((func) << 1) | !!(write))
+
+#define fortify_panic(func, write)	\
+	__fortify_panic(fortify_reason(func, write))
+
+#define FORTIFY_READ		 0
+#define FORTIFY_WRITE		 1
+
+#define FORTIFY_FUNC_strncpy	 0
+#define FORTIFY_FUNC_strnlen	 1
+#define FORTIFY_FUNC_strlen	 2
+#define FORTIFY_FUNC_strlcpy	 3
+#define FORTIFY_FUNC_strscpy	 4
+#define FORTIFY_FUNC_strlcat	 5
+#define FORTIFY_FUNC_strcat	 6
+#define FORTIFY_FUNC_strncat	 7
+#define FORTIFY_FUNC_memset	 8
+#define FORTIFY_FUNC_memcpy	 9
+#define FORTIFY_FUNC_memmove	10
+#define FORTIFY_FUNC_memscan	11
+#define FORTIFY_FUNC_memcmp	12
+#define FORTIFY_FUNC_memchr	13
+#define FORTIFY_FUNC_memchr_inv	14
+#define FORTIFY_FUNC_kmemdup	15
+#define FORTIFY_FUNC_strcpy	16
+
+void __fortify_report(u8 reason);
+void __fortify_panic(u8 reason) __cold __noreturn;
 void __read_overflow(void) __compiletime_error("detected read beyond size of object (1st parameter)");
 void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
 void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("detected read beyond size of field (2nd parameter); maybe use struct_group()?");
@@ -147,7 +174,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE);
 	return __underlying_strncpy(p, q, size);
 }
 
@@ -178,7 +205,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	/* Do not check characters beyond the end of p. */
 	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ);
 	return ret;
 }
 
@@ -214,7 +241,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 		return __underlying_strlen(p);
 	ret = strnlen(p, p_size);
 	if (p_size <= ret)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ);
 	return ret;
 }
 
@@ -256,7 +283,7 @@ __FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, si
 	}
 	if (size) {
 		if (len >= p_size)
-			fortify_panic(__func__);
+			fortify_panic(FORTIFY_FUNC_strlcpy, FORTIFY_WRITE);
 		__underlying_memcpy(p, q, len);
 		p[len] = '\0';
 	}
@@ -334,7 +361,7 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	 * p_size.
 	 */
 	if (len > p_size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE);
 
 	/*
 	 * We can now safely call vanilla strscpy because we are protected from:
@@ -392,7 +419,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if string is already overflowed. */
 	if (p_size <= p_len)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ);
 
 	if (actual >= avail) {
 		copy_len = avail - p_len - 1;
@@ -401,7 +428,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if copy will overflow. */
 	if (p_size <= actual)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[actual] = '\0';
 
@@ -430,7 +457,7 @@ char *strcat(char * const POS p, const char *q)
 	size_t p_size = __member_size(p);
 
 	if (strlcat(p, q, p_size) >= p_size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE);
 	return p;
 }
 
@@ -466,7 +493,7 @@ char *strncat(char * const POS p, const char * const POS q, __kernel_size_t coun
 	p_len = strlen(p);
 	copy_len = strnlen(q, count);
 	if (p_size < p_len + copy_len + 1)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strncat, FORTIFY_WRITE);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[p_len + copy_len] = '\0';
 	return p;
@@ -507,7 +534,7 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic("memset");
+		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE);
 }
 
 #define __fortify_memset_chk(p, c, size, p_size, p_size_field) ({	\
@@ -561,7 +588,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 					 const size_t q_size,
 					 const size_t p_size_field,
 					 const size_t q_size_field,
-					 const char *func)
+					 const u8 func)
 {
 	if (__builtin_constant_p(size)) {
 		/*
@@ -605,9 +632,10 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 * (The SIZE_MAX test is to optimize away checks where the buffer
 	 * lengths are unknown.)
 	 */
-	if ((p_size != SIZE_MAX && p_size < size) ||
-	    (q_size != SIZE_MAX && q_size < size))
-		fortify_panic(func);
+	if (p_size != SIZE_MAX && p_size < size)
+		fortify_panic(func, FORTIFY_WRITE);
+	else if (q_size != SIZE_MAX && q_size < size)
+		fortify_panic(func, FORTIFY_READ);
 
 	/*
 	 * Warn when writing beyond destination field size.
@@ -640,7 +668,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	const size_t __q_size_field = (q_size_field);			\
 	WARN_ONCE(fortify_memcpy_chk(__fortify_size, __p_size,		\
 				     __q_size, __p_size_field,		\
-				     __q_size_field, #op),		\
+				     __q_size_field, FORTIFY_FUNC_ ##op), \
 		  #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
 		  __fortify_size,					\
 		  "field \"" #p "\" at " __FILE__ ":" __stringify(__LINE__), \
@@ -707,7 +735,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ);
 	return __real_memscan(p, c, size);
 }
 
@@ -724,7 +752,7 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 			__read_overflow2();
 	}
 	if (p_size < size || q_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ);
 	return __underlying_memcmp(p, q, size);
 }
 
@@ -736,7 +764,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ);
 	return __underlying_memchr(p, c, size);
 }
 
@@ -748,7 +776,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ);
 	return __real_memchr_inv(p, c, size);
 }
 
@@ -761,7 +789,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ);
 	return __real_kmemdup(p, size, gfp);
 }
 
@@ -798,7 +826,7 @@ char *strcpy(char * const POS p, const char * const POS q)
 		__write_overflow();
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE);
 	__underlying_memcpy(p, q, size);
 	return p;
 }
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 230020a2e076..631c50657096 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -1021,10 +1021,74 @@ EXPORT_SYMBOL(__read_overflow2_field);
 void __write_overflow_field(size_t avail, size_t wanted) { }
 EXPORT_SYMBOL(__write_overflow_field);
 
-void fortify_panic(const char *name)
+void __fortify_report(u8 reason)
 {
-	pr_emerg("detected buffer overflow in %s\n", name);
+	const char *name;
+	const bool write = !!(reason & 0x1);
+
+	switch (reason >> 1) {
+	case FORTIFY_FUNC_strncpy:
+		name = "strncpy";
+		break;
+	case FORTIFY_FUNC_strnlen:
+		name = "strnlen";
+		break;
+	case FORTIFY_FUNC_strlen:
+		name = "strlen";
+		break;
+	case FORTIFY_FUNC_strlcpy:
+		name = "strlcpy";
+		break;
+	case FORTIFY_FUNC_strscpy:
+		name = "strscpy";
+		break;
+	case FORTIFY_FUNC_strlcat:
+		name = "strlcat";
+		break;
+	case FORTIFY_FUNC_strcat:
+		name = "strcat";
+		break;
+	case FORTIFY_FUNC_strncat:
+		name = "strncat";
+		break;
+	case FORTIFY_FUNC_memset:
+		name = "memset";
+		break;
+	case FORTIFY_FUNC_memcpy:
+		name = "memcpy";
+		break;
+	case FORTIFY_FUNC_memmove:
+		name = "memmove";
+		break;
+	case FORTIFY_FUNC_memscan:
+		name = "memscan";
+		break;
+	case FORTIFY_FUNC_memcmp:
+		name = "memcmp";
+		break;
+	case FORTIFY_FUNC_memchr:
+		name = "memchr";
+		break;
+	case FORTIFY_FUNC_memchr_inv:
+		name = "memchr_inv";
+		break;
+	case FORTIFY_FUNC_kmemdup:
+		name = "kmemdup";
+		break;
+	case FORTIFY_FUNC_strcpy:
+		name = "strcpy";
+		break;
+	default:
+		name = "unknown";
+	}
+	WARN(1, "%s: detected buffer %s overflow\n", name, write ? "write" : "read");
+}
+EXPORT_SYMBOL(__fortify_report);
+
+void __fortify_panic(const u8 reason)
+{
+	__fortify_report(reason);
 	BUG();
 }
-EXPORT_SYMBOL(fortify_panic);
+EXPORT_SYMBOL(__fortify_panic);
 #endif /* CONFIG_FORTIFY_SOURCE */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f937be1afe65..2d0a67ce1c51 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -197,6 +197,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	 * attribute isn't provided in ELF data. Keep 'em sorted.
 	 */
 	static const char * const global_noreturns[] = {
+		"__fortify_panic",
 		"__invalid_creds",
 		"__module_put_and_kthread_exit",
 		"__reiserfs_panic",
@@ -208,7 +209,6 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"do_group_exit",
 		"do_task_dead",
 		"ex_handler_msr_mce",
-		"fortify_panic",
 		"kthread_complete_and_exit",
 		"kthread_exit",
 		"kunit_try_catch_throw",
-- 
2.34.1

