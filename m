Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2995FF33A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiJNRzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiJNRy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:54:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8052B258;
        Fri, 14 Oct 2022 10:54:47 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so8566142pjq.3;
        Fri, 14 Oct 2022 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX6I3wxmmC2re4tlQ7azHaY51bTZUH4nJgPdj4ITZq8=;
        b=cyugA0yHJUN3qAYBEX22+gvLsKzT0Qskj8CNA+ZBQPAmGtgf7tK+Sy7JA8OTpXVWB9
         YXCtr/IhxkTKGg6wXcjDhbXvGxTbLTOZI43n2iC2HOissspE74cppc0sruSR9JwaR+Vz
         Eoc1W/ULVDcc5A7omUhw68ovv7kBCrPWVoPjH4eiFFybdVWKDgTTp/IqST7suQo+y58g
         MeR1NqyDiYNodnBCHIGpogo+vlERi25f/glW2sbIkJC+RsL+O6Dc0JqqixOttVYHuVzn
         hPVgOV7m0N/1sNNDaKuOtKopFleKiT9qgs1E45fHsq6jbfTzWqe69zPvrCMo/fl4TqzN
         DbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX6I3wxmmC2re4tlQ7azHaY51bTZUH4nJgPdj4ITZq8=;
        b=hpPvEJFE6iuPNawyPCrOdSljGQm5fG8QsYr9yftisReSyODKH/Fy7vr4OUHeX/1CJB
         WgQdemtKAaPcuS/JxiJwMgmSDnO5JW5PmsVkbWwOYEeLTprMY2q8k2gNqcKEMErSTxDU
         44meYj/F/lxzitwPfQxGyf75uTCHzjc+k+N5fVLtPQeqnRxk0acdVhvlLh05qsV9K2WX
         9/B00mqckzX92Whny+bnbxG/nSz4VezIGdlLermWdodzu7ExgipDWCq8aKM7l8Qk6qRW
         WjKUGAxJnlh4w7ipxhMTedTMq+j2OEqNvy6uqXwnj292YRoH4HTRMVkZ3LxVQN8fUsQs
         QorQ==
X-Gm-Message-State: ACrzQf0gbSYfrZIEbHM99E8WNuaJsqtnCz/IPcrPxF/PdOJf16p07Z+D
        vM3EEZ8XKMBh0f/nWTrqsfE=
X-Google-Smtp-Source: AMsMyM6HJMSW8eaOV/L8mdLS4/siuzIHXjCFIiLCzS5TaBfYxq818U8i5HSUDm/flCBDm5MDoy8urA==
X-Received: by 2002:a17:90a:4311:b0:20b:e232:5920 with SMTP id q17-20020a17090a431100b0020be2325920mr7199880pjg.190.1665770086268;
        Fri, 14 Oct 2022 10:54:46 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:da06:5604:594f:f6af])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b0017f7819732dsm2011780plb.77.2022.10.14.10.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:54:45 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2 5/9] gpiolib: of: add a quirk for reset line for Marvell NFC controller
Date:   Fri, 14 Oct 2022 10:54:29 -0700
Message-Id: <20221011-gpiolib-quirks-v2-5-73cb7176fd94@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221011-gpiolib-quirks-v2-0-73cb7176fd94@gmail.com>
References: <20221011-gpiolib-quirks-v2-0-73cb7176fd94@gmail.com>
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

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 2b5d1b3095c7..5c11ee7638d1 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -390,6 +390,16 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
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
