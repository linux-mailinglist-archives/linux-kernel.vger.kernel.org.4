Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F70D69ABE8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBQMxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBQMxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:53:22 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D741287D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:53:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bt27so544712wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ulgx+po/trB+4FXQcLmj6nxw3N0m6LL1KXnQpc+SYhI=;
        b=BVGRp9vYDHaCoxsJwjIYvbuDVbtvx0mVDEmbX2XZy1ny1uCuSjxjVE1KzSyOk3rj68
         k44oJEa1DPZ4PRmT7xT/Q0u4DRT2JSJ/yo8S1a7AaMmYCvBjLHcX2R10GNIz6orDQOsX
         caM8QvKnausu95V3Nykyrl6B1e4AjbF2MdOKqNLT54r0MUW5HnpnlqBmXGnGzka3U4KQ
         G+4xM3Mi9Rkg+zl7MNlhU3uRT5nCpv8Ej9bPU+mSGdU2obiShaU/RgpDqwmiPx6rPtwe
         npy5gWb5Kq7NBI0JHLXVs3DeTqD9M+5UWblWrMSfPkrJk1MR6fQPP9yWt51aSkt66MPZ
         QKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ulgx+po/trB+4FXQcLmj6nxw3N0m6LL1KXnQpc+SYhI=;
        b=AGSb0hlL0jZFxmHKGoTCdga7gz6bHVkbnMFhpzZuEKhCvvKspr9Z7EpNSZUmgom0d1
         c+1GgFsd7cpTybk9PfGUErA3AcUw6kiOjW8VXzakvC1iLlB8aJy15oBymIjbsGFTNGsA
         lin3IHsNZfAQ162z08ENBu0CNBSVd6dcBfqs0RpJ5hEYiN+2FwknOQF8nKXcBmeGZ/Jk
         /UM62BNt2sgobLrsMPF0JezR2nbvor1237QlphzxCQyvFfGIdPkLqT2B9JVqabeTiiDD
         TzLdhYCtv1iy3LQQPUxmhcLKFActPlONQyRmbUGB5HbAy03yOVy2+BK6C62DNt0QNA6h
         z/Ag==
X-Gm-Message-State: AO0yUKVK+xQSeBFr7WJxe0uYfOzZKAq0NjpMCjLNHy1/i/EcS+6dhvn1
        L6a1Gk4dIKNXKtULkLTfIkPpyA==
X-Google-Smtp-Source: AK7set8a/gyHg3t36Zyr4mxRFV/aOKMOB5cnYYED79FZtuRdCJQaJGG18Ti/CRRpve9Jdk6dcbhgQA==
X-Received: by 2002:adf:fb92:0:b0:2c5:5933:1752 with SMTP id a18-20020adffb92000000b002c559331752mr700692wrr.52.1676638397783;
        Fri, 17 Feb 2023 04:53:17 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:34a3:b9c:4ef:ef85])
        by smtp.gmail.com with ESMTPSA id s17-20020a5d4251000000b002c6e8cb612fsm1050348wrr.92.2023.02.17.04.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 04:53:17 -0800 (PST)
Date:   Fri, 17 Feb 2023 13:53:10 +0100
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Subject: [PATCH -tip v4 4/4] kasan, x86: Don't rename memintrinsics in
 uninstrumented files
Message-ID: <Y+94tm7xoeTGqPgs@elver.google.com>
References: <20230216234522.3757369-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216234522.3757369-1-elver@google.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that memcpy/memset/memmove are no longer overridden by KASAN, we can
just use the normal symbol names in uninstrumented files.

Drop the preprocessor redefinitions.

Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* New patch.
---
 arch/x86/include/asm/string_64.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 888731ccf1f6..c1e14cee0722 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -85,25 +85,6 @@ char *strcpy(char *dest, const char *src);
 char *strcat(char *dest, const char *src);
 int strcmp(const char *cs, const char *ct);
 
-#if (defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__))
-/*
- * For files that not instrumented (e.g. mm/slub.c) we
- * should use not instrumented version of mem* functions.
- */
-
-#undef memcpy
-#define memcpy(dst, src, len) __memcpy(dst, src, len)
-#undef memmove
-#define memmove(dst, src, len) __memmove(dst, src, len)
-#undef memset
-#define memset(s, c, n) __memset(s, c, n)
-
-#ifndef __NO_FORTIFY
-#define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
-#endif
-
-#endif
-
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
 void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
-- 
2.39.2.637.g21b0678d19-goog

