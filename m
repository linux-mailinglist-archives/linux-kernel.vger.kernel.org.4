Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FF65E9DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiIZJhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiIZJhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:37:00 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D084E237F5;
        Mon, 26 Sep 2022 02:36:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VQkJzEH_1664184995;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VQkJzEH_1664184995)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 17:36:36 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 06/16] crypto: arm64/sm4 - refactor and simplify CE implementation
Date:   Mon, 26 Sep 2022 17:36:10 +0800
Message-Id: <20220926093620.99898-7-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220926093620.99898-1-tianjia.zhang@linux.alibaba.com>
References: <20220926093620.99898-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not add new features, but only refactors and simplifies the
implementation of the Crypto Extension acceleration of the SM4 algorithm:

Extract the macro optimized by SM4 Crypto Extension for reuse in the
subsequent optimization of CCM/GCM modes.

Encryption in CBC and CFB modes processes four blocks at a time instead of
one, allowing the ld1 instruction to load 64 bytes of data at a time, which
will reduces unnecessary memory accesses.

CBC/CFB/CTR makes full use of free registers to reduce redundant memory
accesses, and rearranges some instructions to improve out-of-order execution
capabilities.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/sm4-ce-asm.h  | 209 +++++++++++
 arch/arm64/crypto/sm4-ce-core.S | 646 ++++++++++++++------------------
 arch/arm64/crypto/sm4-ce-glue.c |  64 ++--
 3 files changed, 519 insertions(+), 400 deletions(-)
 create mode 100644 arch/arm64/crypto/sm4-ce-asm.h

diff --git a/arch/arm64/crypto/sm4-ce-asm.h b/arch/arm64/crypto/sm4-ce-asm.h
new file mode 100644
index 000000000000..7ea98e42e779
--- /dev/null
+++ b/arch/arm64/crypto/sm4-ce-asm.h
@@ -0,0 +1,209 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SM4 helper macros for Crypto Extensions
+ * Copyright (C) 2022 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+#define SM4_PREPARE(ptr)					\
+	ld1		{v24.16b-v27.16b}, [ptr], #64;		\
+	ld1		{v28.16b-v31.16b}, [ptr];
+
+#define SM4_CRYPT_BLK_BE(b0)					\
+	sm4e		b0.4s, v24.4s;				\
+	sm4e		b0.4s, v25.4s;				\
+	sm4e		b0.4s, v26.4s;				\
+	sm4e		b0.4s, v27.4s;				\
+	sm4e		b0.4s, v28.4s;				\
+	sm4e		b0.4s, v29.4s;				\
+	sm4e		b0.4s, v30.4s;				\
+	sm4e		b0.4s, v31.4s;				\
+	rev64		b0.4s, b0.4s;				\
+	ext		b0.16b, b0.16b, b0.16b, #8;		\
+	rev32		b0.16b, b0.16b;
+
+#define SM4_CRYPT_BLK(b0)					\
+	rev32		b0.16b, b0.16b;				\
+	SM4_CRYPT_BLK_BE(b0);
+
+#define SM4_CRYPT_BLK2_BE(b0, b1)				\
+	sm4e		b0.4s, v24.4s;				\
+	sm4e		b1.4s, v24.4s;				\
+	sm4e		b0.4s, v25.4s;				\
+	sm4e		b1.4s, v25.4s;				\
+	sm4e		b0.4s, v26.4s;				\
+	sm4e		b1.4s, v26.4s;				\
+	sm4e		b0.4s, v27.4s;				\
+	sm4e		b1.4s, v27.4s;				\
+	sm4e		b0.4s, v28.4s;				\
+	sm4e		b1.4s, v28.4s;				\
+	sm4e		b0.4s, v29.4s;				\
+	sm4e		b1.4s, v29.4s;				\
+	sm4e		b0.4s, v30.4s;				\
+	sm4e		b1.4s, v30.4s;				\
+	sm4e		b0.4s, v31.4s;				\
+	sm4e		b1.4s, v31.4s;				\
+	rev64		b0.4s, b0.4s;				\
+	rev64		b1.4s, b1.4s;				\
+	ext		b0.16b, b0.16b, b0.16b, #8;		\
+	ext		b1.16b, b1.16b, b1.16b, #8;		\
+	rev32		b0.16b, b0.16b;				\
+	rev32		b1.16b, b1.16b;				\
+
+#define SM4_CRYPT_BLK2(b0, b1)					\
+	rev32		b0.16b, b0.16b;				\
+	rev32		b1.16b, b1.16b;				\
+	SM4_CRYPT_BLK2_BE(b0, b1);
+
+#define SM4_CRYPT_BLK4_BE(b0, b1, b2, b3)			\
+	sm4e		b0.4s, v24.4s;				\
+	sm4e		b1.4s, v24.4s;				\
+	sm4e		b2.4s, v24.4s;				\
+	sm4e		b3.4s, v24.4s;				\
+	sm4e		b0.4s, v25.4s;				\
+	sm4e		b1.4s, v25.4s;				\
+	sm4e		b2.4s, v25.4s;				\
+	sm4e		b3.4s, v25.4s;				\
+	sm4e		b0.4s, v26.4s;				\
+	sm4e		b1.4s, v26.4s;				\
+	sm4e		b2.4s, v26.4s;				\
+	sm4e		b3.4s, v26.4s;				\
+	sm4e		b0.4s, v27.4s;				\
+	sm4e		b1.4s, v27.4s;				\
+	sm4e		b2.4s, v27.4s;				\
+	sm4e		b3.4s, v27.4s;				\
+	sm4e		b0.4s, v28.4s;				\
+	sm4e		b1.4s, v28.4s;				\
+	sm4e		b2.4s, v28.4s;				\
+	sm4e		b3.4s, v28.4s;				\
+	sm4e		b0.4s, v29.4s;				\
+	sm4e		b1.4s, v29.4s;				\
+	sm4e		b2.4s, v29.4s;				\
+	sm4e		b3.4s, v29.4s;				\
+	sm4e		b0.4s, v30.4s;				\
+	sm4e		b1.4s, v30.4s;				\
+	sm4e		b2.4s, v30.4s;				\
+	sm4e		b3.4s, v30.4s;				\
+	sm4e		b0.4s, v31.4s;				\
+	sm4e		b1.4s, v31.4s;				\
+	sm4e		b2.4s, v31.4s;				\
+	sm4e		b3.4s, v31.4s;				\
+	rev64		b0.4s, b0.4s;				\
+	rev64		b1.4s, b1.4s;				\
+	rev64		b2.4s, b2.4s;				\
+	rev64		b3.4s, b3.4s;				\
+	ext		b0.16b, b0.16b, b0.16b, #8;		\
+	ext		b1.16b, b1.16b, b1.16b, #8;		\
+	ext		b2.16b, b2.16b, b2.16b, #8;		\
+	ext		b3.16b, b3.16b, b3.16b, #8;		\
+	rev32		b0.16b, b0.16b;				\
+	rev32		b1.16b, b1.16b;				\
+	rev32		b2.16b, b2.16b;				\
+	rev32		b3.16b, b3.16b;
+
+#define SM4_CRYPT_BLK4(b0, b1, b2, b3)				\
+	rev32		b0.16b, b0.16b;				\
+	rev32		b1.16b, b1.16b;				\
+	rev32		b2.16b, b2.16b;				\
+	rev32		b3.16b, b3.16b;				\
+	SM4_CRYPT_BLK4_BE(b0, b1, b2, b3);
+
+#define SM4_CRYPT_BLK8_BE(b0, b1, b2, b3, b4, b5, b6, b7)	\
+	sm4e		b0.4s, v24.4s;				\
+	sm4e		b1.4s, v24.4s;				\
+	sm4e		b2.4s, v24.4s;				\
+	sm4e		b3.4s, v24.4s;				\
+	sm4e		b4.4s, v24.4s;				\
+	sm4e		b5.4s, v24.4s;				\
+	sm4e		b6.4s, v24.4s;				\
+	sm4e		b7.4s, v24.4s;				\
+	sm4e		b0.4s, v25.4s;				\
+	sm4e		b1.4s, v25.4s;				\
+	sm4e		b2.4s, v25.4s;				\
+	sm4e		b3.4s, v25.4s;				\
+	sm4e		b4.4s, v25.4s;				\
+	sm4e		b5.4s, v25.4s;				\
+	sm4e		b6.4s, v25.4s;				\
+	sm4e		b7.4s, v25.4s;				\
+	sm4e		b0.4s, v26.4s;				\
+	sm4e		b1.4s, v26.4s;				\
+	sm4e		b2.4s, v26.4s;				\
+	sm4e		b3.4s, v26.4s;				\
+	sm4e		b4.4s, v26.4s;				\
+	sm4e		b5.4s, v26.4s;				\
+	sm4e		b6.4s, v26.4s;				\
+	sm4e		b7.4s, v26.4s;				\
+	sm4e		b0.4s, v27.4s;				\
+	sm4e		b1.4s, v27.4s;				\
+	sm4e		b2.4s, v27.4s;				\
+	sm4e		b3.4s, v27.4s;				\
+	sm4e		b4.4s, v27.4s;				\
+	sm4e		b5.4s, v27.4s;				\
+	sm4e		b6.4s, v27.4s;				\
+	sm4e		b7.4s, v27.4s;				\
+	sm4e		b0.4s, v28.4s;				\
+	sm4e		b1.4s, v28.4s;				\
+	sm4e		b2.4s, v28.4s;				\
+	sm4e		b3.4s, v28.4s;				\
+	sm4e		b4.4s, v28.4s;				\
+	sm4e		b5.4s, v28.4s;				\
+	sm4e		b6.4s, v28.4s;				\
+	sm4e		b7.4s, v28.4s;				\
+	sm4e		b0.4s, v29.4s;				\
+	sm4e		b1.4s, v29.4s;				\
+	sm4e		b2.4s, v29.4s;				\
+	sm4e		b3.4s, v29.4s;				\
+	sm4e		b4.4s, v29.4s;				\
+	sm4e		b5.4s, v29.4s;				\
+	sm4e		b6.4s, v29.4s;				\
+	sm4e		b7.4s, v29.4s;				\
+	sm4e		b0.4s, v30.4s;				\
+	sm4e		b1.4s, v30.4s;				\
+	sm4e		b2.4s, v30.4s;				\
+	sm4e		b3.4s, v30.4s;				\
+	sm4e		b4.4s, v30.4s;				\
+	sm4e		b5.4s, v30.4s;				\
+	sm4e		b6.4s, v30.4s;				\
+	sm4e		b7.4s, v30.4s;				\
+	sm4e		b0.4s, v31.4s;				\
+	sm4e		b1.4s, v31.4s;				\
+	sm4e		b2.4s, v31.4s;				\
+	sm4e		b3.4s, v31.4s;				\
+	sm4e		b4.4s, v31.4s;				\
+	sm4e		b5.4s, v31.4s;				\
+	sm4e		b6.4s, v31.4s;				\
+	sm4e		b7.4s, v31.4s;				\
+	rev64		b0.4s, b0.4s;				\
+	rev64		b1.4s, b1.4s;				\
+	rev64		b2.4s, b2.4s;				\
+	rev64		b3.4s, b3.4s;				\
+	rev64		b4.4s, b4.4s;				\
+	rev64		b5.4s, b5.4s;				\
+	rev64		b6.4s, b6.4s;				\
+	rev64		b7.4s, b7.4s;				\
+	ext		b0.16b, b0.16b, b0.16b, #8;		\
+	ext		b1.16b, b1.16b, b1.16b, #8;		\
+	ext		b2.16b, b2.16b, b2.16b, #8;		\
+	ext		b3.16b, b3.16b, b3.16b, #8;		\
+	ext		b4.16b, b4.16b, b4.16b, #8;		\
+	ext		b5.16b, b5.16b, b5.16b, #8;		\
+	ext		b6.16b, b6.16b, b6.16b, #8;		\
+	ext		b7.16b, b7.16b, b7.16b, #8;		\
+	rev32		b0.16b, b0.16b;				\
+	rev32		b1.16b, b1.16b;				\
+	rev32		b2.16b, b2.16b;				\
+	rev32		b3.16b, b3.16b;				\
+	rev32		b4.16b, b4.16b;				\
+	rev32		b5.16b, b5.16b;				\
+	rev32		b6.16b, b6.16b;				\
+	rev32		b7.16b, b7.16b;
+
+#define SM4_CRYPT_BLK8(b0, b1, b2, b3, b4, b5, b6, b7)		\
+	rev32		b0.16b, b0.16b;				\
+	rev32		b1.16b, b1.16b;				\
+	rev32		b2.16b, b2.16b;				\
+	rev32		b3.16b, b3.16b;				\
+	rev32		b4.16b, b4.16b;				\
+	rev32		b5.16b, b5.16b;				\
+	rev32		b6.16b, b6.16b;				\
+	rev32		b7.16b, b7.16b;				\
+	SM4_CRYPT_BLK8_BE(b0, b1, b2, b3, b4, b5, b6, b7);
diff --git a/arch/arm64/crypto/sm4-ce-core.S b/arch/arm64/crypto/sm4-ce-core.S
index 934e0f093279..41fc745a8528 100644
--- a/arch/arm64/crypto/sm4-ce-core.S
+++ b/arch/arm64/crypto/sm4-ce-core.S
@@ -10,10 +10,12 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include "sm4-ce-asm.h"
 
 .arch	armv8-a+crypto
 
-.irp b, 0, 1, 2, 3, 4, 5, 6, 7, 16, 20, 24, 25, 26, 27, 28, 29, 30, 31
+.irp b, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, \
+		20, 24, 25, 26, 27, 28, 29, 30, 31
 	.set .Lv\b\().4s, \b
 .endr
 
@@ -34,174 +36,6 @@
 
 #define RIV	v20
 
-/* Helper macros. */
-
-#define PREPARE                                       \
-	ld1		{v24.16b-v27.16b}, [x0], #64; \
-	ld1		{v28.16b-v31.16b}, [x0];
-
-#define SM4_CRYPT_BLK(b0)                           \
-	rev32		b0.16b, b0.16b;             \
-	sm4e		b0.4s, v24.4s;              \
-	sm4e		b0.4s, v25.4s;              \
-	sm4e		b0.4s, v26.4s;              \
-	sm4e		b0.4s, v27.4s;              \
-	sm4e		b0.4s, v28.4s;              \
-	sm4e		b0.4s, v29.4s;              \
-	sm4e		b0.4s, v30.4s;              \
-	sm4e		b0.4s, v31.4s;              \
-	rev64		b0.4s, b0.4s;               \
-	ext		b0.16b, b0.16b, b0.16b, #8; \
-	rev32		b0.16b, b0.16b;
-
-#define SM4_CRYPT_BLK4(b0, b1, b2, b3)              \
-	rev32		b0.16b, b0.16b;             \
-	rev32		b1.16b, b1.16b;             \
-	rev32		b2.16b, b2.16b;             \
-	rev32		b3.16b, b3.16b;             \
-	sm4e		b0.4s, v24.4s;              \
-	sm4e		b1.4s, v24.4s;              \
-	sm4e		b2.4s, v24.4s;              \
-	sm4e		b3.4s, v24.4s;              \
-	sm4e		b0.4s, v25.4s;              \
-	sm4e		b1.4s, v25.4s;              \
-	sm4e		b2.4s, v25.4s;              \
-	sm4e		b3.4s, v25.4s;              \
-	sm4e		b0.4s, v26.4s;              \
-	sm4e		b1.4s, v26.4s;              \
-	sm4e		b2.4s, v26.4s;              \
-	sm4e		b3.4s, v26.4s;              \
-	sm4e		b0.4s, v27.4s;              \
-	sm4e		b1.4s, v27.4s;              \
-	sm4e		b2.4s, v27.4s;              \
-	sm4e		b3.4s, v27.4s;              \
-	sm4e		b0.4s, v28.4s;              \
-	sm4e		b1.4s, v28.4s;              \
-	sm4e		b2.4s, v28.4s;              \
-	sm4e		b3.4s, v28.4s;              \
-	sm4e		b0.4s, v29.4s;              \
-	sm4e		b1.4s, v29.4s;              \
-	sm4e		b2.4s, v29.4s;              \
-	sm4e		b3.4s, v29.4s;              \
-	sm4e		b0.4s, v30.4s;              \
-	sm4e		b1.4s, v30.4s;              \
-	sm4e		b2.4s, v30.4s;              \
-	sm4e		b3.4s, v30.4s;              \
-	sm4e		b0.4s, v31.4s;              \
-	sm4e		b1.4s, v31.4s;              \
-	sm4e		b2.4s, v31.4s;              \
-	sm4e		b3.4s, v31.4s;              \
-	rev64		b0.4s, b0.4s;               \
-	rev64		b1.4s, b1.4s;               \
-	rev64		b2.4s, b2.4s;               \
-	rev64		b3.4s, b3.4s;               \
-	ext		b0.16b, b0.16b, b0.16b, #8; \
-	ext		b1.16b, b1.16b, b1.16b, #8; \
-	ext		b2.16b, b2.16b, b2.16b, #8; \
-	ext		b3.16b, b3.16b, b3.16b, #8; \
-	rev32		b0.16b, b0.16b;             \
-	rev32		b1.16b, b1.16b;             \
-	rev32		b2.16b, b2.16b;             \
-	rev32		b3.16b, b3.16b;
-
-#define SM4_CRYPT_BLK8(b0, b1, b2, b3, b4, b5, b6, b7) \
-	rev32		b0.16b, b0.16b;             \
-	rev32		b1.16b, b1.16b;             \
-	rev32		b2.16b, b2.16b;             \
-	rev32		b3.16b, b3.16b;             \
-	rev32		b4.16b, b4.16b;             \
-	rev32		b5.16b, b5.16b;             \
-	rev32		b6.16b, b6.16b;             \
-	rev32		b7.16b, b7.16b;             \
-	sm4e		b0.4s, v24.4s;              \
-	sm4e		b1.4s, v24.4s;              \
-	sm4e		b2.4s, v24.4s;              \
-	sm4e		b3.4s, v24.4s;              \
-	sm4e		b4.4s, v24.4s;              \
-	sm4e		b5.4s, v24.4s;              \
-	sm4e		b6.4s, v24.4s;              \
-	sm4e		b7.4s, v24.4s;              \
-	sm4e		b0.4s, v25.4s;              \
-	sm4e		b1.4s, v25.4s;              \
-	sm4e		b2.4s, v25.4s;              \
-	sm4e		b3.4s, v25.4s;              \
-	sm4e		b4.4s, v25.4s;              \
-	sm4e		b5.4s, v25.4s;              \
-	sm4e		b6.4s, v25.4s;              \
-	sm4e		b7.4s, v25.4s;              \
-	sm4e		b0.4s, v26.4s;              \
-	sm4e		b1.4s, v26.4s;              \
-	sm4e		b2.4s, v26.4s;              \
-	sm4e		b3.4s, v26.4s;              \
-	sm4e		b4.4s, v26.4s;              \
-	sm4e		b5.4s, v26.4s;              \
-	sm4e		b6.4s, v26.4s;              \
-	sm4e		b7.4s, v26.4s;              \
-	sm4e		b0.4s, v27.4s;              \
-	sm4e		b1.4s, v27.4s;              \
-	sm4e		b2.4s, v27.4s;              \
-	sm4e		b3.4s, v27.4s;              \
-	sm4e		b4.4s, v27.4s;              \
-	sm4e		b5.4s, v27.4s;              \
-	sm4e		b6.4s, v27.4s;              \
-	sm4e		b7.4s, v27.4s;              \
-	sm4e		b0.4s, v28.4s;              \
-	sm4e		b1.4s, v28.4s;              \
-	sm4e		b2.4s, v28.4s;              \
-	sm4e		b3.4s, v28.4s;              \
-	sm4e		b4.4s, v28.4s;              \
-	sm4e		b5.4s, v28.4s;              \
-	sm4e		b6.4s, v28.4s;              \
-	sm4e		b7.4s, v28.4s;              \
-	sm4e		b0.4s, v29.4s;              \
-	sm4e		b1.4s, v29.4s;              \
-	sm4e		b2.4s, v29.4s;              \
-	sm4e		b3.4s, v29.4s;              \
-	sm4e		b4.4s, v29.4s;              \
-	sm4e		b5.4s, v29.4s;              \
-	sm4e		b6.4s, v29.4s;              \
-	sm4e		b7.4s, v29.4s;              \
-	sm4e		b0.4s, v30.4s;              \
-	sm4e		b1.4s, v30.4s;              \
-	sm4e		b2.4s, v30.4s;              \
-	sm4e		b3.4s, v30.4s;              \
-	sm4e		b4.4s, v30.4s;              \
-	sm4e		b5.4s, v30.4s;              \
-	sm4e		b6.4s, v30.4s;              \
-	sm4e		b7.4s, v30.4s;              \
-	sm4e		b0.4s, v31.4s;              \
-	sm4e		b1.4s, v31.4s;              \
-	sm4e		b2.4s, v31.4s;              \
-	sm4e		b3.4s, v31.4s;              \
-	sm4e		b4.4s, v31.4s;              \
-	sm4e		b5.4s, v31.4s;              \
-	sm4e		b6.4s, v31.4s;              \
-	sm4e		b7.4s, v31.4s;              \
-	rev64		b0.4s, b0.4s;               \
-	rev64		b1.4s, b1.4s;               \
-	rev64		b2.4s, b2.4s;               \
-	rev64		b3.4s, b3.4s;               \
-	rev64		b4.4s, b4.4s;               \
-	rev64		b5.4s, b5.4s;               \
-	rev64		b6.4s, b6.4s;               \
-	rev64		b7.4s, b7.4s;               \
-	ext		b0.16b, b0.16b, b0.16b, #8; \
-	ext		b1.16b, b1.16b, b1.16b, #8; \
-	ext		b2.16b, b2.16b, b2.16b, #8; \
-	ext		b3.16b, b3.16b, b3.16b, #8; \
-	ext		b4.16b, b4.16b, b4.16b, #8; \
-	ext		b5.16b, b5.16b, b5.16b, #8; \
-	ext		b6.16b, b6.16b, b6.16b, #8; \
-	ext		b7.16b, b7.16b, b7.16b, #8; \
-	rev32		b0.16b, b0.16b;             \
-	rev32		b1.16b, b1.16b;             \
-	rev32		b2.16b, b2.16b;             \
-	rev32		b3.16b, b3.16b;             \
-	rev32		b4.16b, b4.16b;             \
-	rev32		b5.16b, b5.16b;             \
-	rev32		b6.16b, b6.16b;             \
-	rev32		b7.16b, b7.16b;
-
 
 .align 3
 SYM_FUNC_START(sm4_ce_expand_key)
@@ -268,7 +102,7 @@ SYM_FUNC_START(sm4_ce_crypt_block)
 	 *   x1: dst
 	 *   x2: src
 	 */
-	PREPARE;
+	SM4_PREPARE(x0)
 
 	ld1		{v0.16b}, [x2];
 	SM4_CRYPT_BLK(v0);
@@ -285,7 +119,7 @@ SYM_FUNC_START(sm4_ce_crypt)
 	 *   x2: src
 	 *   w3: nblocks
 	 */
-	PREPARE;
+	SM4_PREPARE(x0)
 
 .Lcrypt_loop_blk:
 	sub		w3, w3, #8;
@@ -337,26 +171,50 @@ SYM_FUNC_START(sm4_ce_cbc_enc)
 	 *   x3: iv (big endian, 128 bit)
 	 *   w4: nblocks
 	 */
-	PREPARE;
+	SM4_PREPARE(x0)
+
+	ld1		{RIV.16b}, [x3]
+
+.Lcbc_enc_loop_4x:
+	cmp		w4, #4
+	blt		.Lcbc_enc_loop_1x
+
+	sub		w4, w4, #4
 
-	ld1		{RIV.16b}, [x3];
+	ld1		{v0.16b-v3.16b}, [x2], #64
 
-.Lcbc_enc_loop:
-	sub		w4, w4, #1;
+	eor		v0.16b, v0.16b, RIV.16b
+	SM4_CRYPT_BLK(v0)
+	eor		v1.16b, v1.16b, v0.16b
+	SM4_CRYPT_BLK(v1)
+	eor		v2.16b, v2.16b, v1.16b
+	SM4_CRYPT_BLK(v2)
+	eor		v3.16b, v3.16b, v2.16b
+	SM4_CRYPT_BLK(v3)
 
-	ld1		{RTMP0.16b}, [x2], #16;
-	eor		RIV.16b, RIV.16b, RTMP0.16b;
+	st1		{v0.16b-v3.16b}, [x1], #64
+	mov		RIV.16b, v3.16b
 
-	SM4_CRYPT_BLK(RIV);
+	cbz		w4, .Lcbc_enc_end
+	b		.Lcbc_enc_loop_4x
 
-	st1		{RIV.16b}, [x1], #16;
+.Lcbc_enc_loop_1x:
+	sub		w4, w4, #1
 
-	cbnz		w4, .Lcbc_enc_loop;
+	ld1		{v0.16b}, [x2], #16
 
+	eor		RIV.16b, RIV.16b, v0.16b
+	SM4_CRYPT_BLK(RIV)
+
+	st1		{RIV.16b}, [x1], #16
+
+	cbnz		w4, .Lcbc_enc_loop_1x
+
+.Lcbc_enc_end:
 	/* store new IV */
-	st1		{RIV.16b}, [x3];
+	st1		{RIV.16b}, [x3]
 
-	ret;
+	ret
 SYM_FUNC_END(sm4_ce_cbc_enc)
 
 .align 3
@@ -368,79 +226,93 @@ SYM_FUNC_START(sm4_ce_cbc_dec)
 	 *   x3: iv (big endian, 128 bit)
 	 *   w4: nblocks
 	 */
-	PREPARE;
+	SM4_PREPARE(x0)
 
-	ld1		{RIV.16b}, [x3];
+	ld1		{RIV.16b}, [x3]
 
-.Lcbc_loop_blk:
-	sub		w4, w4, #8;
-	tbnz		w4, #31, .Lcbc_tail8;
+.Lcbc_dec_loop_8x:
+	sub		w4, w4, #8
+	tbnz		w4, #31, .Lcbc_dec_4x
 
-	ld1		{v0.16b-v3.16b}, [x2], #64;
-	ld1		{v4.16b-v7.16b}, [x2];
+	ld1		{v0.16b-v3.16b}, [x2], #64
+	ld1		{v4.16b-v7.16b}, [x2], #64
 
-	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
+	rev32		v8.16b, v0.16b
+	rev32		v9.16b, v1.16b
+	rev32		v10.16b, v2.16b
+	rev32		v11.16b, v3.16b
+	rev32		v12.16b, v4.16b
+	rev32		v13.16b, v5.16b
+	rev32		v14.16b, v6.16b
+	rev32		v15.16b, v7.16b
 
-	sub		x2, x2, #64;
-	eor		v0.16b, v0.16b, RIV.16b;
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v1.16b, v1.16b, RTMP0.16b;
-	eor		v2.16b, v2.16b, RTMP1.16b;
-	eor		v3.16b, v3.16b, RTMP2.16b;
-	st1		{v0.16b-v3.16b}, [x1], #64;
+	SM4_CRYPT_BLK8_BE(v8, v9, v10, v11, v12, v13, v14, v15)
 
-	eor		v4.16b, v4.16b, RTMP3.16b;
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v5.16b, v5.16b, RTMP0.16b;
-	eor		v6.16b, v6.16b, RTMP1.16b;
-	eor		v7.16b, v7.16b, RTMP2.16b;
+	eor		v8.16b, v8.16b, RIV.16b
+	eor		v9.16b, v9.16b, v0.16b
+	eor		v10.16b, v10.16b, v1.16b
+	eor		v11.16b, v11.16b, v2.16b
+	eor		v12.16b, v12.16b, v3.16b
+	eor		v13.16b, v13.16b, v4.16b
+	eor		v14.16b, v14.16b, v5.16b
+	eor		v15.16b, v15.16b, v6.16b
 
-	mov		RIV.16b, RTMP3.16b;
-	st1		{v4.16b-v7.16b}, [x1], #64;
+	st1		{v8.16b-v11.16b}, [x1], #64
+	st1		{v12.16b-v15.16b}, [x1], #64
 
-	cbz		w4, .Lcbc_end;
-	b		.Lcbc_loop_blk;
+	mov		RIV.16b, v7.16b
 
-.Lcbc_tail8:
-	add		w4, w4, #8;
-	cmp		w4, #4;
-	blt		.Lcbc_tail4;
+	cbz		w4, .Lcbc_dec_end
+	b		.Lcbc_dec_loop_8x
 
-	sub		w4, w4, #4;
+.Lcbc_dec_4x:
+	add		w4, w4, #8
+	cmp		w4, #4
+	blt		.Lcbc_dec_loop_1x
 
-	ld1		{v0.16b-v3.16b}, [x2];
+	sub		w4, w4, #4
 
-	SM4_CRYPT_BLK4(v0, v1, v2, v3);
+	ld1		{v0.16b-v3.16b}, [x2], #64
 
-	eor		v0.16b, v0.16b, RIV.16b;
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v1.16b, v1.16b, RTMP0.16b;
-	eor		v2.16b, v2.16b, RTMP1.16b;
-	eor		v3.16b, v3.16b, RTMP2.16b;
+	rev32		v8.16b, v0.16b
+	rev32		v9.16b, v1.16b
+	rev32		v10.16b, v2.16b
+	rev32		v11.16b, v3.16b
 
-	mov		RIV.16b, RTMP3.16b;
-	st1		{v0.16b-v3.16b}, [x1], #64;
+	SM4_CRYPT_BLK4_BE(v8, v9, v10, v11)
 
-	cbz		w4, .Lcbc_end;
+	eor		v8.16b, v8.16b, RIV.16b
+	eor		v9.16b, v9.16b, v0.16b
+	eor		v10.16b, v10.16b, v1.16b
+	eor		v11.16b, v11.16b, v2.16b
 
-.Lcbc_tail4:
-	sub		w4, w4, #1;
+	st1		{v8.16b-v11.16b}, [x1], #64
 
-	ld1		{v0.16b}, [x2];
+	mov		RIV.16b, v3.16b
 
-	SM4_CRYPT_BLK(v0);
+	cbz		w4, .Lcbc_dec_end
 
-	eor		v0.16b, v0.16b, RIV.16b;
-	ld1		{RIV.16b}, [x2], #16;
-	st1		{v0.16b}, [x1], #16;
+.Lcbc_dec_loop_1x:
+	sub		w4, w4, #1
+
+	ld1		{v0.16b}, [x2], #16
+
+	rev32		v8.16b, v0.16b
+
+	SM4_CRYPT_BLK_BE(v8)
 
-	cbnz		w4, .Lcbc_tail4;
+	eor		v8.16b, v8.16b, RIV.16b
+	st1		{v8.16b}, [x1], #16
 
-.Lcbc_end:
+	mov		RIV.16b, v0.16b
+
+	cbnz		w4, .Lcbc_dec_loop_1x
+
+.Lcbc_dec_end:
 	/* store new IV */
-	st1		{RIV.16b}, [x3];
+	st1		{RIV.16b}, [x3]
 
-	ret;
+	ret
 SYM_FUNC_END(sm4_ce_cbc_dec)
 
 .align 3
@@ -452,25 +324,57 @@ SYM_FUNC_START(sm4_ce_cfb_enc)
 	 *   x3: iv (big endian, 128 bit)
 	 *   w4: nblocks
 	 */
-	PREPARE;
+	SM4_PREPARE(x0)
+
+	ld1		{RIV.16b}, [x3]
+
+.Lcfb_enc_loop_4x:
+	cmp		w4, #4
+	blt		.Lcfb_enc_loop_1x
+
+	sub		w4, w4, #4
+
+	ld1		{v0.16b-v3.16b}, [x2], #64
+
+	rev32		v8.16b, RIV.16b
+	SM4_CRYPT_BLK_BE(v8)
+	eor		v0.16b, v0.16b, v8.16b
+
+	rev32		v8.16b, v0.16b
+	SM4_CRYPT_BLK_BE(v8)
+	eor		v1.16b, v1.16b, v8.16b
+
+	rev32		v8.16b, v1.16b
+	SM4_CRYPT_BLK_BE(v8)
+	eor		v2.16b, v2.16b, v8.16b
+
+	rev32		v8.16b, v2.16b
+	SM4_CRYPT_BLK_BE(v8)
+	eor		v3.16b, v3.16b, v8.16b
 
-	ld1		{RIV.16b}, [x3];
+	st1		{v0.16b-v3.16b}, [x1], #64
+	mov		RIV.16b, v3.16b
 
-.Lcfb_enc_loop:
-	sub		w4, w4, #1;
+	cbz		w4, .Lcfb_enc_end
+	b		.Lcfb_enc_loop_4x
 
-	SM4_CRYPT_BLK(RIV);
+.Lcfb_enc_loop_1x:
+	sub		w4, w4, #1
 
-	ld1		{RTMP0.16b}, [x2], #16;
-	eor		RIV.16b, RIV.16b, RTMP0.16b;
-	st1		{RIV.16b}, [x1], #16;
+	ld1		{v0.16b}, [x2], #16
 
-	cbnz		w4, .Lcfb_enc_loop;
+	SM4_CRYPT_BLK(RIV)
+	eor		RIV.16b, RIV.16b, v0.16b
 
+	st1		{RIV.16b}, [x1], #16
+
+	cbnz		w4, .Lcfb_enc_loop_1x
+
+.Lcfb_enc_end:
 	/* store new IV */
-	st1		{RIV.16b}, [x3];
+	st1		{RIV.16b}, [x3]
 
-	ret;
+	ret
 SYM_FUNC_END(sm4_ce_cfb_enc)
 
 .align 3
@@ -482,79 +386,91 @@ SYM_FUNC_START(sm4_ce_cfb_dec)
 	 *   x3: iv (big endian, 128 bit)
 	 *   w4: nblocks
 	 */
-	PREPARE;
+	SM4_PREPARE(x0)
 
-	ld1		{v0.16b}, [x3];
+	ld1		{RIV.16b}, [x3]
 
-.Lcfb_loop_blk:
-	sub		w4, w4, #8;
-	tbnz		w4, #31, .Lcfb_tail8;
+.Lcfb_dec_loop_8x:
+	sub		w4, w4, #8
+	tbnz		w4, #31, .Lcfb_dec_4x
 
-	ld1		{v1.16b, v2.16b, v3.16b}, [x2], #48;
-	ld1		{v4.16b-v7.16b}, [x2];
+	ld1		{v0.16b-v3.16b}, [x2], #64
+	ld1		{v4.16b-v7.16b}, [x2], #64
 
-	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
+	rev32		v8.16b, RIV.16b
+	rev32		v9.16b, v0.16b
+	rev32		v10.16b, v1.16b
+	rev32		v11.16b, v2.16b
+	rev32		v12.16b, v3.16b
+	rev32		v13.16b, v4.16b
+	rev32		v14.16b, v5.16b
+	rev32		v15.16b, v6.16b
 
-	sub		x2, x2, #48;
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v0.16b, v0.16b, RTMP0.16b;
-	eor		v1.16b, v1.16b, RTMP1.16b;
-	eor		v2.16b, v2.16b, RTMP2.16b;
-	eor		v3.16b, v3.16b, RTMP3.16b;
-	st1		{v0.16b-v3.16b}, [x1], #64;
+	SM4_CRYPT_BLK8_BE(v8, v9, v10, v11, v12, v13, v14, v15)
 
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v4.16b, v4.16b, RTMP0.16b;
-	eor		v5.16b, v5.16b, RTMP1.16b;
-	eor		v6.16b, v6.16b, RTMP2.16b;
-	eor		v7.16b, v7.16b, RTMP3.16b;
-	st1		{v4.16b-v7.16b}, [x1], #64;
+	mov		RIV.16b, v7.16b
 
-	mov		v0.16b, RTMP3.16b;
+	eor		v0.16b, v0.16b, v8.16b
+	eor		v1.16b, v1.16b, v9.16b
+	eor		v2.16b, v2.16b, v10.16b
+	eor		v3.16b, v3.16b, v11.16b
+	eor		v4.16b, v4.16b, v12.16b
+	eor		v5.16b, v5.16b, v13.16b
+	eor		v6.16b, v6.16b, v14.16b
+	eor		v7.16b, v7.16b, v15.16b
 
-	cbz		w4, .Lcfb_end;
-	b		.Lcfb_loop_blk;
+	st1		{v0.16b-v3.16b}, [x1], #64
+	st1		{v4.16b-v7.16b}, [x1], #64
 
-.Lcfb_tail8:
-	add		w4, w4, #8;
-	cmp		w4, #4;
-	blt		.Lcfb_tail4;
+	cbz		w4, .Lcfb_dec_end
+	b		.Lcfb_dec_loop_8x
 
-	sub		w4, w4, #4;
+.Lcfb_dec_4x:
+	add		w4, w4, #8
+	cmp		w4, #4
+	blt		.Lcfb_dec_loop_1x
 
-	ld1		{v1.16b, v2.16b, v3.16b}, [x2];
+	sub		w4, w4, #4
 
-	SM4_CRYPT_BLK4(v0, v1, v2, v3);
+	ld1		{v0.16b-v3.16b}, [x2], #64
 
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v0.16b, v0.16b, RTMP0.16b;
-	eor		v1.16b, v1.16b, RTMP1.16b;
-	eor		v2.16b, v2.16b, RTMP2.16b;
-	eor		v3.16b, v3.16b, RTMP3.16b;
-	st1		{v0.16b-v3.16b}, [x1], #64;
+	rev32		v8.16b, RIV.16b
+	rev32		v9.16b, v0.16b
+	rev32		v10.16b, v1.16b
+	rev32		v11.16b, v2.16b
 
-	mov		v0.16b, RTMP3.16b;
+	SM4_CRYPT_BLK4_BE(v8, v9, v10, v11)
 
-	cbz		w4, .Lcfb_end;
+	mov		RIV.16b, v3.16b
 
-.Lcfb_tail4:
-	sub		w4, w4, #1;
+	eor		v0.16b, v0.16b, v8.16b
+	eor		v1.16b, v1.16b, v9.16b
+	eor		v2.16b, v2.16b, v10.16b
+	eor		v3.16b, v3.16b, v11.16b
 
-	SM4_CRYPT_BLK(v0);
+	st1		{v0.16b-v3.16b}, [x1], #64
 
-	ld1		{RTMP0.16b}, [x2], #16;
-	eor		v0.16b, v0.16b, RTMP0.16b;
-	st1		{v0.16b}, [x1], #16;
+	cbz		w4, .Lcfb_dec_end
+
+.Lcfb_dec_loop_1x:
+	sub		w4, w4, #1
+
+	ld1		{v0.16b}, [x2], #16
 
-	mov		v0.16b, RTMP0.16b;
+	SM4_CRYPT_BLK(RIV)
 
-	cbnz		w4, .Lcfb_tail4;
+	eor		RIV.16b, RIV.16b, v0.16b
+	st1		{RIV.16b}, [x1], #16
 
-.Lcfb_end:
+	mov		RIV.16b, v0.16b
+
+	cbnz		w4, .Lcfb_dec_loop_1x
+
+.Lcfb_dec_end:
 	/* store new IV */
-	st1		{v0.16b}, [x3];
+	st1		{RIV.16b}, [x3]
 
-	ret;
+	ret
 SYM_FUNC_END(sm4_ce_cfb_dec)
 
 .align 3
@@ -566,95 +482,99 @@ SYM_FUNC_START(sm4_ce_ctr_enc)
 	 *   x3: ctr (big endian, 128 bit)
 	 *   w4: nblocks
 	 */
-	PREPARE;
+	SM4_PREPARE(x0)
 
-	ldp		x7, x8, [x3];
-	rev		x7, x7;
-	rev		x8, x8;
+	ldp		x7, x8, [x3]
+	rev		x7, x7
+	rev		x8, x8
 
-.Lctr_loop_blk:
-	sub		w4, w4, #8;
-	tbnz		w4, #31, .Lctr_tail8;
+.Lctr_loop_8x:
+	sub		w4, w4, #8
+	tbnz		w4, #31, .Lctr_4x
 
-#define inc_le128(vctr)                     \
-	mov		vctr.d[1], x8;      \
-	mov		vctr.d[0], x7;      \
-	adds		x8, x8, #1;         \
-	adc		x7, x7, xzr;        \
-	rev64		vctr.16b, vctr.16b;
+#define inc_le128(vctr)					\
+		mov		vctr.d[1], x8;		\
+		mov		vctr.d[0], x7;		\
+		adds		x8, x8, #1;		\
+		rev64		vctr.16b, vctr.16b;	\
+		adc		x7, x7, xzr;
 
 	/* construct CTRs */
-	inc_le128(v0);			/* +0 */
-	inc_le128(v1);			/* +1 */
-	inc_le128(v2);			/* +2 */
-	inc_le128(v3);			/* +3 */
-	inc_le128(v4);			/* +4 */
-	inc_le128(v5);			/* +5 */
-	inc_le128(v6);			/* +6 */
-	inc_le128(v7);			/* +7 */
+	inc_le128(v0)			/* +0 */
+	inc_le128(v1)			/* +1 */
+	inc_le128(v2)			/* +2 */
+	inc_le128(v3)			/* +3 */
+	inc_le128(v4)			/* +4 */
+	inc_le128(v5)			/* +5 */
+	inc_le128(v6)			/* +6 */
+	inc_le128(v7)			/* +7 */
+
+	ld1		{v8.16b-v11.16b}, [x2], #64
+	ld1		{v12.16b-v15.16b}, [x2], #64
+
+	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7)
+
+	eor		v0.16b, v0.16b, v8.16b
+	eor		v1.16b, v1.16b, v9.16b
+	eor		v2.16b, v2.16b, v10.16b
+	eor		v3.16b, v3.16b, v11.16b
+	eor		v4.16b, v4.16b, v12.16b
+	eor		v5.16b, v5.16b, v13.16b
+	eor		v6.16b, v6.16b, v14.16b
+	eor		v7.16b, v7.16b, v15.16b
+
+	st1		{v0.16b-v3.16b}, [x1], #64
+	st1		{v4.16b-v7.16b}, [x1], #64
+
+	cbz		w4, .Lctr_end
+	b		.Lctr_loop_8x
+
+.Lctr_4x:
+	add		w4, w4, #8
+	cmp		w4, #4
+	blt		.Lctr_loop_1x
+
+	sub		w4, w4, #4
 
-	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
-
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v0.16b, v0.16b, RTMP0.16b;
-	eor		v1.16b, v1.16b, RTMP1.16b;
-	eor		v2.16b, v2.16b, RTMP2.16b;
-	eor		v3.16b, v3.16b, RTMP3.16b;
-	st1		{v0.16b-v3.16b}, [x1], #64;
+	/* construct CTRs */
+	inc_le128(v0)			/* +0 */
+	inc_le128(v1)			/* +1 */
+	inc_le128(v2)			/* +2 */
+	inc_le128(v3)			/* +3 */
 
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v4.16b, v4.16b, RTMP0.16b;
-	eor		v5.16b, v5.16b, RTMP1.16b;
-	eor		v6.16b, v6.16b, RTMP2.16b;
-	eor		v7.16b, v7.16b, RTMP3.16b;
-	st1		{v4.16b-v7.16b}, [x1], #64;
+	ld1		{v8.16b-v11.16b}, [x2], #64
 
-	cbz		w4, .Lctr_end;
-	b		.Lctr_loop_blk;
+	SM4_CRYPT_BLK4(v0, v1, v2, v3)
 
-.Lctr_tail8:
-	add		w4, w4, #8;
-	cmp		w4, #4;
-	blt		.Lctr_tail4;
+	eor		v0.16b, v0.16b, v8.16b
+	eor		v1.16b, v1.16b, v9.16b
+	eor		v2.16b, v2.16b, v10.16b
+	eor		v3.16b, v3.16b, v11.16b
 
-	sub		w4, w4, #4;
+	st1		{v0.16b-v3.16b}, [x1], #64
 
-	/* construct CTRs */
-	inc_le128(v0);			/* +0 */
-	inc_le128(v1);			/* +1 */
-	inc_le128(v2);			/* +2 */
-	inc_le128(v3);			/* +3 */
+	cbz		w4, .Lctr_end
 
-	SM4_CRYPT_BLK4(v0, v1, v2, v3);
-
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v0.16b, v0.16b, RTMP0.16b;
-	eor		v1.16b, v1.16b, RTMP1.16b;
-	eor		v2.16b, v2.16b, RTMP2.16b;
-	eor		v3.16b, v3.16b, RTMP3.16b;
-	st1		{v0.16b-v3.16b}, [x1], #64;
-
-	cbz		w4, .Lctr_end;
-
-.Lctr_tail4:
-	sub		w4, w4, #1;
+.Lctr_loop_1x:
+	sub		w4, w4, #1
 
 	/* construct CTRs */
-	inc_le128(v0);
+	inc_le128(v0)
 
-	SM4_CRYPT_BLK(v0);
+	ld1		{v8.16b}, [x2], #16
 
-	ld1		{RTMP0.16b}, [x2], #16;
-	eor		v0.16b, v0.16b, RTMP0.16b;
-	st1		{v0.16b}, [x1], #16;
+	SM4_CRYPT_BLK(v0)
+
+	eor		v0.16b, v0.16b, v8.16b
+	st1		{v0.16b}, [x1], #16
 
-	cbnz		w4, .Lctr_tail4;
+	cbnz		w4, .Lctr_loop_1x
 
 .Lctr_end:
 	/* store new CTR */
-	rev		x7, x7;
-	rev		x8, x8;
-	stp		x7, x8, [x3];
+	rev		x7, x7
+	rev		x8, x8
+	stp		x7, x8, [x3]
 
-	ret;
+	ret
 SYM_FUNC_END(sm4_ce_ctr_enc)
diff --git a/arch/arm64/crypto/sm4-ce-glue.c b/arch/arm64/crypto/sm4-ce-glue.c
index 496d55c0d01a..e56e81b1f35f 100644
--- a/arch/arm64/crypto/sm4-ce-glue.c
+++ b/arch/arm64/crypto/sm4-ce-glue.c
@@ -26,9 +26,9 @@ asmlinkage void sm4_ce_crypt_block(const u32 *rkey, u8 *dst, const u8 *src);
 asmlinkage void sm4_ce_crypt(const u32 *rkey, u8 *dst, const u8 *src,
 			     unsigned int nblks);
 asmlinkage void sm4_ce_cbc_enc(const u32 *rkey, u8 *dst, const u8 *src,
-			       u8 *iv, unsigned int nblks);
+			       u8 *iv, unsigned int nblocks);
 asmlinkage void sm4_ce_cbc_dec(const u32 *rkey, u8 *dst, const u8 *src,
-			       u8 *iv, unsigned int nblks);
+			       u8 *iv, unsigned int nblocks);
 asmlinkage void sm4_ce_cfb_enc(const u32 *rkey, u8 *dst, const u8 *src,
 			       u8 *iv, unsigned int nblks);
 asmlinkage void sm4_ce_cfb_dec(const u32 *rkey, u8 *dst, const u8 *src,
@@ -94,66 +94,56 @@ static int sm4_ecb_decrypt(struct skcipher_request *req)
 	return sm4_ecb_do_crypt(req, ctx->rkey_dec);
 }
 
-static int sm4_cbc_encrypt(struct skcipher_request *req)
+static int sm4_cbc_crypt(struct skcipher_request *req,
+			 struct sm4_ctx *ctx, bool encrypt)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct skcipher_walk walk;
 	unsigned int nbytes;
 	int err;
 
 	err = skcipher_walk_virt(&walk, req, false);
+	if (err)
+		return err;
 
 	while ((nbytes = walk.nbytes) > 0) {
 		const u8 *src = walk.src.virt.addr;
 		u8 *dst = walk.dst.virt.addr;
-		unsigned int nblks;
+		unsigned int nblocks;
 
-		kernel_neon_begin();
+		nblocks = nbytes / SM4_BLOCK_SIZE;
+		if (nblocks) {
+			kernel_neon_begin();
 
-		nblks = BYTES2BLKS(nbytes);
-		if (nblks) {
-			sm4_ce_cbc_enc(ctx->rkey_enc, dst, src, walk.iv, nblks);
-			nbytes -= nblks * SM4_BLOCK_SIZE;
-		}
+			if (encrypt)
+				sm4_ce_cbc_enc(ctx->rkey_enc, dst, src,
+					       walk.iv, nblocks);
+			else
+				sm4_ce_cbc_dec(ctx->rkey_dec, dst, src,
+					       walk.iv, nblocks);
 
-		kernel_neon_end();
+			kernel_neon_end();
+		}
 
-		err = skcipher_walk_done(&walk, nbytes);
+		err = skcipher_walk_done(&walk, nbytes % SM4_BLOCK_SIZE);
 	}
 
 	return err;
 }
 
-static int sm4_cbc_decrypt(struct skcipher_request *req)
+static int sm4_cbc_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct skcipher_walk walk;
-	unsigned int nbytes;
-	int err;
-
-	err = skcipher_walk_virt(&walk, req, false);
 
-	while ((nbytes = walk.nbytes) > 0) {
-		const u8 *src = walk.src.virt.addr;
-		u8 *dst = walk.dst.virt.addr;
-		unsigned int nblks;
-
-		kernel_neon_begin();
-
-		nblks = BYTES2BLKS(nbytes);
-		if (nblks) {
-			sm4_ce_cbc_dec(ctx->rkey_dec, dst, src, walk.iv, nblks);
-			nbytes -= nblks * SM4_BLOCK_SIZE;
-		}
-
-		kernel_neon_end();
+	return sm4_cbc_crypt(req, ctx, true);
+}
 
-		err = skcipher_walk_done(&walk, nbytes);
-	}
+static int sm4_cbc_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	return err;
+	return sm4_cbc_crypt(req, ctx, false);
 }
 
 static int sm4_cfb_encrypt(struct skcipher_request *req)
-- 
2.24.3 (Apple Git-128)

