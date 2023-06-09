Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D317728E16
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjFICep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjFICen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:34:43 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FEE1993
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:34:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-653f9c7b3e4so1012798b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686278081; x=1688870081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=57uh27oEnBpOdflliCe0G1T4BtKCh+1ndrEGpWR7AZg=;
        b=eVa3o8Hm94VBhhiBZhCP+hUJkZZOzvHJveiZVBEVgt2ZdKti8Sg88MwK8O12SALErB
         Mg2l3RXTooFdQbGrlcykejODohjNhEKDuoIztLpmhQ2YkXkw+vmJ7PdWG6MT98sl67bv
         IeSLiPoXAGh5jQu91nU04W10CJaBcXurksBJq9C2KFB4ssEGzcp07wwBttKRnC4XXFcJ
         n/OY2GFYb18kE3sccXo9ndsMswr/1mlA+uvEmOex31Gz+ghjWcOahoelHDGkCcOU/33v
         NTdEd01R1207+a2wYeqCXaJWmxjUdYd72xdiDtKwl4pYU4GSyddGFuZCMj8HFDmvWDDi
         zr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686278081; x=1688870081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57uh27oEnBpOdflliCe0G1T4BtKCh+1ndrEGpWR7AZg=;
        b=IJtfVn9NLj/vtmE7dnZdtVXTvNuYDha+WIln7UeKWTEOHJAcBRPMd5YbUQlVpUtEpF
         J68AuSUhDbBx0qpvSHH/NG2XNq1K1hKuDv7dllImTxOFgJz5q4YWbiehMlUtlat7aDP/
         Rrdoc5efakimIVtWtHHQGp36UnYR9+YErH4LfMuloQ8LmTEQUZLUG8avsjSp3tz6MCPt
         qHZYw2c0rwfuQcdFBlEa1EXWLLA7XPLdH4CyoJUfT2i00SjzOfygSxdKcYWlaXcH5T5l
         sB4hcdOX732rBYOhIULI9H9X4Xs5tNga7J2AhLX/P4G1/73GR4jDWVfUlknB6PkDFW7e
         IuIQ==
X-Gm-Message-State: AC+VfDw1wthSc84UdSk0NCrrqGJ6XfY8VancFIbHXgB1CSEpMAKMkrNW
        tfQKoHo4UE7VvrQ8dnfOnPGpX37ttPI=
X-Google-Smtp-Source: ACHHUZ4vtawUqzRGVgQ3RGFhc3hDN50BLF1ucjbLSl1VI64yD2RJJBcAKva827ZrAkmPUYQSlyJwaw==
X-Received: by 2002:a05:6a20:1453:b0:111:2f20:d48f with SMTP id a19-20020a056a20145300b001112f20d48fmr7043003pzi.53.1686278081199;
        Thu, 08 Jun 2023 19:34:41 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3aa3:2af1:e3f1:5039])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902bd8400b001ab061e352bsm2040343pls.195.2023.06.08.19.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 19:34:40 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: add asm-prototypes.h
Date:   Thu,  8 Jun 2023 19:34:33 -0700
Message-Id: <20230609023433.1694994-1-jcmvbkbc@gmail.com>
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

Move assembly source prototypes from xtensa_ksyms.c to
asm/asm-prototypes.h and enable HAVE_ASM_MODVERSIONS for xtensa.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig                      |  1 +
 arch/xtensa/include/asm/asm-prototypes.h | 22 ++++++++++++++++++++++
 arch/xtensa/kernel/xtensa_ksyms.c        | 16 +---------------
 3 files changed, 24 insertions(+), 15 deletions(-)
 create mode 100644 arch/xtensa/include/asm/asm-prototypes.h

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 3c6e5471f025..46051edc5ed3 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -35,6 +35,7 @@ config XTENSA
 	select HAVE_ARCH_KCSAN
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
diff --git a/arch/xtensa/include/asm/asm-prototypes.h b/arch/xtensa/include/asm/asm-prototypes.h
new file mode 100644
index 000000000000..5220226e956c
--- /dev/null
+++ b/arch/xtensa/include/asm/asm-prototypes.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_PROTOTYPES_H
+#define __ASM_PROTOTYPES_H
+
+#include <asm-generic/asm-prototypes.h>
+
+/*
+ * gcc internal math functions
+ */
+long long __ashrdi3(long long, int);
+long long __ashldi3(long long, int);
+long long __bswapdi2(long long);
+int __bswapsi2(int);
+long long __lshrdi3(long long, int);
+int __divsi3(int, int);
+int __modsi3(int, int);
+int __mulsi3(int, int);
+unsigned int __udivsi3(unsigned int, unsigned int);
+unsigned int __umodsi3(unsigned int, unsigned int);
+unsigned long long __umulsidi3(unsigned int, unsigned int);
+
+#endif /* __ASM_PROTOTYPES_H */
diff --git a/arch/xtensa/kernel/xtensa_ksyms.c b/arch/xtensa/kernel/xtensa_ksyms.c
index 17a7ef86fd0d..3b2c088ae11f 100644
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -20,6 +20,7 @@
 #include <linux/in6.h>
 
 #include <linux/uaccess.h>
+#include <asm/asm-prototypes.h>
 #include <asm/cacheflush.h>
 #include <asm/checksum.h>
 #include <asm/dma.h>
@@ -51,21 +52,6 @@ EXPORT_SYMBOL(copy_page);
 
 EXPORT_SYMBOL(empty_zero_page);
 
-/*
- * gcc internal math functions
- */
-extern long long __ashrdi3(long long, int);
-extern long long __ashldi3(long long, int);
-extern long long __bswapdi2(long long);
-extern int __bswapsi2(int);
-extern long long __lshrdi3(long long, int);
-extern int __divsi3(int, int);
-extern int __modsi3(int, int);
-extern int __mulsi3(int, int);
-extern unsigned int __udivsi3(unsigned int, unsigned int);
-extern unsigned int __umodsi3(unsigned int, unsigned int);
-extern unsigned long long __umulsidi3(unsigned int, unsigned int);
-
 EXPORT_SYMBOL(__ashldi3);
 EXPORT_SYMBOL(__ashrdi3);
 EXPORT_SYMBOL(__bswapdi2);
-- 
2.30.2

