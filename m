Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473C1640327
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiLBJVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiLBJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:21:15 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887E3BD89A;
        Fri,  2 Dec 2022 01:21:10 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p12E3-003Aoj-Cn; Fri, 02 Dec 2022 17:20:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 17:20:55 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 02 Dec 2022 17:20:55 +0800
Subject: [PATCH 5/10] crypto: hisilicon/hpre - Set DMA alignment explicitly
References: <Y4nDL50nToBbi4DS@gondor.apana.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1p12E3-003Aoj-Cn@formenos.hmeau.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver has been implicitly relying on kmalloc alignment
to be sufficient for DMA.  This may no longer be the case with
upcoming arm64 changes.

This patch changes it to explicitly request DMA alignment from
the Crypto API.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/hisilicon/hpre/hpre_crypto.c |   40 +++++++++++++++++-----------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 5f6d363c9435..8ede77310dc5 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -147,6 +147,16 @@ struct hpre_asym_request {
 	struct timespec64 req_time;
 };
 
+static inline unsigned int hpre_align_sz(void)
+{
+	return ((crypto_dma_align() - 1) | (HPRE_ALIGN_SZ - 1)) + 1;
+}
+
+static inline unsigned int hpre_align_pd(void)
+{
+	return (hpre_align_sz() - 1) & ~(crypto_tfm_ctx_alignment() - 1);
+}
+
 static int hpre_alloc_req_id(struct hpre_ctx *ctx)
 {
 	unsigned long flags;
@@ -517,7 +527,7 @@ static int hpre_msg_request_set(struct hpre_ctx *ctx, void *req, bool is_rsa)
 		}
 
 		tmp = akcipher_request_ctx(akreq);
-		h_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+		h_req = PTR_ALIGN(tmp, hpre_align_sz());
 		h_req->cb = hpre_rsa_cb;
 		h_req->areq.rsa = akreq;
 		msg = &h_req->req;
@@ -531,7 +541,7 @@ static int hpre_msg_request_set(struct hpre_ctx *ctx, void *req, bool is_rsa)
 		}
 
 		tmp = kpp_request_ctx(kreq);
-		h_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+		h_req = PTR_ALIGN(tmp, hpre_align_sz());
 		h_req->cb = hpre_dh_cb;
 		h_req->areq.dh = kreq;
 		msg = &h_req->req;
@@ -582,7 +592,7 @@ static int hpre_dh_compute_value(struct kpp_request *req)
 	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
 	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
 	void *tmp = kpp_request_ctx(req);
-	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, hpre_align_sz());
 	struct hpre_sqe *msg = &hpre_req->req;
 	int ret;
 
@@ -740,7 +750,7 @@ static int hpre_dh_init_tfm(struct crypto_kpp *tfm)
 {
 	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
 
-	kpp_set_reqsize(tfm, sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ);
+	kpp_set_reqsize(tfm, sizeof(struct hpre_asym_request) + hpre_align_pd());
 
 	return hpre_ctx_init(ctx, HPRE_V2_ALG_TYPE);
 }
@@ -785,7 +795,7 @@ static int hpre_rsa_enc(struct akcipher_request *req)
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct hpre_ctx *ctx = akcipher_tfm_ctx(tfm);
 	void *tmp = akcipher_request_ctx(req);
-	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, hpre_align_sz());
 	struct hpre_sqe *msg = &hpre_req->req;
 	int ret;
 
@@ -833,7 +843,7 @@ static int hpre_rsa_dec(struct akcipher_request *req)
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct hpre_ctx *ctx = akcipher_tfm_ctx(tfm);
 	void *tmp = akcipher_request_ctx(req);
-	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, hpre_align_sz());
 	struct hpre_sqe *msg = &hpre_req->req;
 	int ret;
 
@@ -1168,7 +1178,7 @@ static int hpre_rsa_init_tfm(struct crypto_akcipher *tfm)
 	}
 
 	akcipher_set_reqsize(tfm, sizeof(struct hpre_asym_request) +
-				  HPRE_ALIGN_SZ);
+				  hpre_align_pd());
 
 	ret = hpre_ctx_init(ctx, HPRE_V2_ALG_TYPE);
 	if (ret)
@@ -1490,7 +1500,7 @@ static int hpre_ecdh_msg_request_set(struct hpre_ctx *ctx,
 	}
 
 	tmp = kpp_request_ctx(req);
-	h_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+	h_req = PTR_ALIGN(tmp, hpre_align_sz());
 	h_req->cb = hpre_ecdh_cb;
 	h_req->areq.ecdh = req;
 	msg = &h_req->req;
@@ -1571,7 +1581,7 @@ static int hpre_ecdh_compute_value(struct kpp_request *req)
 	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
 	struct device *dev = ctx->dev;
 	void *tmp = kpp_request_ctx(req);
-	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, hpre_align_sz());
 	struct hpre_sqe *msg = &hpre_req->req;
 	int ret;
 
@@ -1622,7 +1632,7 @@ static int hpre_ecdh_nist_p192_init_tfm(struct crypto_kpp *tfm)
 
 	ctx->curve_id = ECC_CURVE_NIST_P192;
 
-	kpp_set_reqsize(tfm, sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ);
+	kpp_set_reqsize(tfm, sizeof(struct hpre_asym_request) + hpre_align_pd());
 
 	return hpre_ctx_init(ctx, HPRE_V3_ECC_ALG_TYPE);
 }
@@ -1633,7 +1643,7 @@ static int hpre_ecdh_nist_p256_init_tfm(struct crypto_kpp *tfm)
 
 	ctx->curve_id = ECC_CURVE_NIST_P256;
 
-	kpp_set_reqsize(tfm, sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ);
+	kpp_set_reqsize(tfm, sizeof(struct hpre_asym_request) + hpre_align_pd());
 
 	return hpre_ctx_init(ctx, HPRE_V3_ECC_ALG_TYPE);
 }
@@ -1644,7 +1654,7 @@ static int hpre_ecdh_nist_p384_init_tfm(struct crypto_kpp *tfm)
 
 	ctx->curve_id = ECC_CURVE_NIST_P384;
 
-	kpp_set_reqsize(tfm, sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ);
+	kpp_set_reqsize(tfm, sizeof(struct hpre_asym_request) + hpre_align_pd());
 
 	return hpre_ctx_init(ctx, HPRE_V3_ECC_ALG_TYPE);
 }
@@ -1802,7 +1812,7 @@ static int hpre_curve25519_msg_request_set(struct hpre_ctx *ctx,
 	}
 
 	tmp = kpp_request_ctx(req);
-	h_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+	h_req = PTR_ALIGN(tmp, hpre_align_sz());
 	h_req->cb = hpre_curve25519_cb;
 	h_req->areq.curve25519 = req;
 	msg = &h_req->req;
@@ -1923,7 +1933,7 @@ static int hpre_curve25519_compute_value(struct kpp_request *req)
 	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
 	struct device *dev = ctx->dev;
 	void *tmp = kpp_request_ctx(req);
-	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, hpre_align_sz());
 	struct hpre_sqe *msg = &hpre_req->req;
 	int ret;
 
@@ -1972,7 +1982,7 @@ static int hpre_curve25519_init_tfm(struct crypto_kpp *tfm)
 {
 	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
 
-	kpp_set_reqsize(tfm, sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ);
+	kpp_set_reqsize(tfm, sizeof(struct hpre_asym_request) + hpre_align_pd());
 
 	return hpre_ctx_init(ctx, HPRE_V3_ECC_ALG_TYPE);
 }
