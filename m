Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFDE60BE18
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJXXBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJXXAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:00:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97002D7D0C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:22:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-367dc159c2fso101321987b3.19
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4b5t5V5Gcz1RUui4LqlZYe/T5V0+jbf0EermbhLbCo=;
        b=UB5us+L65WuSV7LKHhI52HcB3sYCuWwNnK8ltyO4u0vIvjaAB05ZLOAGafpo8l5cGa
         wBMFCT4Kkvrs5x4wtnBYfMOzahxa569zXfrrKTeHgqfmIyNP4oI+XztTL1fPKIJ8gpn3
         0qkGExeFsAY6JZvk24haFa3HrCY2p0BIZwn7gyOEapmadRNJv3JRV0JguVi3J5+d36gN
         eqa6FcGmhPmYjXJhbPUKqqlQx3k9kRlFuROjUY1SCl88+13znc8K5XUxIlRLoL6bXrBN
         VHDy4KdKJBliLnYUrxmcBAiyhgWHSM9VL/a952Bi8+gPciMk2TXd+F4AepHVcsqQrC8T
         /i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4b5t5V5Gcz1RUui4LqlZYe/T5V0+jbf0EermbhLbCo=;
        b=NWTNvwuKzvM9Vscanu8rzKyD3sNsSZ8GslREPICw+d4bc6gl4XiXh/YZQqHER2QhGI
         21XBt4ZCbStF0BgwS42gy0MD4LxijAe9Ynz3hxRaJVMbxgyBA+yTyUZQgJsyqltb/FN4
         6uhXgM7GKrjRQo22MhECP6O4Nin9wp1Gqn6FY8u/hzjkepaC7WuY+XWw0lavWQLaAmCT
         HpR/rQefj2xYSap806ITQZKRNAniu2rlSAnfHOMnyo/APkJ63RLK/Y+5h9/4QTTRoU3j
         IvDXKkaDEOmkCUTLe+3LeenuAMTP7HH98S1N4X4PIdaVXHEBqg/dBE1BvA0BcyKbJ/L8
         YotQ==
X-Gm-Message-State: ACrzQf02uN4xYtGlIoYvb6ZZuqaLBuLvS18S8srU91ZLLWNAfkCJl71T
        mlV4UlM/sImSK8V9nLv1vJRBcFYM9LE=
X-Google-Smtp-Source: AMsMyM5VBxRcm1qmP+PFj9h/2lKWDWBZikjFrcTw4qx0rnWZ6p3EtaAFU2NKQO0mL3nnRdjEwSH7GuhQvh0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:8695:7c88:66ed:f9d1])
 (user=glider job=sendgmr) by 2002:a81:5a57:0:b0:353:6de6:3263 with SMTP id
 o84-20020a815a57000000b003536de63263mr30747701ywb.358.1666646530679; Mon, 24
 Oct 2022 14:22:10 -0700 (PDT)
Date:   Mon, 24 Oct 2022 23:21:44 +0200
In-Reply-To: <20221024212144.2852069-1-glider@google.com>
Mime-Version: 1.0
References: <20221024212144.2852069-1-glider@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221024212144.2852069-5-glider@google.com>
Subject: [PATCH 5/5] x86: fortify: kmsan: fix KMSAN fortify builds
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Tamas K Lengyel <tamas.lengyel@zentific.com>
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

Ensure that KMSAN builds replace memset/memcpy/memmove calls with the
respective __msan_XXX functions, and that none of the macros are
redefined twice. This should allow building kernel with both
CONFIG_KMSAN and CONFIG_FORTIFY_SOURCE.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-mm@kvack.org
Reported-by: Tamas K Lengyel <tamas.lengyel@zentific.com>
Link: https://github.com/google/kmsan/issues/89
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/include/asm/string_64.h | 11 +++++++----
 include/linux/fortify-string.h   | 17 +++++++++++++++--
 include/linux/kmsan_string.h     | 21 +++++++++++++++++++++
 mm/kmsan/instrumentation.c       |  1 +
 4 files changed, 44 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/kmsan_string.h

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 3b87d889b6e16..888731ccf1f67 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -10,10 +10,13 @@
 /* Even with __builtin_ the compiler may decide to use the out of line
    function. */
 
+#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
+#include <linux/kmsan_string.h>
+#endif
+
 #define __HAVE_ARCH_MEMCPY 1
-#if defined(__SANITIZE_MEMORY__)
+#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
 #undef memcpy
-void *__msan_memcpy(void *dst, const void *src, size_t size);
 #define memcpy __msan_memcpy
 #else
 extern void *memcpy(void *to, const void *from, size_t len);
@@ -21,7 +24,7 @@ extern void *memcpy(void *to, const void *from, size_t len);
 extern void *__memcpy(void *to, const void *from, size_t len);
 
 #define __HAVE_ARCH_MEMSET
-#if defined(__SANITIZE_MEMORY__)
+#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
 extern void *__msan_memset(void *s, int c, size_t n);
 #undef memset
 #define memset __msan_memset
@@ -67,7 +70,7 @@ static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
 }
 
 #define __HAVE_ARCH_MEMMOVE
-#if defined(__SANITIZE_MEMORY__)
+#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
 #undef memmove
 void *__msan_memmove(void *dest, const void *src, size_t len);
 #define memmove __msan_memmove
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 4029fe368a4f6..18a31b125f9d6 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -43,11 +43,24 @@ extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
 extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
 extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
 #else
-#define __underlying_memchr	__builtin_memchr
-#define __underlying_memcmp	__builtin_memcmp
+
+#if defined(__SANITIZE_MEMORY__)
+/*
+ * For KMSAN builds all memcpy/memset/memmove calls should be replaced by the
+ * corresponding __msan_XXX functions.
+ */
+#include <linux/kmsan_string.h>
+#define __underlying_memcpy	__msan_memcpy
+#define __underlying_memmove	__msan_memmove
+#define __underlying_memset	__msan_memset
+#else
 #define __underlying_memcpy	__builtin_memcpy
 #define __underlying_memmove	__builtin_memmove
 #define __underlying_memset	__builtin_memset
+#endif
+
+#define __underlying_memchr	__builtin_memchr
+#define __underlying_memcmp	__builtin_memcmp
 #define __underlying_strcat	__builtin_strcat
 #define __underlying_strcpy	__builtin_strcpy
 #define __underlying_strlen	__builtin_strlen
diff --git a/include/linux/kmsan_string.h b/include/linux/kmsan_string.h
new file mode 100644
index 0000000000000..7287da6f52eff
--- /dev/null
+++ b/include/linux/kmsan_string.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KMSAN string functions API used in other headers.
+ *
+ * Copyright (C) 2022 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+#ifndef _LINUX_KMSAN_STRING_H
+#define _LINUX_KMSAN_STRING_H
+
+/*
+ * KMSAN overrides the default memcpy/memset/memmove implementations in the
+ * kernel, which requires having __msan_XXX function prototypes in several other
+ * headers. Keep them in one place instead of open-coding.
+ */
+void *__msan_memcpy(void *dst, const void *src, size_t size);
+void *__msan_memset(void *s, int c, size_t n);
+void *__msan_memmove(void *dest, const void *src, size_t len);
+
+#endif /* _LINUX_KMSAN_STRING_H */
diff --git a/mm/kmsan/instrumentation.c b/mm/kmsan/instrumentation.c
index 280d154132684..271f135f97a16 100644
--- a/mm/kmsan/instrumentation.c
+++ b/mm/kmsan/instrumentation.c
@@ -14,6 +14,7 @@
 
 #include "kmsan.h"
 #include <linux/gfp.h>
+#include <linux/kmsan_string.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 
-- 
2.38.0.135.g90850a2211-goog

