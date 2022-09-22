Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5392A5E6334
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiIVNJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiIVNIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:08:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09688EBBE5;
        Thu, 22 Sep 2022 06:08:43 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYFrv2j1kzpT57;
        Thu, 22 Sep 2022 21:05:51 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:08:39 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:08:34 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>,
        <ardb@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
        <anshuman.khandual@arm.com>, <chenzhongjin@huawei.com>
Subject: [PATCH -next 3/3] arm64: crypto: Mark constant as data
Date:   Thu, 22 Sep 2022 21:04:52 +0800
Message-ID: <20220922130452.233323-4-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922130452.233323-1-chenzhongjin@huawei.com>
References: <20220922130452.233323-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SYM_DATA_* macros to annotate data bytes in the middle of .text
sections.

For local symbols, ".L" prefix needs to be dropped as the assembler
may exclude the symbols from the .o symbol table.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/crypto/aes-neonbs-core.S | 14 +++++++-------
 arch/arm64/crypto/poly1305-armv8.pl |  4 ++++
 arch/arm64/crypto/polyval-ce-core.S |  7 +++----
 arch/arm64/crypto/sha512-armv8.pl   | 24 ++++++++++++++----------
 4 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/crypto/aes-neonbs-core.S b/arch/arm64/crypto/aes-neonbs-core.S
index d427f4556b6e..fa161d1bf264 100644
--- a/arch/arm64/crypto/aes-neonbs-core.S
+++ b/arch/arm64/crypto/aes-neonbs-core.S
@@ -367,15 +367,15 @@
 
 
 	.align		6
-M0:	.octa		0x0004080c0105090d02060a0e03070b0f
+SYM_DATA_LOCAL(M0,	.octa		0x0004080c0105090d02060a0e03070b0f)
 
-M0SR:	.octa		0x0004080c05090d010a0e02060f03070b
-SR:	.octa		0x0f0e0d0c0a09080b0504070600030201
-SRM0:	.octa		0x01060b0c0207080d0304090e00050a0f
+SYM_DATA_LOCAL(M0SR,	.octa		0x0004080c05090d010a0e02060f03070b)
+SYM_DATA_LOCAL(SR,	.octa		0x0f0e0d0c0a09080b0504070600030201)
+SYM_DATA_LOCAL(SRM0,	.octa		0x01060b0c0207080d0304090e00050a0f)
 
-M0ISR:	.octa		0x0004080c0d0105090a0e0206070b0f03
-ISR:	.octa		0x0f0e0d0c080b0a090504070602010003
-ISRM0:	.octa		0x0306090c00070a0d01040b0e0205080f
+SYM_DATA_LOCAL(M0ISR,	.octa		0x0004080c0d0105090a0e0206070b0f03)
+SYM_DATA_LOCAL(ISR,	.octa		0x0f0e0d0c080b0a090504070602010003)
+SYM_DATA_LOCAL(ISRM0,	.octa		0x0306090c00070a0d01040b0e0205080f)
 
 	/*
 	 * void aesbs_convert_key(u8 out[], u32 const rk[], int rounds)
diff --git a/arch/arm64/crypto/poly1305-armv8.pl b/arch/arm64/crypto/poly1305-armv8.pl
index cbc980fb02e3..f460f33c127a 100644
--- a/arch/arm64/crypto/poly1305-armv8.pl
+++ b/arch/arm64/crypto/poly1305-armv8.pl
@@ -47,6 +47,8 @@ my ($mac,$nonce)=($inp,$len);
 my ($h0,$h1,$h2,$r0,$r1,$s1,$t0,$t1,$d0,$d1,$d2) = map("x$_",(4..14));
 
 $code.=<<___;
+#include <linux/linkage.h>
+
 #ifndef __KERNEL__
 # include "arm_arch.h"
 .extern	OPENSSL_armcap_P
@@ -888,8 +890,10 @@ poly1305_blocks_neon:
 .align	5
 .Lzeros:
 .long	0,0,0,0,0,0,0,0
+SYM_DATA_START_LOCAL(POLY1305_str)
 .asciz	"Poly1305 for ARMv8, CRYPTOGAMS by \@dot-asm"
 .align	2
+SYM_DATA_END(POLY1305_str)
 #if !defined(__KERNEL__) && !defined(_WIN64)
 .comm	OPENSSL_armcap_P,4,4
 .hidden	OPENSSL_armcap_P
diff --git a/arch/arm64/crypto/polyval-ce-core.S b/arch/arm64/crypto/polyval-ce-core.S
index b5326540d2e3..9026a787b0de 100644
--- a/arch/arm64/crypto/polyval-ce-core.S
+++ b/arch/arm64/crypto/polyval-ce-core.S
@@ -65,8 +65,7 @@ GSTAR	.req	v24
 	.arch	armv8-a+crypto
 	.align	4
 
-.Lgstar:
-	.quad	0xc200000000000000, 0xc200000000000000
+SYM_DATA_LOCAL(gstar, .quad	0xc200000000000000, 0xc200000000000000)
 
 /*
  * Computes the product of two 128-bit polynomials in X and Y and XORs the
@@ -309,7 +308,7 @@ GSTAR	.req	v24
  * void pmull_polyval_mul(u8 *op1, const u8 *op2);
  */
 SYM_FUNC_START(pmull_polyval_mul)
-	adr	TMP, .Lgstar
+	adr	TMP, gstar
 	ld1	{GSTAR.2d}, [TMP]
 	ld1	{v0.16b}, [x0]
 	ld1	{v1.16b}, [x1]
@@ -334,7 +333,7 @@ SYM_FUNC_END(pmull_polyval_mul)
  *			     size_t nblocks, u8 *accumulator);
  */
 SYM_FUNC_START(pmull_polyval_update)
-	adr	TMP, .Lgstar
+	adr	TMP, gstar
 	mov	KEY_START, KEY_POWERS
 	ld1	{GSTAR.2d}, [TMP]
 	ld1	{SUM.16b}, [ACCUMULATOR]
diff --git a/arch/arm64/crypto/sha512-armv8.pl b/arch/arm64/crypto/sha512-armv8.pl
index 35ec9ae99fe1..1882c4110026 100644
--- a/arch/arm64/crypto/sha512-armv8.pl
+++ b/arch/arm64/crypto/sha512-armv8.pl
@@ -193,6 +193,8 @@ ___
 }
 
 $code.=<<___;
+#include <linux/linkage.h>
+
 #ifndef	__KERNEL__
 # include "arm_arch.h"
 #endif
@@ -208,11 +210,11 @@ ___
 $code.=<<___	if ($SZ==4);
 #ifndef	__KERNEL__
 # ifdef	__ILP32__
-	ldrsw	x16,.LOPENSSL_armcap_P
+	ldrsw	x16,OPENSSL_armcap_P_rel
 # else
-	ldr	x16,.LOPENSSL_armcap_P
+	ldr	x16,OPENSSL_armcap_P_rel
 # endif
-	adr	x17,.LOPENSSL_armcap_P
+	adr	x17,OPENSSL_armcap_P_rel
 	add	x16,x16,x17
 	ldr	w16,[x16]
 	tst	w16,#ARMV8_SHA256
@@ -237,7 +239,7 @@ $code.=<<___;
 	ldp	$E,$F,[$ctx,#4*$SZ]
 	add	$num,$inp,$num,lsl#`log(16*$SZ)/log(2)`	// end of input
 	ldp	$G,$H,[$ctx,#6*$SZ]
-	adr	$Ktbl,.LK$BITS
+	adr	$Ktbl,K$BITS
 	stp	$ctx,$num,[x29,#96]
 
 .Loop:
@@ -287,8 +289,7 @@ $code.=<<___;
 .size	$func,.-$func
 
 .align	6
-.type	.LK$BITS,%object
-.LK$BITS:
+SYM_DATA_START_LOCAL(K$BITS)
 ___
 $code.=<<___ if ($SZ==8);
 	.quad	0x428a2f98d728ae22,0x7137449123ef65cd
@@ -353,18 +354,21 @@ $code.=<<___ if ($SZ==4);
 	.long	0	//terminator
 ___
 $code.=<<___;
-.size	.LK$BITS,.-.LK$BITS
+SYM_DATA_END(K$BITS)
 #ifndef	__KERNEL__
 .align	3
-.LOPENSSL_armcap_P:
+SYM_DATA_START_LOCAL(OPENSSL_armcap_P_rel)
 # ifdef	__ILP32__
 	.long	OPENSSL_armcap_P-.
 # else
 	.quad	OPENSSL_armcap_P-.
 # endif
+SYM_DATA_END(OPENSSL_armcap_P_rel)
 #endif
+SYM_DATA_START_LOCAL(OPENSSL_str)
 .asciz	"SHA$BITS block transform for ARMv8, CRYPTOGAMS by <appro\@openssl.org>"
 .align	2
+SYM_DATA_END(OPENSSL_str)
 ___
 
 if ($SZ==4) {
@@ -385,7 +389,7 @@ sha256_block_armv8:
 	add		x29,sp,#0
 
 	ld1.32		{$ABCD,$EFGH},[$ctx]
-	adr		$Ktbl,.LK256
+	adr		$Ktbl,K256
 
 .Loop_hw:
 	ld1		{@MSG[0]-@MSG[3]},[$inp],#64
@@ -648,7 +652,7 @@ sha256_block_neon:
 	mov	x29, sp
 	sub	sp,sp,#16*4
 
-	adr	$Ktbl,.LK256
+	adr	$Ktbl,K256
 	add	$num,$inp,$num,lsl#6	// len to point at the end of inp
 
 	ld1.8	{@X[0]},[$inp], #16
-- 
2.17.1

