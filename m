Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C005F0F60
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiI3P5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiI3P5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:57:23 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2F010EEC1;
        Fri, 30 Sep 2022 08:57:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i6so4629831pfb.2;
        Fri, 30 Sep 2022 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=ycp/RuYbPHRjJCSuHB1ORuBHZPMyJ8MIPoQsYWy5iF8=;
        b=aw8A0FyoPKiU9CKsHyTDEWMM9vKf0Dd1e7KxaYqWmoCo8h+yRMewCLQp1uKpigK5vw
         EUCm8f7bk/zpwh79z5KZaeiF0jIT4D1FrNCgoTVtEu7/NClvd0BSxvi8OxdTSemtoAmN
         8ejoLa1LY/t6UAlQCnfuMVzy4OdWFNqPKDOoXX2x0GsG1dSisgu8kiW5AP0izu3OK2i+
         cywPadLLNAghcFXSrwOZMx7nMrnsmTf97O8Tlld10jFaSdkbfrCs/Yf7eYC9T7zY6MQ/
         s/iMnaPGJMh6Pzex9jPTPooAhHZcbzjTjU6DuNC4IOgXC28bqYLlKfs3UJzaDj7A8k22
         DnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ycp/RuYbPHRjJCSuHB1ORuBHZPMyJ8MIPoQsYWy5iF8=;
        b=RYcYgN3TL46ZDHO+T4NA5/uqcB+Or97NpfxKsC2d4kqLETKcsE3qEeuAh6vK9haMr+
         JVIDQ4+0YnbxQIwVipkVVNJ9SXK1HmGSGeSstGke+q6sWCBIOXTZiYf/rE0MhTsIZ37J
         G7Vw3uRBMrZ9LseOhnUpZe4NLAQdKWLHR0f917UKzE4IaXMaP42lphfXUa1EwQO6Y9OY
         9aAlTm2Fce6WwVqAAi2pxzF/fUZ5E3ZaPLdoi5h0rA4HBmS2NO0OLHcaP9VUYqQCfRf/
         DAJru4kEjup3vpbH/GmJOfqOavZVr6eQ+S068MbO5SSSmO89nAjiTMzL5Cwy9rYXjEMf
         lxig==
X-Gm-Message-State: ACrzQf0djG9cm0o85VAoX2agLmruaQ4UEu0h5Wrxrado4P8kSSuJFT9d
        rmomKxRPBkxEGoA9qbce6iusuA9CVMA=
X-Google-Smtp-Source: AMsMyM5brp2GGPq2aEwHtmhN1LJbkVKGoWuYJxk+aMHWiCEZT2O729dk+EQfeRsRh5L7lffBGYvauQ==
X-Received: by 2002:a63:550d:0:b0:43c:1195:5c1d with SMTP id j13-20020a63550d000000b0043c11955c1dmr8123570pgb.84.1664553441741;
        Fri, 30 Sep 2022 08:57:21 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d016:f5be:4ff2:43f])
        by smtp.gmail.com with ESMTPSA id o3-20020a62cd03000000b0053e66f57334sm1967890pfg.112.2022.09.30.08.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:57:21 -0700 (PDT)
Date:   Fri, 30 Sep 2022 08:57:18 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] MIPS: pci: lantiq: switch to using gpiod API
Message-ID: <YzcR3l8/VgvGGYrs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

v3: fixed missing keyword struct, defined error temp variable
v2: actually compiles (proven to be a lie).

 arch/mips/pci/pci-lantiq.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 1ca42f482130..8d16cd021f60 100644
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
+static struct gpio_desc *reset_gpio;
 static struct clk *clk_pci, *clk_external;
 static struct resource pci_io_resource;
 static struct resource pci_mem_resource;
@@ -95,6 +95,7 @@ static int ltq_pci_startup(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	const __be32 *req_mask, *bus_clk;
 	u32 temp_buffer;
+	int error;
 
 	/* get our clocks */
 	clk_pci = clk_get(&pdev->dev, NULL);
@@ -123,17 +124,14 @@ static int ltq_pci_startup(struct platform_device *pdev)
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
+	error = PTR_ERR_OR_ZERO(reset_gpio);
+	if (error) {
+		dev_err(&pdev->dev, "failed to request gpio: %d\n", error);
+		return error;
 	}
+	gpiod_set_consumer_name(reset_gpio, "pci_reset");
 
 	/* enable auto-switching between PCI and EBU */
 	ltq_pci_w32(0xa, PCI_CR_CLK_CTRL);
@@ -195,11 +193,11 @@ static int ltq_pci_startup(struct platform_device *pdev)
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


-- 
Dmitry
