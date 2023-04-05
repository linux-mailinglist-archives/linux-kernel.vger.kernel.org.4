Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656B56D7261
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbjDECYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjDECYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:24:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90B246B4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 19:24:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w4so33080003plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 19:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680661443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gE096tbbtegWsFsNSRWQe6szhT/Ie2gS6GnCnw+q6nk=;
        b=lhVtRJy2kAsB1GaC5KfK+0pirxSB6oDFSixG0x3X1FfItOSi0+ukF3YXzpuQYCbPQA
         y0scIOfAr07Xvbt0AxIdbtbIzn5/YVCCiGSPljzw7Cx4kBWnjz6GlFl5jYG7UmtJfIet
         roub5J7g8iw2CYtKESulYuOy4tJAUdU9w0xS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680661443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gE096tbbtegWsFsNSRWQe6szhT/Ie2gS6GnCnw+q6nk=;
        b=X/roi3Qwc7QJD9ytmcrBfY+5wAicV3BqlYGoj8FM/XWjDUxECDy3DqT8mw+sVcpnNF
         z5EnwycBxqo/St2HGOsQtG2FhPIvVs1Fz9RukvjXCF6Cq46PVOny5cfeOLGs5Oh2DGgc
         lJI4OS1T3vVGCJgQNfQJhnJQZaeuYOvI+GRdgllVq+DHbaG0xgdxnTGTTChBpzK3K6aq
         rLrVDx9Lu4vJKDcfATOO53v6ZnVLJmuFAlB0oQrLTAZ52vsk6TCxagPY0md/v1WZJK9C
         ot+Wo8e12/6+hyVW7CUVKGwjkbes4zYp1eHnE9jDrb2LkngsH9j+ehP0dK7lQ1dpdlfQ
         /dWg==
X-Gm-Message-State: AAQBX9cKnyHhtBkFJrq9bGJ6cpqUCTlmKSjOMtFi5En1/FV47+HmoUyP
        hCd/lQzFdjMHRQXv3WYwGz7Vaw==
X-Google-Smtp-Source: AKy350bszIXwKxf3DRMbVNx2JAkaypaKo50esXSu/LfCtTSKytiwFU5u7bEWiULWHWpfRU3fEA0r1Q==
X-Received: by 2002:a17:90b:4d8c:b0:23d:31c3:c9a4 with SMTP id oj12-20020a17090b4d8c00b0023d31c3c9a4mr5050686pjb.26.1680661443098;
        Tue, 04 Apr 2023 19:24:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d17-20020a17090ad3d100b0023cfa3f7c9fsm238204pjw.10.2023.04.04.19.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 19:24:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] ubsan: Tighten UBSAN_BOUNDS on GCC
Date:   Tue,  4 Apr 2023 19:23:59 -0700
Message-Id: <20230405022356.gonna.338-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5095; h=from:subject:message-id; bh=DBjfeXxQtW9VJ4aQuL4Gd8SY0x0mddkkuOVfELeFHFY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkLNu/MDRN9xOaI1ECqP5sHrBCWmfraRQppPeauIpP LfAoNyuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZCzbvwAKCRCJcvTf3G3AJiRGD/ 9GCblVh+rJ+X9fKxstnSMt5g50rvZ8boQ9jGquDwwRBPpjQBUmfUEu7Hbdr8ebTYfs3Dqk2oeyzBZ3 nlk1pUUOquhlYmykziGexGPPkOC2d5vRxsfJYKIeHG4w10GDvipj/gG83VRAQZUt0xKoQs6WCLNsbp M657SX1rxhqGi6u6ewxDxE23rf8uOvmmn0cOCYKcufAdufamxphOSQHvfsFmxIM6NXV9bVQFtyn6Cr WiOaMa6SvP8PRdD5fv7YGXSzmDbhU1l/ru1LNWK+xGa36s4SJHVeu5Iv3UBZXwk+9LA3VfvHoaIMsv 8w2sPe6V//sMG8q8churBvO4ZBO3zqMpgYxzCAHVOyv4opKptJnqlY9j4la8Osn7xfi+XPtC0uzltU hgkJm9CFbgyoaC7gplFIbQycJVvtPRLgSo7smzZ1cQchP4C+H2nTNzUCQ/Q7Uo9pIe/OZ9bZrprAi5 JfIHyfpyahzjJIeWzvnv6NafzVSFc2C/sIy759irKviiy9U6CCyO0nEdjuvVEXm/Tg1OnoB6iKssAY fhTFHVqPI63ZT9s8fTPdUu+oPAp7NKHCHyF67cJce8rlegUDGSPfJ2lnLXB2wEwc5xWhpWvYjfdkin qGoEv5YkJbVTSezSB4kC/iitqSE69L/P07s28/VlpWLRSsSXL13FyjMeFF8w==
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
v2: improve help text (nathan)
v1: https://lore.kernel.org/lkml/20230302225444.never.053-kees@kernel.org/
---
 lib/Kconfig.ubsan      | 56 +++++++++++++++++++++++-------------------
 scripts/Makefile.ubsan |  2 +-
 2 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index fd15230a703b..65d8bbcba438 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -27,16 +27,29 @@ config UBSAN_TRAP
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
+	  Under Clang, the -fsanitize=bounds option is actually composed
+	  of two more specific options, -fsanitize=array-bounds and
+	  -fsanitize=local-bounds. However, -fsanitize=local-bounds can
+	  only be used when trap mode is enabled. (See also the help for
+	  CONFIG_LOCAL_BOUNDS.) Explicitly check for -fsanitize=array-bounds
+	  so that we can build up the options needed for UBSAN_BOUNDS
+	  with or without UBSAN_TRAP.
 
 config UBSAN_BOUNDS
 	bool "Perform array index bounds checking"
 	default UBSAN
-	depends on CC_HAS_UBSAN_ARRAY_BOUNDS || CC_HAS_UBSAN_BOUNDS
+	depends on CC_HAS_UBSAN_ARRAY_BOUNDS || CC_HAS_UBSAN_BOUNDS_STRICT
 	help
 	  This option enables detection of directly indexed out of bounds
 	  array accesses, where the array size is known at compile time.
@@ -44,33 +57,26 @@ config UBSAN_BOUNDS
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

