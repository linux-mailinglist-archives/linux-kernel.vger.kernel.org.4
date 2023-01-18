Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BFB671556
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjARHqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjARHoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:44:55 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF3861D6B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:09:36 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x36so13684182ede.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPfoISQ8yjAy6Kx331RQfusK05V745Ciii+y5Z5oDqY=;
        b=wmBctA3n37PE/Qp9VALE9hvyzokhZGhVlRNSBMG/pR54HplM0ADaFZtoQFMksmipEH
         BEjNgVhJHaYD3m+ygGntHKc58L/3ykSpeavTFyxZz5O1leoe+/DM+ePod4CBmWLxwAgV
         IK/YQT7ilfTtVzQixBiKdyVxImzjpGhkmtXPc8yb+SBpOGtbx7SbrcKelgEtejFs0fiI
         S/fiNx6xMaezZ+IZRpe437F8EYrB3ovmHkKIaLrs4eqHLEAx1jJYPMU3xHWsNd8VWcDH
         Xk0mrBequEd/CuuXL/cIoB//DRWRvUA84Emwn1so7JKoE+EEmgr784BZHZp4+5zaHZa5
         nJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPfoISQ8yjAy6Kx331RQfusK05V745Ciii+y5Z5oDqY=;
        b=uxBzAGYEzlNOm130ttoBdTWRJwWx6J6OBY1pJvQriJ9ovmJBU2oXsRwQL/MjoG8fDW
         9Xft4hC581W8gavTyFti7rZc/ONCJ3ATYSTon3TAJ6tt/cTIiAfBBTam/zB/6LvhL7OC
         61Onex72ha0xoxrA7Y0Q4vevjIPa52j366Uu/ITaje+AXFzyCcN/XqvwKcqT7pieNlRf
         SYC+T+kig8QQDFMJ6CMGhvVwWfBxxH1w16y6B+97fY5eY4IjoD6O2RsckK3cRD3icEor
         +j+l0AtzTIvZK/bTd8kP34gKAwF0/VHTWNi/1/wJZodqRdjMfWnBfPQcOuHVGxLJrtTa
         m2ZA==
X-Gm-Message-State: AFqh2kqDdfLtpm3LaFhokIyf2KjBODa7s5mBcQJssecIlaxxi9X+slx/
        iiZmTyuD1GbJv9O7sDW2LyGffT7Dy5GNS7T6
X-Google-Smtp-Source: AMrXdXu4OC2mKZpsbLSD/HcB5wYa2/7FLc96flTP6G7qjawHln77BreuslsRpeko5dWsoYGR520/6A==
X-Received: by 2002:a05:6402:14d0:b0:498:1995:ac54 with SMTP id f16-20020a05640214d000b004981995ac54mr5288614edx.40.1674025775533;
        Tue, 17 Jan 2023 23:09:35 -0800 (PST)
Received: from fedora.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id bt16-20020a0564020a5000b00482e0c55e2bsm13596984edb.93.2023.01.17.23.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 23:09:35 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Jan 2023 08:09:18 +0100
Subject: [PATCH v2 4/7] usb: fotg210: Move clock handling to core
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-gemini-fotg210-usb-v2-4-100388af9810@linaro.org>
References: <20230103-gemini-fotg210-usb-v2-0-100388af9810@linaro.org>
In-Reply-To: <20230103-gemini-fotg210-usb-v2-0-100388af9810@linaro.org>
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

Grab the optional silicon block clock, prepare and enable it in
the core before proceeding to prepare the host or peripheral
driver. This saves duplicate code and also uses the simple
devm_clk_get_optional_enabled() to do everything we really
want to do.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/usb/fotg210/fotg210-core.c |  5 +++++
 drivers/usb/fotg210/fotg210-hcd.c  | 33 ++-------------------------------
 drivers/usb/fotg210/fotg210-udc.c  | 30 +++---------------------------
 drivers/usb/fotg210/fotg210-udc.h  |  1 -
 drivers/usb/fotg210/fotg210.h      |  1 +
 5 files changed, 11 insertions(+), 59 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-core.c b/drivers/usb/fotg210/fotg210-core.c
index 4593120c02de..58d84747fb30 100644
--- a/drivers/usb/fotg210/fotg210-core.c
+++ b/drivers/usb/fotg210/fotg210-core.c
@@ -6,6 +6,7 @@
  * driver.
  */
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -109,6 +110,10 @@ static int fotg210_probe(struct platform_device *pdev)
 	if (!fotg->base)
 		return -ENOMEM;
 
+	fotg->pclk = devm_clk_get_optional_enabled(dev, "PCLK");
+	if (IS_ERR(fotg->pclk))
+		return PTR_ERR(fotg->pclk);
+
 	mode = usb_get_dr_mode(dev);
 
 	if (of_device_is_compatible(dev->of_node, "cortina,gemini-usb")) {
diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 15ba5b1618e1..7bd1e8f3080d 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -33,7 +33,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/clk.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -5594,44 +5593,22 @@ int fotg210_hcd_probe(struct platform_device *pdev, struct fotg210 *fotg)
 	fotg210->fotg = fotg;
 	fotg210->caps = hcd->regs;
 
-	/* It's OK not to supply this clock */
-	fotg210->pclk = clk_get(dev, "PCLK");
-	if (!IS_ERR(fotg210->pclk)) {
-		retval = clk_prepare_enable(fotg210->pclk);
-		if (retval) {
-			dev_err(dev, "failed to enable PCLK\n");
-			goto failed_put_hcd;
-		}
-	} else if (PTR_ERR(fotg210->pclk) == -EPROBE_DEFER) {
-		/*
-		 * Percolate deferrals, for anything else,
-		 * just live without the clocking.
-		 */
-		retval = PTR_ERR(fotg210->pclk);
-		goto failed_dis_clk;
-	}
-
 	retval = fotg210_setup(hcd);
 	if (retval)
-		goto failed_dis_clk;
+		goto failed_put_hcd;
 
 	fotg210_init(fotg210);
 
 	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (retval) {
 		dev_err(dev, "failed to add hcd with err %d\n", retval);
-		goto failed_dis_clk;
+		goto failed_put_hcd;
 	}
 	device_wakeup_enable(hcd->self.controller);
 	platform_set_drvdata(pdev, hcd);
 
 	return retval;
 
-failed_dis_clk:
-	if (!IS_ERR(fotg210->pclk)) {
-		clk_disable_unprepare(fotg210->pclk);
-		clk_put(fotg210->pclk);
-	}
 failed_put_hcd:
 	usb_put_hcd(hcd);
 fail_create_hcd:
@@ -5647,12 +5624,6 @@ int fotg210_hcd_probe(struct platform_device *pdev, struct fotg210 *fotg)
 int fotg210_hcd_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-	struct fotg210_hcd *fotg210 = hcd_to_fotg210(hcd);
-
-	if (!IS_ERR(fotg210->pclk)) {
-		clk_disable_unprepare(fotg210->pclk);
-		clk_put(fotg210->pclk);
-	}
 
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
diff --git a/drivers/usb/fotg210/fotg210-udc.c b/drivers/usb/fotg210/fotg210-udc.c
index 034193592a36..6a4b94d26951 100644
--- a/drivers/usb/fotg210/fotg210-udc.c
+++ b/drivers/usb/fotg210/fotg210-udc.c
@@ -15,7 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/clk.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/phy.h>
 
@@ -1134,9 +1133,6 @@ int fotg210_udc_remove(struct platform_device *pdev)
 	for (i = 0; i < FOTG210_MAX_NUM_EP; i++)
 		kfree(fotg210->ep[i]);
 
-	if (!IS_ERR(fotg210->pclk))
-		clk_disable_unprepare(fotg210->pclk);
-
 	kfree(fotg210);
 
 	return 0;
@@ -1164,34 +1160,17 @@ int fotg210_udc_probe(struct platform_device *pdev, struct fotg210 *fotg)
 	fotg210->dev = dev;
 	fotg210->fotg = fotg;
 
-	/* It's OK not to supply this clock */
-	fotg210->pclk = devm_clk_get(dev, "PCLK");
-	if (!IS_ERR(fotg210->pclk)) {
-		ret = clk_prepare_enable(fotg210->pclk);
-		if (ret) {
-			dev_err(dev, "failed to enable PCLK\n");
-			goto err;
-		}
-	} else if (PTR_ERR(fotg210->pclk) == -EPROBE_DEFER) {
-		/*
-		 * Percolate deferrals, for anything else,
-		 * just live without the clocking.
-		 */
-		ret = -EPROBE_DEFER;
-		goto err;
-	}
-
 	fotg210->phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
 	if (IS_ERR(fotg210->phy)) {
 		ret = PTR_ERR(fotg210->phy);
 		if (ret == -EPROBE_DEFER)
-			goto err_pclk;
+			goto err_free;
 		dev_info(dev, "no PHY found\n");
 		fotg210->phy = NULL;
 	} else {
 		ret = usb_phy_init(fotg210->phy);
 		if (ret)
-			goto err_pclk;
+			goto err_free;
 		dev_info(dev, "found and initialized PHY\n");
 	}
 
@@ -1286,11 +1265,8 @@ int fotg210_udc_probe(struct platform_device *pdev, struct fotg210 *fotg)
 err_alloc:
 	for (i = 0; i < FOTG210_MAX_NUM_EP; i++)
 		kfree(fotg210->ep[i]);
-err_pclk:
-	if (!IS_ERR(fotg210->pclk))
-		clk_disable_unprepare(fotg210->pclk);
 
-err:
+err_free:
 	kfree(fotg210);
 	return ret;
 }
diff --git a/drivers/usb/fotg210/fotg210-udc.h b/drivers/usb/fotg210/fotg210-udc.h
index 20335a38a410..22b72caf498c 100644
--- a/drivers/usb/fotg210/fotg210-udc.h
+++ b/drivers/usb/fotg210/fotg210-udc.h
@@ -231,7 +231,6 @@ struct fotg210_ep {
 struct fotg210_udc {
 	spinlock_t		lock; /* protect the struct */
 	void __iomem		*reg;
-	struct clk		*pclk;
 
 	unsigned long		irq_trigger;
 
diff --git a/drivers/usb/fotg210/fotg210.h b/drivers/usb/fotg210/fotg210.h
index 50436cc16538..4d0d4ae1a957 100644
--- a/drivers/usb/fotg210/fotg210.h
+++ b/drivers/usb/fotg210/fotg210.h
@@ -12,6 +12,7 @@ struct fotg210 {
 	struct device *dev;
 	struct resource *res;
 	void __iomem *base;
+	struct clk *pclk;
 	struct regmap *map;
 	enum gemini_port port;
 };

-- 
2.39.0
