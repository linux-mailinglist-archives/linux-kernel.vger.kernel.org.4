Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506995BED8E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiITTW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiITTWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:22:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895C128E26
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:22:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c24so3404967plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=b7FvkRf/XameI3tAxI0qKDnPDgul0cfpqZiW5Ih+TfY=;
        b=G0yzd3YQmRHSm8hygGaJN23uIfHcIPVonGOjkqyNWhgM4CENWufgxK3rc2ksXWFaq5
         W1pvS4BzvsxlUiZWzbHjFUgvT7hopNCjL7/IfebtaUkJyqFyjRtP+IPnqn4y0na+dKs7
         J0wWa6WM4Qv2DbhPAozS3qg50xwRRqP+oeG5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b7FvkRf/XameI3tAxI0qKDnPDgul0cfpqZiW5Ih+TfY=;
        b=b33tmwrHaxGL9R11PWf73rqkgnLTEsc6TMxNAT31EJRZd59cRmF0K+zwrXGQbTBPjw
         M0DbItsH+ARKxTSpkqBvDvqbfr045ntBW9tOtMy73QMzhdKMe1+cO3h1YiYfnhGQ8Vt9
         1TumnySpn9gIWodFm8x0JSiFZ/FkN1ua+pUQ2JtiZIExRzVpfmxKHcQZBslRD7iFGTPQ
         jHMFXwbxSw/Luqivdf1tpBvNQ+KU2kap3xjQatZOJmA0U2axdd/S/X3LMGAf8WU3wxS0
         cKM25Eb+aX/Txz6hLbh9KsGYPZdZzPIPWQzRTjn/h41MDBRkEhCOBbbNbSf4NAQffZIW
         oPxA==
X-Gm-Message-State: ACrzQf3Awow2vgz+3MCozyWLarpIDhJuc8oWWBxMT2roActHC6x72rbp
        4Xjnyzy5cdNHGNqXsKjP0zPs1w==
X-Google-Smtp-Source: AMsMyM4MlWS2VfZxaUxG/J/yjFdlpSdd1ttEqoJXydSzcYurOBNsEyN3/lJvRpJhe6BzL1xIb54Ykg==
X-Received: by 2002:a17:902:dac7:b0:178:b5e0:3627 with SMTP id q7-20020a170902dac700b00178b5e03627mr1050536plx.147.1663701732000;
        Tue, 20 Sep 2022 12:22:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902ceca00b0017732e4003bsm262226plg.141.2022.09.20.12.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:22:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] fortify: Convert to struct vs member helpers
Date:   Tue, 20 Sep 2022 12:22:01 -0700
Message-Id: <20220920192202.190793-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920192202.190793-1-keescook@chromium.org>
References: <20220920192202.190793-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9864; h=from:subject; bh=BqQbiGaquIsbcMOqf8A6fSRC6Vfu8ZKyxxnc+qe3hgU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjKhLZ0Oxez6IX/gcUwsIFv3+tMCVKvwgPQj27qPt8 VXbpHlqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYyoS2QAKCRCJcvTf3G3AJkDdD/ 4q2zvDS9l/L4s2sAzrxtBwCZUnHjkBHzcdbXLIMLWrIepT/FQAM3Kk2z7w84mjlNBeiW0infuj23MH o1u1RPvNkHf9A/+vRJfGs21mJA+0+Fav4YMboXMqbp1hpIx9YxW9JJ7dJrkRGNpfLXY8n8t3jCRi7n FEUyBKp81hcgHgWxILxQ8mIqLf75AZxwCUyrTAcu8LyNbCR9O+buVloQ8tKdiGsET+3CYTF5KbLYhb PJeWtRKVBFO8QAOIWoWwkdCTn0mgfIKMzevZ3SZd7vuIF28ExS9VX9Oh+BSrYWN5SKR2+5VFypcVyM ln6dH04dg2abuCq7Dvft9pCN2OjVZZjmMU3qoVx69WaD4hViFuGBRXfS+PUAUtWOHwNPlrHkedlukV KkHl1OLS0ueDpoNZ2MkiKtuKGyxPs3lwC06Tp/uPgdzmCJbdwQzzS2MoZx3bXLRcfvr7jhUJmtSrD0 CpwYhQzocUF7Qz0exEUjIgOZwzkx/BgRoMxGD8aftpAzOCjXb95k3wQJDgSIspogue2cLDWwg1EP28 o9opm3tYeLVcIM89XXxu1rGM0jA8ZkfQAdK3ZFmCaB93ai7/BZOAdlB+ElB/7qtXaUgLZpaKmV0XBj wSrPBqjrKEijV2hEVqi7xjlhTwUdHp9HrHTrE7G1vvC0P0Q3TTyMo/sDet/A==
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

In preparation for adding support for __builtin_dynamic_object_size(),
wrap each instance of __builtin_object_size(p, N) with either the new
__struct_size(p) as __bos(p, 0), or __member_size(p) as __bos(p, 1).
This will allow us to replace the definitions with __bdos() next.
There are no binary differences from this change.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 68 +++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 71c0a432c638..3f1178584d7b 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -20,7 +20,7 @@ void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("
 ({								\
 	unsigned char *__p = (unsigned char *)(p);		\
 	size_t __ret = SIZE_MAX;				\
-	size_t __p_size = __builtin_object_size(p, 1);		\
+	size_t __p_size = __member_size(p);			\
 	if (__p_size != SIZE_MAX &&				\
 	    __builtin_constant_p(*__p)) {			\
 		size_t __p_len = __p_size - 1;			\
@@ -72,13 +72,15 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 	__underlying_memcpy(dst, src, bytes)
 
 /*
- * Clang's use of __builtin_object_size() within inlines needs hinting via
- * __pass_object_size(). The preference is to only ever use type 1 (member
+ * Clang's use of __builtin_*object_size() within inlines needs hinting via
+ * __pass_*object_size(). The preference is to only ever use type 1 (member
  * size, rather than struct size), but there remain some stragglers using
  * type 0 that will be converted in the future.
  */
-#define POS	__pass_object_size(1)
-#define POS0	__pass_object_size(0)
+#define POS			__pass_object_size(1)
+#define POS0			__pass_object_size(0)
+#define __struct_size(p)	__builtin_object_size(p, 0)
+#define __member_size(p)	__builtin_object_size(p, 1)
 
 #define __compiletime_lessthan(bounds, length)	(	\
 	__builtin_constant_p(length) &&			\
@@ -121,7 +123,7 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 __FORTIFY_INLINE __diagnose_as(__builtin_strncpy, 1, 2, 3)
 char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 {
-	size_t p_size = __builtin_object_size(p, 1);
+	size_t p_size = __member_size(p);
 
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
@@ -133,7 +135,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
 char *strcat(char * const POS p, const char *q)
 {
-	size_t p_size = __builtin_object_size(p, 1);
+	size_t p_size = __member_size(p);
 
 	if (p_size == SIZE_MAX)
 		return __underlying_strcat(p, q);
@@ -145,7 +147,7 @@ char *strcat(char * const POS p, const char *q)
 extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
 __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size_t maxlen)
 {
-	size_t p_size = __builtin_object_size(p, 1);
+	size_t p_size = __member_size(p);
 	size_t p_len = __compiletime_strlen(p);
 	size_t ret;
 
@@ -175,7 +177,7 @@ __FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
 __kernel_size_t __fortify_strlen(const char * const POS p)
 {
 	__kernel_size_t ret;
-	size_t p_size = __builtin_object_size(p, 1);
+	size_t p_size = __member_size(p);
 
 	/* Give up if we don't know how large p is. */
 	if (p_size == SIZE_MAX)
@@ -190,8 +192,8 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
 __FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, size_t size)
 {
-	size_t p_size = __builtin_object_size(p, 1);
-	size_t q_size = __builtin_object_size(q, 1);
+	size_t p_size = __member_size(p);
+	size_t q_size = __member_size(q);
 	size_t q_len;	/* Full count of source string length. */
 	size_t len;	/* Count of characters going into destination. */
 
@@ -219,8 +221,8 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 {
 	size_t len;
 	/* Use string size rather than possible enclosing struct size. */
-	size_t p_size = __builtin_object_size(p, 1);
-	size_t q_size = __builtin_object_size(q, 1);
+	size_t p_size = __member_size(p);
+	size_t q_size = __member_size(q);
 
 	/* If we cannot get size of p and q default to call strscpy. */
 	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
@@ -265,8 +267,8 @@ __FORTIFY_INLINE __diagnose_as(__builtin_strncat, 1, 2, 3)
 char *strncat(char * const POS p, const char * const POS q, __kernel_size_t count)
 {
 	size_t p_len, copy_len;
-	size_t p_size = __builtin_object_size(p, 1);
-	size_t q_size = __builtin_object_size(q, 1);
+	size_t p_size = __member_size(p);
+	size_t q_size = __member_size(q);
 
 	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
 		return __underlying_strncat(p, q, count);
@@ -324,11 +326,11 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
 })
 
 /*
- * __builtin_object_size() must be captured here to avoid evaluating argument
- * side-effects further into the macro layers.
+ * __struct_size() vs __member_size() must be captured here to avoid
+ * evaluating argument side-effects further into the macro layers.
  */
 #define memset(p, c, s) __fortify_memset_chk(p, c, s,			\
-		__builtin_object_size(p, 0), __builtin_object_size(p, 1))
+		__struct_size(p), __member_size(p))
 
 /*
  * To make sure the compiler can enforce protection against buffer overflows,
@@ -421,7 +423,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 * fake flexible arrays, until they are all converted to
 	 * proper flexible arrays.
 	 *
-	 * The implementation of __builtin_object_size() behaves
+	 * The implementation of __builtin_*object_size() behaves
 	 * like sizeof() when not directly referencing a flexible
 	 * array member, which means there will be many bounds checks
 	 * that will appear at run-time, without a way for them to be
@@ -487,22 +489,22 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
  */
 
 /*
- * __builtin_object_size() must be captured here to avoid evaluating argument
- * side-effects further into the macro layers.
+ * __struct_size() vs __member_size() must be captured here to avoid
+ * evaluating argument side-effects further into the macro layers.
  */
 #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,			\
-		__builtin_object_size(p, 0), __builtin_object_size(q, 0), \
-		__builtin_object_size(p, 1), __builtin_object_size(q, 1), \
+		__struct_size(p), __struct_size(q),			\
+		__member_size(p), __member_size(q),			\
 		memcpy)
 #define memmove(p, q, s)  __fortify_memcpy_chk(p, q, s,			\
-		__builtin_object_size(p, 0), __builtin_object_size(q, 0), \
-		__builtin_object_size(p, 1), __builtin_object_size(q, 1), \
+		__struct_size(p), __struct_size(q),			\
+		__member_size(p), __member_size(q),			\
 		memmove)
 
 extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
 __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 {
-	size_t p_size = __builtin_object_size(p, 0);
+	size_t p_size = __struct_size(p);
 
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
@@ -514,8 +516,8 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 __FORTIFY_INLINE __diagnose_as(__builtin_memcmp, 1, 2, 3)
 int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t size)
 {
-	size_t p_size = __builtin_object_size(p, 0);
-	size_t q_size = __builtin_object_size(q, 0);
+	size_t p_size = __struct_size(p);
+	size_t q_size = __struct_size(q);
 
 	if (__builtin_constant_p(size)) {
 		if (__compiletime_lessthan(p_size, size))
@@ -531,7 +533,7 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 __FORTIFY_INLINE __diagnose_as(__builtin_memchr, 1, 2, 3)
 void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 {
-	size_t p_size = __builtin_object_size(p, 0);
+	size_t p_size = __struct_size(p);
 
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
@@ -543,7 +545,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_inv);
 __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 {
-	size_t p_size = __builtin_object_size(p, 0);
+	size_t p_size = __struct_size(p);
 
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
@@ -555,7 +557,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 extern void *__real_kmemdup(const void *src, size_t len, gfp_t gfp) __RENAME(kmemdup);
 __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp)
 {
-	size_t p_size = __builtin_object_size(p, 0);
+	size_t p_size = __struct_size(p);
 
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
@@ -568,8 +570,8 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 __FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
 char *strcpy(char * const POS p, const char * const POS q)
 {
-	size_t p_size = __builtin_object_size(p, 1);
-	size_t q_size = __builtin_object_size(q, 1);
+	size_t p_size = __member_size(p);
+	size_t q_size = __member_size(q);
 	size_t size;
 
 	/* If neither buffer size is known, immediately give up. */
-- 
2.34.1

