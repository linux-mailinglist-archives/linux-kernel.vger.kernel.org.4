Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7365A5ECFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 00:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiI0WFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 18:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiI0WFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:05:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056FEDCCF8;
        Tue, 27 Sep 2022 15:05:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b5so10590307pgb.6;
        Tue, 27 Sep 2022 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sSNiRI+ap5x7MQu5aicCdFhgVcBXQnxVbZJ3Z+sJpp8=;
        b=OOyC2BrocNE0X+rCeeu5h8pK/QD9DXH43+jMmNO5mvsOZ1mxwh/D5n0xieeWhMZMnJ
         s4nHeJeglfR0/5RU++bvcwYzn6G4IrgSYGOpSs/8vrzWLfC3QhiAjd8d5J0IHFGG72+b
         jh1EWUQL8qtdxipQcm7saWcg8ckvv4bqxrIgzZDkfiq8H4zxtRZrSJceGlfjpfmA45LF
         bphWnbtWxfEZXZTatXhOlRTEL4QYDsUTf8Gwpq1uwtwfnsxGgy5PoXKCGaHpmKQiWk6F
         nwcdWVgZ+JBOENToCG2htL6cs8qi4PaCHV83K/lr5Ni/I/jWFAjJyQKg/VYsy92EPMVP
         12DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sSNiRI+ap5x7MQu5aicCdFhgVcBXQnxVbZJ3Z+sJpp8=;
        b=z6vpU3MJXDmkqcXoMazgM0SNlJzrVz8bSRedtA+jmdCIc3VCXVqdFQ3uA55qnVFQrX
         quc7T+Xlz+364BbiBUaGjUQ3KEDoD/YzVeg4FSkxWfUwgsXI11RoVWFxxDqY13S05bMj
         PgOi5FJDmEZHaxGcUI2WduTOebexg4AzRdTX7rCbkHcSYtPEXnePhoxDCctd6R/t+luX
         d63MBA7b8A5eFYQsbGlZ0wxhRxX4KkYq3dni75VteFmNdnkvjO7+RzkqDyfE0jEKFicu
         JXO0F8CZYHb/L3WtwebILctHwRHi2RnnQqGuEeFBWSvG7skMokymccG2UTxJ8yUbrtW/
         1ylA==
X-Gm-Message-State: ACrzQf0yAlrpGIun9+0RSxiV4s//Xd0OT9gDq2LXHdqivh2QZZNDnHSl
        MH9Rmolarxhkl4S4OKK1IyE=
X-Google-Smtp-Source: AMsMyM7B+45kOzKa6I+J8lHdpYg6f15aeiEZITup3tLWRn8nUeSzydKNeCzYrlQc6OG9pm1jFIonVw==
X-Received: by 2002:a63:1521:0:b0:43c:9566:7a6a with SMTP id v33-20020a631521000000b0043c95667a6amr15583244pgl.339.1664316311492;
        Tue, 27 Sep 2022 15:05:11 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090301c900b001782398648dsm2051220plh.8.2022.09.27.15.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:05:10 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: host: ehci-exynos: switch to using gpiod API
Date:   Tue, 27 Sep 2022 15:05:04 -0700
Message-Id: <20220927220504.3744878-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220927220504.3744878-1-dmitry.torokhov@gmail.com>
References: <20220927220504.3744878-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches the driver from using legacy gpio API to the newer
gpiod API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/usb/host/ehci-exynos.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index c8e152c2e0ce..a333231616f4 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -13,7 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/usb.h>
@@ -131,20 +131,13 @@ static void exynos_ehci_phy_disable(struct device *dev)
 
 static void exynos_setup_vbus_gpio(struct device *dev)
 {
+	struct gpio_desc *gpio;
 	int err;
-	int gpio;
 
-	if (!dev->of_node)
-		return;
-
-	gpio = of_get_named_gpio(dev->of_node, "samsung,vbus-gpio", 0);
-	if (!gpio_is_valid(gpio))
-		return;
-
-	err = devm_gpio_request_one(dev, gpio, GPIOF_OUT_INIT_HIGH,
-				    "ehci_vbus_gpio");
+	gpio = devm_gpiod_get_optional(dev, "samsung,vbus", GPIOD_OUT_HIGH);
+	err = PTR_ERR_OR_ZERO(gpio);
 	if (err)
-		dev_err(dev, "can't request ehci vbus gpio %d", gpio);
+		dev_err(dev, "can't request ehci vbus gpio: %d\n", err);
 }
 
 static int exynos_ehci_probe(struct platform_device *pdev)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

