Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B82E5EBC49
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiI0H5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiI0H4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:56:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BFBAC26D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:55:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so6341696wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cJE9JrNh4HvbwKuPRZxdjE4sOr8yHsnud2KqNuPrCRY=;
        b=20kzfWx9aFDUAIT6CRNbmts2xKF41R3yIU2wQhMgemqKUKm9PfGdpdzuA3A7EFeJ6H
         Iok7JfIJA8T6hUZ+qSRMg914u+8yUXo2KS4PCKgbA1w3KeOklMBs1KPtN9soEnGDIz9U
         bYJ774WZT/cLBQ/uNvbZkJz6DCK6FT3peZunOxgHG9OMq+51o2soutWOn79dSpqZjqpf
         Mc4ASvDawv4rRHqam72yB4bJCJGoiLljB6VjuRs2y42cj0oUPUnkC/Dev9InlFQGKCt8
         EcuQxhssHuLmWz0fusJlKiCjh/0z9LR6cY1XMUiD/SfNH33cgAQRdiWUa4665WIAyM4r
         jj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cJE9JrNh4HvbwKuPRZxdjE4sOr8yHsnud2KqNuPrCRY=;
        b=TnokVprvntlW35OuPh6a/cTQTN0ePzZ7BEECOFd7G30fCPHBnXuWeUTqqkBErszpSd
         9+VRYI8AYlEPKaImaMDKYYMBEJSljdL12yr+843wYHVQ5MN3l6sZ1rjagQzoKT7wgG4L
         mq/SldAFmnWrGUNSTZCnn24Lq+24BtIDF5kXFDPLEOglxtq5Perh/naRxaPOP84L/JoL
         /XzxD4yqf9q9PsePmGQVCdrrET6bxVwKlIR0rqMX/AQ3MkRHKXhkzFxBXVInEH2psJLm
         M+tk991k5xZqlMiowCfXCcGLr0LQXEHaIvvP2DG4LqozYHnUU2gMpiijaEy5rminI/cs
         Tazg==
X-Gm-Message-State: ACrzQf1c7ptglsI790qhPmGs9kF/a1h+gqkHpvlEMKl9x6kg3b5bkI6i
        C0Y5FxI0IOrBhB7A+wz14gmg/w==
X-Google-Smtp-Source: AMsMyM5Hup35F8JL91OS8GUnQcPPFYhGSM2YCoZNnF0Xb08xMtOKnNvRAzZkn4zQ06arBDX8UGaGGA==
X-Received: by 2002:a7b:ce99:0:b0:3b4:9031:fc02 with SMTP id q25-20020a7bce99000000b003b49031fc02mr1635504wmj.154.1664265352028;
        Tue, 27 Sep 2022 00:55:52 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8-20020adfdcc8000000b0022afbd02c69sm1076654wrm.56.2022.09.27.00.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 00:55:51 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>,
        John Keeping <john@metanate.com>
Subject: [PATCH v10 17/33] crypto: rockchip: use read_poll_timeout
Date:   Tue, 27 Sep 2022 07:54:55 +0000
Message-Id: <20220927075511.3147847-18-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927075511.3147847-1-clabbe@baylibre.com>
References: <20220927075511.3147847-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use read_poll_timeout instead of open coding it.
In the same time, fix indentation of related comment.

Reviewed-by: John Keeping <john@metanate.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 137013bd4410..1fbab86c9238 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -10,6 +10,7 @@
  */
 #include <linux/device.h>
 #include <asm/unaligned.h>
+#include <linux/iopoll.h>
 #include "rk3288_crypto.h"
 
 /*
@@ -295,18 +296,17 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 		sg = sg_next(sg);
 	}
 
-		/*
-		 * it will take some time to process date after last dma
-		 * transmission.
-		 *
-		 * waiting time is relative with the last date len,
-		 * so cannot set a fixed time here.
-		 * 10us makes system not call here frequently wasting
-		 * efficiency, and make it response quickly when dma
-		 * complete.
-		 */
-	while (!CRYPTO_READ(tctx->dev, RK_CRYPTO_HASH_STS))
-		udelay(10);
+	/*
+	 * it will take some time to process date after last dma
+	 * transmission.
+	 *
+	 * waiting time is relative with the last date len,
+	 * so cannot set a fixed time here.
+	 * 10us makes system not call here frequently wasting
+	 * efficiency, and make it response quickly when dma
+	 * complete.
+	 */
+	readl_poll_timeout(tctx->dev->reg + RK_CRYPTO_HASH_STS, v, v == 0, 10, 1000);
 
 	for (i = 0; i < crypto_ahash_digestsize(tfm) / 4; i++) {
 		v = readl(tctx->dev->reg + RK_CRYPTO_HASH_DOUT_0 + i * 4);
-- 
2.35.1

