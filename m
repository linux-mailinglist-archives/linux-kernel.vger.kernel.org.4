Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0163E6DB432
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjDGT1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjDGT1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:27:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75E8BDE6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:27:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o2so40742592plg.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680895643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IE1lV//2EfqWsi9rLXlIKGjTg7Y0JuJqreF8rxNmIp4=;
        b=OOfNhwt6AsOblyX4fTnJE+f4Xyodt1R+TLbdPGarUv8okjXb48BsDQyUk5d1Gcztz2
         ewYv2DoGs5wuUfeWktV9+Xy4iQ8LncTDCAb/OgecOs00yI0YhnmX3rvBJpqZKHmSehxz
         kdnMnsN73C+olRzp00BkITWcSF8d51iFqQmEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680895643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IE1lV//2EfqWsi9rLXlIKGjTg7Y0JuJqreF8rxNmIp4=;
        b=pn0xUV8ajUE6nR1DSABQLgn23veA3CM4R5fdW5I40Red5DLBRnY1MUWK8w8/akidsx
         TTOmBO4NR3+vAi4Ip/oVRHj2djUBFt8VcNPWCicZBQ1BiFPnLPCH0EZyRNO/YZJHv/M+
         5mUQy3zEhwDzFU4zfoAtTo4v6nCZTbuLh2HCjAasoNZUyWtuHhJj9FaVfYEDSCQytuLa
         6QmozbX9ms0lT82u90xe97qA7Wjo14sIBvcfpbbtgn+lSYO36A0LHarXvMdl7i3t0Pkn
         mF35gssUrL7ostv8u0PZFqTMwkVGf7rLOnBp1ngXCkKiTtqhYVfm3JhDD+KuUSLAyOrC
         PTdg==
X-Gm-Message-State: AAQBX9fbfjae6We70RFJFzt2CS7ZPJ+DhDufVpcKH9lPoZLYYgmJiygd
        DDir1QshIFNZSfX+3mw6UTHi3w==
X-Google-Smtp-Source: AKy350Y8tK+4qjwpRid2j2VP+PTbuYk42t0iNn6m4EZ1LuWnOk0Mh/hGGVmVsSBReXdPypJ4zrBmLw==
X-Received: by 2002:a17:902:d4d1:b0:19b:dbf7:f9ca with SMTP id o17-20020a170902d4d100b0019bdbf7f9camr4797649plg.0.1680895643303;
        Fri, 07 Apr 2023 12:27:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709026b4200b0019719f752c5sm3263818plt.59.2023.04.07.12.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:27:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
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
Subject: [PATCH v2 07/10] fortify: Split reporting and avoid passing string pointer
Date:   Fri,  7 Apr 2023 12:27:13 -0700
Message-Id: <20230407192717.636137-7-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407191904.gonna.522-kees@kernel.org>
References: <20230407191904.gonna.522-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12362; h=from:subject; bh=sIh1INkht7p4hil8+5qOLn0KsawQtkhw8ZTi8OxES9I=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkMG6TvuhHN7ddESKLwQhLG234Xp2FKpVi6+bCo4HY hNdQXhyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZDBukwAKCRCJcvTf3G3AJqMsD/ 4mrCtL556ZnBnBU+YpwWR4tdcwrFVN9VBaaHQ3ysRpnNzhcIKrirTf8F+bKgVXz7VdnQPQP4kPptqW oqgNJ8gLU8++PL4Jk+ztEKkKNbtSJi4D8wEK5kuFO70FcRsAjdNZlA9JMXpNEcRJtqRQlW1VU/61bX jhQ8yorXFzUYWduR/ZCRf2JlkgxzbtTWRHl0SD1dKWVr0cttG9i6ebNtGV/S6Fi8JhcT3j3nbFbWym 5xH+Q5Lu8vMc9QMdyNXP0wlTqvyUjPV8E2Ti4ZQYeY1W0HKAr/CBZcvD0/jU0u2yQcyuNZaHRE7wpS bicH4vXHlMb2SOZ9kUxh3EZU6RKJYDJLPM+t1pkBoKSI3mtpAJZn+b+2bgCdF0bRhQUTJH5xIGS4Yb lY70PRnz8ikHpcPJxt0azyFIolFkxx1dy7AvNVjdVdCgHG8O/7qKy3pan7EUy0G4/fADU534RwiCM1 XxzZ+UJwZ3BWPKVusr7jaThCQK+hQt7tYVVPLrXiExuqhRnTiHDNKHaSnpz7pXPlkNj+GaH6XQa1rE mkZC3kIyBDj3aV2k0F6gitpHkeB5RCwuRsMWDxSUcxcKCehcK50fziE5z7/13caNJaY+F11x7Ce8dy zdkF70ln9BtrthYbWI1G3YuX1DsUdE0SZd+5FbcoIRusX2h4vkNlZfBQ0YDQ==
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
access failure (read or write overflow) into a single u8 argument. This
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
 arch/arm/boot/compressed/misc.c |  2 +-
 arch/x86/boot/compressed/misc.c |  2 +-
 include/linux/fortify-string.h  | 84 ++++++++++++++++++++++++---------
 lib/string_helpers.c            | 23 +++++++--
 tools/objtool/check.c           |  2 +-
 5 files changed, 85 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index abfed1aa2baa..f31e2c949089 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -160,7 +160,7 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 		putstr(" done, booting the kernel.\n");
 }
 
-void fortify_panic(const char *name)
+void __fortify_panic(const u8 reason)
 {
 	error("detected buffer overflow");
 }
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 014ff222bf4b..aa45e7529a40 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -470,7 +470,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	return output + entry_offset;
 }
 
-void fortify_panic(const char *name)
+void __fortify_panic(const u8 reason)
 {
 	error("detected buffer overflow");
 }
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index ab058d092817..19906b45fb98 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_FORTIFY_STRING_H_
 #define _LINUX_FORTIFY_STRING_H_
 
+#include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/const.h>
 #include <linux/limits.h>
@@ -9,7 +10,45 @@
 #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
 #define __RENAME(x) __asm__(#x)
 
-void fortify_panic(const char *name) __noreturn __cold;
+#define FORTIFY_REASON_DIR(r)		FIELD_GET(BIT(0), r)
+#define FORTIFY_REASON_FUNC(r)		FIELD_GET(GENMASK(7, 1), r)
+#define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
+					 FIELD_PREP(GENMASK(7, 1), func))
+
+#define fortify_panic(func, write)	\
+	__fortify_panic(FORTIFY_REASON(func, write))
+
+#define FORTIFY_READ		 0
+#define FORTIFY_WRITE		 1
+
+#define EACH_FORTIFY_FUNC(macro)	\
+	macro(strncpy),			\
+	macro(strnlen),			\
+	macro(strlen),			\
+	macro(strlcpy),			\
+	macro(strscpy),			\
+	macro(strlcat),			\
+	macro(strcat),			\
+	macro(strncat),			\
+	macro(memset),			\
+	macro(memcpy),			\
+	macro(memmove),			\
+	macro(memscan),			\
+	macro(memcmp),			\
+	macro(memchr),			\
+	macro(memchr_inv),		\
+	macro(kmemdup),			\
+	macro(strcpy),			\
+	macro(UNKNOWN),
+
+#define MAKE_FORTIFY_FUNC(func)	FORTIFY_FUNC_##func
+
+enum fortify_func {
+	EACH_FORTIFY_FUNC(MAKE_FORTIFY_FUNC)
+};
+
+void __fortify_report(const u8 reason);
+void __fortify_panic(const u8 reason) __cold __noreturn;
 void __read_overflow(void) __compiletime_error("detected read beyond size of object (1st parameter)");
 void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
 void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("detected read beyond size of field (2nd parameter); maybe use struct_group()?");
@@ -147,7 +186,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE);
 	return __underlying_strncpy(p, q, size);
 }
 
@@ -178,7 +217,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	/* Do not check characters beyond the end of p. */
 	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ);
 	return ret;
 }
 
@@ -214,7 +253,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 		return __underlying_strlen(p);
 	ret = strnlen(p, p_size);
 	if (p_size <= ret)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ);
 	return ret;
 }
 
@@ -256,7 +295,7 @@ __FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, si
 	}
 	if (size) {
 		if (len >= p_size)
-			fortify_panic(__func__);
+			fortify_panic(FORTIFY_FUNC_strlcpy, FORTIFY_WRITE);
 		__underlying_memcpy(p, q, len);
 		p[len] = '\0';
 	}
@@ -334,7 +373,7 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	 * p_size.
 	 */
 	if (len > p_size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE);
 
 	/*
 	 * We can now safely call vanilla strscpy because we are protected from:
@@ -392,7 +431,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if string is already overflowed. */
 	if (p_size <= p_len)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ);
 
 	if (actual >= avail) {
 		copy_len = avail - p_len - 1;
@@ -401,7 +440,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if copy will overflow. */
 	if (p_size <= actual)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[actual] = '\0';
 
@@ -430,7 +469,7 @@ char *strcat(char * const POS p, const char *q)
 	const size_t p_size = __member_size(p);
 
 	if (strlcat(p, q, p_size) >= p_size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE);
 	return p;
 }
 
@@ -466,7 +505,7 @@ char *strncat(char * const POS p, const char * const POS q, __kernel_size_t coun
 	p_len = strlen(p);
 	copy_len = strnlen(q, count);
 	if (p_size < p_len + copy_len + 1)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strncat, FORTIFY_WRITE);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[p_len + copy_len] = '\0';
 	return p;
@@ -507,7 +546,7 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic("memset");
+		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE);
 }
 
 #define __fortify_memset_chk(p, c, size, p_size, p_size_field) ({	\
@@ -561,7 +600,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 					 const size_t q_size,
 					 const size_t p_size_field,
 					 const size_t q_size_field,
-					 const char *func)
+					 const u8 func)
 {
 	if (__builtin_constant_p(size)) {
 		/*
@@ -605,9 +644,10 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
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
@@ -640,7 +680,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	const size_t __q_size_field = (q_size_field);			\
 	WARN_ONCE(fortify_memcpy_chk(__fortify_size, __p_size,		\
 				     __q_size, __p_size_field,		\
-				     __q_size_field, #op),		\
+				     __q_size_field, FORTIFY_FUNC_ ##op), \
 		  #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
 		  __fortify_size,					\
 		  "field \"" #p "\" at " __FILE__ ":" __stringify(__LINE__), \
@@ -707,7 +747,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ);
 	return __real_memscan(p, c, size);
 }
 
@@ -724,7 +764,7 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 			__read_overflow2();
 	}
 	if (p_size < size || q_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ);
 	return __underlying_memcmp(p, q, size);
 }
 
@@ -736,7 +776,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ);
 	return __underlying_memchr(p, c, size);
 }
 
@@ -748,7 +788,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ);
 	return __real_memchr_inv(p, c, size);
 }
 
@@ -761,7 +801,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ);
 	return __real_kmemdup(p, size, gfp);
 }
 
@@ -798,7 +838,7 @@ char *strcpy(char * const POS p, const char * const POS q)
 		__write_overflow();
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE);
 	__underlying_memcpy(p, q, size);
 	return p;
 }
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 230020a2e076..96d502e1e578 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -1021,10 +1021,27 @@ EXPORT_SYMBOL(__read_overflow2_field);
 void __write_overflow_field(size_t avail, size_t wanted) { }
 EXPORT_SYMBOL(__write_overflow_field);
 
-void fortify_panic(const char *name)
+#define MAKE_FORTIFY_FUNC_NAME(func)	[MAKE_FORTIFY_FUNC(func)] = #func
+
+static const char * const fortify_func_name[] = {
+	EACH_FORTIFY_FUNC(MAKE_FORTIFY_FUNC_NAME)
+};
+
+void __fortify_report(const u8 reason)
+{
+	const u8 func = FORTIFY_REASON_FUNC(reason);
+	const bool write = FORTIFY_REASON_DIR(reason);
+	const char *name;
+
+	name = fortify_func_name[min_t(u8, func, FORTIFY_FUNC_UNKNOWN)];
+	WARN(1, "%s: detected buffer %s overflow\n", name, str_read_write(!write));
+}
+EXPORT_SYMBOL(__fortify_report);
+
+void __fortify_panic(const u8 reason)
 {
-	pr_emerg("detected buffer overflow in %s\n", name);
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

