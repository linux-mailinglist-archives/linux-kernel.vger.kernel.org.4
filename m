Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB3463832A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 05:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKYEgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 23:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYEgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:36:45 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E43D2338D;
        Thu, 24 Nov 2022 20:36:44 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oyQRw-000dj8-W3; Fri, 25 Nov 2022 12:36:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Nov 2022 12:36:28 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 25 Nov 2022 12:36:28 +0800
Subject: [v2 PATCH 1/9] crypto: Prepare to move crypto_tfm_ctx
References: <Y4BGC2BPesy3qsEm@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1oyQRw-000dj8-W3@formenos.hmeau.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper crypto_tfm_ctx is only used by the Crypto API algorithm
code and should really be in algapi.h.  However, for historical
reasons many files relied on it to be in crypto.h.  This patch
changes those files to use algapi.h instead in prepartion for a
move.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 arch/arm/crypto/aes-cipher-glue.c      |    2 +-
 arch/arm64/crypto/aes-ce-glue.c        |    2 +-
 arch/arm64/crypto/aes-cipher-glue.c    |    2 +-
 arch/arm64/crypto/sm4-ce-cipher-glue.c |    2 +-
 arch/x86/crypto/twofish_glue.c         |    2 +-
 crypto/aes_generic.c                   |    2 +-
 crypto/aes_ti.c                        |    2 +-
 crypto/anubis.c                        |    2 +-
 crypto/blowfish_common.c               |    3 ++-
 crypto/blowfish_generic.c              |    3 ++-
 crypto/camellia_generic.c              |    2 +-
 crypto/cast5_generic.c                 |    2 +-
 crypto/cast6_generic.c                 |    2 +-
 crypto/des_generic.c                   |    2 +-
 crypto/fcrypt.c                        |    2 +-
 crypto/khazad.c                        |    2 +-
 crypto/seed.c                          |    2 +-
 crypto/serpent_generic.c               |    2 +-
 crypto/sm4_generic.c                   |    2 +-
 crypto/tea.c                           |    2 +-
 crypto/twofish_common.c                |    2 +-
 crypto/twofish_generic.c               |    2 +-
 drivers/crypto/nx/nx-842.h             |    2 +-
 include/crypto/aria.h                  |    2 +-
 include/crypto/internal/acompress.h    |    2 ++
 include/crypto/internal/scompress.h    |    3 ++-
 26 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/arm/crypto/aes-cipher-glue.c b/arch/arm/crypto/aes-cipher-glue.c
index 8cd00f56800e..6dfaef2d8f91 100644
--- a/arch/arm/crypto/aes-cipher-glue.c
+++ b/arch/arm/crypto/aes-cipher-glue.c
@@ -7,7 +7,7 @@
  */
 
 #include <crypto/aes.h>
-#include <linux/crypto.h>
+#include <crypto/algapi.h>
 #include <linux/module.h>
 
 asmlinkage void __aes_arm_encrypt(u32 *rk, int rounds, const u8 *in, u8 *out);
diff --git a/arch/arm64/crypto/aes-ce-glue.c b/arch/arm64/crypto/aes-ce-glue.c
index 56a5f6f0b0c1..e921823ca103 100644
--- a/arch/arm64/crypto/aes-ce-glue.c
+++ b/arch/arm64/crypto/aes-ce-glue.c
@@ -9,9 +9,9 @@
 #include <asm/simd.h>
 #include <asm/unaligned.h>
 #include <crypto/aes.h>
+#include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <linux/cpufeature.h>
-#include <linux/crypto.h>
 #include <linux/module.h>
 
 #include "aes-ce-setkey.h"
diff --git a/arch/arm64/crypto/aes-cipher-glue.c b/arch/arm64/crypto/aes-cipher-glue.c
index 8caf6dfefce8..4ec55e568941 100644
--- a/arch/arm64/crypto/aes-cipher-glue.c
+++ b/arch/arm64/crypto/aes-cipher-glue.c
@@ -6,7 +6,7 @@
  */
 
 #include <crypto/aes.h>
-#include <linux/crypto.h>
+#include <crypto/algapi.h>
 #include <linux/module.h>
 
 asmlinkage void __aes_arm64_encrypt(u32 *rk, u8 *out, const u8 *in, int rounds);
diff --git a/arch/arm64/crypto/sm4-ce-cipher-glue.c b/arch/arm64/crypto/sm4-ce-cipher-glue.c
index 76a34ef4abbb..c31d76fb5a17 100644
--- a/arch/arm64/crypto/sm4-ce-cipher-glue.c
+++ b/arch/arm64/crypto/sm4-ce-cipher-glue.c
@@ -2,11 +2,11 @@
 
 #include <asm/neon.h>
 #include <asm/simd.h>
+#include <crypto/algapi.h>
 #include <crypto/sm4.h>
 #include <crypto/internal/simd.h>
 #include <linux/module.h>
 #include <linux/cpufeature.h>
-#include <linux/crypto.h>
 #include <linux/types.h>
 
 MODULE_ALIAS_CRYPTO("sm4");
diff --git a/arch/x86/crypto/twofish_glue.c b/arch/x86/crypto/twofish_glue.c
index f9c4adc27404..0614beece279 100644
--- a/arch/x86/crypto/twofish_glue.c
+++ b/arch/x86/crypto/twofish_glue.c
@@ -38,8 +38,8 @@
  * Third Edition.
  */
 
+#include <crypto/algapi.h>
 #include <crypto/twofish.h>
-#include <linux/crypto.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
diff --git a/crypto/aes_generic.c b/crypto/aes_generic.c
index 27ab27931813..666474b81c6a 100644
--- a/crypto/aes_generic.c
+++ b/crypto/aes_generic.c
@@ -48,11 +48,11 @@
  */
 
 #include <crypto/aes.h>
+#include <crypto/algapi.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/errno.h>
-#include <linux/crypto.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
diff --git a/crypto/aes_ti.c b/crypto/aes_ti.c
index 205c2c257d49..a3b342f92fab 100644
--- a/crypto/aes_ti.c
+++ b/crypto/aes_ti.c
@@ -6,7 +6,7 @@
  */
 
 #include <crypto/aes.h>
-#include <linux/crypto.h>
+#include <crypto/algapi.h>
 #include <linux/module.h>
 
 static int aesti_set_key(struct crypto_tfm *tfm, const u8 *in_key,
diff --git a/crypto/anubis.c b/crypto/anubis.c
index 5da0241ef453..9f0cf61bbc6e 100644
--- a/crypto/anubis.c
+++ b/crypto/anubis.c
@@ -29,11 +29,11 @@
  *
  */
 
+#include <crypto/algapi.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <asm/byteorder.h>
-#include <linux/crypto.h>
 #include <linux/types.h>
 
 #define ANUBIS_MIN_KEY_SIZE	16
diff --git a/crypto/blowfish_common.c b/crypto/blowfish_common.c
index 1c072012baff..c0208ce269a3 100644
--- a/crypto/blowfish_common.c
+++ b/crypto/blowfish_common.c
@@ -14,11 +14,12 @@
  * Copyright (c) Kyle McMartin <kyle@debian.org>
  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
  */
+
+#include <crypto/algapi.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <asm/byteorder.h>
-#include <linux/crypto.h>
 #include <linux/types.h>
 #include <crypto/blowfish.h>
 
diff --git a/crypto/blowfish_generic.c b/crypto/blowfish_generic.c
index 003b52c6880e..0e74c7242e77 100644
--- a/crypto/blowfish_generic.c
+++ b/crypto/blowfish_generic.c
@@ -11,11 +11,12 @@
  * Copyright (c) Kyle McMartin <kyle@debian.org>
  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
  */
+
+#include <crypto/algapi.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <asm/unaligned.h>
-#include <linux/crypto.h>
 #include <linux/types.h>
 #include <crypto/blowfish.h>
 
diff --git a/crypto/camellia_generic.c b/crypto/camellia_generic.c
index fd1a88af9e77..c04670cf51ac 100644
--- a/crypto/camellia_generic.c
+++ b/crypto/camellia_generic.c
@@ -9,7 +9,7 @@
  *  https://info.isl.ntt.co.jp/crypt/eng/camellia/specifications.html
  */
 
-#include <linux/crypto.h>
+#include <crypto/algapi.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/crypto/cast5_generic.c b/crypto/cast5_generic.c
index 0257c14cefc2..085a1eedae03 100644
--- a/crypto/cast5_generic.c
+++ b/crypto/cast5_generic.c
@@ -14,8 +14,8 @@
 
 
 #include <asm/unaligned.h>
+#include <crypto/algapi.h>
 #include <linux/init.h>
-#include <linux/crypto.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/string.h>
diff --git a/crypto/cast6_generic.c b/crypto/cast6_generic.c
index 75346380aa0b..34f1ab53e3a7 100644
--- a/crypto/cast6_generic.c
+++ b/crypto/cast6_generic.c
@@ -11,8 +11,8 @@
 
 
 #include <asm/unaligned.h>
+#include <crypto/algapi.h>
 #include <linux/init.h>
-#include <linux/crypto.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/string.h>
diff --git a/crypto/des_generic.c b/crypto/des_generic.c
index c85354a5e94c..1274e18d3eb9 100644
--- a/crypto/des_generic.c
+++ b/crypto/des_generic.c
@@ -8,11 +8,11 @@
  */
 
 #include <asm/byteorder.h>
+#include <crypto/algapi.h>
 #include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/errno.h>
-#include <linux/crypto.h>
 
 #include <crypto/internal/des.h>
 
diff --git a/crypto/fcrypt.c b/crypto/fcrypt.c
index 76a04d000c0d..95a16e88899b 100644
--- a/crypto/fcrypt.c
+++ b/crypto/fcrypt.c
@@ -43,10 +43,10 @@
  */
 
 #include <asm/byteorder.h>
+#include <crypto/algapi.h>
 #include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/crypto.h>
 
 #define ROUNDS 16
 
diff --git a/crypto/khazad.c b/crypto/khazad.c
index f19339954c89..70cafe73f974 100644
--- a/crypto/khazad.c
+++ b/crypto/khazad.c
@@ -19,11 +19,11 @@
  *
  */
 
+#include <crypto/algapi.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <asm/byteorder.h>
-#include <linux/crypto.h>
 #include <linux/types.h>
 
 #define KHAZAD_KEY_SIZE		16
diff --git a/crypto/seed.c b/crypto/seed.c
index 27720140820e..d0506ade2a5f 100644
--- a/crypto/seed.c
+++ b/crypto/seed.c
@@ -8,11 +8,11 @@
  * Copyright (C) 2007 Korea Information Security Agency (KISA).
  */
 
+#include <crypto/algapi.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/errno.h>
-#include <linux/crypto.h>
 #include <asm/byteorder.h>
 
 #define SEED_NUM_KCONSTANTS	16
diff --git a/crypto/serpent_generic.c b/crypto/serpent_generic.c
index 45f98b750053..c6bca47931e2 100644
--- a/crypto/serpent_generic.c
+++ b/crypto/serpent_generic.c
@@ -7,11 +7,11 @@
  * Copyright (C) 2002 Dag Arne Osvik <osvik@ii.uib.no>
  */
 
+#include <crypto/algapi.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <asm/unaligned.h>
-#include <linux/crypto.h>
 #include <linux/types.h>
 #include <crypto/serpent.h>
 
diff --git a/crypto/sm4_generic.c b/crypto/sm4_generic.c
index 4a6480a27fee..560eba37dc55 100644
--- a/crypto/sm4_generic.c
+++ b/crypto/sm4_generic.c
@@ -7,12 +7,12 @@
  * All rights reserved.
  */
 
+#include <crypto/algapi.h>
 #include <crypto/sm4.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/errno.h>
-#include <linux/crypto.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
diff --git a/crypto/tea.c b/crypto/tea.c
index 02efc5d81690..896f863f3067 100644
--- a/crypto/tea.c
+++ b/crypto/tea.c
@@ -14,11 +14,11 @@
  * Copyright (c) 2004 Aaron Grothe ajgrothe@yahoo.com
  */
 
+#include <crypto/algapi.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <asm/byteorder.h>
-#include <linux/crypto.h>
 #include <linux/types.h>
 
 #define TEA_KEY_SIZE		16
diff --git a/crypto/twofish_common.c b/crypto/twofish_common.c
index f921f30334f4..bf4f28742f77 100644
--- a/crypto/twofish_common.c
+++ b/crypto/twofish_common.c
@@ -25,9 +25,9 @@
  * Third Edition.
  */
 
+#include <crypto/algapi.h>
 #include <crypto/twofish.h>
 #include <linux/bitops.h>
-#include <linux/crypto.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/crypto/twofish_generic.c b/crypto/twofish_generic.c
index 86b2f067a416..557915e4062d 100644
--- a/crypto/twofish_generic.c
+++ b/crypto/twofish_generic.c
@@ -25,12 +25,12 @@
  */
 
 #include <asm/unaligned.h>
+#include <crypto/algapi.h>
 #include <crypto/twofish.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/errno.h>
-#include <linux/crypto.h>
 #include <linux/bitops.h>
 
 /* Macros to compute the g() function in the encryption and decryption
diff --git a/drivers/crypto/nx/nx-842.h b/drivers/crypto/nx/nx-842.h
index b66f19ac600f..7590bfb24d79 100644
--- a/drivers/crypto/nx/nx-842.h
+++ b/drivers/crypto/nx/nx-842.h
@@ -3,10 +3,10 @@
 #ifndef __NX_842_H__
 #define __NX_842_H__
 
+#include <crypto/algapi.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/crypto.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/io.h>
diff --git a/include/crypto/aria.h b/include/crypto/aria.h
index 254da46cc385..73295146be11 100644
--- a/include/crypto/aria.h
+++ b/include/crypto/aria.h
@@ -18,11 +18,11 @@
 #ifndef _CRYPTO_ARIA_H
 #define _CRYPTO_ARIA_H
 
+#include <crypto/algapi.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/errno.h>
-#include <linux/crypto.h>
 #include <asm/byteorder.h>
 
 #define ARIA_MIN_KEY_SIZE	16
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index cfc47e18820f..49339003bd2c 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -8,7 +8,9 @@
  */
 #ifndef _CRYPTO_ACOMP_INT_H
 #define _CRYPTO_ACOMP_INT_H
+
 #include <crypto/acompress.h>
+#include <crypto/algapi.h>
 
 /*
  * Transform internal helpers.
diff --git a/include/crypto/internal/scompress.h b/include/crypto/internal/scompress.h
index f834274c2493..252cc949d4ee 100644
--- a/include/crypto/internal/scompress.h
+++ b/include/crypto/internal/scompress.h
@@ -8,7 +8,8 @@
  */
 #ifndef _CRYPTO_SCOMP_INT_H
 #define _CRYPTO_SCOMP_INT_H
-#include <linux/crypto.h>
+
+#include <crypto/algapi.h>
 
 #define SCOMP_SCRATCH_SIZE	131072
 
