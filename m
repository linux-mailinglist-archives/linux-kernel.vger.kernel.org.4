Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCF55EB966
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 06:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiI0E7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 00:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiI0E7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 00:59:06 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6603109501;
        Mon, 26 Sep 2022 21:59:04 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v4so8382901pgi.10;
        Mon, 26 Sep 2022 21:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SAJkGU+79dW4f6vbvdxoH4HOSpZWnjzUc2txpj5o7k8=;
        b=i0JLo6YAgNP9aIA5APS8sn9FG+ZEaQMdYG4Cr9A3MxLan8b268kyX6Ie/pphVrJUFX
         0GPKzHhxOqaXA3zOFZpP1B6CZRdAkHk55RX3atYMYwOI1f+oOXXjnjpl1C+a0aXYUDUU
         t+37Meaqq5Uzy9T4ySMwxBhYqZSXSiya/qV7ltKNi+qJY1oH0Uw5awLORdVKq5cOFK9k
         H2/5XBstu0d54XJ8Z7r3hVzBv4wawLDCSwoZOn1PGovsnKVSR+ESJN+ISiQ1qitoGTXa
         IVIKucCS+bqns3qUX+O0umbK1IhRg0MuD088fxWMWEqMOM82NOqQrocZ3WW8MXesqtCU
         lJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SAJkGU+79dW4f6vbvdxoH4HOSpZWnjzUc2txpj5o7k8=;
        b=ZgUbvfaaNkV/YQbWAcwVwqAu7S9Xp8iatA128zxxyc51S7l7mhCuBFwKiEwaNf5ukb
         GfCGZWXczOgRk7DamLuxvPD2iWedHFcBx6AP5sOUyuN1JNlqCxjmGi0se/dWVeG02B1X
         kDrnkqjAmZvzEwGIgDpaK3gahcfVP+u39VVlGUo8zQH9S4NUoKbkFZdDRw6eFC6dvXLu
         8a4HwTuoKwdirALmyLTUjBDtCuZ5Qs5GFSO8iFLIL1qW4PPjP6gIawe4ctlNNPDuohgS
         KhqzqXc5ODl1scaM8pipkRtcXk6F6fWiM+VbhlSNUHzNaz4XQ7lS8czE8eaJ6D1OpNhq
         X9sg==
X-Gm-Message-State: ACrzQf2WLBLiadn60Y9o4yDfwMqCBdAmCvJSatbEmmazOwaBhLQOhdZy
        SIAOoy36xRyy0rPLwPPNMQsG8pf01hI=
X-Google-Smtp-Source: AMsMyM7JNRqUydIyZ2ktPnUYLLn1ZxKkSEd9FYS7ZVAy7YuI69bFCMaK0PbaXPBqPPu47RNNGpHmdQ==
X-Received: by 2002:a63:1a12:0:b0:43d:286e:35ad with SMTP id a18-20020a631a12000000b0043d286e35admr2005806pga.512.1664254743814;
        Mon, 26 Sep 2022 21:59:03 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id y129-20020a626487000000b0053640880313sm475867pfb.46.2022.09.26.21.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 21:59:03 -0700 (PDT)
Date:   Mon, 26 Sep 2022 21:59:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC/PATCH v2] MIPS: pci: lantiq: switch to using gpiod API
Message-ID: <YzKDFCq3M2gxlJ2e@google.com>
References: <YzE9E+Esv/rqO0MA@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzE9E+Esv/rqO0MA@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches the driver from legacy gpio API to the newer
gpiod API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
v2 - actually compiles.

 arch/mips/pci/pci-lantiq.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 1ca42f482130..377b4a2577e1 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -9,11 +9,11 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/clk.h>
 #include <linux/of_platform.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 
@@ -62,7 +62,7 @@
 __iomem void *ltq_pci_mapped_cfg;
 static __iomem void *ltq_pci_membase;
 
-static int reset_gpio;
+static gpio_desc *reset_gpio;
 static struct clk *clk_pci, *clk_external;
 static struct resource pci_io_resource;
 static struct resource pci_mem_resource;
@@ -123,17 +123,14 @@ static int ltq_pci_startup(struct platform_device *pdev)
 		clk_disable(clk_external);
 
 	/* setup reset gpio used by pci */
-	reset_gpio = of_get_named_gpio(node, "gpio-reset", 0);
-	if (gpio_is_valid(reset_gpio)) {
-		int ret = devm_gpio_request(&pdev->dev,
-						reset_gpio, "pci-reset");
-		if (ret) {
-			dev_err(&pdev->dev,
-				"failed to request gpio %d\n", reset_gpio);
-			return ret;
-		}
-		gpio_direction_output(reset_gpio, 1);
+	reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
+					     GPIOD_OUT_LOW);
+	ret = PTR_ERR_OR_ZERO(reset_gpio);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request gpio: %d\n", ret);
+		return ret;
 	}
+	gpiod_set_consumer_name(reset_gpio, "pci_reset");
 
 	/* enable auto-switching between PCI and EBU */
 	ltq_pci_w32(0xa, PCI_CR_CLK_CTRL);
@@ -195,11 +192,11 @@ static int ltq_pci_startup(struct platform_device *pdev)
 	ltq_ebu_w32(ltq_ebu_r32(LTQ_EBU_PCC_IEN) | 0x10, LTQ_EBU_PCC_IEN);
 
 	/* toggle reset pin */
-	if (gpio_is_valid(reset_gpio)) {
-		__gpio_set_value(reset_gpio, 0);
+	if (reset_gpio) {
+		gpiod_set_value_cansleep(reset_gpio, 1);
 		wmb();
 		mdelay(1);
-		__gpio_set_value(reset_gpio, 1);
+		gpiod_set_value_cansleep(reset_gpio, 0);
 	}
 	return 0;
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog

