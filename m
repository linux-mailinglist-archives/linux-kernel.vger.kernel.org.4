Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39DE63832C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 05:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKYEg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 23:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKYEgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:36:47 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A192338F;
        Thu, 24 Nov 2022 20:36:47 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oyQS1-000djS-65; Fri, 25 Nov 2022 12:36:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Nov 2022 12:36:33 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 25 Nov 2022 12:36:33 +0800
Subject: [v2 PATCH 3/9] crypto: aead - Add ctx helpers with DMA alignment
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
Message-Id: <E1oyQS1-000djS-65@formenos.hmeau.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds helpers to access the aead context structure and
request context structure with an added alignment for DMA access.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 include/crypto/internal/aead.h |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/crypto/internal/aead.h b/include/crypto/internal/aead.h
index d482017f3e20..cd8cb1e921b7 100644
--- a/include/crypto/internal/aead.h
+++ b/include/crypto/internal/aead.h
@@ -39,6 +39,11 @@ static inline void *crypto_aead_ctx(struct crypto_aead *tfm)
 	return crypto_tfm_ctx(&tfm->base);
 }
 
+static inline void *crypto_aead_ctx_dma(struct crypto_aead *tfm)
+{
+	return crypto_tfm_ctx_dma(&tfm->base);
+}
+
 static inline struct crypto_instance *aead_crypto_instance(
 	struct aead_instance *inst)
 {
@@ -65,6 +70,16 @@ static inline void *aead_request_ctx(struct aead_request *req)
 	return req->__ctx;
 }
 
+static inline void *aead_request_ctx_dma(struct aead_request *req)
+{
+	unsigned int align = crypto_dma_align();
+
+	if (align <= crypto_tfm_ctx_alignment())
+		align = 1;
+
+	return PTR_ALIGN(aead_request_ctx(req), align);
+}
+
 static inline void aead_request_complete(struct aead_request *req, int err)
 {
 	req->base.complete(&req->base, err);
@@ -108,6 +123,13 @@ static inline void crypto_aead_set_reqsize(struct crypto_aead *aead,
 	aead->reqsize = reqsize;
 }
 
+static inline void crypto_aead_set_reqsize_dma(struct crypto_aead *aead,
+					       unsigned int reqsize)
+{
+	reqsize += crypto_dma_align() & ~(crypto_tfm_ctx_alignment() - 1);
+	aead->reqsize = reqsize;
+}
+
 static inline void aead_init_queue(struct aead_queue *queue,
 				   unsigned int max_qlen)
 {
