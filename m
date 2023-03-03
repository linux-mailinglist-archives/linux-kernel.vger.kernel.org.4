Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077D46A9932
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjCCOO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjCCOOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:14:49 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A9417152
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:14:47 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so4116918edc.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677852886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAtSFGVTwhm/tX8WamH/Zd7xaJyhhcixand9gS9KqOo=;
        b=edrPhHR+hbvuZmCRmiXvtdzInq+2KrUPIrtLGbBOYAz18C6kJWS+/nki4keZBHrSjX
         Q9nhw9CS30Klrqx9/BvqlHeAniJuoR/QNhoB9W5oFpeRTdTaYW3kcWOLgRPD6NXZIP6n
         mCC7IOqMEor1717d+03PnfDDyrDEXtVYpKT9TFFypjlnzs0nyAZ2rNe3l77D9LG/LFF9
         P4H7KTzZSBM8OobRFBApQihuTwjuD3mWpkS7Dxkd8mvYiL/+iGj/yGknBW2a+RQL7LA8
         Cp1I4cW2uNEf7myQDdk6wGuhupp71e5j4QbfcEgLzB44ot+O6Uamh2nuy8Dt05VbcIci
         r4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677852886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAtSFGVTwhm/tX8WamH/Zd7xaJyhhcixand9gS9KqOo=;
        b=c+2QPPc4HWY3Vu2gjP7Yu1hZNFZv/pQNec4k30F8KPp0VNaOmHWlEPl1atQsSsbXld
         YHJJTR4zocFoLqVSYevHsNPa8V04otKYNyqxU1SFSiLCRkIYwI60jGdcAOVcoc8IPtSa
         fBh4JCa6YheNDFIUf8dYiTGiJZzD1qxVJsL8Y8AjYS4JRAQzQvnoNTdC4ZU7Xznni8qB
         FK91odEokb0EE2Z0sxdeHrZpuDjzKYX66Tu1BE4COXxiNsel3dRxw24g/g3QZfdVlD50
         fIP3z1ZUJL6Q14PcRAqUIWL7jQBOuZE3qZXK6HnaztlmImSRdqLyKSeXsVeqoY6B4TOm
         4djw==
X-Gm-Message-State: AO0yUKXvYCcVI9dkv/HFnKBLWh4I4jNFsLQDxnKErFNiKKJwuZvhetsr
        kofEAtawE0iZnvNJQNx0xBKpISayHVk=
X-Google-Smtp-Source: AK7set9ovVaTOZsd0wnlPkswC0ekqTesP61gdVe/s0v8ISscKbGWSxjuV4vTctRIUgfB7uruGzs1glnmf18=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:f11e:2fac:5069:a04d])
 (user=glider job=sendgmr) by 2002:a50:d581:0:b0:4bf:7914:98c5 with SMTP id
 v1-20020a50d581000000b004bf791498c5mr1171964edi.4.1677852886570; Fri, 03 Mar
 2023 06:14:46 -0800 (PST)
Date:   Fri,  3 Mar 2023 15:14:32 +0100
In-Reply-To: <20230303141433.3422671-1-glider@google.com>
Mime-Version: 1.0
References: <20230303141433.3422671-1-glider@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230303141433.3422671-3-glider@google.com>
Subject: [PATCH 3/4] x86: kmsan: use C versions of memset16/memset32/memset64
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        nathan@kernel.org, ndesaulniers@google.com,
        kasan-dev@googlegroups.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
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

KMSAN must see as many memory accesses as possible to prevent false
positive reports. Fall back to versions of
memset16()/memset32()/memset64() implemented in lib/string.c instead of
those written in assembly.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
---
 arch/x86/include/asm/string_64.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 9be401d971a99..e9c736f4686f5 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -22,6 +22,11 @@ extern void *__memcpy(void *to, const void *from, size_t len);
 void *memset(void *s, int c, size_t n);
 void *__memset(void *s, int c, size_t n);
 
+/*
+ * KMSAN needs to instrument as much code as possible. Use C versions of
+ * memsetXX() from lib/string.c under KMSAN.
+ */
+#if !defined(CONFIG_KMSAN)
 #define __HAVE_ARCH_MEMSET16
 static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 {
@@ -57,6 +62,7 @@ static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
 		     : "memory");
 	return s;
 }
+#endif
 
 #define __HAVE_ARCH_MEMMOVE
 void *memmove(void *dest, const void *src, size_t count);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

