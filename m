Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A387F65CA60
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbjACXfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbjACXf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:35:29 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4952F165AA
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 15:35:27 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bq39so40175699lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 15:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rq0s4onjSRUwhmApDnZ8KEVauR86LqfQw7i8WlycEFs=;
        b=rJvaZkk57ZeoGjLTVPf6NQmvZfWeEFVlPJbGJ3wvMJ63Av0UjO5SAxDlXQPXVJjXHQ
         m3PBikfjuV6CMWTaalBoqNhftpinKPz/nk7SexZAYeM09eTnxslPgQ1eiAOwVNJ/cicV
         0fHLNOZyGxMGZu2z5HgpmKd8dqztH7gH0rO3zgZqD6MwhMmr4unT8nCedyeeOytgFzzU
         Z1JKdzEqA3FL+H6BRqlwdth52gWQjWTAlM4Z46ZhAM20OuRzliT+0mlc0Yf39FlWvkVE
         ZA9sLIbS6DjEZy0Lu42PSiILujdPeA8wx6/h/RgYfB877zh5jTCrT2YgSUzF4EnWUsGJ
         xWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rq0s4onjSRUwhmApDnZ8KEVauR86LqfQw7i8WlycEFs=;
        b=0T4C1Wf8BvyDgw0eCn17B65SPAtVH06K9xOGmU3wOxZtM91ELDbF63RgAmwNA83OFk
         eQExRgtdux/SFOpmw4pDcb8tWcAEsGIw00naL2mglk1YwHp6qCYoXC8ORd3hc86ECpdE
         uW8mswxC9LAfgMNv7mBsozmOdulqCcG2N63hMcI6Lz12VFFMklnTKuL/mgh0j/LSK8zq
         q6NK3XNLSYmMzSlxnY3kQxcfcjrE/tMFKfYRATjiQoi9pKL+O8kN0T/CV6NP025iz378
         OfIySxPrQ9K4EeUynJoX92s6Q2xRAJDJP+mJX2/7N/QGfK/Z/Gdd4jQV9OrcleoO2FdX
         L+1Q==
X-Gm-Message-State: AFqh2kr9j5NZ+WuvUwbDZVZL2shVDDfJ2mIS+7VPDWk7ElOZxDJKh7Nk
        m30thP+n+gi+qlCltlaOi+DImj+CAMLd/tgv
X-Google-Smtp-Source: AMrXdXutAAOkOUBIuK6T1E9JkbuwrOliPzDnYqRmT25gu1gXcfAdrJsGfjDYEORwXECwxCTU2UBEJw==
X-Received: by 2002:a05:6512:3b22:b0:4a4:68b9:19e1 with SMTP id f34-20020a0565123b2200b004a468b919e1mr14446708lfv.9.1672788925655;
        Tue, 03 Jan 2023 15:35:25 -0800 (PST)
Received: from Fecusia.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512070b00b004a45edc1de2sm4939801lfs.239.2023.01.03.15.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:35:25 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 04 Jan 2023 00:35:19 +0100
Subject: [PATCH 3/7] usb: fotg210: Acquire memory resource in core
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-gemini-fotg210-usb-v1-3-f2670cb4a492@linaro.org>
References: <20230103-gemini-fotg210-usb-v1-0-f2670cb4a492@linaro.org>
In-Reply-To: <20230103-gemini-fotg210-usb-v1-0-f2670cb4a492@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabian Vogt <fabian@ritter-vogt.de>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subdrivers are obtaining and mapping the memory resource
separately. Create a common state container for the shared
resources and start populating this by acquiring the IO
memory resource and remap it and pass this to the subdrivers
for host and peripheral.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/usb/fotg210/fotg210-core.c | 29 ++++++++++++++++++++++-------
 drivers/usb/fotg210/fotg210-hcd.c  | 15 +++++----------
 drivers/usb/fotg210/fotg210-hcd.h  |  1 +
 drivers/usb/fotg210/fotg210-udc.c  | 16 +++-------------
 drivers/usb/fotg210/fotg210-udc.h  |  1 +
 drivers/usb/fotg210/fotg210.h      | 24 ++++++++++++++++++++----
 6 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-core.c b/drivers/usb/fotg210/fotg210-core.c
index cef12827e797..4593120c02de 100644
--- a/drivers/usb/fotg210/fotg210-core.c
+++ b/drivers/usb/fotg210/fotg210-core.c
@@ -33,9 +33,10 @@
 #define GEMINI_MISC_USB0_MINI_B		BIT(29)
 #define GEMINI_MISC_USB1_MINI_B		BIT(30)
 
-static int fotg210_gemini_init(struct device *dev, struct resource *res,
+static int fotg210_gemini_init(struct fotg210 *fotg, struct resource *res,
 			       enum usb_dr_mode mode)
 {
+	struct device *dev = fotg->dev;
 	struct device_node *np = dev->of_node;
 	struct regmap *map;
 	bool wakeup;
@@ -47,6 +48,7 @@ static int fotg210_gemini_init(struct device *dev, struct resource *res,
 		dev_err(dev, "no syscon\n");
 		return PTR_ERR(map);
 	}
+	fotg->map = map;
 	wakeup = of_property_read_bool(np, "wakeup-source");
 
 	/*
@@ -55,6 +57,7 @@ static int fotg210_gemini_init(struct device *dev, struct resource *res,
 	 */
 	mask = 0;
 	if (res->start == 0x69000000) {
+		fotg->port = GEMINI_PORT_1;
 		mask = GEMINI_MISC_USB1_VBUS_ON | GEMINI_MISC_USB1_MINI_B |
 			GEMINI_MISC_USB1_WAKEUP;
 		if (mode == USB_DR_MODE_HOST)
@@ -64,6 +67,7 @@ static int fotg210_gemini_init(struct device *dev, struct resource *res,
 		if (wakeup)
 			val |= GEMINI_MISC_USB1_WAKEUP;
 	} else {
+		fotg->port = GEMINI_PORT_0;
 		mask = GEMINI_MISC_USB0_VBUS_ON | GEMINI_MISC_USB0_MINI_B |
 			GEMINI_MISC_USB0_WAKEUP;
 		if (mode == USB_DR_MODE_HOST)
@@ -89,23 +93,34 @@ static int fotg210_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	enum usb_dr_mode mode;
+	struct fotg210 *fotg;
 	int ret;
 
+	fotg = devm_kzalloc(dev, sizeof(*fotg), GFP_KERNEL);
+	if (!fotg)
+		return -ENOMEM;
+	fotg->dev = dev;
+
+	fotg->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!fotg->res)
+		return -ENODEV;
+
+	fotg->base = devm_ioremap_resource(dev, fotg->res);
+	if (!fotg->base)
+		return -ENOMEM;
+
 	mode = usb_get_dr_mode(dev);
 
 	if (of_device_is_compatible(dev->of_node, "cortina,gemini-usb")) {
-		struct resource *res;
-
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		ret = fotg210_gemini_init(dev, res, mode);
+		ret = fotg210_gemini_init(fotg, fotg->res, mode);
 		if (ret)
 			return ret;
 	}
 
 	if (mode == USB_DR_MODE_PERIPHERAL)
-		ret = fotg210_udc_probe(pdev);
+		ret = fotg210_udc_probe(pdev, fotg);
 	else
-		ret = fotg210_hcd_probe(pdev);
+		ret = fotg210_hcd_probe(pdev, fotg);
 
 	return ret;
 }
diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 51ac93a2eb98..15ba5b1618e1 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -5557,11 +5557,10 @@ static void fotg210_init(struct fotg210_hcd *fotg210)
  * then invokes the start() method for the HCD associated with it
  * through the hotplug entry's driver_data.
  */
-int fotg210_hcd_probe(struct platform_device *pdev)
+int fotg210_hcd_probe(struct platform_device *pdev, struct fotg210 *fotg)
 {
 	struct device *dev = &pdev->dev;
 	struct usb_hcd *hcd;
-	struct resource *res;
 	int irq;
 	int retval;
 	struct fotg210_hcd *fotg210;
@@ -5585,18 +5584,14 @@ int fotg210_hcd_probe(struct platform_device *pdev)
 
 	hcd->has_tt = 1;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(hcd->regs)) {
-		retval = PTR_ERR(hcd->regs);
-		goto failed_put_hcd;
-	}
+	hcd->regs = fotg->base;
 
-	hcd->rsrc_start = res->start;
-	hcd->rsrc_len = resource_size(res);
+	hcd->rsrc_start = fotg->res->start;
+	hcd->rsrc_len = resource_size(fotg->res);
 
 	fotg210 = hcd_to_fotg210(hcd);
 
+	fotg210->fotg = fotg;
 	fotg210->caps = hcd->regs;
 
 	/* It's OK not to supply this clock */
diff --git a/drivers/usb/fotg210/fotg210-hcd.h b/drivers/usb/fotg210/fotg210-hcd.h
index 0781442b7a24..13c9342982ee 100644
--- a/drivers/usb/fotg210/fotg210-hcd.h
+++ b/drivers/usb/fotg210/fotg210-hcd.h
@@ -182,6 +182,7 @@ struct fotg210_hcd {			/* one per controller */
 #	define INCR(x) do {} while (0)
 #endif
 
+	struct fotg210		*fotg;		/* Overarching FOTG210 device */
 	/* silicon clock */
 	struct clk		*pclk;
 };
diff --git a/drivers/usb/fotg210/fotg210-udc.c b/drivers/usb/fotg210/fotg210-udc.c
index 66e1b7ee3346..034193592a36 100644
--- a/drivers/usb/fotg210/fotg210-udc.c
+++ b/drivers/usb/fotg210/fotg210-udc.c
@@ -1142,21 +1142,14 @@ int fotg210_udc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-int fotg210_udc_probe(struct platform_device *pdev)
+int fotg210_udc_probe(struct platform_device *pdev, struct fotg210 *fotg)
 {
-	struct resource *res;
 	struct fotg210_udc *fotg210 = NULL;
 	struct device *dev = &pdev->dev;
 	int irq;
 	int ret = 0;
 	int i;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		pr_err("platform_get_resource error.\n");
-		return -ENODEV;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		pr_err("could not get irq\n");
@@ -1169,6 +1162,7 @@ int fotg210_udc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	fotg210->dev = dev;
+	fotg210->fotg = fotg;
 
 	/* It's OK not to supply this clock */
 	fotg210->pclk = devm_clk_get(dev, "PCLK");
@@ -1207,11 +1201,7 @@ int fotg210_udc_probe(struct platform_device *pdev)
 			goto err_alloc;
 	}
 
-	fotg210->reg = ioremap(res->start, resource_size(res));
-	if (fotg210->reg == NULL) {
-		dev_err(dev, "ioremap error\n");
-		goto err_alloc;
-	}
+	fotg210->reg = fotg->base;
 
 	spin_lock_init(&fotg210->lock);
 
diff --git a/drivers/usb/fotg210/fotg210-udc.h b/drivers/usb/fotg210/fotg210-udc.h
index fadb57ca8d78..20335a38a410 100644
--- a/drivers/usb/fotg210/fotg210-udc.h
+++ b/drivers/usb/fotg210/fotg210-udc.h
@@ -236,6 +236,7 @@ struct fotg210_udc {
 	unsigned long		irq_trigger;
 
 	struct device			*dev;
+	struct fotg210			*fotg;
 	struct usb_phy			*phy;
 	struct usb_gadget		gadget;
 	struct usb_gadget_driver	*driver;
diff --git a/drivers/usb/fotg210/fotg210.h b/drivers/usb/fotg210/fotg210.h
index ef79d8323d89..50436cc16538 100644
--- a/drivers/usb/fotg210/fotg210.h
+++ b/drivers/usb/fotg210/fotg210.h
@@ -2,13 +2,28 @@
 #ifndef __FOTG210_H
 #define __FOTG210_H
 
+enum gemini_port {
+	GEMINI_PORT_NONE = 0,
+	GEMINI_PORT_0,
+	GEMINI_PORT_1,
+};
+
+struct fotg210 {
+	struct device *dev;
+	struct resource *res;
+	void __iomem *base;
+	struct regmap *map;
+	enum gemini_port port;
+};
+
 #ifdef CONFIG_USB_FOTG210_HCD
-int fotg210_hcd_probe(struct platform_device *pdev);
+int fotg210_hcd_probe(struct platform_device *pdev, struct fotg210 *fotg);
 int fotg210_hcd_remove(struct platform_device *pdev);
 int fotg210_hcd_init(void);
 void fotg210_hcd_cleanup(void);
 #else
-static inline int fotg210_hcd_probe(struct platform_device *pdev)
+static inline int fotg210_hcd_probe(struct platform_device *pdev,
+				    struct fotg210 *fotg)
 {
 	return 0;
 }
@@ -26,10 +41,11 @@ static inline void fotg210_hcd_cleanup(void)
 #endif
 
 #ifdef CONFIG_USB_FOTG210_UDC
-int fotg210_udc_probe(struct platform_device *pdev);
+int fotg210_udc_probe(struct platform_device *pdev, struct fotg210 *fotg);
 int fotg210_udc_remove(struct platform_device *pdev);
 #else
-static inline int fotg210_udc_probe(struct platform_device *pdev)
+static inline int fotg210_udc_probe(struct platform_device *pdev,
+				    struct fotg210 *fotg)
 {
 	return 0;
 }

-- 
2.38.1
