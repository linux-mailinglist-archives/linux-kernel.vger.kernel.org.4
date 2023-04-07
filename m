Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45E36DB435
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDGT2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjDGT15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:27:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F7CA38
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:27:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c3so73751pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680895654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPcuT70JKssQ2aI2lYpWBDS/i3DDpoTMqsAdxV4Teow=;
        b=cN16vjyvLAfvNO0jjCGHhI00oaqTmFSmnidjbBiLrBf0B/08a6qkleOl92BlOs6E1T
         /6iKx63ap9Uw3aFi03oADHv+RsE6oreIelPn3k+fIjdn9XIKttRJEVqbab0lIEjfC++j
         qpfaABtpH9kdeOaODI3LoufOzR9px+qtG2YXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680895654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPcuT70JKssQ2aI2lYpWBDS/i3DDpoTMqsAdxV4Teow=;
        b=LJSBmVC1RXqUZH2ZnUIqtxZt6SfZD1V7gVEz/rtreau/1rsbzskMoKUJh1xBEfm4Az
         mplOuQVDAY8Y7lhK8L3GgiSIEfSMTh/CcW5D7lx0bKjq0k2jBddN2rMRu4Z+VprW9Ucr
         jkuNqWP3D9UHAJOPtu3sFZ4O/3DMBt+55XbhsAMUgtzd9Homz9OzkbPDvffFBKKEpTqa
         nWa3PcAtktPJog/fzbtOQDpAnxA88j28tJu6HRVhSudFCGt/+tzCG73WGTyvcBXtclR3
         vIwkLWg3lOOyEbC1M/3arnhV2MG6+Q4f0l1J8TZqKpWS5wIMsbIx66M9XkKr8H7aCjXq
         0NEA==
X-Gm-Message-State: AAQBX9eLwQpPyxx4qbVrNBPBYigza+hT/77+NwAzUHRfnFkGqPy+l3bk
        TyEXG2iMurJUdjt/IGFXXwI/HQ==
X-Google-Smtp-Source: AKy350ZL0G/P430xOGmweElZlWfnvFO82GK0vna9Ov6aYArxnHGwCSyf8flfDuVYXmHTSKPU0rQphw==
X-Received: by 2002:a17:902:d2c9:b0:1a2:6f9f:de16 with SMTP id n9-20020a170902d2c900b001a26f9fde16mr2976801plc.11.1680895641785;
        Fri, 07 Apr 2023 12:27:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709028d8600b001a1faed8707sm3258805plo.63.2023.04.07.12.27.19
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
Subject: [PATCH v2 05/10] fortify: Add protection for strlcat()
Date:   Fri,  7 Apr 2023 12:27:11 -0700
Message-Id: <20230407192717.636137-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407191904.gonna.522-kees@kernel.org>
References: <20230407191904.gonna.522-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3263; h=from:subject; bh=r+rAeBjXdjpzUns0umU+5al0iGfCgvAONvhR7EI8+Y8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkMG6TN8iuOguCB+qcsKhhHeavng+JIsd1jx5bn/I2 ZyUXTNCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZDBukwAKCRCJcvTf3G3AJqv8EA CNmv9W7JWKVOk91zfZbymKklNoRoEq6PHkPAoXZmBQ9prANIl8A0PpUcG7Tg44HCVln1YpbioI2e6c N1z+l4w9MTicUNShiQXV3p/u3aio9GZgdrwZFTXs598tWlR6bd7C7PcmhMWiVb2mEsSfoL5xw1BB+Q 7VtTxOJpRkfivCBExUzwOqJFlhEcCiLxtULImFD2OdxKvI+24zwzeL77iyDlyxyW4kVMHvPp8XBNfQ R1uJkWX/bdzxPwvnzvjgo3YUFXfU+fm1fEUrsGt4O1DjrnkiTbnymoQfmnVLtZ0SjEZ8EkJ95X/oNI dnHmjM5tm33rcPlI3v08Kr/ITAjaTQ/vQAihwmpPHuqL9QStWFVbUzt0fXcOYpoh6OdqHrtIM7Pe7s XxJb+0Dg0sDiFC/Fqx2XNWGB3lQgrWHwq1JtulFPMif5ONEyXuFZDorIv4Mu8765lshHXfdgZ92x/s vaWh4umoMxB6J94dGeKG7XGLUEFF7otfKfo5+RZXrOf/IuFrq0skfZJ24apxIverbThOXEgCqpi2ep WR8dag2pABvmetuTrKlax4AHHTN6XnZJiZfXwkyLyYpmNfS5kP4LGoIshqwA8PZ78E4UpiVwS1l/NG g9Q9TBNDFzNq+iQ60xfv0dSwA+z1t+6GXFy3ejgT/kWDK2xIDYJoqPppxYow==
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

The definition of strcat() was defined in terms of unfortified strlcat(),
but that meant there was no bounds checking done on the internal strlen()
calls, and the (bounded) copy would be performed before reporting a
failure. Additionally, pathological cases (i.e. unterminated destination
buffer) did not make calls to fortify_panic(), which will make future unit
testing more difficult. Instead, explicitly define a fortified strlcat()
wrapper for strcat() to use.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 64 ++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index fae1bf4bd543..8cf17ef81905 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -371,6 +371,70 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	return __real_strscpy(p, q, len);
 }
 
+/* Defined after fortified strlen() to reuse it. */
+extern size_t __real_strlcat(char *p, const char *q, size_t avail) __RENAME(strlcat);
+/**
+ * strlcat - Append a string to an existing string
+ *
+ * @p: pointer to %NUL-terminated string to append to
+ * @q: pointer to %NUL-terminated string to append from
+ * @avail: Maximum bytes available in @p
+ *
+ * Appends %NUL-terminated string @q after the %NUL-terminated
+ * string at @p, but will not write beyond @avail bytes total,
+ * potentially truncating the copy from @q. @p will stay
+ * %NUL-terminated only if a %NUL already existed within
+ * the @avail bytes of @p. If so, the resulting number of
+ * bytes copied from @q will be at most "@avail - strlen(@p) - 1".
+ *
+ * Do not use this function. While FORTIFY_SOURCE tries to avoid
+ * read and write overflows, this is only possible when the sizes
+ * of @p and @q are known to the compiler. Prefer building the
+ * string with formatting, via scnprintf(), seq_buf, or similar.
+ *
+ * Returns total bytes that _would_ have been contained by @p
+ * regardless of truncation, similar to snprintf(). If return
+ * value is >= @avail, the string has been truncated.
+ *
+ */
+__FORTIFY_INLINE
+size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
+{
+	const size_t p_size = __member_size(p);
+	const size_t q_size = __member_size(q);
+	size_t p_len, copy_len;
+	size_t actual, wanted;
+
+	/* Give up immediately if both buffer sizes are unknown. */
+	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
+		return __real_strlcat(p, q, avail);
+
+	p_len = strnlen(p, avail);
+	copy_len = strlen(q);
+	wanted = actual = p_len + copy_len;
+
+	/* Cannot append any more: report truncation. */
+	if (avail <= p_len)
+		return wanted;
+
+	/* Give up if string is already overflowed. */
+	if (p_size <= p_len)
+		fortify_panic(__func__);
+
+	if (actual >= avail) {
+		copy_len = avail - p_len - 1;
+		actual = p_len + copy_len;
+	}
+
+	/* Give up if copy will overflow. */
+	if (p_size <= actual)
+		fortify_panic(__func__);
+	__underlying_memcpy(p + p_len, q, copy_len);
+	p[actual] = '\0';
+
+	return wanted;
+}
+
 /**
  * strncat - Append a string to an existing string
  *
-- 
2.34.1

