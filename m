Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DE55B34B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiIIJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIIJ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:58:21 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC3712B37E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:58:18 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id s17-20020a056402521100b004511c8d59e3so449596edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=D6OG8U2ohhx6yvxRPlrU4RT77Zc+3Pmhd2b2KcPfT9w=;
        b=spZi2W4U/Rx+sTAsHn53CdqexM1clzV0ZHlZptJcpDDwp0KWal+DUcEHgRsDUwRam6
         ATPzdiKsSAM2QrCTFeMI1kbXjVuY+gRlNIV/Y5pRusnWt+ze+ghyGWaw5JNiOJQdmD1x
         VlvgoRCtpUd7TSVHO4wXsqpN6XdCoXWdsKvTmk4GhVw00DAWlub10ZVyVG10FntDWxEP
         tnyo8oAVYlcCvFD7Vv69z4dS+JgwJHpUg2RtsIrgyP2XRf08bjVu/9lG0d/7gJn6y1Av
         FkCrhzMBIPuYrDtLgFCzxL+wh/2AYPtd1IqJh49J3CZGmAbNvdleee8vB2Q8oucKbpHW
         7e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=D6OG8U2ohhx6yvxRPlrU4RT77Zc+3Pmhd2b2KcPfT9w=;
        b=r9Lp6MvIeEGJ2zccAGLgBl5ebCR3btUCxNezwFzGeWdbN8awc8Pvai2OERoPtI+Yax
         89gI0gNPhMdvNHw/kSE2ZfLu/kN5JDraMoYXttXWvGHkntRoIfrnxeHNSGhkPTUz3dr+
         BhgGbRnVNolJPLkKQJ83Odo6oJcEQImvpyjqJjtkLZYaJg9U89pUQpOubx2+kQ4lho7O
         jjA5xMzmoWKJ7KPHgwTxAka3kghLozEzymnm6iotJ7OmX5lpVtMEI9DRCoUJSzDQH0yp
         lSbkBSW0xwTusrdosiYptjPKf67guobB4fVKVmI4VbV/TjMs9y6ulE+dVuNjJN5BD/PY
         9Lgg==
X-Gm-Message-State: ACgBeo0RXL5N1aD+efEj3ulyeLhP4Xe0rRKKtdc48k77fI/XOLd+P20+
        EK9Ptd/2eSmeHOAmEup/CygwuxDbKzU=
X-Google-Smtp-Source: AA6agR5xUE32vDAhEEeGFXTiC3m3EpIsxNHrqIOoevdf2nuCsw9gz5fezE9V3Mg4YaFhFbtiJGeY/5vXOpE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:eaa4:a143:fbdd:a2d1])
 (user=glider job=sendgmr) by 2002:a05:6402:524b:b0:448:6824:8788 with SMTP id
 t11-20020a056402524b00b0044868248788mr11090103edd.227.1662717496935; Fri, 09
 Sep 2022 02:58:16 -0700 (PDT)
Date:   Fri,  9 Sep 2022 11:58:10 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220909095811.2166073-1-glider@google.com>
Subject: [PATCH -next 1/2] x86: crypto: kmsan: revert !KMSAN dependencies
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Robert Elliott <elliott@hpe.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reverts "crypto: Kconfig: fix up for "crypto: kmsan: disable
accelerated configs under KMSAN" used by Stephen Rothwell to cleanly
merge KMSAN patches into linux-next.

Because now arch-specific crypto configs reside in a separate Kconfig
file, we can disable them all by adding a single !KMSAN before including
that file (done in the following patch).

Among others, this patch reverts !KMSAN check for
CONFIG_CRYPTO_AEGIS128_SIMD, which is ARM-only and is hence unnecessary,
because KMSAN does not support ARM yet.

Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Robert Elliott <elliott@hpe.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org
---
 arch/x86/crypto/Kconfig | 29 -----------------------------
 crypto/Kconfig          |  1 -
 2 files changed, 30 deletions(-)

diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 856f5d8ca65f5..9bb0f7939c6bc 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -5,7 +5,6 @@ menu "Accelerated Cryptographic Algorithms for CPU (x86)"
 config CRYPTO_CURVE25519_X86
 	tristate "Public key crypto: Curve25519 (ADX)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
 	help
@@ -17,7 +16,6 @@ config CRYPTO_CURVE25519_X86
 config CRYPTO_AES_NI_INTEL
 	tristate "Ciphers: AES, modes: ECB, CBC, CTS, CTR, XTR, XTS, GCM (AES-NI)"
 	depends on X86
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_AEAD
 	select CRYPTO_LIB_AES
 	select CRYPTO_ALGAPI
@@ -34,7 +32,6 @@ config CRYPTO_AES_NI_INTEL
 config CRYPTO_BLOWFISH_X86_64
 	tristate "Ciphers: Blowfish, modes: ECB, CBC"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_BLOWFISH_COMMON
 	imply CRYPTO_CTR
@@ -47,7 +44,6 @@ config CRYPTO_BLOWFISH_X86_64
 config CRYPTO_CAMELLIA_X86_64
 	tristate "Ciphers: Camellia with modes: ECB, CBC"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	imply CRYPTO_CTR
 	help
@@ -59,7 +55,6 @@ config CRYPTO_CAMELLIA_X86_64
 config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	tristate "Ciphers: Camellia with modes: ECB, CBC (AES-NI/AVX)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAMELLIA_X86_64
 	select CRYPTO_SIMD
@@ -74,7 +69,6 @@ config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
 	tristate "Ciphers: Camellia with modes: ECB, CBC (AES-NI/AVX2)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	help
 	  Length-preserving ciphers: Camellia with ECB and CBC modes
@@ -86,7 +80,6 @@ config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
 config CRYPTO_CAST5_AVX_X86_64
 	tristate "Ciphers: CAST5 with modes: ECB, CBC (AVX)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST5
 	select CRYPTO_CAST_COMMON
@@ -104,7 +97,6 @@ config CRYPTO_CAST5_AVX_X86_64
 config CRYPTO_CAST6_AVX_X86_64
 	tristate "Ciphers: CAST6 with modes: ECB, CBC (AVX)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST6
 	select CRYPTO_CAST_COMMON
@@ -123,7 +115,6 @@ config CRYPTO_CAST6_AVX_X86_64
 config CRYPTO_DES3_EDE_X86_64
 	tristate "Ciphers: Triple DES EDE with modes: ECB, CBC"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_DES
 	imply CRYPTO_CTR
@@ -138,7 +129,6 @@ config CRYPTO_DES3_EDE_X86_64
 config CRYPTO_SERPENT_SSE2_X86_64
 	tristate "Ciphers: Serpent with modes: ECB, CBC (SSE2)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
@@ -155,7 +145,6 @@ config CRYPTO_SERPENT_SSE2_X86_64
 config CRYPTO_SERPENT_SSE2_586
 	tristate "Ciphers: Serpent with modes: ECB, CBC (32-bit with SSE2)"
 	depends on X86 && !64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
@@ -172,7 +161,6 @@ config CRYPTO_SERPENT_SSE2_586
 config CRYPTO_SERPENT_AVX_X86_64
 	tristate "Ciphers: Serpent with modes: ECB, CBC (AVX)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
@@ -190,7 +178,6 @@ config CRYPTO_SERPENT_AVX_X86_64
 config CRYPTO_SERPENT_AVX2_X86_64
 	tristate "Ciphers: Serpent with modes: ECB, CBC (AVX2)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SERPENT_AVX_X86_64
 	help
 	  Length-preserving ciphers: Serpent cipher algorithm
@@ -258,7 +245,6 @@ config CRYPTO_TWOFISH_586
 config CRYPTO_TWOFISH_X86_64
 	tristate "Ciphers: Twofish"
 	depends on (X86 || UML_X86) && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_ALGAPI
 	select CRYPTO_TWOFISH_COMMON
 	imply CRYPTO_CTR
@@ -270,7 +256,6 @@ config CRYPTO_TWOFISH_X86_64
 config CRYPTO_TWOFISH_X86_64_3WAY
 	tristate "Ciphers: Twofish with modes: ECB, CBC (3-way parallel)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_TWOFISH_COMMON
 	select CRYPTO_TWOFISH_X86_64
@@ -286,7 +271,6 @@ config CRYPTO_TWOFISH_X86_64_3WAY
 config CRYPTO_TWOFISH_AVX_X86_64
 	tristate "Ciphers: Twofish with modes: ECB, CBC (AVX)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
 	select CRYPTO_TWOFISH_COMMON
@@ -305,7 +289,6 @@ config CRYPTO_TWOFISH_AVX_X86_64
 config CRYPTO_CHACHA20_X86_64
 	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (SSSE3/AVX2/AVX-512VL)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
@@ -321,7 +304,6 @@ config CRYPTO_CHACHA20_X86_64
 config CRYPTO_AEGIS128_AESNI_SSE2
 	tristate "AEAD ciphers: AEGIS-128 (AES-NI/SSE2)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_AEAD
 	select CRYPTO_SIMD
 	help
@@ -334,7 +316,6 @@ config CRYPTO_AEGIS128_AESNI_SSE2
 config CRYPTO_NHPOLY1305_SSE2
 	tristate "Hash functions: NHPoly1305 (SSE2)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_NHPOLY1305
 	help
 	  NHPoly1305 hash function for Adiantum
@@ -345,7 +326,6 @@ config CRYPTO_NHPOLY1305_SSE2
 config CRYPTO_NHPOLY1305_AVX2
 	tristate "Hash functions: NHPoly1305 (AVX2)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_NHPOLY1305
 	help
 	  NHPoly1305 hash function for Adiantum
@@ -356,7 +336,6 @@ config CRYPTO_NHPOLY1305_AVX2
 config CRYPTO_BLAKE2S_X86
 	bool "Hash functions: BLAKE2s (SSSE3/AVX-512)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_LIB_BLAKE2S_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
 	help
@@ -379,7 +358,6 @@ config CRYPTO_POLYVAL_CLMUL_NI
 config CRYPTO_POLY1305_X86_64
 	tristate "Hash functions: Poly1305 (SSE2/AVX2)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_LIB_POLY1305_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	help
@@ -392,7 +370,6 @@ config CRYPTO_POLY1305_X86_64
 config CRYPTO_SHA1_SSSE3
 	tristate "Hash functions: SHA-1 (SSSE3/AVX/AVX2/SHA-NI)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
@@ -407,7 +384,6 @@ config CRYPTO_SHA1_SSSE3
 config CRYPTO_SHA256_SSSE3
 	tristate "Hash functions: SHA-224 and SHA-256 (SSSE3/AVX/AVX2/SHA-NI)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
@@ -422,7 +398,6 @@ config CRYPTO_SHA256_SSSE3
 config CRYPTO_SHA512_SSSE3
 	tristate "Hash functions: SHA-384 and SHA-512 (SSSE3/AVX/AVX2)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
@@ -449,7 +424,6 @@ config CRYPTO_SM3_AVX_X86_64
 config CRYPTO_GHASH_CLMUL_NI_INTEL
 	tristate "Hash functions: GHASH (CLMUL-NI)"
 	depends on X86 && 64BIT
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_CRYPTD
 	help
 	  GCM GHASH hash function (NIST SP800-38D)
@@ -460,7 +434,6 @@ config CRYPTO_GHASH_CLMUL_NI_INTEL
 config CRYPTO_CRC32C_INTEL
 	tristate "CRC32c (SSE4.2/PCLMULQDQ)"
 	depends on X86
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_HASH
 	help
 	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
@@ -472,7 +445,6 @@ config CRYPTO_CRC32C_INTEL
 config CRYPTO_CRC32_PCLMUL
 	tristate "CRC32 (PCLMULQDQ)"
 	depends on X86
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_HASH
 	select CRC32
 	help
@@ -484,7 +456,6 @@ config CRYPTO_CRC32_PCLMUL
 config CRYPTO_CRCT10DIF_PCLMUL
 	tristate "CRCT10DIF (PCLMULQDQ)"
 	depends on X86 && 64BIT && CRC_T10DIF
-	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_HASH
 	help
 	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 1dfe0583f302c..40423a14f86f5 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -796,7 +796,6 @@ config CRYPTO_AEGIS128
 config CRYPTO_AEGIS128_SIMD
 	bool "AEGIS-128 (arm NEON, arm64 NEON)"
 	depends on CRYPTO_AEGIS128 && ((ARM || ARM64) && KERNEL_MODE_NEON)
-	depends on !KMSAN # avoid false positives from assembly
 	default y
 	help
 	  AEGIS-128 AEAD algorithm
-- 
2.37.2.789.g6183377224-goog

