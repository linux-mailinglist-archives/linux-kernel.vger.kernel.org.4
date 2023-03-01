Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AB96A6E94
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCAOjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCAOjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:39:39 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED36B479
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:39:38 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id cf11-20020a0564020b8b00b0049ec3a108beso19362631edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JhZ8SEDoNzl+E2htjsUuUTMZqyHgHOmh7ac72ddETYs=;
        b=hwwsMSyOzkoBWayzQKOdFKIZfN+8rn6K+uZRqXexu7jTOCYjQq9ACST/vXXGgUa8CT
         9PbkYANDhENEWpCTAac5mNG7ZIAElA8E4TlfoSG2z+sTpCuZtWZwUNcme6Nz5ZOi8bmI
         WuyGwo5xiOk2ylqXeLH4a6J07LtGg7Ap91k/9Mcx8NUjgjoD00YVOtKBU9sHuoMA8yE3
         Onih1jNZmnQe2nEJA1yFuRFt5+jQMY1R2GMyNKX1qCR4BhaJrAA/7d3oi5VEphgCi5fm
         cZRBWCikluD1F4OG5qcDUFzHLUwgyg0Swg3+bo7tCkfOYvarkHR+O8quNjT/Nzoz7/3D
         eJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JhZ8SEDoNzl+E2htjsUuUTMZqyHgHOmh7ac72ddETYs=;
        b=jkiL3nqI4kmv3dz6C1eCIsfHZfByWaDTsM4ixpH9IsTmreI4AHfnuzuVy8mc04kT7B
         m+9+afdXi4ZkhR+2bGin+oqOBndBGaCLnOpLBptSNyPbAT4FmIlWIvOe+udRSbztAvur
         u1BFcHwBz0LQBdzqJK2b7IF9hzAM1RvNU+cr5dttpfIOOxs+mV+/WTg0KiPM0z8tnVnV
         cBu/NvCSPETkr/q1Fw7i+I72+K0Vx9eDeVhdr3oRigRIiDMI4eisvuO5MTGOeTUzLMTN
         YNCHV2Ofj2x4rfffGhB4m7Sk+jAp8f3NH/6AOOS0TTxSuMtGApODcW2e7MNGKG7jqWk0
         FuSw==
X-Gm-Message-State: AO0yUKUY356y/odlxgMECtOvENI9XXs+KlMfLu8sMvUY9Rcy0iwDaUjP
        DFuF8OSg2pgOtdiD+F1hVg1LxJq1Gkw=
X-Google-Smtp-Source: AK7set/soLRTnmi/Q6cCoxB5T4A5ekmdZ3mGiPUd6HKEr7VaR2a3N3ZNKHKp69dd1Rxd9h+HwywF0ggPLBQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:3c31:b0cf:1498:e916])
 (user=glider job=sendgmr) by 2002:a17:907:9491:b0:8ee:babc:d3f8 with SMTP id
 dm17-20020a170907949100b008eebabcd3f8mr5683794ejc.3.1677681577396; Wed, 01
 Mar 2023 06:39:37 -0800 (PST)
Date:   Wed,  1 Mar 2023 15:39:30 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230301143933.2374658-1-glider@google.com>
Subject: [PATCH 1/4] x86: kmsan: Don't rename memintrinsics in uninstrumented files
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        nathan@kernel.org, ndesaulniers@google.com,
        kasan-dev@googlegroups.com, Kees Cook <keescook@chromium.org>
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

KMSAN should be overriding calls to memset/memcpy/memmove and their
__builtin_ versions in instrumented files, so there is no need to
override them. In non-instrumented versions we are now required to
leave memset() and friends intact, so we cannot replace them with
__msan_XXX() functions.

Cc: Kees Cook <keescook@chromium.org>
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/include/asm/string_64.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 888731ccf1f67..9be401d971a99 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -15,22 +15,11 @@
 #endif
 
 #define __HAVE_ARCH_MEMCPY 1
-#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
-#undef memcpy
-#define memcpy __msan_memcpy
-#else
 extern void *memcpy(void *to, const void *from, size_t len);
-#endif
 extern void *__memcpy(void *to, const void *from, size_t len);
 
 #define __HAVE_ARCH_MEMSET
-#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
-extern void *__msan_memset(void *s, int c, size_t n);
-#undef memset
-#define memset __msan_memset
-#else
 void *memset(void *s, int c, size_t n);
-#endif
 void *__memset(void *s, int c, size_t n);
 
 #define __HAVE_ARCH_MEMSET16
@@ -70,13 +59,7 @@ static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
 }
 
 #define __HAVE_ARCH_MEMMOVE
-#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
-#undef memmove
-void *__msan_memmove(void *dest, const void *src, size_t len);
-#define memmove __msan_memmove
-#else
 void *memmove(void *dest, const void *src, size_t count);
-#endif
 void *__memmove(void *dest, const void *src, size_t count);
 
 int memcmp(const void *cs, const void *ct, size_t count);
-- 
2.39.2.722.g9855ee24e9-goog

