Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529016BAED2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjCOLJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjCOLJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:09:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C60C8A381;
        Wed, 15 Mar 2023 04:07:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h12so2555738pfh.5;
        Wed, 15 Mar 2023 04:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678878435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENZGfn0N5sbbl8jujN5yatFHQa0wMdAEr3milXh8ga4=;
        b=QwaQwQTpf1tFpCrehpL5Tyxx2PvivtwFRGQ+2g63q9DRPT0iJpuIEW8aL2Xm62Y9ys
         3mDgW4bOoMoydaV8ves1yBEXZQC9O6S3QxDvd472spfwRsW9Os65vbWnEAg3Y7lgiQC2
         Skzt974XUv96M8Mn6Uc3G//MVte5u7/u1yDzF3wQ/ezurk/HDxWNVT/VPozaUnnt5juC
         qcqBVsGjql+wlf4sMzKmllb4tRLVZg756g8e4fjG09jCCcp2/ql9FGJCAn1N4zO+7YgU
         eMDBagzau5d0kmX3wqUKf0HkrIebPdkowPFw1P+GvI/kl+DocrmqRrWb2Ba2aKEClyj3
         cNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENZGfn0N5sbbl8jujN5yatFHQa0wMdAEr3milXh8ga4=;
        b=w2jJk22c98MPjnGmytlYy2u+Q0fTjbP5DtmhCsaLcRSeDHAFnPc5U+G2rMdKHBQAxM
         0dd+gEV/x+ZHkvDqLJV1djeV/hKuLaZLXUd4PseRW+IGOu3sad19mB24PEm2I/crabaE
         k1gmDHz1ns2F2KOfggCFD7oGCPsh0Ytmx4A3MWWPQSZm+cuyoDavCv/P4IEruOSOKblJ
         o3E5eB+dapJA5lthUm61yFmH098cUyx4RX8ma2rt8JyAkzpzEhUu2aewA/vjlh/ghgRw
         fmqcDz5UOSAeKQ2At4fRgNg6yszk/Rgz/xWWrobalg1YciaC4cKYxaXFVETgIqMzgOxf
         KdFw==
X-Gm-Message-State: AO0yUKUnd+HNTxenVwAj1j1VoIjF/91FWzmDpMjvujHsMAcoGObSl1pb
        DJW0hwrDR1bpy2/t5+qdlzk/Lu0shji9Mg==
X-Google-Smtp-Source: AK7set+PWLrf/DlRfDSG5f4bqHukXK6xMHNFVopCKXQWA1Mp8+HPh7WAzOCp+nPmzafpDyFr8mv3gw==
X-Received: by 2002:a62:5285:0:b0:625:68f7:d552 with SMTP id g127-20020a625285000000b0062568f7d552mr4789285pfb.7.1678878434748;
        Wed, 15 Mar 2023 04:07:14 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78084000000b005892ea4f092sm3337489pff.95.2023.03.15.04.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:07:14 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v3 3/4] gpio: loongson1: Add DT support
Date:   Wed, 15 Mar 2023 19:06:49 +0800
Message-Id: <20230315110650.142577-4-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315110650.142577-1-keguang.zhang@gmail.com>
References: <20230315110650.142577-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT support for Loongson-1 GPIO driver.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V2 -> V3: None
V1 -> V2: Let gpiolib parse ngpios property
          Remove unnecessary alias id parsing
          Remove superfluous initialization done by bgpio_init()
          Add MODULE_DEVICE_TABLE()
          Other minor fixes
---
 drivers/gpio/gpio-loongson1.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index dddfc71f0e10..6ca3b969db4d 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -68,25 +68,38 @@ static int ls1x_gpio_probe(struct platform_device *pdev)
 	ls1x_gc->gc.owner = THIS_MODULE;
 	ls1x_gc->gc.request = ls1x_gpio_request;
 	ls1x_gc->gc.free = ls1x_gpio_free;
-	ls1x_gc->gc.base = pdev->id * 32;
+	/*
+	 * Clear ngpio to let gpiolib get the correct number
+	 * by reading ngpios property
+	 */
+	ls1x_gc->gc.ngpio = 0;
 
 	ret = devm_gpiochip_add_data(dev, &ls1x_gc->gc, ls1x_gc);
 	if (ret)
 		goto err;
 
 	platform_set_drvdata(pdev, ls1x_gc);
-	dev_info(dev, "Loongson1 GPIO driver registered\n");
+
+	dev_info(dev, "GPIO controller registered with %d pins\n",
+		 ls1x_gc->gc.ngpio);
 
 	return 0;
 err:
-	dev_err(dev, "failed to register GPIO device\n");
+	dev_err(dev, "failed to register GPIO controller\n");
 	return ret;
 }
 
+static const struct of_device_id ls1x_gpio_dt_ids[] = {
+	{ .compatible = "loongson,ls1x-gpio" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ls1x_gpio_dt_ids);
+
 static struct platform_driver ls1x_gpio_driver = {
 	.probe	= ls1x_gpio_probe,
 	.driver	= {
 		.name	= "ls1x-gpio",
+		.of_match_table = ls1x_gpio_dt_ids,
 	},
 };
 
-- 
2.34.1

