Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A3F6A1669
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 06:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBXFwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 00:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBXFwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 00:52:17 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E685E843;
        Thu, 23 Feb 2023 21:52:14 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pVQzn-00F7yJ-3T; Fri, 24 Feb 2023 13:51:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Feb 2023 13:51:51 +0800
Date:   Fri, 24 Feb 2023 13:51:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Subject: [v2 PATCH] crypto: stm32 - Save and restore between each request
Message-ID: <Y/hQdzsKMYgkIfMY@gondor.apana.org.au>
References: <Y/cBB+q0Ono9j2Jy@gondor.apana.org.au>
 <20230224231430.2948-1-kunyu@nfschina.com>
 <Y/cy5wUtk10OahpO@gondor.apana.org.au>
 <CACRpkdYyB=-UnE1bmdVszSSB5ReECZ0fUoWJX6XtYbKHEe52tA@mail.gmail.com>
 <Y/c7iVW67Xhhdu8e@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/c7iVW67Xhhdu8e@gondor.apana.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 fixes potential state clobbering from the disconnect between
hdev->flags and rctx->flags.

---8<---
The Crypto API hashing paradigm requires the hardware state to
be exported between *each* request because multiple unrelated
hashes may be processed concurrently.

The stm32 hardware is capable of producing the hardware hashing
state but it was only doing it in the export function.  This is
not only broken for export as you can't export a kernel pointer
and reimport it, but it also means that concurrent hashing was
fundamentally broken.

Fix this by moving the saving and restoring of hardware hash
state between each and every hashing request.

Fixes: 8a1012d3f2ab ("crypto: stm32 - Support for STM32 HASH module")
Reported-by: Li kunyu <kunyu@nfschina.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index acf8bfc8de4b..523312f47166 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -152,8 +152,8 @@ struct stm32_hash_request_ctx {
 
 	u8 buffer[HASH_BUFLEN] __aligned(sizeof(u32));
 
-	/* Export Context */
-	u32			*hw_context;
+	/* hash state */
+	u32			hw_context[3 + HASH_CSR_REGISTER_NUMBER];
 };
 
 struct stm32_hash_algs_info {
@@ -184,7 +184,6 @@ struct stm32_hash_dev {
 	struct ahash_request	*req;
 	struct crypto_engine	*engine;
 
-	int			err;
 	unsigned long		flags;
 
 	struct dma_chan		*dma_lch;
@@ -442,6 +441,18 @@ static int stm32_hash_update_cpu(struct stm32_hash_dev *hdev)
 			hdev->flags |= HASH_FLAGS_OUTPUT_READY;
 			err = 0;
 		}
+	} else {
+		u32 *preg = rctx->hw_context;
+		int i;
+
+		if (!hdev->pdata->ux500)
+			*preg++ = stm32_hash_read(hdev, HASH_IMR);
+		*preg++ = stm32_hash_read(hdev, HASH_STR);
+		*preg++ = stm32_hash_read(hdev, HASH_CR);
+		for (i = 0; i < HASH_CSR_REGISTER_NUMBER; i++)
+			*preg++ = stm32_hash_read(hdev, HASH_CSR(i));
+
+		rctx->flags |= HASH_FLAGS_INIT;
 	}
 
 	return err;
@@ -884,11 +895,6 @@ static void stm32_hash_finish_req(struct ahash_request *req, int err)
 	if (!err && (HASH_FLAGS_FINAL & hdev->flags)) {
 		stm32_hash_copy_hash(req);
 		err = stm32_hash_finish(req);
-		hdev->flags &= ~(HASH_FLAGS_FINAL | HASH_FLAGS_CPU |
-				 HASH_FLAGS_INIT | HASH_FLAGS_DMA_READY |
-				 HASH_FLAGS_OUTPUT_READY | HASH_FLAGS_HMAC |
-				 HASH_FLAGS_HMAC_INIT | HASH_FLAGS_HMAC_FINAL |
-				 HASH_FLAGS_HMAC_KEY);
 	} else {
 		rctx->flags |= HASH_FLAGS_ERRORS;
 	}
@@ -899,68 +905,58 @@ static void stm32_hash_finish_req(struct ahash_request *req, int err)
 	crypto_finalize_hash_request(hdev->engine, req, err);
 }
 
-static int stm32_hash_hw_init(struct stm32_hash_dev *hdev,
+static void stm32_hash_hw_init(struct stm32_hash_dev *hdev,
 			      struct stm32_hash_request_ctx *rctx)
 {
 	pm_runtime_get_sync(hdev->dev);
-
-	if (!(HASH_FLAGS_INIT & hdev->flags)) {
-		stm32_hash_write(hdev, HASH_CR, HASH_CR_INIT);
-		stm32_hash_write(hdev, HASH_STR, 0);
-		stm32_hash_write(hdev, HASH_DIN, 0);
-		stm32_hash_write(hdev, HASH_IMR, 0);
-		hdev->err = 0;
-	}
-
-	return 0;
 }
 
-static int stm32_hash_one_request(struct crypto_engine *engine, void *areq);
-static int stm32_hash_prepare_req(struct crypto_engine *engine, void *areq);
-
 static int stm32_hash_handle_queue(struct stm32_hash_dev *hdev,
 				   struct ahash_request *req)
 {
 	return crypto_transfer_hash_request_to_engine(hdev->engine, req);
 }
 
-static int stm32_hash_prepare_req(struct crypto_engine *engine, void *areq)
+static int stm32_hash_one_request(struct crypto_engine *engine, void *areq)
 {
 	struct ahash_request *req = container_of(areq, struct ahash_request,
 						 base);
 	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
 	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
 	struct stm32_hash_request_ctx *rctx;
+	int err = 0;
 
 	if (!hdev)
 		return -ENODEV;
 
-	hdev->req = req;
-
-	rctx = ahash_request_ctx(req);
-
 	dev_dbg(hdev->dev, "processing new req, op: %lu, nbytes %d\n",
 		rctx->op, req->nbytes);
 
-	return stm32_hash_hw_init(hdev, rctx);
-}
-
-static int stm32_hash_one_request(struct crypto_engine *engine, void *areq)
-{
-	struct ahash_request *req = container_of(areq, struct ahash_request,
-						 base);
-	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
-	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
-	struct stm32_hash_request_ctx *rctx;
-	int err = 0;
-
-	if (!hdev)
-		return -ENODEV;
+	stm32_hash_hw_init(hdev, rctx);
 
 	hdev->req = req;
+	hdev->flags = 0;
 
 	rctx = ahash_request_ctx(req);
 
+	if (rctx->flags & HASH_FLAGS_INIT) {
+		u32 *preg = rctx->hw_context;
+		u32 reg;
+		int i;
+
+		if (!hdev->pdata->ux500)
+			stm32_hash_write(hdev, HASH_IMR, *preg++);
+		stm32_hash_write(hdev, HASH_STR, *preg++);
+		stm32_hash_write(hdev, HASH_CR, *preg);
+		reg = *preg++ | HASH_CR_INIT;
+		stm32_hash_write(hdev, HASH_CR, reg);
+
+		for (i = 0; i < HASH_CSR_REGISTER_NUMBER; i++)
+			stm32_hash_write(hdev, HASH_CSR(i), *preg++);
+
+		hdev->flags |= HASH_FLAGS_INIT;
+	}
+
 	if (rctx->op == HASH_OP_UPDATE)
 		err = stm32_hash_update_req(hdev);
 	else if (rctx->op == HASH_OP_FINAL)
@@ -1048,33 +1044,6 @@ static int stm32_hash_digest(struct ahash_request *req)
 static int stm32_hash_export(struct ahash_request *req, void *out)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
-	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
-	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
-	u32 *preg;
-	unsigned int i;
-	int ret;
-
-	pm_runtime_get_sync(hdev->dev);
-
-	ret = stm32_hash_wait_busy(hdev);
-	if (ret)
-		return ret;
-
-	rctx->hw_context = kmalloc_array(3 + HASH_CSR_REGISTER_NUMBER,
-					 sizeof(u32),
-					 GFP_KERNEL);
-
-	preg = rctx->hw_context;
-
-	if (!hdev->pdata->ux500)
-		*preg++ = stm32_hash_read(hdev, HASH_IMR);
-	*preg++ = stm32_hash_read(hdev, HASH_STR);
-	*preg++ = stm32_hash_read(hdev, HASH_CR);
-	for (i = 0; i < HASH_CSR_REGISTER_NUMBER; i++)
-		*preg++ = stm32_hash_read(hdev, HASH_CSR(i));
-
-	pm_runtime_mark_last_busy(hdev->dev);
-	pm_runtime_put_autosuspend(hdev->dev);
 
 	memcpy(out, rctx, sizeof(*rctx));
 
@@ -1084,33 +1053,9 @@ static int stm32_hash_export(struct ahash_request *req, void *out)
 static int stm32_hash_import(struct ahash_request *req, const void *in)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
-	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
-	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
-	const u32 *preg = in;
-	u32 reg;
-	unsigned int i;
 
 	memcpy(rctx, in, sizeof(*rctx));
 
-	preg = rctx->hw_context;
-
-	pm_runtime_get_sync(hdev->dev);
-
-	if (!hdev->pdata->ux500)
-		stm32_hash_write(hdev, HASH_IMR, *preg++);
-	stm32_hash_write(hdev, HASH_STR, *preg++);
-	stm32_hash_write(hdev, HASH_CR, *preg);
-	reg = *preg++ | HASH_CR_INIT;
-	stm32_hash_write(hdev, HASH_CR, reg);
-
-	for (i = 0; i < HASH_CSR_REGISTER_NUMBER; i++)
-		stm32_hash_write(hdev, HASH_CSR(i), *preg++);
-
-	pm_runtime_mark_last_busy(hdev->dev);
-	pm_runtime_put_autosuspend(hdev->dev);
-
-	kfree(rctx->hw_context);
-
 	return 0;
 }
 
@@ -1166,8 +1111,6 @@ static int stm32_hash_cra_init_algs(struct crypto_tfm *tfm,
 		ctx->flags |= HASH_FLAGS_HMAC;
 
 	ctx->enginectx.op.do_one_request = stm32_hash_one_request;
-	ctx->enginectx.op.prepare_request = stm32_hash_prepare_req;
-	ctx->enginectx.op.unprepare_request = NULL;
 
 	return stm32_hash_init_fallback(tfm);
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
