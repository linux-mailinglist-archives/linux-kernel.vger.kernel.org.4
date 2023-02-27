Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ACE6A3F95
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjB0KkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjB0KkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:40:07 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A60E20569;
        Mon, 27 Feb 2023 02:40:03 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pWauy-00G0kv-KM; Mon, 27 Feb 2023 18:39:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 27 Feb 2023 18:39:40 +0800
Date:   Mon, 27 Feb 2023 18:39:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Subject: [v3 PATCH] crypto: stm32 - Save and restore between each request
Message-ID: <Y/yIbPBVCPx9K/0s@gondor.apana.org.au>
References: <Y/cBB+q0Ono9j2Jy@gondor.apana.org.au>
 <20230224231430.2948-1-kunyu@nfschina.com>
 <Y/cy5wUtk10OahpO@gondor.apana.org.au>
 <CACRpkdYyB=-UnE1bmdVszSSB5ReECZ0fUoWJX6XtYbKHEe52tA@mail.gmail.com>
 <Y/c7iVW67Xhhdu8e@gondor.apana.org.au>
 <Y/hQdzsKMYgkIfMY@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/hQdzsKMYgkIfMY@gondor.apana.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 moves the exported state into its own structure so that it
doesn't contain unnecessary data.  It also subsumes the "empty
message" patch, as only the stm32_hash_copy_hash hunk was really
needed and it's easiest if we put that here.

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

Also change the emptymsg check in stm32_hash_copy_hash to rely
on whether we have any existing hash state, rather than whether
this particular update request is empty.

Fixes: 8a1012d3f2ab ("crypto: stm32 - Support for STM32 HASH module")
Reported-by: Li kunyu <kunyu@nfschina.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 7bf805563ac2..72806daab600 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -127,6 +127,16 @@ struct stm32_hash_ctx {
 	int			keylen;
 };
 
+struct stm32_hash_state {
+	u16			bufcnt;
+	u16			buflen;
+
+	u8 buffer[HASH_BUFLEN] __aligned(4);
+
+	/* hash state */
+	u32			hw_context[3 + HASH_CSR_REGISTER_NUMBER];
+};
+
 struct stm32_hash_request_ctx {
 	struct stm32_hash_dev	*hdev;
 	unsigned long		flags;
@@ -134,8 +144,6 @@ struct stm32_hash_request_ctx {
 
 	u8 digest[SHA256_DIGEST_SIZE] __aligned(sizeof(u32));
 	size_t			digcnt;
-	size_t			bufcnt;
-	size_t			buflen;
 
 	/* DMA */
 	struct scatterlist	*sg;
@@ -149,10 +157,7 @@ struct stm32_hash_request_ctx {
 
 	u8			data_type;
 
-	u8 buffer[HASH_BUFLEN] __aligned(sizeof(u32));
-
-	/* Export Context */
-	u32			*hw_context;
+	struct stm32_hash_state state;
 };
 
 struct stm32_hash_algs_info {
@@ -183,7 +188,6 @@ struct stm32_hash_dev {
 	struct ahash_request	*req;
 	struct crypto_engine	*engine;
 
-	int			err;
 	unsigned long		flags;
 
 	struct dma_chan		*dma_lch;
@@ -326,11 +330,12 @@ static void stm32_hash_write_ctrl(struct stm32_hash_dev *hdev, int bufcnt)
 
 static void stm32_hash_append_sg(struct stm32_hash_request_ctx *rctx)
 {
+	struct stm32_hash_state *state = &rctx->state;
 	size_t count;
 
-	while ((rctx->bufcnt < rctx->buflen) && rctx->total) {
+	while ((state->bufcnt < state->buflen) && rctx->total) {
 		count = min(rctx->sg->length - rctx->offset, rctx->total);
-		count = min(count, rctx->buflen - rctx->bufcnt);
+		count = min_t(size_t, count, state->buflen - state->bufcnt);
 
 		if (count <= 0) {
 			if ((rctx->sg->length == 0) && !sg_is_last(rctx->sg)) {
@@ -341,10 +346,10 @@ static void stm32_hash_append_sg(struct stm32_hash_request_ctx *rctx)
 			}
 		}
 
-		scatterwalk_map_and_copy(rctx->buffer + rctx->bufcnt, rctx->sg,
-					 rctx->offset, count, 0);
+		scatterwalk_map_and_copy(state->buffer + state->bufcnt,
+					 rctx->sg, rctx->offset, count, 0);
 
-		rctx->bufcnt += count;
+		state->bufcnt += count;
 		rctx->offset += count;
 		rctx->total -= count;
 
@@ -413,26 +418,27 @@ static int stm32_hash_xmit_cpu(struct stm32_hash_dev *hdev,
 static int stm32_hash_update_cpu(struct stm32_hash_dev *hdev)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(hdev->req);
+	struct stm32_hash_state *state = &rctx->state;
 	int bufcnt, err = 0, final;
 
 	dev_dbg(hdev->dev, "%s flags %lx\n", __func__, rctx->flags);
 
 	final = (rctx->flags & HASH_FLAGS_FINUP);
 
-	while ((rctx->total >= rctx->buflen) ||
-	       (rctx->bufcnt + rctx->total >= rctx->buflen)) {
+	while ((rctx->total >= state->buflen) ||
+	       (state->bufcnt + rctx->total >= state->buflen)) {
 		stm32_hash_append_sg(rctx);
-		bufcnt = rctx->bufcnt;
-		rctx->bufcnt = 0;
-		err = stm32_hash_xmit_cpu(hdev, rctx->buffer, bufcnt, 0);
+		bufcnt = state->bufcnt;
+		state->bufcnt = 0;
+		err = stm32_hash_xmit_cpu(hdev, state->buffer, bufcnt, 0);
 	}
 
 	stm32_hash_append_sg(rctx);
 
 	if (final) {
-		bufcnt = rctx->bufcnt;
-		rctx->bufcnt = 0;
-		err = stm32_hash_xmit_cpu(hdev, rctx->buffer, bufcnt, 1);
+		bufcnt = state->bufcnt;
+		state->bufcnt = 0;
+		err = stm32_hash_xmit_cpu(hdev, state->buffer, bufcnt, 1);
 
 		/* If we have an IRQ, wait for that, else poll for completion */
 		if (hdev->polled) {
@@ -441,8 +447,20 @@ static int stm32_hash_update_cpu(struct stm32_hash_dev *hdev)
 			hdev->flags |= HASH_FLAGS_OUTPUT_READY;
 			err = 0;
 		}
+	} else {
+		u32 *preg = state->hw_context;
+		int i;
+
+		if (!hdev->pdata->ux500)
+			*preg++ = stm32_hash_read(hdev, HASH_IMR);
+		*preg++ = stm32_hash_read(hdev, HASH_STR);
+		*preg++ = stm32_hash_read(hdev, HASH_CR);
+		for (i = 0; i < HASH_CSR_REGISTER_NUMBER; i++)
+			*preg++ = stm32_hash_read(hdev, HASH_CSR(i));
 	}
 
+	rctx->flags |= HASH_FLAGS_INIT;
+
 	return err;
 }
 
@@ -584,10 +602,10 @@ static int stm32_hash_dma_init(struct stm32_hash_dev *hdev)
 static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(hdev->req);
+	u32 *buffer = (void *)rctx->state.buffer;
 	struct scatterlist sg[1], *tsg;
 	int err = 0, len = 0, reg, ncp = 0;
 	unsigned int i;
-	u32 *buffer = (void *)rctx->buffer;
 
 	rctx->sg = hdev->req->src;
 	rctx->total = hdev->req->nbytes;
@@ -615,7 +633,7 @@ static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 
 				ncp = sg_pcopy_to_buffer(
 					rctx->sg, rctx->nents,
-					rctx->buffer, sg->length - len,
+					rctx->state.buffer, sg->length - len,
 					rctx->total - sg->length + len);
 
 				sg->length = len;
@@ -671,6 +689,8 @@ static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 		err = stm32_hash_hmac_dma_send(hdev);
 	}
 
+	rctx->flags |= HASH_FLAGS_INIT;
+
 	return err;
 }
 
@@ -749,14 +769,12 @@ static int stm32_hash_init(struct ahash_request *req)
 		return -EINVAL;
 	}
 
-	rctx->bufcnt = 0;
-	rctx->buflen = HASH_BUFLEN;
+	rctx->state.bufcnt = 0;
+	rctx->state.buflen = HASH_BUFLEN;
 	rctx->total = 0;
 	rctx->offset = 0;
 	rctx->data_type = HASH_DATA_8_BITS;
 
-	memset(rctx->buffer, 0, HASH_BUFLEN);
-
 	if (ctx->flags & HASH_FLAGS_HMAC)
 		rctx->flags |= HASH_FLAGS_HMAC;
 
@@ -774,15 +792,16 @@ static int stm32_hash_final_req(struct stm32_hash_dev *hdev)
 {
 	struct ahash_request *req = hdev->req;
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
+	struct stm32_hash_state *state = &rctx->state;
+	int buflen = state->bufcnt;
 	int err;
-	int buflen = rctx->bufcnt;
 
-	rctx->bufcnt = 0;
+	state->bufcnt = 0;
 
 	if (!(rctx->flags & HASH_FLAGS_CPU))
 		err = stm32_hash_dma_send(hdev);
 	else
-		err = stm32_hash_xmit_cpu(hdev, rctx->buffer, buflen, 1);
+		err = stm32_hash_xmit_cpu(hdev, state->buffer, buflen, 1);
 
 	/* If we have an IRQ, wait for that, else poll for completion */
 	if (hdev->polled) {
@@ -832,7 +851,7 @@ static void stm32_hash_copy_hash(struct ahash_request *req)
 	__be32 *hash = (void *)rctx->digest;
 	unsigned int i, hashsize;
 
-	if (hdev->pdata->broken_emptymsg && !req->nbytes)
+	if (hdev->pdata->broken_emptymsg && !(rctx->flags & HASH_FLAGS_INIT))
 		return stm32_hash_emptymsg_fallback(req);
 
 	switch (rctx->flags & HASH_FLAGS_ALGO_MASK) {
@@ -882,11 +901,6 @@ static void stm32_hash_finish_req(struct ahash_request *req, int err)
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
@@ -897,68 +911,58 @@ static void stm32_hash_finish_req(struct ahash_request *req, int err)
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
+		u32 *preg = rctx->state.hw_context;
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
@@ -985,6 +989,7 @@ static int stm32_hash_enqueue(struct ahash_request *req, unsigned int op)
 static int stm32_hash_update(struct ahash_request *req)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
+	struct stm32_hash_state *state = &rctx->state;
 
 	if (!req->nbytes || !(rctx->flags & HASH_FLAGS_CPU))
 		return 0;
@@ -993,7 +998,7 @@ static int stm32_hash_update(struct ahash_request *req)
 	rctx->sg = req->src;
 	rctx->offset = 0;
 
-	if ((rctx->bufcnt + rctx->total < rctx->buflen)) {
+	if ((state->bufcnt + rctx->total < state->buflen)) {
 		stm32_hash_append_sg(rctx);
 		return 0;
 	}
@@ -1044,35 +1049,13 @@ static int stm32_hash_digest(struct ahash_request *req)
 static int stm32_hash_export(struct ahash_request *req, void *out)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
-	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
-	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
-	u32 *preg;
-	unsigned int i;
-	int ret;
+	bool empty = !(rctx->flags & HASH_FLAGS_INIT);
+	u8 *p = out;
 
-	pm_runtime_get_sync(hdev->dev);
-
-	ret = stm32_hash_wait_busy(hdev);
-	if (ret)
-		return ret;
-
-	rctx->hw_context = kmalloc_array(3 + HASH_CSR_REGISTER_NUMBER,
-					 sizeof(u32),
-					 GFP_KERNEL);
+	*(u8 *)p = empty;
 
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
-
-	memcpy(out, rctx, sizeof(*rctx));
+	if (!empty)
+		memcpy(p + 1, &rctx->state, sizeof(rctx->state));
 
 	return 0;
 }
@@ -1080,32 +1063,14 @@ static int stm32_hash_export(struct ahash_request *req, void *out)
 static int stm32_hash_import(struct ahash_request *req, const void *in)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
-	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
-	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
-	const u32 *preg = in;
-	u32 reg;
-	unsigned int i;
-
-	memcpy(rctx, in, sizeof(*rctx));
+	const u8 *p = in;
 
-	preg = rctx->hw_context;
-
-	pm_runtime_get_sync(hdev->dev);
+	stm32_hash_init(req);
 
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
+	if (!*(u8 *)p) {
+		rctx->flags |= HASH_FLAGS_INIT;
+		memcpy(&rctx->state, p + 1, sizeof(rctx->state));
+	}
 
 	return 0;
 }
@@ -1162,8 +1127,6 @@ static int stm32_hash_cra_init_algs(struct crypto_tfm *tfm,
 		ctx->flags |= HASH_FLAGS_HMAC;
 
 	ctx->enginectx.op.do_one_request = stm32_hash_one_request;
-	ctx->enginectx.op.prepare_request = stm32_hash_prepare_req;
-	ctx->enginectx.op.unprepare_request = NULL;
 
 	return stm32_hash_init_fallback(tfm);
 }
@@ -1255,7 +1218,7 @@ static struct ahash_alg algs_md5[] = {
 		.import = stm32_hash_import,
 		.halg = {
 			.digestsize = MD5_DIGEST_SIZE,
-			.statesize = sizeof(struct stm32_hash_request_ctx),
+			.statesize = sizeof(struct stm32_hash_state) + 1,
 			.base = {
 				.cra_name = "md5",
 				.cra_driver_name = "stm32-md5",
@@ -1282,7 +1245,7 @@ static struct ahash_alg algs_md5[] = {
 		.setkey = stm32_hash_setkey,
 		.halg = {
 			.digestsize = MD5_DIGEST_SIZE,
-			.statesize = sizeof(struct stm32_hash_request_ctx),
+			.statesize = sizeof(struct stm32_hash_state) + 1,
 			.base = {
 				.cra_name = "hmac(md5)",
 				.cra_driver_name = "stm32-hmac-md5",
@@ -1311,7 +1274,7 @@ static struct ahash_alg algs_sha1[] = {
 		.import = stm32_hash_import,
 		.halg = {
 			.digestsize = SHA1_DIGEST_SIZE,
-			.statesize = sizeof(struct stm32_hash_request_ctx),
+			.statesize = sizeof(struct stm32_hash_state) + 1,
 			.base = {
 				.cra_name = "sha1",
 				.cra_driver_name = "stm32-sha1",
@@ -1338,7 +1301,7 @@ static struct ahash_alg algs_sha1[] = {
 		.setkey = stm32_hash_setkey,
 		.halg = {
 			.digestsize = SHA1_DIGEST_SIZE,
-			.statesize = sizeof(struct stm32_hash_request_ctx),
+			.statesize = sizeof(struct stm32_hash_state) + 1,
 			.base = {
 				.cra_name = "hmac(sha1)",
 				.cra_driver_name = "stm32-hmac-sha1",
@@ -1367,7 +1330,7 @@ static struct ahash_alg algs_sha224[] = {
 		.import = stm32_hash_import,
 		.halg = {
 			.digestsize = SHA224_DIGEST_SIZE,
-			.statesize = sizeof(struct stm32_hash_request_ctx),
+			.statesize = sizeof(struct stm32_hash_state) + 1,
 			.base = {
 				.cra_name = "sha224",
 				.cra_driver_name = "stm32-sha224",
@@ -1394,7 +1357,7 @@ static struct ahash_alg algs_sha224[] = {
 		.import = stm32_hash_import,
 		.halg = {
 			.digestsize = SHA224_DIGEST_SIZE,
-			.statesize = sizeof(struct stm32_hash_request_ctx),
+			.statesize = sizeof(struct stm32_hash_state) + 1,
 			.base = {
 				.cra_name = "hmac(sha224)",
 				.cra_driver_name = "stm32-hmac-sha224",
@@ -1423,7 +1386,7 @@ static struct ahash_alg algs_sha256[] = {
 		.import = stm32_hash_import,
 		.halg = {
 			.digestsize = SHA256_DIGEST_SIZE,
-			.statesize = sizeof(struct stm32_hash_request_ctx),
+			.statesize = sizeof(struct stm32_hash_state) + 1,
 			.base = {
 				.cra_name = "sha256",
 				.cra_driver_name = "stm32-sha256",
@@ -1450,7 +1413,7 @@ static struct ahash_alg algs_sha256[] = {
 		.setkey = stm32_hash_setkey,
 		.halg = {
 			.digestsize = SHA256_DIGEST_SIZE,
-			.statesize = sizeof(struct stm32_hash_request_ctx),
+			.statesize = sizeof(struct stm32_hash_state) + 1,
 			.base = {
 				.cra_name = "hmac(sha256)",
 				.cra_driver_name = "stm32-hmac-sha256",
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
