Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC65B73B8F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjFWNoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjFWNoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:44:15 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BBA1FE1;
        Fri, 23 Jun 2023 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687527852; bh=ZJI78+EPNTp82LSUythHTSjkLEKJnQKH+YZh2u1h6f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHJr2KhxCtSIMq1CF71GM745UnDdJH35CzRxq05bJNeYqqiBxqkZM3Pqgnyfgzp57
         48tFm3jhTJiqAXRbaYE4Ny3ySfX14KOqMQHMlS8OkRQ6ii/oLkoI72b6PLK7ynma/N
         hC2VOT3XAiAmNsw44ev5GL9UbmBDQZvovPjQRuFA=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 3B330605E5;
        Fri, 23 Jun 2023 21:44:12 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 4/9] LoongArch: Make {read,write}_fcsr compatible with LLVM/Clang
Date:   Fri, 23 Jun 2023 21:43:46 +0800
Message-Id: <20230623134351.1898379-5-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230623134351.1898379-1-kernel@xen0n.name>
References: <20230623134351.1898379-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

LLVM/Clang does not see FCSRs as GPRs, so make use of compiler
built-ins instead for better maintainability with less code.

The existing version cannot be wholly removed though, because the
built-ins, while available on GCC too, is predicated TARGET_HARD_FLOAT,
which means soft-float code cannot make use of them.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/include/asm/loongarch.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index ac83e60c60d1..eedc313b5241 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1445,12 +1445,6 @@ __BUILD_CSR_OP(tlbidx)
 #define EXCCODE_INT_START	64
 #define EXCCODE_INT_END		(EXCCODE_INT_START + EXCCODE_INT_NUM - 1)
 
-/* FPU register names */
-#define LOONGARCH_FCSR0	$r0
-#define LOONGARCH_FCSR1	$r1
-#define LOONGARCH_FCSR2	$r2
-#define LOONGARCH_FCSR3	$r3
-
 /* FPU Status Register Values */
 #define FPU_CSR_RSVD	0xe0e0fce0
 
@@ -1487,6 +1481,18 @@ __BUILD_CSR_OP(tlbidx)
 #define FPU_CSR_RU	0x200	/* towards +Infinity */
 #define FPU_CSR_RD	0x300	/* towards -Infinity */
 
+#ifdef CONFIG_CC_IS_CLANG
+#define LOONGARCH_FCSR0	0
+#define LOONGARCH_FCSR1	1
+#define LOONGARCH_FCSR2	2
+#define LOONGARCH_FCSR3	3
+#define read_fcsr(source)	__movfcsr2gr(source)
+#define write_fcsr(dest, val)	__movgr2fcsr(dest, val)
+#else /* CONFIG_CC_IS_CLANG */
+#define LOONGARCH_FCSR0	$r0
+#define LOONGARCH_FCSR1	$r1
+#define LOONGARCH_FCSR2	$r2
+#define LOONGARCH_FCSR3	$r3
 #define read_fcsr(source)	\
 ({	\
 	unsigned int __res;	\
@@ -1503,5 +1509,6 @@ do {	\
 	"	movgr2fcsr	"__stringify(dest)", %0	\n"	\
 	: : "r" (val));	\
 } while (0)
+#endif /* CONFIG_CC_IS_CLANG */
 
 #endif /* _ASM_LOONGARCH_H */
-- 
2.40.0

