Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B42638328
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 05:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKYEgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 23:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYEgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:36:45 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B548C2338F;
        Thu, 24 Nov 2022 20:36:44 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oyQRz-000djH-3a; Fri, 25 Nov 2022 12:36:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Nov 2022 12:36:31 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 25 Nov 2022 12:36:31 +0800
Subject: [v2 PATCH 2/9] crypto: api - Add crypto_tfm_ctx_dma
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
Message-Id: <E1oyQRz-000djH-3a@formenos.hmeau.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the helpers crypto_tfm_ctx_aligned and
crypto_tfm_ctx_dma.  The first aligns the tfm context to the
value cra_alignmask.  The second sets the alignment according
to dma_cache_get_alignment();

This patch also moves crypto_tfm_ctx into algapi.h.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 include/crypto/algapi.h |   41 +++++++++++++++++++++++++++++++++++++++--
 include/linux/crypto.h  |    5 -----
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index f50c5d1725da..4c99eb66e654 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -7,6 +7,7 @@
 #ifndef _CRYPTO_ALGAPI_H
 #define _CRYPTO_ALGAPI_H
 
+#include <asm/cache.h>
 #include <linux/align.h>
 #include <linux/crypto.h>
 #include <linux/kconfig.h>
@@ -25,6 +26,14 @@
 #define MAX_CIPHER_BLOCKSIZE		16
 #define MAX_CIPHER_ALIGNMASK		15
 
+#ifdef ARCH_DMA_MINALIGN
+#define CRYPTO_DMA_ALIGN ARCH_DMA_MINALIGN
+#else
+#define CRYPTO_DMA_ALIGN CRYPTO_MINALIGN
+#endif
+
+#define CRYPTO_DMA_PADDING ((CRYPTO_DMA_ALIGN - 1) & ~(CRYPTO_MINALIGN - 1))
+
 struct crypto_aead;
 struct crypto_instance;
 struct module;
@@ -189,10 +198,38 @@ static inline void crypto_xor_cpy(u8 *dst, const u8 *src1, const u8 *src2,
 	}
 }
 
+static inline void *crypto_tfm_ctx(struct crypto_tfm *tfm)
+{
+	return tfm->__crt_ctx;
+}
+
+static inline void *crypto_tfm_ctx_align(struct crypto_tfm *tfm,
+					 unsigned int align)
+{
+	if (align <= crypto_tfm_ctx_alignment())
+		align = 1;
+
+	return PTR_ALIGN(crypto_tfm_ctx(tfm), align);
+}
+
 static inline void *crypto_tfm_ctx_aligned(struct crypto_tfm *tfm)
 {
-	return PTR_ALIGN(crypto_tfm_ctx(tfm),
-			 crypto_tfm_alg_alignmask(tfm) + 1);
+	return crypto_tfm_ctx_align(tfm, crypto_tfm_alg_alignmask(tfm) + 1);
+}
+
+static inline unsigned int crypto_dma_align(void)
+{
+	return CRYPTO_DMA_ALIGN;
+}
+
+static inline unsigned int crypto_dma_padding(void)
+{
+	return (crypto_dma_align() - 1) & ~(crypto_tfm_ctx_alignment() - 1);
+}
+
+static inline void *crypto_tfm_ctx_dma(struct crypto_tfm *tfm)
+{
+	return crypto_tfm_ctx_align(tfm, crypto_dma_align());
 }
 
 static inline struct crypto_instance *crypto_tfm_alg_instance(
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 2324ab6f1846..5d1e961f810e 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -714,11 +714,6 @@ static inline void crypto_tfm_clear_flags(struct crypto_tfm *tfm, u32 flags)
 	tfm->crt_flags &= ~flags;
 }
 
-static inline void *crypto_tfm_ctx(struct crypto_tfm *tfm)
-{
-	return tfm->__crt_ctx;
-}
-
 static inline unsigned int crypto_tfm_ctx_alignment(void)
 {
 	struct crypto_tfm *tfm;
