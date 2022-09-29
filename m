Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509CD5EF023
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiI2IQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiI2IQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:16:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ED6111DC9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:16:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so5237446pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=BYd62bt7cYtJniBYilhjKYrGUYdiD00saVENui7fqyE=;
        b=JUWtUmQ/HNgKSzPJRGQjC0qcFbgiY4K0nFeyod1ABT6qseFv0DcHfUN3oWtZOiYgcS
         pll9mDIh1hDv9MPtpUdbWkRTQLB3QYUKAgpHLlTaZ579zlnC+NjWsUBm5ksQh6bg2er7
         AIbzMxq8R+mEtbL54RdvXwCOQJu8fr8e9uElA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BYd62bt7cYtJniBYilhjKYrGUYdiD00saVENui7fqyE=;
        b=u+7uOEkVHTZ84o+EsTMYhlAIoVCP10uSzjVdSIJdfykbGsCgwgsCR5QSnb4ZZ0BFra
         wRov9l5msIwmoFs0PZtytF6w819wYMMVel2h8Rrt5p6jwxUKOeCcdoNPO5GUelrXyPyz
         5mNGETogTWeigG4mKozqDcxt/9BtHN0GNAHPlLR1uEUQnox8NSPpK9UpAAYap8gwQkFm
         IuppBcB+H8vWVDav3ot9e12brHiayaEgO0Kp+4YCudT3IXOXnql6ichCQ/hCbjQk5NFS
         xrMacsDd0tLQh//lG3FoIf/eB1BeGaF5t0EI+YCaF0alVi7IBabdyXY7cMdArcS3f7Zr
         BF5w==
X-Gm-Message-State: ACrzQf0+qBoSjgqGbD6gZLfVzA+VFAztPd52nZ4HGfz279UnEeUaTGGO
        dEGKUkdV88Ku5y0kzFgz0uEZQg==
X-Google-Smtp-Source: AMsMyM4XM9HOf4mevtYN33sojeiy8FUE2NFncgvI6Em3mrM26ZsyYXh7h7GAT7NtSJb3bBDCVc05Pw==
X-Received: by 2002:a17:902:bd95:b0:17a:582:4eb with SMTP id q21-20020a170902bd9500b0017a058204ebmr2267644pls.40.1664439405935;
        Thu, 29 Sep 2022 01:16:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 78-20020a630651000000b0042aca53b4cesm4985938pgg.70.2022.09.29.01.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 01:16:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yonghong Song <yhs@fb.com>, Hao Luo <haoluo@google.com>,
        Marco Elver <elver@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] compiler_types.h: Test for __alloc_size__ again
Date:   Thu, 29 Sep 2022 01:16:42 -0700
Message-Id: <20220929081642.1932200-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2675; h=from:subject; bh=+FdAXICN7lOpYuazmb3Lfz4pBNvSpMZRw+IYkyoMdSs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjNVRp8k+WbjGCgyrHrq92hhwupa/TT04j9idnxFGK K4eqEomJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYzVUaQAKCRCJcvTf3G3AJnw9D/ 9Eo3Z//levsQrri6Ytzj8A3R1gdFL5kKEBOZ5vgooJrqcl6mwkZGejzMr2TctWgIDBrzASz4xLqblU MNFpmsVABljyJEfpJzfacfYbHYZZtqBn9LHzob4MU2D2LQh4K6azmxIJRZSxu0ie5lPU2JNa5od04U wHerZjCNRA4u1B9OXzrZTANZa6+k3FRM9SYJRr2hGWwodWm8f67HQWewdTnk3tm6S4618uBmXCstZ2 KVe/Nnm5rGkGyzNQEV8j4zN5ScpKBP9zsCFwO5GcU4jf/wuyKgCxz0xy0Yh10b//gY/bJ+CeNy7kfI C8a9LYlgI/hoZP4641JquUZWDrMkyDYiYIHtbhtw32AWNqWeFmkgHbLRn0GMhI5CqBI49MBamo6BrI K2Zcg+xKd8wmhqI+JTfZZWKUAWRzKNPk27oBocKK7kfo0w5RgakznVEE7f7QFeFGD8PTKmOcyCm7Z7 QSltOG5GMD2JzgoXrn8LdXpSVug388lgJS40aBakACbzXB6DPJPSX7P2Jpslw8KzuqznC0ulGHRGxc 7tH4zapffTkQ0DUqlj4My/jXhI8SdHNe0cbX6JouPcUUEBJsRMY4s1g/qke5YNnAshmAxCT3BJWuQx ns8DkVZAZ/nJ4FuuncraD/HASOZRoQrKLQIzqxFEZ0Sk0xiLN04I/6ebKQ9Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the "alloc_size" attribute is available on all GCC versions, I
forgot that it gets disabled explicitly by the kernel in GCC < 9.1 due
to misbehaviors. Add a note to the compiler_attributes.h entry for it,
and restore the #ifdef in compiler_types.h.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Marco Elver <elver@google.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/lkml/CAMuHMdXK+UN1YVZm9DenuXAM8hZRUZJwp=SXsueP7sWiVU3a9A@mail.gmail.com
Fixes: 63caa04ec60583b1 ("slab: Remove __malloc attribute from realloc functions")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I swear I sent this earlier today, but I don't see it on lore still. Resending,
so apologies if this is a duplicate.
---
 include/linux/compiler_attributes.h | 3 ++-
 include/linux/compiler_types.h      | 9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 465be5f072ff..55fbb6091ecf 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -65,7 +65,8 @@
 
 /*
  * Note: do not use this directly. Instead, use __alloc_size() since it is conditionally
- * available and includes other attributes.
+ * available and includes other attributes. For GCC < 9.1, __alloc_size__ gets undefined
+ * in compiler-gcc.h, due to misbehaviors.
  *
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
  * clang: https://clang.llvm.org/docs/AttributeReference.html#alloc-size
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index f141a6f6b9f6..0717534f8364 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -275,8 +275,13 @@ struct ftrace_likely_data {
  * be performing a _reallocation_, as that may alias the existing pointer.
  * For these, use __realloc_size().
  */
-#define __alloc_size(x, ...)	__alloc_size__(x, ## __VA_ARGS__) __malloc
-#define __realloc_size(x, ...)	__alloc_size__(x, ## __VA_ARGS__)
+#ifdef __alloc_size__
+# define __alloc_size(x, ...)	__alloc_size__(x, ## __VA_ARGS__) __malloc
+# define __realloc_size(x, ...)	__alloc_size__(x, ## __VA_ARGS__)
+#else
+# define __alloc_size(x, ...)	__malloc
+# define __realloc_size(x, ...)
+#endif
 
 #ifndef asm_volatile_goto
 #define asm_volatile_goto(x...) asm goto(x)
-- 
2.34.1

