Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E675E6DB42F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjDGT1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjDGT1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:27:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD91B7D9B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:27:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z19so40744891plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680895641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCqEfE4fF+BMO3eztdtksvLApA4/hcoAiL2AO2Jx8jE=;
        b=OX3M/cgfb49p9aUt+RUI68YYZOAp9CkoHt47Dmbxx98uIvKmfGf3dBaA8pp8pq2ITO
         lzjjSLnPNEb/pjy4QNBnWJ92X3qsc9lX+L0+eakeysaXYjxi7WE8OfFHzIM2XyxCtach
         N5uDxmje1iFdHde3TXNXWRjbku4Bt3uqCfQ7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680895641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCqEfE4fF+BMO3eztdtksvLApA4/hcoAiL2AO2Jx8jE=;
        b=Nhj5nvAeKYLJqJAk8+dijXQwLEi943EfnNBQob8MLT50J7yl337WGU4oqZSS8+S+/R
         lL4xEPvP0+Fs/ELGIYEuDltAyMiyWcYzUHArRjFxpcFdglrdr+WNsnf93J+UvWmeTybN
         CPzuiOly73kSXoezW2ab8NrSUsfMzh8e57R++H9xyYV5fsUtvap+hDHBmDFzTmQID/n7
         kOk6qq9r6+KRhZzCjBUhr9OWqeXv8QAz0MkcQkWNKQktU2qRv1U8wRSiy5/1Fa4vAgCc
         LDvn5ZoUkjAMkrUmKNZEUnpWMah34qhtqeTw4ZrjD98IrQyyeKWujQI9H87w4IKkwxTV
         Metg==
X-Gm-Message-State: AAQBX9c0yv7uDNgA6ncsHQ8tQPKQXSxmLxHIW2OAbQ/tBltLNywl13xB
        6dIfP62WNxlUbsrGM/kkHlw9uw==
X-Google-Smtp-Source: AKy350bjtjw5AGqYagHL7I5B6JAL1NMTHI3kKf2X4CBIP1qmaxR6OLAaaGq2m1B3qWyJw3qwLcEskw==
X-Received: by 2002:a05:6a20:be04:b0:d8:a1c9:c9bc with SMTP id ge4-20020a056a20be0400b000d8a1c9c9bcmr4044320pzb.25.1680895641278;
        Fri, 07 Apr 2023 12:27:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f5-20020aa78b05000000b0062d8c855ee9sm3498171pfd.149.2023.04.07.12.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:27:18 -0700 (PDT)
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
Subject: [PATCH v2 03/10] string: Add Kunit tests for strcat() family
Date:   Fri,  7 Apr 2023 12:27:09 -0700
Message-Id: <20230407192717.636137-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407191904.gonna.522-kees@kernel.org>
References: <20230407191904.gonna.522-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5622; h=from:subject; bh=d0/+ooOvDGbjHMvg1I4tGXInlU+netRGkDw9mqAzd+o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkMG6TM3Sr8YBDzEUgHpm9Qr7os7WBitixulj8nyjt 4IeCxByJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZDBukwAKCRCJcvTf3G3AJpXDD/ 9UN2Ut16jFY359dFCbJjLXQb706yyaKLP/jKphDrnKusXpsMKZtx7ddsCcggAGrsFG8P8Mw97dEgOK KrKDzpv6YrAOd0BVd8olFxWKJehE1xiHdKxF3AYFaGm6nI/1iN9CTtHsKDhOE0WOovrB6TaTld5WXU KmrUJYC8cVxXI+f5SODkl7+1GC2zhlP8oQlTAwnHxT6eTUAj8omY2igdi7t3Wmwesl2hrNXBG6TkCY HsgcYW5reqdSl6TFYO/ftLyFNh/uoki30fnkB5FKopLtThS3kRapKJVVcibBEvHV61YLNauvCxF9yD M0dvpw9BSJhchgp9SrlVXtbkdq6MMUuPbhOZWKBpkqebN8Lc5zF8+xg91vKx36ehiuOmlYSL7O0hke cBtEdg9JwgUp/jnWx6+Z/Ut75zSbIrwE4HrX1vHeQ/CHSxxoCMcRexL0RXlxTJVHDUyf7HmaBPvfwQ SOiJ66o2n8RtaLnlKQpa/B0+THyl1bhcGg3Gc8Fc3I97QAeAcIvNpgNcU23B+R1lf+eqr91Odo+wkX 1pKBjP3ui1+Fnin30M836PZ0E/dY7utp3JrnqWI7YrtNgRbcZyoD/9Dv44/+YLxqjG6xkY5symZcBa IlfNB+lCBxYGxpvbYa2w/fpcL0nLMJ6QVrZiRZyDYnAAfKE+zGFXyW2Uetgg==
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

Add tests to make sure the strcat() family of functions behave
correctly.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS        |   1 +
 lib/Kconfig.debug  |   5 +++
 lib/Makefile       |   1 +
 lib/strcat_kunit.c | 104 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+)
 create mode 100644 lib/strcat_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ec57c42ed544..86c0012b5130 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8021,6 +8021,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/har
 F:	include/linux/fortify-string.h
 F:	lib/fortify_kunit.c
 F:	lib/memcpy_kunit.c
+F:	lib/strcat_kunit.c
 F:	lib/strscpy_kunit.c
 F:	lib/test_fortify/*
 F:	scripts/test_fortify.sh
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d48a5f4b471e..86157aa5e979 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2631,6 +2631,11 @@ config HW_BREAKPOINT_KUNIT_TEST
 
 	  If unsure, say N.
 
+config STRCAT_KUNIT_TEST
+	tristate "Test strcat() family of functions at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+
 config STRSCPY_KUNIT_TEST
 	tristate "Test strscpy*() family of functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index baf2821f7a00..6582d8fe1a77 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -389,6 +389,7 @@ obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, unsequenced)
 CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
+obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
 obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 
diff --git a/lib/strcat_kunit.c b/lib/strcat_kunit.c
new file mode 100644
index 000000000000..e21be95514af
--- /dev/null
+++ b/lib/strcat_kunit.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kernel module for testing 'strcat' family of functions.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+#include <linux/string.h>
+
+static volatile int unconst;
+
+static void strcat_test(struct kunit *test)
+{
+	char dest[8];
+
+	/* Destination is terminated. */
+	memset(dest, 0, sizeof(dest));
+	KUNIT_EXPECT_EQ(test, strlen(dest), 0);
+	/* Empty copy does nothing. */
+	KUNIT_EXPECT_TRUE(test, strcat(dest, "") == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+	/* 4 characters copied in, stops at %NUL. */
+	KUNIT_EXPECT_TRUE(test, strcat(dest, "four\000123") == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "four");
+	KUNIT_EXPECT_EQ(test, dest[5], '\0');
+	/* 2 more characters copied in okay. */
+	KUNIT_EXPECT_TRUE(test, strcat(dest, "AB") == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
+}
+
+static void strncat_test(struct kunit *test)
+{
+	char dest[8];
+
+	/* Destination is terminated. */
+	memset(dest, 0, sizeof(dest));
+	KUNIT_EXPECT_EQ(test, strlen(dest), 0);
+	/* Empty copy of size 0 does nothing. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "", 0 + unconst) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+	/* Empty copy of size 1 does nothing too. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "", 1 + unconst) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+	/* Copy of max 0 characters should do nothing. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "asdf", 0 + unconst) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+
+	/* 4 characters copied in, even if max is 8. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "four\000123", 8 + unconst) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "four");
+	KUNIT_EXPECT_EQ(test, dest[5], '\0');
+	KUNIT_EXPECT_EQ(test, dest[6], '\0');
+	/* 2 characters copied in okay, 2 ignored. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "ABCD", 2 + unconst) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
+}
+
+static void strlcat_test(struct kunit *test)
+{
+	char dest[8] = "";
+	int len = sizeof(dest) + unconst;
+
+	/* Destination is terminated. */
+	KUNIT_EXPECT_EQ(test, strlen(dest), 0);
+	/* Empty copy is size 0. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "", len), 0);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+	/* Size 1 should keep buffer terminated, report size of source only. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "four", 1 + unconst), 4);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+
+	/* 4 characters copied in. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "four", len), 4);
+	KUNIT_EXPECT_STREQ(test, dest, "four");
+	/* 2 characters copied in okay, gets to 6 total. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "AB", len), 6);
+	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
+	/* 2 characters ignored if max size (7) reached. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "CD", 7 + unconst), 8);
+	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
+	/* 1 of 2 characters skipped, now at true max size. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "EFG", len), 9);
+	KUNIT_EXPECT_STREQ(test, dest, "fourABE");
+	/* Everything else ignored, now at full size. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "1234", len), 11);
+	KUNIT_EXPECT_STREQ(test, dest, "fourABE");
+}
+
+static struct kunit_case strcat_test_cases[] = {
+	KUNIT_CASE(strcat_test),
+	KUNIT_CASE(strncat_test),
+	KUNIT_CASE(strlcat_test),
+	{}
+};
+
+static struct kunit_suite strcat_test_suite = {
+	.name = "strcat",
+	.test_cases = strcat_test_cases,
+};
+
+kunit_test_suite(strcat_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.34.1

