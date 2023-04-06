Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBA86D8B60
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjDFAC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjDFACY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:02:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FB17A89
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:02:20 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x15so35676507pjk.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 17:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680739340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGVmFbO1Y3SrBAnAifK0ihmdOIjmdFYZw8LCIDp6wGM=;
        b=LxuIX9/ul4iLS8S1aSht29ovUoxEWtGqAQzkZBAuM1aqCB5+3YSKswbAGoEOIAFZHU
         5+ZEOX44gt7UQ/6UDEk2oYWZHiuiZJCSUgfTLAzMP7qUKPaD9+iZvbO+rCCFfPu902DU
         yKxO2jiNZJkpWIJ/VwUKDp+AP65jBVlINGOLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGVmFbO1Y3SrBAnAifK0ihmdOIjmdFYZw8LCIDp6wGM=;
        b=fnWXt8G2WtdHw3JVa4m5sORadXdnaJxYfLxKCNAF3R6xzGqgOCSfu+F4mnpCCvEWhO
         LSUjTg0hn4ooCy91MOfrQQRGilRDOLRWqhYYIoMeo4owsCq9hixxCoXT8/epPV/9LoJa
         UZBikgXXYLN6SFbzl5pmR6h4+sjj6WzKcDmLbLcXM9bpqBwnJ7uHZVk5/V74qr/0MAIP
         sS3nDB7N5zSZ3c7uRxzkHHjapPs2QCbhQBxP4hIeFMrQrDEYEmmc1RRSTRzS7d27cyVd
         FoTpJTEw7DrGkzouD4YO2XEMlu5VRuPd5fYzEyZlCMp932TJFFM05wNjA0HurGktqLh5
         Berw==
X-Gm-Message-State: AAQBX9fH3ny+yCgcGTC3ZZUdH/7QmBn5zNpP9kjDnh9pcMLWj5kLgDKB
        HDHFZwcFeD2r6rWO8RGZD82oFA==
X-Google-Smtp-Source: AKy350ZzdST7ynXxaHkIFbOo3qCq3yyAa47OlYAX17JCcj3YVJqO9U5rE0aLbsCxGmdw5S4FmAKxkA==
X-Received: by 2002:a17:902:d2ce:b0:1a2:1a5b:cc69 with SMTP id n14-20020a170902d2ce00b001a21a5bcc69mr9937827plc.32.1680739339837;
        Wed, 05 Apr 2023 17:02:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902b08a00b0019cbd37a335sm93665plr.93.2023.04.05.17.02.16
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
Subject: [PATCH 8/9] fortify: Add KUnit tests for runtime overflows
Date:   Wed,  5 Apr 2023 17:02:07 -0700
Message-Id: <20230406000212.3442647-8-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405235832.never.487-kees@kernel.org>
References: <20230405235832.never.487-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=29256; i=keescook@chromium.org;
 h=from:subject; bh=93uSHieIIEjRUuw59HxOto+9Z0ygPJhGlaPpgK8yUi0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkLgv/Eee2x9D/oTNO8DmEDkp1d4E7VwNznal84U3D
 Z5T/FeaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZC4L/wAKCRCJcvTf3G3AJuQnD/
 9HcOyFb96Sg7V/6cPe30hGahUjaFGv1GJfhTo1eskyLJvf490QordO1B8ZxUJ37i4l7HNDFoBD7gbU
 k+V3dnqQuks53s7OPhS51I38yshsdhmdHmoHtXIYfc3SrbbmPG2cgWRGo8xtqSK9Kva2myh2nFax6y
 tbcRrFiKQxBcM0M/V3fuw4Mmd1M2yp3diPAEnlzdTx8OoKsMedFtr0IG9azL8xTx8z9rb9kfIkaw52
 UXeFOXOHo/aiZhe/n2X5rWhbywBQ06NVg4HN9pSFtHCWW41y2FbQmfdMZvA6rgSrG2fyLrVKf0Y+Qt
 hwRvjEmAjmQXowe0K/zJ2NUFDmaCyey3jnrf+V2nqK2gk0qdaZxCcArh7tPail+7pDkS4BdNlbEHNP
 JaKkLIFa1vz3MXuBXLBWNJZXeIYnBk9g4620cJU25/tpaGtCs6dFFMLrp8oWa8orSkMnRxFG+01yX8
 dUMGsEA2wF2LIqJZgnQ9orDYUk+fYxHowQ/h67qjTqqjBW1fEtRVFcIUTFMR6WBzvNy7DrtjBO5mZY
 AypftjP2RcG3FS1fucjbxIt37jlDlR67LRUa/xShcHMBtMtNgMUVeLu25sDGt2ZNUz1UlGarFdLMtH
 3MEXbzgAEBC/+yUST0x/69+evQL2UvyD/WBQ6oDdw/kuLYC7PlXJLkcwVnuQ==
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

With fortify overflows able to be redirected, we can use KUnit to
exercise the overflow conditions. Add tests for every API covered by
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Kees Cook <kees@outflux.net>
---
 lib/fortify_kunit.c | 733 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 733 insertions(+)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index f7523c25d341..b7c884037629 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -357,6 +357,723 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 
+/*
+ * We can't have an array at the end of a structure or else
+ * builds without -fstrict-flex-arrays=3 will report them as
+ * being an unknown length. Additionally, add bytes before
+ * and after the string to catch over/underflows if tests
+ * fail.
+ */
+struct fortify_padding {
+	unsigned long bytes_before;
+	char buf[32];
+	unsigned long bytes_after;
+};
+/* Force compiler into not being able to resolve size at compile-time. */
+static volatile int unconst = 0;
+
+static void strlen_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	int i, end = sizeof(pad.buf) - 1;
+
+	skip_without_fortify();
+
+	fortify_read_overflows = 0;
+
+	/* Fill 31 bytes with valid characters. */
+	for (i = 0; i < sizeof(pad.buf) - 1; i++)
+		pad.buf[i] = i + '0';
+	/* Trailing bytes are still %NUL. */
+	KUNIT_EXPECT_EQ(test, pad.buf[end], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* String is terminated, so strlen() is valid. */
+	KUNIT_EXPECT_EQ(test, strlen(pad.buf), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+
+	/* Make string unterminated, and recount. */
+	pad.buf[end] = 'A';
+	end = sizeof(pad.buf);
+	KUNIT_EXPECT_EQ(test, strlen(pad.buf), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+}
+
+static void strnlen_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	int i, end = sizeof(pad.buf) - 1;
+
+	skip_without_fortify();
+
+	fortify_read_overflows = 0;
+
+	/* Fill 31 bytes with valid characters. */
+	for (i = 0; i < sizeof(pad.buf) - 1; i++)
+		pad.buf[i] = i + '0';
+	/* Trailing bytes are still %NUL. */
+	KUNIT_EXPECT_EQ(test, pad.buf[end], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* String is terminated, so strnlen() is valid. */
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, sizeof(pad.buf)), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* A truncated strnlen() will be safe, too. */
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, sizeof(pad.buf) / 2),
+					sizeof(pad.buf) / 2);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+
+	/* Make string unterminated, and recount. */
+	pad.buf[end] = 'A';
+	end = sizeof(pad.buf);
+	/* Reading beyond with strncpy() will fail. */
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 1), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 2), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+
+	/* Early-truncated is safe still, though. */
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+
+	end = sizeof(pad.buf) / 2;
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void strcpy_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[sizeof(pad.buf) + 1] = { };
+	int i;
+
+	skip_without_fortify();
+
+	/* Fill 31 bytes with valid characters. */
+	for (i = 0; i < sizeof(src) - 2; i++)
+		src[i] = i + '0';
+
+	fortify_read_overflows = 0;
+	fortify_write_overflows = 0;
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strcpy() 1 less than of max size. */
+	KUNIT_ASSERT_TRUE(test, strcpy(pad.buf, src)
+				== pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Only last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	src[sizeof(src) - 2] = 'A';
+	/* But now we trip the overflow checking. */
+	KUNIT_ASSERT_TRUE(test, strcpy(pad.buf, src)
+				== pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	/* Trailing %NUL -- thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	src[sizeof(src) - 1] = 'A';
+	/* And for sure now, two bytes past. */
+	KUNIT_ASSERT_TRUE(test, strcpy(pad.buf, src)
+				== pad.buf);
+	/*
+	 * Which trips both the strlen() on the unterminated src,
+	 * and the resulting copy attempt.
+	 */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	/* Trailing %NUL -- thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strncpy_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[] = "Copy me fully into a small buffer and I will overflow!";
+
+	skip_without_fortify();
+
+	fortify_write_overflows = 0;
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strncpy() 1 less than of max size. */
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
+					sizeof(pad.buf) + unconst - 1)
+				== pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Only last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Legitimate (though unterminated) max-size strncpy. */
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
+					sizeof(pad.buf) + unconst)
+				== pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* No trailing %NUL -- thanks strncpy API. */
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* But we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Now verify that FORTIFY is working... */
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
+					sizeof(pad.buf) + unconst + 1)
+				== pad.buf);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And further... */
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
+					sizeof(pad.buf) + unconst + 2)
+				== pad.buf);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strlcpy_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[] = "Copy me fully into a small buffer and I will overflow!";
+	char tiny[4] = "abcd";
+
+	skip_without_fortify();
+
+	fortify_read_overflows = 0;
+	fortify_write_overflows = 0;
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strlcpy() 1 less than of max size. */
+	KUNIT_ASSERT_EQ(test, strlcpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst - 1),
+			sizeof(src) - 1);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Keeping space for %NUL, last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Legitimate max-size strlcpy. */
+	KUNIT_ASSERT_EQ(test, strlcpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst),
+			sizeof(src) - 1);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* A trailing %NUL will exist. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+
+	/* Now verify that FORTIFY is working... */
+	KUNIT_ASSERT_EQ(test, strlcpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst + 1),
+			sizeof(src) - 1);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And much further... */
+	KUNIT_ASSERT_EQ(test, strlcpy(pad.buf, src,
+				      sizeof(src) * 2 + unconst),
+			sizeof(src) - 1);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Catch over-read. */
+	KUNIT_ASSERT_EQ(test, strlcpy(pad.buf, tiny,
+				      sizeof(pad.buf) + unconst),
+			sizeof(tiny));
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+}
+
+static void strscpy_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[] = "Copy me fully into a small buffer and I will overflow!";
+
+	skip_without_fortify();
+
+	fortify_write_overflows = 0;
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strscpy() 1 less than of max size. */
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst - 1),
+			-E2BIG);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Keeping space for %NUL, last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Legitimate max-size strscpy. */
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst),
+			-E2BIG);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* A trailing %NUL will exist. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+
+	/* Now verify that FORTIFY is working... */
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst + 1),
+			-E2BIG);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And much further... */
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
+				      sizeof(src) * 2 + unconst),
+			-E2BIG);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strcat_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[sizeof(pad.buf) / 2] = { };
+	char one[] = "A";
+	char two[] = "BC";
+	int i;
+
+	skip_without_fortify();
+
+	fortify_write_overflows = 0;
+
+	/* Fill 15 bytes with valid characters. */
+	for (i = 0; i < sizeof(src) - 1; i++)
+		src[i] = i + 'A';
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strcat() using less than half max size. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, src) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Legitimate strcat() now 2 bytes shy of end. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, src) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Add one more character to the end. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, one) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* And this one char will overflow. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, one) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And adding two will overflow more. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, two) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strncat_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[sizeof(pad.buf)] = { };
+	int i, partial;
+
+	skip_without_fortify();
+
+	fortify_read_overflows = 0;
+	fortify_write_overflows = 0;
+
+	/* Fill 31 bytes with valid characters. */
+	partial = sizeof(src) / 2 - 1;
+	for (i = 0; i < partial; i++)
+		src[i] = i + 'A';
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strncat() using less than half max size. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, partial) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Legitimate strncat() now 2 bytes shy of end. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, partial) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Add one more character to the end. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, 1) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* And this one char will overflow. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, 1) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And adding two will overflow more. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, 2) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Force an unterminated destination, and overflow. */
+	pad.buf[sizeof(pad.buf) - 1] = 'A';
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, 1) == pad.buf);
+	/* This will have tripped both strlen() and strcat(). */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 3);
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	/* But we should not go beyond the end. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strlcat_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[sizeof(pad.buf)] = { };
+	int i, partial;
+	int len = sizeof(pad.buf) + unconst;
+
+	skip_without_fortify();
+
+	fortify_read_overflows = 0;
+	fortify_write_overflows = 0;
+
+	/* Fill 15 bytes with valid characters. */
+	partial = sizeof(src) / 2 - 1;
+	for (i = 0; i < partial; i++)
+		src[i] = i + 'A';
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strlcat() using less than half max size. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, src, len), partial);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Legitimate strlcat() now 2 bytes shy of end. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, src, len), partial * 2);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Add one more character to the end. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, "Q", len), partial * 2 + 1);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* And this one char will overflow. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, "V", len * 2), len);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And adding two will overflow more. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, "QQ", len * 2), len + 1);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Force an unterminated destination, and overflow. */
+	pad.buf[sizeof(pad.buf) - 1] = 'A';
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, "TT", len * 2), len + 2);
+	/* This will have tripped both strlen() and strlcat(). */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	/* But we should not go beyond the end. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Force an unterminated source, and overflow. */
+	memset(src, 'B', sizeof(src));
+	pad.buf[sizeof(pad.buf) - 1] = '\0';
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, src, len * 3), len - 1 + sizeof(src));
+	/* This will have tripped both strlen() and strlcat(). */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 3);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 3);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	/* But we should not go beyond the end. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void memscan_test(struct kunit *test)
+{
+	char haystack[] = "Where oh where is my memory range?";
+	char *mem = haystack + strlen("Where oh where is ");
+	char needle = 'm';
+	size_t len = sizeof(haystack) + unconst;
+
+	skip_without_fortify();
+
+	fortify_read_overflows = 0;
+
+	KUNIT_ASSERT_PTR_EQ(test, memscan(haystack, needle, len),
+				  mem);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* Catch too-large range. */
+	KUNIT_ASSERT_PTR_EQ(test, memscan(haystack, needle, len + 1),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_ASSERT_PTR_EQ(test, memscan(haystack, needle, len * 2),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void memchr_test(struct kunit *test)
+{
+	char haystack[] = "Where oh where is my memory range?";
+	char *mem = haystack + strlen("Where oh where is ");
+	char needle = 'm';
+	size_t len = sizeof(haystack) + unconst;
+
+	skip_without_fortify();
+
+	fortify_read_overflows = 0;
+
+	KUNIT_ASSERT_PTR_EQ(test, memchr(haystack, needle, len),
+				  mem);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* Catch too-large range. */
+	KUNIT_ASSERT_PTR_EQ(test, memchr(haystack, needle, len + 1),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_ASSERT_PTR_EQ(test, memchr(haystack, needle, len * 2),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void memchr_inv_test(struct kunit *test)
+{
+	char haystack[] = "Where oh where is my memory range?";
+	char *mem = haystack + 1;
+	char needle = 'W';
+	size_t len = sizeof(haystack) + unconst;
+
+	skip_without_fortify();
+
+	fortify_read_overflows = 0;
+
+	/* Normal search is okay. */
+	KUNIT_ASSERT_PTR_EQ(test, memchr_inv(haystack, needle, len),
+				  mem);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* Catch too-large range. */
+	KUNIT_ASSERT_PTR_EQ(test, memchr_inv(haystack, needle, len + 1),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_ASSERT_PTR_EQ(test, memchr_inv(haystack, needle, len * 2),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void memcmp_test(struct kunit *test)
+{
+	char one[] = "My mind is going ...";
+	char two[] = "My mind is going ... I can feel it.";
+	size_t one_len = sizeof(one) + unconst - 1;
+	size_t two_len = sizeof(two) + unconst - 1;
+
+	skip_without_fortify();
+
+	fortify_read_overflows = 0;
+
+	/* We match the first string (ignoring the %NUL). */
+	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len), 0);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* Still in bounds, but no longer matching. */
+	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len + 1), -32);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+
+	/* Catch too-large ranges. */
+	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len + 2), INT_MIN);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+
+	KUNIT_ASSERT_EQ(test, memcmp(two, one, two_len + 2), INT_MIN);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void kmemdup_test(struct kunit *test)
+{
+	char src[] = "I got Doom running on it!";
+	char *copy;
+	size_t len = sizeof(src) + unconst;
+
+	skip_without_fortify();
+
+	fortify_read_overflows = 0;
+
+	/* Copy is within bounds. */
+	copy = kmemdup(src, len, GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	kfree(copy);
+
+	/* Without %NUL. */
+	copy = kmemdup(src, len - 1, GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	kfree(copy);
+
+	/* Tiny bounds. */
+	copy = kmemdup(src, 1, GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	kfree(copy);
+
+	/* Out of bounds by 1 byte. */
+	copy = kmemdup(src, len + 1, GFP_KERNEL);
+	KUNIT_EXPECT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	kfree(copy);
+
+	/* Way out of bounds. */
+	copy = kmemdup(src, len * 2, GFP_KERNEL);
+	KUNIT_EXPECT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+	kfree(copy);
+
+	/* Starting offset causing out of bounds. */
+	copy = kmemdup(src + 1, len, GFP_KERNEL);
+	KUNIT_EXPECT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 3);
+	kfree(copy);
+}
+
 static int fortify_test_init(struct kunit *test)
 {
 	kunit_add_named_resource(test, NULL, NULL, &read_resource,
@@ -379,6 +1096,22 @@ static struct kunit_case fortify_test_cases[] = {
 	KUNIT_CASE(alloc_size_kvmalloc_dynamic_test),
 	KUNIT_CASE(alloc_size_devm_kmalloc_const_test),
 	KUNIT_CASE(alloc_size_devm_kmalloc_dynamic_test),
+	KUNIT_CASE(strlen_test),
+	KUNIT_CASE(strnlen_test),
+	KUNIT_CASE(strcpy_test),
+	KUNIT_CASE(strncpy_test),
+	KUNIT_CASE(strlcpy_test),
+	KUNIT_CASE(strscpy_test),
+	KUNIT_CASE(strcat_test),
+	KUNIT_CASE(strncat_test),
+	KUNIT_CASE(strlcat_test),
+	/* skip memset: performs bounds checking on whole structs */
+	/* skip memcpy: still using warn-and-clobber instead of hard-fail */
+	KUNIT_CASE(memscan_test),
+	KUNIT_CASE(memchr_test),
+	KUNIT_CASE(memchr_inv_test),
+	KUNIT_CASE(memcmp_test),
+	KUNIT_CASE(kmemdup_test),
 	{}
 };
 
-- 
2.34.1

