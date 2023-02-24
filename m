Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D951B6A1867
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjBXJAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjBXJAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:00:05 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A71663A07
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:00:03 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id r6-20020aa7c146000000b004acd97105ffso18875635edp.19
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni0X0/loZejzrEM3ahtyHsQ4czmgqm9WNAw1TT3btvM=;
        b=KNP4d6RVhpEjbQC3l2fT7kAl4C3wq4IJLBgd79IVsMNh23YbWQPxqNeNp4PNlX68dW
         rVjsIqPdml9xCdbYExTQnHkglHOraVKUHi8/qeMC3A0BjfhF00nI7oV0i9lYvUjp+3Jy
         06s7+Vsgaq+qITEL4UlWWmUEyFOmvxmbI33WEdvg/44hzTfS1YsYyJIlEIoO1pADPPyI
         wUvDfvgb4DtiXPJvyc4ll/OFNetXkSHQURg/uKU+DyYrlA7oBOh6BQ/bmc0NaIgLL9F7
         fa7+HKeZezfK5A1GpEJhWgtD/OGQgow/R7raRNgP6kyn44OIn90x9bADVFlDj7e3pksb
         GLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni0X0/loZejzrEM3ahtyHsQ4czmgqm9WNAw1TT3btvM=;
        b=p1nbP1rUDtoYxvM4rg1VhA7jZR8eX6Lqo9SVPX5hSkjCuRYP/bt8Qdg9mpVIvOzDvY
         LGqDVga9hOa2GnhOnTCqk7CD83hLVMfMoQGQNCNHNDtzrF/c8BUH3gmpgRKMRulmphll
         Uca5ffFR0lLQMVhQ3RXdqfe2pXLoeyrfqDgHpZvHkLQT4kpi02bwpNeE55mMdZyrSak1
         fCwUN3yayIMqtoaN+jz8MfRRJzw+hMINwCoo0HgBTrdkx3o+yLsQZrnfJ2mC9kgTnUPE
         9vdflodI1fO/eLv+Gb1otDVWDGOL5LL2pW/YF3cOkKZodUtbiiezUGOdsGwRFKhea4yW
         XltQ==
X-Gm-Message-State: AO0yUKUO3aBTjwGeqSYKijSWezaO7dsdGmviSVJuk1xMzMyAF8V2jCBp
        2l+Va+JDZPentI1O0X2Tk9ktUpklcg==
X-Google-Smtp-Source: AK7set9rZ9eUb7bGWTMJ7DQioL+NOIJFyBh22lkV7CejLhB9j4FRWsGV+zy8NVqE9CeBwZV5bua6ewKcaw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:53eb:6453:f5f5:3bb9])
 (user=elver job=sendgmr) by 2002:a50:d544:0:b0:4ad:6e3e:7da6 with SMTP id
 f4-20020a50d544000000b004ad6e3e7da6mr7001699edj.6.1677229201684; Fri, 24 Feb
 2023 01:00:01 -0800 (PST)
Date:   Fri, 24 Feb 2023 09:59:40 +0100
In-Reply-To: <20230224085942.1791837-1-elver@google.com>
Mime-Version: 1.0
References: <20230224085942.1791837-1-elver@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224085942.1791837-2-elver@google.com>
Subject: [PATCH v5 2/4] kasan: Treat meminstrinsic as builtins in
 uninstrumented files
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>,
        linux-toolchains@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where the compiler instruments meminstrinsics by generating calls to
__asan/__hwasan_ prefixed functions, let the compiler consider
memintrinsics as builtin again.

To do so, never override memset/memmove/memcpy if the compiler does the
correct instrumentation - even on !GENERIC_ENTRY architectures.

Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
v4:
* New patch.
---
 lib/Kconfig.kasan      | 9 +++++++++
 mm/kasan/shadow.c      | 5 ++++-
 scripts/Makefile.kasan | 9 +++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index be6ee6020290..fdca89c05745 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -49,6 +49,15 @@ menuconfig KASAN
 
 if KASAN
 
+config CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=kernel-address -mllvm -asan-kernel-mem-intrinsic-prefix=1)) || \
+		 (CC_IS_GCC && $(cc-option,-fsanitize=kernel-address --param asan-kernel-mem-intrinsic-prefix=1))
+	# Don't define it if we don't need it: compilation of the test uses
+	# this variable to decide how the compiler should treat builtins.
+	depends on !KASAN_HW_TAGS
+	help
+	  The compiler is able to prefix memintrinsics with __asan or __hwasan.
+
 choice
 	prompt "KASAN mode"
 	default KASAN_GENERIC
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index f8a47cb299cb..43b6a59c8b54 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -38,11 +38,14 @@ bool __kasan_check_write(const volatile void *p, unsigned int size)
 }
 EXPORT_SYMBOL(__kasan_check_write);
 
-#ifndef CONFIG_GENERIC_ENTRY
+#if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) && !defined(CONFIG_GENERIC_ENTRY)
 /*
  * CONFIG_GENERIC_ENTRY relies on compiler emitted mem*() calls to not be
  * instrumented. KASAN enabled toolchains should emit __asan_mem*() functions
  * for the sites they want to instrument.
+ *
+ * If we have a compiler that can instrument meminstrinsics, never override
+ * these, so that non-instrumented files can safely consider them as builtins.
  */
 #undef memset
 void *memset(void *addr, int c, size_t len)
diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index fa9f836f8039..c186110ffa20 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -1,5 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
+
+ifdef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+# Safe for compiler to generate meminstrinsic calls in uninstrumented files.
+CFLAGS_KASAN_NOSANITIZE :=
+else
+# Don't let compiler generate memintrinsic calls in uninstrumented files
+# because they are instrumented.
 CFLAGS_KASAN_NOSANITIZE := -fno-builtin
+endif
+
 KASAN_SHADOW_OFFSET ?= $(CONFIG_KASAN_SHADOW_OFFSET)
 
 cc-param = $(call cc-option, -mllvm -$(1), $(call cc-option, --param $(1)))
-- 
2.39.2.637.g21b0678d19-goog

