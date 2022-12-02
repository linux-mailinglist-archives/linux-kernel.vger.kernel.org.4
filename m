Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21EC640332
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbiLBJWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiLBJV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:21:58 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1924BDCC0;
        Fri,  2 Dec 2022 01:21:20 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p12ED-003AqB-SJ; Fri, 02 Dec 2022 17:21:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 17:21:05 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 02 Dec 2022 17:21:05 +0800
Subject: [PATCH 10/10] crypto: qce - Set DMA alignment explicitly
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
Message-Id: <E1p12ED-003AqB-SJ@formenos.hmeau.com>
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

 drivers/crypto/qce/aead.c   |   22 +++++++++++-----------
 drivers/crypto/qce/common.c |    5 +++--
 drivers/crypto/qce/sha.c    |   18 +++++++++---------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 6eb4d2e35629..7d811728f047 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -24,7 +24,7 @@ static void qce_aead_done(void *data)
 {
 	struct crypto_async_request *async_req = data;
 	struct aead_request *req = aead_request_cast(async_req);
-	struct qce_aead_reqctx *rctx = aead_request_ctx(req);
+	struct qce_aead_reqctx *rctx = aead_request_ctx_dma(req);
 	struct qce_aead_ctx *ctx = crypto_tfm_ctx(async_req->tfm);
 	struct qce_alg_template *tmpl = to_aead_tmpl(crypto_aead_reqtfm(req));
 	struct qce_device *qce = tmpl->qce;
@@ -92,7 +92,7 @@ static void qce_aead_done(void *data)
 static struct scatterlist *
 qce_aead_prepare_result_buf(struct sg_table *tbl, struct aead_request *req)
 {
-	struct qce_aead_reqctx *rctx = aead_request_ctx(req);
+	struct qce_aead_reqctx *rctx = aead_request_ctx_dma(req);
 	struct qce_alg_template *tmpl = to_aead_tmpl(crypto_aead_reqtfm(req));
 	struct qce_device *qce = tmpl->qce;
 
@@ -103,7 +103,7 @@ qce_aead_prepare_result_buf(struct sg_table *tbl, struct aead_request *req)
 static struct scatterlist *
 qce_aead_prepare_ccm_result_buf(struct sg_table *tbl, struct aead_request *req)
 {
-	struct qce_aead_reqctx *rctx = aead_request_ctx(req);
+	struct qce_aead_reqctx *rctx = aead_request_ctx_dma(req);
 
 	sg_init_one(&rctx->result_sg, rctx->ccmresult_buf, QCE_BAM_BURST_SIZE);
 	return qce_sgtable_add(tbl, &rctx->result_sg, QCE_BAM_BURST_SIZE);
@@ -112,7 +112,7 @@ qce_aead_prepare_ccm_result_buf(struct sg_table *tbl, struct aead_request *req)
 static struct scatterlist *
 qce_aead_prepare_dst_buf(struct aead_request *req)
 {
-	struct qce_aead_reqctx *rctx = aead_request_ctx(req);
+	struct qce_aead_reqctx *rctx = aead_request_ctx_dma(req);
 	struct qce_alg_template *tmpl = to_aead_tmpl(crypto_aead_reqtfm(req));
 	struct qce_device *qce = tmpl->qce;
 	struct scatterlist *sg, *msg_sg, __sg[2];
@@ -186,7 +186,7 @@ qce_aead_ccm_prepare_buf_assoclen(struct aead_request *req)
 {
 	struct scatterlist *sg, *msg_sg, __sg[2];
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct qce_aead_reqctx *rctx = aead_request_ctx(req);
+	struct qce_aead_reqctx *rctx = aead_request_ctx_dma(req);
 	struct qce_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	unsigned int assoclen = rctx->assoclen;
 	unsigned int adata_header_len, cryptlen, totallen;
@@ -300,7 +300,7 @@ qce_aead_ccm_prepare_buf_assoclen(struct aead_request *req)
 
 static int qce_aead_prepare_buf(struct aead_request *req)
 {
-	struct qce_aead_reqctx *rctx = aead_request_ctx(req);
+	struct qce_aead_reqctx *rctx = aead_request_ctx_dma(req);
 	struct qce_alg_template *tmpl = to_aead_tmpl(crypto_aead_reqtfm(req));
 	struct qce_device *qce = tmpl->qce;
 	struct scatterlist *sg;
@@ -328,7 +328,7 @@ static int qce_aead_prepare_buf(struct aead_request *req)
 
 static int qce_aead_ccm_prepare_buf(struct aead_request *req)
 {
-	struct qce_aead_reqctx *rctx = aead_request_ctx(req);
+	struct qce_aead_reqctx *rctx = aead_request_ctx_dma(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct qce_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct scatterlist *sg;
@@ -408,7 +408,7 @@ static int
 qce_aead_async_req_handle(struct crypto_async_request *async_req)
 {
 	struct aead_request *req = aead_request_cast(async_req);
-	struct qce_aead_reqctx *rctx = aead_request_ctx(req);
+	struct qce_aead_reqctx *rctx = aead_request_ctx_dma(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct qce_aead_ctx *ctx = crypto_tfm_ctx(async_req->tfm);
 	struct qce_alg_template *tmpl = to_aead_tmpl(crypto_aead_reqtfm(req));
@@ -502,7 +502,7 @@ qce_aead_async_req_handle(struct crypto_async_request *async_req)
 static int qce_aead_crypt(struct aead_request *req, int encrypt)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct qce_aead_reqctx *rctx = aead_request_ctx(req);
+	struct qce_aead_reqctx *rctx = aead_request_ctx_dma(req);
 	struct qce_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct qce_alg_template *tmpl = to_aead_tmpl(tfm);
 	unsigned int blocksize = crypto_aead_blocksize(tfm);
@@ -675,8 +675,8 @@ static int qce_aead_init(struct crypto_aead *tfm)
 	if (IS_ERR(ctx->fallback))
 		return PTR_ERR(ctx->fallback);
 
-	crypto_aead_set_reqsize(tfm, sizeof(struct qce_aead_reqctx) +
-				crypto_aead_reqsize(ctx->fallback));
+	crypto_aead_set_reqsize_dma(tfm, sizeof(struct qce_aead_reqctx) +
+					 crypto_aead_reqsize(ctx->fallback));
 	return 0;
 }
 
diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index 7c612ba5068f..04253a8d3340 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
  */
 
+#include <crypto/internal/hash.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/types.h>
@@ -147,7 +148,7 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 {
 	struct ahash_request *req = ahash_request_cast(async_req);
 	struct crypto_ahash *ahash = __crypto_ahash_cast(async_req->tfm);
-	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
+	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
 	struct qce_alg_template *tmpl = to_ahash_tmpl(async_req->tfm);
 	struct qce_device *qce = tmpl->qce;
 	unsigned int digestsize = crypto_ahash_digestsize(ahash);
@@ -419,7 +420,7 @@ static unsigned int qce_be32_to_cpu_array(u32 *dst, const u8 *src, unsigned int
 static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 {
 	struct aead_request *req = aead_request_cast(async_req);
-	struct qce_aead_reqctx *rctx = aead_request_ctx(req);
+	struct qce_aead_reqctx *rctx = aead_request_ctx_dma(req);
 	struct qce_aead_ctx *ctx = crypto_tfm_ctx(async_req->tfm);
 	struct qce_alg_template *tmpl = to_aead_tmpl(crypto_aead_reqtfm(req));
 	struct qce_device *qce = tmpl->qce;
diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 37bafd7aeb79..fc72af8aa9a7 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -38,7 +38,7 @@ static void qce_ahash_done(void *data)
 	struct crypto_async_request *async_req = data;
 	struct ahash_request *req = ahash_request_cast(async_req);
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
+	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
 	struct qce_alg_template *tmpl = to_ahash_tmpl(async_req->tfm);
 	struct qce_device *qce = tmpl->qce;
 	struct qce_result_dump *result = qce->dma.result_buf;
@@ -75,7 +75,7 @@ static void qce_ahash_done(void *data)
 static int qce_ahash_async_req_handle(struct crypto_async_request *async_req)
 {
 	struct ahash_request *req = ahash_request_cast(async_req);
-	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
+	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
 	struct qce_sha_ctx *ctx = crypto_tfm_ctx(async_req->tfm);
 	struct qce_alg_template *tmpl = to_ahash_tmpl(async_req->tfm);
 	struct qce_device *qce = tmpl->qce;
@@ -132,7 +132,7 @@ static int qce_ahash_async_req_handle(struct crypto_async_request *async_req)
 
 static int qce_ahash_init(struct ahash_request *req)
 {
-	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
+	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
 	struct qce_alg_template *tmpl = to_ahash_tmpl(req->base.tfm);
 	const u32 *std_iv = tmpl->std_iv;
 
@@ -147,7 +147,7 @@ static int qce_ahash_init(struct ahash_request *req)
 
 static int qce_ahash_export(struct ahash_request *req, void *out)
 {
-	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
+	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
 	struct qce_sha_saved_state *export_state = out;
 
 	memcpy(export_state->pending_buf, rctx->buf, rctx->buflen);
@@ -164,7 +164,7 @@ static int qce_ahash_export(struct ahash_request *req, void *out)
 
 static int qce_ahash_import(struct ahash_request *req, const void *in)
 {
-	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
+	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
 	const struct qce_sha_saved_state *import_state = in;
 
 	memset(rctx, 0, sizeof(*rctx));
@@ -183,7 +183,7 @@ static int qce_ahash_import(struct ahash_request *req, const void *in)
 static int qce_ahash_update(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
+	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
 	struct qce_alg_template *tmpl = to_ahash_tmpl(req->base.tfm);
 	struct qce_device *qce = tmpl->qce;
 	struct scatterlist *sg_last, *sg;
@@ -275,7 +275,7 @@ static int qce_ahash_update(struct ahash_request *req)
 
 static int qce_ahash_final(struct ahash_request *req)
 {
-	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
+	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
 	struct qce_alg_template *tmpl = to_ahash_tmpl(req->base.tfm);
 	struct qce_device *qce = tmpl->qce;
 
@@ -302,7 +302,7 @@ static int qce_ahash_final(struct ahash_request *req)
 
 static int qce_ahash_digest(struct ahash_request *req)
 {
-	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
+	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
 	struct qce_alg_template *tmpl = to_ahash_tmpl(req->base.tfm);
 	struct qce_device *qce = tmpl->qce;
 	int ret;
@@ -395,7 +395,7 @@ static int qce_ahash_cra_init(struct crypto_tfm *tfm)
 	struct crypto_ahash *ahash = __crypto_ahash_cast(tfm);
 	struct qce_sha_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	crypto_ahash_set_reqsize(ahash, sizeof(struct qce_sha_reqctx));
+	crypto_ahash_set_reqsize_dma(ahash, sizeof(struct qce_sha_reqctx));
 	memset(ctx, 0, sizeof(*ctx));
 	return 0;
 }
