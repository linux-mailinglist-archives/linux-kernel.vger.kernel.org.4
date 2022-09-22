Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C565E5B63
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiIVG20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiIVG2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:28:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B66AC258
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:28:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fs14so8753255pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZqCkXEiXsKRAIDO6WEKfcC5h6w7aUTtWegAghzKUio4=;
        b=iTmM9cu2pPbNrOxZ45H918i6P/mCZqABd+wswr/ZllFVx+47h02KrRcecrXco9asp8
         WdazGn5Qd6Zl8y0aN8xBnLQOERxlGHbDZOhZO6t71cbt9p/mIPRdZyQ0AAenl41PTbxb
         qRMlDgqkMUR0EM3z2Cr6p+jT0QbeoqDVQc+7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZqCkXEiXsKRAIDO6WEKfcC5h6w7aUTtWegAghzKUio4=;
        b=pqJq+XFvY1uYiqUCz5Mj7c1sT+tuHZ6M3P49J5CEDWTTh8lkowsCPGHrzIBFx2GkzP
         KKdwNbkjskQvboGtAMjdmvWBk/Mc/hbeVGuJeCXl2Fiq7Ec7fZRFaCZl24A3XrdiPjHx
         m31dstARrNUFiVM1gh6+Y+fpNABdwR6ERcQ+v+Zfg2H5qxfhGqQkW7b2qFcc5NPIzPuD
         VMqChK+H1OLSTpEkLYDc/Ela8WjyX7E0vu2OBjCaZUqZX7M5sVsJYjyW+V6J/DCKxdgb
         X5l5KnUy6JTO2wtxLG4MlgK+UAN4HsceXd2gBcBxJEQLz1Dj9GjUdvHma7/Tn4E+wyGj
         RCig==
X-Gm-Message-State: ACrzQf1pcJTeoyVbI0C8eFGDLaQSE8BHoeKDGo84kOg3C4GWEZ5TI5by
        LG4Jw9sCqhZNsVWWg3rPXw1N/HUY1lY5oQ==
X-Google-Smtp-Source: AMsMyM7mhsOtmag6+PB6ytQqVOEoYzZeMicf6CoyRxontMJ1cxDJA25D3l9LzEHJJCIDesuHgdyovQ==
X-Received: by 2002:a17:90b:33c9:b0:200:9ec2:f2eb with SMTP id lk9-20020a17090b33c900b002009ec2f2ebmr2095377pjb.29.1663828100335;
        Wed, 21 Sep 2022 23:28:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e186-20020a621ec3000000b0053b2681b0e0sm3397654pfe.39.2022.09.21.23.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 23:28:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] string: Rewrite and add more kern-doc for the str*() functions
Date:   Wed, 21 Sep 2022 23:28:17 -0700
Message-Id: <20220922062817.2283352-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15450; h=from:subject; bh=XNGoI+v3Lo37a41PSmNFVl58a5vuww1oZHEVITu0DvA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjLACBpSeu11Er/+oHBwcJo79z7pCzFp2vAuMU9ssO FWMUvJ+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYywAgQAKCRCJcvTf3G3AJugpD/ 9+qD1bsYNyTyhZpj4f6qzt/ixWhOoHAO/w9V0g4SnAAEEANo07732aa2yhegAzlhsLnJCJ8RFMWebd 5ISjM4EbqHE4y6FrWNwWcyjrbl2B91dchshQaMQRWddqRIwydEZPQyk9B4VGamDrANHLHmfJl/8dG/ JrLCLmLizw01bw0M2Fa9CxbGajV/6ifrV2puAzQjsP3nkWZo8dAfjk0VTGTtCqVi12SyOiz4HIz+4A wyDePro9WHDQ0uzACxDsy4TS+NBiPL9EPTYiJdYeB2GjxWIk9eguqxmeUR+5S3IttBXL6lrRyLUVPO FB1AbWIXdzpvZXm+lj7bG/y4FlMa5lBt47wJAZKwE5MGegTqkw7O6NYDY+xjqICNJ+zQKkywAgG14J aJinrE/HUwIJS6vywC2cbPT6tMC9nEATe6nqGGSaidgTV+5EExnkGcNxIOA19LKlHY2ABdWQSk/YwS wI9Z0b6HmC/44+SdL+C6KU8oekduRc9LDiELqBYUc42kpfJUTW/dCnJdDy3pqO9elkso727e75+5YE 2/+RxWg5wHC+1qNs1dahuIxJLiZGfv5RL4P9FszQ1uyVkf/doixrpB5mmWOX1uOR6i+s8zuoTvEIGM RImT6rz3hX5NdUTW07rqjkKih4325vpBXSHVUAXgxONfHaMXqIefMSzKkB2Q==
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

While there were varying degrees of kern-doc for various str*()-family
functions, many needed updating and clarification, or to just be
entirely written. Update (and relocate) existing kern-doc and add missing
functions, sadly shaking my head at how many times I have written "Do
not use this function". Include the results in the core kernel API doc.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Follow up to https://lore.kernel.org/lkml/20220902223507.2537469-1-keescook@chromium.org
Note that this is on top of my recent fortify-string.h series:
https://lore.kernel.org/lkml/20220920192202.190793-1-keescook@chromium.org/
---
 Documentation/core-api/kernel-api.rst |   3 +
 include/linux/fortify-string.h        | 133 ++++++++++++++++++++++++--
 lib/string.c                          |  82 ----------------
 scripts/kernel-doc                    |   4 +
 4 files changed, 130 insertions(+), 92 deletions(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 0793c400d4b0..20569f26dde1 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -36,6 +36,9 @@ String Conversions
 String Manipulation
 -------------------
 
+.. kernel-doc:: include/linux/fortify-string.h
+   :internal:
+
 .. kernel-doc:: lib/string.c
    :export:
 
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index b62c90cfafaf..a2e06ad47479 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -106,13 +106,13 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
  * Instead, please choose an alternative, so that the expectation
  * of @p's contents is unambiguous:
  *
- * +--------------------+-----------------+------------+
- * | @p needs to be:    | padded to @size | not padded |
- * +====================+=================+============+
- * |     NUL-terminated | strscpy_pad()   | strscpy()  |
- * +--------------------+-----------------+------------+
- * | not NUL-terminated | strtomem_pad()  | strtomem() |
- * +--------------------+-----------------+------------+
+ * +--------------------+--------------------+------------+
+ * | **p** needs to be: | padded to **size** | not padded |
+ * +====================+====================+============+
+ * |     NUL-terminated | strscpy_pad()      | strscpy()  |
+ * +--------------------+--------------------+------------+
+ * | not NUL-terminated | strtomem_pad()     | strtomem() |
+ * +--------------------+--------------------+------------+
  *
  * Note strscpy*()'s differing return values for detecting truncation,
  * and strtomem*()'s expectation that the destination is marked with
@@ -131,6 +131,21 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 	return __underlying_strncpy(p, q, size);
 }
 
+/**
+ * strcat - Append a string to an existing string
+ *
+ * @p: pointer to NUL-terminated string to append to
+ * @q: pointer to NUL-terminated source string to append from
+ *
+ * Do not use this function. While FORTIFY_SOURCE tries to avoid
+ * read and write overflows, this is only possible when the
+ * destination buffer size is known to the compiler. Prefer
+ * building the string with formatting, via scnprintf() or similar.
+ * At the very least, use strncat().
+ *
+ * Returns @p.
+ *
+ */
 __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
 char *strcat(char * const POS p, const char *q)
 {
@@ -144,6 +159,16 @@ char *strcat(char * const POS p, const char *q)
 }
 
 extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
+/**
+ * strnlen - Return bounded count of characters in a NUL-terminated string
+ *
+ * @p: pointer to NUL-terminated string to count.
+ * @maxlen: maximum number of characters to count.
+ *
+ * Returns number of characters in @p (NOT including the final NUL), or
+ * @maxlen, if no NUL has been found up to there.
+ *
+ */
 __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size_t maxlen)
 {
 	size_t p_size = __member_size(p);
@@ -169,6 +194,19 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
  * possible for strlen() to be used on compile-time strings for use in
  * static initializers (i.e. as a constant expression).
  */
+/**
+ * strlen - Return count of characters in a NUL-terminated string
+ *
+ * @p: pointer to NUL-terminated string to count.
+ *
+ * Do not use this function unless the string length is known at
+ * compile-time. When @p is unterminated, this function may crash
+ * or return unexpected counts that could lead to memory content
+ * exposures. Prefer strnlen().
+ *
+ * Returns number of characters in @p (NOT including the final NUL).
+ *
+ */
 #define strlen(p)							\
 	__builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),	\
 		__builtin_strlen(p), __fortify_strlen(p))
@@ -187,8 +225,26 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 	return ret;
 }
 
-/* defined after fortified strlen to reuse it */
+/* Defined after fortified strlen() to reuse it. */
 extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
+/**
+ * strlcpy - Copy a string into another string buffer
+ *
+ * @p: pointer to destination of copy
+ * @q: pointer to NUL-terminated source string to copy
+ * @size: maximum number of bytes to write at @p
+ *
+ * If strlen(@q) >= @size, the copy of @q will be truncated at
+ * @size - 1 bytes. @p will always be NUL-terminated.
+ *
+ * Do not use this function. While FORTIFY_SOURCE tries to avoid
+ * over-reads when calculating strlen(@q), it is still possible.
+ * Prefer strscpy(), though note its different return values for
+ * detecting truncation.
+ *
+ * Returns total number of bytes written to @p, including terminating NUL.
+ *
+ */
 __FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, size_t size)
 {
 	size_t p_size = __member_size(p);
@@ -214,8 +270,32 @@ __FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, si
 	return q_len;
 }
 
-/* defined after fortified strnlen to reuse it */
+/* Defined after fortified strnlen() to reuse it. */
 extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
+/**
+ * strscpy - Copy a C-string into a sized buffer
+ *
+ * @p: Where to copy the string to
+ * @q: Where to copy the string from
+ * @size: Size of destination buffer
+ *
+ * Copy the source string @p, or as much of it as fits, into the destination
+ * @q buffer. The behavior is undefined if the string buffers overlap. The
+ * destination @p buffer is always NUL terminated, unless it's zero-sized.
+ *
+ * Preferred to strlcpy() since the API doesn't require reading memory
+ * from the source @q string beyond the specified @size bytes, and since
+ * the return value is easier to error-check than strlcpy()'s.
+ * In addition, the implementation is robust to the string changing out
+ * from underneath it, unlike the current strlcpy() implementation.
+ *
+ * Preferred to strncpy() since it always returns a valid string, and
+ * doesn't unnecessarily force the tail of the destination buffer to be
+ * zero padded. If padding is desired please use strscpy_pad().
+ *
+ * Returns the number of characters copied in @p (not including the
+ * trailing %NUL) or -E2BIG if @size is 0 or the copy of @q was truncated.
+ */
 __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, size_t size)
 {
 	size_t len;
@@ -261,7 +341,26 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	return __real_strscpy(p, q, len);
 }
 
-/* defined after fortified strlen and strnlen to reuse them */
+/**
+ * strncat - Append a string to an existing string
+ *
+ * @p: pointer to NUL-terminated string to append to
+ * @q: pointer to source string to append from
+ * @count: Maximum bytes to read from @q
+ *
+ * Appends at most @count bytes from @q (stopping at the first
+ * NUL byte) after the NUL-terminated string at @p. @p will be
+ * NUL-terminated.
+ *
+ * Do not use this function. While FORTIFY_SOURCE tries to avoid
+ * read and write overflows, this is only possible when the sizes
+ * of @p and @q are known to the compiler. Prefer building the
+ * string with formatting, via scnprintf() or similar.
+ *
+ * Returns @p.
+ *
+ */
+/* Defined after fortified strlen() and strnlen() to reuse them. */
 __FORTIFY_INLINE __diagnose_as(__builtin_strncat, 1, 2, 3)
 char *strncat(char * const POS p, const char * const POS q, __kernel_size_t count)
 {
@@ -565,6 +664,20 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 	return __real_kmemdup(p, size, gfp);
 }
 
+/**
+ * strcpy - Copy a string into another string buffer
+ *
+ * @p: pointer to destination of copy
+ * @q: pointer to NUL-terminated source string to copy
+ *
+ * Do not use this function. While FORTIFY_SOURCE tries to avoid
+ * overflows, this is only possible when the sizes of @q and @p are
+ * known to the compiler. Prefer strscpy(), though note its different
+ * return values for detecting truncation.
+ *
+ * Returns @p.
+ *
+ */
 /* Defined after fortified strlen to reuse it. */
 __FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
 char *strcpy(char * const POS p, const char * const POS q)
diff --git a/lib/string.c b/lib/string.c
index 6f334420f687..6045124c2195 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -76,11 +76,6 @@ EXPORT_SYMBOL(strcasecmp);
 #endif
 
 #ifndef __HAVE_ARCH_STRCPY
-/**
- * strcpy - Copy a %NUL terminated string
- * @dest: Where to copy the string to
- * @src: Where to copy the string from
- */
 char *strcpy(char *dest, const char *src)
 {
 	char *tmp = dest;
@@ -93,19 +88,6 @@ EXPORT_SYMBOL(strcpy);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCPY
-/**
- * strncpy - Copy a length-limited, C-string
- * @dest: Where to copy the string to
- * @src: Where to copy the string from
- * @count: The maximum number of bytes to copy
- *
- * The result is not %NUL-terminated if the source exceeds
- * @count bytes.
- *
- * In the case where the length of @src is less than  that  of
- * count, the remainder of @dest will be padded with %NUL.
- *
- */
 char *strncpy(char *dest, const char *src, size_t count)
 {
 	char *tmp = dest;
@@ -122,17 +104,6 @@ EXPORT_SYMBOL(strncpy);
 #endif
 
 #ifndef __HAVE_ARCH_STRLCPY
-/**
- * strlcpy - Copy a C-string into a sized buffer
- * @dest: Where to copy the string to
- * @src: Where to copy the string from
- * @size: size of destination buffer
- *
- * Compatible with ``*BSD``: the result is always a valid
- * NUL-terminated string that fits in the buffer (unless,
- * of course, the buffer size is zero). It does not pad
- * out the result like strncpy() does.
- */
 size_t strlcpy(char *dest, const char *src, size_t size)
 {
 	size_t ret = strlen(src);
@@ -148,30 +119,6 @@ EXPORT_SYMBOL(strlcpy);
 #endif
 
 #ifndef __HAVE_ARCH_STRSCPY
-/**
- * strscpy - Copy a C-string into a sized buffer
- * @dest: Where to copy the string to
- * @src: Where to copy the string from
- * @count: Size of destination buffer
- *
- * Copy the string, or as much of it as fits, into the dest buffer.  The
- * behavior is undefined if the string buffers overlap.  The destination
- * buffer is always NUL terminated, unless it's zero-sized.
- *
- * Preferred to strlcpy() since the API doesn't require reading memory
- * from the src string beyond the specified "count" bytes, and since
- * the return value is easier to error-check than strlcpy()'s.
- * In addition, the implementation is robust to the string changing out
- * from underneath it, unlike the current strlcpy() implementation.
- *
- * Preferred to strncpy() since it always returns a valid string, and
- * doesn't unnecessarily force the tail of the destination buffer to be
- * zeroed.  If zeroing is desired please use strscpy_pad().
- *
- * Returns:
- * * The number of characters copied (not including the trailing %NUL)
- * * -E2BIG if count is 0 or @src was truncated.
- */
 ssize_t strscpy(char *dest, const char *src, size_t count)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
@@ -258,11 +205,6 @@ char *stpcpy(char *__restrict__ dest, const char *__restrict__ src)
 EXPORT_SYMBOL(stpcpy);
 
 #ifndef __HAVE_ARCH_STRCAT
-/**
- * strcat - Append one %NUL-terminated string to another
- * @dest: The string to be appended to
- * @src: The string to append to it
- */
 char *strcat(char *dest, const char *src)
 {
 	char *tmp = dest;
@@ -277,15 +219,6 @@ EXPORT_SYMBOL(strcat);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCAT
-/**
- * strncat - Append a length-limited, C-string to another
- * @dest: The string to be appended to
- * @src: The string to append to it
- * @count: The maximum numbers of bytes to copy
- *
- * Note that in contrast to strncpy(), strncat() ensures the result is
- * terminated.
- */
 char *strncat(char *dest, const char *src, size_t count)
 {
 	char *tmp = dest;
@@ -306,12 +239,6 @@ EXPORT_SYMBOL(strncat);
 #endif
 
 #ifndef __HAVE_ARCH_STRLCAT
-/**
- * strlcat - Append a length-limited, C-string to another
- * @dest: The string to be appended to
- * @src: The string to append to it
- * @count: The size of the destination buffer.
- */
 size_t strlcat(char *dest, const char *src, size_t count)
 {
 	size_t dsize = strlen(dest);
@@ -476,10 +403,6 @@ EXPORT_SYMBOL(strnchr);
 #endif
 
 #ifndef __HAVE_ARCH_STRLEN
-/**
- * strlen - Find the length of a string
- * @s: The string to be sized
- */
 size_t strlen(const char *s)
 {
 	const char *sc;
@@ -492,11 +415,6 @@ EXPORT_SYMBOL(strlen);
 #endif
 
 #ifndef __HAVE_ARCH_STRNLEN
-/**
- * strnlen - Find the length of a length-limited string
- * @s: The string to be sized
- * @count: The maximum number of bytes to search
- */
 size_t strnlen(const char *s, size_t count)
 {
 	const char *sc;
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 8bb89deb9a91..adbc4d307770 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1448,6 +1448,8 @@ sub create_parameterlist($$$$) {
     foreach my $arg (split($splitter, $args)) {
 	# strip comments
 	$arg =~ s/\/\*.*\*\///;
+	# ignore argument attributes
+	$arg =~ s/\sPOS0?\s/ /;
 	# strip leading/trailing spaces
 	$arg =~ s/^\s*//;
 	$arg =~ s/\s*$//;
@@ -1657,6 +1659,7 @@ sub dump_function($$) {
     $prototype =~ s/^__inline +//;
     $prototype =~ s/^__always_inline +//;
     $prototype =~ s/^noinline +//;
+    $prototype =~ s/^__FORTIFY_INLINE +//;
     $prototype =~ s/__init +//;
     $prototype =~ s/__init_or_module +//;
     $prototype =~ s/__deprecated +//;
@@ -1667,6 +1670,7 @@ sub dump_function($$) {
     $prototype =~ s/__sched +//;
     $prototype =~ s/__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +//;
     $prototype =~ s/__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +//;
+    $prototype =~ s/__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +//;
     my $define = $prototype =~ s/^#\s*define\s+//; #ak added
     $prototype =~ s/__attribute_const__ +//;
     $prototype =~ s/__attribute__\s*\(\(
-- 
2.34.1

