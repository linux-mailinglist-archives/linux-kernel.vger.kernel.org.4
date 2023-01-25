Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B619667A793
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjAYAXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjAYAX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:23:29 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E74C6DC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:23:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id rl14so40187849ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUkCYflpr+n15L4Vm/MSLW1gKZcSFosf/SKBOHEfnoE=;
        b=FBUUSMTSAD24Njq7mG04mERxcZpYhWmVHoJtnNFaRCL9Y3/BWnHyc4978LWifZgpUB
         7JTpx0VZE43VbS6+hzWZWHbJGeElFVYkZngIYrtU+ZrJYHlJCCGoT9U3MBisger+Bwpe
         b2kHKoErxfcUtHRO7i2tuY6GHzdNGy0HYBU1M2DpCoGm1B79XR/XUxBYX0kAES55LpMO
         jbnncKMlj9dOs0ivCnIiOlDCSSsK2bvRJi6m1CEUKQeL7Ok3LAReuMSjfYdz9vqEvOvA
         FL/mQfgkz4dWv7K4n6zT6Yt+qOXjKGncBD7DdSGqiDXky5lYLdjN0nLaYlbbg3FzJ0ab
         Muiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUkCYflpr+n15L4Vm/MSLW1gKZcSFosf/SKBOHEfnoE=;
        b=AtXNGkjPnr+LGj7eXPf/feB84tQ2lx4JNetV+fAvlqV6fR9aO+ycTveeWc0S4JDH5K
         IFZj/dW3nRylS9aazutoXhclvW0ZKiTLE8TY6fL2KnzSA6QE07JNh0kvjJ6gGa0YN2Z0
         7XIOAub6iaYofYwdutW1y5ff6gGLTsId9WDgTt/x10UIHFANQnJ5xIPBGa+nTtw1qo6q
         JVfdXAYC+m8bnXDwgyqf0rRbVZ/+5s+8q3aJV8bXbwDKMKmoQFKPyQa1X/kSEA2Vjo+H
         VMEs3dIPBBFG0v/3a/olXZJ1qFonrmb2E+sSL0KJRHZ1MkVc2Fx77sBZdFlpls1GT2Un
         Q3TQ==
X-Gm-Message-State: AFqh2koIsJ3bWQFMteq5dIaBiqSD9tEd0u+EnUM1Tv7eBuUSMrWdk2Zk
        MzKOuDNSRbwa75sBK5MN5Q/mRQ==
X-Google-Smtp-Source: AMrXdXtfHliIojocN7Npl+Vd+Uvs3Y5LbR5HftmRnXKphVTdqbG/7SDsUEwmxNH1BeYzLZB+Srbg/A==
X-Received: by 2002:a17:907:75f5:b0:7c4:f501:e5b1 with SMTP id jz21-20020a17090775f500b007c4f501e5b1mr31786941ejc.51.1674606205402;
        Tue, 24 Jan 2023 16:23:25 -0800 (PST)
Received: from fedora.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id if10-20020a170906df4a00b00738795e7d9bsm1584606ejc.2.2023.01.24.16.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 16:23:25 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Jan 2023 01:23:10 +0100
Subject: [PATCH v3 5/6] crypto: stm32/hash: Support Ux500 hash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221227-ux500-stm32-hash-v3-5-32ee12cd6f06@linaro.org>
References: <20221227-ux500-stm32-hash-v3-0-32ee12cd6f06@linaro.org>
In-Reply-To: <20221227-ux500-stm32-hash-v3-0-32ee12cd6f06@linaro.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ux500 has a hash block which is an ancestor to the STM32
hash block. With some minor code path additions we can
support also this variant in the STM32 driver. Differences:

- Ux500 only supports SHA1 and SHA256 (+/- MAC) so we split
  up the algorithm registration per-algorithm and register
  each algorithm along with its MAC variant separately.

- Ux500 does not have an interrupt to indicate that hash
  calculation is complete, so we add code paths to handle
  polling for completion if the interrupt is missing in the
  device tree.

- Ux500 is lacking the SR status register, to check if an
  operating is complete, we need to poll the HASH_STR_DCAL
  bit in the HASH_STR register instead.

- Ux500 had the resulting hash at address offset 0x0c and
  8 32bit registers ahead. We account for this with a special
  code path when reading out the hash digest.

- Ux500 need a special bit set in the control register before
  performing the final hash calculation on an empty message.

- Ux500 hashes on empty messages will be performed if the
  above bit is set, but are incorrect. For this reason we
  just make an inline synchronous hash using a fallback
  hash.

Tested on the Ux500 Golden device with the extended tests.

Acked-by: Lionel Debieve <lionel.debieve@foss.st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Changed to allocating the fallback algorithm in .cra_init()
  and free it in .cra_exit(), store the fallback in the context.
- Picked up Lionel's ACK reluctantly, please take a second
  look Lionel as I changed some stuff.
ChangeLog v1->v2:
- Rename flag for mdmat from has_mdma to has_mdmat
- Fix some random whitespacing errors
- Fix the errorpath in the synchronous fallback
---
 drivers/crypto/stm32/stm32-hash.c | 254 ++++++++++++++++++++++++++++++++------
 1 file changed, 219 insertions(+), 35 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index d4eefd8292ff..7bf805563ac2 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -32,6 +32,7 @@
 #define HASH_CR				0x00
 #define HASH_DIN			0x04
 #define HASH_STR			0x08
+#define HASH_UX500_HREG(x)		(0x0c + ((x) * 0x04))
 #define HASH_IMR			0x20
 #define HASH_SR				0x24
 #define HASH_CSR(x)			(0x0F8 + ((x) * 0x04))
@@ -54,6 +55,10 @@
 #define HASH_CR_ALGO_SHA224		0x40000
 #define HASH_CR_ALGO_SHA256		0x40080
 
+#define HASH_CR_UX500_EMPTYMSG		BIT(20)
+#define HASH_CR_UX500_ALGO_SHA1		BIT(7)
+#define HASH_CR_UX500_ALGO_SHA256	0x0
+
 /* Interrupt */
 #define HASH_DINIE			BIT(0)
 #define HASH_DCIE			BIT(1)
@@ -115,6 +120,7 @@ enum stm32_hash_data_format {
 struct stm32_hash_ctx {
 	struct crypto_engine_ctx enginectx;
 	struct stm32_hash_dev	*hdev;
+	struct crypto_shash	*xtfm;
 	unsigned long		flags;
 
 	u8			key[HASH_MAX_KEY_SIZE];
@@ -157,6 +163,10 @@ struct stm32_hash_algs_info {
 struct stm32_hash_pdata {
 	struct stm32_hash_algs_info	*algs_info;
 	size_t				algs_info_size;
+	bool				has_sr;
+	bool				has_mdmat;
+	bool				broken_emptymsg;
+	bool				ux500;
 };
 
 struct stm32_hash_dev {
@@ -168,6 +178,7 @@ struct stm32_hash_dev {
 	phys_addr_t		phys_base;
 	u32			dma_mode;
 	u32			dma_maxburst;
+	bool			polled;
 
 	struct ahash_request	*req;
 	struct crypto_engine	*engine;
@@ -208,6 +219,11 @@ static inline int stm32_hash_wait_busy(struct stm32_hash_dev *hdev)
 {
 	u32 status;
 
+	/* The Ux500 lacks the special status register, we poll the DCAL bit instead */
+	if (!hdev->pdata->has_sr)
+		return readl_relaxed_poll_timeout(hdev->io_base + HASH_STR, status,
+						  !(status & HASH_STR_DCAL), 10, 10000);
+
 	return readl_relaxed_poll_timeout(hdev->io_base + HASH_SR, status,
 				   !(status & HASH_SR_BUSY), 10, 10000);
 }
@@ -249,7 +265,7 @@ static int stm32_hash_write_key(struct stm32_hash_dev *hdev)
 	return 0;
 }
 
-static void stm32_hash_write_ctrl(struct stm32_hash_dev *hdev)
+static void stm32_hash_write_ctrl(struct stm32_hash_dev *hdev, int bufcnt)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(hdev->req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(hdev->req);
@@ -263,13 +279,19 @@ static void stm32_hash_write_ctrl(struct stm32_hash_dev *hdev)
 			reg |= HASH_CR_ALGO_MD5;
 			break;
 		case HASH_FLAGS_SHA1:
-			reg |= HASH_CR_ALGO_SHA1;
+			if (hdev->pdata->ux500)
+				reg |= HASH_CR_UX500_ALGO_SHA1;
+			else
+				reg |= HASH_CR_ALGO_SHA1;
 			break;
 		case HASH_FLAGS_SHA224:
 			reg |= HASH_CR_ALGO_SHA224;
 			break;
 		case HASH_FLAGS_SHA256:
-			reg |= HASH_CR_ALGO_SHA256;
+			if (hdev->pdata->ux500)
+				reg |= HASH_CR_UX500_ALGO_SHA256;
+			else
+				reg |= HASH_CR_ALGO_SHA256;
 			break;
 		default:
 			reg |= HASH_CR_ALGO_MD5;
@@ -284,7 +306,15 @@ static void stm32_hash_write_ctrl(struct stm32_hash_dev *hdev)
 				reg |= HASH_CR_LKEY;
 		}
 
-		stm32_hash_write(hdev, HASH_IMR, HASH_DCIE);
+		/*
+		 * On the Ux500 we need to set a special flag to indicate that
+		 * the message is zero length.
+		 */
+		if (hdev->pdata->ux500 && bufcnt == 0)
+			reg |= HASH_CR_UX500_EMPTYMSG;
+
+		if (!hdev->polled)
+			stm32_hash_write(hdev, HASH_IMR, HASH_DCIE);
 
 		stm32_hash_write(hdev, HASH_CR, reg);
 
@@ -345,7 +375,7 @@ static int stm32_hash_xmit_cpu(struct stm32_hash_dev *hdev,
 
 	hdev->flags |= HASH_FLAGS_CPU;
 
-	stm32_hash_write_ctrl(hdev);
+	stm32_hash_write_ctrl(hdev, length);
 
 	if (stm32_hash_wait_busy(hdev))
 		return -ETIMEDOUT;
@@ -403,6 +433,14 @@ static int stm32_hash_update_cpu(struct stm32_hash_dev *hdev)
 		bufcnt = rctx->bufcnt;
 		rctx->bufcnt = 0;
 		err = stm32_hash_xmit_cpu(hdev, rctx->buffer, bufcnt, 1);
+
+		/* If we have an IRQ, wait for that, else poll for completion */
+		if (hdev->polled) {
+			if (stm32_hash_wait_busy(hdev))
+				return -ETIMEDOUT;
+			hdev->flags |= HASH_FLAGS_OUTPUT_READY;
+			err = 0;
+		}
 	}
 
 	return err;
@@ -433,11 +471,12 @@ static int stm32_hash_xmit_dma(struct stm32_hash_dev *hdev,
 
 	reg = stm32_hash_read(hdev, HASH_CR);
 
-	if (mdma)
-		reg |= HASH_CR_MDMAT;
-	else
-		reg &= ~HASH_CR_MDMAT;
-
+	if (!hdev->pdata->has_mdmat) {
+		if (mdma)
+			reg |= HASH_CR_MDMAT;
+		else
+			reg &= ~HASH_CR_MDMAT;
+	}
 	reg |= HASH_CR_DMAE;
 
 	stm32_hash_write(hdev, HASH_CR, reg);
@@ -558,7 +597,7 @@ static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 	if (rctx->nents < 0)
 		return -EINVAL;
 
-	stm32_hash_write_ctrl(hdev);
+	stm32_hash_write_ctrl(hdev, rctx->total);
 
 	if (hdev->flags & HASH_FLAGS_HMAC) {
 		err = stm32_hash_hmac_dma_send(hdev);
@@ -745,16 +784,57 @@ static int stm32_hash_final_req(struct stm32_hash_dev *hdev)
 	else
 		err = stm32_hash_xmit_cpu(hdev, rctx->buffer, buflen, 1);
 
+	/* If we have an IRQ, wait for that, else poll for completion */
+	if (hdev->polled) {
+		if (stm32_hash_wait_busy(hdev))
+			return -ETIMEDOUT;
+		hdev->flags |= HASH_FLAGS_OUTPUT_READY;
+		/* Caller will call stm32_hash_finish_req() */
+		err = 0;
+	}
 
 	return err;
 }
 
+static void stm32_hash_emptymsg_fallback(struct ahash_request *req)
+{
+	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
+	struct stm32_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
+	struct stm32_hash_dev *hdev = rctx->hdev;
+	int ret;
+
+	dev_dbg(hdev->dev, "use fallback message size 0 key size %d\n",
+		ctx->keylen);
+
+	if (!ctx->xtfm) {
+		dev_err(hdev->dev, "no fallback engine\n");
+		return;
+	}
+
+	if (ctx->keylen) {
+		ret = crypto_shash_setkey(ctx->xtfm, ctx->key, ctx->keylen);
+		if (ret) {
+			dev_err(hdev->dev, "failed to set key ret=%d\n", ret);
+			return;
+		}
+	}
+
+	ret = crypto_shash_tfm_digest(ctx->xtfm, NULL, 0, rctx->digest);
+	if (ret)
+		dev_err(hdev->dev, "shash digest error\n");
+}
+
 static void stm32_hash_copy_hash(struct ahash_request *req)
 {
 	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(req);
+	struct stm32_hash_dev *hdev = rctx->hdev;
 	__be32 *hash = (void *)rctx->digest;
 	unsigned int i, hashsize;
 
+	if (hdev->pdata->broken_emptymsg && !req->nbytes)
+		return stm32_hash_emptymsg_fallback(req);
+
 	switch (rctx->flags & HASH_FLAGS_ALGO_MASK) {
 	case HASH_FLAGS_MD5:
 		hashsize = MD5_DIGEST_SIZE;
@@ -772,9 +852,14 @@ static void stm32_hash_copy_hash(struct ahash_request *req)
 		return;
 	}
 
-	for (i = 0; i < hashsize / sizeof(u32); i++)
-		hash[i] = cpu_to_be32(stm32_hash_read(rctx->hdev,
-						      HASH_HREG(i)));
+	for (i = 0; i < hashsize / sizeof(u32); i++) {
+		if (hdev->pdata->ux500)
+			hash[i] = cpu_to_be32(stm32_hash_read(hdev,
+					      HASH_UX500_HREG(i)));
+		else
+			hash[i] = cpu_to_be32(stm32_hash_read(hdev,
+					      HASH_HREG(i)));
+	}
 }
 
 static int stm32_hash_finish(struct ahash_request *req)
@@ -977,7 +1062,8 @@ static int stm32_hash_export(struct ahash_request *req, void *out)
 
 	preg = rctx->hw_context;
 
-	*preg++ = stm32_hash_read(hdev, HASH_IMR);
+	if (!hdev->pdata->ux500)
+		*preg++ = stm32_hash_read(hdev, HASH_IMR);
 	*preg++ = stm32_hash_read(hdev, HASH_STR);
 	*preg++ = stm32_hash_read(hdev, HASH_CR);
 	for (i = 0; i < HASH_CSR_REGISTER_NUMBER; i++)
@@ -1006,7 +1092,8 @@ static int stm32_hash_import(struct ahash_request *req, const void *in)
 
 	pm_runtime_get_sync(hdev->dev);
 
-	stm32_hash_write(hdev, HASH_IMR, *preg++);
+	if (!hdev->pdata->ux500)
+		stm32_hash_write(hdev, HASH_IMR, *preg++);
 	stm32_hash_write(hdev, HASH_STR, *preg++);
 	stm32_hash_write(hdev, HASH_CR, *preg);
 	reg = *preg++ | HASH_CR_INIT;
@@ -1038,6 +1125,29 @@ static int stm32_hash_setkey(struct crypto_ahash *tfm,
 	return 0;
 }
 
+static int stm32_hash_init_fallback(struct crypto_tfm *tfm)
+{
+	struct stm32_hash_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
+	const char *name = crypto_tfm_alg_name(tfm);
+	struct crypto_shash *xtfm;
+
+	/* The fallback is only needed on Ux500 */
+	if (!hdev->pdata->ux500)
+		return 0;
+
+	xtfm = crypto_alloc_shash(name, 0, CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(xtfm)) {
+		dev_err(hdev->dev, "failed to allocate %s fallback\n",
+			name);
+		return PTR_ERR(xtfm);
+	}
+	dev_info(hdev->dev, "allocated %s fallback\n", name);
+	ctx->xtfm = xtfm;
+
+	return 0;
+}
+
 static int stm32_hash_cra_init_algs(struct crypto_tfm *tfm,
 				    const char *algs_hmac_name)
 {
@@ -1054,7 +1164,8 @@ static int stm32_hash_cra_init_algs(struct crypto_tfm *tfm,
 	ctx->enginectx.op.do_one_request = stm32_hash_one_request;
 	ctx->enginectx.op.prepare_request = stm32_hash_prepare_req;
 	ctx->enginectx.op.unprepare_request = NULL;
-	return 0;
+
+	return stm32_hash_init_fallback(tfm);
 }
 
 static int stm32_hash_cra_init(struct crypto_tfm *tfm)
@@ -1082,6 +1193,14 @@ static int stm32_hash_cra_sha256_init(struct crypto_tfm *tfm)
 	return stm32_hash_cra_init_algs(tfm, "sha256");
 }
 
+static void stm32_hash_cra_exit(struct crypto_tfm *tfm)
+{
+	struct stm32_hash_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (ctx->xtfm)
+		crypto_free_shash(ctx->xtfm);
+}
+
 static irqreturn_t stm32_hash_irq_thread(int irq, void *dev_id)
 {
 	struct stm32_hash_dev *hdev = dev_id;
@@ -1125,7 +1244,7 @@ static irqreturn_t stm32_hash_irq_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static struct ahash_alg algs_md5_sha1[] = {
+static struct ahash_alg algs_md5[] = {
 	{
 		.init = stm32_hash_init,
 		.update = stm32_hash_update,
@@ -1147,6 +1266,7 @@ static struct ahash_alg algs_md5_sha1[] = {
 				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
 				.cra_alignmask = 3,
 				.cra_init = stm32_hash_cra_init,
+				.cra_exit = stm32_hash_cra_exit,
 				.cra_module = THIS_MODULE,
 			}
 		}
@@ -1173,10 +1293,14 @@ static struct ahash_alg algs_md5_sha1[] = {
 				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
 				.cra_alignmask = 3,
 				.cra_init = stm32_hash_cra_md5_init,
+				.cra_exit = stm32_hash_cra_exit,
 				.cra_module = THIS_MODULE,
 			}
 		}
 	},
+};
+
+static struct ahash_alg algs_sha1[] = {
 	{
 		.init = stm32_hash_init,
 		.update = stm32_hash_update,
@@ -1198,6 +1322,7 @@ static struct ahash_alg algs_md5_sha1[] = {
 				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
 				.cra_alignmask = 3,
 				.cra_init = stm32_hash_cra_init,
+				.cra_exit = stm32_hash_cra_exit,
 				.cra_module = THIS_MODULE,
 			}
 		}
@@ -1224,13 +1349,14 @@ static struct ahash_alg algs_md5_sha1[] = {
 				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
 				.cra_alignmask = 3,
 				.cra_init = stm32_hash_cra_sha1_init,
+				.cra_exit = stm32_hash_cra_exit,
 				.cra_module = THIS_MODULE,
 			}
 		}
 	},
 };
 
-static struct ahash_alg algs_sha224_sha256[] = {
+static struct ahash_alg algs_sha224[] = {
 	{
 		.init = stm32_hash_init,
 		.update = stm32_hash_update,
@@ -1252,6 +1378,7 @@ static struct ahash_alg algs_sha224_sha256[] = {
 				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
 				.cra_alignmask = 3,
 				.cra_init = stm32_hash_cra_init,
+				.cra_exit = stm32_hash_cra_exit,
 				.cra_module = THIS_MODULE,
 			}
 		}
@@ -1278,10 +1405,14 @@ static struct ahash_alg algs_sha224_sha256[] = {
 				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
 				.cra_alignmask = 3,
 				.cra_init = stm32_hash_cra_sha224_init,
+				.cra_exit = stm32_hash_cra_exit,
 				.cra_module = THIS_MODULE,
 			}
 		}
 	},
+};
+
+static struct ahash_alg algs_sha256[] = {
 	{
 		.init = stm32_hash_init,
 		.update = stm32_hash_update,
@@ -1303,6 +1434,7 @@ static struct ahash_alg algs_sha224_sha256[] = {
 				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
 				.cra_alignmask = 3,
 				.cra_init = stm32_hash_cra_init,
+				.cra_exit = stm32_hash_cra_exit,
 				.cra_module = THIS_MODULE,
 			}
 		}
@@ -1329,6 +1461,7 @@ static struct ahash_alg algs_sha224_sha256[] = {
 				.cra_ctxsize = sizeof(struct stm32_hash_ctx),
 				.cra_alignmask = 3,
 				.cra_init = stm32_hash_cra_sha256_init,
+				.cra_exit = stm32_hash_cra_exit,
 				.cra_module = THIS_MODULE,
 			}
 		}
@@ -1374,35 +1507,73 @@ static int stm32_hash_unregister_algs(struct stm32_hash_dev *hdev)
 	return 0;
 }
 
+static struct stm32_hash_algs_info stm32_hash_algs_info_ux500[] = {
+	{
+		.algs_list	= algs_sha1,
+		.size		= ARRAY_SIZE(algs_sha1),
+	},
+	{
+		.algs_list	= algs_sha256,
+		.size		= ARRAY_SIZE(algs_sha256),
+	},
+};
+
+static const struct stm32_hash_pdata stm32_hash_pdata_ux500 = {
+	.algs_info	= stm32_hash_algs_info_ux500,
+	.algs_info_size	= ARRAY_SIZE(stm32_hash_algs_info_ux500),
+	.broken_emptymsg = true,
+	.ux500		= true,
+};
+
 static struct stm32_hash_algs_info stm32_hash_algs_info_stm32f4[] = {
 	{
-		.algs_list	= algs_md5_sha1,
-		.size		= ARRAY_SIZE(algs_md5_sha1),
+		.algs_list	= algs_md5,
+		.size		= ARRAY_SIZE(algs_md5),
+	},
+	{
+		.algs_list	= algs_sha1,
+		.size		= ARRAY_SIZE(algs_sha1),
 	},
 };
 
 static const struct stm32_hash_pdata stm32_hash_pdata_stm32f4 = {
 	.algs_info	= stm32_hash_algs_info_stm32f4,
 	.algs_info_size	= ARRAY_SIZE(stm32_hash_algs_info_stm32f4),
+	.has_sr		= true,
+	.has_mdmat	= true,
 };
 
 static struct stm32_hash_algs_info stm32_hash_algs_info_stm32f7[] = {
 	{
-		.algs_list	= algs_md5_sha1,
-		.size		= ARRAY_SIZE(algs_md5_sha1),
+		.algs_list	= algs_md5,
+		.size		= ARRAY_SIZE(algs_md5),
+	},
+	{
+		.algs_list	= algs_sha1,
+		.size		= ARRAY_SIZE(algs_sha1),
 	},
 	{
-		.algs_list	= algs_sha224_sha256,
-		.size		= ARRAY_SIZE(algs_sha224_sha256),
+		.algs_list	= algs_sha224,
+		.size		= ARRAY_SIZE(algs_sha224),
+	},
+	{
+		.algs_list	= algs_sha256,
+		.size		= ARRAY_SIZE(algs_sha256),
 	},
 };
 
 static const struct stm32_hash_pdata stm32_hash_pdata_stm32f7 = {
 	.algs_info	= stm32_hash_algs_info_stm32f7,
 	.algs_info_size	= ARRAY_SIZE(stm32_hash_algs_info_stm32f7),
+	.has_sr		= true,
+	.has_mdmat	= true,
 };
 
 static const struct of_device_id stm32_hash_of_match[] = {
+	{
+		.compatible = "stericsson,ux500-hash",
+		.data = &stm32_hash_pdata_ux500,
+	},
 	{
 		.compatible = "st,stm32f456-hash",
 		.data = &stm32_hash_pdata_stm32f4,
@@ -1456,16 +1627,23 @@ static int stm32_hash_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 && irq != -ENXIO)
 		return irq;
 
-	ret = devm_request_threaded_irq(dev, irq, stm32_hash_irq_handler,
-					stm32_hash_irq_thread, IRQF_ONESHOT,
-					dev_name(dev), hdev);
-	if (ret) {
-		dev_err(dev, "Cannot grab IRQ\n");
-		return ret;
+	if (irq > 0) {
+		ret = devm_request_threaded_irq(dev, irq,
+						stm32_hash_irq_handler,
+						stm32_hash_irq_thread,
+						IRQF_ONESHOT,
+						dev_name(dev), hdev);
+		if (ret) {
+			dev_err(dev, "Cannot grab IRQ\n");
+			return ret;
+		}
+	} else {
+		dev_info(dev, "No IRQ, use polling mode\n");
+		hdev->polled = true;
 	}
 
 	hdev->clk = devm_clk_get(&pdev->dev, NULL);
@@ -1507,9 +1685,11 @@ static int stm32_hash_probe(struct platform_device *pdev)
 	case 0:
 		break;
 	case -ENOENT:
-		dev_dbg(dev, "DMA mode not available\n");
+	case -ENODEV:
+		dev_info(dev, "DMA mode not available\n");
 		break;
 	default:
+		dev_err(dev, "DMA init error %d\n", ret);
 		goto err_dma;
 	}
 
@@ -1528,7 +1708,11 @@ static int stm32_hash_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_engine_start;
 
-	hdev->dma_mode = stm32_hash_read(hdev, HASH_HWCFGR);
+	if (hdev->pdata->ux500)
+		/* FIXME: implement DMA mode for Ux500 */
+		hdev->dma_mode = 0;
+	else
+		hdev->dma_mode = stm32_hash_read(hdev, HASH_HWCFGR);
 
 	/* Register algos */
 	ret = stm32_hash_register_algs(hdev);

-- 
2.39.0
