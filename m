Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A774C5EBC31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiI0H4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiI0Hz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:55:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB1BAB428
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:55:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ay36so6005124wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Lb5wXjXl71KLOn69lH3EgInZyalgQlnigOqDmtk2Tt0=;
        b=n7kRyUqNGoOgpPCI9RAaDptp44hDn8HLIUD/5MufJyUFwbUHFvsmN8TqneO3R4nDUI
         dgazNQY1irolv5+pnQeY+LJJjNg/69LsymFpZiPl/oT4vx8lNBoyj4HpflzUFkSBmnhy
         fBsUeoVzlq7+GME1AMbqMwbVJavpAJ70/894ANaAkc3+OKWumAK1+uskfJ3ox0N8muTg
         Y4IJ+W+VYAT/SvSywKLOlTu5niuz1IZrUkd5Cl/YNsKA+5yEiKuiZF1B6dH6CgQ3AU/f
         6wumlOfxXHzIHF24CqhYUvvvgHOhi4keYT+jmkvXE3YXcqnKERLrmXhV/il5V3WXIuYi
         cEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Lb5wXjXl71KLOn69lH3EgInZyalgQlnigOqDmtk2Tt0=;
        b=FyEAc1X264M5S7ALl+K8IP1m6K10JCldI/t9P+qPDK5MPbztkpMJv1M/58Dalhiau5
         yOrw3eyS7eoz0kxQFHs21W6cdZqqCg5sz12T0ixRTdQEvf+gJBr4uwBVoRW+tOtU11tJ
         FDT+u0yZi5y2MrgpnO+0Bk2QeBCtylm+PQkKFiIlJpBuKIs59IGIfJV19zU9gufFHnMg
         gLaGeZcuwC/UXjtFsG1jkBFQCj7E72Q6Eep0T9m97Xm1dpdQE4n16tdRdFPzo7lMxUL1
         xIA6uwK+oRin9c/X7y3uFWOddAHmCvTebV1aCaa19SPxBcxL/oM8UiEwXCxiX0iOegWq
         2CAA==
X-Gm-Message-State: ACrzQf0ag372joxwBMDQQBME3Emf8hr8KXcXXtq17y5Ljdo+rO0M6gco
        YoD5y+9+kGPLinRfO9r3G2WWHu7CePXnJA==
X-Google-Smtp-Source: AMsMyM5Ybn/y7bScy90bmV2wjgN7iG7dSSPxhXP+bQSRzfK8cYmmofblqtHnwg0Y25InbFDihy4MDQ==
X-Received: by 2002:a05:600c:4186:b0:3b4:a660:1d29 with SMTP id p6-20020a05600c418600b003b4a6601d29mr1615632wmh.120.1664265340931;
        Tue, 27 Sep 2022 00:55:40 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8-20020adfdcc8000000b0022afbd02c69sm1076654wrm.56.2022.09.27.00.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 00:55:40 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>,
        John Keeping <john@metanate.com>
Subject: [PATCH v10 07/33] crypto: rockchip: add fallback for ahash
Date:   Tue, 27 Sep 2022 07:54:45 +0000
Message-Id: <20220927075511.3147847-8-clabbe@baylibre.com>
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

Adds a fallback for all case hardware cannot handle.

Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
Reviewed-by: John Keeping <john@metanate.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 49017d1fb510..16009bb0bf16 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -16,6 +16,40 @@
  * so we put the fixed hash out when met zero message.
  */
 
+static bool rk_ahash_need_fallback(struct ahash_request *req)
+{
+	struct scatterlist *sg;
+
+	sg = req->src;
+	while (sg) {
+		if (!IS_ALIGNED(sg->offset, sizeof(u32))) {
+			return true;
+		}
+		if (sg->length % 4) {
+			return true;
+		}
+		sg = sg_next(sg);
+	}
+	return false;
+}
+
+static int rk_ahash_digest_fb(struct ahash_request *areq)
+{
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct rk_ahash_ctx *tfmctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, tfmctx->fallback_tfm);
+	rctx->fallback_req.base.flags = areq->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	rctx->fallback_req.nbytes = areq->nbytes;
+	rctx->fallback_req.src = areq->src;
+	rctx->fallback_req.result = areq->result;
+
+	return crypto_ahash_digest(&rctx->fallback_req);
+}
+
 static int zero_message_process(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
@@ -167,6 +201,9 @@ static int rk_ahash_digest(struct ahash_request *req)
 	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
 	struct rk_crypto_info *dev = tctx->dev;
 
+	if (rk_ahash_need_fallback(req))
+		return rk_ahash_digest_fb(req);
+
 	if (!req->nbytes)
 		return zero_message_process(req);
 	else
@@ -309,6 +346,7 @@ static void rk_cra_hash_exit(struct crypto_tfm *tfm)
 	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(tfm);
 
 	free_page((unsigned long)tctx->dev->addr_vir);
+	crypto_free_ahash(tctx->fallback_tfm);
 }
 
 struct rk_crypto_tmp rk_ahash_sha1 = {
-- 
2.35.1

