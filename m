Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D655FBDCE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJKWUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiJKWTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:19:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F53012A8A;
        Tue, 11 Oct 2022 15:19:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e129so13946061pgc.9;
        Tue, 11 Oct 2022 15:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sP4CVLuIUUqGyDN5WgNcl+HHfO20Zq1pEkrf2HVCvvk=;
        b=fcOv/f56EIKFARHyO8xbxa7fok8UbyeXvggYNyWObyTtGnqVjpIr5M/LlKIqa8Jo50
         KE3k/UahcKbfOjKREk6Len+MyCOJMsO7K3bVdedPZsFkz2NA060/Uwx7OFLtdEUEaZVX
         FcXuqxexqMz0VcSW6/3ykBqarEX78X9TwUfQDfvtQV/7ceIguG3H+Abj7D49IbV62M2X
         fD1JoEAHMl0T2cdqrGfl6Cc1v0WDP2gEWaLjR4fVDbMoOjB5qB0pccUHihLlcrZ/NBeC
         u2k+NbDk6RLeNyrEUPOzA7tGvQmLN2Gi/4+JiqMIs+e6D+F2ANtvV/S1lfQ8K4C6MJHP
         aRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP4CVLuIUUqGyDN5WgNcl+HHfO20Zq1pEkrf2HVCvvk=;
        b=Y8pvsZUDZVLlLg8dBB7Z0+N7ONOgt/j0WfTadSyM0IR4n6Hi3qhGWZCUzK+xq39Roj
         CQA1gkVw7bLwywTp/xc/1gH0CwkfCXMYKocVkafkblf+2Lny+Dd27AgyDGKeSkXIJBQV
         hP/1eW5a17x6XUfZ4j/zkNxgtS78weH5Zl6QfABXL3tQM4NYxtKVMyZfnXrDDihgCZaP
         DkEnOrPQPFAsOukj/co33NvVjmdR+GrtIZlEiBBDeZLGFDGbfzVF662z7GpReoc52SSA
         9av2gy8pbRxf0L1+V/y0Q6tlj0x51YnGCXXdVXav7qvyu/cL9bcJ4RQyUyLF8N27HPXQ
         VGYg==
X-Gm-Message-State: ACrzQf3Rr8BmfmTYdcmw/Dx3+bl8rh/GPLGb33KwBxO9+/kOLpHR/ghm
        fBW8jsZTb/IVvRu4x7Ip7XI=
X-Google-Smtp-Source: AMsMyM7JyTtqCtUz4oGyeYuC82Zq4iMUrxtYt5rjUJ/2CibmiDuwu5AZH0jMv5c0Qxd84MuJz5BDNg==
X-Received: by 2002:a63:106:0:b0:460:64ce:51c4 with SMTP id 6-20020a630106000000b0046064ce51c4mr15846958pgb.17.1665526786033;
        Tue, 11 Oct 2022 15:19:46 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:becc:db10:eb45:dc35])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090ab70600b0020d39ffe987sm60151pjr.50.2022.10.11.15.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:19:45 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH 4/7] gpiolib: of: add a quirk for reset line for Marvell NFC controller
Date:   Tue, 11 Oct 2022 15:19:32 -0700
Message-Id: <20221011-gpiolib-quirks-v1-4-e01d9d3e7b29@gmail.com>
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

The controller is using non-standard "reset-n-io" name for its reset
gpio property, whereas gpiod API expects "<name>-gpios". Add a quirk
so that gpiod API will still work on unmodified DTSes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 576f2f0c3432..7d4193fe36e5 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -383,6 +383,16 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 #if IS_ENABLED(CONFIG_MFD_ARIZONA)
 		{ "wlf,reset",	NULL,		NULL },
 #endif
+
+#if IS_ENABLED(CONFIG_NFC_MRVL_I2C)
+		{ "reset",	"reset-n-io",	"marvell,nfc-i2c" },
+#endif
+#if IS_ENABLED(CONFIG_NFC_MRVL_SPI)
+		{ "reset",	"reset-n-io",	"marvell,nfc-spi" },
+#endif
+#if IS_ENABLED(CONFIG_NFC_MRVL_UART)
+		{ "reset",	"reset-n-io",	"marvell,nfc-uart" },
+#endif
 #if !IS_ENABLED(CONFIG_PCI_LANTIQ)
 		/* MIPS Lantiq PCI */
 		{ "reset",	"gpios-reset",	"lantiq,pci-xway" },

-- 
b4 0.11.0-dev-5166b
