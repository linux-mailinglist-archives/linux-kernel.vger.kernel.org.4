Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57E86A9930
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCCOOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCCOOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:14:42 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B0913DEB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:14:41 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id q13-20020a5085cd000000b004af50de0bcfso4216239edh.15
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677852880;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2N/CPy1IFmLQesHjkxJB5VDmlDO65TUQOL9xC78XNWQ=;
        b=hMY2yJzsPf2YWJ9SnaLFMvgZa7mnCcGkPNLMoITa/8FWMXegqQl7kIJo/qWbFtv42K
         JUF3gcDP0cfK67S+1mdFC2TbAWAnhoc3q+tRpdXFcLyhBGTf0Opvr/qYA8Z6Oj+oe1PO
         azhktU12eLJhoB1eKldndx4jeQwB0Xkm5Yro83Pn9TkvQpP34l1jQU1wvOMFDuojTwoy
         nr3zYZv12m4lPIMp4NLUZBH3EtP7QEL/MlNPFBicPOgSwAROS0En6PD9ETZi/dZ8EYZt
         S93zuhDgiY/Zn126O3o8Vab4eMVHJMeE2Mpw/mURlt/0t2gHwSJCXA5K1fqYu1PAdxYy
         lHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677852880;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2N/CPy1IFmLQesHjkxJB5VDmlDO65TUQOL9xC78XNWQ=;
        b=Hva06/fizgI2iSmW2KN/XPfcg72zGgBLrruXTjIYh6H/Oc+RPnQmGm+lfN+4OeouDJ
         zSWlmb9Dscktf6lMiBd9kDSp3hKhk88wg7Ulr+A0VVpJ4k77b7TCbAIWH0Tjx5plLAz8
         C/lEnykxUIlSL5kSEZIdtjDVDLGJFZ8E8w7UKG8SemgwGxfOvV6tsbiT0FcN6EXfzhMC
         PA/mCLwIbppreM+bdRZecwmfmaerRfyOoPuiHVOI3sgzEoJDPWyDdRBToJq8eDy7ZyFb
         hiZtEcAutxVWD9mEtaoaizgU+kQl7/BxlXEQ3rCTF2k+qnO4QmKA3Au05fTQCmI/SvYe
         gCbg==
X-Gm-Message-State: AO0yUKWBAyyKgkNfYo9TWICWHOYWjYLoP1444YMvzWOe7Y3EoMLGdFUi
        M37klHPImJI4mb897nbmCeFHD0QMjUk=
X-Google-Smtp-Source: AK7set/QK/eNvPtl5qmRXYLEBXFksBQrVDShOV/MqLWGsB02mS/d8mUxfHAqI+8j0Y0o6fWedP51UKjMacs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:f11e:2fac:5069:a04d])
 (user=glider job=sendgmr) by 2002:a50:ab1e:0:b0:4ab:4933:225b with SMTP id
 s30-20020a50ab1e000000b004ab4933225bmr1157914edc.6.1677852879922; Fri, 03 Mar
 2023 06:14:39 -0800 (PST)
Date:   Fri,  3 Mar 2023 15:14:30 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230303141433.3422671-1-glider@google.com>
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

clang -fsanitize=kernel-memory already replaces calls to
memset/memcpy/memmove and their __builtin_ versions with
__msan_memset/__msan_memcpy/__msan_memmove in instrumented files, so
there is no need to override them.

In non-instrumented versions we are now required to leave memset()
and friends intact, so we cannot replace them with __msan_XXX() functions.

Cc: Kees Cook <keescook@chromium.org>
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>

---
v2:
 - updated patch description
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
2.40.0.rc0.216.gc4246ad0f0-goog

