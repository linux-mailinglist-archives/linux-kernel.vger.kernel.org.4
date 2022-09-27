Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1635EBC7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiI0H74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiI0H6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:58:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875CDB029A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:56:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t14so13666309wrx.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0KerGvUzdejWLAwshDyy9ppWCWrJnFuYbHleK5z5lUU=;
        b=tFZZkGLF12zpJ31kndQX4/eM+ARGjrnucK7XCQ8xEzjNs8rXqJXlW9DOiPgvta1cA0
         Yy9+5gkNcMt20ahW61SdWn0goPxqolClL5ZlG+JTNs278lWWZq453BNrLGlUX/q/Z8mx
         1LYi9+zNPagPwC71r/b8mMLvjoKFrQcG99vO5jCh+QgbOBn9ntWmGCYNEjZDvVCZmyj2
         l4QUUuEbbcrs4NIHGKG9IwB9S9/nUTSwAzTFoPQYAZMneUoXm8ypujPZAKTJ7amhwD0e
         P5wdhOt3nio9X2nmDhWLztkpWl5ax1AXyki3jhpErcshNVxIZXh2JEDgx4/mwoVzU/Ti
         hBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0KerGvUzdejWLAwshDyy9ppWCWrJnFuYbHleK5z5lUU=;
        b=T2JHOOlx20weCJnZXZvs9aRYZYIQRz92AU0q2JsxumemrsirLeQ9E5Xe3R8jQucSDY
         KDpxowLRvEkFfcyyiseM2qGFuTA369ZEBAndObmm52x5kc+g7FX8Z0hFZAcv++B5UaMh
         dV0jxALLjoYJKpEATYFYvP1dHgFFAti30biGKCndkNrtGXok0Le76+ZUb4LGcLSonh1z
         aQFxVJxn/lTTuYRlKJDSDcRLvoTzF09KSUXxlsGoMfzzVZL+eC0nu2bMQRENff2AMGL0
         5reIb7cptr6gO6MF3/bq8mDDDH1+CJaBxNgxodFPJuVj/57PJ28sYUqa7vJKRbwQfkIO
         WttQ==
X-Gm-Message-State: ACrzQf2F1I20w6E2oV6a2iSigkLudv8Ph6joM7E/BIISzm81pmXhUaf7
        McSyd79N7v9QVr96NjlU4rUn/A==
X-Google-Smtp-Source: AMsMyM7cTV+QeJCXQ/wabYGrCDeuge3SgCP1vYJoewZaxtGyOUU+Nm9KENJZ/QjBK8MeyIn1pqZGSQ==
X-Received: by 2002:adf:9cd0:0:b0:22a:7cea:d3c3 with SMTP id h16-20020adf9cd0000000b0022a7cead3c3mr16728656wre.196.1664265359229;
        Tue, 27 Sep 2022 00:55:59 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8-20020adfdcc8000000b0022afbd02c69sm1076654wrm.56.2022.09.27.00.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 00:55:58 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>,
        John Keeping <john@metanate.com>
Subject: [PATCH v10 23/33] crypto: rockchip: use the rk_crypto_info given as parameter
Date:   Tue, 27 Sep 2022 07:55:01 +0000
Message-Id: <20220927075511.3147847-24-clabbe@baylibre.com>
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

Instead of using the crypto_info from TFM ctx, use the one given as parameter.

Reviewed-by: John Keeping <john@metanate.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto_skcipher.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index 6a1bea98fded..cf0dfb6029d8 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -254,7 +254,7 @@ static void rk_cipher_hw_init(struct rk_crypto_info *dev, struct skcipher_reques
 			     RK_CRYPTO_TDES_BYTESWAP_KEY |
 			     RK_CRYPTO_TDES_BYTESWAP_IV;
 		CRYPTO_WRITE(dev, RK_CRYPTO_TDES_CTRL, rctx->mode);
-		memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, ctx->key, ctx->keylen);
+		memcpy_toio(dev->reg + RK_CRYPTO_TDES_KEY1_0, ctx->key, ctx->keylen);
 		conf_reg = RK_CRYPTO_DESSEL;
 	} else {
 		rctx->mode |= RK_CRYPTO_AES_FIFO_MODE |
@@ -266,7 +266,7 @@ static void rk_cipher_hw_init(struct rk_crypto_info *dev, struct skcipher_reques
 		else if (ctx->keylen == AES_KEYSIZE_256)
 			rctx->mode |= RK_CRYPTO_AES_256BIT_key;
 		CRYPTO_WRITE(dev, RK_CRYPTO_AES_CTRL, rctx->mode);
-		memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_KEY_0, ctx->key, ctx->keylen);
+		memcpy_toio(dev->reg + RK_CRYPTO_AES_KEY_0, ctx->key, ctx->keylen);
 	}
 	conf_reg |= RK_CRYPTO_BYTESWAP_BTFIFO |
 		    RK_CRYPTO_BYTESWAP_BRFIFO;
-- 
2.35.1

