Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5D5FBDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJKWUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJKWTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:19:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9957614D0D;
        Tue, 11 Oct 2022 15:19:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso290970pjk.1;
        Tue, 11 Oct 2022 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gDfnfolyPIiLoZMfrzrbPqoZrA52wx7/qfIWAlJm1I=;
        b=IwSJt27h8PVkrQYaH8qScEO9APBnjLfs46Cz1k15mBQMKZ7yOOzw0B8AA7LGRkpHKR
         LONSMzjFDbYkfvh8t6F1XJyZDo0UkJZYG1kYGMKNC76J7Ol2BwcOxjo1JNChA9KJwymy
         GVbCcD4HGQcEX/V9InKcFZOso7iCfLJUNYY7Cvt2mbClIqVvbp+BMC6ewUqjCRmGLMCi
         SKb4hXI/DuMbjB9SgIhMbEI9KfOKyBKJYBqBlxSESjDMTFooIQHm2Wt88DewR619vwgI
         ar8Aw7Qeme/yhGs5UWzeQL5SGD8xyNuOi/rgit/xD16Zslz2Y2FqnFxdZPXByX5vpixF
         v04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gDfnfolyPIiLoZMfrzrbPqoZrA52wx7/qfIWAlJm1I=;
        b=NWvVEoV7PUlAbXafTX6AX1VzxiFf99ejFCj1dYVYd5DDr35+Y9eqqn3eT5B4/mmueC
         IU61HgYNAJPrr9+vu3jNeQ3/Nr4Exl7mPOllnGUqX4+PJ1vuJrIX/ZK7vGZ+DKXfm4DR
         lk8Mh9vrpAUQXSZAXwlQpWlxDYZE5h0IKvPgLYiQVWIeeiwWeTPctJ68U/a3pSXk6yKa
         V6xBv7YIvr4wyLdwU4VOyP9uGTaDVAl3koVOuO/AJ5moSx2KRy/S/60DgmKt/uXGDxpi
         i4aEdUtxo++UY7yyxZ5THfGbdveq2hZVAbO/zOY/FqlvkP9pGRjeNUUl0kZhJdjeKH26
         segw==
X-Gm-Message-State: ACrzQf2UwrFE5pqnNzYBj15NSs6Akff83pFjrj/H6GgDcEKE2l9LGarm
        WMSXAbg6UdxvFIWXqAJnJsE=
X-Google-Smtp-Source: AMsMyM43bMnQePWNIYfL+kjn2ma7R4LVxExmEkZSq5CfjI94HAHswoD0kp04cKyT4G6RRD3P1ITxNA==
X-Received: by 2002:a17:90b:3ec6:b0:20a:eb6b:c832 with SMTP id rm6-20020a17090b3ec600b0020aeb6bc832mr1526920pjb.22.1665526787668;
        Tue, 11 Oct 2022 15:19:47 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:becc:db10:eb45:dc35])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090ab70600b0020d39ffe987sm60151pjr.50.2022.10.11.15.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:19:47 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH 5/7] gpiolib: of: add a quirk for reset line for Cirrus CS42L56 codec
Date:   Tue, 11 Oct 2022 15:19:33 -0700
Message-Id: <20221011-gpiolib-quirks-v1-5-e01d9d3e7b29@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-5166b
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

The controller is using non-standard "cirrus,gpio-nreset" name for its
reset gpio property, whereas gpiod API expects "<name>-gpios".
Add a quirk so that gpiod API will still work on unmodified DTSes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 7d4193fe36e5..953d1c23950a 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -407,6 +407,9 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		{ "wlf,ldo1ena", NULL,		NULL }, /* WM8994 */
 		{ "wlf,ldo2ena", NULL,		NULL }, /* WM8994 */
 #endif
+#if IS_ENABLED(CONFIG_SND_SOC_CS42L56)
+		{ "reset",	"cirrus,gpio-nreset",	"cirrus,cs42l56" },
+#endif
 #if IS_ENABLED(CONFIG_SND_SOC_TLV320AIC3X)
 		{ "reset",	"gpio-reset",	"ti,tlv320aic3x" },
 		{ "reset",	"gpio-reset",	"ti,tlv320aic33" },

-- 
b4 0.11.0-dev-5166b
