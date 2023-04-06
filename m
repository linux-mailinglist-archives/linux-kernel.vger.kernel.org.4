Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC136D8B5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjDFACb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjDFACT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:02:19 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6023261AE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:02:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c18so35934991ple.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 17:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680739338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExS1X1Asjk++jX2/Mr+aGsXWXjGWAeASIa6ARPjpF0s=;
        b=KEWpEbnIM66/k6Fl8lCg8J+TrhHMvhMCQDYDaDVmogicejBB6916cUXGdx/RY09kcG
         hBmb95mrp2ZAvyKnwpzjCUiRTAl/+vYw5D3mc38QSjWeoBPBhN7v84E7UMtxWozTF2OJ
         sfIE6kWBGdOqf4Va5AZMZCWGF4srD5lcdldts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExS1X1Asjk++jX2/Mr+aGsXWXjGWAeASIa6ARPjpF0s=;
        b=yqrdjQT3uV7sIdWFu/cmx3tcz/C7gKU2oUf1Mtm2bYl8uFcZAWcBgwBnx3kAL86gsA
         fDWP3bVNkGQDJ1ahZW+gASEgyLTNJBt/pEHRtjZh168cavOsZVUTv8RmJXg3EGsIgCrF
         85jgy1q74K11POqYXSX+YX4CN7gIwgBOP0EokFgqYalOAhZ00jt5TkJzZxP8kXeQXypt
         tRoqrfgZpPWs3BWnl6dMoEytOikqraormFRW3c5iPjwFJLg0DF7Js+W8jDPao7D819a9
         1XR5SJhtn8oEFbfLiV2HujAREuZMr+6wINXXU87z1V8I+ogu79lQqhaaBM0UCPU+MkV5
         +Zbg==
X-Gm-Message-State: AAQBX9d6pn8DVz8+eh3AyP8bldyPY0BhxgMiKvTjAiaYRvzQBBhd//Jo
        LWk/PrGBNE1FN2KT8oralEgblg==
X-Google-Smtp-Source: AKy350YpahY9tQxkeh6meEYNw3t9u3+e9C0Er0CTpuKk8Ndi/YL+LO1EN4IEqvq0UCpr5wuMQM5dgw==
X-Received: by 2002:a17:902:c94e:b0:1a0:65d3:bae4 with SMTP id i14-20020a170902c94e00b001a065d3bae4mr9699691pla.38.1680739337837;
        Wed, 05 Apr 2023 17:02:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902b08900b0019e8915b1b5sm94611plr.105.2023.04.05.17.02.15
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
Subject: [PATCH 5/9] fortify: strcat: Move definition to use fortified strlcat()
Date:   Wed,  5 Apr 2023 17:02:04 -0700
Message-Id: <20230406000212.3442647-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405235832.never.487-kees@kernel.org>
References: <20230405235832.never.487-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2624; i=keescook@chromium.org; h=from:subject; bh=O4OjFtVJ1tD3TCO7wTWZXRQ046029J23gw/1XMQ1O9Q=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkLgv/+JEBhkqs9VsEq7y+wgME8WyhveIf5l89VWz3 AvrwAtSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZC4L/wAKCRCJcvTf3G3AJniDD/ 0V5CRN6GGGJdY8FU0vXH9y7xdXiBbN5MFFeYHQoaCP7lqkYn1TRcvNrmtPkuQIGjZnGXbn+ldsUrvV jkxwJ8JpVpqfIC1ibhYHJ4o8YRe/uMFWzORpNOqmWTMoB/cei1+5afll5SMW1OjW1ch7EjDpYZXS1n WpLAB9D8ZQMcs6+gld3A3cB+CzR1IUQ6COJcvbOR8kV5iqWfXvsasBwPdwJiJHv/PYt6vaoKOrfOWg pfWcesAXe72Wmi2cV/+q0hCjv5+ayGB79Uc/VxtoaplGonA4rkJa9B7fywwIu5Ies8q3T5W4h3R2uX 5LdB8eqUuszkdjxxaVDGrNEUjqagVMNZnYpobfs+95DYhbu4gxBKfR+IZQW1KKogha4mJ8NJPDskUk Gr77XjOP8BCqdIodxcWGdaGaCYeIrcfTMu+c7j3xmoZLhxaVI29WqUkShAi46f20FIKxSLcHosBiuF T2tvZYSwpt/rC0gr135kL9xLZopQMxaSlKQUBXStie8QRRd2YsFNaxUxjUB3FMOqOY/dVqlRjnIdnh nHDMa2mwEohRoW7/IvyAeFHvR5GjE3R+PkfCSo0FnX2JGxTYmZqMCB5OWzdKgX7E1uzF80JFHJQNp+ 9DmWdlBGTPj0I+5Nwipfd7HfdVVNL5PTMVBo+TRgSWa+siRVBjLWKGBAQpIA==
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

Move the definition of fortified strcat() to after strlcat() to use it
for bounds checking.

Signed-off-by: Kees Cook <kees@outflux.net>
---
 include/linux/fortify-string.h | 53 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 875689aa83c3..41dbd641f55c 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -151,33 +151,6 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 	return __underlying_strncpy(p, q, size);
 }
 
-/**
- * strcat - Append a string to an existing string
- *
- * @p: pointer to NUL-terminated string to append to
- * @q: pointer to NUL-terminated source string to append from
- *
- * Do not use this function. While FORTIFY_SOURCE tries to avoid
- * read and write overflows, this is only possible when the
- * destination buffer size is known to the compiler. Prefer
- * building the string with formatting, via scnprintf() or similar.
- * At the very least, use strncat().
- *
- * Returns @p.
- *
- */
-__FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
-char *strcat(char * const POS p, const char *q)
-{
-	size_t p_size = __member_size(p);
-
-	if (p_size == SIZE_MAX)
-		return __underlying_strcat(p, q);
-	if (strlcat(p, q, p_size) >= p_size)
-		fortify_panic(__func__);
-	return p;
-}
-
 extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
 /**
  * strnlen - Return bounded count of characters in a NUL-terminated string
@@ -435,6 +408,32 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 	return wanted;
 }
 
+/* Defined after fortified strlcat() to reuse it. */
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
+__FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
+char *strcat(char * const POS p, const char *q)
+{
+	size_t p_size = __member_size(p);
+
+	if (strlcat(p, q, p_size) >= p_size)
+		fortify_panic(__func__);
+	return p;
+}
+
 /**
  * strncat - Append a string to an existing string
  *
-- 
2.34.1

