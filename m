Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436AD6D8B5A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjDFAC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjDFACT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:02:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C859E3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:02:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id fb38so24781371pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 17:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680739337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihHu/77nnwOlD0yIDOkgSICbQg4UYxIlXHTf7scrixI=;
        b=C+wnnFr1hwIr9HKbn6ntv8TFTvMwzfAwoDQnZM0sBfu9WX+uzyklLEx4XcRwUridjf
         /g3NAUcd1BBTIaKOaILN+Hr5Ysj2wpFac9yWZZ1XUWEjJBeUCaAmm/SvaJb7Qzd3DWI+
         Fc9fqIxEG0Gjo9RQFjgPkvsQe4gYKXJmbZ2kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihHu/77nnwOlD0yIDOkgSICbQg4UYxIlXHTf7scrixI=;
        b=HIdZv4bIXI4+YPIYoaAmKfIChvx0/NoHb6+40+hIbji+LBKCl5TwkVHmVmDim19cLd
         hAbelIKTYQIuc5A7DZI/5rLDibpP6oPAaTBZ90EFflkY/qoZ3JoADd/zGOnQATIqiuxB
         bUcX1/kaOo0sEcnUrtT0LVr99EmB6urWC0G79EWTTLdigQAatPOVdh4xd2af3JOswyQ9
         8qfcyKC1c3LHK7LarBlZco055/eq94QP0KK7jU56aWJ27GVUReLl3hUCPQMfevFhsZzi
         P/zZiQJusLnvwKabVNq/Pncag+Qc+6kEAvF+gBoJH8yWoMrinNTES5Bo1PTyT4sM5fiX
         LtrA==
X-Gm-Message-State: AAQBX9dw/ipayXsgxtnxm07FGRHPmF46ZEDbsmTjKdfT3Y5vWWd25Z8G
        2dIa+KMJc+zPRzheZsvkJ/p0dA==
X-Google-Smtp-Source: AKy350bu+D5tm8a2pBp6SySsMEwThkWPnl59XxSW4bom/2xnxgS0kO4ReDQvA0MNoBkL8lT7ZGafPg==
X-Received: by 2002:aa7:9423:0:b0:627:8e40:68d8 with SMTP id y3-20020aa79423000000b006278e4068d8mr7319771pfo.18.1680739337281;
        Wed, 05 Apr 2023 17:02:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n9-20020aa79049000000b00625e885a6ffsm11635623pfo.18.2023.04.05.17.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 17:02:13 -0700 (PDT)
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
Subject: [PATCH 3/9] string: Add Kunit tests for strcat() family
Date:   Wed,  5 Apr 2023 17:02:02 -0700
Message-Id: <20230406000212.3442647-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405235832.never.487-kees@kernel.org>
References: <20230405235832.never.487-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5480; i=keescook@chromium.org; h=from:subject; bh=TwKlXl0mlDA9aUwwDPbJaiGBGoVKgl4jR+SCssFeKos=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkLgv/w9lYG8TKO2pLdSGWjeJdz4gWEQKB8J8NlI2U lCXR/oeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZC4L/wAKCRCJcvTf3G3AJkrPD/ 4tWkIiWa0xJaDvh14pSs0DPg5BaVbTIgpacy939WxRJYFB5IqVFbROCHrjrYPvw3RbO6Ur7PXfzA83 oVE0L4cdpb8ja3B7YicriDJnvI9DGSOytYgPGFOLXEzhgtgMywfa1RGUMu8xzJuX5GDyXoWD/0iNva MwIa+kUhPmik2QkyZBjjeBkryhnkaWcvn6so+24JKCPwvrnNEUpCGHFqG1QkM8KYF/WLBipLNCKopu RVYonEVOmVAjppym0p8STjAGhyJwrdOX6gizbCAoxgx74o1s3YQudGTloGoNOUvkrBtxOj66rFnFvj K4SWyZcQNeK7+W6hU2WHGeLiYMCVuqgyaeY+TKWfskT0fFbzjpAEp/VKsXFU0+8kwY4w09fYIreqhK Hpd24C9DQEbuc53RJ3gjcKjCHTrDgfIBn3lh8truyL/r68oF9npR5sgw8gsj2qM9GsM4T4iOCjmh/a AGKFFNNxtgNEbVQgiYdiFcDOMzI3rAHSyn7Bks/TVznBw75Jmlni9DddObi51AR39rGooGMB47Hh0c HWt6CsKuw3zBZIdfS/QrNvsx1Kufr+Xlt4edUaxBXh4kJGif10BfKXIqQjnUrJrpI9lYfw701wB7lo WI58U+HyG+iORfD+4byCR0LnU1t7yxCe6NnjLehv6DvuMISjiqxfBJQwj2oQ==
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

Add tests to make sure the strcat() family of functions behave
correctly.

Signed-off-by: Kees Cook <kees@outflux.net>
---
 MAINTAINERS        |   1 +
 lib/Kconfig.debug  |   5 +++
 lib/Makefile       |   1 +
 lib/strcat_kunit.c | 100 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+)
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
index 000000000000..b6428c3a557f
--- /dev/null
+++ b/lib/strcat_kunit.c
@@ -0,0 +1,100 @@
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
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "", 0) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+	/* Empty copy of size 1 does nothing too. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "", 1) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+	/* Copy of max 0 characters should do nothing. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "asdf", 0) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+
+	/* 4 characters copied in, even if max is 8. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "four\000123", 8) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "four");
+	KUNIT_EXPECT_EQ(test, dest[5], '\0');
+	/* 2 characters copied in okay, 2 ignored. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "ABCD", 2) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
+}
+
+static void strlcat_test(struct kunit *test)
+{
+	char dest[8] = "";
+
+	/* Destination is terminated. */
+	KUNIT_EXPECT_EQ(test, strlen(dest), 0);
+	/* Empty copy is size 0. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "", sizeof(dest)), 0);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+	/* Size 1 should keep buffer terminated, report size of source only. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "four", 1), 4);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+
+	/* 4 characters copied in. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "four", sizeof(dest)), 4);
+	KUNIT_EXPECT_STREQ(test, dest, "four");
+	/* 2 characters copied in okay, gets to 6 total. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "AB", sizeof(dest)), 6);
+	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
+	/* 2 characters ignored if max size (7) reached. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "CD", 7), 8);
+	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
+	/* 1 of 2 characters skipped, now at true max size. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "EFG", sizeof(dest)), 9);
+	KUNIT_EXPECT_STREQ(test, dest, "fourABE");
+	/* Everything else ignored, now at full size. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "1234", sizeof(dest)), 11);
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

