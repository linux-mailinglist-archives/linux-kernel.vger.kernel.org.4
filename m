Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E483D6DB42C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjDGT1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDGT1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:27:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3807DB47D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:27:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o11so40758531ple.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680895639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iceky2qZBmmPvb+84ZhVCagAV37KBLs6ikPPwI/vVU=;
        b=LPbqMcG9W63inybkR1IO+JjW/8sCJ47LPwDmEyXhUpWSy1fntw5h/1h7xZsPDgdd70
         mFP3DM413LFcwH9H7Ql3Ey8aU6Dgk3sZuG3MLwLccmbH6W5NANpZrUqjzeUr30SNkTWC
         YRVicFBycx5jr5GjrNes2ZqBKlQnP6T++wYlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680895639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iceky2qZBmmPvb+84ZhVCagAV37KBLs6ikPPwI/vVU=;
        b=XubG8B2E4rX5PT0uIukIvWBmcgwd3+KZPLVbeKILakWD/DMFcthDAS/5e9b7VCgdUG
         6TOMAbqZRDagmV7W7ii5bKBHjadX+FFgQZC7dFPNtu3uTVhDuDkvSmd01IPPkZbmjeMz
         atykRbK8KrgHbIMmx2sJehQwfH7IoS6zHHnyTNDnA/ZEDLg7PGdD6bKzL7psVu9GEqw+
         oq9ar9xRfbDNX/qFqvV00GN0PnA2NYHWuUSZmhqKfZnFc1KmHiiPmM+eLdgdt8hNkiJc
         ICvasVjDT6yAXpcMTakT9XPcRVi1STtP5kYHLswlex2DBqctpZB31Zm4ZqIT/PlH2W6S
         8XIQ==
X-Gm-Message-State: AAQBX9eUXOsyI13FIwnZp82hQshDRa5ntmUFr0ZJUheIgtVh1WJaAW3N
        7hTSl9XTc6gOo1GDtgcXeREicA==
X-Google-Smtp-Source: AKy350aShXShg+rC+CAz781JC0+6J+BvF9ozBrLq7uaabaeLnQY51uyEREZJGjnvjWTRSKsuNNwPUw==
X-Received: by 2002:a05:6a20:b98:b0:e8:fe82:583a with SMTP id i24-20020a056a200b9800b000e8fe82583amr1487041pzh.26.1680895639635;
        Fri, 07 Apr 2023 12:27:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g5-20020aa78745000000b0061949fe3beasm3411886pfo.22.2023.04.07.12.27.17
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
Subject: [PATCH v2 02/10] fortify: Allow KUnit test to build without FORTIFY
Date:   Fri,  7 Apr 2023 12:27:08 -0700
Message-Id: <20230407192717.636137-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407191904.gonna.522-kees@kernel.org>
References: <20230407191904.gonna.522-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116; h=from:subject; bh=ccG2bNY7K5BZtbleuqiKVnIVFX8WC48jOVbBodSXYXk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkMG6TM2zrha7Ipa7uDmzoHRpb9RWuePb2XGcS7CJv en17kyyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZDBukwAKCRCJcvTf3G3AJn7YEA CER3124RngLsuvZqHAvpzkO00CzkPYu9RLFpI3cKRivKzkUkR5wxM/NC00ecF5sxvG6Sw9DWeJkVeN MNAKx38AC1EyPN5nmnhxbVnhwcU/PJJleVj1Bw2t+U/rE3Xara/ECkj6yX3aysw+2xJJYT8XpQch+t TwZ4XmilZ9le6Rfj+YioA9Jmiu0dEVO79l+reOQ+9/NTEiy6t3hYxx9cfE8iX841bZvCuo9ziloHeU 3uUHoE7RxPec0fqA6a/n72NL/aHNWTE3GthVRhAqFnK6jgRLgecdcVo6tCqFJJ2Pus2z+hbqaHbPlQ u45gFLyO+AfC9lFZLk7N6sNhThbzDS4Bbz5cRlT7SQBBlX9XVJYaY9pY2+NZTX6dumTtEM7Qf9h0DB VMdagi6uXGY6TOH9j2kTlVN+mbWiNJO2TL1i8hAWHTEe3iNqFyIQQ2bNRmCMoK4mr2jaSwsg3IwS2V okMgL1acUel87FDPsB8puAJleQ2eavuclaC5L+GwcD5jjK1mV9LKyLHBZkTMFA8vnVJaUiMWQKchEB gc7bmlmT1U3USfTbreSenFr4OqEa5mIZf5TTZEDibWczL9S5mgdhNUjRKasbVlvYz81KO7TsBLVi40 w9bldPkvRyN/Nl0lag1fccQ2jP219rdmt2y+n8cwtBr7dRkvTm+GGl90Tdbg==
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

In order for CI systems to notice all the skipped tests related to
CONFIG_FORTIFY_SOURCE, allow the FORTIFY_SOURCE KUnit tests to build
with or without CONFIG_FORTIFY_SOURCE.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.debug   |  2 +-
 lib/fortify_kunit.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c8b379e2e9ad..d48a5f4b471e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2614,7 +2614,7 @@ config STACKINIT_KUNIT_TEST
 
 config FORTIFY_KUNIT_TEST
 	tristate "Test fortified str*() and mem*() function internals at runtime" if !KUNIT_ALL_TESTS
-	depends on KUNIT && FORTIFY_SOURCE
+	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
 	  Builds unit tests for checking internals of FORTIFY_SOURCE as used
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index c8c33cbaae9e..524132f33cf0 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -25,6 +25,11 @@ static const char array_of_10[] = "this is 10";
 static const char *ptr_of_11 = "this is 11!";
 static char array_unknown[] = "compiler thinks I might change";
 
+/* Handle being built without CONFIG_FORTIFY_SOURCE */
+#ifndef __compiletime_strlen
+# define __compiletime_strlen __builtin_strlen
+#endif
+
 static void known_sizes_test(struct kunit *test)
 {
 	KUNIT_EXPECT_EQ(test, __compiletime_strlen("88888888"), 8);
@@ -307,6 +312,14 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 
+static int fortify_test_init(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
+		kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=y");
+
+	return 0;
+}
+
 static struct kunit_case fortify_test_cases[] = {
 	KUNIT_CASE(known_sizes_test),
 	KUNIT_CASE(control_flow_split_test),
@@ -323,6 +336,7 @@ static struct kunit_case fortify_test_cases[] = {
 
 static struct kunit_suite fortify_test_suite = {
 	.name = "fortify",
+	.init = fortify_test_init,
 	.test_cases = fortify_test_cases,
 };
 
-- 
2.34.1

