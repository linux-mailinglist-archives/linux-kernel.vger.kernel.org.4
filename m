Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878D86B5A31
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCKJnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCKJm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:42:26 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B3513FF03;
        Sat, 11 Mar 2023 01:42:21 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pavE7-002xaw-AF; Sat, 11 Mar 2023 17:09:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 11 Mar 2023 17:09:19 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Sat, 11 Mar 2023 17:09:19 +0800
Subject: [v7 PATCH 5/8] crypto: stm32 - Move hash state into separate structure
References: <ZAxFBR3TdA7jUAgJ@gondor.apana.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Message-Id: <E1pavE7-002xaw-AF@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new struct stm32_hash_state so that it may be exported
in future instead of the entire request context.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/stm32/stm32-hash.c |  127 +++++++++++++++++++++-----------------
 1 file changed, 71 insertions(+), 56 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index e35fee945371..c836163a9fd4 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -126,15 +126,24 @@ struct stm32_hash_ctx {
 	int			keylen;
 };
 
+struct stm32_hash_state {
+	u32			flags;
+
+	u16			bufcnt;
+	u16			buflen;
+
+	u8 buffer[HASH_BUFLEN] __aligned(4);
+
+	/* hash state */
+	u32			*hw_context;
+};
+
 struct stm32_hash_request_ctx {
 	struct stm32_hash_dev	*hdev;
-	unsigned long		flags;
 	unsigned long		op;
 
 	u8 digest[SHA256_DIGEST_SIZE] __aligned(sizeof(u32));
 	size_t			digcnt;
-	size_t			bufcnt;
-	size_t			buflen;
 
 	/* DMA */
 	struct scatterlist	*sg;
@@ -148,10 +157,7 @@ struct stm32_hash_request_ctx {
 
 	u8			data_type;
 
-	u8 buffer[HASH_BUFLEN] __aligned(sizeof(u32));
-
-	/* Export Context */
-	u32			*hw_context;
+	struct stm32_hash_state state;
 };
 
 struct stm32_hash_algs_info {
@@ -268,11 +274,12 @@ static void stm32_hash_write_ctrl(struct stm32_hash_dev *hdev, int bufcnt)
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(hdev->req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(hdev->req);
 	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct stm32_hash_state *state = &rctx->state;
 
 	u32 reg = HASH_CR_INIT;
 
 	if (!(hdev->flags & HASH_FLAGS_INIT)) {
-		switch (rctx->flags & HASH_FLAGS_ALGO_MASK) {
+		switch (state->flags & HASH_FLAGS_ALGO_MASK) {
 		case HASH_FLAGS_MD5:
 			reg |= HASH_CR_ALGO_MD5;
 			break;
@@ -297,7 +304,7 @@ static void stm32_hash_write_ctrl(struct stm32_hash_dev *hdev, int bufcnt)
 
 		reg |= (rctx->data_type << HASH_CR_DATATYPE_POS);
 
-		if (rctx->flags & HASH_FLAGS_HMAC) {
+		if (state->flags & HASH_FLAGS_HMAC) {
 			hdev->flags |= HASH_FLAGS_HMAC;
 			reg |= HASH_CR_MODE;
 			if (ctx->keylen > HASH_LONG_KEY)
@@ -324,11 +331,12 @@ static void stm32_hash_write_ctrl(struct stm32_hash_dev *hdev, int bufcnt)
 
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
@@ -339,10 +347,10 @@ static void stm32_hash_append_sg(struct stm32_hash_request_ctx *rctx)
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
 
@@ -411,18 +419,19 @@ static int stm32_hash_xmit_cpu(struct stm32_hash_dev *hdev,
 static int stm32_hash_update_cpu(struct stm32_hash_dev *hdev)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(hdev->req);
+	struct stm32_hash_state *state = &rctx->state;
 	int bufcnt, err = 0, final;
 
-	dev_dbg(hdev->dev, "%s flags %lx\n", __func__, rctx->flags);
+	dev_dbg(hdev->dev, "%s flags %x\n", __func__, state->flags);
 
-	final = rctx->flags & HASH_FLAGS_FINAL;
+	final = state->flags & HASH_FLAGS_FINAL;
 
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
 		if (err)
 			return err;
 	}
@@ -430,9 +439,9 @@ static int stm32_hash_update_cpu(struct stm32_hash_dev *hdev)
 	stm32_hash_append_sg(rctx);
 
 	if (final) {
-		bufcnt = rctx->bufcnt;
-		rctx->bufcnt = 0;
-		err = stm32_hash_xmit_cpu(hdev, rctx->buffer, bufcnt, 1);
+		bufcnt = state->bufcnt;
+		state->bufcnt = 0;
+		err = stm32_hash_xmit_cpu(hdev, state->buffer, bufcnt, 1);
 	}
 
 	return err;
@@ -576,10 +585,10 @@ static int stm32_hash_dma_init(struct stm32_hash_dev *hdev)
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
@@ -607,7 +616,7 @@ static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 
 				ncp = sg_pcopy_to_buffer(
 					rctx->sg, rctx->nents,
-					rctx->buffer, sg->length - len,
+					rctx->state.buffer, sg->length - len,
 					rctx->total - sg->length + len);
 
 				sg->length = len;
@@ -718,41 +727,40 @@ static int stm32_hash_init(struct ahash_request *req)
 	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(tfm);
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
 	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
+	struct stm32_hash_state *state = &rctx->state;
 
 	rctx->hdev = hdev;
 
-	rctx->flags = HASH_FLAGS_CPU;
+	state->flags = HASH_FLAGS_CPU;
 
 	rctx->digcnt = crypto_ahash_digestsize(tfm);
 	switch (rctx->digcnt) {
 	case MD5_DIGEST_SIZE:
-		rctx->flags |= HASH_FLAGS_MD5;
+		state->flags |= HASH_FLAGS_MD5;
 		break;
 	case SHA1_DIGEST_SIZE:
-		rctx->flags |= HASH_FLAGS_SHA1;
+		state->flags |= HASH_FLAGS_SHA1;
 		break;
 	case SHA224_DIGEST_SIZE:
-		rctx->flags |= HASH_FLAGS_SHA224;
+		state->flags |= HASH_FLAGS_SHA224;
 		break;
 	case SHA256_DIGEST_SIZE:
-		rctx->flags |= HASH_FLAGS_SHA256;
+		state->flags |= HASH_FLAGS_SHA256;
 		break;
 	default:
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
-		rctx->flags |= HASH_FLAGS_HMAC;
+		state->flags |= HASH_FLAGS_HMAC;
 
-	dev_dbg(hdev->dev, "%s Flags %lx\n", __func__, rctx->flags);
+	dev_dbg(hdev->dev, "%s Flags %x\n", __func__, state->flags);
 
 	return 0;
 }
@@ -760,8 +768,9 @@ static int stm32_hash_init(struct ahash_request *req)
 static int stm32_hash_update_req(struct stm32_hash_dev *hdev)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(hdev->req);
+	struct stm32_hash_state *state = &rctx->state;
 
-	if (!(rctx->flags & HASH_FLAGS_CPU))
+	if (!(state->flags & HASH_FLAGS_CPU))
 		return stm32_hash_dma_send(hdev);
 
 	return stm32_hash_update_cpu(hdev);
@@ -771,14 +780,15 @@ static int stm32_hash_final_req(struct stm32_hash_dev *hdev)
 {
 	struct ahash_request *req = hdev->req;
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
-	int buflen = rctx->bufcnt;
+	struct stm32_hash_state *state = &rctx->state;
+	int buflen = state->bufcnt;
 
-	if (rctx->flags & HASH_FLAGS_FINUP)
+	if (state->flags & HASH_FLAGS_FINUP)
 		return stm32_hash_update_req(hdev);
 
-	rctx->bufcnt = 0;
+	state->bufcnt = 0;
 
-	return stm32_hash_xmit_cpu(hdev, rctx->buffer, buflen, 1);
+	return stm32_hash_xmit_cpu(hdev, state->buffer, buflen, 1);
 }
 
 static void stm32_hash_emptymsg_fallback(struct ahash_request *req)
@@ -813,6 +823,7 @@ static void stm32_hash_emptymsg_fallback(struct ahash_request *req)
 static void stm32_hash_copy_hash(struct ahash_request *req)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
+	struct stm32_hash_state *state = &rctx->state;
 	struct stm32_hash_dev *hdev = rctx->hdev;
 	__be32 *hash = (void *)rctx->digest;
 	unsigned int i, hashsize;
@@ -820,7 +831,7 @@ static void stm32_hash_copy_hash(struct ahash_request *req)
 	if (hdev->pdata->broken_emptymsg && !req->nbytes)
 		return stm32_hash_emptymsg_fallback(req);
 
-	switch (rctx->flags & HASH_FLAGS_ALGO_MASK) {
+	switch (state->flags & HASH_FLAGS_ALGO_MASK) {
 	case HASH_FLAGS_MD5:
 		hashsize = MD5_DIGEST_SIZE;
 		break;
@@ -862,6 +873,7 @@ static int stm32_hash_finish(struct ahash_request *req)
 static void stm32_hash_finish_req(struct ahash_request *req, int err)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
+	struct stm32_hash_state *state = &rctx->state;
 	struct stm32_hash_dev *hdev = rctx->hdev;
 
 	if (!err && (HASH_FLAGS_FINAL & hdev->flags)) {
@@ -873,7 +885,7 @@ static void stm32_hash_finish_req(struct ahash_request *req, int err)
 				 HASH_FLAGS_HMAC_INIT | HASH_FLAGS_HMAC_FINAL |
 				 HASH_FLAGS_HMAC_KEY);
 	} else {
-		rctx->flags |= HASH_FLAGS_ERRORS;
+		state->flags |= HASH_FLAGS_ERRORS;
 	}
 
 	pm_runtime_mark_last_busy(hdev->dev);
@@ -979,15 +991,16 @@ static int stm32_hash_enqueue(struct ahash_request *req, unsigned int op)
 static int stm32_hash_update(struct ahash_request *req)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
+	struct stm32_hash_state *state = &rctx->state;
 
-	if (!req->nbytes || !(rctx->flags & HASH_FLAGS_CPU))
+	if (!req->nbytes || !(state->flags & HASH_FLAGS_CPU))
 		return 0;
 
 	rctx->total = req->nbytes;
 	rctx->sg = req->src;
 	rctx->offset = 0;
 
-	if ((rctx->bufcnt + rctx->total < rctx->buflen)) {
+	if ((state->bufcnt + rctx->total < state->buflen)) {
 		stm32_hash_append_sg(rctx);
 		return 0;
 	}
@@ -998,8 +1011,9 @@ static int stm32_hash_update(struct ahash_request *req)
 static int stm32_hash_final(struct ahash_request *req)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
+	struct stm32_hash_state *state = &rctx->state;
 
-	rctx->flags |= HASH_FLAGS_FINAL;
+	state->flags |= HASH_FLAGS_FINAL;
 
 	return stm32_hash_enqueue(req, HASH_OP_FINAL);
 }
@@ -1009,17 +1023,18 @@ static int stm32_hash_finup(struct ahash_request *req)
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
 	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
 	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
+	struct stm32_hash_state *state = &rctx->state;
 
 	if (!req->nbytes)
 		goto out;
 
-	rctx->flags |= HASH_FLAGS_FINUP;
+	state->flags |= HASH_FLAGS_FINUP;
 	rctx->total = req->nbytes;
 	rctx->sg = req->src;
 	rctx->offset = 0;
 
 	if (hdev->dma_lch && stm32_hash_dma_aligned_data(req))
-		rctx->flags &= ~HASH_FLAGS_CPU;
+		state->flags &= ~HASH_FLAGS_CPU;
 
 out:
 	return stm32_hash_final(req);
@@ -1035,6 +1050,7 @@ static int stm32_hash_export(struct ahash_request *req, void *out)
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
 	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
 	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
+	struct stm32_hash_state *state = &rctx->state;
 	u32 *preg;
 	unsigned int i;
 	int ret;
@@ -1045,11 +1061,9 @@ static int stm32_hash_export(struct ahash_request *req, void *out)
 	if (ret)
 		return ret;
 
-	rctx->hw_context = kmalloc_array(3 + HASH_CSR_REGISTER_NUMBER,
-					 sizeof(u32),
-					 GFP_KERNEL);
-
-	preg = rctx->hw_context;
+	state->hw_context = kmalloc_array(3 + HASH_CSR_REGISTER_NUMBER,
+					  sizeof(u32), GFP_KERNEL);
+	preg = state->hw_context;
 
 	if (!hdev->pdata->ux500)
 		*preg++ = stm32_hash_read(hdev, HASH_IMR);
@@ -1071,13 +1085,14 @@ static int stm32_hash_import(struct ahash_request *req, const void *in)
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
 	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
 	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
+	struct stm32_hash_state *state = &rctx->state;
 	const u32 *preg = in;
 	u32 reg;
 	unsigned int i;
 
 	memcpy(rctx, in, sizeof(*rctx));
 
-	preg = rctx->hw_context;
+	preg = state->hw_context;
 
 	pm_runtime_get_sync(hdev->dev);
 
@@ -1094,7 +1109,7 @@ static int stm32_hash_import(struct ahash_request *req, const void *in)
 	pm_runtime_mark_last_busy(hdev->dev);
 	pm_runtime_put_autosuspend(hdev->dev);
 
-	kfree(rctx->hw_context);
+	kfree(state->hw_context);
 
 	return 0;
 }
