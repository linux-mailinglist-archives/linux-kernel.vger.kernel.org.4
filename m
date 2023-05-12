Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492B4700D54
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbjELQtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjELQtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:49:20 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33A435A4;
        Fri, 12 May 2023 09:49:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac79d4858dso108594931fa.2;
        Fri, 12 May 2023 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683910157; x=1686502157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HutwX+KLgfv7Jubic5/xhBrVUiQ8CRoQwUCK5WkViRc=;
        b=VfN6pVJQ9iYFwPvisewJpSseYxIOZJ8XGtqNp3uDEu7Yzev9BZ8HV01uiYtjdteHfr
         uZ/wFn1Xlm/7Bn2CictEgaS+/jwGKKMkPSscmroDrnvp7iLZwOIZY+0yyrhcYhs0oNoI
         3WLYzsK6BovbvoQlDDmWr/4pJ/gU8I53Y6WZyjORZJtbUbN2uqAfRuGrTkSOyrQ+j2i7
         ffnOyPpVQAiaKETKdvBssKTO7qKRa0BYN+8N+jNAa1FuDykFwjGooK/MwoVlt9+1PtQp
         vGcZx+t8W5Roh2YA/kDEhQFN1U+XHGofmjpgT4VXSE4Vu5rzOirC8WjnCNN8wjqej2H2
         /LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683910157; x=1686502157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HutwX+KLgfv7Jubic5/xhBrVUiQ8CRoQwUCK5WkViRc=;
        b=cNUy+igYaZrKqxz4E8dbBTPRR7slQ9V/vY7wVptweqHKXONhHK42lZGv+xRaMUth4d
         rHmuzST2mEpaylQljBLOFnMwzYyBGoJWtOvjzmsK/J7rcVtIxe46MrNXxuqVVZ/TxIe6
         EM5lLf2qDiqhmCGKYDdUp61T767E6jHj2rjZ6lLRZVelxi516wwHSMjKgYAcSHzRBfyR
         rhNUj3JxslGbOgQlcsQYQEYELdLDCDDrVEGN3L5f2RrXgQMOwb81dZKcLUmOZ1VnyM0t
         yibmYYwNWdLScBC/bGqSWme0VXBTkOrAJAPGVFv5fiZgvU8EOzArTwsaM7qFIlg978Qd
         XwcA==
X-Gm-Message-State: AC+VfDwsd7RrXwKRl9v6aoVOJLamOH7TK/U6D4KLb9E6ZGIueAfiDagT
        QfZ+Kg7NO3mijRJciUYhyGDz1yUVKAY=
X-Google-Smtp-Source: ACHHUZ45I5a90y+oxAWYYYI9RbvhH7u37R2zaXbn6C+WPKUPKbwp6TJj6ccI/r/y9WuVKFErMiuW7g==
X-Received: by 2002:a2e:b61c:0:b0:2a8:bce4:c70f with SMTP id r28-20020a2eb61c000000b002a8bce4c70fmr4049054ljn.26.1683910156419;
        Fri, 12 May 2023 09:49:16 -0700 (PDT)
Received: from localhost.localdomain ([37.130.110.122])
        by smtp.gmail.com with ESMTPSA id j14-20020a2eb70e000000b002a8a77f4d03sm2839487ljo.59.2023.05.12.09.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 09:49:15 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] xtensa: add __bswap{si,di}2 helpers
Date:   Fri, 12 May 2023 09:48:15 -0700
Message-Id: <20230512164815.2150839-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-13 may generate calls for __bswap{si,di}2. This breaks the kernel
build when optimization for size is selected. Add __bswap{si,di}2
helpers to fix that.

Cc: stable@vger.kernel.org
Fixes: 19c5699f9aff ("xtensa: don't link with libgcc")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- add declarations and EXPORT_SYMBOL

 arch/xtensa/kernel/xtensa_ksyms.c |  4 ++++
 arch/xtensa/lib/Makefile          |  2 +-
 arch/xtensa/lib/bswapdi2.S        | 21 +++++++++++++++++++++
 arch/xtensa/lib/bswapsi2.S        | 16 ++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 arch/xtensa/lib/bswapdi2.S
 create mode 100644 arch/xtensa/lib/bswapsi2.S

diff --git a/arch/xtensa/kernel/xtensa_ksyms.c b/arch/xtensa/kernel/xtensa_ksyms.c
index 2a31b1ab0c9f..17a7ef86fd0d 100644
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -56,6 +56,8 @@ EXPORT_SYMBOL(empty_zero_page);
  */
 extern long long __ashrdi3(long long, int);
 extern long long __ashldi3(long long, int);
+extern long long __bswapdi2(long long);
+extern int __bswapsi2(int);
 extern long long __lshrdi3(long long, int);
 extern int __divsi3(int, int);
 extern int __modsi3(int, int);
@@ -66,6 +68,8 @@ extern unsigned long long __umulsidi3(unsigned int, unsigned int);
 
 EXPORT_SYMBOL(__ashldi3);
 EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__bswapdi2);
+EXPORT_SYMBOL(__bswapsi2);
 EXPORT_SYMBOL(__lshrdi3);
 EXPORT_SYMBOL(__divsi3);
 EXPORT_SYMBOL(__modsi3);
diff --git a/arch/xtensa/lib/Makefile b/arch/xtensa/lib/Makefile
index 7ecef0519a27..c9c2614188f7 100644
--- a/arch/xtensa/lib/Makefile
+++ b/arch/xtensa/lib/Makefile
@@ -4,7 +4,7 @@
 #
 
 lib-y	+= memcopy.o memset.o checksum.o \
-	   ashldi3.o ashrdi3.o lshrdi3.o \
+	   ashldi3.o ashrdi3.o bswapdi2.o bswapsi2.o lshrdi3.o \
 	   divsi3.o udivsi3.o modsi3.o umodsi3.o mulsi3.o umulsidi3.o \
 	   usercopy.o strncpy_user.o strnlen_user.o
 lib-$(CONFIG_PCI) += pci-auto.o
diff --git a/arch/xtensa/lib/bswapdi2.S b/arch/xtensa/lib/bswapdi2.S
new file mode 100644
index 000000000000..d8e52e05eba6
--- /dev/null
+++ b/arch/xtensa/lib/bswapdi2.S
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+ENTRY(__bswapdi2)
+
+	abi_entry_default
+	ssai	8
+	srli	a4, a2, 16
+	src	a4, a4, a2
+	src	a4, a4, a4
+	src	a4, a2, a4
+	srli	a2, a3, 16
+	src	a2, a2, a3
+	src	a2, a2, a2
+	src	a2, a3, a2
+	mov	a3, a4
+	abi_ret_default
+
+ENDPROC(__bswapdi2)
diff --git a/arch/xtensa/lib/bswapsi2.S b/arch/xtensa/lib/bswapsi2.S
new file mode 100644
index 000000000000..9c1de1344f79
--- /dev/null
+++ b/arch/xtensa/lib/bswapsi2.S
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH GCC-exception-2.0 */
+#include <linux/linkage.h>
+#include <asm/asmmacro.h>
+#include <asm/core.h>
+
+ENTRY(__bswapsi2)
+
+	abi_entry_default
+	ssai	8
+	srli	a3, a2, 16
+	src	a3, a3, a2
+	src	a3, a3, a3
+	src	a2, a2, a3
+	abi_ret_default
+
+ENDPROC(__bswapsi2)
-- 
2.30.2

