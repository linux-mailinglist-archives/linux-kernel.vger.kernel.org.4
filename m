Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F166A05BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjBWKLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjBWKKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:10:54 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECC651F9D;
        Thu, 23 Feb 2023 02:10:39 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pV8YL-00Epv7-PF; Thu, 23 Feb 2023 18:10:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Feb 2023 18:10:17 +0800
Date:   Thu, 23 Feb 2023 18:10:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Subject: [PATCH] crypto: stm32 - Save and restore between each request
Message-ID: <Y/c7iVW67Xhhdu8e@gondor.apana.org.au>
References: <Y/cBB+q0Ono9j2Jy@gondor.apana.org.au>
 <20230224231430.2948-1-kunyu@nfschina.com>
 <Y/cy5wUtk10OahpO@gondor.apana.org.au>
 <CACRpkdYyB=-UnE1bmdVszSSB5ReECZ0fUoWJX6XtYbKHEe52tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYyB=-UnE1bmdVszSSB5ReECZ0fUoWJX6XtYbKHEe52tA@mail.gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:52:17AM +0100, Linus Walleij wrote:
>
> Can we fix the actual problem? It seems to have been there since the
> initial submission in 2017.
> 
> I guess the right fix is to export the *actual* hardware state into "out"
> and read it back from there instead of copying out the rctx struct.
> Also .statesize needs to be fixed to correspond to that.
> I can just use a roof:ed constant size for this.

Indeed.  It looks like the driver already has everything we need
but it's just in the wrong place.

Here's my completely untested patch to move the hardware state
reading/writing to where I think it should be.  As it stands,
not only is export/import broken, but multiple hashing requests
occuring concurrently will overwrite each other's state.

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
index 7bf805563ac2..4bc69677a861 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -148,11 +148,12 @@ struct stm32_hash_request_ctx {
 	int			nents;
 
 	u8			data_type;
+	bool			started;
 
 	u8 buffer[HASH_BUFLEN] __aligned(sizeof(u32));
 
-	/* Export Context */
-	u32			*hw_context;
+	/* hash state */
+	u32			hw_context[3 + HASH_CSR_REGISTER_NUMBER];
 };
 
 struct stm32_hash_algs_info {
@@ -441,8 +442,20 @@ static int stm32_hash_update_cpu(struct stm32_hash_dev *hdev)
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
 	}
 
+	rctx->started = !final;
+
 	return err;
 }
 
@@ -754,6 +767,7 @@ static int stm32_hash_init(struct ahash_request *req)
 	rctx->total = 0;
 	rctx->offset = 0;
 	rctx->data_type = HASH_DATA_8_BITS;
+	rctx->started = false;
 
 	memset(rctx->buffer, 0, HASH_BUFLEN);
 
@@ -959,6 +973,22 @@ static int stm32_hash_one_request(struct crypto_engine *engine, void *areq)
 
 	rctx = ahash_request_ctx(req);
 
+	if (rctx->started) {
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
+	}
+
 	if (rctx->op == HASH_OP_UPDATE)
 		err = stm32_hash_update_req(hdev);
 	else if (rctx->op == HASH_OP_FINAL)
@@ -1044,33 +1074,6 @@ static int stm32_hash_digest(struct ahash_request *req)
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
 
@@ -1080,33 +1083,9 @@ static int stm32_hash_export(struct ahash_request *req, void *out)
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
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
