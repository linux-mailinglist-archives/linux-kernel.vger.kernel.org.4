Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627156B9A18
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCNPnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjCNPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:43:34 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DCA5F6D3;
        Tue, 14 Mar 2023 08:42:58 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id l9so5738013iln.1;
        Tue, 14 Mar 2023 08:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678808487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCAtIzojDKjXwvTZHur7bC8iD1yA0PDQlsydS6C7RKo=;
        b=sbQBRpctIILoHU8Py6U5QAzpb3Ef1d3zBmtwin1FIeWtko+oVH9bzgJSGyNyVaXuYr
         VvDkoaKCmSmItZgeh5gzgNGAXCJ2ZiGpkTZKldqA5wVmBr1Ja8ki/fOvnvczOIB6Be4t
         OUlbtNa/lbeCbpmW86tv+/dcJNZO4QBF/FY9CEJ78QsI5OcMmIfPdVynOo5E2Zf1Tuyz
         dS73bEBGcs3OrsZ1flBz0Ozyq5FEecPTH9utsC0JqhTJ49abJjoIwOa827aMEIx/zUp4
         xU0+lZdSvNIDP2XGqZuTAXA9zCiqWwy1W8E5N/bjrS2m4nB9Urw+M8IZ/S4wsqcB6j6A
         AzNg==
X-Gm-Message-State: AO0yUKWRdZIQnangdG33wElUSlvWltPkjwrky1V4xV+8bF2JwTT3poKL
        ySjkRv6poF69rq2Ewl5kbI0aZMRJxw==
X-Google-Smtp-Source: AK7set8y3epFKFBjfVmJ/SgGeZ54GIN9djSuAFcfwC4M7hpCzdzbY1nCfCI/qvUz7zHBYEhse+mFkA==
X-Received: by 2002:a05:6e02:1d0e:b0:323:1869:15a1 with SMTP id i14-20020a056e021d0e00b00323186915a1mr3811947ila.25.1678808486709;
        Tue, 14 Mar 2023 08:41:26 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id t12-20020a92dc0c000000b00314007fdbc2sm876071iln.62.2023.03.14.08.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:41:26 -0700 (PDT)
Received: (nullmailer pid 477337 invoked by uid 1000);
        Tue, 14 Mar 2023 15:41:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpio: Use of_property_read_bool() for boolean properties
Date:   Tue, 14 Mar 2023 10:41:17 -0500
Message-Id: <20230314154117.477138-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Actually use of_property_read_bool() as the commit msg says instead
   of of_property_present()
---
 drivers/gpio/gpio-stp-xway.c | 2 +-
 drivers/gpio/gpio-tb10x.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-stp-xway.c b/drivers/gpio/gpio-stp-xway.c
index 0ce1543426a4..4750ea34204c 100644
--- a/drivers/gpio/gpio-stp-xway.c
+++ b/drivers/gpio/gpio-stp-xway.c
@@ -292,7 +292,7 @@ static int xway_stp_probe(struct platform_device *pdev)
 	}
 
 	/* check which edge trigger we should use, default to a falling edge */
-	if (!of_find_property(pdev->dev.of_node, "lantiq,rising", NULL))
+	if (!of_property_read_bool(pdev->dev.of_node, "lantiq,rising"))
 		chip->edge = XWAY_STP_FALLING;
 
 	clk = devm_clk_get(&pdev->dev, NULL);
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index de6afa3f9716..78f8790168ae 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -167,7 +167,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tb10x_gpio);
 
-	if (of_find_property(np, "interrupt-controller", NULL)) {
+	if (of_property_read_bool(np, "interrupt-controller")) {
 		struct irq_chip_generic *gc;
 
 		ret = platform_get_irq(pdev, 0);
-- 
2.39.2

