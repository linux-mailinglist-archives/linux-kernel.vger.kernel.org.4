Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E6F5EBC19
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiI0Hzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiI0Hzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:55:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCCE73918
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:55:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l8so5987462wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2nwWkT4441Zvq5igIAOKA8C0HAjPPXDmTRADPlAyhok=;
        b=FhCg6N8IdLUqYun9zFfNxEKEFxD/HuGTkniM7ShtX24traaLVPnNCQf6esKBn0W/kg
         3yjeiHkQXXz4+27KjUI70493oisSzR9M+ECcruAfQ7DAoW3K2SxW0OPUFapVTtqi9hR5
         DEjiIryUck3YbGPpR/3H1zoaJlaK8HOPpPjJz3u1MSKuAUg07OS5wukM9QalNg/F6WQ4
         qdi5dxstPbe57InTXy89Cw1DxqZFA+D7aWz4xTTnXeUZFjvQ86dPVGGZ5n+KlcS8iQD4
         zk1b82sC3K3UwhhbL3n/c+tgU+UlqcbVBkgl9oi4xF/S1hwsKSLiTcDZ9suJmNp+ZnUi
         bUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2nwWkT4441Zvq5igIAOKA8C0HAjPPXDmTRADPlAyhok=;
        b=yhyAAywQte03crbeWksW2/qpvpV8RCfmyaCiQor+SDZYg51dGbvClWc/7eoEkwcI/d
         0N+4iLb7083zmlrlMjF+GFvPP23zXmPBLmEu6Li3oRGkxdz8RSOo8hqUYn6aZYTak+94
         IqvtNdgDplIkEkJcqOju8sxZgTZaAFlrSuTc2yk1GEpj57p+yQzx1sp21IGiY4KWr79t
         g1+8Q9lkTfEh/nmH46l3Mu5yoGIFHIQBn/G+PcC9P1RngcCX+3xVE4xpzSKEtjQ89/Bo
         0tC4yawE+bmGMjN+zqG05X8eKX96vhzEl06p57bVnbli0+6lZOf/I6QfLcoy7SxFEpK2
         /YUA==
X-Gm-Message-State: ACrzQf3pu8xDwPrsvyZ4tT5UBQ+5PNoayZbR2B7dCkp3D3wH08ajMrom
        2bv7GljGQv2BATcORuf1qQV4Ww==
X-Google-Smtp-Source: AMsMyM6h87WBvVreQkid4R2UnKxsEZtgzHIzUDroAKPttULMr+SwoIKne5+cNdtK+OWCySafkeOQVg==
X-Received: by 2002:a05:600c:4f89:b0:3b4:a6fc:89e5 with SMTP id n9-20020a05600c4f8900b003b4a6fc89e5mr1531348wmq.149.1664265334129;
        Tue, 27 Sep 2022 00:55:34 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8-20020adfdcc8000000b0022afbd02c69sm1076654wrm.56.2022.09.27.00.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 00:55:33 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>,
        John Keeping <john@metanate.com>
Subject: [PATCH v10 01/33] crypto: rockchip: use dev_err for error message about interrupt
Date:   Tue, 27 Sep 2022 07:54:39 +0000
Message-Id: <20220927075511.3147847-2-clabbe@baylibre.com>
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

Interrupt is mandatory so the message should be printed as error.

Reviewed-by: John Keeping <john@metanate.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 35d73061d156..45cc5f766788 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -371,8 +371,7 @@ static int rk_crypto_probe(struct platform_device *pdev)
 
 	crypto_info->irq = platform_get_irq(pdev, 0);
 	if (crypto_info->irq < 0) {
-		dev_warn(crypto_info->dev,
-			 "control Interrupt is not available.\n");
+		dev_err(&pdev->dev, "control Interrupt is not available.\n");
 		err = crypto_info->irq;
 		goto err_crypto;
 	}
-- 
2.35.1

