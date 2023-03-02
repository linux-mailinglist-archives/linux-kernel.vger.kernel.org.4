Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8018E6A8C42
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCBWyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCBWyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:54:50 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA811B2E2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:54:48 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id bn17so403813pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677797688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u2JRIgyoI3LG7ExFh5qUTdxbB5N+rDjbtaVJKTM4FGg=;
        b=ZRgJuMA/fQKk05iFza42jJH+7v8m6WLj7Y6PW2elWQDxLzrrB8AIr5lDRsP8VnuXVN
         rJPiHHWN3O1ya1BQCMKJ+tbSlzVBhubn5U+J9Fcbwv19NLhaHehmctR4b/akjO/PJjh5
         RdIPYeAhrbFnidkd+uGgbwkALes5aULSbkkBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677797688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2JRIgyoI3LG7ExFh5qUTdxbB5N+rDjbtaVJKTM4FGg=;
        b=kLOOUCvJKDMuP0cCwVZ/SswkMb+rLnKIAZTpwlXr6Y+U13dDL1X0+2bL4ekQ7q6H2e
         Y2lMb9KYDsKnuyIjxUGc7XZCSzb+8hkRn7WyUFvYLqHh28+7Lk06FkKa5isIesINXA7i
         4NmiyYzbU3jCGIT3rFETMvusIyYrBstE7GnS6hz+vdEBAtri8nW7U6ODW3JGrWZvwv8l
         Iv+8ikwT+4qLbjl94eBiVlBCUp70MsKalMdr5ajPAcD9SH8z8rTm3AfrZhpEax60cbnd
         Ks1cEjn9iSgdkJeMshp3JgE8RpyI9IiQGeDS34/yksABiD7erO1MBE9rKYv113kziXG2
         azyg==
X-Gm-Message-State: AO0yUKUcRDjFDYFH/jeIa6ThQeE5FqYDtpYuXcvjrBz9KHWcOAUP+dqm
        H+w6w0dyRxcBdhVOGYMWrE2UIg==
X-Google-Smtp-Source: AK7set9WtD/j4O/ovPP1ZZjoBYPmLhyqfNrov+AFG7LCOlOoZCF1E5LcP7RwmFw+/RjghZHDnTH1Cw==
X-Received: by 2002:a62:1c86:0:b0:5e3:a299:da83 with SMTP id c128-20020a621c86000000b005e3a299da83mr75169pfc.19.1677797687906;
        Thu, 02 Mar 2023 14:54:47 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v15-20020a62a50f000000b005b02ddd852dsm198884pfm.142.2023.03.02.14.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:54:47 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] ubsan: Tighten UBSAN_BOUNDS on GCC
Date:   Thu,  2 Mar 2023 14:54:45 -0800
Message-Id: <20230302225444.never.053-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4864; h=from:subject:message-id; bh=fiHZshvhhBKge+wRDtZOMOzuLFEr4J5rZ3Gf/YuSg5M=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkASk1DfXP5RuMcAAZwINXn4av0e/T7Lrav7dZ437c Q1HmfpSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZAEpNQAKCRCJcvTf3G3AJj31D/ 9BTfaAD5NLjFsFdk12+iIZ7uD1uZEcSbqdoJ7lGo7+gHmqfLYRh8NLk6aC+Y5XuNYLenexfMHd++iL 549RaiWK0GMjdrjruhZt2eCaYNzIf3IdiWiMD/MsLFFI9ZXv4TboLjnmaP0E/ZfcqmoHh4vYbevZrr vJ4gMJ+5PueShbCXZgmfyK2POQqJgNRdRvYlIotpMXRgJLXtSYpvYNXr/blNV9vKnkXFNSnxFkvU1z CZwFDlPDtoQNEomhI6iXD9K3Rft4CxC+viOjpGeQ3wB4aoWN59HyszKR7zN2bEn9snIBnQ08CRcBJl Enn79lEZcyVoHR8sKowxKnm8aRK74yLdShiilCj4/500Qzuz7mYYVC0UbhPQiEZx6gaI/E912x+UUP +bLVXqcBzQha7xRWV3LotWF1zyxOz/9nM5RYTArt1LLJLh+PovKta7kh7gxCMl6Abj9PUCRUwFoZBo ccy31dmawOpHfBmKjZi8lipwiZQ/SRs8I0d6q2Jgho8uYwU5S5uP0IQE1/XnjjQPm9tvdtC5Nwl98G qSjqqk+dtEBJb5gn5ogtJwMkqwlmd+AUTgBxGMoHrBfSVTZWG1ye4G9y99qaqP6ZwnuMIMihAGUbw2 Xq1FBo7M+pfLf/dmIk1FcwbOfVfZiWrh8xa7PQ+ndqYgGoX2zJwKzZoeZ8yg==
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

The use of -fsanitize=bounds on GCC will ignore some trailing arrays,
leaving a gap in coverage. Switch to using -fsanitize=bounds-strict to
match Clang's stricter behavior.

Cc: Marco Elver <elver@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Tom Rix <trix@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: linux-kbuild@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.ubsan      | 54 +++++++++++++++++++++++-------------------
 scripts/Makefile.ubsan |  2 +-
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index fd15230a703b..9d3e87a0b6d1 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -27,16 +27,27 @@ config UBSAN_TRAP
 	  the system. For some system builders this is an acceptable
 	  trade-off.
 
-config CC_HAS_UBSAN_BOUNDS
-	def_bool $(cc-option,-fsanitize=bounds)
+config CC_HAS_UBSAN_BOUNDS_STRICT
+	def_bool $(cc-option,-fsanitize=bounds-strict)
+	help
+	  The -fsanitize=bounds-strict option is only available on GCC,
+	  but uses the more strict handling of arrays that includes knowledge
+	  of flexible arrays, which is comparable to Clang's regular
+	  -fsanitize=bounds.
 
 config CC_HAS_UBSAN_ARRAY_BOUNDS
 	def_bool $(cc-option,-fsanitize=array-bounds)
+	help
+	  The -fsanitize=array-bounds option is only available on Clang,
+	  and is actually composed of two more specific options,
+	  -fsanitize=array-bounds and -fsanitize=local-bounds. However,
+	  -fsanitize=local-bounds can only be used when trap mode is
+	  enabled. (See also the help for CONFIG_LOCAL_BOUNDS.)
 
 config UBSAN_BOUNDS
 	bool "Perform array index bounds checking"
 	default UBSAN
-	depends on CC_HAS_UBSAN_ARRAY_BOUNDS || CC_HAS_UBSAN_BOUNDS
+	depends on CC_HAS_UBSAN_ARRAY_BOUNDS || CC_HAS_UBSAN_BOUNDS_STRICT
 	help
 	  This option enables detection of directly indexed out of bounds
 	  array accesses, where the array size is known at compile time.
@@ -44,33 +55,26 @@ config UBSAN_BOUNDS
 	  to the {str,mem}*cpy() family of functions (that is addressed
 	  by CONFIG_FORTIFY_SOURCE).
 
-config UBSAN_ONLY_BOUNDS
-	def_bool CC_HAS_UBSAN_BOUNDS && !CC_HAS_UBSAN_ARRAY_BOUNDS
-	depends on UBSAN_BOUNDS
+config UBSAN_BOUNDS_STRICT
+	def_bool UBSAN_BOUNDS && CC_HAS_UBSAN_BOUNDS_STRICT
 	help
-	  This is a weird case: Clang's -fsanitize=bounds includes
-	  -fsanitize=local-bounds, but it's trapping-only, so for
-	  Clang, we must use -fsanitize=array-bounds when we want
-	  traditional array bounds checking enabled. For GCC, we
-	  want -fsanitize=bounds.
+	  GCC's bounds sanitizer. This option is used to select the
+	  correct options in Makefile.ubsan.
 
 config UBSAN_ARRAY_BOUNDS
-	def_bool CC_HAS_UBSAN_ARRAY_BOUNDS
-	depends on UBSAN_BOUNDS
+	def_bool UBSAN_BOUNDS && CC_HAS_UBSAN_ARRAY_BOUNDS
+	help
+	  Clang's array bounds sanitizer. This option is used to select
+	  the correct options in Makefile.ubsan.
 
 config UBSAN_LOCAL_BOUNDS
-	bool "Perform array local bounds checking"
-	depends on UBSAN_TRAP
-	depends on $(cc-option,-fsanitize=local-bounds)
-	help
-	  This option enables -fsanitize=local-bounds which traps when an
-	  exception/error is detected. Therefore, it may only be enabled
-	  with CONFIG_UBSAN_TRAP.
-
-	  Enabling this option detects errors due to accesses through a
-	  pointer that is derived from an object of a statically-known size,
-	  where an added offset (which may not be known statically) is
-	  out-of-bounds.
+	def_bool UBSAN_ARRAY_BOUNDS && UBSAN_TRAP
+	help
+	  This option enables Clang's -fsanitize=local-bounds which traps
+	  when an access through a pointer that is derived from an object
+	  of a statically-known size, where an added offset (which may not
+	  be known statically) is out-of-bounds. Since this option is
+	  trap-only, it depends on CONFIG_UBSAN_TRAP.
 
 config UBSAN_SHIFT
 	bool "Perform checking for bit-shift overflows"
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 7099c603ff0a..4749865c1b2c 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -2,7 +2,7 @@
 
 # Enable available and selected UBSAN features.
 ubsan-cflags-$(CONFIG_UBSAN_ALIGNMENT)		+= -fsanitize=alignment
-ubsan-cflags-$(CONFIG_UBSAN_ONLY_BOUNDS)	+= -fsanitize=bounds
+ubsan-cflags-$(CONFIG_UBSAN_BOUNDS_STRICT)	+= -fsanitize=bounds-strict
 ubsan-cflags-$(CONFIG_UBSAN_ARRAY_BOUNDS)	+= -fsanitize=array-bounds
 ubsan-cflags-$(CONFIG_UBSAN_LOCAL_BOUNDS)	+= -fsanitize=local-bounds
 ubsan-cflags-$(CONFIG_UBSAN_SHIFT)		+= -fsanitize=shift
-- 
2.34.1

