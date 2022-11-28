Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86D263A68B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiK1LAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiK1LAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:00:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8581B795
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:00:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id b2so8481023eja.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/FObQx7gNNEzu7Fz/r+02A9P2+kih+CkY8d1AEZ/l8=;
        b=h5o9ZaEMnmeJX3u40x3jnQaj68fWIfoDhpsEQ+uOJwWZ26WPgcBwccF8lp6Py+GV1y
         EaWDSfD1LmPrSaszCw2l58dT9n2shvErQOB1QYrBOtp20rTPAzaGGutEvhKFo8zaDjvV
         1b3L8pQY4TzcHVDoUv9BmoLbS7difwkG2VgbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/FObQx7gNNEzu7Fz/r+02A9P2+kih+CkY8d1AEZ/l8=;
        b=XMaAs5BP1ob71GuaLgq5BrUNMUPMBGEcTezxNTHIaSaO5hhD+lWoOjem9y3zSXnrUS
         DMdfWTJYd4jaJWIsCTeAVM99qQyRlEgBdFjpRapNfynxWnAs9kGscruPOP45JlEbe6Tu
         1B2tCsmTtiDKPtAcwR4OmywO3tNtF1yTHVsTSFI3o2l83HKV3r5R4LuDEC03T67/g/nR
         h+qBRL/24ozR2h9pTSsx8LYyfzPbUe9mNpSD8uBGpBSgxQsfwB01UEPr1BR20LI57+NH
         kYvWLGDwRpGbrNCCn65HlziLPpx5xzuKSnv/JJTUi5PH5IAHv0+rzb5h7USbIfzvXsbq
         5p1A==
X-Gm-Message-State: ANoB5pn5rrAac/0px59Mh5d7tuRMj9wfTuivgux19eGaVT9CnS+AYpcH
        spA4SCR0cU/GaD2U9R/CS0P5tg==
X-Google-Smtp-Source: AA0mqf4LpBI8mH+rTkJern/KmNlS838lVLrfISixZ5MmZ7sHkwspV51Z2RZT6R3QzAH/MKuIJ0nhHQ==
X-Received: by 2002:a17:906:a983:b0:7b8:31b1:b23f with SMTP id jr3-20020a170906a98300b007b831b1b23fmr26249228ejb.591.1669633206252;
        Mon, 28 Nov 2022 03:00:06 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ku3-20020a170907788300b0078c213ad441sm4812218ejc.101.2022.11.28.03.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:00:05 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 28 Nov 2022 12:00:01 +0100
Subject: [PATCH] spi: mediatek: Enable irq when pdata is ready
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221128-spi-mt65xx-v1-0-509266830665@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ZM8EpoUpJvky3qvHPm0h+aUGkH0jg+w0Hxbl4l42SQ0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjhJSy24ik16jMlF5x2yBj1XDSVYbw1Ttx2xgaYpdg
 PRJjjOqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4SUsgAKCRDRN9E+zzrEiEgYEA
 CGG7z/n18b8jhUn+olLZ/7A7n4m4s1/aTx0bJ8nwXO5rPTAuq6kV6cpMiiYj1duMK6N+1MLRuVHHPg
 c7i1Hj32bRjRv+XNNGsd3r5Yty83sMQDkva9tsj2IJ3+hNn0scOHih16CacBebGdLfaiU0sgBKwM28
 uiqcCwcTh1gtxaGJx3EeK56m1E4PJc8EzuhqM5Blzj1PdoJyChKtkiZY8eXrlifGem0LoqUzHgXyHs
 XBR2JYEIfUNDGOhKbScPHgYNWdMwWpOFBtybfouI1oTnEk0soJtOaS7FxfnP9bctHouLnakmVkcwEz
 YJqq14kU5nT/XZBw5CLgowtPaVoLFCQ2x2SiZ8JKBGUDwspHJfvHwqTdghuRCcZpA5ZCz/WzGv2xg+
 ODGEjhNYOi0s09zBYEOnJh6TAVKkTKjqIVsX7WsN/g8yWSbkblCqXnv/k7ewoyXVSw2JzuE5IhGEkN
 HtOcAQla8GLdwknrrJghh/kSo8cF0KtcK7+YOMAzfU8dptYovwUp0oaYZnrOFn4Z3WUVKBXyE5m5iu
 8S65QPBq4cf8i/mKPM/UZSmH5p9OUwVTQz3I7LrrNq0oViGapj3+J8HOPHX9kOjkWO3y093TU4uXww
 3Sb/4IHqTcla56jtdqq6CCIZQFwik8/pTr8pgA9mRkBBXrr6pgvTT1qES6pg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device does not come straight from reset, we might receive an IRQ
before we are ready to handle it.

Fixes:

[    0.832328] Unable to handle kernel read from unreadable memory at virtual address 0000000000000010
[    1.040343] Call trace:
[    1.040347]  mtk_spi_can_dma+0xc/0x40
...
[    1.262265]  start_kernel+0x338/0x42c

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-mt65xx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index d6aff909fc36..6de8360e5c2a 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1192,11 +1192,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	else
 		dma_set_max_seg_size(dev, SZ_256K);
 
-	ret = devm_request_irq(dev, irq, mtk_spi_interrupt,
-			       IRQF_TRIGGER_NONE, dev_name(dev), master);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to register irq\n");
-
 	mdata->parent_clk = devm_clk_get(dev, "parent-clk");
 	if (IS_ERR(mdata->parent_clk))
 		return dev_err_probe(dev, PTR_ERR(mdata->parent_clk),
@@ -1266,6 +1261,13 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "failed to register master\n");
 	}
 
+	ret = devm_request_irq(dev, irq, mtk_spi_interrupt,
+			       IRQF_TRIGGER_NONE, dev_name(dev), master);
+	if (ret) {
+		pm_runtime_disable(dev);
+		return dev_err_probe(dev, ret, "failed to register irq\n");
+	}
+
 	return 0;
 }
 

---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221128-spi-mt65xx-b92c9ca96ffa

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
