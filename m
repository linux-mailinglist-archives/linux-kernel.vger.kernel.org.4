Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E845A64032A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiLBJWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiLBJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:21:17 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1D8BDCE2;
        Fri,  2 Dec 2022 01:21:14 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p12E7-003ApG-IG; Fri, 02 Dec 2022 17:21:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 17:20:59 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 02 Dec 2022 17:20:59 +0800
Subject: [PATCH 7/10] crypto: keembay - Set DMA alignment explicitly
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
Message-Id: <E1p12E7-003ApG-IG@formenos.hmeau.com>
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

 drivers/crypto/keembay/keembay-ocs-hcu-core.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/keembay/keembay-ocs-hcu-core.c b/drivers/crypto/keembay/keembay-ocs-hcu-core.c
index 0379dbf32a4c..d4bcbed1f546 100644
--- a/drivers/crypto/keembay/keembay-ocs-hcu-core.c
+++ b/drivers/crypto/keembay/keembay-ocs-hcu-core.c
@@ -226,7 +226,7 @@ static void kmb_ocs_hcu_dma_cleanup(struct ahash_request *req,
  */
 static int kmb_ocs_dma_prepare(struct ahash_request *req)
 {
-	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx_dma(req);
 	struct device *dev = rctx->hcu_dev->dev;
 	unsigned int remainder = 0;
 	unsigned int total;
@@ -356,7 +356,7 @@ static int kmb_ocs_dma_prepare(struct ahash_request *req)
 
 static void kmb_ocs_hcu_secure_cleanup(struct ahash_request *req)
 {
-	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx_dma(req);
 
 	/* Clear buffer of any data. */
 	memzero_explicit(rctx->buffer, sizeof(rctx->buffer));
@@ -374,7 +374,7 @@ static int kmb_ocs_hcu_handle_queue(struct ahash_request *req)
 
 static int prepare_ipad(struct ahash_request *req)
 {
-	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct ocs_hcu_ctx *ctx = crypto_ahash_ctx(tfm);
 	int i;
@@ -414,7 +414,7 @@ static int kmb_ocs_hcu_do_one_request(struct crypto_engine *engine, void *areq)
 						 base);
 	struct ocs_hcu_dev *hcu_dev = kmb_ocs_hcu_find_dev(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx_dma(req);
 	struct ocs_hcu_ctx *tctx = crypto_ahash_ctx(tfm);
 	int rc;
 	int i;
@@ -561,7 +561,7 @@ static int kmb_ocs_hcu_do_one_request(struct crypto_engine *engine, void *areq)
 static int kmb_ocs_hcu_init(struct ahash_request *req)
 {
 	struct ocs_hcu_dev *hcu_dev = kmb_ocs_hcu_find_dev(req);
-	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct ocs_hcu_ctx *ctx = crypto_ahash_ctx(tfm);
 
@@ -614,7 +614,7 @@ static int kmb_ocs_hcu_init(struct ahash_request *req)
 
 static int kmb_ocs_hcu_update(struct ahash_request *req)
 {
-	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx_dma(req);
 	int rc;
 
 	if (!req->nbytes)
@@ -650,7 +650,7 @@ static int kmb_ocs_hcu_update(struct ahash_request *req)
 /* Common logic for kmb_ocs_hcu_final() and kmb_ocs_hcu_finup(). */
 static int kmb_ocs_hcu_fin_common(struct ahash_request *req)
 {
-	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct ocs_hcu_ctx *ctx = crypto_ahash_ctx(tfm);
 	int rc;
@@ -687,7 +687,7 @@ static int kmb_ocs_hcu_fin_common(struct ahash_request *req)
 
 static int kmb_ocs_hcu_final(struct ahash_request *req)
 {
-	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx_dma(req);
 
 	rctx->sg_data_total = 0;
 	rctx->sg_data_offset = 0;
@@ -698,7 +698,7 @@ static int kmb_ocs_hcu_final(struct ahash_request *req)
 
 static int kmb_ocs_hcu_finup(struct ahash_request *req)
 {
-	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx_dma(req);
 
 	rctx->sg_data_total = req->nbytes;
 	rctx->sg_data_offset = 0;
@@ -726,7 +726,7 @@ static int kmb_ocs_hcu_digest(struct ahash_request *req)
 
 static int kmb_ocs_hcu_export(struct ahash_request *req, void *out)
 {
-	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx_dma(req);
 
 	/* Intermediate data is always stored and applied per request. */
 	memcpy(out, rctx, sizeof(*rctx));
@@ -736,7 +736,7 @@ static int kmb_ocs_hcu_export(struct ahash_request *req, void *out)
 
 static int kmb_ocs_hcu_import(struct ahash_request *req, const void *in)
 {
-	struct ocs_hcu_rctx *rctx = ahash_request_ctx(req);
+	struct ocs_hcu_rctx *rctx = ahash_request_ctx_dma(req);
 
 	/* Intermediate data is always stored and applied per request. */
 	memcpy(rctx, in, sizeof(*rctx));
@@ -822,8 +822,8 @@ static int kmb_ocs_hcu_setkey(struct crypto_ahash *tfm, const u8 *key,
 /* Set request size and initialize tfm context. */
 static void __cra_init(struct crypto_tfm *tfm, struct ocs_hcu_ctx *ctx)
 {
-	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
-				 sizeof(struct ocs_hcu_rctx));
+	crypto_ahash_set_reqsize_dma(__crypto_ahash_cast(tfm),
+				     sizeof(struct ocs_hcu_rctx));
 
 	/* Init context to 0. */
 	memzero_explicit(ctx, sizeof(*ctx));
