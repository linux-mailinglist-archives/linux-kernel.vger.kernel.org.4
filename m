Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F936DB430
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjDGT1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjDGT1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:27:24 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E1BBB8E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:27:22 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-503e712502fso142338a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680895642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH3dZcNrJEcXdI6gLg/VVjSGY3YcGh7oSZMfJQoWlZk=;
        b=Y6dsI+xaLywGjLzrDUE4NPsihTXJPkDDqEy1KlHDQJOljbqAf23LYpKKnxZGCY0Ix3
         K/gQTNK5PGOrBxMnW/S3DxxG+G6DKJyIazDTG0sBOwTQS9/4TXOJZdzGlYJCaumE75eB
         exf7mrC7xy3XNiZXspsAYimbRc6Quu/lXQjwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680895642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH3dZcNrJEcXdI6gLg/VVjSGY3YcGh7oSZMfJQoWlZk=;
        b=i+HaIAI5lYTrx9pOXdmUdi+rWS8kVosUBIO66xHQOfS449IMQkBTfXXPe5eFqUp3dq
         ySJcPdPOmP83++JCeXXghxkc+Xyar4eIDjm0/AE0wMumiWXB1KFyfVnt9DwsD/kvlafw
         pm58fOCidz9+ChpDGY2PYhUqHMwjmOymS7IEjCWN0nxjMrTtoNFd8uU4leabXxVsVHQo
         0nNQg114bdkSgn3kOB2IYzmfWxtPuqpvFZz6Jv/FJ2vjJARvuaBr7EjwLFJgcVI7qlW1
         f16CGdIh+7gq8gpxvj2+wrPFyW4ARSzKWOMuRJjX7jNHYDeDWnAMeYyC1sDxzAUZC41x
         1ZLg==
X-Gm-Message-State: AAQBX9duKqs4q401Nsw8kX1ys9Ax0cWGrUbeditnkARMYnnIRtbsDyIo
        +Gv+6zc9oRmytkkehPnUSBWBag==
X-Google-Smtp-Source: AKy350YuL6Xs7by8SNDk+HQdmk4IcrYdk70nudo84K771qx45gacfI/TGaEDLdcrhZ+xploqpEiuVw==
X-Received: by 2002:aa7:9793:0:b0:628:650:4835 with SMTP id o19-20020aa79793000000b0062806504835mr3238044pfp.13.1680895642266;
        Fri, 07 Apr 2023 12:27:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v12-20020aa7850c000000b005da23d8cbffsm3369357pfn.158.2023.04.07.12.27.19
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
Subject: [PATCH v2 06/10] fortify: strcat: Move definition to use fortified strlcat()
Date:   Fri,  7 Apr 2023 12:27:12 -0700
Message-Id: <20230407192717.636137-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407191904.gonna.522-kees@kernel.org>
References: <20230407191904.gonna.522-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2641; h=from:subject; bh=fgN4hsz1FdWUIQbkd6Iy2KfoErfwaK/Oc+dmURYf7Mo=; b=owEBbAKT/ZANAwAKAYly9N/cbcAmAcsmYgBkMG6TtMTKotZ5UuZ6/J+WNgqbctlvvaLeCtSAKQ0/ hLnjmgWJAjIEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZDBukwAKCRCJcvTf3G3AJoL6D/ i7HpHWgvMyI90z6CVCbQynb9o1brHw6iGmsTfNl0mrHayNgEnN50mQihqYfKpauwm1bEwTokrzBAsx oM8LLACRlDZrdzx2H8I/ZADgDIrMDceD20KpRp7hxjYibuGhlg3bOcp3BX/FLPDaQWo0CaEeTwuzvy 7wXxB2ekUV2JLQY8bjkx7KfHHoQ3n6R6LTLyaiTOEQCKnJFoteC5j32zzaWZNbZ/jbetpJOzeswFSY cOPj+VOVPvUdubTMKyKx4EjbOrb4qZEHA7hQ5SHpoCw60vpIs4jDY9VtqBMp0/sbYmdXg82YkxAqOI BUecXs5caWAfp8qvMjo739H86eS0piU2I7f8j0+IjOiL7LF08P3XJqjsoipz+xPJYmEJulwauWDKoi 1VuuVZjK2Kemw0oucpfWyWa8ghBipwF+fy7vQ0hZb/3z+Lqc07Ps17aTr4aYqI98eV/r9YLbIQzS5A 61h8Yz8PcbFc240wOdvLPxomh0tLyslgSobvWE9fqyA6YjoQZBBGSi59olM7JLn2a3Fy6+oJzPzjvq 3zU0TwLzoT8SCqJke00Ud27ZWAyT33To+3WeB2LrYN0P5cRSyrIV4DS1Nq2u43BidS5K/ej0G7YGzJ vZaR1hhi6sJmdX00dgIYTeBA49t3CTFHxhkyWHMFoQOSKzFLIJlmJyUYYM
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

Move the definition of fortified strcat() to after strlcat() to use it
for bounds checking.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 53 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 8cf17ef81905..ab058d092817 100644
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
-	const size_t p_size = __member_size(p);
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
+	const size_t p_size = __member_size(p);
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

