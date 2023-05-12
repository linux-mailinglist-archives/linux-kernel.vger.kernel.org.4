Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E00970033B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbjELJCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240318AbjELJCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:02:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D07DD99
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:02:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f24ceae142so7494561e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683882127; x=1686474127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYsTuiYlWJfilS+f53bhPgeN+o2WHD+Xkevp/Tel5aM=;
        b=llRRZrd/C+dOpgtWf8x5y97R7dZamJQrXTjRbJgV4bTURSc5wlO4Q6gx7UavdfoOd/
         5bOjufDm3mlk5UQx5sjc47q1+0u7dIgSWbsYkYWhnY3SlDiqaLlWSbAaWip8OYGlZO4K
         EMm8y6K8BG69k2QGJPD7zrQvqMbz41ee68iLOfPto2V61GqVzKR9G1QaewDL3H/aoi6w
         9Tgqh4awidXTAiZd5BldO5TTXEbpotpcD69mH8WXgXqsq3yev3FROrcHe0jwLDtc9YVw
         Ey3yRfVNfN4+REqKyC2oSL6piFgGSR2gjpcNkfLSdocYPSyjCEaQW/NOyw3f2TbkoSgR
         UhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683882127; x=1686474127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYsTuiYlWJfilS+f53bhPgeN+o2WHD+Xkevp/Tel5aM=;
        b=cukRipvH2wawb6+CZ9q02eVgLxXIg5K6fT5VUqpHMoLh46DRTMCnFhX52Xq0FMTnym
         tp3GVb6R2SwN9Jul3XjL9XEC8DgPP454WKGPOcsH3K0+da/7kZ4rk6XMjX0fn+oSlfYe
         BXV6x5BhLMFXA0r/fnfAL+lbIrPD7E5v7uaqoSfHm0EleCJJliD7nG2RomttZCSy8Y7e
         87+jaMUiXy2pNoXRdltWG5eqDOI19zgLoIDdUz2J80GgDjjj3n/A354PeG5V8RP6aFAf
         F1XbIn0hkyd3PkgpM+XFNSBqs4ePURE6MIHzhgoRMwuAAvw/ImJ19KBYtFLoUsgNfRFe
         eIRQ==
X-Gm-Message-State: AC+VfDypV/HYcAWNjjZB+KTHRPimAUYTwpAYSBhTjPteNi8UHwKCCzaI
        8Fx+4wGA5HLL4BHNV1nKoQD280+JrzU=
X-Google-Smtp-Source: ACHHUZ7wcxWPKVXSVbsOxuJD6b9qSpou6fb/Mqx4fyE6DPB0GA2Zti9+M/L14bwVLbXQH7hAKnwISA==
X-Received: by 2002:ac2:46fc:0:b0:4ef:d3f3:c421 with SMTP id q28-20020ac246fc000000b004efd3f3c421mr4291328lfo.4.1683882127037;
        Fri, 12 May 2023 02:02:07 -0700 (PDT)
Received: from localhost.localdomain ([37.130.110.122])
        by smtp.gmail.com with ESMTPSA id b13-20020ac25e8d000000b004cb14fa604csm1403326lfq.262.2023.05.12.02.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:02:06 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2] xtensa: add __bswap{si,di}2 helpers
Date:   Fri, 12 May 2023 02:01:14 -0700
Message-Id: <20230512090114.2143572-1-jcmvbkbc@gmail.com>
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

