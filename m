Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7DD5EBC70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiI0H7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiI0H5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:57:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3894AEDAC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:56:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h7so1287919wru.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QipqmHbUZGHLWu5BlBNjHs+pAuw4tqeLoTpMAyu+/es=;
        b=jwcCEhTXdHbeKkjeWK+MvMrthc056cMoYzAYbT9fSGb4d/OJwB6wTXFupwgWETwDUk
         KMdfyclrKSBYQhc9WU7mbIJiZj5oXw1mWipTjTmBuUfFIRcCmzl7+7SxCKCIFMSAuDWr
         yFmEHpTm1OqGTaSEBdNsL0QDOr+kcC+BR1GvBdheTTSfxSsPtMdIZc7sDmZbiFJMnypi
         eXyOEnRwQvrnlctUAGdFo5lUxUIabgfQj6F4R6PLQ+Q3Gw1/5nwjl8W7julSwfOfyuVX
         tbGqcAz0RPmJLTRatEe6eZsjE5l9mhKDEPFq+Wg7/XFyrBGn+DsZeTyxKlVgYpMPl3BA
         /PjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QipqmHbUZGHLWu5BlBNjHs+pAuw4tqeLoTpMAyu+/es=;
        b=pBlp1X2/selzKBVgby++FGxW8OgQxgcG9APVyQkJUTsN6bssPoiW2GA4AISPc0z7R0
         FprvP9PCgKuVdpi9fMiFRm2zc9THFgujLi1nVeigMJr9PKGed8NyGy6FgdKRssM2Y3ID
         gcQoX2GQ4htbMNZ3+Xepg4h3YZrRTPoPmPkcXghlEb2AylN1u9OTPyeVKJTAEVVTD0ZP
         3AL8mekKCqEAvOBTwNp4ytHk31ubKdqShIUot15HZBNLccx0u49i1nB5SHaAjyBVX8yP
         1dW27YIQfCBndJ6+0ljZObzPMOUCUOpC5edeECTsU1aDMVSTkNBWvnM2fpFyn0VwG0A+
         osGQ==
X-Gm-Message-State: ACrzQf2g+ogFHzlFSYaNGmn3qQIDYkyU7qTe3hzKhpO0vfMshOttHbxZ
        WxqPZBFnoFTYyAgSWgc7FPMJfw==
X-Google-Smtp-Source: AMsMyM7K+ymi+QQYX5gsaalOWOHDoQxV3Hvf+WX5bbEGtYUAWosJaxnVIUdGEXgs6HuIfnku7XpykA==
X-Received: by 2002:a5d:5a85:0:b0:22a:34a8:eda7 with SMTP id bp5-20020a5d5a85000000b0022a34a8eda7mr15590236wrb.687.1664265371088;
        Tue, 27 Sep 2022 00:56:11 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8-20020adfdcc8000000b0022afbd02c69sm1076654wrm.56.2022.09.27.00.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 00:56:10 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v10 33/33] crypto: rockchip: Add support for RK3399
Date:   Tue, 27 Sep 2022 07:55:11 +0000
Message-Id: <20220927075511.3147847-34-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927075511.3147847-1-clabbe@baylibre.com>
References: <20220927075511.3147847-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3399 has 2 rk3288 compatible crypto device named crypto0 and
crypto1. The only difference is lack of RSA in crypto1.

We need to add driver support for 2 parallel instance as only one need
to register crypto algorithms.
Then the driver will round robin each request on each device.

For avoiding complexity (device bringup after a TFM is created), PM is
modified to be handled per request.
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c       | 92 +++++++++++++++----
 drivers/crypto/rockchip/rk3288_crypto.h       | 25 +++--
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 37 ++++----
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 37 ++++----
 4 files changed, 123 insertions(+), 68 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index d96f375423d5..6217e73ba4c4 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -19,6 +19,23 @@
 #include <linux/crypto.h>
 #include <linux/reset.h>
 
+static struct rockchip_ip rocklist = {
+	.dev_list = LIST_HEAD_INIT(rocklist.dev_list),
+	.lock = __SPIN_LOCK_UNLOCKED(rocklist.lock),
+};
+
+struct rk_crypto_info *get_rk_crypto(void)
+{
+	struct rk_crypto_info *first;
+
+	spin_lock(&rocklist.lock);
+	first = list_first_entry_or_null(&rocklist.dev_list,
+					 struct rk_crypto_info, list);
+	list_rotate_left(&rocklist.dev_list);
+	spin_unlock(&rocklist.lock);
+	return first;
+}
+
 static const struct rk_variant rk3288_variant = {
 	.num_clks = 4,
 	.rkclks = {
@@ -30,6 +47,10 @@ static const struct rk_variant rk3328_variant = {
 	.num_clks = 3,
 };
 
+static const struct rk_variant rk3399_variant = {
+	.num_clks = 3,
+};
+
 static int rk_crypto_get_clks(struct rk_crypto_info *dev)
 {
 	int i, j, err;
@@ -83,8 +104,8 @@ static void rk_crypto_disable_clk(struct rk_crypto_info *dev)
 }
 
 /*
- * Power management strategy: The device is suspended unless a TFM exists for
- * one of the algorithms proposed by this driver.
+ * Power management strategy: The device is suspended until a request
+ * is handled. For avoiding suspend/resume yoyo, the autosuspend is set to 2s.
  */
 static int rk_crypto_pm_suspend(struct device *dev)
 {
@@ -166,8 +187,17 @@ static struct rk_crypto_tmp *rk_cipher_algs[] = {
 #ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_DEBUG
 static int rk_crypto_debugfs_show(struct seq_file *seq, void *v)
 {
+	struct rk_crypto_info *dd;
 	unsigned int i;
 
+	spin_lock(&rocklist.lock);
+	list_for_each_entry(dd, &rocklist.dev_list, list) {
+		seq_printf(seq, "%s %s requests: %lu\n",
+			   dev_driver_string(dd->dev), dev_name(dd->dev),
+			   dd->nreq);
+	}
+	spin_unlock(&rocklist.lock);
+
 	for (i = 0; i < ARRAY_SIZE(rk_cipher_algs); i++) {
 		if (!rk_cipher_algs[i]->dev)
 			continue;
@@ -198,6 +228,18 @@ static int rk_crypto_debugfs_show(struct seq_file *seq, void *v)
 DEFINE_SHOW_ATTRIBUTE(rk_crypto_debugfs);
 #endif
 
+static void register_debugfs(struct rk_crypto_info *crypto_info)
+{
+#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_DEBUG
+	/* Ignore error of debugfs */
+	rocklist.dbgfs_dir = debugfs_create_dir("rk3288_crypto", NULL);
+	rocklist.dbgfs_stats = debugfs_create_file("stats", 0444,
+						   rocklist.dbgfs_dir,
+						   &rocklist,
+						   &rk_crypto_debugfs_fops);
+#endif
+}
+
 static int rk_crypto_register(struct rk_crypto_info *crypto_info)
 {
 	unsigned int i, k;
@@ -255,6 +297,9 @@ static const struct of_device_id crypto_of_id_table[] = {
 	{ .compatible = "rockchip,rk3328-crypto",
 	  .data = &rk3328_variant,
 	},
+	{ .compatible = "rockchip,rk3399-crypto",
+	  .data = &rk3399_variant,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, crypto_of_id_table);
@@ -262,7 +307,7 @@ MODULE_DEVICE_TABLE(of, crypto_of_id_table);
 static int rk_crypto_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct rk_crypto_info *crypto_info;
+	struct rk_crypto_info *crypto_info, *first;
 	int err = 0;
 
 	crypto_info = devm_kzalloc(&pdev->dev,
@@ -325,22 +370,22 @@ static int rk_crypto_probe(struct platform_device *pdev)
 	if (err)
 		goto err_pm;
 
-	err = rk_crypto_register(crypto_info);
-	if (err) {
-		dev_err(dev, "err in register alg");
-		goto err_register_alg;
-	}
+	spin_lock(&rocklist.lock);
+	first = list_first_entry_or_null(&rocklist.dev_list,
+					 struct rk_crypto_info, list);
+	list_add_tail(&crypto_info->list, &rocklist.dev_list);
+	spin_unlock(&rocklist.lock);
+
+	if (!first) {
+		err = rk_crypto_register(crypto_info);
+		if (err) {
+			dev_err(dev, "Fail to register crypto algorithms");
+			goto err_register_alg;
+		}
 
-#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_DEBUG
-	/* Ignore error of debugfs */
-	crypto_info->dbgfs_dir = debugfs_create_dir("rk3288_crypto", NULL);
-	crypto_info->dbgfs_stats = debugfs_create_file("stats", 0444,
-						       crypto_info->dbgfs_dir,
-						       crypto_info,
-						       &rk_crypto_debugfs_fops);
-#endif
+		register_debugfs(crypto_info);
+	}
 
-	dev_info(dev, "Crypto Accelerator successfully registered\n");
 	return 0;
 
 err_register_alg:
@@ -355,11 +400,20 @@ static int rk_crypto_probe(struct platform_device *pdev)
 static int rk_crypto_remove(struct platform_device *pdev)
 {
 	struct rk_crypto_info *crypto_tmp = platform_get_drvdata(pdev);
+	struct rk_crypto_info *first;
+
+	spin_lock_bh(&rocklist.lock);
+	list_del(&crypto_tmp->list);
+	first = list_first_entry_or_null(&rocklist.dev_list,
+					 struct rk_crypto_info, list);
+	spin_unlock_bh(&rocklist.lock);
 
+	if (!first) {
 #ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_DEBUG
-	debugfs_remove_recursive(crypto_tmp->dbgfs_dir);
+		debugfs_remove_recursive(rocklist.dbgfs_dir);
 #endif
-	rk_crypto_unregister();
+		rk_crypto_unregister();
+	}
 	rk_crypto_pm_exit(crypto_tmp);
 	crypto_engine_exit(crypto_tmp->engine);
 	return 0;
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index ac979d67ced9..b2695258cade 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -190,6 +190,20 @@
 
 #define RK_MAX_CLKS 4
 
+/*
+ * struct rockchip_ip - struct for managing a list of RK crypto instance
+ * @dev_list:		Used for doing a list of rk_crypto_info
+ * @lock:		Control access to dev_list
+ * @dbgfs_dir:		Debugfs dentry for statistic directory
+ * @dbgfs_stats:	Debugfs dentry for statistic counters
+ */
+struct rockchip_ip {
+	struct list_head	dev_list;
+	spinlock_t		lock; /* Control access to dev_list */
+	struct dentry		*dbgfs_dir;
+	struct dentry		*dbgfs_stats;
+};
+
 struct rk_clks {
 	const char *name;
 	unsigned long max;
@@ -201,6 +215,7 @@ struct rk_variant {
 };
 
 struct rk_crypto_info {
+	struct list_head		list;
 	struct device			*dev;
 	struct clk_bulk_data		*clks;
 	int				num_clks;
@@ -208,19 +223,15 @@ struct rk_crypto_info {
 	void __iomem			*reg;
 	int				irq;
 	const struct rk_variant *variant;
+	unsigned long nreq;
 	struct crypto_engine *engine;
 	struct completion complete;
 	int status;
-#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_DEBUG
-	struct dentry *dbgfs_dir;
-	struct dentry *dbgfs_stats;
-#endif
 };
 
 /* the private variable of hash */
 struct rk_ahash_ctx {
 	struct crypto_engine_ctx enginectx;
-	struct rk_crypto_info		*dev;
 	/* for fallback */
 	struct crypto_ahash		*fallback_tfm;
 };
@@ -236,7 +247,6 @@ struct rk_ahash_rctx {
 /* the private variable of cipher */
 struct rk_cipher_ctx {
 	struct crypto_engine_ctx enginectx;
-	struct rk_crypto_info		*dev;
 	unsigned int			keylen;
 	u8				key[AES_MAX_KEY_SIZE];
 	u8				iv[AES_BLOCK_SIZE];
@@ -252,7 +262,7 @@ struct rk_cipher_rctx {
 
 struct rk_crypto_tmp {
 	u32 type;
-	struct rk_crypto_info		*dev;
+	struct rk_crypto_info           *dev;
 	union {
 		struct skcipher_alg	skcipher;
 		struct ahash_alg	hash;
@@ -276,4 +286,5 @@ extern struct rk_crypto_tmp rk_ahash_sha1;
 extern struct rk_crypto_tmp rk_ahash_sha256;
 extern struct rk_crypto_tmp rk_ahash_md5;
 
+struct rk_crypto_info *get_rk_crypto(void);
 #endif
diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 30f78256c955..a78ff3dcd0b1 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -199,8 +199,8 @@ static int rk_ahash_export(struct ahash_request *req, void *out)
 static int rk_ahash_digest(struct ahash_request *req)
 {
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
-	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
-	struct rk_crypto_info *dev = tctx->dev;
+	struct rk_crypto_info *dev;
+	struct crypto_engine *engine;
 
 	if (rk_ahash_need_fallback(req))
 		return rk_ahash_digest_fb(req);
@@ -208,9 +208,12 @@ static int rk_ahash_digest(struct ahash_request *req)
 	if (!req->nbytes)
 		return zero_message_process(req);
 
+	dev = get_rk_crypto();
+
 	rctx->dev = dev;
+	engine = dev->engine;
 
-	return crypto_transfer_hash_request_to_engine(dev->engine, req);
+	return crypto_transfer_hash_request_to_engine(engine, req);
 }
 
 static void crypto_ahash_dma_start(struct rk_crypto_info *dev, struct scatterlist *sg)
@@ -260,9 +263,14 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 	int i;
 	u32 v;
 
+	err = pm_runtime_resume_and_get(rkc->dev);
+	if (err)
+		return err;
+
 	rctx->mode = 0;
 
 	algt->stat_req++;
+	rkc->nreq++;
 
 	switch (crypto_ahash_digestsize(tfm)) {
 	case SHA1_DIGEST_SIZE:
@@ -313,6 +321,8 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 	}
 
 theend:
+	pm_runtime_put_autosuspend(rkc->dev);
+
 	local_bh_disable();
 	crypto_finalize_hash_request(engine, breq, err);
 	local_bh_enable();
@@ -323,21 +333,15 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 static int rk_cra_hash_init(struct crypto_tfm *tfm)
 {
 	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(tfm);
-	struct rk_crypto_tmp *algt;
-	struct ahash_alg *alg = __crypto_ahash_alg(tfm->__crt_alg);
-
 	const char *alg_name = crypto_tfm_alg_name(tfm);
-	int err;
-
-	algt = container_of(alg, struct rk_crypto_tmp, alg.hash);
-
-	tctx->dev = algt->dev;
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->__crt_alg);
+	struct rk_crypto_tmp *algt = container_of(alg, struct rk_crypto_tmp, alg.hash);
 
 	/* for fallback */
 	tctx->fallback_tfm = crypto_alloc_ahash(alg_name, 0,
 						CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(tctx->fallback_tfm)) {
-		dev_err(tctx->dev->dev, "Could not load fallback driver.\n");
+		dev_err(algt->dev->dev, "Could not load fallback driver.\n");
 		return PTR_ERR(tctx->fallback_tfm);
 	}
 
@@ -349,15 +353,7 @@ static int rk_cra_hash_init(struct crypto_tfm *tfm)
 	tctx->enginectx.op.prepare_request = rk_hash_prepare;
 	tctx->enginectx.op.unprepare_request = rk_hash_unprepare;
 
-	err = pm_runtime_resume_and_get(tctx->dev->dev);
-	if (err < 0)
-		goto error_pm;
-
 	return 0;
-error_pm:
-	crypto_free_ahash(tctx->fallback_tfm);
-
-	return err;
 }
 
 static void rk_cra_hash_exit(struct crypto_tfm *tfm)
@@ -365,7 +361,6 @@ static void rk_cra_hash_exit(struct crypto_tfm *tfm)
 	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(tfm);
 
 	crypto_free_ahash(tctx->fallback_tfm);
-	pm_runtime_put_autosuspend(tctx->dev->dev);
 }
 
 struct rk_crypto_tmp rk_ahash_sha1 = {
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index 0b1c90ababb7..59069457582b 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -17,11 +17,11 @@
 static int rk_cipher_need_fallback(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	unsigned int bs = crypto_skcipher_blocksize(tfm);
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	struct rk_crypto_tmp *algt = container_of(alg, struct rk_crypto_tmp, alg.skcipher);
 	struct scatterlist *sgs, *sgd;
 	unsigned int stodo, dtodo, len;
+	unsigned int bs = crypto_skcipher_blocksize(tfm);
 
 	if (!req->cryptlen)
 		return true;
@@ -84,15 +84,16 @@ static int rk_cipher_fallback(struct skcipher_request *areq)
 
 static int rk_cipher_handle_req(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct rk_cipher_ctx *tctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
-	struct rk_crypto_info *rkc = tctx->dev;
-	struct crypto_engine *engine = rkc->engine;
+	struct rk_crypto_info *rkc;
+	struct crypto_engine *engine;
 
 	if (rk_cipher_need_fallback(req))
 		return rk_cipher_fallback(req);
 
+	rkc = get_rk_crypto();
+
+	engine = rkc->engine;
 	rctx->dev = rkc;
 
 	return crypto_transfer_skcipher_request_to_engine(engine, req);
@@ -307,7 +308,12 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 	struct rk_crypto_tmp *algt = container_of(alg, struct rk_crypto_tmp, alg.skcipher);
 	struct rk_crypto_info *rkc = rctx->dev;
 
+	err = pm_runtime_resume_and_get(rkc->dev);
+	if (err)
+		return err;
+
 	algt->stat_req++;
+	rkc->nreq++;
 
 	ivsize = crypto_skcipher_ivsize(tfm);
 	if (areq->iv && crypto_skcipher_ivsize(tfm) > 0) {
@@ -401,6 +407,8 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 	}
 
 theend:
+	pm_runtime_put_autosuspend(rkc->dev);
+
 	local_bh_disable();
 	crypto_finalize_skcipher_request(engine, areq, err);
 	local_bh_enable();
@@ -420,18 +428,13 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 static int rk_cipher_tfm_init(struct crypto_skcipher *tfm)
 {
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	const char *name = crypto_tfm_alg_name(&tfm->base);
-	struct rk_crypto_tmp *algt;
-	int err;
-
-	algt = container_of(alg, struct rk_crypto_tmp, alg.skcipher);
-
-	ctx->dev = algt->dev;
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct rk_crypto_tmp *algt = container_of(alg, struct rk_crypto_tmp, alg.skcipher);
 
 	ctx->fallback_tfm = crypto_alloc_skcipher(name, 0, CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(ctx->fallback_tfm)) {
-		dev_err(ctx->dev->dev, "ERROR: Cannot allocate fallback for %s %ld\n",
+		dev_err(algt->dev->dev, "ERROR: Cannot allocate fallback for %s %ld\n",
 			name, PTR_ERR(ctx->fallback_tfm));
 		return PTR_ERR(ctx->fallback_tfm);
 	}
@@ -441,14 +444,7 @@ static int rk_cipher_tfm_init(struct crypto_skcipher *tfm)
 
 	ctx->enginectx.op.do_one_request = rk_cipher_run;
 
-	err = pm_runtime_resume_and_get(ctx->dev->dev);
-	if (err < 0)
-		goto error_pm;
-
 	return 0;
-error_pm:
-	crypto_free_skcipher(ctx->fallback_tfm);
-	return err;
 }
 
 static void rk_cipher_tfm_exit(struct crypto_skcipher *tfm)
@@ -457,7 +453,6 @@ static void rk_cipher_tfm_exit(struct crypto_skcipher *tfm)
 
 	memzero_explicit(ctx->key, ctx->keylen);
 	crypto_free_skcipher(ctx->fallback_tfm);
-	pm_runtime_put_autosuspend(ctx->dev->dev);
 }
 
 struct rk_crypto_tmp rk_ecb_aes_alg = {
-- 
2.35.1

