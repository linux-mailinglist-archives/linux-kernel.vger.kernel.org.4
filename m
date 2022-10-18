Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935A86023E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiJRFlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiJRFle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:41:34 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90949E2EB;
        Mon, 17 Oct 2022 22:41:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b2so12825237plc.7;
        Mon, 17 Oct 2022 22:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DMgKUA1ndW99FtkgK7fFtqDLzR447NcQVyF5tYxkvo=;
        b=Mlfgrqkvj70vbejMKTCGMp9GJ3gaaUYU2AlqRY+VhyqGg6D1JLN0HUd/z3p1RhbjYA
         qKTm6/8A7q0//QibXBHZ/htlvYzCq4TaldEc4XHw7CViZCvb8xbfGIIkQTFt648ancWP
         ApQ5j5FmpBzZ/HcXdZigRmLted9Ydib9kYLTdgTYfiaHLXEGhlUpp0Zvfhj85HfaSJii
         GRlbrM+XZHKiQUgHKBrwMovQuWt7uncd3+kDmAn6fJgoyUD/k6I/GLLP8z6YuKkj13zS
         LNrkr2xF/J1ZwPe06l0GZlJGBysiHgLQvDhLFXZ3o1wUoFXpaYhGJaV2wykb62sZnjyv
         4+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DMgKUA1ndW99FtkgK7fFtqDLzR447NcQVyF5tYxkvo=;
        b=tqUjlPSnOY8kgbUr14lFA5TF3au7RX4NYtqSYVMOcA9lqD9reMehk8ZVbR97HCRTYh
         VrsGAGWh2U2Y64DlT0jkwj47A7+H9vvYH7WmEOLbuQW/YcShcN/DIuV+0nSxA98edT7T
         95wPr6r1Mq8aLR5GQtaefoKbC3AmnddNgNgIgHWLh0rOFd8Cc64GysweNaF5CvitLLue
         h9zzZi+8MMwNGj5comaPg13f1ZFLLQkUo6NLPnVZK0f0iMcfyhJl+tHYuwbGhaMAhqtx
         DdQR1TCBqobF0Td9mQkKLt7oAHQcCGzQQM4TqHozQBAPuVkOaHJdZkx0PRuLwVVuJ4tI
         3B9Q==
X-Gm-Message-State: ACrzQf0LC8K7gIkxS/aCLWv7DTuiPxm2txgQbIq03zDUSOvDWjIeJMAF
        821EE0F8cm9NCSzih6d+KnM=
X-Google-Smtp-Source: AMsMyM4APqjmpfE8dbaBzrp0RzRGgW+hybGoL45HKLrtC/NaYxPDQ1SgvY67ey1Va7pYiWzVz1nvvg==
X-Received: by 2002:a17:90b:4c04:b0:20d:4ef6:aacc with SMTP id na4-20020a17090b4c0400b0020d4ef6aaccmr37879621pjb.199.1666071685218;
        Mon, 17 Oct 2022 22:41:25 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:f7bc:1bb5:e0b1:92cb])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709027e8700b00172f4835f53sm7597435pla.192.2022.10.17.22.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 22:41:24 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 05/10] gpiolib: of: add a quirk for reset line for Marvell NFC controller
Date:   Mon, 17 Oct 2022 22:41:06 -0700
Message-Id: <20221011-gpiolib-quirks-v3-5-eae9cc2ed0a1@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
References: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
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
index 2b5d1b3095c7..a9cedc39a245 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -390,6 +390,16 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 #if IS_ENABLED(CONFIG_MFD_ARIZONA)
 		{ "wlf,reset",	NULL,		NULL },
 #endif
+#if IS_ENABLED(CONFIG_NFC_MRVL_I2C)
+		{ "reset",	"reset-n-io",	"marvell,nfc-i2c" },
+#endif
+#if IS_ENABLED(CONFIG_NFC_MRVL_SPI)
+		{ "reset",	"reset-n-io",	"marvell,nfc-spi" },
+#endif
+#if IS_ENABLED(CONFIG_NFC_MRVL_UART)
+		{ "reset",	"reset-n-io",	"marvell,nfc-uart" },
+		{ "reset",	"reset-n-io",	"mrvl,nfc-uart" },
+#endif
 #if !IS_ENABLED(CONFIG_PCI_LANTIQ)
 		/* MIPS Lantiq PCI */
 		{ "reset",	"gpios-reset",	"lantiq,pci-xway" },

-- 
b4 0.11.0-dev-5166b
