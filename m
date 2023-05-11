Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614006FF89B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbjEKRgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbjEKRf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:35:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EC29026
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:35:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f26f437b30so975519e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683826522; x=1686418522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rRJ8mjKU8Qcia6O7HD6C6QcAo5Zo1M6tYvByRc32EUo=;
        b=iB0fi5privuoqJO2tpfT7qFW35KoAtArxs9XTNaQE2cwjsyyCwjxbVDVfCD2rE7B9o
         V73T2EPGfIhZ2f55Rurtw2tQDYe8v7teYb0LouRi073zykhOSMk5642LeGF1sjrbraX1
         0uex54Y2eB01kC1DbxS4GbBP/BHQyGyyGimI8XwJ+tb1z36ZJpHy7jcLy8Teo0OLh64G
         K6g0PN4iItBcd/EP6eJnWW0QXx8c3k3tPitEB0lEG2ZsJTy02iv6wJQdCziRtGb4qvJD
         Iso7233sdvG0l9wU/IRk8AB+oDZqLxba40cXaDk8DSAXfHVrbX3iUtF+PyZDNm9mtzeH
         hnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683826522; x=1686418522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRJ8mjKU8Qcia6O7HD6C6QcAo5Zo1M6tYvByRc32EUo=;
        b=AAZnkiapPmhItVnN3s5NHenO8edjdFscMAKBUNFl3WsRauj9yTg2Ave+N+5spsO3Bn
         QD7VAaGf40Ys2H4q9cyHB+xnczXW4+i/QJo3+27BuVX6AucshxbpGHh4ipp7YZo2JWZj
         cpmF3Zh3Zppl6LVMYkrUGAoUzHwy/dTyTXF+XhAkGHzF8UXznO/vbhR0VPWfvDszb86i
         nYcF0Lv/yJj02KYsvR9Vdym2dJ5nreObml62SCflRXcXr1wiDb80szyMFPcL7ZFwABOo
         z1EEeHQ+H9v3mZI39cedZwEFKV6WL7XO10Rqm2QaqWmRFLvd0iXqLqxO/GclW+uiX1WT
         3P/g==
X-Gm-Message-State: AC+VfDwo084h76xJ6s11xGK1A6lOPXaxVT0FJ36D4oIkarx43Vvgg5W5
        +wp2wFFKbY9BQWz2GPLES7Sckl1K27k=
X-Google-Smtp-Source: ACHHUZ5e9PwWzQEKP0i+i7ZwrqpJvpjNAAkkuFZkRvVh7dLc7NQxfiO0XSeASOPoPtpodYEdm0EI5g==
X-Received: by 2002:ac2:4461:0:b0:4e9:c627:195d with SMTP id y1-20020ac24461000000b004e9c627195dmr2571758lfl.57.1683826522332;
        Thu, 11 May 2023 10:35:22 -0700 (PDT)
Received: from localhost.localdomain ([37.130.110.122])
        by smtp.gmail.com with ESMTPSA id t12-20020ac243ac000000b004a6f66eed7fsm1172538lfl.165.2023.05.11.10.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:35:21 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: add __bswap{si,di}2 helpers
Date:   Thu, 11 May 2023 10:34:28 -0700
Message-Id: <20230511173428.1757265-1-jcmvbkbc@gmail.com>
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

Fixes: 19c5699f9aff ("xtensa: don't link with libgcc")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/lib/Makefile   |  2 +-
 arch/xtensa/lib/bswapdi2.S | 21 +++++++++++++++++++++
 arch/xtensa/lib/bswapsi2.S | 16 ++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 arch/xtensa/lib/bswapdi2.S
 create mode 100644 arch/xtensa/lib/bswapsi2.S

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

