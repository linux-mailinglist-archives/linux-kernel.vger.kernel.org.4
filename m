Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EDB5EBC99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiI0IBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiI0IAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:00:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FF6B14F2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:56:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso8880697wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/HcULCDUWUOb7zL9pkaT5teTJK7hgsOh6ToY9+UZMac=;
        b=7lLd0LEwj1X7XZMWENgGR2iUtmd3mQmo2CkvfLT1Mil4cjHHSmbIOAFJ01jDjX5pC2
         80mHdhoD/49EcCspvFrffQgX7nO5s1eAmwz/zW1oF1+4qCyv+rqFmnXWNwY+BO387Gf4
         c5YqFAiAl06up8ol/ZCBtqk+LeuQ3I0nJhxgKA9WL53Bm9r0qMcc6CUHnK46ySVDGmh/
         WGD1wirGtNiXPQZH5euvBPGCiNBqOgq2uzwBFySI5vjSCVy1mLRT3xrOu/h1BiImqXTf
         YQluU1dzfcWu4077Henz279+fKNBb0/CL6eBoe/ZGy1dH9iJ722p5K8Gz95MwWulnpdv
         qydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/HcULCDUWUOb7zL9pkaT5teTJK7hgsOh6ToY9+UZMac=;
        b=R1tyzk7nqA7OXuXnEZwUdaAS+hGpLV1ZVObdhwX03B0oy/GcVvtDu98HREhBeBW4aM
         FERXyDkVB9IVes38aI6Xp2qQjDqFj08w21VKtKo0KYxnBQ+IFHuvlKhVovhBVWDQR8en
         BwskPbDXT49QMG/njdusNI2hPJzyZ1chjPQhROgYC4mOaOEqYJCrH8PQd5qolAvvnCIa
         oCYv4+rGBjKKNvl8kpm5o54CzHrFZ5+JYIcI0KxweNVfAY77oFPaa4ILQi1/jSEOTcPm
         fLdz+qHIVJMKlWoYGE3IVJ+jT8G3YLPMKhMCYTq3xchBZ6j21KXavOjJwQag7cn62H6Y
         b1zg==
X-Gm-Message-State: ACrzQf2tgQq0jaD3dBZiaTULRHFU7sTBaydgSNKzBw+VxqwiCK4ioOND
        n34Qd0P5XG1JLBaJOfNxu4E+5Q==
X-Google-Smtp-Source: AMsMyM4MKhcqcAW8tXr2t2zLzf0IU90hIT+K9JixREHhebzInhta7AbKkldKQKBi2KsiRvbjvtU36w==
X-Received: by 2002:a7b:c051:0:b0:3a6:36fc:8429 with SMTP id u17-20020a7bc051000000b003a636fc8429mr1572126wmc.78.1664265368752;
        Tue, 27 Sep 2022 00:56:08 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8-20020adfdcc8000000b0022afbd02c69sm1076654wrm.56.2022.09.27.00.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 00:56:08 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v10 31/33] crypto: rockchip: rk_ahash_reg_init use crypto_info from parameter
Date:   Tue, 27 Sep 2022 07:55:09 +0000
Message-Id: <20220927075511.3147847-32-clabbe@baylibre.com>
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

rk_ahash_reg_init() use crypto_info from TFM context, since we will
remove it, let's take if from parameters.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index d1bf68cb390d..30f78256c955 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -78,12 +78,10 @@ static int zero_message_process(struct ahash_request *req)
 	return 0;
 }
 
-static void rk_ahash_reg_init(struct ahash_request *req)
+static void rk_ahash_reg_init(struct ahash_request *req,
+			      struct rk_crypto_info *dev)
 {
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct rk_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
-	struct rk_crypto_info *dev = tctx->dev;
 	int reg_status;
 
 	reg_status = CRYPTO_READ(dev, RK_CRYPTO_CTRL) |
@@ -281,7 +279,7 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 		goto theend;
 	}
 
-	rk_ahash_reg_init(areq);
+	rk_ahash_reg_init(areq, rkc);
 
 	while (sg) {
 		reinit_completion(&rkc->complete);
-- 
2.35.1

