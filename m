Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6BB73838E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjFUMTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjFUMTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:19:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B769D1FD3;
        Wed, 21 Jun 2023 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687349980; x=1718885980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H2On4BkiK842BWT2+FLgDrsxTV7abLUQsx5UxDHkU+U=;
  b=Zvj1qvsC/h5Zl3wZyafQwYYRS71T+F71ToUTCy46KoQi9vMwN54IPG/4
   B9dfPTv0IRM/UycXPcJoZtBEylFFQKvIXlmEFG7Ok8cpEd302QBOaF+yO
   2AWDgPzjbb4vpjVlnb6XfxkCthS9twJ/lLxGGvAJ0QfXaqYjIk0gH4bnb
   FqzUeREMbHxtROFQu3DRRD8KHcOChSU0GU72ulpbtQmEUkE9z8pSvXaEu
   zO20VtJk7Ktm6shuilhjZPxZQ/OWKYiTxw6/N2ZhNTqK13zBSPxvq3owO
   sQXVlhDAq8Kx8Jawd8gmNLNy/cHQ3OFBYCNbeFJkKo4HhfpKQMV0sQL88
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349885595"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="349885595"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 05:19:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="827411431"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="827411431"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2023 05:19:38 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, chang.seok.bae@intel.com
Subject: [PATCH] crypto: x86/aesni: Align the address before aes_set_key_common()
Date:   Wed, 21 Jun 2023 05:06:53 -0700
Message-Id: <20230621120653.121759-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f1093780-cdda-35ec-3ef1-e5fab4139bef@intel.com>
References: <f1093780-cdda-35ec-3ef1-e5fab4139bef@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aes_set_key_common() performs runtime alignment to the void *raw_ctx
pointer. This facilitates consistent access to the 16byte-aligned
address during key extension.

However, the alignment is already handlded in the GCM-related setkey
functions before invoking the common function. Consequently, the
alignment in the common function is unnecessary for those functions.

To establish a consistent approach throughout the glue code, remove
the aes_ctx() call from its current location. Instead, place it at
each call site where the runtime alignment is currently absent.

Link: https://lore.kernel.org/lkml/20230605024623.GA4653@quark.localdomain/
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
The need for this fix was discovered during Eric's review of the Key
Locker series [1]. Considering the upstream code also requires this
improvement, this is applicable regardless of the Key Locker enabling
[2].

[1] https://lore.kernel.org/lkml/20230605024623.GA4653@quark.localdomain/
[2] https://lore.kernel.org/lkml/f1093780-cdda-35ec-3ef1-e5fab4139bef@intel.com/
---
 arch/x86/crypto/aesni-intel_glue.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index a5b0cb3efeba..c4eea7e746e7 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -229,10 +229,10 @@ static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
 	return (struct crypto_aes_ctx *)ALIGN(addr, align);
 }
 
-static int aes_set_key_common(struct crypto_tfm *tfm, void *raw_ctx,
+static int aes_set_key_common(struct crypto_tfm *tfm,
+			      struct crypto_aes_ctx *ctx,
 			      const u8 *in_key, unsigned int key_len)
 {
-	struct crypto_aes_ctx *ctx = aes_ctx(raw_ctx);
 	int err;
 
 	if (key_len != AES_KEYSIZE_128 && key_len != AES_KEYSIZE_192 &&
@@ -253,7 +253,7 @@ static int aes_set_key_common(struct crypto_tfm *tfm, void *raw_ctx,
 static int aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 		       unsigned int key_len)
 {
-	return aes_set_key_common(tfm, crypto_tfm_ctx(tfm), in_key, key_len);
+	return aes_set_key_common(tfm, aes_ctx(crypto_tfm_ctx(tfm)), in_key, key_len);
 }
 
 static void aesni_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
@@ -286,7 +286,7 @@ static int aesni_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			         unsigned int len)
 {
 	return aes_set_key_common(crypto_skcipher_tfm(tfm),
-				  crypto_skcipher_ctx(tfm), key, len);
+				  aes_ctx(crypto_skcipher_ctx(tfm)), key, len);
 }
 
 static int ecb_encrypt(struct skcipher_request *req)
@@ -893,13 +893,13 @@ static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	keylen /= 2;
 
 	/* first half of xts-key is for crypt */
-	err = aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_crypt_ctx,
+	err = aes_set_key_common(crypto_skcipher_tfm(tfm), aes_ctx(ctx->raw_crypt_ctx),
 				 key, keylen);
 	if (err)
 		return err;
 
 	/* second half of xts-key is for tweak */
-	return aes_set_key_common(crypto_skcipher_tfm(tfm), ctx->raw_tweak_ctx,
+	return aes_set_key_common(crypto_skcipher_tfm(tfm), aes_ctx(ctx->raw_tweak_ctx),
 				  key + keylen, keylen);
 }
 
-- 
2.34.1

