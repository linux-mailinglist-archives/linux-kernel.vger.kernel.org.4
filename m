Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA8369A29A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 00:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBPXpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 18:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBPXpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:45:36 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB3150AE1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:45:35 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-52a8f97c8ccso38488797b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f9fSJ8LX1LV0NJhDIu0hFxwhZk7Rq4zVsb0PZTFK4Co=;
        b=T1m8J9zu54fxOtNw1pfhMlQVMKTBI98xdI/WbelYkJUrDITtxfYmR5FLfm9XU00+xB
         RrI0OR1yS6IMQO/YgtX1dk+cglRU1BcwoVEv268fpi4FOw1p+H/khXU3KeXcBcUs0P/a
         N5oBiP/Mprdk9yX27S1VfpUsCYZGE1kSAaJiBZkAmchx904ORP6dD2n+6vCCCc9Bmp35
         pTCFcu6YRrrm8sSn44TcuV4lSaYwyvsQmmSp//MdVpCxCNi05VziSOIZz6BIYIBOanmh
         wBxNwYgItWLMyNXHDJbtrh/NSCyNkbK+FGvTJlhndfBhKp5KQOkoEawctV9VNckVmuVk
         mA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9fSJ8LX1LV0NJhDIu0hFxwhZk7Rq4zVsb0PZTFK4Co=;
        b=hbJh5PHbh9By+GFEdoBvGg1J06c8Cm1gIyB6urU2N78Str/ep7/HUthVIMg1GitLpQ
         kkqBsJ1r9mv3+DaSzFUwtMg7lTY2exHsTtTFkPd7FjJIJAun5PnUbNiSF2y9VoOcr1EQ
         K2B6I+FCm/ufTrUB9RDU59apSjbEvTMd/0vnveNrzNtuvKVCjE0ceRER5W6VF+tVccdI
         6BZd1dIccaTLzc0cqb40fv3zj1pChTsFFrv1Tb51zO3J2/MerapxIJaOCFsljhqCxkWJ
         kd9DxAeJB+nkClM/bwsmUaQldkA0sDazFPGwOQWi6P0oiDKs8y98AsgPc774NP78on2u
         TpWg==
X-Gm-Message-State: AO0yUKX6v7+RKYpH6HwjT7ZPBf419+Ua4ZrqsT2HTtTjDxi8ii7fo90L
        4YrY9vMAgOZf/TM7gpue42fprrUl3Q==
X-Google-Smtp-Source: AK7set/IFbohazrUlym85MQHWcUsKV5YXF2glA/nmcXrwKnVDZvE8l4eL3cW+ZnSjjVoiViI/jThdbWCyQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:34a3:b9c:4ef:ef85])
 (user=elver job=sendgmr) by 2002:a5b:6c7:0:b0:8dd:4f2c:ede4 with SMTP id
 r7-20020a5b06c7000000b008dd4f2cede4mr5888ybq.2.1676591134138; Thu, 16 Feb
 2023 15:45:34 -0800 (PST)
Date:   Fri, 17 Feb 2023 00:45:20 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230216234522.3757369-1-elver@google.com>
Subject: [PATCH -tip v4 1/3] kasan: Emit different calls for instrumentable memintrinsics
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jakub Jelinek <jakub@redhat.com>,
        linux-toolchains@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang 15 provides an option to prefix memcpy/memset/memmove calls with
__asan_/__hwasan_ in instrumented functions: https://reviews.llvm.org/D122724

GCC will add support in future:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108777

Use it to regain KASAN instrumentation of memcpy/memset/memmove on
architectures that require noinstr to be really free from instrumented
mem*() functions (all GENERIC_ENTRY architectures).

Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
v4:
* Also enable it for KASAN_SW_TAGS (__hwasan_mem*).

v3:
* No change.

v2:
* Use asan-kernel-mem-intrinsic-prefix=1, so that once GCC supports the
  param, it also works there (it needs the =1).

The Fixes tag is just there to show the dependency, and that people
shouldn't apply this patch without 69d4c0d32186.
---
 mm/kasan/kasan.h       |  4 ++++
 mm/kasan/shadow.c      | 11 +++++++++++
 scripts/Makefile.kasan |  8 ++++++++
 3 files changed, 23 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 71c15438afcf..172713b87556 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -637,4 +637,8 @@ void __hwasan_storeN_noabort(unsigned long addr, size_t size);
 
 void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size);
 
+void *__hwasan_memset(void *addr, int c, size_t len);
+void *__hwasan_memmove(void *dest, const void *src, size_t len);
+void *__hwasan_memcpy(void *dest, const void *src, size_t len);
+
 #endif /* __MM_KASAN_KASAN_H */
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 98269936a5e4..f8a47cb299cb 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -107,6 +107,17 @@ void *__asan_memcpy(void *dest, const void *src, size_t len)
 }
 EXPORT_SYMBOL(__asan_memcpy);
 
+#ifdef CONFIG_KASAN_SW_TAGS
+void *__hwasan_memset(void *addr, int c, size_t len) __alias(__asan_memset);
+EXPORT_SYMBOL(__hwasan_memset);
+#ifdef __HAVE_ARCH_MEMMOVE
+void *__hwasan_memmove(void *dest, const void *src, size_t len) __alias(__asan_memmove);
+EXPORT_SYMBOL(__hwasan_memmove);
+#endif
+void *__hwasan_memcpy(void *dest, const void *src, size_t len) __alias(__asan_memcpy);
+EXPORT_SYMBOL(__hwasan_memcpy);
+#endif
+
 void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
 	void *shadow_start, *shadow_end;
diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index b9e94c5e7097..fa9f836f8039 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -38,6 +38,11 @@ endif
 
 CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
 
+# Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
+# instead. With compilers that don't support this option, compiler-inserted
+# memintrinsics won't be checked by KASAN on GENERIC_ENTRY architectures.
+CFLAGS_KASAN += $(call cc-param,asan-kernel-mem-intrinsic-prefix=1)
+
 endif # CONFIG_KASAN_GENERIC
 
 ifdef CONFIG_KASAN_SW_TAGS
@@ -54,6 +59,9 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
 		$(call cc-param,hwasan-inline-all-checks=0) \
 		$(instrumentation_flags)
 
+# Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
+CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
+
 endif # CONFIG_KASAN_SW_TAGS
 
 export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE
-- 
2.39.2.637.g21b0678d19-goog

