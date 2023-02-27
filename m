Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AD06A3E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjB0Jv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjB0Jvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:51:46 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA11ABF0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:51:44 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so7630803edc.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vLAZSY9lX30lbRvxmgqsLOf9PyjLVjvwhzsapOvRcDY=;
        b=kMaj71Vfi/lRJwpu2c6Y30c4GChofTS/1NAM6BSsppmd+79MVgshdAkbfwYcY+bpGs
         CiRnRoFJalGQy06Qf6ofr6IPOrEnPsJbQXg6+U1jdMGXFVGJ1AsOf4i7MQFcQA+l8ULe
         Mo2b8h0asHjntecxkZTvGug03tleK52dxXa25hMzrG4SNMTyU/JAHj9MR/l79zKdXHLQ
         buM5KSHUBERdH016UmpVUqFya9R7u6amo2onMgq6s4r74lW7NUSfh3ur9xrEK7PEmm+k
         3xZcAhDWMRii49gLrjaLUjNtFD2IuQu4WrV5DAjjdfOzUNXSCtDX0oHDPSI05CE4qHzb
         EqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLAZSY9lX30lbRvxmgqsLOf9PyjLVjvwhzsapOvRcDY=;
        b=P9Bckr22JNDBQUSbAoUUh+M2vINezoo4u3s+JITu/Dbl4zige1tIGiiDMA4Zt7xdBT
         mwpSI0CJwJuNjlSWLEP81cE2cQfdWlZUgb4J80DsCZN5tFbTc+NcweZSWioSOrbpV9+7
         EszKFCGrxKOzRT6HnpmumQRBBPA3Jl+HnhfOyit/NLEW76lt44axtUACoWdRVzxh0uoO
         YMmN3qE77uByVFrp+8pEfYnKOfRavM0lGc4HDXdipLypgcySBdc05YKOrkAgvpCw37ON
         aafbwrJN1WKSG/quMBUVVc2i+oKSq8Ka9wlmvYYK3svMwiQyq/w13Spt0Ik8zea4xvUx
         vUFg==
X-Gm-Message-State: AO0yUKWS5sK/Cd0J9xEpDNInVLhMZzdF/a1hsGbqoTmKjJxmTePsVl95
        meslx7CPBQ+2G1L4UIIntcAYlEvDQQ==
X-Google-Smtp-Source: AK7set8hge3bNWvK5Bx6TAmYJQ6x6+ySzteQpQn1kKAYlB8+s6f2a5QBRfTeJyAYOF013isoIX53pzIcXw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:1a89:611d:c416:e1ee])
 (user=elver job=sendgmr) by 2002:a17:907:60cd:b0:8b1:3540:7632 with SMTP id
 hv13-20020a17090760cd00b008b135407632mr5583442ejc.2.1677491502399; Mon, 27
 Feb 2023 01:51:42 -0800 (PST)
Date:   Mon, 27 Feb 2023 10:47:27 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230227094726.3833247-1-elver@google.com>
Subject: [PATCH mm] kasan, powerpc: Don't rename memintrinsics if compiler
 adds prefixes
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Liam Howlett <liam.howlett@oracle.com>,
        kasan-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Daniel Axtens <dja@axtens.net>,
        kernel test robot <lkp@intel.com>
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

With appropriate compiler support [1], KASAN builds use __asan prefixed
meminstrinsics, and KASAN no longer overrides memcpy/memset/memmove.

If compiler support is detected (CC_HAS_KASAN_MEMINTRINSIC_PREFIX),
define memintrinsics normally (do not prefix '__').

On powerpc, KASAN is the only user of __mem functions, which are used to
define instrumented memintrinsics. Alias the normal versions for KASAN
to use in its implementation.

Link: https://lore.kernel.org/all/20230224085942.1791837-1-elver@google.com/ [1]
Link: https://lore.kernel.org/oe-kbuild-all/202302271348.U5lvmo0S-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 arch/powerpc/include/asm/kasan.h       |  2 +-
 arch/powerpc/include/asm/string.h      | 15 +++++++++++----
 arch/powerpc/kernel/prom_init_check.sh |  9 +++++++--
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index 92a968202ba7..365d2720097c 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_KASAN_H
 #define __ASM_KASAN_H
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN) && !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX)
 #define _GLOBAL_KASAN(fn)	_GLOBAL(__##fn)
 #define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(__##fn)
 #define EXPORT_SYMBOL_KASAN(fn)	EXPORT_SYMBOL(__##fn)
diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 2aa0e31e6884..60ba22770f51 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -30,11 +30,17 @@ extern int memcmp(const void *,const void *,__kernel_size_t);
 extern void * memchr(const void *,int,__kernel_size_t);
 void memcpy_flushcache(void *dest, const void *src, size_t size);
 
+#ifdef CONFIG_KASAN
+/* __mem variants are used by KASAN to implement instrumented meminstrinsics. */
+#ifdef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+#define __memset memset
+#define __memcpy memcpy
+#define __memmove memmove
+#else /* CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
 void *__memset(void *s, int c, __kernel_size_t count);
 void *__memcpy(void *to, const void *from, __kernel_size_t n);
 void *__memmove(void *to, const void *from, __kernel_size_t n);
-
-#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
+#ifndef __SANITIZE_ADDRESS__
 /*
  * For files that are not instrumented (e.g. mm/slub.c) we
  * should use not instrumented version of mem* functions.
@@ -46,8 +52,9 @@ void *__memmove(void *to, const void *from, __kernel_size_t n);
 #ifndef __NO_FORTIFY
 #define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
 #endif
-
-#endif
+#endif /* !__SANITIZE_ADDRESS__ */
+#endif /* CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
+#endif /* CONFIG_KASAN */
 
 #ifdef CONFIG_PPC64
 #ifndef CONFIG_KASAN
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 311890d71c4c..f3f43a8f48cf 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -13,8 +13,13 @@
 # If you really need to reference something from prom_init.o add
 # it to the list below:
 
-grep "^CONFIG_KASAN=y$" ${KCONFIG_CONFIG} >/dev/null
-if [ $? -eq 0 ]
+has_renamed_memintrinsics()
+{
+	grep -q "^CONFIG_KASAN=y$" ${KCONFIG_CONFIG} && \
+		! grep -q "^CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y" ${KCONFIG_CONFIG}
+}
+
+if has_renamed_memintrinsics
 then
 	MEM_FUNCS="__memcpy __memset"
 else
-- 
2.39.2.637.g21b0678d19-goog

