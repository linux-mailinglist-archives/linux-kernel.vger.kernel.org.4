Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE65E98FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 07:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiIZFsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 01:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIZFsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 01:48:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA80B13E16;
        Sun, 25 Sep 2022 22:48:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so5735783pjl.0;
        Sun, 25 Sep 2022 22:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=C3HGDWzJDzD6dEB3cSzZ+VqFtIu5lbxh7fO+G9Hf+bs=;
        b=OyApyQhzgsufviIIYuCZXpMFePmWhETfJ9zBACj7N86nkFC+mB9W0JwrknWgCGD7rw
         Sb7GDzHnbAH8mZcpT+sVEFKE56uwLlA/0CjbVZ2ZSBn20CG8c6HWB6gBYLUUlPNs5cNV
         wTGBOuZRL3vcPJH/HfugiQG/K7hLVh8bu1sxF7Y30bD9QmAYF3FOc3EdU16h5RvwebAK
         luOX6FE+6SNu/LWYLX1by4H/AEwFcQOYK1ejhhtCjQ403noRIVyvic5wkEp2zMchZnRI
         2u/CD43Zpb/mtrX3rpSGf2ysXD9TQsnMN/wU5psLKdB3i0hGuAJIBX6hHN+/RQVUiavY
         y3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=C3HGDWzJDzD6dEB3cSzZ+VqFtIu5lbxh7fO+G9Hf+bs=;
        b=cpN2uywPSstULbJ7CBMytMwjKBk85Ldc1ofzO4shSataryHJ5mTmpBxsX/QWKoPVlx
         LyslVlcE5qk+C/fZZNtYeKpd9hhXvaF32mJ33KDUSMp//UIoGIHxRRF9SRXscIwH97jW
         wxTGRFrVmHYNkORrqERXG7LggAucJXKw05VpEwluTfXMC4InD2OdZZZ1qXDoZtKX4j68
         lKuIORPAE2Y/CrCd5NWbEAxOz5+v4FPQNwVqC5/J44qw/94GfoSS3vmAKVPnwPaNcuNT
         /CRwy0yfU6jWIUB0JqexIOCvcU1jDOa6jZiLKIhDXByWdvfv89rI5/6KnwolvyAWN28I
         eeSg==
X-Gm-Message-State: ACrzQf32vzw7AkQPJf6NUMvzE5szdOwBefwJUxb+GT5y7U7+aO6Oiaca
        gyarhVDOGUdmk0/SJ+1+aUE=
X-Google-Smtp-Source: AMsMyM7xAIXgQFJ3rdpBhnlpD5gSBj0nwJMuqQZetzLyfmYOAZwt3Ywvz/4AG8ke9Kp5/CvKdqSz/A==
X-Received: by 2002:a17:903:11cf:b0:178:a8f4:d511 with SMTP id q15-20020a17090311cf00b00178a8f4d511mr20299904plh.72.1664171286957;
        Sun, 25 Sep 2022 22:48:06 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:7e1b:858c:19dc:934])
        by smtp.gmail.com with ESMTPSA id w71-20020a62824a000000b0053b24b0fb88sm11075959pfd.65.2022.09.25.22.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 22:48:06 -0700 (PDT)
Date:   Sun, 25 Sep 2022 22:48:03 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] MIPS: pci: lantiq: switch to using gpiod API
Message-ID: <YzE9E+Esv/rqO0MA@google.com>
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

Note that the original version was using "gpio-reset" to look up gpio,
while this one will be using "reset-gpios" and "reset-gpio". However I
do not see any users of this driver in mainline kernel that are using
reset gpio functionality, so maybe it is OK?

If compatibility with existing DTSes is absolutely necessary I can make
a patch that will add needed quirk to drivers/gpio/gpiolib-of.c.

Please let me know.

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
2.37.3.998.g577e59143f-goog


-- 
Dmitry
